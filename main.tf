/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  local_ceph_metadata = {
//    startup-script = data.template_file.init_es.rendered
//
//    es_config = data.template_file.es_config.rendered
//    es_jvm_options = data.template_file.jvm_options.rendered
   sshKeys = "integer:${file("~/.ssh/id_rsa.pub")}"

  }
  local_es_tags     = ["elastic-external"]

}

data "google_compute_network" "data_network" {
  project = var.project_id
  name    = var.gcp_network
}

data "google_compute_subnetwork" "data_subnetwork" {
  project = var.project_id
  name    = var.gcp_subnet_name
  region  = var.gcp_instance_region
}

### ceph osd
resource "google_compute_instance" "ceph_osd" {
  project      = var.project_id
  name         = "${var.ceph_osd_instance_name}${count.index}"
  count        = var.ceph_osd_vm_count
  machine_type = var.ceph_osd_instance_machine_type
  zone         = var.gcp_instance_zone
//  tags = concat(
//  local.local_es_tags,
//  var.es_tags
//  )

  allow_stopping_for_update = "false"

  boot_disk {
    source = google_compute_disk.ceph_osd_vm_disk[count.index].name
  }

  metadata = merge(
  local.local_ceph_metadata,
//  var.ceph_instance_metadata
  )

  network_interface {
    subnetwork = data.google_compute_subnetwork.data_subnetwork.self_link
    network_ip = google_compute_address.ceph_osd_vm_internal_address[count.index].address

    access_config {

    }
  }

}

resource "google_compute_disk" "ceph_osd_vm_disk" {
  project = var.project_id
  name    = "${var.ceph_osd_instance_name}${count.index}-disk"
  count   = var.ceph_osd_vm_count
  type    = var.ceph_osd_disk_type
  size    = var.ceph_osd_disk_size
  image   = var.ceph_osd_instance_image
  zone    = var.gcp_instance_zone

  physical_block_size_bytes = 4096
}

resource "google_compute_address" "ceph_osd_vm_internal_address" {
  project    = var.project_id
  count      = var.ceph_osd_vm_count
  name       = "${var.ceph_osd_instance_name}${count.index}-internal-address"
  region     = var.gcp_instance_region
  subnetwork = data.google_compute_subnetwork.data_subnetwork.name

  address_type = "INTERNAL"
}

### cephadmin

resource "google_compute_instance" "ceph_adm" {
  project      = var.project_id
  name         = "${var.ceph_adm_instance_name}${count.index}"
  count        = var.ceph_adm_vm_count
  machine_type = var.ceph_adm_instance_machine_type
  zone         = var.gcp_instance_zone
  //  tags = concat(
  //  local.local_es_tags,
  //  var.es_tags
  //  )

  allow_stopping_for_update = "false"

  boot_disk {
    source = google_compute_disk.ceph_adm_vm_disk[count.index].name
  }

  metadata = merge(
  local.local_ceph_metadata,
//  var.ceph_instance_metadata
  )

  network_interface {
    subnetwork = data.google_compute_subnetwork.data_subnetwork.self_link
    network_ip = google_compute_address.ceph_adm_vm_internal_address[count.index].address

    access_config {

    }
  }

}


resource "google_compute_disk" "ceph_adm_vm_disk" {
  project = var.project_id
  name    = "${var.ceph_adm_instance_name}${count.index}-disk"
  count   = var.ceph_adm_vm_count
  type    = var.ceph_adm_disk_type
  size    = var.ceph_adm_disk_size
  image   = var.ceph_adm_instance_image
  zone    = var.gcp_instance_zone

  physical_block_size_bytes = 4096
}

resource "google_compute_address" "ceph_adm_vm_internal_address" {
  project    = var.project_id
  count      = var.ceph_adm_vm_count
  name       = "${var.ceph_adm_instance_name}${count.index}-internal-address"
  region     = var.gcp_instance_region
  subnetwork = data.google_compute_subnetwork.data_subnetwork.name

  address_type = "INTERNAL"
}
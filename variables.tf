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

variable "project_id" {
  description = "The project ID to deploy to"
}

###gcp common
variable "gcp_network" {
  description = "Network to use in GCP"
  default = "default"
}

variable "gcp_subnet_name" {
  description = "GCP subnetwork name for a given network"
  default = "default"
}

variable "gcp_instance_zone" {
  description = "Zone for instances to use"
  default = "europe-west3-b"
}

variable "gcp_instance_region" {
  description = "GCP region to deploy instances"
  default = "europe-west3"
}

###ceph osd
variable "ceph_osd_instance_name" {
  default = "ceph-osd-node"
}
variable "ceph_osd_vm_count" {
  default = "3"
}
variable "ceph_osd_instance_machine_type" {
  default = "n1-standard-1"
}
variable "ceph_osd_disk_type" {
  default = "pd-standard"
}
variable "ceph_osd_disk_size" {
  default = "10"
}
variable "ceph_osd_instance_image" {
  default = "centos-7"
}

###ceph adm
variable "ceph_adm_instance_name" {
  default = "ceph-adm-node"
}
variable "ceph_adm_vm_count" {
  default = "1"
}
variable "ceph_adm_instance_machine_type" {
  default = "g1-small"
}
variable "ceph_adm_disk_type" {
  default = "pd-standard"
}
variable "ceph_adm_disk_size" {
  default = "10"
}
variable "ceph_adm_instance_image" {
  default = "centos-7"
}
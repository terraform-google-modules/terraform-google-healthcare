# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

control "gcloud" do
  title "gcloud"

  describe command("gcloud --project=#{attribute("project")} services list --enabled") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "healthcare.googleapis.com" }
  end

  # Datasets
  describe command("gcloud --project=#{attribute("project")} healthcare datasets list") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "example-healthcare-dataset" }
  end

  # DICOM stores
  describe command("gcloud --project=#{attribute("project")} healthcare dicom-stores list --dataset=example-healthcare-dataset") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "example-dicom-a" }
    its(:stdout) { should match "example-dicom-b" }
  end

  # FHIR stores
  describe command("gcloud --project=#{attribute("project")} healthcare fhir-stores list --dataset=example-healthcare-dataset") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "example-fhir" }
  end

  # HL7V2 Stores
  describe command("gcloud --project=#{attribute("project")} healthcare hl7v2-stores list --dataset=example-healthcare-dataset") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "example-hl7v2" }
  end

  describe command("gcloud --project=#{attribute("project")} healthcare dicom-stores describe example-dicom-a --dataset=example-healthcare-dataset") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "projects/#{attribute("project")}/topics/example-topic\n" }
  end

  describe command("gcloud --project=#{attribute("project")} healthcare fhir-stores describe example-fhir --dataset=example-healthcare-dataset") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "projects/#{attribute("project")}/topics/example-topic\n" }
  end

  describe command("gcloud --project=#{attribute("project")} healthcare hl7v2-stores describe example-hl7v2 --dataset=example-healthcare-dataset") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "projects/#{attribute("project")}/topics/example-topic\n" }
  end

  describe command("gcloud --project=#{attribute("project")} beta healthcare hl7v2-stores describe example-hl7v2 --dataset=example-healthcare-dataset") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) {
      should match "parser_config"
      should match "SOFT_FAIL"
    }
  end

end

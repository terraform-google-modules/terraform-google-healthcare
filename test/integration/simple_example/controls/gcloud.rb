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
  describe command("gcloud --project=#{attribute("project")} beta healthcare datasets list") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "example-healthcare-dataset" }
  end

  # DICOM stores
  describe command("gcloud --project=#{attribute("project")} beta healthcare dicom-stores list --dataset=example-healthcare-dataset") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "example-dicom-a" }
    its(:stdout) { should match "example-dicom-b" }
  end

  describe command("gcloud --project=#{attribute("project")} beta healthcare dicom-stores list --dataset=example-healthcare-dataset --format=\"value(TOPIC)\" --filter=ID:example-dicom-a") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should eq "projects/#{attribute("project")}/topics/example-topic\n" }
  end

  describe command("gcloud --project=#{attribute("project")} beta healthcare dicom-stores list --dataset=example-healthcare-dataset --format=\"value(TOPIC)\" --filter=ID:example-dicom-b") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should eq "\n" }
  end

  describe command("gcloud --project=#{attribute("project")} beta healthcare datasets get-iam-policy example-healthcare-dataset --format=\"value(bindings)\"") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should eq "{'members': ['serviceAccount:example-sa@#{attribute("project")}.iam.gserviceaccount.com'], 'role': 'roles/healthcare.datasetAdmin'}\n" }
  end

  describe command("gcloud --project=#{attribute("project")} beta healthcare dicom-stores get-iam-policy example-dicom-a --dataset=example-healthcare-dataset --format=\"value(bindings)\"") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should eq "\n" }
  end

  describe command("gcloud --project=#{attribute("project")} beta healthcare dicom-stores get-iam-policy example-dicom-b --dataset=example-healthcare-dataset --format=\"value(bindings)\"") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should eq "{'members': ['serviceAccount:example-sa@#{attribute("project")}.iam.gserviceaccount.com'], 'role': 'roles/healthcare.dicomEditor'}\n" }
  end

  # FHIR stores
  describe command("gcloud --project=#{attribute("project")} beta healthcare fhir-stores list --dataset=example-healthcare-dataset") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "example-fhir" }
  end

  describe command("gcloud --project=#{attribute("project")} beta healthcare fhir-stores list --dataset=example-healthcare-dataset --format=\"value(TOPIC)\" --filter=ID:example-fhir") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should eq "projects/#{attribute("project")}/topics/example-topic\n" }
  end

  describe command("gcloud --project=#{attribute("project")} beta healthcare fhir-stores get-iam-policy example-fhir --dataset=example-healthcare-dataset --format=\"value(bindings)\"") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should eq "{'members': ['serviceAccount:example-sa@#{attribute("project")}.iam.gserviceaccount.com'], 'role': 'roles/healthcare.fhirResourceEditor'}\n" }
  end

  # HL7V2 Stores
  describe command("gcloud --project=#{attribute("project")} beta healthcare hl7v2-stores list --dataset=example-healthcare-dataset") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "example-hl7v2" }
  end

  describe command("gcloud --project=#{attribute("project")} beta healthcare hl7v2-stores list --dataset=example-healthcare-dataset --format=\"value(TOPIC)\" --filter=ID:example-hl7v2") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should eq "projects/#{attribute("project")}/topics/example-topic\n" }
  end

  describe command("gcloud --project=#{attribute("project")} beta healthcare hl7v2-stores get-iam-policy example-hl7v2 --dataset=example-healthcare-dataset --format=\"value(bindings)\"") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should eq "{'role': 'roles/healthcare.hl7V2Editor', 'members': ['serviceAccount:example-sa@#{attribute("project")}.iam.gserviceaccount.com']}\n" }
  end


end

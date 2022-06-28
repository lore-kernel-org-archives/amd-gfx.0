Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D689DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0266810FB3B;
	Tue, 28 Jun 2022 14:51:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F95A10FAA1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG1aICz9G72RsYgwsiFitNCLrV+dkrVdCgzluOrURtZBqjsIG0Ko4ZEhu77g3Wn9EnoJA2dlcH7SUr5TLNmTcqwnsfL2Ev7n5mAqxK+xnwTKqswwDsOj3Pj6nhX0RSuh8vi/ueTR/MzC6EzDaI88Iop0FKKho3jkiBW6o9O+LmDG+t8l4vxJ1mqCKQJvPqjHbk2BYslDYvjlkTSnNYNXKjq4c97CQvE3LTK5nI3+SzSaTWitZbqrDpTpiPd2UJ2PH2vGUNClYzB0oGpBiR+P2ltbscg21OWnlcFrwy+Vu9nJdQsO5CZWvdESgHQGHxr0nmj7dGJ4tPjbaxcrvvV03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlJ8faEbUPVClO1nhrun+LBDXW3YT+4AofnaE59mPEk=;
 b=fOHN23iGSC7PJxN4xOY5RCRh738/ZrMu5IkLSiY6+DEjKTgXMwNs/bFjkSF93cJZj5XU+x74R5mtWNrs9ePVA1pfogzV/TmqZgIzyNoxzZgejuAujgaog4ODIxOhNO0Qbky5/e1HQIxrEuQSUjx4I/hvID6UH/OupS7EY8c6x7hK0FU2jzRd0zbGJSo1uqJNeR29Jio+1pNfoW72HnNRvsrrUaXTuio1DIrpibp+78mAn92VxOLgGxA8vPDS6qMJvM6M/OPFsRUr4gJFYCEBeNSCl7MqGWrDXsW5zQSgRdYZ+KofL0Oc4hEb77qeZuWoua15k0Jwk1sPQpGsOYvCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlJ8faEbUPVClO1nhrun+LBDXW3YT+4AofnaE59mPEk=;
 b=osE7/iFthGyGtcOJQOJEgdaQyQ45lNc93jEY8MU4JE+fWtU2j1eIwPdzNPNouGWW86kPmukugMdvEKThfMJeKB0qyUeBxTLjO87kru3l/nXE4Zj4hGb6jAdTvpY5MSbgTaaQsnw6PT1cTjgWqhFpRd0ym3PJPOkQ+UW6YlBw+iQ=
Received: from MWHPR17CA0094.namprd17.prod.outlook.com (2603:10b6:300:c2::32)
 by BYAPR12MB2823.namprd12.prod.outlook.com (2603:10b6:a03:96::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 14:51:30 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::b1) by MWHPR17CA0094.outlook.office365.com
 (2603:10b6:300:c2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:29 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] ROCR-Runtime Basic SVM profiler
Date: Tue, 28 Jun 2022 10:50:20 -0400
Message-ID: <20220628145020.26925-12-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628145020.26925-1-Philip.Yang@amd.com>
References: <20220628145020.26925-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdaab2b1-fe27-4172-4b23-08da5915af87
X-MS-TrafficTypeDiagnostic: BYAPR12MB2823:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hcmWw1sEIRJqA1bQzRxxzFI1JV9g23GiySGYooCNzt2pNEkHAFup1dpGKPt07PpRzQpCSHVzUgSnc/e7wzriPtkF3Uqgt36Xtf9IDAfhYBMZbm7ucl5p8w3CySC+pIxohXU924GlZtVabAu4RSjuzYlR+6Wr9xzApMD6RxhJrP56ooa09lQUCsekQSDWXgF181JB+wWhgECeXYamThLbL+rONYLwgEHGr8fwBvJvHKnEx/EukCLajruMYtFJIqHlkxc4KMRTrt4u3qpzsWFP/FBCFTk+u7Q5146VzJ8cUN/74LdbVFIm8mvR/RiLdsdf4ABJy1PQlbbC8d2zOsQbRxqfnPCRWhPw+kwy/c04XWgxbx23r+4zJnlvQUhH6D25xJ0lLm+G2g30iCgRQDAGHoupqjkZqNnXdB+JvBEP+BWIFf0ogIpILl5E5rtdXbdxz7HuPIE2DaDWRXhPk0NF1zjoqm/HM5994ECaLS6OzbNCu1WJkop7ZWkapUlg+XuOMI0AiqkXMN0p+JL5JiHGwrAix930ChPZqYVElPHzn7yVcZGBL3t5bRnYOOZofEkVeDYdCe/JHoczsuMJhweLguDsso9uU4LUOzzCHpegV69eVtT+FXEsiXGzIUBNhlcI29srgcRj4kUGW3/kQBVvrnQyzwirTxr5U981q7wqWxwn1y0fXysnvPhhPIaA+CaevAfjxxi3lJTmGkQKBl6JLLcP8sMdReCqpzCLx4fQZGVZNtHaqaIEB/3hutt3KsDfgzxM2vRYKB61ZAYH2TWPmrSi0CtPZrVgSWRiMqZ4mYOzIAAzrcQvBIP3IZJJ3vAudeKanmWv6HqXkiPI9ubCLNpTpfvuPxBVCmQtCYoM/w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(316002)(54906003)(6916009)(4326008)(70206006)(86362001)(82740400003)(8676002)(2906002)(26005)(81166007)(5660300002)(70586007)(356005)(15974865002)(83380400001)(8936002)(7696005)(426003)(40460700003)(16526019)(336012)(47076005)(41300700001)(6666004)(36860700001)(82310400005)(2616005)(1076003)(478600001)(36756003)(30864003)(40480700001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:29.8536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaab2b1-fe27-4172-4b23-08da5915af87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2823
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Felix.Kuehling@amd.com, Sean Keely <Sean.Keely@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sean Keely <Sean.Keely@amd.com>

Mostly a demo at this point.  Logs SVM (aka HMM) info to
HSA_SVM_PROFILE if set.

Example: HSA_SVM_PROFILE=log.txt SomeApp

Change-Id: Ib6fd688f661a21b2c695f586b833be93662a15f4
---
 src/CMakeLists.txt                |   1 +
 src/core/inc/amd_gpu_agent.h      |   3 +
 src/core/inc/runtime.h            |   9 +
 src/core/inc/svm_profiler.h       |  67 ++++++
 src/core/runtime/runtime.cpp      |   8 +
 src/core/runtime/svm_profiler.cpp | 364 ++++++++++++++++++++++++++++++
 src/core/util/flag.h              |   6 +
 7 files changed, 458 insertions(+)
 create mode 100644 src/core/inc/svm_profiler.h
 create mode 100644 src/core/runtime/svm_profiler.cpp

diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 8fb02b14..1b7bf9b0 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -180,6 +180,7 @@ set ( SRCS core/util/lnx/os_linux.cpp
            core/runtime/signal.cpp
            core/runtime/queue.cpp
            core/runtime/cache.cpp
+           core/runtime/svm_profiler.cpp
            core/common/shared.cpp
            core/common/hsa_table_interface.cpp
            loader/executable.cpp
diff --git a/src/core/inc/amd_gpu_agent.h b/src/core/inc/amd_gpu_agent.h
index ed64d5be..fbdccaae 100644
--- a/src/core/inc/amd_gpu_agent.h
+++ b/src/core/inc/amd_gpu_agent.h
@@ -283,6 +283,9 @@ class GpuAgent : public GpuAgentInt {
   // @brief Returns Hive ID
   __forceinline uint64_t HiveId() const override { return  properties_.HiveID; }
 
+  // @brief Returns KFD's GPU id which is a hash used internally.
+  __forceinline uint64_t KfdGpuID() const { return properties_.KFDGpuID; }
+
   // @brief Returns node property.
   __forceinline const HsaNodeProperties& properties() const {
     return properties_;
diff --git a/src/core/inc/runtime.h b/src/core/inc/runtime.h
index 9f5b8acc..13190c75 100644
--- a/src/core/inc/runtime.h
+++ b/src/core/inc/runtime.h
@@ -50,6 +50,7 @@
 #include <memory>
 #include <tuple>
 #include <utility>
+#include <thread>
 
 #include "core/inc/hsa_ext_interface.h"
 #include "core/inc/hsa_internal.h"
@@ -60,6 +61,7 @@
 #include "core/inc/memory_region.h"
 #include "core/inc/signal.h"
 #include "core/inc/interrupt_signal.h"
+#include "core/inc/svm_profiler.h"
 #include "core/util/flag.h"
 #include "core/util/locks.h"
 #include "core/util/os.h"
@@ -312,6 +314,8 @@ class Runtime {
 
   const std::vector<uint32_t>& gpu_ids() { return gpu_ids_; }
 
+  Agent* agent_by_gpuid(uint32_t gpuid) { return agents_by_gpuid_[gpuid]; }
+
   Agent* region_gpu() { return region_gpu_; }
 
   const std::vector<const MemoryRegion*>& system_regions_fine() const {
@@ -508,6 +512,9 @@ class Runtime {
   // Agent map containing all agents indexed by their KFD node IDs.
   std::map<uint32_t, std::vector<Agent*> > agents_by_node_;
 
+  // Agent map containing all agents indexed by their KFD gpuid.
+  std::map<uint32_t, Agent*> agents_by_gpuid_;
+
   // Agent list containing all compatible gpu agent ids in the platform.
   std::vector<uint32_t> gpu_ids_;
 
@@ -590,6 +597,8 @@ class Runtime {
   // Kfd version
   KfdVersion_t kfd_version;
 
+  std::unique_ptr<AMD::SvmProfileControl> svm_profile_;
+
   // Frees runtime memory when the runtime library is unloaded if safe to do so.
   // Failure to release the runtime indicates an incorrect application but is
   // common (example: calls library routines at process exit).
diff --git a/src/core/inc/svm_profiler.h b/src/core/inc/svm_profiler.h
new file mode 100644
index 00000000..064965c7
--- /dev/null
+++ b/src/core/inc/svm_profiler.h
@@ -0,0 +1,67 @@
+////////////////////////////////////////////////////////////////////////////////
+//
+// The University of Illinois/NCSA
+// Open Source License (NCSA)
+//
+// Copyright (c) 2022-2022, Advanced Micro Devices, Inc. All rights reserved.
+//
+// Developed by:
+//
+//                 AMD Research and AMD HSA Software Development
+//
+//                 Advanced Micro Devices, Inc.
+//
+//                 www.amd.com
+//
+// Permission is hereby granted, free of charge, to any person obtaining a copy
+// of this software and associated documentation files (the "Software"), to
+// deal with the Software without restriction, including without limitation
+// the rights to use, copy, modify, merge, publish, distribute, sublicense,
+// and/or sell copies of the Software, and to permit persons to whom the
+// Software is furnished to do so, subject to the following conditions:
+//
+//  - Redistributions of source code must retain the above copyright notice,
+//    this list of conditions and the following disclaimers.
+//  - Redistributions in binary form must reproduce the above copyright
+//    notice, this list of conditions and the following disclaimers in
+//    the documentation and/or other materials provided with the distribution.
+//  - Neither the names of Advanced Micro Devices, Inc,
+//    nor the names of its contributors may be used to endorse or promote
+//    products derived from this Software without specific prior written
+//    permission.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+// THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
+// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+// DEALINGS WITH THE SOFTWARE.
+//
+////////////////////////////////////////////////////////////////////////////////
+
+#ifndef HSA_RUNTME_CORE_INC_SVM_PROFILER_H_
+#define HSA_RUNTME_CORE_INC_SVM_PROFILER_H_
+
+#include <vector>
+#include <string>
+#include <thread>
+
+namespace rocr {
+namespace AMD {
+
+    class SvmProfileControl {
+    public:
+      SvmProfileControl();
+      ~SvmProfileControl();
+
+    private:
+      template <typename... Args> std::string format(const char* format, Args... arg);
+      int event;
+      std::thread* thread;
+      std::vector<char> format_buffer;
+    };
+
+} // namespace AMD
+} // namespace rocr
+#endif // header guard
diff --git a/src/core/runtime/runtime.cpp b/src/core/runtime/runtime.cpp
index 40ebc35e..cb7ba992 100644
--- a/src/core/runtime/runtime.cpp
+++ b/src/core/runtime/runtime.cpp
@@ -48,6 +48,7 @@
 #include <string>
 #include <thread>
 #include <vector>
+#include <cstdio>
 
 #include "core/common/shared.h"
 #include "core/inc/hsa_ext_interface.h"
@@ -158,6 +159,8 @@ void Runtime::RegisterAgent(Agent* agent) {
   if (agent->device_type() == Agent::DeviceType::kAmdCpuDevice) {
     cpu_agents_.push_back(agent);
 
+    agents_by_gpuid_[0] = agent;
+
     // Add cpu regions to the system region list.
     for (const core::MemoryRegion* region : agent->regions()) {
       if (region->fine_grain()) {
@@ -1375,10 +1378,15 @@ hsa_status_t Runtime::Load() {
   // Load tools libraries
   LoadTools();
 
+  // Load svm profiler
+  svm_profile_.reset(new AMD::SvmProfileControl);
+
   return HSA_STATUS_SUCCESS;
 }
 
 void Runtime::Unload() {
+  svm_profile_.reset(nullptr);
+
   UnloadTools();
   UnloadExtensions();
 
diff --git a/src/core/runtime/svm_profiler.cpp b/src/core/runtime/svm_profiler.cpp
new file mode 100644
index 00000000..537b3a05
--- /dev/null
+++ b/src/core/runtime/svm_profiler.cpp
@@ -0,0 +1,364 @@
+////////////////////////////////////////////////////////////////////////////////
+//
+// The University of Illinois/NCSA
+// Open Source License (NCSA)
+//
+// Copyright (c) 2022-2022, Advanced Micro Devices, Inc. All rights reserved.
+//
+// Developed by:
+//
+//                 AMD Research and AMD HSA Software Development
+//
+//                 Advanced Micro Devices, Inc.
+//
+//                 www.amd.com
+//
+// Permission is hereby granted, free of charge, to any person obtaining a copy
+// of this software and associated documentation files (the "Software"), to
+// deal with the Software without restriction, including without limitation
+// the rights to use, copy, modify, merge, publish, distribute, sublicense,
+// and/or sell copies of the Software, and to permit persons to whom the
+// Software is furnished to do so, subject to the following conditions:
+//
+//  - Redistributions of source code must retain the above copyright notice,
+//    this list of conditions and the following disclaimers.
+//  - Redistributions in binary form must reproduce the above copyright
+//    notice, this list of conditions and the following disclaimers in
+//    the documentation and/or other materials provided with the distribution.
+//  - Neither the names of Advanced Micro Devices, Inc,
+//    nor the names of its contributors may be used to endorse or promote
+//    products derived from this Software without specific prior written
+//    permission.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+// THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
+// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+// DEALINGS WITH THE SOFTWARE.
+//
+////////////////////////////////////////////////////////////////////////////////
+
+#include "core/inc/svm_profiler.h"
+
+#include <stdint.h>
+#include <algorithm>
+#include <sys/eventfd.h>
+#include <poll.h>
+
+#include "hsakmt/hsakmt.h"
+
+#include "core/util/utils.h"
+#include "core/inc/runtime.h"
+#include "core/inc/agent.h"
+#include "core/inc/amd_gpu_agent.h"
+
+namespace rocr {
+namespace AMD {
+
+static const char* smi_event_string(uint32_t event) {
+  static const char* strings[] = {"NONE",
+                                  "VMFAULT",
+                                  "THERMAL_THROTTLE",
+                                  "GPU_PRE_RESET",
+                                  "GPU_POST_RESET",
+                                  "MIGRATE_START",
+                                  "MIGRATE_END",
+                                  "PAGE_FAULT_START",
+                                  "PAGE_FAULT_END",
+                                  "QUEUE_EVICTION",
+                                  "QUEUE_RESTORE",
+                                  "UNMAP_FROM_GPU",
+                                  "UNKNOWN"};
+
+  event = std::min<uint32_t>(event, sizeof(strings) / sizeof(char*) - 1);
+  return strings[event];
+}
+
+static const char* smi_migrate_string(uint32_t trigger) {
+  static const char* strings[] = {"PREFETCH",
+                                  "PAGEFAULT_GPU",
+                                  "PAGEFAULT_CPU",
+                                  "TTM_EVICTION",
+                                  "UNKNOWN"};
+
+  trigger = std::min<uint32_t>(trigger, sizeof(strings) / sizeof(char*) - 1);
+  return strings[trigger];
+}
+
+static const char* smi_eviction_string(uint32_t trigger) {
+  static const char* strings[] = {"SVM",
+                                  "USERPTR",
+                                  "TTM",
+                                  "SUSPEND",
+                                  "CRIU_CHECKPOINT",
+                                  "CRIU_RESTORE",
+                                  "UNKNOWN"};
+
+  trigger = std::min<uint32_t>(trigger, sizeof(strings) / sizeof(char*) - 1);
+  return strings[trigger];
+}
+
+static const char* smi_unmap_string(uint32_t trigger) {
+  static const char* strings[] = {"MMU_NOTIFY",
+                                  "MMU_NOTIFY_MIGRATE",
+                                  "UNMAP_FROM_CPU",
+                                  "UNKNOWN"};
+
+  trigger = std::min<uint32_t>(trigger, sizeof(strings) / sizeof(char*) - 1);
+  return strings[trigger];
+}
+
+SvmProfileControl::SvmProfileControl() : event(-1), thread(nullptr) {
+  event = eventfd(0, EFD_CLOEXEC);
+  if (event == -1) return;
+
+  thread = new std::thread([&]() {
+    if (core::Runtime::runtime_singleton_->flag().svm_profile().empty()) return;
+    FILE* logFile = fopen(core::Runtime::runtime_singleton_->flag().svm_profile().c_str(), "a");
+    if (logFile == NULL) return;
+    MAKE_NAMED_SCOPE_GUARD(logGuard, [&]() { fclose(logFile); });
+
+    std::vector<pollfd> files;
+    files.resize(core::Runtime::runtime_singleton_->gpu_agents().size() + 1);
+    files[0].fd = event;
+    files[0].events = POLLIN;
+    files[0].revents = 0;
+
+    HSAuint64 events = 0;
+    events = HSA_SMI_EVENT_MASK_FROM_INDEX(HSA_SMI_EVENT_MIGRATE_START) |
+        HSA_SMI_EVENT_MASK_FROM_INDEX(HSA_SMI_EVENT_MIGRATE_END) |
+        HSA_SMI_EVENT_MASK_FROM_INDEX(HSA_SMI_EVENT_PAGE_FAULT_START) |
+        HSA_SMI_EVENT_MASK_FROM_INDEX(HSA_SMI_EVENT_PAGE_FAULT_END) |
+        HSA_SMI_EVENT_MASK_FROM_INDEX(HSA_SMI_EVENT_QUEUE_EVICTION) |
+        HSA_SMI_EVENT_MASK_FROM_INDEX(HSA_SMI_EVENT_QUEUE_RESTORE) |
+        HSA_SMI_EVENT_MASK_FROM_INDEX(HSA_SMI_EVENT_UNMAP_FROM_GPU);
+
+    for (int i = 0; i < core::Runtime::runtime_singleton_->gpu_agents().size(); i++) {
+      auto err =
+          hsaKmtOpenSMI(core::Runtime::runtime_singleton_->gpu_agents()[i]->node_id(), &files[i + 1].fd);
+      assert(err == HSAKMT_STATUS_SUCCESS);
+      files[i + 1].events = POLLIN;
+      files[i + 1].revents = 0;
+      // Enable collecting masked events.
+      auto wrote = write(files[i + 1].fd, &events, sizeof(events));
+      assert(wrote == sizeof(events));
+    }
+    MAKE_NAMED_SCOPE_GUARD(smiGuard, [&]() {
+      for (int i = 1; i < files.size(); i++) {
+        close(files[i].fd);
+      }
+    });
+
+    std::vector<std::string> smi_records;
+    smi_records.resize(core::Runtime::runtime_singleton_->gpu_agents().size() + 1);
+    char buffer[HSA_SMI_EVENT_MSG_SIZE + 1];
+
+    auto format_agent = [this](uint32_t gpuid) {
+      std::string ret;
+      core::Agent* agent = core::Runtime::runtime_singleton_->agent_by_gpuid(gpuid);
+      if (agent->device_type() == core::Agent::kAmdCpuDevice)
+        return std::string("CPU");
+      else
+        return format("GPU%u(%p)", ((AMD::GpuAgent*)agent)->enumeration_index(),
+                      agent->public_handle());
+    };
+
+    while (true) {
+      int ready = poll(&files[0], files.size(), -1);
+      if (ready < 1) {
+        assert(false && "poll failed!");
+        return;
+      }
+
+      for (int i = 1; i < files.size(); i++) {
+        if (files[i].revents & POLLIN) {
+          memset(buffer, 0, sizeof(buffer));
+          auto len = read(files[i].fd, buffer, sizeof(buffer) - 1);
+          if (len > 0) {
+            buffer[len] = '\0';
+            // printf("%s\n", buffer);
+            // fprintf(logFile, "%s\n", buffer);
+
+            smi_records[i] += buffer;
+
+            while (true) {
+              size_t pos = smi_records[i].find('\n');
+              if (pos == std::string::npos) break;
+
+              std::string line = smi_records[i].substr(0, pos);
+              smi_records[i].erase(0, pos + 1);
+
+              const char* cursor;
+              cursor = line.c_str();
+
+              // Event records follow the format:
+              // event_id timestamp -pid event_specific_info trigger
+              // timestamp, pid, and trigger are in dec.  All other are hex.
+              // event_specific substring is listed for each event type.
+              // See kfd_ioctl.h for more info.
+              int event_id;
+              uint64_t time;
+              int pid;
+              int offset = 0;
+              int args = sscanf(cursor, "%x %lu -%u%n", &event_id, &time, &pid, &offset);
+              assert(args == 3 && "Parsing error!");
+
+              std::string detail;
+              cursor += offset + 1;
+              switch (event_id) {
+                //@addr(size) from->to prefetch_location:preferred_location
+                case HSA_SMI_EVENT_MIGRATE_START: {
+                  uint64_t addr;
+                  uint32_t size;
+                  uint32_t from, to;
+                  uint32_t trigger = 0;
+                  uint32_t fetch, pref;
+                  args = sscanf(cursor, "@%lx(%x) %x->%x %x:%x %u", &addr, &size, &from, &to,
+                                &fetch, &pref, &trigger);
+                  assert(args == 7 && "Parsing error!");
+
+                  addr *= 4096;
+                  size *= 4096;
+
+                  std::string from_agent = format_agent(from);
+                  std::string to_agent = format_agent(to);
+                  std::string range = format("[%p, %p]", addr, addr + size - 1);
+                  std::string cause = smi_migrate_string(trigger);
+                  detail = cause + " " + from_agent + "->" + to_agent + " " + range;
+                  break;
+                }
+                //@addr(size) from->to
+                case HSA_SMI_EVENT_MIGRATE_END: {
+                  uint64_t addr;
+                  uint32_t size;
+                  uint32_t from, to;
+                  uint32_t trigger;
+                  args = sscanf(cursor, "@%lx(%x) %x->%x %u", &addr, &size, &from, &to, &trigger);
+                  assert(args == 5 && "Parsing error!");
+
+                  addr *= 4096;
+                  size *= 4096;
+
+                  std::string from_agent = format_agent(from);
+                  std::string to_agent = format_agent(to);
+                  std::string range = format("[%p, %p]", addr, addr + size - 1);
+                  std::string cause = smi_migrate_string(trigger);
+                  detail = cause + " " + from_agent + "->" + to_agent + " " + range;
+                  break;
+                }
+                //@addr(gpu_id) W/R
+                case HSA_SMI_EVENT_PAGE_FAULT_START: {
+                  uint64_t addr;
+                  uint32_t gpuid;
+                  char mode;
+                  args = sscanf(cursor, "@%lx(%x) %c", &addr, &gpuid, &mode);
+
+                  addr *= 4096;
+
+                  assert(args == 3 && "Parsing error!");
+                  std::string agent = format_agent(gpuid);
+                  std::string range = std::to_string(addr);
+                  std::string cause = (mode == 'W') ? "Write" : "Read";
+                  detail = cause + " " + agent + " " + range;
+                  break;
+                }
+                //@addr(gpu_id) M/U  (migration / page table update)
+                case HSA_SMI_EVENT_PAGE_FAULT_END: {
+                  uint64_t addr;
+                  uint32_t gpuid;
+                  char mode;
+                  args = sscanf(cursor, "@%lx(%x) %c", &addr, &gpuid, &mode);
+                  assert(args == 3 && "Parsing error!");
+
+                  addr *= 4096;
+
+                  std::string agent = format_agent(gpuid);
+                  std::string range = std::to_string(addr);
+                  std::string cause = (mode == 'M') ? "Migration" : "Map";
+                  detail = cause + " " + agent + " " + range;
+                  break;
+                }
+                // gpu_id
+                case HSA_SMI_EVENT_QUEUE_EVICTION: {
+                  uint32_t gpuid;
+                  uint32_t trigger;
+                  args = sscanf(cursor, "%x %u", &gpuid, &trigger);
+                  assert(args == 2 && "Parsing error!");
+                  std::string agent = format_agent(gpuid);
+                  std::string cause = smi_eviction_string(trigger);
+                  detail = cause + " " + agent;
+                  break;
+                }
+                // gpu_id
+                case HSA_SMI_EVENT_QUEUE_RESTORE: {
+                  uint32_t gpuid;
+                  uint32_t trigger;
+                  args = sscanf(cursor, "%x %u", &gpuid, &trigger);
+                  assert(args == 2 && "Parsing error!");
+                  std::string agent = format_agent(gpuid);
+                  std::string cause = smi_eviction_string(trigger);
+                  detail = cause + " " + agent;
+                  break;
+                }
+                //@addr(size) gpu_id
+                case HSA_SMI_EVENT_UNMAP_FROM_GPU: {
+                  uint64_t addr;
+                  uint32_t size;
+                  uint32_t gpuid;
+                  uint32_t trigger;
+                  args = sscanf(cursor, "@%lx(%x) %x %u", &addr, &size, &gpuid, &trigger);
+                  assert(args == 4 && "Parsing error!");
+
+                  addr *= 4096;
+                  size *= 4096;
+
+                  std::string gpu = format_agent(gpuid);
+                  std::string range = format("[%p, %p]", addr, addr + size - 1);
+                  std::string cause = smi_unmap_string(trigger);
+                  detail = cause + " " + gpu + " " + range;
+                  break;
+                }
+                default:;
+              }
+
+              std::string record = std::string("ROCr HMM event: ") + std::to_string(time) + " " +
+                  smi_event_string(event_id) + " " + detail;
+              // printf("%s\n", record.c_str());
+              fprintf(logFile, "%s\n", record.c_str());
+            }
+          } else {
+            auto err = errno;
+            const char* msg = strerror(err);
+            // printf("ROCr HMM event error: Read returned %ld, %s (%d)\n", len, msg, err);
+            fprintf(logFile, "ROCr HMM event error: Read returned %ld, %s (%d)\n", len, msg, err);
+          }
+          files[i].revents = 0;
+        }
+      }
+
+      if (files[0].revents & POLLIN) return;
+    }
+  });
+}
+
+SvmProfileControl::~SvmProfileControl() {
+  if (event != -1) eventfd_write(event, 1);
+  thread->join();
+  delete thread;
+  close(event);
+}
+
+template <typename... Args>
+std::string SvmProfileControl::format(const char* format, Args... args) {
+  int len = snprintf(&format_buffer[0], format_buffer.size(), format, args...);
+  if (len + 1 > format_buffer.size()) {
+    format_buffer.resize(len + 1);
+    snprintf(&format_buffer[0], format_buffer.size(), format, args...);
+  }
+  return std::string(&format_buffer[0]);
+}
+ 
+} // namespace AMD
+} // namespace rocr
diff --git a/src/core/util/flag.h b/src/core/util/flag.h
index 045a6d0c..212ab013 100644
--- a/src/core/util/flag.h
+++ b/src/core/util/flag.h
@@ -153,6 +153,9 @@ class Flag {
     // Will become opt-out and possibly removed in future releases.
     var = os::GetEnvVar("HSA_COOP_CU_COUNT");
     coop_cu_count_ = (var == "1") ? true : false;
+
+    var = os::GetEnvVar("HSA_SVM_PROFILE");
+    svm_profile_ = var;
   }
 
   void parse_masks(uint32_t maxGpu, uint32_t maxCU) {
@@ -221,6 +224,8 @@ class Flag {
 
   bool coop_cu_count() const { return coop_cu_count_; }
 
+  const std::string& svm_profile() const { return svm_profile_; }
+
  private:
   bool check_flat_scratch_;
   bool enable_vm_fault_message_;
@@ -252,6 +257,7 @@ class Flag {
   size_t scratch_mem_size_;
 
   std::string tools_lib_names_;
+  std::string svm_profile_;
 
   size_t force_sdma_size_;
 
-- 
2.35.1


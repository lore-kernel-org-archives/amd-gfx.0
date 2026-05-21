Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301C9CD5BAB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 21:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12C310E55E;
	Thu, 21 May 2026 21:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ek3ZjlAw";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012049.outbound.protection.outlook.com
 [40.93.195.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB1710E55E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 21:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHVYptXv+t7koLJn/TweZz3g+wTjUcLUTcY0CKco90mm87/G5g1g9UYVdPPleut8obdzn+lWVIHZr060YYoV+2Fkkt2pou1PKHzw+uJtw8YB62KUbS9gu0trqazOGhox4WQA9hOmcuRwJywvfy1Y0k6wnebFx3tezVTuwr8JPPCU0aDooWZzsooIeZgpG63Hhh7plTG3VRAl47Tr4KyveL7AmwUFoIQKmNvdaLHSF3a7r8kWkGNfar7Aou+Kq+pYSCJy4wwxgoRdEPRhOXxphcS1ECjK+Zl4Le/MaBSUKOid0WdYTU+wPB2vFNLionx0N2VeNZ5ygP0gzyV/NQqFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XW5322pXnsNikQGbM5r3RA8TEqjrLzy3UqIQOvi/WmE=;
 b=uhr8g4VBwhYl2enTemR4WjVi0+UV36kHFkRcM4ksuR8ZZcOFE18XWFuYhj72iTuRpmBtRshxIfK992kvQLr9tKK1G3maA/+VWsOeHMGxVBlpeO6r9r2NlUNqGWjSx2KvsoDntG8TLwmaQCRh0RqFUTo19tdncR61IEKtwm4yJJ+FNzpWp/4KIVvFMlwq9iFDy6mXOcV4FC+0CXeq9b2+/3p30Bk1GbYHvfH1c1MuoeqOOC3X1JP7z8FJnmMTRdxBRqt+jbJGS3pUW/bMajk6mGJnGcrjoL5ybXCiKWIao68PX29Vlk2zfIeuG8/X+P7nYWlepr/XqZ6OL6su1c2vgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XW5322pXnsNikQGbM5r3RA8TEqjrLzy3UqIQOvi/WmE=;
 b=Ek3ZjlAwC2MCdRi8QtCylA9AFNQ8rJ1aki8I+DuiCMvao9Ak8brMCqGjAG3Z+2E1YdivsSAcjSE6Ak5vW+PYSK+Z7HNPE6F5y4jUfEClS1y71jBEfXSI3bLDTsdHeA7/GY/NlmD/79ZTFJR1b34y2/BJTes+dKZnydP8VA2i9LE=
Received: from IA1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::6)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 21 May
 2026 21:40:05 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::70) by IA1P220CA0009.outlook.office365.com
 (2603:10b6:208:461::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 21:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 21:40:05 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 16:40:04 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Bing.Ma@amd.com>
CC: <jamesz@amd.com>
Subject: [PATCH v3 07/17] drm/amdgpu: add profiler/spm manager initialization
 and release
Date: Thu, 21 May 2026 17:39:54 -0400
Message-ID: <20260521213954.1934376-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-8-James.Zhu@amd.com>
References: <20260324212030.822932-8-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: 609c4454-c7dd-4db7-affb-08deb78185b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|11063799006|18002099003|56012099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: JBJqSLSevPBYVZUZI1P+7HpYHHsqPzB9aiYZKX1g2+K5N+J/bj8X8omVhldnj82epJVTSToqxQ7RbUkuM8YYGjJ+sU06r+AQBfhqJyPpewQW1MBemVOwUK/gTuV4jAI0qNbFx4j/3ro6NwmCa1y3EsSHsn9KzsKmindFPph5M5vv+ihDAbDA0Z4lI83I5Smud2l1yk1YVRsLT8Oz3maVfDpB4Gar26/a/ZxdpBhut0o2iDjVTe/RqoIBkNAWi7d4wK4ktyj3TprQ6zwidv5pVpGMJeCTvBhVVEbRsFk/HfLBQkfDlVyTtX8rRp2x3bC3rxI8sY6/B4zCMV7yT8hODoF8Y78Hl9WSzTA75XbOpFY9sQiHkfIJH9xcPjeqqLvltA86eMizTN89Y9ffwLUESlQgrPrjNTUv4P2clc5nxLqVdHs34JkHOFba4ZVOZr8V3+YkjvmWJh41wEfke6Vatmxh/WVMAdRIE1+axwwZcmbEmK0BK7GygbQhA86ehvf7BZW9AS8iFGV63qJ6hBchk2B9rTBeK3XPbdCX9C5/nZECy2Sgrv3gUTaCJSFEzhfAGy+6Woo4IlijE7oPsINDoGqL3E0SiAKkNQvzom2D3UjmAosP2vWRvf9YQFFG8jeJozSxwWqiTTP6MGrf1PzdqrQ1Ujy4qlxier2/xkV1DaiXtXsxPtFxYOJk/dDRUEJUxZK3M+DPWrXEVWu5x953HLSFwvNH12fl/VB/1gT5aew=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(11063799006)(18002099003)(56012099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JQ9Djt1Ygmbb6ZbpzFAZnQwfZzHxPGHbEXPEEr4OJGzg9gIkwslB6d+ZfB/i99ZzWKhh6VhBFvcAEx6A1N2DAMJIJVufviLy1BN8YG75Cih06ngXPN/tzTeAxhf49oAXkw90V75IRMFbocNSX/ljrHruAEHiU11gwIc1e4rfNwMI42p3oL5uQxQ9LdqIUu9qnwjGIcscGFEpwbEa6Wp2Xgt0Yo9X0yNls5awDPDVzHYiTx0K3L2oR+IkwCUOvHE5bg0BJwleVMQait67OgeavQYKoumVSVvblDw8e/ySsOoDkBEBhpM8c9XN5vKKhoGndeJUFPloQlk40PWH4/vak0jGG8PEG0smfqUerGgk5Y+QbnUOq8/9IMUuApDR6b/0BixhlPIaVCtb4+xoLSn+xNBoGcdjUTEM1qTHECsznRCfSwgMA2E0MnFB6EpeDQ3W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:40:05.4432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 609c4454-c7dd-4db7-affb-08deb78185b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999159
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

to introduce the SPM (Stream Performance Monitor) manager subsystem
as a new compilation unit (amdgpu_spm.c / amdgpu_spm.h) and integrate
it into the per-XCP profiler manager lifecycle.

struct amdgpu_spm_mgr is defined in amdgpu_spm.h, currently holding
only a drm_file pointer (the owning file handle). It is embedded as a
member of a union inside struct amdgpu_profiler_xcp_mgr, alongside
future profiler subsystems (e.g. PCS).

The SPM manager lifecycle is tied to the profiler XCP manager:
- amdgpu_spm_mgr_init() is called from amdgpu_profiler_mgr_init() when
  a new XCP profiler context is first created (i.e. the first open on
  that XCP partition). It calls the internal amdgpu_spm_init_device()
  stub (TODO: device-level SPM hardware initialization).
- amdgpu_spm_mgr_fini() is called from amdgpu_profiler_mgr_release()
  (the kref release callback) when the last file handle referencing this
  XCP profiler context is closed. If an active file handle is recorded
  in spm_mgr->file, it triggers amdgpu_spm_release_device(), which
  calls the internal amdgpu_spm_release() stub (TODO: SPM hardware
  teardown and resource cleanup).

A helper macro prof_mgr_to_adev() is added to amdgpu_profiler.h to
retrieve the parent amdgpu_device from an amdgpu_profiler_mgr pointer
via container_of().

-v3: rename is_init to is_initialized in amdgpu_profiler_xcp_mgr

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 11 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 62 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      | 34 +++++++++++
 5 files changed, 113 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 74abc061cd4d..e97a9a066308 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -68,7 +68,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o  amdgpu_cwsr.o \
-	amdgpu_profiler.o
+	amdgpu_profiler.o amdgpu_spm.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index bed43ea8bcc3..7ea3c57ccd39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -70,7 +70,7 @@ int amdgpu_profiler_mgr_init(
 	mutex_lock(&prof_mgr->mutex);
 
 	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
-	if (prof_xcp_mgr->is_init) {
+	if (prof_xcp_mgr->is_initialized) {
 		kref_get(&prof_xcp_mgr->ref);
 		mutex_unlock(&prof_mgr->mutex);
 		return 0;
@@ -82,7 +82,8 @@ int amdgpu_profiler_mgr_init(
 	mutex_init(&prof_xcp_mgr->mutex);
 	prof_xcp_mgr->xcp_id = fpriv->xcp_id;
 
-	prof_xcp_mgr->is_init = true;
+	amdgpu_spm_mgr_init(&prof_xcp_mgr->spm_mgr);
+	prof_xcp_mgr->is_initialized = true;
 
 	mutex_unlock(&prof_mgr->mutex);
 	return 0;
@@ -93,8 +94,10 @@ static void amdgpu_profiler_mgr_release(struct kref *ref)
 	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =
 		container_of(ref, struct amdgpu_profiler_xcp_mgr, ref);
 
+	amdgpu_spm_mgr_fini(&prof_xcp_mgr->spm_mgr);
+
 	mutex_destroy(&prof_xcp_mgr->mutex);
-	prof_xcp_mgr->is_init = false;
+	prof_xcp_mgr->is_initialized = false;
 }
 
 void amdgpu_profiler_mgr_fini(
@@ -108,7 +111,7 @@ void amdgpu_profiler_mgr_fini(
 
 	mutex_lock(&prof_mgr->mutex);
 	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
-	if (prof_xcp_mgr->is_init)
+	if (prof_xcp_mgr->is_initialized)
 		kref_put(&prof_xcp_mgr->ref, amdgpu_profiler_mgr_release);
 	mutex_unlock(&prof_mgr->mutex);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index e73a49c9a41f..35ad16b0ead5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -25,15 +25,24 @@
 #ifndef AMDGPU_PROFILER_H_
 #define AMDGPU_PROFILER_H_
 
+#include "amdgpu_spm.h"
+
 #define AMDGPU_XCP_ID(x) (x == AMDGPU_XCP_NO_PARTITION ? 0 : x)
 #define fpriv_to_prof_mgr(fpriv) (&(fpriv)->userq_mgr.adev->prof_mgr)
 #define fpriv_to_adev(fpriv) ((fpriv)->userq_mgr.adev)
 
+#define prof_mgr_to_adev(x) \
+	container_of(x, struct amdgpu_device, prof_mgr)
+
 struct amdgpu_profiler_xcp_mgr {
 	struct mutex                   mutex;
 	uint32_t                       xcp_id;
 	bool                           is_initialized;
 	struct kref                    ref;
+
+	union {
+		struct amdgpu_spm_mgr      spm_mgr;
+	};
 };
 
 struct amdgpu_profiler_mgr {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
new file mode 100644
index 000000000000..27f4ed1aa1e0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "amdgpu.h"
+
+/*
+ * SPM revision change log
+ *
+ * 0.1 - Initial revision
+ */
+
+static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
+
+static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)
+{
+	/* TODO */
+}
+
+static void amdgpu_spm_release_device(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
+{
+	amdgpu_spm_release(spm_mgr, filp);
+}
+
+static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
+{
+	/* TODO */
+	return 0;
+}
+
+int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr)
+{
+	amdgpu_spm_init_device(spm_mgr);
+	return 0;
+}
+
+void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
+{
+	if (spm_mgr->file) {
+		amdgpu_spm_release_device(spm_mgr, spm_mgr->file);
+		spm_mgr->file = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
new file mode 100644
index 000000000000..06b4f6dba41b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef AMDGPU_SPM_H_
+#define AMDGPU_SPM_H_
+
+struct amdgpu_spm_mgr {
+	struct drm_file *file;
+};
+
+int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);
+void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
+
+#endif
-- 
2.34.1


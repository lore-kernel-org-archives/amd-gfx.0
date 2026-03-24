Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FA3FEC118
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1972C10E5F4;
	Tue, 24 Mar 2026 21:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vmgqn41D";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C8310E326
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0/dh6eV4d3GUO7/1DrOjPsu/tl7D1g8E1nArGoL5s3YRIxwHaVFu8Nv0ktfW2y4XRqGtJvz/xcnc/Xgr2ZORU7vKSOQm0TgIW0YNbBfL3jxCqc9nojIR0mTFbc7eYo7SeEV5MrTRTiAwxHCvhIgheMkeznhTuHWMn2tmMtuTuS0elRB4aEBn9my4r51YOUa+wYt0y02UzWdxvu+XBMwUsAtJpXHecvn+w2ZCbcJ6Xf/MAu3ZrOg3H4031o7yeDOleQiKifbgHueiuQLPyjfLc5U9zcL7QTlbcrPF91AT+oF0HVYuljBEo5vsNn1YYwSdqrSzklR3Ftr/WBxRAnDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKDWKLTdLcHheWwzr/ZTcEIcbcggLQ9Ac+sPpdA4prc=;
 b=FtkhPFsPtIHb2/y75ztjvmkN3njV0tX4CBWvyHfCgTvTcxZTQEz4AjcWMKqomCI0xSDzNAcq/zX2oyU5D2MC4dis3+RajWvGkaTDMtLmVYZ5keVBf1fhN5xiI6e/Fa1r47rfopk+PokRDS2tt/HnuR2IRIFjGMs0oYQx6F1aElbwf9SGtllLwS5Wri+hp8nSeTnP7hb1wEZq/E8NQ2NvhPeSjOdcVxvLLcer8uZZi81RUDfMnsoGuheTBESJUYbyfSAnApllbwZQioKQd8rDxomj0SL4y+mKnUNyTRZU6vQgaL9IAjiz4hXnCm420ZX5PLqMZBvDD/0VvQkQrRT+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKDWKLTdLcHheWwzr/ZTcEIcbcggLQ9Ac+sPpdA4prc=;
 b=Vmgqn41DP3jsN22LAVh16CQZ/z0L+/ognKBeDrt3BxFuLY6jwmdCCAbU0mE22oE3c4BlV7gNit3t0zdUbaZHGQpyuyUgl9QhO1xlmLf7XqrpMbi36TBZ7S12ZZ+hMXkxcAqmcZlbBPClcTdFZa0+MqtTamKzlm97sZvujB2Gz+k=
Received: from SA0PR11CA0194.namprd11.prod.outlook.com (2603:10b6:806:1bc::19)
 by MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:54 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::7d) by SA0PR11CA0194.outlook.office365.com
 (2603:10b6:806:1bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:53 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:44 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 07/17] drm/amdgpu: add profiler/spm manager initialization
 and release
Date: Tue, 24 Mar 2026 17:20:20 -0400
Message-ID: <20260324212030.822932-8-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: d024e2a0-6a91-4aee-18fb-08de89eb3b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: pw9ZjoQwyI+vZlz3B56bi7Q4U3oTWVtHygufEQ8/3wlE6eJPjituGE11y2VRFfjdW2U+z4dSrn9QSMyub5yp4dUXtmF5LzOAn1uEX9nslKubqCiHMQ6T/BjhYNYC/wuJL7VgcRyfZQdCcpE4gy+wU8lBbJbsZrFovDx9f2nrvNxr5eLQOJCwCPbCjwHIH3Z69VJk7QTEL0sfH3XqqEK6pXt7cIaqehVdCUNNshXxeIO0w2fTktn5j85hMNrbnrrK7Oo82jpqUEqDh0ZVbkQi0RVJKltMWVrlCRB0+GRCo3yF3EhQQPwHLzDBU1iFWZDoLVzLX+1Jv7V0qLUg3+4mNzWWStBrDN4nUAlbMSJCVVmRxTriK2l/apUMnmWMEtd4QFeTa3pXpyLQO9neVTfLUrdrwBUBUt9bExSp6fCcd2Q+fWgrP62oL6JuiWpTXpZsHpwF+LsLfZ0tRfZUEeBmEWrdBuptvg27Oaxg1DRONCp5bP2L07FsdgI0wrCXn/QghTyJaeE0MPu3zDfYNzWvO0RQXFzN9flArQF/k9EZM5xWHLUOxvDgUTVbrqDczk5SNqF0EP1lILIwaNRsSG37ynQ3VT8qi2uDatrvzXc8JQ8otsdjoLkaRNE6jcCeRN3jbU1nBQYQuC8igNgEyKpKG7Pl9u0qnexzQ7khsIp5k8pcagqoBegTOdrnizpQi71bHIpcTNwpkfYghVdRhYaktm1jWWJkyYOQJPxxybIaSsnxMslPaKaQkb69TvvTnLaPeZFbkW3iRxSMCgFqfGni/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W0SeIhuIyu7FBzxez6KcWTUyTgh4O8e+0ds+JcdCC/1Oj9OBnIzdL9b0AxdEI3rqXX8SV1i+r6vJd6RfyLrcCboAU1rSqnqFZ2hgQWvYSJNjrTe4r3XKTY9D2X9uFdfpP2g4CSjcUG+qQzkk+Z/Zi3tbL/meydsRCoKUKAypEeZBoChEpPTAGtYkLkjP8hz6H+opSC0XlmrmMREbff57lfngkoxafLPb8b/VycvGMKuGVuZoxAs3RfS4YuOE7AwLMFZd4dUFnawXt0hY8m7OAEg+eVqrv94gwHtXNjNE2dfo2rKfrtvQ8Dw22l9Y23uPhLkCJhKJSj7hXOlPIjk6IorBoxazZlg1bi9twGiwG7xfBRp05Oojl/IcrAHNwIH3fs9WV6uGmS94eHoEHTFN42KrVDa3YJYy2FTF/N941F5a0r/zdr84rY6TtwCgwlOt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:53.9435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d024e2a0-6a91-4aee-18fb-08de89eb3b66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333
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

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 62 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      | 34 +++++++++++
 5 files changed, 109 insertions(+), 1 deletion(-)
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
index bed43ea8bcc3..d462d99dc8bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -82,6 +82,7 @@ int amdgpu_profiler_mgr_init(
 	mutex_init(&prof_xcp_mgr->mutex);
 	prof_xcp_mgr->xcp_id = fpriv->xcp_id;
 
+	amdgpu_spm_mgr_init(&prof_xcp_mgr->spm_mgr);
 	prof_xcp_mgr->is_init = true;
 
 	mutex_unlock(&prof_mgr->mutex);
@@ -93,6 +94,8 @@ static void amdgpu_profiler_mgr_release(struct kref *ref)
 	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =
 		container_of(ref, struct amdgpu_profiler_xcp_mgr, ref);
 
+	amdgpu_spm_mgr_fini(&prof_xcp_mgr->spm_mgr);
+
 	mutex_destroy(&prof_xcp_mgr->mutex);
 	prof_xcp_mgr->is_init = false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index 779cfe19fda2..ea62a4dee364 100644
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
 	bool                           is_init;
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


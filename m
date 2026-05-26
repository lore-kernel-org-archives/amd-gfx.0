Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC05CD5BD2
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B0110E68C;
	Tue, 26 May 2026 14:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2SnxW5X6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D0B810E671
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MspBKERU1et/sEZQZF/W4hsw3/ms56rTWw1Ok7EMXggNhxj5VtUrH2ZOcYrb7Z175YjB/W1nhFZb9LJu+lvF9lbCn7p3TJVCZU56a56ricz8OqS/d6WeJWIQgl03n+77R8UfsZl4+Bp8tovCtm9C6KIS8roTpNLFelbuqItp5BDvF5mcURnFFrO95B/8mVvQ685Rur0tZCSIwA7jcjeXVKmZy3zmjA+3kIudbRBcH5GUw8Ylan8nJw55ENCXH80UCr60KTsb1zM2A6ASftgI6Q92Z03IWqmWE4KWC59xqNksD/9d7YZ4nhCPMxS2b9W1ouUO+Dpcad84XVW61YnWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUFgZC9aGS0UmFonu94CrfiMx3Q1xmkUWXZKJ7edHNs=;
 b=KL6aX/I4Mwa66mquJFUQGFMJ9QOmtISTxyatmOLycMFke4DlnqvEIpg03vKkvgtFQIFclMjd01w82AVBYMhtyAuPT55dAbdE94NhVg7fS70f8yfICto/sbP1JuZ2iIzSHMkPQ4bxAXQiO9HFBFR5hyNkOH6yK1+HK/tqdyAhQq5Y7bqkj+xx54IjoU911vjqJX6yRJXfXalB4/nMwxWnyaYM1u6H+pKD8+U+Wtu1QG+INgjfG96XIgaANXfKEWykKrLtzhMYcs69wcHz+jxuJaCXlAhEO57myPtGUzZao4f5tJgOjCymBGt7Ff9T2V1nAxCnTSFpjYm5HOEbhf/sLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUFgZC9aGS0UmFonu94CrfiMx3Q1xmkUWXZKJ7edHNs=;
 b=2SnxW5X6SF0dhWm4X9e5yyQ+0wgsKSJuU4ro5dA+ledg+b/fsw3t8ABtXar0yLky8rYOiqoKS45iyiIT8VO46KTGWKpWjN2yYWtTDQK5aEAG/x5h2hPCMPSFwAyFIWQRobHGVOFV+qvMv4bvA449z7jEwFo/GEGTZhXgRQT+Y6Y=
Received: from BN9PR03CA0665.namprd03.prod.outlook.com (2603:10b6:408:10e::10)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 14:11:57 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::af) by BN9PR03CA0665.outlook.office365.com
 (2603:10b6:408:10e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:11:56 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:52 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 07/17] drm/amdgpu: add profiler/spm manager initialization
 and release
Date: Tue, 26 May 2026 10:11:19 -0400
Message-ID: <20260526141129.592886-7-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e45595-85d9-469a-910e-08debb30beaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 0HRHU7QrOF5P3RiWAZ4TF9ujwSa55ljDCjVRWeQY06bezTIzs3YB2e6xaOgusFLsmyRcJIFADjvlq2RhwRxAdgklvzBp5Ca+AYAeQuQ8lUFgf2/S42HAR3Rtnv4gC1+/DUf6IFvU8s+SGqTpg6SxplgCXqRO7T+B0mJkTiOo7hLs1b5lcT8UhbTGXHW2X3lkiF6txLU5RDNe4DhKugJ27bQxqb/bRgkrkOhsitcjkZBmw834WqNzijPLL0fyE4HUpa0BHJkabs+3zYa8heHY7+RdRiiZHH5o3CEvVwTgqDAAosqEPHLQdFoxGNtqx77ZaebvDk+EOlIHnvLndChPWo0GrAKV1T/pfCvd1iLWKToh5IrwgifBmDUa7uPK79RoW38eF7ESFY2igO6VNh7Ew1gX4PJATk/+rlqxduojst7hKmNoTjw0OQKrjFrF0q1UpfAWswQkbGttm3Jq5HK5TAB21L5/xgpL5aJb14DfRYkZWpRhSTq74u+s8iUpnicBMTrA65M6MH89L+TaCgsKhlQOTxa5VxWvgTeGokYuZwJ5vkgoNWjtxDoGlenUabBPKpaoLTeBwrZdJpqpt0m8cHLmHXcrITGGyVGFHRM8nn0nWy3B+GaNGjozf/UNE6cyI4h45Y9ModR6rqCIirhWG3S7ifUdxBd6tc6hGQHPgboElf4iRLbpcZYxcPYL12ZddJynCPeQEfqRez7U16GJR/rvq3W8S9cFIS/yag3QZAA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZLclWRnTPMogWul1qv/cEkEDtK/gY9PrPleoead6Ag8SmsCUfa6F2N30Ek+zYOzHv1uXGhj/DnYLQ2wEayvsOjgqj27vOqYRGdjsyIJj3xh0scVNYsaE6vq8RgJuGF5vWrNpcK+nK6bLqvcYdS9cQ6YlAvC3DLhSNebI2i2uWJ0RrxE2rSst9nWTZNUvN69iq8Bs4oKzDZT+VakVlcnGne/cs3tnF27rHKNOLrhlXIro1e61P0xgxmbtRLTK2seS/Tr6mFtHlJYzF2wbcX562ZkZnigFT5smU6/SO1jxXaWcRB3sXUzDUm681YpZpSo4LUfANtsqlEjvTldcnvcxL0usX8tLPBtqDuSO5jolelZBZJdMIDyXsLUENINmi+PcQUDFExxLmTy7u7qZgocWVRLw842OKcYwqSHYUG3TE8Pla71sL2vEebpDNe4XVGxx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:11:56.4453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e45595-85d9-469a-910e-08debb30beaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
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
-v4: fix mistake

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
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
index a54869a20e73..8d474005f56c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o amdgpu_events.o \
-	amdgpu_cwsr.o amdgpu_profiler.o
+	amdgpu_cwsr.o amdgpu_profiler.o amdgpu_spm.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index f40d8de6771d..7ea3c57ccd39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -82,6 +82,7 @@ int amdgpu_profiler_mgr_init(
 	mutex_init(&prof_xcp_mgr->mutex);
 	prof_xcp_mgr->xcp_id = fpriv->xcp_id;
 
+	amdgpu_spm_mgr_init(&prof_xcp_mgr->spm_mgr);
 	prof_xcp_mgr->is_initialized = true;
 
 	mutex_unlock(&prof_mgr->mutex);
@@ -93,6 +94,8 @@ static void amdgpu_profiler_mgr_release(struct kref *ref)
 	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =
 		container_of(ref, struct amdgpu_profiler_xcp_mgr, ref);
 
+	amdgpu_spm_mgr_fini(&prof_xcp_mgr->spm_mgr);
+
 	mutex_destroy(&prof_xcp_mgr->mutex);
 	prof_xcp_mgr->is_initialized = false;
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


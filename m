Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6D8C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EB310E6AF;
	Tue, 22 Sep 2026 09:34:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NYDLVPgv";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED84810E6AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p22djBP0MOUEiVKFiajb1mY6s7G6LTqbUw5hFjQR9KHJSWBkNdXZBPdIJRfvVQgQ5aXWMl9bgPBcG3V8Z3zuiGFrJL03HWFu/bVGk5BL+mq8fDbIVghYuS3rPPXOtkNn7mtkBQ6sklIQ9l9UCcp0xFUBQQCKtj6X97Fc9NQGBqou+iRPdTx3OwNiASM+XF910Yy+le670SoeKDsAuPmcq4X6mScxeW8hx0rauGuRNg/aVpsPf4E01CixR42+VTBD6eyMARrrjx4ez+2GZJl/xej1O/MGMQT5RIM7QHFHsl/qWc37/nZZa4YRBTpWLXK2vrpcM7U72PalnvvXhIDQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utmGcP0jb0s6aRPUavMguM9+9RFYJR9NAdF/i7FP+Uw=;
 b=SWhgV/eNyZD35tydZN0zTPZkorAxoWgneZM4O2SuEqC3y1EUR5iOt75DzQdY1oewJTzm8NneqIuaeo9VUPdlkb8KXNfGfY5XtD2QzRXGhsJLMjc67o8/Ne7KYNrd9G8D/E1844qMCPHvNvTQEs/q8ciczRQUDTDrPykAqqyJLXmUvIc8zEVG0H1PLFB/aZnny5NlMWHieadHVzHUX9Lom+6GfyGVCPW4pXK5yBpiBBLTrAnEcTwsBISuznXYhlQXN0XA8AAHnTNiP74w2fFca2XrDZJXTg6C+F8joMcFasPNyCI/qvn8kSAEaliMUccvXYqlvHk2Yz/LgwL4eqZG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utmGcP0jb0s6aRPUavMguM9+9RFYJR9NAdF/i7FP+Uw=;
 b=NYDLVPgv8NfRMnsxXUhu6wy78e8jGdrW04s+u4/ssHeWrwW+JnXDW1VZuAvFUxGWE6OGHbVDbn21kwI9NUQPmPGyYldXAXiSjw/Q7l29AGSDifzuQaxfEo8gUYteeqeTqy1jgHPpsgdkithGxjhO01djvhJuNmP4i2Xz5Djpz/E=
Received: from BN9PR03CA0546.namprd03.prod.outlook.com (2603:10b6:408:138::11)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:34:11 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::85) by BN9PR03CA0546.outlook.office365.com
 (2603:10b6:408:138::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Tue,
 22 Sep 2026 09:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:10 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:08 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 01/10] drm/amdgpu: implement PMC ioctl framework
Date: Tue, 22 Sep 2026 17:34:27 +0800
Message-ID: <20260922093436.596947-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922093436.596947-1-lingshan.zhu@amd.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ef01b4-5ef6-4267-be65-08df188ca85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: i7XPNMAHFUqvWcdgEC+1HvwkJXRKoyZYWUmnKCAGnLJJeyzbG1/zPTLmiYXunRY1RdkPjCNGmh0Zt8NEN3+s2BnXGqpHIfb+DPp1ixImbww70ImsmRz8FJHC7ARyPKnC1Ro+USZJ0yQEha5+NZBS2XXorih/cOkNln8Av6CopUI/tODfZ/2lBc2Dg7TrQxVNnnQ7BUQP/8TxeHqNm8+/Me6lBCWf6e/lEyPhVJV9RNsdCHmsYEvK0N9zcLRvA0aDfbJr3HuIcoEfYCezXbdcSQtAE15+dN3p2yp69Ysic+MFMd428ZI5ZnjQVKQhIdt1WFHnpYnMQEYh9v/S2h/kkykP0fMy5t3uypj39bEi/kjbjnBZk3lIiRV3SyYyQmcIFCQCDb4e8VmU0ZVCiMn52ty0+VizW820bC51YUWIJjKitw9FJ9j/TLrtxTryUXOhXxXc1gq4fNAP5XYzda5YcCst0xefeDVxRfI9nKvfYHyZKpGwHS9NbyLcqPBvsD2G/7mpwtLxLE4+Akw6L+cYWcbcLkeQh9DXsUyOBMdIeyZF/SVSVDVdrfe+fv/fBBW15FRLeCIgrHlcK+rb4IKdQwXAZO+NmLsAtAwvrqOeKTNR/iB/AFOG5e9UnbdRVo3jWWlVOpvctCgwQGNe6DwcgvXJPJRtMsRpI6NZDiglRWqoFLigG9Phyw7MNqT5hK1HCg2/jzEvj09ueU3LVhiKUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BsYQbtbscCV/Ltp/mb2IkoC8bQwZl4s/PjH4XkLShKHF66AyvEbuNV00hFtkjC0h1hGO1zB2OijuIF0c+4kYnoOu/86ExF+/pgvKTJqkpR6ajsZsy7kpwyn2ckIO/XaLUxmGu8PhOSdCkU6xicbgPQhzlallnOaRGwj9vmMJoMi2l6654pcF1T0PrH+8kCni5BgxaVjt221RtnbqWeJFt2EbWo87HcbW5JsLN5WUTjOmhSvIa6N/AAnaAMwDQC3OII/vSz664BwSwd4WlPdMOl3kJplZ1VGCK0dOV0qY+3boQC4k6OCb0dRAs/QPXCNHtF4M6E6/rqdDUUYqpSD1+4LDISTIRz9jQBvCMfsvzWy5KayXiSzZWJ/wVcTyXX+ECW5r79EgsXXNuP7y3e3mwWv/UfSjvTgGyfLTZS1FVJbyprcax/hjnickEhU3izRh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:10.8646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ef01b4-5ef6-4267-be65-08df188ca85c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
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

This commit implements basic ioctl framework for PMC,
including basic operations.

This commit also implements AMDGPU_PROFILER_OP_VERSION
which report profiler version to the user space.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 44 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 33 +++++++++++++++
 include/uapi/drm/amdgpu_drm.h                | 36 ++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6fb0a913e33b..d7db69e9d6a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
+	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_profiler.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7c473f60bd28..a98c4a47e196 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -55,6 +55,7 @@
 #include "amdgpu_cwsr.h"
 #include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
+#include "amdgpu_profiler.h"
 
 /*
  * KMS wrapper.
@@ -3096,6 +3097,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
new file mode 100644
index 000000000000..04902696adab
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: MIT
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
+ *
+ */
+
+#include <linux/errno.h>
+#include <drm/amdgpu_drm.h>
+#include "amdgpu_profiler.h"
+
+int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+{
+	struct drm_amdgpu_profiler_args *args = data;
+
+	switch (args->op) {
+	case AMDGPU_PROFILER_OP_VERSION:
+		args->version = AMDGPU_PROFILER_VERSION_NUM;
+		return 0;
+	case AMDGPU_PROFILER_OP_RESERVE:
+		return -EOPNOTSUPP;
+	case AMDGPU_PROFILER_OP_PMC:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
new file mode 100644
index 000000000000..c27b5f9b3ff0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: MIT */
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
+ *
+ */
+
+#ifndef __AMDGPU_PROFILER_H__
+#define __AMDGPU_PROFILER_H__
+
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+
+int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+
+#endif /* __AMDGPU_PROFILER_H__ */
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9222be9a6d2a..acc63804ba8c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,6 +60,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_CWSR			0x1B
+#define DRM_AMDGPU_PROFILER		0x1C
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -83,6 +84,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_CWSR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
+#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
 
 /**
  * DOC: memory domains
@@ -1809,6 +1811,40 @@ struct drm_amdgpu_proc_options {
 	} kfd_sigbus_delay;
 };
 
+#define AMDGPU_PROFILER_VERSION_NUM	1
+
+enum amdgpu_profiler_ops {
+	AMDGPU_PROFILER_OP_VERSION = 1,
+	AMDGPU_PROFILER_OP_RESERVE = 2,
+	AMDGPU_PROFILER_OP_PMC = 3,
+};
+
+enum amdgpu_profiler_reserve_ops {
+	/* release the device resertaion, only the reservation owner do this */
+	AMDGPU_PROFILER_RELEASE = 0,
+	/* reserve the device profiler */
+	AMDGPU_PROFILER_RESERVE = 1,
+	/* Clear the device profiler reservation, in case the reservation
+	 * owner can no longer release the reservation(e.g., it crashes),
+	 * This operation does not take the reseration nor touch profielr state
+	 */
+	AMDGPU_PROFILER_CLEAR_RESERVATION = 2,
+};
+
+struct drm_amdgpu_profiler_args {
+	/* enum amdgpu_profiler_ops */
+	__u8 op;
+	__u8 pad[3];
+	union {
+		/* AMDGPU_PROFILER_OP_RESERVE: enum amdgpu_profiler_reserve_ops */
+		__u8 reserve;
+		/* AMDGPU_PROFILER_OP_PMC: 1 enable PMC, 0 disable PMC */
+		__u8 perfcount_enable;
+		/* AMDGPU_PROFILER_OP_VERSION: AMDGPU_PROFILER_VERSION_NUM */
+		__u32 version;
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.55.0


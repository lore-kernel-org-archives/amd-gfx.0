Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696C606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J1rURTQh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0B410E5FC;
	Fri, 23 Oct 2026 09:08:58 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013051.outbound.protection.outlook.com
 [40.107.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB16B10E5F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqdZTZXfyuZU4AzdtjHf2jkVeayw+LQWOoKmZtaRgzAfU5tKKgHbSh6allBv+P8vcmYuDGLcFBdHDoc2UUuWSx/S/PVDk64iRWRVMj4kvkpKqMM3ZHVD8QyIS5WVlDPTPsVqKy0cuDMs1kSVP09Bqadq7URforz39L0Z+ZVugRvvxRx7leDU2VBo7jvsTlb46AgLdmMD86xhxKJSMb8Cm9qmgm4qwGwFWMhj+mD0EJ+wa0bJdLmqrZ6eYYnFcvk9wX6wcpgy6HPFgLLiLUJXVd764f9neg2KSoKbjYWPFKlxpualyyG8NzV7jZM5fcOG32yBZD+wESdFuHqX4xc/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIGP6OYOFrWTBNicWfZM7vwVGwcwyRNr4mBBrs7ELRo=;
 b=RCNLhgToZLRLFOsc6CiqPYRrCa79yx1000MQDcKMuwlgsGIBDe2CLvOtzW0CkkdMUpmcTntOf4/nmQV4ZQwLqzlpvfIr83WYr/NHG83LwZSiFObvCy4O0tF7Weom17JlcdKlwMjCVCjTe2HE0PDxqyddRx8U3TYbMQHaXTMZMrDzPIKhvcNdpqTMLjRUZw7y+o4+kOTU6WllQeyYgMaBODOy+KoVTODgGfg4jvcX6qnrRxDuThv5e902snJxoRAQLV/hocec+F1uWZ7CEr86XlSV5aDg2PBNlqJM3g9sX+Sez2Tjlnd08hwdLLcY09PbYoYx81/RZvH7LrUNnvBNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIGP6OYOFrWTBNicWfZM7vwVGwcwyRNr4mBBrs7ELRo=;
 b=J1rURTQhFOgvj/KY2fcVtx4mnXVAnuyy3sKCJiW2n6poeVsEiWdzOdYWakLsKBf63oQfySTr1F62oBhkO4A+bOBxktt32wLpkVW4XNQxiGP1JcVRwTwvIfMi/ESq3vf12eEJPZ+sBBm3Ml8W8/7FOMJPOzI5XD4ILSe3YlOZ0tQ=
Received: from MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::9)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 09:08:45 +0000
Received: from IA0PEPF00000040.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::94) by MN0P223CA0015.outlook.office365.com
 (2603:10b6:208:52b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 09:08:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000040.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:44 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:38 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 01/13] drm/amdgpu: implement PMC ioctl framework
Date: Fri, 23 Oct 2026 17:08:33 +0800
Message-ID: <20261023090845.670581-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000040:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d79028-bdb2-42ab-3a2f-08df30e53d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|11063799006|56012099006|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261009221227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: e9cUrCpTObI9TrGVh+dHt3qDMjwA0XhgDebEdpmxkgIZuMxUL71ICdi64WRBVHYkzondWLtgiMcMJNdTNms/99odXFzaWEy0U1e+WO+noTHcYkoSgWOoWcCKQ6EQVhBE58pI5GTQHCAfusGRJWCO8PRQG+i9tq+eVmWKJ/9qTINRTEbpPB3n7DEGcWntxWJmS9vj8Bbt21OON6EfyHn/ZfQ007xAFF0QXWBhE9xReoDyb93Z+UaYA3j9CesV2UWduNbI6Ckwq16HV4ti7Hd9MtxjRCBi+t0ANP/z7HC5xI2DMwdcstO86PFqhEZFoEWeQEk74NkafVd3ynVEvG3jtvciXmcZbzHBhrETeQA/N04P9pIVeSPKbjF3hnywGIZI/Luzop7gpbqkJJPhGKflVUPRZE4475RYoxcnKsMsEh2oyhbgnV94Df9D7jocttNTpYYaHv2BfSPlZzQInnBRmPjPcKZGZ1c66mBd6KRV7Ujodv0Maqjc2CHWckSv2n1qLKN/WmCPPwXQFwYyaov4Zhik/SVdCWZWZTL7np1fYzPRCFFmFVhKgWQc1kZwj73OrOvo+YG66ZAHDdNjWNqJ0AHUzqqqL/uH9ccgIl6m90os2Uc9DPwOLK+fCzMtR5o+WpFryYRthMXnauKuU8z3SI0voTuQsia7XOYJxmF2XwH0tnJkkbl0Z0ltlCX9HKLCr1QZoQzpsYZ2hlDlzPVfCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +isYyyuC6/DZQdWovbbzJPLQYvlk88D8dmB6ZIhabkkB016BKtFtYH5kKSfKaMnx+1oCwrJ97aj6XK7pMpFpR8Qnn197W8wV0mj2CjideDCPi1IAxKIfF3J0RZyoJfkQYULpIsEfO6W6aMA3UMWq93YscW34FDt8SuUnrxNreqQt99vFg3tTjTdUqZurRk/0aljYGAIfcTUMullI4VsT+05QdaSv3sx2dQTX8Oo2ac+0hRRB5e117SjIfStpd6KePC0O5eizca9oqSoerdclh+t6YFwwRqhHmeeby6VS4DbumKOjcuheeyb4iEcVPjZNWsmVbNxmnwxjBsgCwjkk0ddxaQ+qaDjSmHJDKhzUro3YjfOxR/uk4gj7goVBCve/w8cvCYH6B7A8YrCaWuiZxzQLUzvXp6eWoPfLmF4ohg2a5Htfn9hOUY1MY5UeH/Tv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:44.6127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d79028-bdb2-42ab-3a2f-08df30e53d74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index ec199715ee76..7ce3d682eb53 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o amdgpu_trap.o amdgpu_events.o
+	amdgpu_wb.o amdgpu_trap.o amdgpu_events.o amdgpu_profiler.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a93ee106ab92..61ce43dcad68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -55,6 +55,7 @@
 #include "amdgpu_trap.h"
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
index 9e5fa6f53e59..b4f160d1ded4 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,6 +60,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_TRAP			0x1B
+#define DRM_AMDGPU_PROFILER		0x1C
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -83,6 +84,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)
+#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
 
 /**
  * DOC: memory domains
@@ -1821,6 +1823,40 @@ struct drm_amdgpu_proc_options {
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
+	/* release the device reservation, only the reservation owner do this */
+	AMDGPU_PROFILER_RELEASE = 0,
+	/* reserve the device profiler */
+	AMDGPU_PROFILER_RESERVE = 1,
+	/* Clear the device profiler reservation, in case the reservation
+	 * owner can no longer release the reservation(e.g., it crashes),
+	 * This operation does not take the reservation nor touch profiler state
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
2.53.0


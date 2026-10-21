Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D6606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gAK4qqvq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953E510FD77;
	Wed, 21 Oct 2026 11:09:38 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9999E10E2CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNEWMbOAUDexr1LiPGi0+OV2BjzmVs8BXBuWr7A85zLVuJRBNyTmUeXu959wX+WfSqOnhzhvl9ouUxEC+QxiRlcsViBS5hNe/oGxTVeBrhNE04vkEUu0ehs44/0iEsc2AW6wolQsI10JS/kYUlx/V9AMLY46zczmdvdSlqW25qfkZ0fE1azEPgO9LeEr4d24f3anM9QmsAYNhkozIGc6m1wxXf9FWRtIXIh825KkH9ZqFcjedrc2RNskBCX/ZA7HwgJ52/xSTmxHaasRPKEtJX45TQE66Pc6H6h9d3a6sT2aF7TqyCkCnyVAzzKRGmK1RUqTFU+vctzYYhLKeKgkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTg2aK/6QbNYb5EdWkWXrbHWqe8OIHPxxHs302a9RdE=;
 b=uiEkHxZg8jAXen0ontaNlOi/WehCmi8JrjWFpFLIly/KS3nP00SZPEZIauPj+1LEW5yOZvEfikSFeJ+er/anikfSjBptJAc12HSeIh7But/g+0szXEavVCKof0lDAY+NOlijB05mzL7AG6CFd+fkpCUsLJ/SHei9amWXLjsYM1lpIrr1bZ+VvsM20Dh0rhsKM5mrpkKiLaAvV+AYGMc/DSCFbOjwyv/GQQyvtNdNUpHts1D+Xa/ZM+i6jp2UBgfa/qQmw4i/5jcLrNqkCZ8QrZsK3j90aNmHSIfQks8Ig19WPVZKJr3gwt68qxHrV2p+O6Tilg0aNaaitgUIcf4z8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTg2aK/6QbNYb5EdWkWXrbHWqe8OIHPxxHs302a9RdE=;
 b=gAK4qqvqqsLxDkG9SGLJ176k7w2WOTXO/nA1TZtkIe4lRCMXh6v3TdrzRXk2dcE2YSMux0pOjwCNdKFl6bznTuJNxRuZmFwpniKISvoe97EKhD506MWpHoqrc3sXjij0wtfJrHJ2fy/BdKAZEW2TwgpwLA02WoWqB2C4BVlzkQE=
Received: from BN9PR03CA0533.namprd03.prod.outlook.com (2603:10b6:408:131::28)
 by CH4PR12MB088503.namprd12.prod.outlook.com (2603:10b6:610:50a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 11:09:28 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::5d) by BN9PR03CA0533.outlook.office365.com
 (2603:10b6:408:131::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 11:09:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:28 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:26 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH 03/12] drm/amdgpu: implement PMC ioctl framework
Date: Wed, 21 Oct 2026 19:09:54 +0800
Message-ID: <20261021111003.3371005-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CH4PR12MB088503:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d5ee78-d4d2-413d-2d86-08df2f63c654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|3023799007|261009221227099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: N5ixMInlFKBYuo7UMJacbGyXiTduSug59e+AMobS2+HR3NYrGwrXBw6WBbBNy+K56IKfi3TcmRxXvfvpySas4mN3Myfn0JysNsM7v5lDLU1DHhFkFmhBNSDs2k26yx1852MvOH2JeVUM6r6H9w+4S/SyX4SphtLSuRWg1C1RGEDbSXhZ+rleleDtqnoE3gytqTExesbme5YOYJFMIL6/n2skP/uN9UpJh+2c3cdHui8l4S1unm6LtL12Tv3Jhj8Q9zPUr+u+kXqDX+OGpgv7wUCRve3PymsYTidD9CebQ2ATXgOVWuLDO4ZVimg8kZYXQnlDf9toq9TT2Jp9j3nEdG13VZMZKyMo9PAXA8qflz88IZPU8PV8D+dLJGUC8tXTdJMbNdeFU6dgaBlOPXrGEUzSpjNRQZno1/ohFEL7Pm+1IusjodmfoRIlftxY0J18iJPtrX4A4ZwWqTmxooQ0lx+jPy+Na83JGt6tgYD04ORry89hmtGck1B2eMNHENSqfIHIi/rqHk+ROFDisAqhy7BTzI3rTSZe2v/xaXVDrA0eLGjEo+6qnWIrIffWId9u/ZN2VL/G4KO3xdAgOdnUPRkt/AAoryZIf/FYyJ/+ncca7rtr+zyNrtabgBTu94tEjABghKaVJ5X4gEaknTGZId+Lw2xD0bZbum/71cyF91BUQQY3TcZycPaZGiVdh6M1DeVOURg0G56lJUxUAjzQGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(261009221227099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9t0/JIlAURiTpBTYqWfTvXvWKFBqsHj5s7XTv0TMhg7KtsiQnrzq0S3Aa4YWWlfbM+Q51cRUfjqhZqZCDsaATsqGFPlNA+4bDlu8ylEl37zL5Nwt3H3CxxySqOpcPLr4Qi+sVYz8SDi/HoFcU+orFGN/w8tpI7jvkSQ6y5t90iCilJk85uZDToAZ7Fe7rBgdbcc32hHN2toC1YCkkWCyoxMq10Ukua+BBL0CLDtUgO2WpdWfO2x+L4OiH8dsF6OAIRD407V+lDNinEhg/Iu8cIpvs7YCbNEquLKm/YXuNMaEiElt4Dzez/tJ/UmniACf9V9Qiy/xpFVhZnW+cbX7kHzK7JNoIH/DrERBbwBgBmnoY6e+y5JgM1iGJ4BG5HXLB5CEoX9D/w74RtlKH5gS08s/OjdZupprOTzaQkbQKkAlC8GuzxlZvS03I2JQuGbi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:28.5151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d5ee78-d4d2-413d-2d86-08df2f63c654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB088503
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
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 44 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 33 +++++++++++++++
 include/uapi/drm/amdgpu_drm.h                | 37 +++++++++++++++-
 5 files changed, 116 insertions(+), 2 deletions(-)
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
index 9e5fa6f53e59..283d56a0ef0b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,7 +60,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_TRAP			0x1B
-
+#define DRM_AMDGPU_PROFILER		0x1C
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
 #define DRM_IOCTL_AMDGPU_CTX		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CTX, union drm_amdgpu_ctx)
@@ -83,6 +83,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)
+#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
 
 /**
  * DOC: memory domains
@@ -1821,6 +1822,40 @@ struct drm_amdgpu_proc_options {
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
2.53.0


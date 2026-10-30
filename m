Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21856606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pOAJTN35
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A897910E83C;
	Fri, 30 Oct 2026 06:31:16 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012011.outbound.protection.outlook.com
 [40.107.200.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE3A10E83C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEEXAYx0By5JwPqNh/HqSjsWIFq9ENjGSKufuMAzB+Z4TawjInWg9ZnbpgXEgsdkVnK7Tbs+9VUxPV7yDPpI7aCNZHd2F50j8nG/0IvdlfEUrdG11GUVFCZv/DuOZsUu2/D/w950m97RivyPbXq42pHm/iteDIdS/r5yb5iPoRQ14+bxBbjZ/eGUaT9r67IHbOIT8O49/qaY8IyJrVySw7OuIs5PDNHvVY2bX121lnIqYXRpLCr2UVgfc1w2UIO1Sq+ACvKmtVSdZFo6xw5mMCGotpUee5udKqmsckLXG7xhSedfHhIrLkkuT9QVljhtKz19RQf9Ofte/tzQ/1FCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPZPduaY1V3zmV8/Z5Jhuzb5TwhEc4G1Y+jZRpSEHtQ=;
 b=qz7vYYM8WF4zPdAykGxk6l4DA/RqWFG7SxdcPVeYcMLUH5Cy6yqU/vk3gjzZKwEQUCFsUL7hK1oMtEMHmuQQIlA6X2L5JJBcDdGrQHnd0GnnGrdP9/bOjCmbLPrh0/vP58IS9ofY6mGrsBbhiYTyLA6LnvMM3aCf3vYiLTSCkzbVbWzcT0y7rvhwZsLdlhrXaz27OXFaOal4Jx1qzDMhv5ivTSjO2ABXSdiTy5kQZRWKVO5Y62H16dy4vBAJR5T+7hHoxvnImItIXrWaefKdUYVnmXceRyChh6DSWjhFiHXhy5xLD2AFGErG1YV/QUcJfu3K+YB+XP3owvCxlKLTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPZPduaY1V3zmV8/Z5Jhuzb5TwhEc4G1Y+jZRpSEHtQ=;
 b=pOAJTN35PFGdQ9SP8Xn02dYkklT1V1E+gK9QLyngIwi+KEOpQtZDVvMvd/1CURiKJqSgshs+0Zog2fRynw7K8w5BGesMWOw8s99Xtj7TZVVD9jAH43enfAJhnwfJ0bFwAtX4NnttOcF03KR5yogQtugxFz8C1xM5yKgJLGKzVEM=
Received: from CY5PR19CA0019.namprd19.prod.outlook.com (2603:10b6:930:15::25)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 06:31:04 +0000
Received: from MWH0EPF000D8953.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::5e) by CY5PR19CA0019.outlook.office365.com
 (2603:10b6:930:15::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 06:31:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D8953.mail.protection.outlook.com (10.167.249.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:02 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:00 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 01/13] drm/amdgpu: implement PMC ioctl framework
Date: Fri, 30 Oct 2026 14:31:29 +0800
Message-ID: <20261030063141.2773032-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8953:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 6824a630-f864-4ab6-57c0-08df364f5ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|56012099006|11063799006|261028144727099003|261026121527099003|261026140227099003|261022115727099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261009223027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: /L6irRmNpIdM2rMjSYoge0GroPeOv+5WAz9a5Y/hANvu2XooEFkrFaFC+7joKypkU1xfoDE6UwOCOWXcKfIeT+a9c83bSwckD0tK1UF4xA5kGPUA3P+Q4W9slhsanQvEvYQ8rLjcZ2UuVESRJ4x3Dp5D/DPuFoMhmVQcMDzXrsK3I/1/HUNYBj9fp4pK9OR33feTLWns5oh9zGP3YpgqWFvaAiWVglSxBuq6lq2MR0mXpVKh0IAvDNRkaHJJgfKP7z4iJnfUFFpb/11BqyBBgow7KZycSvZQ18jCcQdsXp89q+KYWoCoPM/nbfz2JIz/FaODzuyo4eNzYRScsuAf6u0KV+03BEv4RnfAfyNuETjB78J90uPL/4/Tsq1ws9xrcpCVBnvCx16VP7ZfNMgoq+F/08baQnRGak8SIPI7Q6DkeylWSt0rRO1A1saB1g2oDoRsAC/DzwgY1pBF5uStjF6+mvy4mZE4ueM8awL2e2X880tu4ZxuwRZphknG7y+pF0c6WmbcA3hAXbm89B1XM0vEk0oLzlaGZe4BfjkFjbOobPxA8mE7oOJk/pWbJ+q3R/wuoLiz+VGubKwtPAPkeGAktc3AlUS9Wt4kasPMpzMNKXX8Vc+QkJhS3LHuMAl4uVWcLTvfy3U3YcUlEETGeqwV/EvQ4a0tKAyT0hEja2A8tl7gMiIWibJUCzZ7b8WQ2L4w+SaE8npsmuXhpFwceg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261022115727099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ytt9HI4xeFP7ORyIVWcXSDnMB7si5vZQ66W5fgoV/+ehvjTuFcLWty7HEwtiy6wgc8VlnYh0OwHNQQpsBxpNWHExaVkwSh+gt3ZrBO8gsTGmVO9YShCKztpQu6a+JSFR/4Qa5Nz3+zwkJCmOBSesXppPKYLWUtsjCJNpikPQWtjMude3Acanj4yEXtmAsp8NQM9Kco0L88aWXYrs3OT0VZlABZeKqvIG9/r5eLreIyiBEOb4Yz8RnlZB8sdoRVy2fajx4xvT5D2z6BRd0ynsoR5Tts35lrGAMG2KjBgFnUrcCpkES6PNVZAgz0w/Wz1vcJgN5gOyVpxFT/kmX9Htp5J9FYcd03rhGkWfHgGgKXiCSIlR45Tcf7DvFGVbCNaG/k8WlWbI0jhLSzUMHTuP/I3lBVzGtNvN2obA10ZyhknmuzJZ/fNlRmTDF3Fl1SEl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:02.8851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6824a630-f864-4ab6-57c0-08df364f5ec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8953.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


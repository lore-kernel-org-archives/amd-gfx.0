Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BF7C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689A410F6CA;
	Fri, 14 Aug 2026 21:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PTpaQ2Em";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E32A10E5CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDKkXuQFzlJUR0/AGGN0rPq0A52CfWOXHtLergZj9HyHUCbZPASAvlhnjNW9h3RH3/lWNfyzvz0fKj+zDTz5curjtsP+CpWdtlpNS3jFto9oShbiUxEltuhyY+Zbq/DMwAHlE8DVLfon8/i8HoGnkstpt8osV9PJWOuI1+HX29piES2cgmh9o2wQaPo5ZbS6e4vGqf5gu1ZmJIRQKCUBpynplGsE1cLqorX3aS2SmwKEszD3AuRnhR2MrnzQEu4nnaoMJpM7FHYbXVrXLm002Aj5jZZW4q21vyWWL3RdXV8CQlW2OyPCvF6r9hfIFYMJRIXMhj1ARxJv8OU7FZ/hWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGlaXFhAbwEBDuhpBDVcaCWy8j+PZgZFvmrUugKkbPA=;
 b=uXGIOKP8NCfpY2JUMcuCs/dD7f+4o/S1/A3eSKCB3+UtOIc1A7sC6Xb8WohGN9q3nv2dq2aJlby8J6bPPn6OGcdpgSGHNlA1B4qbBFl6RP65g2YUYDCBTOq7IMoTSSxiRDgz6NoMcnThCieGN9i1o6yDnr5tpnjPPlr7qCKwhqRiZQBOFJA1mwf0d1NUiukQ+OU5ES3LImPIOj7r+OZFVB4fO6grn2mBff7KqjJokyO0kiB78Poyro+IRvuaSi+S4+sqnmEluqCTd+EmRoixo5aoURlvXtJStC1YXSwD7vLf7GQg4rhYA8tKnlqubWNJRQ2eD2+8CUumuc+4pJ6sSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGlaXFhAbwEBDuhpBDVcaCWy8j+PZgZFvmrUugKkbPA=;
 b=PTpaQ2Em5wNGsUnqNPiuRih7qFYjKQtZwqVQ9nxnku4020S2Zfd+LZVqJjJARdtjMBFwlTA9l7U5J7sea83IJGjYYcu03dvfOmy7ej05fGIse6TbXTjPURibOH1stqwH/WLLAh7SHINjy4O5ZNz3ZIyFdcjg+W+5olBRT/RCoII=
Received: from SA9PR13CA0069.namprd13.prod.outlook.com (2603:10b6:806:23::14)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:00 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::45) by SA9PR13CA0069.outlook.office365.com
 (2603:10b6:806:23::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 21:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:02:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:02:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:02:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:02:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 003/109] drm/amd/ras: register mce notifier to obtain ras
 error info
Date: Fri, 14 Aug 2026 17:01:00 -0400
Message-ID: <20260814210246.3067612-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4f6773-2393-40e9-1854-08defa476c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|10067099003|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: mhe/AZv9lQ3R6n1Lclac16F322Ba9/mF8q6nCEflCev/7Qa+MNBCR4YLUQGuPeekkGqe7zwEqeVeyt/rTA9SRYt6kG6B1ggea4s9EtyZCWnz6Kpn0J40IHJDvcsYm17mzzQYx5OLwjkOEkgyf6I0pWwQZ2WB2zi25rAb5YdOVZSxFwwEYDQrVa5+3akvUqGGsvxzpQdXyCzqhMsUV/Cq1s2+zIvO3W1eNg62T+PobJm3DEXVVpzo16b0elBF0wv5RJ3A31aQk9bEnOuh3Fql/Nf88Ez/XZA1xC9T5LQL+SJlqWDXdJqATUABtEPo3qDWWMVbYRn00f2vxDvLd3yPUCLF6tdkQ55ZoofJquRQf9XZyLV6lMzUsi7WOpE3r4csBzQnP/Y32jQtaQCzA+dUKgB8L7Tt3WtOiJdQwf9x06XmGN0NQyYgRl7rmdaTT8EqdV/+mq6hO664IZfkDDdlVFtDSPzRPZ2tJxrH3hbTIAABPOTxudJqtWEPLU5Oe3TpmpMfs8C6hsMvYos094FA7Y+XXBHVwBQrbYm5jb7Bxx0HrUqcBe2DaGfxRoLNWqcpgc2ijGQNPHQOfCjSk3K8Y8itd4qyRTC5+rfWVnBKWuQnf+QI5k/CweFQfBRm1Tucg1/BV9csEf45X5DeG3TCqTfLJkm4Q+qBuy+sRflvNMV8QPjNOI+RdhA7cG6LSZcw1DztdrdxLhx1FMq/Xc64wQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3RKQULAq5baDb33m9QtPZHuAzTi6t7EqFRro/qBLNWe/qZlhBg/N0F1O0Yn8t169HJ9/OdS7HrcvHSM+qFYp6XK3Mtk/tDHdEeDyjVMJSoYNtuczTmNmcaMNibPu73CabOR6nzy074XQd4DnDOJSaFvjGNxQPVIcqyX4K4uemSZ1a+MzhvgecGmpt/n3YXX/jHiIwsbj5DwhFpBbn/wk1xZ3OsOsm/I6xKHNCmUwCjQGe3qJiXPmC+CZ0iUTY5pIzcRvYrcrSJvKxGwe7ZCcSE0MMBtTfW822VG5BuiOFQQ5Qu3+wMqjQLs/x90bT2I1tIvqFPGYUXVf+bNcBS08Sn0tPHiXF2Mh19m5vVVhrJcYmB0+esNudtIm57NQNzLBaY/pQiILRfBBZD/EZPiJxnt99kSXcuPvTcGPcSJBs/00fBsevQ404XM5wEGHNeoq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:02:59.8180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4f6773-2393-40e9-1854-08defa476c3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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

From: Xiang Liu <xiang.liu@amd.com>

Register mce notifier to obtain ras error info for A + A.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile      |   3 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c  | 153 ++++++++++++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h  |  31 ++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |   6 +
 4 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
index 6759635aadc26..70649c49d1ff6 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
@@ -25,7 +25,8 @@ RAS_MGR_FILES = amdgpu_ras_sys.o  \
 		amdgpu_ras_cmd.o \
 		amdgpu_virt_ras_cmd.o \
 		amdgpu_ras_process.o \
-		amdgpu_ras_nbio_v7_9.o
+		amdgpu_ras_nbio_v7_9.o \
+		amdgpu_ras_mce.o
 
 
 RAS_MGR = $(addprefix $(AMD_GPU_RAS_PATH)/ras_mgr/, $(RAS_MGR_FILES))
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
new file mode 100644
index 0000000000000..991cf39195eea
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
@@ -0,0 +1,153 @@
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
+#include "amdgpu.h"
+#include "amdgpu_ras_mgr.h"
+#include "amdgpu_ras_mce.h"
+#include <asm/mce.h>
+
+static int amdgpu_sys_mce_notifier(struct notifier_block *nb, unsigned long val, void *data);
+typedef int (*mce_notifier)(struct amdgpu_device *dev,
+			unsigned int id, unsigned long val, void *data);
+struct ras_mce_dev {
+	void *dev;
+	mce_notifier dev_notifier;
+};
+
+struct ras_mce_mgr {
+	struct ras_mce_dev devs[MAX_GPU_INSTANCE];
+	atomic_t dev_count;
+	atomic_t ref_count;
+	struct notifier_block nb;
+	mce_notifier notifier;
+};
+
+struct ras_mce_mgr  g_ras_mce_mgr = {
+	.nb = {
+		.notifier_call = amdgpu_sys_mce_notifier,
+		.priority = MCE_PRIO_UC,
+	},
+};
+
+static int amdgpu_sys_mce_notifier(struct notifier_block *nb, unsigned long val, void *data)
+{
+	struct ras_mce_mgr *mce_mgr = container_of(nb, struct ras_mce_mgr, nb);
+	struct ras_mce_dev *mce_dev;
+	int i;
+
+	if (!data)
+		return NOTIFY_DONE;
+
+	for (i = 0; i < atomic_read(&mce_mgr->dev_count); i++) {
+		mce_dev = &mce_mgr->devs[i];
+		if (mce_dev->dev && mce_dev->dev_notifier)
+			mce_dev->dev_notifier(mce_dev->dev, i, val, data);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int amdgpu_ras_register_mce_notifier(struct amdgpu_device *adev, mce_notifier notifier)
+{
+	struct ras_mce_mgr *mce_mgr = &g_ras_mce_mgr;
+	struct ras_mce_dev *mce_dev = NULL;
+	int idx, i;
+
+	if (!adev || !notifier)
+		return -EINVAL;
+
+	if (atomic_read(&mce_mgr->dev_count) >= ARRAY_SIZE(mce_mgr->devs))
+		return -ENOENT;
+
+	for (i = 0; i < atomic_read(&mce_mgr->dev_count); i++) {
+		if (mce_mgr->devs[i].dev == adev)
+			return -EEXIST;
+	}
+
+	idx = atomic_fetch_inc(&mce_mgr->dev_count);
+	mce_dev = &mce_mgr->devs[idx];
+	mce_dev->dev = adev;
+	mce_dev->dev_notifier = notifier;
+	atomic_inc(&mce_mgr->ref_count);
+
+	if (!idx)
+		mce_register_decode_chain(&mce_mgr->nb);
+
+	return 0;
+}
+
+static int amdgpu_ras_unregister_mce_notifier(struct amdgpu_device *adev)
+{
+	struct ras_mce_mgr *mce_mgr = &g_ras_mce_mgr;
+	struct ras_mce_dev *mce_dev;
+	int i;
+
+	if (!adev)
+		return -EINVAL;
+
+	for (i = 0; i < atomic_read(&mce_mgr->dev_count); i++) {
+		mce_dev = &mce_mgr->devs[i];
+		if (mce_dev->dev == adev) {
+			mce_dev->dev = NULL;
+			mce_dev->dev_notifier = NULL;
+			atomic_dec(&mce_mgr->ref_count);
+			break;
+		}
+	}
+
+	if (atomic_read(&mce_mgr->ref_count) <= 0) {
+		atomic_set(&mce_mgr->dev_count, 0);
+		mce_unregister_decode_chain(&mce_mgr->nb);
+	}
+
+	return 0;
+}
+
+static int amdgpu_ras_mce_notifier(struct amdgpu_device *adev,
+			unsigned int id, unsigned long val, void *data)
+{
+	return 0;
+}
+
+int amdgpu_ras_mce_hw_init(struct amdgpu_device *adev)
+{
+	return 0;
+}
+
+int amdgpu_ras_mce_hw_fini(struct amdgpu_device *adev)
+{
+	return 0;
+}
+
+int amdgpu_ras_mce_sw_init(struct amdgpu_device *adev)
+{
+	amdgpu_ras_register_mce_notifier(adev, amdgpu_ras_mce_notifier);
+	return 0;
+}
+
+int amdgpu_ras_mce_sw_fini(struct amdgpu_device *adev)
+{
+	amdgpu_ras_unregister_mce_notifier(adev);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h
new file mode 100644
index 0000000000000..39e8804f89c41
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h
@@ -0,0 +1,31 @@
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
+ */
+
+#ifndef __AMDGPU_RAS_MCE_H__
+#define __AMDGPU_RAS_MCE_H__
+
+int amdgpu_ras_mce_sw_init(struct amdgpu_device *adev);
+int amdgpu_ras_mce_sw_fini(struct amdgpu_device *adev);
+int amdgpu_ras_mce_hw_init(struct amdgpu_device *adev);
+int amdgpu_ras_mce_hw_fini(struct amdgpu_device *adev);
+#endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index e039249b41afe..8ba6d8d76a5a4 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -32,6 +32,7 @@
 #include "amdgpu_ras_eeprom_i2c.h"
 #include "amdgpu_ras_mp1_v13_0.h"
 #include "amdgpu_ras_nbio_v7_9.h"
+#include "amdgpu_ras_mce.h"
 
 #define MAX_SOCKET_NUM_PER_HIVE		8
 #define MAX_AID_NUM_PER_SOCKET		4
@@ -362,6 +363,7 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 		goto err2;
 	}
 	amdgpu_ras_mgr_init_event_mgr(ras_mgr->ras_core);
+	amdgpu_ras_mce_sw_init(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		ret = amdgpu_virt_ras_sw_init(adev);
@@ -402,6 +404,7 @@ static int amdgpu_ras_mgr_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_ras_sw_fini(adev);
 
+	amdgpu_ras_mce_sw_fini(adev);
 	amdgpu_ras_process_fini(adev);
 	ras_core_sw_fini(ras_mgr->ras_core);
 	ras_core_destroy(ras_mgr->ras_core);
@@ -436,6 +439,8 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_block *ip_block)
 		return ret;
 	}
 
+	amdgpu_ras_mce_hw_init(adev);
+
 	ras_mgr->ras_is_ready = true;
 
 	amdgpu_enable_uniras(adev, true);
@@ -461,6 +466,7 @@ static int amdgpu_ras_mgr_hw_fini(struct amdgpu_ip_block *ip_block)
 	else
 		ras_core_hw_fini(ras_mgr->ras_core);
 
+	amdgpu_ras_mce_hw_fini(adev);
 	ras_mgr->ras_is_ready = false;
 
 	return 0;
-- 
2.55.0


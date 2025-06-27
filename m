Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79080C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 19:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11F910E33F;
	Fri, 27 Jun 2025 19:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sHgZVB0I";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D614310E33F
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 19:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHLxg99qWxe9E+BdSgyrdP3vREO4LRQhXoDgotdxQamRfgnwj3jClndVdFQUqY3H636X3bie6ytgF3ps7BIiZrgMBhEJCrBKTpItVQu8JG85OiKlMd3fKmJpU9blEDbpqn5OhOGlxFoo94asfJwkFl3N26e3BC5mT1PgrwK3+vGJwpD0gI9QQb8WBG8DpnGBkG6KSmS6HsY8z4Mv/JEwp7ID9/gjuFryQHRGKem1fkaNyWt4JXsnzRvDQTNdqJ9OyNwjaGwHVJE/0x1C3KzS2YVDz5tXZw7B7mRdylS6Gqb/wxaM+Thh7Qsvi25WI4aiDMHuas+sM5C9srPs6omCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIYoMbyMSN3wtCES/APWyoxPFBnakT7syVthTVTc1bc=;
 b=bUS3aGE+altI6grWYXVHJRE33JgqUPv4FDWvEBLOJMnaXKfpvpdmDOdXNHNqOIQRgweHSk+qrIo7YFrupzTz70FtgNwqkDKJ0CIepw4Ai66aeN6KATaMXwXRrFE4InNkT4SjnDBunWY4Ek/a5QQLJZeInwFY3cCiebA9yXRgaVnjIf89UFWxWenBlh3dXo8A1pd7y812KgqAJXvhIEUAYsuzAFHyscXQPhAWWzfRdy+cWnqYuR09m2SeJ2kHa6lYwJnVJvrqLIk9cLRiy1Dp/2xvs4g8rLMM2rPaTxzHtFOt+2D8eDadswlwZvkJ+Il4TaPn5y1oX1E4oyx3qDCtmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIYoMbyMSN3wtCES/APWyoxPFBnakT7syVthTVTc1bc=;
 b=sHgZVB0Iv+TGE1rM55H+c9Zpp9PYMWzJUR426Bsdtl6yv598kPZTQJc6iTEtv0XGQ7vqgBdxBYmVVSNlM5oaZhzeRgufUWmLgv34GzDXXaYmfRBC/kTXYoOihg4YtMmlkePVBylkKpnNU3YchthFk7QkqvlyAdE8/8+SE/3Hq9o=
Received: from BN9PR03CA0144.namprd03.prod.outlook.com (2603:10b6:408:fe::29)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 19:14:42 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::75) by BN9PR03CA0144.outlook.office365.com
 (2603:10b6:408:fe::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 19:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 19:14:42 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Jun 2025 14:14:41 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <phil.jawich@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add helper functions for isp buffers
Date: Fri, 27 Jun 2025 15:13:59 -0400
Message-ID: <20250627191422.353939-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 71eaddf3-5545-4246-4c6a-08ddb5aedef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jUwoXpFyDv3IyDWIRCQjKfOqqiJcC3xxvI8YVzIMgEsyAMQmMCybDDmFwEIE?=
 =?us-ascii?Q?LHxu2YtcpoL0TRrPXC4CuBI8YCLm1JUIfyYwV92zrc4V1nWmY3aW/5NDR/Yf?=
 =?us-ascii?Q?iKy/8Nnf7mfQDD2kXX+etB/lUirTCnQedw1blt4QC3mvyHdbblaAeziBB4qu?=
 =?us-ascii?Q?2DCKgwu2zxaRVRirGxKuQqeKf+uWMBiUunu97bd9URKfxkGCLDClPm/kEz+7?=
 =?us-ascii?Q?vXfpOPAiSODE3csFBi7LjZbf/powINJGL91igmXNmtA3xzJrYuqH5xwaA9NB?=
 =?us-ascii?Q?eYYcq1cGTupQmTb5JZcGDpEdMpdkV/O6qb3v24j+yPiRa4aM0xoSHVyEqWe4?=
 =?us-ascii?Q?znv4kFN14t2pjQ5dt+anSjIa+bUmqBKVAHG0KfgPVpCUdFsg7OW0apYQSe/m?=
 =?us-ascii?Q?bAaCDD1gvDy+Agyi0BNK2hVnxCLNEPWGfbUaMqYuXmt2oHaBq7pAIRzYgF7G?=
 =?us-ascii?Q?FX3vQ3hxY3JrNam8ce4+SLTEy7x4OLm7IdytEJ7xADs2cpdFn/tT8kHYQXbQ?=
 =?us-ascii?Q?9ItM9EIgs7ZEnwUmvfo1CY3dVCJbJ5cbKTA4pl3yz5CzXnuLs3ex42jV7+Xb?=
 =?us-ascii?Q?r/ptEVS3EeLtvONHbzMetAr3RptHeY6vqYJT80XsFf68cHzcX3OdqeYaWSoT?=
 =?us-ascii?Q?RRIRWu/YnF++y4uggz4rts+OmG+MDd/sOeSZe5G006TyYxXjNAx0fbUDa35F?=
 =?us-ascii?Q?e9gnKasLfnnktnavOWU+JrrZrD7jZoai04LqX1GavKmC0P9IUzU/+zuWVF+J?=
 =?us-ascii?Q?JS1QSAldzAtgrZCZLd3mMW5rIhJT9FFywEwc4+5GDIHbaCXDGOi4IPj0ptA2?=
 =?us-ascii?Q?4GctakPIXIUP/bAuvJAqIWN+U6cbOta411Xhcrns73ql63DHOWDXxPUg7abz?=
 =?us-ascii?Q?x8XMJu8SEH865DLHFBwQRk6ZRNprVxze2fXklj6nVL3wrgywFBKdSurF6hKs?=
 =?us-ascii?Q?pkSthhMXezmjWgp1YYsPCQzkC+YhliSxs5Q9lUEv9muuSqLZw6gyj19ZiRCC?=
 =?us-ascii?Q?ErAI5TYTaHylyyS5Wt9FsxOlYmxI4Er321Nju8eGVVo4r2bI5hQshkSYg9Og?=
 =?us-ascii?Q?ZMGgo7y8IPpullCY7cqSQVQJP0XwH9fvjGk+HpOQsVZfEneQIOvxw2iD2OJn?=
 =?us-ascii?Q?IDNUAsPTdDzMAHGHgyEZ6RNm8WJtOhfwtHRnDKujS3Rienj/xPT3DgAYx6MS?=
 =?us-ascii?Q?F3oSEdYjppjDaebG7CXbmXZbSWdtmG4u5zGa3NHMw3zofVjO9kLYw+bUGeLU?=
 =?us-ascii?Q?eRtdFG+Ufrzjx5/j09MNZCL1lJJv4PIbtt98rYhITq/4xhto2gasQnkLq8pK?=
 =?us-ascii?Q?6/ISwni7Sei5VPMgfQo1O+zx66+rQ7J9grgQIRhSznNf58eD+0aYGur9TcFc?=
 =?us-ascii?Q?N2FsG1JC4l+y5AxJ5HVF9wPQ7Y0kTHrLL6Qg4+GnVrjAuDxzeACWsqNmZW0T?=
 =?us-ascii?Q?2m+nkyiQoMD8vmsKaBPmuY1gT7Pv5qvBxHdStMsYYMbR85BsLwS7DxEEmasV?=
 =?us-ascii?Q?6ralhgT8Bc8rnR57mW8nlJalbHULBKojX/zp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 19:14:42.5468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eaddf3-5545-4246-4c6a-08ddb5aedef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821
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

Accessing amdgpu internal data structures "struct amdgpu_device"
and "struct amdgpu_bo" in ISP V4L2 driver to alloc/free GART
buffers is not recommended.

Add new amdgpu_isp helper functions thats takes opaque params
from ISP V4L2 driver and calls the amdgpu internal functions
amdgpu_bo_create_isp_user() and amdgpu_bo_create_kernel() to
alloc/free GART buffers.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c    | 75 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h    |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 --
 drivers/gpu/drm/amd/amdgpu/isp.h           | 47 ++++++++++++++
 4 files changed, 122 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/isp.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 43fc941dfa57..bbbca85d95d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -33,6 +33,8 @@
 #include "isp_v4_1_0.h"
 #include "isp_v4_1_1.h"
 
+#define ISP_MC_ADDR_ALIGN (1024 * 32)
+
 /**
  * isp_hw_init - start and test isp block
  *
@@ -78,7 +80,7 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
 
 	/* read isp fw */
 	r = amdgpu_ucode_request(adev, &adev->isp.fw, AMDGPU_UCODE_OPTIONAL,
-				"amdgpu/%s.bin", ucode_prefix);
+				 "amdgpu/%s.bin", ucode_prefix);
 	if (r) {
 		amdgpu_ucode_release(&adev->isp.fw);
 		return r;
@@ -141,6 +143,77 @@ static int isp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
+			  void **buf_obj, u64 *buf_addr)
+{
+	struct platform_device *ispdev = to_platform_device(dev);
+	struct mfd_cell *mfd_cell = &ispdev->mfd_cell[0];
+	const struct isp_platform_data *isp_pdata;
+	struct amdgpu_device *adev;
+	struct amdgpu_bo *bo;
+	u64 gpu_addr;
+	int ret;
+
+	isp_pdata = mfd_cell->platform_data;
+	adev = isp_pdata->adev;
+
+	ret = amdgpu_bo_create_isp_user(adev, dmabuf,
+					AMDGPU_GEM_DOMAIN_GTT, &bo, &gpu_addr);
+	if (ret) {
+		drm_err(&adev->ddev, "failed to alloc gart user buffer (%d)", ret);
+		return ret;
+	}
+
+	*buf_obj = (void *)bo;
+	*buf_addr = gpu_addr;
+
+	return 0;
+}
+EXPORT_SYMBOL(isp_user_buffer_alloc);
+
+void isp_user_buffer_free(void *buf_obj)
+{
+	amdgpu_bo_free_isp_user(buf_obj);
+}
+EXPORT_SYMBOL(isp_user_buffer_free);
+
+int isp_kernel_buffer_alloc(struct device *dev, u64 size,
+			    void **buf_obj, u64 *gpu_addr, void **cpu_addr)
+{
+	struct platform_device *ispdev = to_platform_device(dev);
+	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
+	struct mfd_cell *mfd_cell = &ispdev->mfd_cell[0];
+	const struct isp_platform_data *isp_pdata;
+	struct amdgpu_device *adev;
+	int ret;
+
+	isp_pdata = mfd_cell->platform_data;
+	adev = isp_pdata->adev;
+
+	ret = amdgpu_bo_create_kernel(adev,
+				      size,
+				      ISP_MC_ADDR_ALIGN,
+				      AMDGPU_GEM_DOMAIN_GTT,
+				      bo,
+				      gpu_addr,
+				      cpu_addr);
+	if (!cpu_addr || ret) {
+		drm_err(&adev->ddev, "failed to alloc gart kernel buffer (%d)", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(isp_kernel_buffer_alloc);
+
+void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr)
+{
+	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
+
+	amdgpu_bo_free_kernel(bo, gpu_addr, cpu_addr);
+}
+EXPORT_SYMBOL(isp_kernel_buffer_free);
+
 static const struct amd_ip_funcs isp_ip_funcs = {
 	.name = "isp_ip",
 	.early_init = isp_early_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
index 1d1c4b1ec7e7..cf26d283469e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -29,17 +29,12 @@
 #define __AMDGPU_ISP_H__
 
 #include <linux/pm_domain.h>
+#include "isp.h"
 
 #define ISP_REGS_OFFSET_END 0x629A4
 
 struct amdgpu_isp;
 
-struct isp_platform_data {
-	void *adev;
-	u32 asic_type;
-	resource_size_t base_rmmio_size;
-};
-
 struct isp_funcs {
 	int (*hw_init)(struct amdgpu_isp *isp);
 	int (*hw_fini)(struct amdgpu_isp *isp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c5fda18967c8..122a88294883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -352,7 +352,6 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 
 	return 0;
 }
-EXPORT_SYMBOL(amdgpu_bo_create_kernel);
 
 /**
  * amdgpu_bo_create_isp_user - create user BO for isp
@@ -421,7 +420,6 @@ int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
 
 	return r;
 }
-EXPORT_SYMBOL(amdgpu_bo_create_isp_user);
 
 /**
  * amdgpu_bo_create_kernel_at - create BO for kernel use at specific location
@@ -525,7 +523,6 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 	if (cpu_addr)
 		*cpu_addr = NULL;
 }
-EXPORT_SYMBOL(amdgpu_bo_free_kernel);
 
 /**
  * amdgpu_bo_free_isp_user - free BO for isp use
@@ -548,7 +545,6 @@ void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo)
 	}
 	amdgpu_bo_unref(&bo);
 }
-EXPORT_SYMBOL(amdgpu_bo_free_isp_user);
 
 /* Validate bo size is bit bigger than the request domain */
 static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/isp.h b/drivers/gpu/drm/amd/amdgpu/isp.h
new file mode 100644
index 000000000000..6c8214ea28e1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/isp.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ */
+
+#ifndef __ISP_H__
+#define __ISP_H__
+
+struct isp_platform_data {
+	void *adev;
+	u32 asic_type;
+	resource_size_t base_rmmio_size;
+};
+
+int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
+			  void **buf_obj, u64 *buf_addr);
+
+void isp_user_buffer_free(void *buf_obj);
+
+int isp_kernel_buffer_alloc(struct device *dev, u64 size,
+			    void **buf_obj, u64 *gpu_addr, void **cpu_addr);
+
+void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr);
+
+#endif
-- 
2.43.0


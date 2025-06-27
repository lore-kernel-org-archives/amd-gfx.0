Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE50FC77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 20:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5A810E0AD;
	Fri, 27 Jun 2025 20:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jhq2G1VW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF0610EA28
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 20:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/bgv4ERHvm10IBEw5PcXvyOAp0ZlL4fOUZlW5iW9nwthQbP2M2RQEd9oiqKluwQb7iPixa79WX2cY+uCG9rbAdeYwcxUcYX9IU3wocH58dnqOw2REP9pnMmsHuqpkekDgLYbYJD/fz1kUsbpQBUPoarUGxL/lwwvE699m4O+S/jg6VrxMoDfM4SoQdm4mOfxlmk6UYkEkPsViMPTblMDJ3YXtrbxJ7rX+u/3HGxsTr0UYo8dvuLPXnk50q0pt31yXovebjLuiYxawha5G4CscGdfwQNrpVh4tnzXqH9ydaBCcYP4fsFLjZgrBeavv5e6wvQlZTMXGqoQKZOHTs94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zR3RlMX/5+iQmiuPXnUVwg2UynB8p1J7G/wCPRWRIY=;
 b=JsBg4NVXNerAPmT97MI/x8nXkH2p5l07c7e/pocglpdB8qPBolRMdX/zmJueNRKkcsPPYWa7ssGg5cYxF8d3FMfWCHcxqCq96u5ZBgdGBLSgGt0ebGKd3dCucVP/aj4cn3g3hCD7LOj5xhMibbSGIrcEowgrRsNA2suFA3Sk+ehjLFbbrBCU4lVbJH1mqeeRkKqhNOXiFEJb/0vNeqLZrifAsLY0PRcNQwQTYSTmsHcrhaej0dx9sc5hKJn4JQxSmNGg3OU4LGrDJEdx3QU+HnmxuI7L/booh2cuhkeUzI6lBr07q8gY0Ea1SnbnPkEmVktAzPtQA0v2NJrPuoV1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zR3RlMX/5+iQmiuPXnUVwg2UynB8p1J7G/wCPRWRIY=;
 b=Jhq2G1VWv/eF8krZeo6w1wrrKpILuLkMD06LP/xd+1aXbkvP8/xZ8sMODkJXgVO6HL/bl+A66tvKBtW2YQzYB70gDcvqcwauAVEjx5opgFBw3ITw1+vD/ga1wE89gr7bPD/BR4+giDD0fMttD79NW1fIUKNQnclDN4ZWzyNUSjE=
Received: from SJ0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:33b::19)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 20:18:07 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::78) by SJ0PR05CA0014.outlook.office365.com
 (2603:10b6:a03:33b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.13 via Frontend Transport; Fri,
 27 Jun 2025 20:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 20:18:07 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Jun 2025 15:18:02 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <phil.jawich@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Add helper functions for isp buffers
Date: Fri, 27 Jun 2025 16:17:29 -0400
Message-ID: <20250627201736.696030-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: b63c98e6-5476-4a1d-cfb8-08ddb5b7babd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cc46K74QsrKOaVvIvyU+RkZy/DsqNLD0yfizk9h7T9BLXsMw30BkpCyuI2rf?=
 =?us-ascii?Q?gEoBKziIwksB6ciiI2kMeLLOh+s11fDMaTh+DW0eIkNL3SiXyk4QZjhGZN82?=
 =?us-ascii?Q?0esfuWkRHnqgAznFkR8GFfrK2VLE1CKR2yKreWwEdAEb/Ki4Ulqy2vvtT1It?=
 =?us-ascii?Q?XsqB/YHZx5yVLERrak6FLz3cF370CGDC5weK1IKPksXE0iv5JsDPhYpD3yp0?=
 =?us-ascii?Q?EgFsyt1U3piZpLcHIzguy/MsWqbO6TBH90khIwMwOtR74nMKOiKFuUrdjRQU?=
 =?us-ascii?Q?VI6LK05+k8N9f0tyTa/01mYi6kDkrOhmPFpzVxydwG2ds/cqM0jGgGGxiZRX?=
 =?us-ascii?Q?/1+7jF8rE/QWf4wopRvU2yfxOQQDtqhop8zrcdtMqg1XYFmSUG+4JCUW+rG8?=
 =?us-ascii?Q?59C+TTEuafcYs40VjTg/cyZM1RhZ8nkypCaKI8/1xXv6XpCPm3Zv2Qsr2r/x?=
 =?us-ascii?Q?qkMPqQuqjnNDBV+gLWTnlcw0kfxRldpyI8phY3UT+L6MNsr70DZ/2TMOVgaz?=
 =?us-ascii?Q?p2CBiMwNW/g7iAPKZKBzWq1Oqg5qK4vaKH/UovbG7EcGys0KrnYjL8nuCr7o?=
 =?us-ascii?Q?Mhu+/LzLU5imeQxyDf2ABqXFThJ2Vgj32qgQyUIsd1Uzy4peJRyANL73lTHR?=
 =?us-ascii?Q?K0Qw+pVE2gfhvCkZkLfY2eQdJ6AzmUQEWPDedGR7cCwdIQ5HCHiNO8PwvIK+?=
 =?us-ascii?Q?fBflnaf8ZaBj7cWv/29dceoj3Y5m1+g7kNfMPNvIiMv4yPVa8I93jiOjjh+g?=
 =?us-ascii?Q?+v8mOP67WL9e4D1CfB09L6wKvbv2YYpXexsd5qBTn8NHmZy7teDJ/EZNk93N?=
 =?us-ascii?Q?2EwmNfucWy2OO3/GXAnLXfBE2zFGsteIyOXabxb1CxAW7WdqhoWcZNkB4pjR?=
 =?us-ascii?Q?4ONVss7zRb5UkySj9Q2CoVk5abnv/LsTpck6LMQ/iyY91RSMfNaMfi0Ambvk?=
 =?us-ascii?Q?25BHvpRcJq1wBS3u5zK2GqMW9XobVXFI5MJb8IMikdUI6vnBO3Vz8L0MoRtU?=
 =?us-ascii?Q?MA7u/VYrnJ7oNTwCLTt5BuhqHeIgm8HNPWnFQPELQEmzQ/bBJ4aAMqN/xIGA?=
 =?us-ascii?Q?xLf2w3T1fP1+LJWy954AKKOtq3Ff87k14CIA7zNM/Dm+oMBspFZIpabFsBeC?=
 =?us-ascii?Q?AVW4bfr6HYjk8lFMYSwiEEcfrs56uiXgb86rrX43ylVQbSQb/AP87cdLMcAx?=
 =?us-ascii?Q?TWw9ai0QwpJZYS2amtYU2KqxSE/5vIwbVErrgAL1BYtgHkAo9/s7nae4bxax?=
 =?us-ascii?Q?GUN+qVENi+j09owQlZ9Aquu6iBKKi2xW/Q/wW9xpV2tIAE+Q4pWOsXkQbiuw?=
 =?us-ascii?Q?BLJ3Zf73lnt7w3YIyy13qRmyWmyLp+6NhkLV0ukOj8lffz3nsPA9s2Hoqirb?=
 =?us-ascii?Q?GRM+TWWHNFaowklbHIWAQqEc2u5yQusBXEhUHPnXC0fCNT6xAqsHYJOZy9UG?=
 =?us-ascii?Q?TX9njMXhwhAtgRc+riylw3w1DamRBnVzoIIFnRQ66N5aCq+qq8sc0+8FGViE?=
 =?us-ascii?Q?dQ2bjxL1dqPsEAc9Tng9ud2ndOgEa7xUDQGi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 20:18:07.1743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63c98e6-5476-4a1d-cfb8-08ddb5b7babd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c    | 73 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h    |  7 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 --
 drivers/gpu/drm/amd/amdgpu/isp.h           | 47 ++++++++++++++
 4 files changed, 121 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/isp.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 43fc941dfa57..1b776c966bf2 100644
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
+	if (ret) {
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


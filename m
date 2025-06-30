Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98FDC8302F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 21:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408B810E4CA;
	Mon, 30 Jun 2025 21:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VIyY1W2i";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1AED10E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 21:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=six7dB6UPJr28vEX/vh4dyR52m8S+MuDmSBdi2vx2JXm82B/dwgA7fTEWQ+X3B8J7bhVaohdxnNhJeQ3+QVOpbT1ch7CSrKnJcViXE1vs3yveHwyBq7x5o+6X4vBm2J7CTEEHrRonCl7fZlWWED+Zd99Icc8GpDgHPoKgMl6PJtQu0AGuiQdH0EuKWrmjTChgBI4qfhH1qbbera+m4AyhM0lzlxx1zbt/wm7tK4nVYiXADFTWhT0j9XuVob+kRp0P8tGylCrkaIshwtqvTozQ/SPo9eyLc11nXuelsFBmRiJVIs+WnVJ6Un7w948YSbjBicu+Ch7xwW6fQ6e3bNxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y1KOu3Z6Xk7iYUFPBzPZ6gWLks975RkCchM0WZGW00=;
 b=i1M76g1LfX6QWlcPGRCTMQY0W10aYYYWRkjc/xt82GAk24G466sSqR1UcjRPElrtiCYji4EvZRuF7dfnaToQXv+Fsq/692FPQPVI51FidBVdPW2L9X1KZ9jMdnuKn63hWI2ShHP2vGI7urEWMAx1ceBH4CJ0tQ4O0JrODHFqSFaSDxuM4XyJkgSjkuSn5EX3eescRtDLEcl8AlT2QaupxzXc/o6OJ5xOfiv207KSoA7DZeGUI+q4syv+EniUjnKTEfBR+nQQJpbGlltMgtJCe57JXdfw3L28Bd8eZaZ4fYaWPVTjAQ2ho+HLhdDWH33UfFteYtjE1fdMJLRyoQkETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y1KOu3Z6Xk7iYUFPBzPZ6gWLks975RkCchM0WZGW00=;
 b=VIyY1W2iTmfetpQVqzdaTKkgpCMUkMclxdgRrcreZnwcCXJ2hDxp2hcJE989XWLpMjw6c/aiG54W6GJhoqLy0S2nRdvYschHRRsw4SG2xqBK/stI1CsjbaUakQEtABSt3RE90QzD3oVbWV60B32ANDT9M1u827/9CORXHafAuv4=
Received: from DM5PR08CA0035.namprd08.prod.outlook.com (2603:10b6:4:60::24) by
 CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.30; Mon, 30 Jun 2025 21:36:22 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::c) by DM5PR08CA0035.outlook.office365.com
 (2603:10b6:4:60::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.31 via Frontend Transport; Mon,
 30 Jun 2025 21:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 21:36:21 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Jun 2025 16:36:20 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <phil.jawich@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v4] drm/amd/amdgpu: Add helper functions for isp buffers
Date: Mon, 30 Jun 2025 17:33:51 -0400
Message-ID: <20250630213607.1849629-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8b407b-1ca3-4316-f9fe-08ddb81e281f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AqQuhj/PkZxitw67OBzlZF4/Rmw3w+D3TboVMGp7D5BCvhDIqqEuk49FDZjR?=
 =?us-ascii?Q?59j2doRDyYuUxWT3qdCl5beGLTBKJHb3TQcSCUAy7QCSv7RmNUIqzkuizZKt?=
 =?us-ascii?Q?OYwC0oo5tecE/FyNgto2YJyVZnGK+1zUqimvegXrQggVmOfFlNPYnGwumFu4?=
 =?us-ascii?Q?/bp/7jGMnLYApzvCS2+sb7zn67Qdt6Vlg4zjTQxqCveL60v3BpXP4kskbpbq?=
 =?us-ascii?Q?b8FbfuuZwWrZUN0cnI9fsc0mH76S7/I7XEjnXzzEg89ES6kviihZFk8mnLTb?=
 =?us-ascii?Q?mAw59upKAQwzvJ3h1jL3HABGvYH5b4D5oczBqvhLqmQoKmHCLUWaDIspUTvt?=
 =?us-ascii?Q?0ctGnDk3mpsYJ9Q1mmpgsmaSJRNURaVuF6P+hWR/0ZRW3sAsaD0ZyE5yyJtc?=
 =?us-ascii?Q?YOjIRKrs6BtqAYos0fN2mla6d3r9FIYqdUH3K2l689cj8tYoc6kyRo4msg1R?=
 =?us-ascii?Q?GlJW7ibPewQ4hS/qylHvVwNlw1yAxJJ03AHGuGDCJOeLk/KQOrRF2ARmYYq5?=
 =?us-ascii?Q?kIIJ0fWSJk9a2RXLveL9zkMQ3T14sxoyewbPptEr5eQ7Sx5g7B7Eq5KHyZNG?=
 =?us-ascii?Q?CohFKIpPRnpwQ7wGSni6cEA0gEEBmaZOLTetu2kzMcIwln+gJnBanD/qe8KV?=
 =?us-ascii?Q?PZ6DyYwT3GV436Y1YtR+EWhbzHDAxyKdS0rqDWRUk9bX97WOTVbqCpSaaYTv?=
 =?us-ascii?Q?6EyxbNMEcl6/4UzL36qxpJHAef2BGc/irmo4yg9SsC+LPR285MyCvnQ/ZyUD?=
 =?us-ascii?Q?1NSHFM05kmlHsx5fKr/bqbSf2k0hdweYVEHH+DN0OnYj4R3zWmXE/+7u9a3e?=
 =?us-ascii?Q?b+HhwqddZX94xVjuudrClPER1OTi2N9dbdKCPcbu8hDiimQb+VW/iRwn/804?=
 =?us-ascii?Q?uPX+aE57s73EVBso+nuwLQoO6N6/ZL1ISfXTJqkprsyDntO7DopRANtdmo5F?=
 =?us-ascii?Q?W4vYyemJLyPTsXyyAOS3NYTYJYTx7iaYxpivWq1AOIKnYCK/EPavZmscBXBw?=
 =?us-ascii?Q?JuuYdba4QHeqOg/CpSc5nFFfqtsA1M/2QjI9S25cqmoCvaEDlyOt6VWHYuXd?=
 =?us-ascii?Q?EUZx1ldp3SN2/hb3Z75vMWzBVHkGmr/w3Mjt0GABwmgPAr7PY8GLipCkd7iV?=
 =?us-ascii?Q?CtJDiLQH+2WfdR2CyaFMKfPRSJkDbtCEjk78aUkaZpRxBMSegAECuYVdLfOL?=
 =?us-ascii?Q?aMtFiVliWmk+W4/nPYEDx4N9ogZoNxJQpO6Ui9VW/bKBIOFGCcBvFU1aqLF5?=
 =?us-ascii?Q?PAeZNeAZJ7sJu9D55SzJnmhjp5hsUysTPhGu39gDxfYKnP5r5TeWcPO2UGTV?=
 =?us-ascii?Q?7Af9GYcy7IUsX1Vk2ciD9OjFhQmRzWaD2/ms0CUuW2L+Bpiajhf5GFsIafDV?=
 =?us-ascii?Q?7HBrCRl5Y86h2YB3w9FLwuRvcrBVjkEVdUosi8sM6dhDcUxQH6n3HM7S4qce?=
 =?us-ascii?Q?KjGN8GuzJcM8mhzQInwUON7Csgx6Krm1CXZ68DNIl3icbI1D8TcodgIsyQBR?=
 =?us-ascii?Q?+xQuIOrN1LkRTwGZoh5EONtSO60yDreRSBeP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 21:36:21.7417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8b407b-1ca3-4316-f9fe-08ddb81e281f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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
Changes v3 -> v4:

* Remove unrelated change in isp_load_fw_by_psp()

 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c    | 175 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h    |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 -
 include/drm/amd/isp.h                      |  51 ++++++
 4 files changed, 227 insertions(+), 10 deletions(-)
 create mode 100644 include/drm/amd/isp.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 43fc941dfa57..f9cabeae1c71 100644
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
@@ -141,6 +143,179 @@ static int isp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int is_valid_isp_device(struct device *isp_parent, struct device *amdgpu_dev)
+{
+	if (isp_parent != amdgpu_dev)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * isp_user_buffer_alloc - create user buffer object (BO) for isp
+ *
+ * @dev: isp device handle
+ * @dma_buf: DMABUF handle for isp buffer allocated in system memory
+ * @buf_obj: GPU buffer object handle to initialize
+ * @buf_addr: GPU addr of the pinned BO to initialize
+ *
+ * Imports isp DMABUF to allocate and pin a user BO for isp internal use. It does
+ * GART alloc to generate GPU addr for BO to make it accessible through the
+ * GART aperture for ISP HW.
+ *
+ * This function is exported to allow the V4L2 isp device external to drm device
+ * to create and access the isp user BO.
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
+			  void **buf_obj, u64 *buf_addr)
+{
+	struct platform_device *ispdev = to_platform_device(dev);
+	const struct isp_platform_data *isp_pdata;
+	struct amdgpu_device *adev;
+	struct mfd_cell *mfd_cell;
+	struct amdgpu_bo *bo;
+	u64 gpu_addr;
+	int ret;
+
+	if (WARN_ON(!ispdev))
+		return -ENODEV;
+
+	if (WARN_ON(!buf_obj))
+		return -EINVAL;
+
+	if (WARN_ON(!buf_addr))
+		return -EINVAL;
+
+	mfd_cell = &ispdev->mfd_cell[0];
+	if (!mfd_cell)
+		return -ENODEV;
+
+	isp_pdata = mfd_cell->platform_data;
+	adev = isp_pdata->adev;
+
+	ret = is_valid_isp_device(ispdev->dev.parent, adev->dev);
+	if (ret)
+		return ret;
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
+/**
+ * isp_user_buffer_free - free isp user buffer object (BO)
+ *
+ * @buf_obj: amdgpu isp user BO to free
+ *
+ * unpin and unref BO for isp internal use.
+ *
+ * This function is exported to allow the V4L2 isp device
+ * external to drm device to free the isp user BO.
+ */
+void isp_user_buffer_free(void *buf_obj)
+{
+	amdgpu_bo_free_isp_user(buf_obj);
+}
+EXPORT_SYMBOL(isp_user_buffer_free);
+
+/**
+ * isp_kernel_buffer_alloc - create kernel buffer object (BO) for isp
+ *
+ * @dev: isp device handle
+ * @size: size for the new BO
+ * @buf_obj: GPU BO handle to initialize
+ * @gpu_addr: GPU addr of the pinned BO
+ * @cpu_addr: CPU address mapping of BO
+ *
+ * Allocates and pins a kernel BO for internal isp firmware use.
+ *
+ * This function is exported to allow the V4L2 isp device
+ * external to drm device to create and access the kernel BO.
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+int isp_kernel_buffer_alloc(struct device *dev, u64 size,
+			    void **buf_obj, u64 *gpu_addr, void **cpu_addr)
+{
+	struct platform_device *ispdev = to_platform_device(dev);
+	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
+	const struct isp_platform_data *isp_pdata;
+	struct amdgpu_device *adev;
+	struct mfd_cell *mfd_cell;
+	int ret;
+
+	if (WARN_ON(!ispdev))
+		return -ENODEV;
+
+	if (WARN_ON(!buf_obj))
+		return -EINVAL;
+
+	if (WARN_ON(!gpu_addr))
+		return -EINVAL;
+
+	if (WARN_ON(!cpu_addr))
+		return -EINVAL;
+
+	mfd_cell = &ispdev->mfd_cell[0];
+	if (!mfd_cell)
+		return -ENODEV;
+
+	isp_pdata = mfd_cell->platform_data;
+	adev = isp_pdata->adev;
+
+	ret = is_valid_isp_device(ispdev->dev.parent, adev->dev);
+	if (ret)
+		return ret;
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
+/**
+ * isp_kernel_buffer_free - free isp kernel buffer object (BO)
+ *
+ * @buf_obj: amdgpu isp user BO to free
+ * @gpu_addr: GPU addr of isp kernel BO
+ * @cpu_addr: CPU addr of isp kernel BO
+ *
+ * unmaps and unpin a isp kernel BO.
+ *
+ * This function is exported to allow the V4L2 isp device
+ * external to drm device to free the kernel BO.
+ */
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
index 1d1c4b1ec7e7..d6f4ffa4c97c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -28,18 +28,13 @@
 #ifndef __AMDGPU_ISP_H__
 #define __AMDGPU_ISP_H__
 
+#include <drm/amd/isp.h>
 #include <linux/pm_domain.h>
 
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
diff --git a/include/drm/amd/isp.h b/include/drm/amd/isp.h
new file mode 100644
index 000000000000..ec868288abf2
--- /dev/null
+++ b/include/drm/amd/isp.h
@@ -0,0 +1,51 @@
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
+#include <linux/types.h>
+
+struct device;
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


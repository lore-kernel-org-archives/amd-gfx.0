Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE041C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 14:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798DD10E3F5;
	Mon, 15 Jul 2024 14:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fu69DPw2";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370A910E3F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 14:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jn9bQHRLVxAKISZy5KQpyHdp5Qu6GarVf2tCYOpZkYEecgaHAZsuSez92S38+NbKKtVFZevvNm2CdhjCF+drEv4c3rblBa4dtphjrLxUqQWzBv3HxZqSuFLEYfcf08+KoDSvzrWCH9ligBNMaxHUPyZ2k/MfB+usQd/p1vOTKT07hFTZtlQ1xielANwwkpsEt7z29sU8agC7h1ji7W4IRTdT78x9vIUh6vguxFeE/Lj4P28ylvX+8kZgjxlkCJK8p199eoAT1E1BvhCq2Bme0B4HnkLzQE1wtHe6RzDoHh0bjcNuSA7MTLbbfXaFQAg05l2oPtt0p4UPRs78D2/qyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCc2X1xrwOVdF1Bi9WR+3zPLg6ntszUMmmmP8ufh/yY=;
 b=G0qpV8Vy3GnsRi+gcom4JIpguDFHJt/q8/jRSEk+imZDSDfbm1Pwsegk2TH29ZVpOq5BE/1r88Yz3dqRY2ujR86EkGTm0PUB/yc9pFNTwuW9mSc37HJEH2avKc0KR0Pnj/xW6worUZJ6750XyUO2npW5zqkUYARl6w45zpZfz8ocs9xwWR55TfDarLQhKI71nwDj4+TTj440Fq9ZcrBCx4pkrH1OtEZtItoLWZMNeOdNJs10A03ZVJ+Sqcoej3CEKYZazv70HZE4pQJ0eHJWdRJoGT3FZ5kiRqUzoxpaMmyv/enOEw2vW+KjjfhcwEbrGUIA0tOYL10G9CItPFwD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCc2X1xrwOVdF1Bi9WR+3zPLg6ntszUMmmmP8ufh/yY=;
 b=fu69DPw2vBTI3g3iwQ9VfUYj49tr2DlXKSNveDXfx89SlQeaNVw4pXNcK63+U96CC9yaKWYbxYrU/3O3QcbXan1QvQg0oZev9OjHD4vlNQB/roOfnDxuYUCJDg7XRCArGpzMJYmG/bE5jYpzfgpIQ11nW3QKqaqrYMySmC26sZI=
Received: from BLAPR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:36e::21)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:42:21 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::73) by BLAPR05CA0012.outlook.office365.com
 (2603:10b6:208:36e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Mon, 15 Jul 2024 14:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 14:42:20 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 09:42:19 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 1/1] drm/amd/amdgpu: Add support for isp buffers
Date: Mon, 15 Jul 2024 10:42:03 -0400
Message-ID: <20240715144203.14563-2-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715144203.14563-1-pratap.nirujogi@amd.com>
References: <20240715144203.14563-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: b7cd5bd2-0778-4408-00f0-08dca4dc552d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mfOwHaVwTUakavsfVr9JH/GJ6BgusicIbnXXrdpJpxGDcYoXE3UxzlYjs1by?=
 =?us-ascii?Q?lg8H+CLYyxsAnEzF6zdGaUI4KRB7pgkq+1CvEufbSoGGYTKixiEOp55Eu01h?=
 =?us-ascii?Q?uGzr0mWRTrcMP6jvCPvcRBLuJDF2RrDrg646QNf3Dr5k0/TsqJhYPQwYP9zi?=
 =?us-ascii?Q?btK150DN6JtEOkNdqqmqSbCDVLEOtFwAq+G6MO7qLP3sjML0A3ClR40rwBBy?=
 =?us-ascii?Q?EXKiatJGFtSpCFByFISs+2/gE3JSme98nQWTw9sT3yunzdS/lWyILvjzG2r9?=
 =?us-ascii?Q?GDw7Sb+rz2LICHPJ7ol7P6fvPb/KmD8felE/pbcDijkItamCBb8ZHR18n1sB?=
 =?us-ascii?Q?XHk8WWh14NDWHqrr2e6LiXhI7TRDXpuQf+16jtcd3boi07dDaoYFTuNcn9S9?=
 =?us-ascii?Q?Hy6sMtcO/aEbjO2erbYf51cBwSrrQM/7aKKz8gF1rwFhqo91hIQOi2m9S5z6?=
 =?us-ascii?Q?Y7CuQvKR9+MeKoh6e9RQEWKQX62gsPt8M4q08GjI3fKguIA9M+nNvYehWYP3?=
 =?us-ascii?Q?T12vWiMTEQdgoLm1pLocrZUWwxxIDMxQdOhC3YR19bZLhldcVeMBGpEMaHKW?=
 =?us-ascii?Q?N6cxbacNjkfemMbW/EQxlUl+OHT2XFcKcA3+AaXE27nUL/kf8e20yOqiSDaM?=
 =?us-ascii?Q?QOoELtUwIm96ezoNmPNxjPJJrdxg8j0WcgMNzdf38kpIJt2A5QMZEDvMCN15?=
 =?us-ascii?Q?LQ3hf5MVG5WFqJvWhznA6ZIc/ggDUlqbxSqB3h73gZEix/OHLXLlvv1uPKJm?=
 =?us-ascii?Q?1Vvo3YTPSP6gKbSPrc8l8UXXiXhlbsNmJKXUtWC1fQ5q1oJgtRjXxEAOsJ87?=
 =?us-ascii?Q?Oq6E/Th76IDpIBWrFzBVyv4Ao165v63Dc9/GBG0QdaL2xdF6qWpqcliDT1la?=
 =?us-ascii?Q?biq0qMg9fvZupJFaXSrmHxi7guSKt7gquP5ghklfYqOxeM6LgiP4tbrUbMa0?=
 =?us-ascii?Q?oB7ozBuMAV/p+GWgawKeHjlUP8ZFdhkKymiX5+lSz9amscUg6oLaJAgG+96u?=
 =?us-ascii?Q?4CHqGNWxVlZ3SdSzBSNSjgdoW7BZhRUv6P3OXMeqqGJ62gi0Umk68K0eunS6?=
 =?us-ascii?Q?uC+141Eq46hDnK2X6D5EwvwaY1zDNf5KsF9ilobjb/h85EJc3poe3XpmdmFG?=
 =?us-ascii?Q?COntFltDE0uAO5oxKmpqtqfcVWrM+1TaxdHBFf1pHfiHj+PF/v8B/3dz7QTP?=
 =?us-ascii?Q?qNLHKnvxf9EE69LGQ/VCKG/I1ViDyTG4Yrx0O9othqbJZnVXjJcBfBPQ4QY+?=
 =?us-ascii?Q?QkRG7C7nhutYwF9Kb8+mfU5ygf3WcgClYR3yhD5DQyflv4FRDC1xhCfQnLGr?=
 =?us-ascii?Q?VwAXUPfW4xoxTDv79nVGg4OiNSaZ/a+3quHIM+l2FdIluR5qvJieW28s3NEu?=
 =?us-ascii?Q?vsD13RealyFNUb1H2v1qLUp7nU+4vDar8gxavUr4IMnbuv7aboKbX0kIrRYS?=
 =?us-ascii?Q?AqFojwlTkLBpP8m5vt41+fgIIC+pyyUh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:42:20.7915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cd5bd2-0778-4408-00f0-08dca4dc552d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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

Add support to create user BOs with MC address for isp using the dma-buf
handle exported for the buffers allocated from system memory in isp driver.

Export amdgpu_bo_create_kernel() and amdgpu_bo_free_kernel() as well for
isp to allocate GTT internal buffers required for fw to run.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 103 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |   4 +
 2 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6faeb9e4a572..517c9567a332 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -39,6 +39,7 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_dma_buf.h"
 
 /**
  * DOC: amdgpu_object
@@ -334,6 +335,9 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
  *
  * Allocates and pins a BO for kernel internal use.
  *
+ * This function is exported to allow the V4L2 isp device
+ * external to drm device to create and access the kernel BO.
+ *
  * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
  *
  * Returns:
@@ -357,6 +361,77 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 
 	return 0;
 }
+EXPORT_SYMBOL(amdgpu_bo_create_kernel);
+
+/**
+ * amdgpu_bo_create_isp_user - create user BO for isp
+ *
+ * @adev: amdgpu device object
+ * @dma_buf: DMABUF handle for isp buffer
+ * @domain: where to place it
+ * @bo:  used to initialize BOs in structures
+ * @gpu_addr: GPU addr of the pinned BO
+ *
+ * Imports isp DMABUF to allocate and pin a user BO for isp internal use. It does
+ * GART alloc to generate gpu_addr for BO to make it accessible through the
+ * GART aperture for ISP HW.
+ *
+ * This function is exported to allow the V4L2 isp device external to drm device
+ * to create and access the isp user BO.
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
+			   struct dma_buf *dbuf, u32 domain, struct amdgpu_bo **bo,
+			   u64 *gpu_addr)
+
+{
+	struct drm_gem_object *gem_obj;
+	int r;
+
+	gem_obj = amdgpu_gem_prime_import(&adev->ddev, dbuf);
+	*bo = gem_to_amdgpu_bo(gem_obj);
+	if (!(*bo)) {
+		dev_err(adev->dev, "failed to get valid isp user bo\n");
+		return -EINVAL;
+	}
+
+	r = amdgpu_bo_reserve(*bo, false);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to reserve isp user bo\n", r);
+		return r;
+	}
+
+	r = amdgpu_bo_pin(*bo, domain);
+	if (r) {
+		dev_err(adev->dev, "(%d) isp user bo pin failed\n", r);
+		goto error_unreserve;
+	}
+
+	r = amdgpu_ttm_alloc_gart(&(*bo)->tbo);
+	if (r) {
+		dev_err(adev->dev, "%p bind failed\n", *bo);
+		goto error_unpin;
+	}
+
+	if (!WARN_ON(!gpu_addr))
+		*gpu_addr = amdgpu_bo_gpu_offset(*bo);
+
+	amdgpu_bo_unreserve(*bo);
+
+	return 0;
+
+error_unpin:
+	amdgpu_bo_unpin(*bo);
+error_unreserve:
+	amdgpu_bo_unreserve(*bo);
+	amdgpu_bo_unref(bo);
+
+	return r;
+}
+EXPORT_SYMBOL(amdgpu_bo_create_isp_user);
+
 
 /**
  * amdgpu_bo_create_kernel_at - create BO for kernel use at specific location
@@ -433,6 +508,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
  * @cpu_addr: pointer to where the BO's CPU memory space address was stored
  *
  * unmaps and unpin a BO for kernel internal use.
+ *
+ * This function is exported to allow the V4L2 isp device
+ * external to drm device to free the kernel BO.
  */
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr)
@@ -457,6 +535,31 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 	if (cpu_addr)
 		*cpu_addr = NULL;
 }
+EXPORT_SYMBOL(amdgpu_bo_free_kernel);
+
+
+/**
+ * amdgpu_bo_free_isp_user - free BO for isp use
+ *
+ * @bo: amdgpu isp user BO to free
+ *
+ * unpin and unref BO for isp internal use.
+ *
+ * This function is exported to allow the V4L2 isp device
+ * external to drm device to free the isp user BO.
+ */
+void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo)
+{
+	if (bo == NULL)
+		return;
+
+	if (amdgpu_bo_reserve(bo, true) == 0) {
+		amdgpu_bo_unpin(bo);
+		amdgpu_bo_unreserve(bo);
+	}
+	amdgpu_bo_unref(&bo);
+}
+EXPORT_SYMBOL(amdgpu_bo_free_isp_user);
 
 /* Validate bo size is bit bigger than the request domain */
 static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index bc42ccbde659..17aa99b8311d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -299,6 +299,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 			    unsigned long size, int align,
 			    u32 domain, struct amdgpu_bo **bo_ptr,
 			    u64 *gpu_addr, void **cpu_addr);
+int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
+			   struct dma_buf *dbuf, u32 domain, struct amdgpu_bo **bo,
+			   u64 *gpu_addr);
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 			       uint64_t offset, uint64_t size,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
@@ -310,6 +313,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 			struct amdgpu_bo_vm **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
+void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
 void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
 void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
-- 
2.34.1


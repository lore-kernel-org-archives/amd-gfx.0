Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB16C3ABC5
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 05:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBE610E2D1;
	Thu,  8 May 2025 05:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BVeeuqIx";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302C710E160
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 05:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZJpVIqFbPNRHnqSfQLD3ORpBwhrKJ4fLvpznBa4kitRyXeWL4kg5yoaAdcGGWZ96+GpxluXLzL5VcDYtQuWnwkdErx40Vb+MmSBoyZi9VsCUqXDAh4qZOK+y8Map4zkr8jH/Gv2f6BviYkM7IC7pE+t+D0KK6LgjXt9euqpKVCq4oGxRpaSKAT57RneR5bzSIeSLomqt3LLDGDkuP5NXN+zLHjsYuVvNKc/k2kK5VfEsp0w3mInm+CUtlGm6yOJtbF3hfrECAFXMDKFiCj+0Ll1CpXVa9jVMeIpctVaYVOvHS7rfpDpDA8QJ2z+gb6H81VcztePRdZ9gfOIF2HGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Uj5+oFcdAJDkbrPsMNHexo/xhoZ8e86MDOuA3HP0TI=;
 b=ln7K6LUIcoLjwHqIbyEql4qmY3zHKiXfqDdOBplOfQ+XTWPFkFPIpH5FNFgkjbcNxs4D+yBYBziCP5ip2+waQkwZEYBDm5aF24nKmSPiQDAYuA+cDGlPIugtWSvXtp0P96OzYS8oyC9lG/5d7PgkRP4JA2ugBeP8pVDNwd719zx33b0vhMnbcGTddLa79kqQBQAdH3+K10fNc51pDQPl5442CIbouBncsAxk5DqTokVRGaECEeQ5iETOl7tRRfumc8DK1Npm8wKHL08qrr49bywB00LXOf98Acio6U2xg0BSQABhH6YhSulHgx2mJa7TntnMR2SHB+vyv2zltZs7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Uj5+oFcdAJDkbrPsMNHexo/xhoZ8e86MDOuA3HP0TI=;
 b=BVeeuqIxJ8F+yqOqdPqWeP1KNSu+t4IHd46jpvDs6waUP1rqp9O+z8PJV9J/GN5H5+tjPVsAmDUQSX+b6nEvGig+TL8/ZmFe7dzDJPE9sDWN/FHLGfwaGScKSJUtcNpNK8h7Zp5qlU7b7y90bhbRQLIDKu5gjOpNIKfj/DiJkKI=
Received: from SA0PR11CA0195.namprd11.prod.outlook.com (2603:10b6:806:1bc::20)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.37; Thu, 8 May
 2025 05:10:05 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::2) by SA0PR11CA0195.outlook.office365.com
 (2603:10b6:806:1bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Thu,
 8 May 2025 05:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:10:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:10:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:10:04 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:10:02 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH v4 2/7] drm/amdgpu: update GPU addresses for SMU and PSP
Date: Thu, 8 May 2025 13:09:21 +0800
Message-ID: <20250508050926.228674-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508050926.228674-1-guoqing.zhang@amd.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc0ec45-3e86-44a1-a9d6-08dd8dee9827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8BDrsvw19wNStOqgD3aT51ym8ylam3AwFepL4YHDRCJJLhP5xJ61YgUJckOj?=
 =?us-ascii?Q?Uj8Txwg9/v53q8zFPhV97YvmK0IQUh42NQdibNuUkVjaQNpE7Q6lL+ODrl7k?=
 =?us-ascii?Q?M8o2+nuEO4n1sy9lwWAAXeh+zH0RJdqKwk6P2VVh4L1622pEWoQtLhkiHiwV?=
 =?us-ascii?Q?szch7FYLFim1Xav2gXgnQLjyJ2k5DY7S1iKxG9TdsJWKKSpIwRolMu1qzwgy?=
 =?us-ascii?Q?SqPlf/AfVhaQRHAagR6r0iVeIA84SEx64F8zRWi2kONylASvaN6tFRU8RyQB?=
 =?us-ascii?Q?a6iX6qsYL+lmLa0pgfk/DNczulhZKYeI2ziwGhNzeu7Bs+0vLh93T2tgdQ/x?=
 =?us-ascii?Q?BcJXB39bgh2bDcNLEHQ+r9y+ujhbLoah6KJK+FIu/qgW9o7g5QLbe4IIsONv?=
 =?us-ascii?Q?dQLslNS2SQ6dV8RG72JroPCNhD7YfK5TZYXqtuxf7DZY2Z8RI9eEfxVTsEBQ?=
 =?us-ascii?Q?aH1HUs4aG7O0/Z8C+Hlj2KWYXb7gG1wVcaQj1BHW01er6p62XLIXGLFNhywt?=
 =?us-ascii?Q?rbQ0b2JgQLNDMfGrF+XZpfGTYdo+iaROD/lUpxW/u9LWH+leaca7SwVJ4LQi?=
 =?us-ascii?Q?4DvYIElx51JWxt6NetMCSfovrvgeTmkmZuHoVywVyO2MQil6huRH8MTgiV7T?=
 =?us-ascii?Q?U3TqOVVrJTIDgmklOOU/OHvJrhaGonBNKa31eJGLKYfGVc33mGKT5FWEYsxr?=
 =?us-ascii?Q?AUoaelIt+avxoAw76a8wPTtwYxdwFgnEm1fr+ihPXdZuBIDwI4A/mrHs9dUY?=
 =?us-ascii?Q?wwquBrSTNoVMUnitD51Yz8inYyrIL4GcBBNywvfd9z4Ngah86JTmNGfCf0b/?=
 =?us-ascii?Q?o1G9m15MXHSO3YEwxopeUnxgbp/zSc1WKcVSOpMSeF2gEIvnqFq10dqOBb9j?=
 =?us-ascii?Q?cpvPys/sM/jcF61YWFlyC02vkQcTvrVA1flOYD9jT/hTFPxMixJDUD2hUKhj?=
 =?us-ascii?Q?YFbXdvXmcsvxtVXmCBvKfHOxNdv8j1RWfMSgdbV5J/2mJCTJfFtGSqRBiZPx?=
 =?us-ascii?Q?J5wMmj2707yyn/6DF89/uEcAHrI4Om2MEcLYd0yF/LhTaxMLRMxeKbuho1Fa?=
 =?us-ascii?Q?3RcoUZdof2heRTQ92C/AvAYFLYc3D4hMoveRhNLy2tRaYMSiW+GicARcaJY+?=
 =?us-ascii?Q?+j/KWslnoeFp+Y8PqMxn6LkdtQ1f+7mW4Jp9EBBqdc7tNKgRAqCbE8aZlyFp?=
 =?us-ascii?Q?Vfd+qIy2T41HDwrOC2yhTVVAyJ7GTsf6u2/1JjZ9gplmVhV5W6J4U8eq3zuB?=
 =?us-ascii?Q?iVrq+V8E4gJBBgYv0n3gMFL5WpwCZG39/5k1Cimt1xJ20Nw5j/dAGwO4Tnzs?=
 =?us-ascii?Q?NhCwfzQ6ieZEE94eSncAQSaKrvRP7zz3nZ+yr1vIVoABz+sBRysXXTwBzYKv?=
 =?us-ascii?Q?qF/4xZaPgy5yXvE5GknsjS2E68RR5iVqTH3/OOriq6A8FdpXKG9bZ0a7Fzo2?=
 =?us-ascii?Q?GY3cuKaq8rjKq4/axgmnKLDXUn4OD/eUSWbK7clTayB7h8+wgl4q7MF08Yah?=
 =?us-ascii?Q?X74X9AIgxnFROcvADIQfKcwhHwhNS9yE5Amg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:10:05.0292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc0ec45-3e86-44a1-a9d6-08dd8dee9827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447
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

add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
the FB aperture address for SMU and PSP.

2 reasons for this change:
1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
aperture address, it is not compatible with SMU and PSP, it need to updated
to use FB aperture address.
2. Since FB aperture address will change after switching to new GPU
index after hibernation, it need to be updated after resume.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 17 +++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4e794d546b61..3dde57cd5b81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1513,6 +1513,26 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 	return amdgpu_bo_gpu_offset_no_check(bo);
 }
 
+/**
+ * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
+ * @bo:	amdgpu VRAM buffer object for which we query the offset
+ *
+ * Returns:
+ * current FB aperture GPU offset of the object.
+ */
+u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	uint64_t offset, fb_base;
+
+	WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
+
+	fb_base = adev->mmhub.funcs->get_fb_location(adev);
+	fb_base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
+	offset = (bo->tbo.resource->start << PAGE_SHIFT) + fb_base;
+	return amdgpu_gmc_sign_extend(offset);
+}
+
 /**
  * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
  * @bo:	amdgpu object for which we query the offset
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index dcce362bfad3..c8a63e38f5d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 			     bool intr);
 int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
+u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
 uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
 uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e1e658a97b36..bdab40b42983 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
 					      &psp->tmr_bo, &psp->tmr_mc_addr,
 					      pptr);
 	}
+	if (psp->tmr_bo)
+		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
 
 	return ret;
 }
@@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
 
+	if (context->mem_context.shared_bo)
+		context->mem_context.shared_mc_addr = amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
+
 	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =
 		lower_32_bits(context->mem_context.shared_mc_addr);
 	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =
@@ -2336,11 +2341,26 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
 	return false;
 }
 
+static void psp_update_gpu_addresses(struct amdgpu_device *adev)
+{
+	struct psp_context *psp = &adev->psp;
+
+	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
+		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
+		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
+		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
+	}
+	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
+		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
+}
+
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
 	int ret;
 
+	psp_update_gpu_addresses(adev);
+
 	if (!amdgpu_sriov_vf(adev)) {
 		if ((is_psp_fw_valid(psp->kdb)) &&
 		    (psp->funcs->bootloader_load_kdb != NULL)) {
@@ -3976,6 +3996,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
 
 	mutex_lock(&adev->psp.mutex);
+	fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
 	ret = psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
 	mutex_unlock(&adev->psp.mutex);
 
@@ -4085,6 +4106,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf, adev->psp.vbflash_image_size);
 
 	mutex_lock(&adev->psp.mutex);
+	fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
 	ret = psp_update_spirom(&adev->psp, fw_pri_mc_addr);
 	mutex_unlock(&adev->psp.mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 3d9e9fdc10b4..f3b56c219e7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
 	}
 
+	if (adev->firmware.fw_buf)
+		adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
+
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
 		if (ucode->fw) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 315b0856bf02..dfdda98cf0c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
 	return 0;
 }
 
+static void smu_update_gpu_addresses(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *pm_status_table = smu_table->tables + SMU_TABLE_PMSTATUSLOG;
+	struct smu_table *driver_table = &(smu_table->driver_table);
+	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
+
+	if (pm_status_table->bo)
+		pm_status_table->mc_address = amdgpu_bo_fb_aper_addr(pm_status_table->bo);
+	if (driver_table->bo)
+		driver_table->mc_address = amdgpu_bo_fb_aper_addr(driver_table->bo);
+	if (dummy_read_1_table->bo)
+		dummy_read_1_table->mc_address = amdgpu_bo_fb_aper_addr(dummy_read_1_table->bo);
+}
+
 /**
  * smu_alloc_memory_pool - allocate memory pool in the system memory
  *
@@ -1789,6 +1804,8 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	smu_update_gpu_addresses(smu);
+
 	smu->smc_fw_state = SMU_FW_INIT;
 
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-- 
2.43.5


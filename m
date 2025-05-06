Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6692C3ABBF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549C710E636;
	Tue,  6 May 2025 09:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oZPO+EuC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3BAE10E636
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaRJ0FE2sV/nYrrz5WyI4XU9sMHAPnJFspNPVZgjmB0lNlCN9zMRou209SbOVZhLC6sQDJwc9ILHeh/bhWknLh1tOi/r5CQcONQ/BU9ZxNTn31uuroNQBPVocRv80ZateYGwhC6tGRUZUltMlL/Lzlwhkbru3MxM44T4UQWZ5gqiNpfwhbCU3qtmdtFMjz5wNjrCAOagGY2ov8OW+KRtWwU/yYqRc9kTvC3bvHMBnDajW1phFkIqR4WevHpuLIa+16GpzbUel1iUFoDNers9LVeNL598gOQ/CTcbN/GS/JguRSWaPQAZYKcm2HFfA5Nnv+dt1tc3QNQNELq7rmdWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Uj5+oFcdAJDkbrPsMNHexo/xhoZ8e86MDOuA3HP0TI=;
 b=d4f1S2uW8eKazf5XTFJ8xlCGkeq3YnrqJl7YxOfPjSHwCVC7bMP3XtyNzZR/sfVG5Hr0U/0hNXmFPLFS3sydKE6RG8b2a4JJKy72ZZ577+R/um6qHYVtwZSAU0EVyNly7Oeg5+YWvYJ7pz6kZ9bEgYjpnEDc2nqjaS8tjuS3akyHpoQ/2+IFpsSBL2vx5zeA0rRMP9n5zaINo4c5zr3xpJnLgsukLUcmhTB/teiHxQD0HH8XWyS+CD5tsTKWKpPC3ih1IJQsJRI3NH+s5JnS+XIVZ1tNwB+58fOqWp8n4RSElmKzVtrjkT3/Z7GLn+hxWnIbDw5OyA15WU5vte0/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Uj5+oFcdAJDkbrPsMNHexo/xhoZ8e86MDOuA3HP0TI=;
 b=oZPO+EuCFgS0Kl3Zj+bGHFKsRriPC1imOQWs70B+qjkF66dX0JkIoVhRgbPliknsF0K9SqFR0Kah8wxRVklnSwenzNto81mspdoftxjtxCGmqBegUcpiRj3XUjqDba4C1GTxTBLJVMYOdJoIsUxnFbbAxfWYUsUx/QN8+SOXc8g=
Received: from DS7PR05CA0054.namprd05.prod.outlook.com (2603:10b6:8:2f::28) by
 IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:38:09 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::2d) by DS7PR05CA0054.outlook.office365.com
 (2603:10b6:8:2f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18 via Frontend Transport; Tue,
 6 May 2025 09:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 09:38:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 04:38:07 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 04:38:05 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH v3 2/7] drm/amdgpu: update GPU addresses for SMU and PSP
Date: Tue, 6 May 2025 17:36:24 +0800
Message-ID: <20250506093629.249792-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250506093629.249792-1-guoqing.zhang@amd.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b16f7e2-55cc-417d-44b3-08dd8c81b5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?etK3CdcuN2UZROv0TFQ9NH/u1QK244lttFNfkb2E5L6oiGtJBd0v0YuPSzyx?=
 =?us-ascii?Q?uc3ArQ6lw+Sav4okjGUC/bqb1It9b6fMqEeanpVcLlA9/AKmlYJR3eyi40Wy?=
 =?us-ascii?Q?r7rDaB51VbcSHhO8OAbSvlwAQcifhs3xPBqwCWbiuJazZ1g/tvsX58BlAQkw?=
 =?us-ascii?Q?ZUIF/93gkkY3qGWiJkzeKnbyWN7fSf8uCXDYbbiLsUcMqqR+7I1wuFtCvs3M?=
 =?us-ascii?Q?/VxYz4L0vc3To0N4PQXmZSdpJwgeGDvBQSl2uxMhB5V9zxr/u+mbPVbjYXta?=
 =?us-ascii?Q?zgoMX+n0AuO14Fs0lgqkotZSuzQR3ZCPioF1VnDhSd6nrhSVPJZehnjPyElx?=
 =?us-ascii?Q?LQtz24hXQenZLYbrOiz5a/XUUghpUzUQJaJ0YheZUJelmOZBmRmc0cGez7dq?=
 =?us-ascii?Q?5F9FYmbhZJhm6H1BnNEbyjlbYGY+PTDrTtV6SKSJRKttwTAjkA6mqeiEbHzW?=
 =?us-ascii?Q?smZDNT2k5bKJZ6Mq8IvmQeh80LuLlwaj6sdE6hcrJotNSwDBrZpzjkV82vMv?=
 =?us-ascii?Q?yxWqAscqS3bxuF1W5tlmzmN22NH2k5NdWpN+5KGl+dWNixni6Z9HpxmHoMPC?=
 =?us-ascii?Q?YlGhfE34udCosZgOuyAGyBmSMYfTBS6cyxYoiHsgWwvgxnm6p14WJQ4yx14I?=
 =?us-ascii?Q?jojO05LCidVc6sazxAlbyj81dAhAbh0jzn2cLws34AF3EgVyoYYo4ydeEiEe?=
 =?us-ascii?Q?gEzIXp6IeAReW+Q4n8qX/9q3OJFrOFHkIoyP9I4ZuOSKKc/35MjdKjF1EPgh?=
 =?us-ascii?Q?b17fhbjsDMZjn3JLeswlUE8FBjAVnRBghuFVnSbUg7SE59baKhQPMvgLUjW1?=
 =?us-ascii?Q?irmaL6deofcElpgCc6g9b5g00DxsSXQ92ZE6jv79yHmalJW5S7luCKw1pPFS?=
 =?us-ascii?Q?MGpnS7S9JNmpQssMkc0BqSJ+e5Tm5+k6WeiVBVSQgmV6amP1gI8dp8ujFb3x?=
 =?us-ascii?Q?w4hrwhOwA2sYolyhFFF7PUyfLsr0yxreruDr4uHcvaTJ94iAZhMjL2HeVXbX?=
 =?us-ascii?Q?V5npZCeReXVR1o61821tgL74bfQ76qfOGecXKhLYKkbwi6BdhB1yhV6dZJHn?=
 =?us-ascii?Q?94pFIliDaT4EatkDNxlbDmaGPAeygFpsy2Igh5VsvsmwKeQN6cxaH2uoPHPq?=
 =?us-ascii?Q?H95kNX93IuVWYsqo7aXJE0iuYmRb1Jop4gXalYBaGbsbyEZAcYsckerx2W9m?=
 =?us-ascii?Q?1ycFjOnwXkgT+w6yz7+HHpPHwzckByOjvuWHhZmBO+e+r7GtCxj7HfUOexPg?=
 =?us-ascii?Q?J6QqkHqfpVqzZrlSkTK4ZNyUlNWjUWQee9+zStlQWoeg8h0RfVrSyIz3zs2q?=
 =?us-ascii?Q?+5BQEznBDqW1z2e4rf6QMN3oPsy1Hp0Bjd4dwU5cfUq1VrJkeESvPgeiX+Cs?=
 =?us-ascii?Q?SqlX117gsh6OXQrNkyMe+0FUVs5qZqfODoWItfH+7tm2JeWFJBbtnjwTpfFG?=
 =?us-ascii?Q?+LYFMag87qQF/EbHroTpDxwVxLVgPHiUqPcwd7CeLvVHyekNlModQT3JMpGy?=
 =?us-ascii?Q?eV4p/OKsIxk4jE6PB4LKRj2akETT2D9wHfFX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:38:08.5998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b16f7e2-55cc-417d-44b3-08dd8c81b5e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734
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


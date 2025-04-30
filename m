Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF73DC369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 10:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4445B10E722;
	Wed, 30 Apr 2025 10:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qZs+ogcz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B53010E722
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 10:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1JOYAvKdRWrmIx3c6QIQHCXwO1zP5tvjtf6sWL9PNTPZKRaE22+pRS6T7JSQmo6Rv4uqpIUH14TLScMU0gonNGDhtuYt1ZrZiyhSsUsCwVvuWsR0x3E+hqAf1479JIURBH9nXFQ2gC6lG5g+inhINzUdAfnnat4QthmkV+aq5/1296UfK4nYbXqgPlnOdH8Pdmpd0fHzfON0jsoQKDjRKyZIFgR68q8Bi4OiIot3lrX0OoOxdzeajX3bE+FESNfgJkLqrzXKNk5M3qIxE5vpXMqzCexeEn4PuRcG3XrVWz5cKJI9LIeDJXKnCbH3fXFwl0GGdwwWM4Ql9+zu/anoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKjiMcPlJ8lHcTQH094Hv7NHpXLwJ848lC0X8hijZVI=;
 b=ySAAmCnj4qJrn3DR5WPMxQj1mqvXG1L3wFCsuQFwpz9iLZkYB7SEyg/Hd6uUWJjJ/sFgJR244hgZ82n91+kC+vOjEBFwoDrxjLhE99+ExFGykP2UAdKKYb2D5aDhX46gLRJisBIJT18uWAGytlnPXfOcNPuSzwk0FI9HMiYMg4uPWwC144afk3PE5jqKLRoJQEsyY07YBKhdnt2zndfgkW4qWM59+m6yZQjfRi34B4wvwXof0n/R8IbJ1tPhdwnZSm9qSvji0icrOILvECMALLNI18QdnA/5VLxth6IQYQYBUM48cWNOM/XaLNLYix/WKCOdNYFWofCLMV5IJXi4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKjiMcPlJ8lHcTQH094Hv7NHpXLwJ848lC0X8hijZVI=;
 b=qZs+ogczutkMjXkkMzslUAfTG28J1rMyAQ4Pr9O0UblUji647rww65xPTrx6gDvw2f0ysln2AZ9oNEOrno1nCBe5Dp6VZsWq9XoxJQEigPnShB+LBjWBdHZqr7JNTcKX4nFHHMEzgrhiQ+xzsaPVXGNtDq6wT1HTXpxvAVyAHUM=
Received: from CH2PR12CA0007.namprd12.prod.outlook.com (2603:10b6:610:57::17)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 10:19:02 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::80) by CH2PR12CA0007.outlook.office365.com
 (2603:10b6:610:57::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 10:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 10:19:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 05:19:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 05:19:01 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Apr 2025 05:18:59 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>, Jiang Liu
 <gerry@linux.alibaba.com>
Subject: [PATCH v2 2/3] drm/amdgpu: update GPU addresses for SMU and PSP
Date: Wed, 30 Apr 2025 18:16:37 +0800
Message-ID: <20250430101638.649274-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250430101638.649274-1-guoqing.zhang@amd.com>
References: <20250430101638.649274-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 204785f9-3a19-4a51-3725-08dd87d06db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XVGfE2QO9obqJEV2/X6fxYyFrCmBygSAVp9NeToPVlN08QugSDOl2SJukOEj?=
 =?us-ascii?Q?NCWaIzJ+R4U1v3iA+QNBB8+k2MNgBeeL3mONrCp+GwZtyX1ApxY6Rl8+AzpE?=
 =?us-ascii?Q?ZMP+i4as1suDTmJ6UOWj0lx30JH/5S1SxbotefBtS47GDRpXnMMVM5N4Hme6?=
 =?us-ascii?Q?dIXXy+O6fBBO7tkSQs+tAe3I4gF60qQYCXkqSk4F+lcaLtmftLc5bWmlp+e7?=
 =?us-ascii?Q?KcjbwKHsjgCmYR+8HEuhA0Dy0L+y7GlmaqQGufZwm2HLlPDDl40HXWlbN8Cg?=
 =?us-ascii?Q?8Ujt8vEwPsbHSSWukdEN9dQZ7SMLQ5AXgxdJEqFIDbG00zbEpsbOmBQM+6iZ?=
 =?us-ascii?Q?w2kDNUeRguC/PxYPqy5PEC829lhRJawwvM34IWKoj2gvNz5TK4nwtH4BQLHC?=
 =?us-ascii?Q?GGqDJzvWOBYw1otosByJh/TPM4MsdW9w8rFbzgvBwCBieoNfpazFOM24ZXdU?=
 =?us-ascii?Q?VEVfnbRAFufSEu+XK1glkGEk3V9ZUneL2uLK87NQ/+EWWfc2w9VDAE5kLtyE?=
 =?us-ascii?Q?8uo4VPKPIoy88fBzv0/b+TrUChfiF2z5hUVEiE/da/4gaUTqSHfj8CU5Yzaj?=
 =?us-ascii?Q?c0e4v3WGYj54Q2aF6JFXJnE9g/X7WP8sA6cSPjwYTX8rivOra9HeIxBAUCoq?=
 =?us-ascii?Q?JyNDW5aEzOG0t5OE0l8TMR4UMTkdq29xRZo8z/DDYtLMEyHCRywNrNrs7vM4?=
 =?us-ascii?Q?mqkTfUeWTmdgj6XPpCau1L6qak/FcDrqQbn82CqyrXUx0mTnrCZ05nfFm4fQ?=
 =?us-ascii?Q?VSMbYhW2MbKShG4VKRFD/Bs93PrOkUOIaX9RCTwyDA1q+H17x+FirFjg558g?=
 =?us-ascii?Q?AL3M/bhdUdqRYcRD2Afsd1WQB3BFecaLYJIkAj/J52srUzybWy7/70a3Z/WD?=
 =?us-ascii?Q?AHugVygFDvsbCVg/r5ZGelKYYfu8Q5vNwuRhXnvKAIGYpPnft1YPljJepFb2?=
 =?us-ascii?Q?reSbLHuo7dObvcYUy+2BBVmPaQnxJkkVm0XnVc2avo5AsAaIB/swVHdLNn0C?=
 =?us-ascii?Q?c3gWy1Wj1aOMv17wqqOmZTxcDhkygOiAsVqCgVyUiQEKuTb1C+wK71cZ6Z/d?=
 =?us-ascii?Q?yypUdr5jHYKDNFtryMZuMqu10OQqHj1YnMFJSsusNxdRj4/T5G0PB55xVVn4?=
 =?us-ascii?Q?a6msYL3vMVzVVPATaEpmH7ROjQr44SiQ6k2U2YrCekis+Uz9NnhKBaUXcoKx?=
 =?us-ascii?Q?hH+EHtEnVGjq63qZmF3SHwyoc1M1VvVMcis/54SGUZgrpRWtnacCAJASCuSy?=
 =?us-ascii?Q?RXtfSkKqpWzYrq/0AdZX3RYHhbhzoturpPsFzK8XcQ1vCfNv3rLoMZaV0LuG?=
 =?us-ascii?Q?QoIthQS+zYclRn4CasXVOGZAs1SV3dfRJ8+8cD0v5mAoGAeYyZd0s50hfZLK?=
 =?us-ascii?Q?150WHlyVfFKFOHK3/fj3l12vd8ktvYnUHuqTJOv4R72dSRRc2lfeSICf2+hh?=
 =?us-ascii?Q?uqQSJraiHSGZDL+oul3GNv5s6vxaWEe2NnNxVZSMozhjMIlCZ2KONZVozcld?=
 =?us-ascii?Q?mAtiXskb9FEtiWMbFWC07fyLL1M7/ZUs+Uzz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 10:19:01.9248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 204785f9-3a19-4a51-3725-08dd87d06db3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 17 +++++++++++++++++
 7 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a2abddf3c110..ef6eaddc2ccb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -209,6 +209,7 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 	uint64_t vis_limit = (uint64_t)amdgpu_vis_vram_limit << 20;
 	uint64_t limit = (uint64_t)amdgpu_vram_limit << 20;
 
+	mc->vram_offset = base;
 	mc->vram_start = base;
 	mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
 	if (limit < mc->real_vram_size)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index bd7fc123b8f9..291d96168a57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -251,6 +251,7 @@ struct amdgpu_gmc {
 	 */
 	u64			vram_start;
 	u64			vram_end;
+	u64			vram_offset;
 	/* FB region , it's same as local vram region in single GPU, in XGMI
 	 * configuration, this region covers all GPUs in the same hive ,
 	 * each GPU in the hive has the same view of this FB region .
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4e794d546b61..ca29270f66d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1513,6 +1513,24 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
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
+	uint64_t offset;
+
+	WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
+
+	offset = (bo->tbo.resource->start << PAGE_SHIFT) + adev->gmc.vram_offset;
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


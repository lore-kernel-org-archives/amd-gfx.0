Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD880CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 07:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D5810EAD8;
	Thu, 26 Sep 2024 07:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e4301Asi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A6E10EAD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 07:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PS3JZbKFRcuYTSz0QMur5YI8lLHqka6V2g8Xwp6mzIkFpn5fi2KqvkF5MkZpMwVkQlYzb3bwVYn0CsKP1yRVXKq7kvIlM4r5aXcCEZUIthN2nGoen5BKhaB48JXVzkx+28zgIyzHiK0qVNG3KUwkJ7K2M+IXg3CdqbvukG7XBQRV/dTi1udnGiWpTaWnDCXxNeaYLtnENvM2XrYmdCmY6RxIuHpyvf0wk7udPx4JEbld6J/JYNrkAjpbHR/XZKwp5O1t2ut7mWxn+lJuZlVjQXwEDQzhj4NmC7l75kaKSQTcGZ5KPlvQeVP5PeQ1DIBzi9U4jJygpi1M2SUQvy/f0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69p38w+etApDobPo5Foy5kNYWrNujnUfUd+BjHJp8Hc=;
 b=XGBHUoSdfgpmTnXiagYciqgFcbCgPIDPKs139QWa9+0hzk4YK4t6osSTuD0kLvwt5Zf5YkZgMPXFW/3vbehxMUA//zfN/BNneq8JmnO7E5puYNKGFAmsr6YwCWHOihn29hLzJ3DVnnxmgFDwy+/99GWPeyDuEBQ8eNgCzShHnHGrUNm5I/Ka3TujK1nin26aFoen2RPQ04V13nVHmtJi5c8ER5tGjWhUxnrSpfSI7aKnfeEDVnvYkPNzkDpOpp09othmuMDnk/yoo0QMbDfBSjiEfyFSgE4RX/Xy6gJlW1aQoi/iNREV6ft+S4E7PJQZpbh9ways1CsEgetSeLpZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69p38w+etApDobPo5Foy5kNYWrNujnUfUd+BjHJp8Hc=;
 b=e4301AsiNiIompErogzRjwtdAWLanEWct5fEbB256v+KhMYVOOIDIFLW6c2XTfs/Su3LdAlqYDA4H/V7nR6zI1OLawC10OKd+cLcwqop0KWvg2nxaeyVmk8O6EFBChYJbWLNN7+QxqXpJLEr3NsPheT146xb8lsUOjaC8ER36lY=
Received: from BN9PR03CA0772.namprd03.prod.outlook.com (2603:10b6:408:13a::27)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 07:48:04 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::5a) by BN9PR03CA0772.outlook.office365.com
 (2603:10b6:408:13a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26 via Frontend
 Transport; Thu, 26 Sep 2024 07:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 07:48:04 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 02:47:59 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu/sdma5.2: split out per instance resume
 function
Date: Thu, 26 Sep 2024 15:45:35 +0800
Message-ID: <20240926074536.22211-3-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926074536.22211-1-jiadong.zhu@amd.com>
References: <20240926074536.22211-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 75dc3d6f-e987-4516-787f-08dcddff8dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YPGOzm9tOm8kPsvKGGx1CojH4prs6KVwfPcKZvTG0jB5hBzrRZFap+os3OdI?=
 =?us-ascii?Q?99l09pFNoQYffuVU5EoM4LAlwJE8K3T3+Fhoeuz7JeEpaRtNz2VY3W43lqWF?=
 =?us-ascii?Q?S0DwkY1oSd1GRGdc3KL6yhDe01BBifcJoujERVjOPRrMWdeDBu1MvcUBwWU4?=
 =?us-ascii?Q?AlxewOYmVi0LBwCdGV4OhjY6cWoRkT6GtNg4w1hwYgbAY1mlp4SnkVFOHlbD?=
 =?us-ascii?Q?ug05XPdp7mzQnkwYXFYsZEX1jMNumf0w+1rWZARgmHMegJtj7bYnSoTbu+ab?=
 =?us-ascii?Q?4DeCW4BkeKaPE3GsjB0DRQkCOwZu75Jsxhw53Tg7iYnUgLM7LsV+Tv1pvhBI?=
 =?us-ascii?Q?b6kh6ucHqCrdEKHN9Z1qyzd7E9SJhvApAocr+3+KEktcdncE+ZkJJYt4/0EQ?=
 =?us-ascii?Q?4KQGhx6Y+P125RKZ9aL6OBlwm98jFo9aHh0vRUIcTr+28WTfnyLV5pBo8Wud?=
 =?us-ascii?Q?yuRD7abfxXoqX0mdQPBrkQQdjuMaeY42Z3wYCb+H7vSrLGzfNrgvJItmY3GO?=
 =?us-ascii?Q?J9yq9Q0sbadNGRaEk8FR5dk0COKXdtP2K5W9emTl2mmS2g8Sme1mzHjfJAEq?=
 =?us-ascii?Q?1205g3y41XqG7RxDyyivYojAHGocih/1XbZ1iYNOYMECNta+OSbKKDAikCS3?=
 =?us-ascii?Q?JJHjOsVJqeqgB8Lz36vlRyfNMNNluf54AuzKK8o2gH6g821Ynk+JLTjYRw1B?=
 =?us-ascii?Q?vu+p4r4d/01DO58xzEYzdC1UYVal+qHzmFWtlAnw26NLc1NCc8jrZW+oWx9L?=
 =?us-ascii?Q?V79L+nPHNpz91Xo8AzzxO3wcWeo5IcXGoTWw4/6TMNHa4122Ups1LaLKN1Tf?=
 =?us-ascii?Q?qjLxpwZm4qBZnF7KNvc1el1ddv1TbiHO97rS2m84ByNDlD+SWmcEi+/Lwcoo?=
 =?us-ascii?Q?db+lWhoSqFcFqff9LYfz/bjtl9avzY1e1ZmCRK6DrO0YNXNIbztqa8p1qvVC?=
 =?us-ascii?Q?cvPozU8cfPXSdGk0V7PqLCAIilI97yrp8VJcM1QMutiH4YrN8X9/xgpkGHiA?=
 =?us-ascii?Q?TNwz/D5JJytga91PToCw1N07rDGEOqTvVCtCwym0Rs9Ha8U0XT20wN/ilcVA?=
 =?us-ascii?Q?WENcUP9IoHjPXUtQ22ggIFs2RUwp3xrjIzJ8th/iNoY0b72qiaEh/kQ5g6KZ?=
 =?us-ascii?Q?fpwtNO/79g5evD0kTBra8R2D8yW0ihrjDlx/Jom1fj/dF+9+N3xXg1/XBQhW?=
 =?us-ascii?Q?v+JcFO/Eml3ZKHORns2GxihQpOehzrZzHnl3CvPagzGENTTEuDu+/rOuT9xM?=
 =?us-ascii?Q?s7AWs2gZgLZwoLcn2jijIu50BsLmXlQnxyup5IjgpyP8mPhimWI4sHK3xrHd?=
 =?us-ascii?Q?9MRpZ4tm9S1mxICL7y6iRkSB3vjFYYvsGLzGrrai8IFQcj/tIVW9X7k6J7l+?=
 =?us-ascii?Q?kTo12BJrgSEw43yOoG4AoHrB1i3xWC3Wi0P2MK9ysI6bfQ+skp7IsDTXy7Nj?=
 =?us-ascii?Q?MPBKZKyoyxgKuwQeCsZb2qNiVphH+/HC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 07:48:04.4242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dc3d6f-e987-4516-787f-08dcddff8dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Extract the resume sequence from sdma_v5_2_gfx_resume for
starting/restarting an individual instance.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 247 ++++++++++++++-----------
 1 file changed, 136 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index bc9b240a3488..37534c6f431f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -522,14 +522,17 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
 }
 
 /**
- * sdma_v5_2_gfx_resume - setup and start the async dma engines
+ * sdma_v5_2_gfx_resume_instance - start/restart a certain sdma engine
  *
  * @adev: amdgpu_device pointer
+ * @i: instance
+ * @restore: used to restore wptr when restart
  *
- * Set up the gfx DMA ring buffers and enable them.
- * Returns 0 for success, error for failure.
+ * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
+ * Return 0 for success.
  */
-static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
+
+static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
@@ -539,139 +542,161 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 	u32 temp;
 	u32 wptr_poll_cntl;
 	u64 wptr_gpu_addr;
-	int i, r;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
+	ring = &adev->sdma.instance[i].ring;
 
-		if (!amdgpu_sriov_vf(adev))
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+	if (!amdgpu_sriov_vf(adev))
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
-		/* Set ring buffer size in dwords */
-		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
-					RPTR_WRITEBACK_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
+				RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
-
-		/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+
+	/* Initialize the ring buffer's read and write pointers */
+	if (restore) {
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
+	} else {
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
+	}
 
-		/* setup the wptr shadow polling */
-		wptr_gpu_addr = ring->wptr_gpu_addr;
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
-		       lower_32_bits(wptr_gpu_addr));
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
-		       upper_32_bits(wptr_gpu_addr));
-		wptr_poll_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
-							 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
-		wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
-					       SDMA0_GFX_RB_WPTR_POLL_CNTL,
-					       F32_POLL_ENABLE, 1);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
-		       wptr_poll_cntl);
-
-		/* set the wb address whether it's enabled or not */
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
-		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
-		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
-
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
-
+	/* setup the wptr shadow polling */
+	wptr_gpu_addr = ring->wptr_gpu_addr;
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
+	       lower_32_bits(wptr_gpu_addr));
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
+	       upper_32_bits(wptr_gpu_addr));
+	wptr_poll_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
+						 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
+	wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
+				       SDMA0_GFX_RB_WPTR_POLL_CNTL,
+				       F32_POLL_ENABLE, 1);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
+	       wptr_poll_cntl);
+
+	/* set the wb address whether it's enabled or not */
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
+	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
+	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
+
+	if (!restore)
 		ring->wptr = 0;
 
-		/* before programing wptr to a less value, need set minor_ptr_update first */
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
+	/* before programing wptr to a less value, need set minor_ptr_update first */
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
 
-		if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
-		}
+	if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
+	}
 
-		doorbell = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
-		doorbell_offset = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
+	doorbell = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
+	doorbell_offset = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
 
-		if (ring->use_doorbell) {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
-			doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_GFX_DOORBELL_OFFSET,
-					OFFSET, ring->doorbell_index);
-		} else {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
-		}
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
+	if (ring->use_doorbell) {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
+		doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_GFX_DOORBELL_OFFSET,
+				OFFSET, ring->doorbell_index);
+	} else {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
+	}
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
 
-		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
-						      ring->doorbell_index,
-						      adev->doorbell_index.sdma_doorbell_range);
+	adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
+					      ring->doorbell_index,
+					      adev->doorbell_index.sdma_doorbell_range);
 
-		if (amdgpu_sriov_vf(adev))
-			sdma_v5_2_ring_set_wptr(ring);
+	if (amdgpu_sriov_vf(adev))
+		sdma_v5_2_ring_set_wptr(ring);
 
-		/* set minor_ptr_update to 0 after wptr programed */
+	/* set minor_ptr_update to 0 after wptr programed */
 
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
-		/* SRIOV VF has no control of any of registers below */
-		if (!amdgpu_sriov_vf(adev)) {
-			/* set utc l1 enable flag always to 1 */
-			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
-
-			/* enable MCBP */
-			temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
-
-			/* Set up RESP_MODE to non-copy addresses */
-			temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
-
-			/* program default cache read and write policy */
-			temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
-			/* clean read policy and write policy bits */
-			temp &= 0xFF0FFF;
-			temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
-				 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
-				 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
-
-			/* unhalt engine */
-			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), temp);
-		}
+	/* SRIOV VF has no control of any of registers below */
+	if (!amdgpu_sriov_vf(adev)) {
+		/* set utc l1 enable flag always to 1 */
+		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
+
+		/* enable MCBP */
+		temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
+
+		/* Set up RESP_MODE to non-copy addresses */
+		temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
+		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
+
+		/* program default cache read and write policy */
+		temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
+		/* clean read policy and write policy bits */
+		temp &= 0xFF0FFF;
+		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
+			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
+			 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
+
+		/* unhalt engine */
+		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), temp);
+	}
 
-		/* enable DMA RB */
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+	/* enable DMA RB */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
-		ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
-		/* enable DMA IBs */
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+	/* enable DMA IBs */
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v5_2_ctx_switch_enable(adev, true);
-			sdma_v5_2_enable(adev, true);
-		}
+	if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
+		sdma_v5_2_ctx_switch_enable(adev, true);
+		sdma_v5_2_enable(adev, true);
+	}
+
+	return amdgpu_ring_test_helper(ring);
+}
 
-		r = amdgpu_ring_test_helper(ring);
+/**
+ * sdma_v5_2_gfx_resume - setup and start the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set up the gfx DMA ring buffers and enable them.
+ * Returns 0 for success, error for failure.
+ */
+static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		r = sdma_v5_2_gfx_resume_instance(adev, i, false);
 		if (r)
 			return r;
 	}
-- 
2.25.1


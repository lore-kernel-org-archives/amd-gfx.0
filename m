Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A216DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074F810F126;
	Fri, 29 Apr 2022 17:46:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 049C810F136
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk45+2gIyKNQ92Mcl/CFU3IllI/DMGs8Oe3KaB64oICOzGaBixClUKLERx/YVLOOFLJ2PJJHLAht7K6+8dBk2tFSe8xSbkkUm3dW6v51Nlm651EyGpYaAAlVug2vClhBMDjbKxEONqJr6Xj3npJS41P4QJ9eWFngJzt4RlymFP46t7TFnfl7HW7/Wm6cHFOI5ETjpr4lNLxDZoQ85ceIb7QskvGibXlEGhzodPNs01yBxYlPzhsyMuvJdF+SMeJWFLfML0Nc7Ncl9do9GSU3TmUmq7L8b2RxAb4PxW9g6PrTHnQkYmEruOci6TvEDxAW31xOv+1tb6ExUGaIthdrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21pRA6NyXhl5h/mMFyMoVXr+OqnX/9uQXmlCJTN5tHc=;
 b=VdECfjdoHwpQgPXjmGWyDbRe6zeSCYpKUN4WkgBLMF+52JP5Iq4yfNkTpFAtkxC3l8thobknHapexUjtHnFHvV1pBEhoWTzIeDMP2HoNn1Pe+AfktBcboTnNGaIZx3G55gmsKL8VcC3aqIUGZOp/Vkn2090f/ASjsgogG2gkvqBEurbVIa5fa5KRt4kUtGf7R/YWmjm9jNsq2vxFkDOdgtgkJjGWkMSPa9RSlb6dRAWKw01gog/h4gkOxJxaLz7ZaY4KvPQZDxcluCYEstoGN8uS5Fzk5oSt/aTmAqQT7l/ObzCxOzJRpILX0ai9hqhZd6vxQw6tK8XkwAkySrNPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21pRA6NyXhl5h/mMFyMoVXr+OqnX/9uQXmlCJTN5tHc=;
 b=Ms1dxoGT7thJEWgaV4uItci984cOcw/HubEV4Z7q/bsixZQ/b6NB5OGhJn47rYuYmNINJ21ziipPkKtLOwC7gZKnLMHep3PCRa5zF9VAoqV6hGAZCCQlVV3rIwE+uEpl9fK9psMKR/f1cjvXFUYEGyVaNAv5a3d9x70oNvk3kKc=
Received: from DM5PR08CA0060.namprd08.prod.outlook.com (2603:10b6:4:60::49) by
 BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Fri, 29 Apr
 2022 17:46:41 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::9) by DM5PR08CA0060.outlook.office365.com
 (2603:10b6:4:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/73] drm/amdgpu: use ring structure to access rptr/wptr v2
Date: Fri, 29 Apr 2022 13:45:17 -0400
Message-ID: <20220429174624.459475-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72da2c79-a42a-4158-beb1-08da2a0837fd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5318933DB91B440AD0CE2B94F7FC9@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86ufdSLKNgEBev3t3Vu7budlbff8E/ugym/mFZcvbZFZvTxiwiC7vFuZTj/+Kx2vhMf7LtBf6t032aSWybgLb+83QJgak3EL0E7/5aGV6GkhfaMz/muZmtHNEt7agjRqVdBe1/3UlpHqAaTlpvNvBDTqettyN2mqYIXcfbvhYu1sHm0UWU+GlBU7HOwDI8pI2IPTJ4F8yqoioqZ8kZKSsGiyKnwSYGOogCTqEjcc4gOqkNsVvM1J1joniBYroM72SbZIlI/ZH1gtjfJMUaBHIUNW5WX1eHe3PQV0G9260LuoSjE0SZYqafY6/aoKc6IkU/Q51uYxT7uMFZjpwvramPkSyhy3/8YKDZ2MMVWDsITjQs4904S0+EUTxsBd8Nu20U7lsRHWf51556jkYTBN0hPnz1zE9/KIh6wHrAMAlCz8hgfReH/I851S1Wq7IF2Uq+tmSVk8vJon8pXXB+Ux7OLrNkIVElKvx1D8OiZe+njza3l2f53TI2qZxsES+a237iePTBT7NzCWbZuv7GK5KXebq4z4B+M3BDJv20ElSEiGPlzlAtTLDwnl1pG/KjreI0sQvshmSBmP03JplQvJDuUNaCKVimqWv1InnKUUWX9IoQwSizIDo8TeiPOBc9WH4zZrqwVaPtz7wC2lbJQ1Eis6LSNAKlnNCqul6tChflAYHFXQafKdlCNOpc7t13P4/LDlhZELtcoJJWDrXQs0b5as5op974kXkpYOdfKmHVkIrUmogy/9RqQ7Qwt0sce5BCKP9TroXccv+6KZj4FmjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(26005)(6666004)(7696005)(36860700001)(81166007)(16526019)(186003)(426003)(356005)(47076005)(40460700003)(1076003)(66574015)(2616005)(336012)(5660300002)(316002)(8676002)(70586007)(70206006)(4326008)(82310400005)(36756003)(2906002)(30864003)(54906003)(8936002)(508600001)(6916009)(83380400001)(21314003)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:41.2890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72da2c79-a42a-4158-beb1-08da2a0837fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Use ring structure to access the cpu/gpu address of rptr/wptr.

v2: merge gfx10/sdma5/sdma5.2 patches

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c  |  8 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 37 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c  |  8 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 16 +++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 20 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 25 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 11 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c |  8 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 16 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 28 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 16 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 16 +++++------
 drivers/gpu/drm/amd/amdgpu/si_dma.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c  |  6 ++---
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c  |  6 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c  | 12 ++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c  | 12 ++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c  | 12 ++++-----
 21 files changed, 128 insertions(+), 145 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 6c01199e9112..5647f13b98d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -164,7 +164,7 @@ static uint64_t cik_sdma_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	u32 rptr;
 
-	rptr = ring->adev->wb.wb[ring->rptr_offs];
+	rptr = *ring->rptr_cpu_addr;
 
 	return (rptr & 0x3fffc) >> 2;
 }
@@ -436,12 +436,10 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
 	u32 rb_bufsz;
-	u32 wb_offset;
 	int i, j, r;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		wb_offset = (ring->rptr_offs * 4);
 
 		mutex_lock(&adev->srbm_mutex);
 		for (j = 0; j < 16; j++) {
@@ -477,9 +475,9 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
 
 		/* set the wb address whether it's enabled or not */
 		WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_HI + sdma_offsets[i],
-		       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
+		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
 		WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_LO + sdma_offsets[i],
-		       ((adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC));
+		       ((ring->rptr_gpu_addr) & 0xFFFFFFFC));
 
 		rb_cntl |= SDMA0_GFX_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 407074f958f4..f2dd53f2af61 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3519,9 +3519,8 @@ static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue
 static void gfx10_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 				 struct amdgpu_ring *ring)
 {
-	struct amdgpu_device *adev = kiq_ring->adev;
 	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
-	uint64_t wptr_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	uint64_t wptr_addr = ring->wptr_gpu_addr;
 	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
@@ -6344,12 +6343,12 @@ static int gfx_v10_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI, upper_32_bits(ring->wptr));
 
 	/* set the wb address wether it's enabled or not */
-	rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	rptr_addr = ring->rptr_gpu_addr;
 	WREG32_SOC15(GC, 0, mmCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr));
 	WREG32_SOC15(GC, 0, mmCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
 		     CP_RB_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
 
-	wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wptr_gpu_addr = ring->wptr_gpu_addr;
 	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
 		     lower_32_bits(wptr_gpu_addr));
 	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
@@ -6382,11 +6381,11 @@ static int gfx_v10_0_cp_gfx_resume(struct amdgpu_device *adev)
 		WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lower_32_bits(ring->wptr));
 		WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI, upper_32_bits(ring->wptr));
 		/* Set the wb address wether it's enabled or not */
-		rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+		rptr_addr = ring->rptr_gpu_addr;
 		WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
 		WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
 			     CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
-		wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+		wptr_gpu_addr = ring->wptr_gpu_addr;
 		WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
 			     lower_32_bits(wptr_gpu_addr));
 		WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
@@ -6610,13 +6609,13 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_gfx_hqd_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up hqd_rptr_addr/_hi, similar as CP_RB_RPTR */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	wb_gpu_addr = ring->rptr_gpu_addr;
 	mqd->cp_gfx_hqd_rptr_addr = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_gfx_hqd_rptr_addr_hi =
 		upper_32_bits(wb_gpu_addr) & 0xffff;
 
 	/* set up rb_wptr_poll addr */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wb_gpu_addr = ring->wptr_gpu_addr;
 	mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
@@ -6730,7 +6729,7 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
-		adev->wb.wb[ring->wptr_offs] = 0;
+		*ring->wptr_cpu_addr = 0;
 		amdgpu_ring_clear_ring(ring);
 #ifdef BRING_UP_DEBUG
 		mutex_lock(&adev->srbm_mutex);
@@ -6904,13 +6903,13 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_control = tmp;
 
 	/* set the wb address whether it's enabled or not */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	wb_gpu_addr = ring->rptr_gpu_addr;
 	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_rptr_report_addr_hi =
 		upper_32_bits(wb_gpu_addr) & 0xffff;
 
 	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wb_gpu_addr = ring->wptr_gpu_addr;
 	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
@@ -7130,7 +7129,7 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		/* reset ring buffer */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	} else {
 		amdgpu_ring_clear_ring(ring);
@@ -8496,7 +8495,8 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u64 *flags)
 
 static u64 gfx_v10_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->rptr_offs]; /* gfx10 is 32bit rptr*/
+	/* gfx10 is 32bit rptr*/
+	return *(uint32_t *)ring->rptr_cpu_addr;
 }
 
 static u64 gfx_v10_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
@@ -8506,7 +8506,7 @@ static u64 gfx_v10_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		wptr = atomic64_read((atomic64_t *)&adev->wb.wb[ring->wptr_offs]);
+		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
 	} else {
 		wptr = RREG32_SOC15(GC, 0, mmCP_RB0_WPTR);
 		wptr += (u64)RREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI) << 32;
@@ -8521,7 +8521,7 @@ static void gfx_v10_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], ring->wptr);
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		WREG32_SOC15(GC, 0, mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
@@ -8531,7 +8531,8 @@ static void gfx_v10_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 
 static u64 gfx_v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->rptr_offs]; /* gfx10 hardware is 32bit rptr */
+	/* gfx10 hardware is 32bit rptr */
+	return *(uint32_t *)ring->rptr_cpu_addr;
 }
 
 static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
@@ -8540,7 +8541,7 @@ static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)&ring->adev->wb.wb[ring->wptr_offs]);
+		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
@@ -8552,7 +8553,7 @@ static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], ring->wptr);
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		BUG(); /* only DOORBELL method supported on gfx10 now */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 6a8dadea40f9..29a91b320d4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2117,7 +2117,7 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32(mmCP_RB0_WPTR, ring->wptr);
 
 	/* set the wb address whether it's enabled or not */
-	rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	rptr_addr = ring->rptr_gpu_addr;
 	WREG32(mmCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr));
 	WREG32(mmCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
 
@@ -2139,7 +2139,7 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 
 static u64 gfx_v6_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->rptr_offs];
+	return *ring->rptr_cpu_addr;
 }
 
 static u64 gfx_v6_0_ring_get_wptr(struct amdgpu_ring *ring)
@@ -2203,7 +2203,7 @@ static int gfx_v6_0_cp_compute_resume(struct amdgpu_device *adev)
 	ring->wptr = 0;
 	WREG32(mmCP_RB1_WPTR, ring->wptr);
 
-	rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	rptr_addr = ring->rptr_gpu_addr;
 	WREG32(mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
 	WREG32(mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
 
@@ -2222,7 +2222,7 @@ static int gfx_v6_0_cp_compute_resume(struct amdgpu_device *adev)
 	WREG32(mmCP_RB2_CNTL, tmp | CP_RB2_CNTL__RB_RPTR_WR_ENA_MASK);
 	ring->wptr = 0;
 	WREG32(mmCP_RB2_WPTR, ring->wptr);
-	rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	rptr_addr = ring->rptr_gpu_addr;
 	WREG32(mmCP_RB2_RPTR_ADDR, lower_32_bits(rptr_addr));
 	WREG32(mmCP_RB2_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index d17a6f399347..ac3f2dbba726 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2630,8 +2630,8 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
 	ring->wptr = 0;
 	WREG32(mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
 
-	/* set the wb address whether it's enabled or not */
-	rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	/* set the wb address wether it's enabled or not */
+	rptr_addr = ring->rptr_gpu_addr;
 	WREG32(mmCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr));
 	WREG32(mmCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
 
@@ -2656,7 +2656,7 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
 
 static u64 gfx_v7_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->rptr_offs];
+	return *ring->rptr_cpu_addr;
 }
 
 static u64 gfx_v7_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
@@ -2677,7 +2677,7 @@ static void gfx_v7_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 static u64 gfx_v7_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
 	/* XXX check if swapping is necessary on BE */
-	return ring->adev->wb.wb[ring->wptr_offs];
+	return *ring->wptr_cpu_addr;
 }
 
 static void gfx_v7_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
@@ -2685,7 +2685,7 @@ static void gfx_v7_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	/* XXX check if swapping is necessary on BE */
-	adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+	*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 	WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 }
 
@@ -2981,12 +2981,12 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
 		CP_HQD_PQ_CONTROL__KMD_QUEUE_MASK; /* assuming kernel queue control */
 
 	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wb_gpu_addr = ring->wptr_gpu_addr;
 	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
-	/* set the wb address whether it's enabled or not */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	/* set the wb address wether it's enabled or not */
+	wb_gpu_addr = ring->rptr_gpu_addr;
 	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_rptr_report_addr_hi =
 		upper_32_bits(wb_gpu_addr) & 0xffff;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 25dc729d0ec2..e4e779a19c20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4306,11 +4306,11 @@ static int gfx_v8_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32(mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
 
 	/* set the wb address wether it's enabled or not */
-	rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	rptr_addr = ring->rptr_gpu_addr;
 	WREG32(mmCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr));
 	WREG32(mmCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
 
-	wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wptr_gpu_addr = ring->wptr_gpu_addr;
 	WREG32(mmCP_RB_WPTR_POLL_ADDR_LO, lower_32_bits(wptr_gpu_addr));
 	WREG32(mmCP_RB_WPTR_POLL_ADDR_HI, upper_32_bits(wptr_gpu_addr));
 	mdelay(1);
@@ -4393,7 +4393,7 @@ static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
 		uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
-		uint64_t wptr_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+		uint64_t wptr_addr = ring->wptr_gpu_addr;
 
 		/* map queues */
 		amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
@@ -4517,13 +4517,13 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_control = tmp;
 
 	/* set the wb address whether it's enabled or not */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	wb_gpu_addr = ring->rptr_gpu_addr;
 	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_rptr_report_addr_hi =
 		upper_32_bits(wb_gpu_addr) & 0xffff;
 
 	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wb_gpu_addr = ring->wptr_gpu_addr;
 	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
@@ -6051,7 +6051,7 @@ static int gfx_v8_0_set_clockgating_state(void *handle,
 
 static u64 gfx_v8_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->rptr_offs];
+	return *ring->rptr_cpu_addr;
 }
 
 static u64 gfx_v8_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
@@ -6060,7 +6060,7 @@ static u64 gfx_v8_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell)
 		/* XXX check if swapping is necessary on BE */
-		return ring->adev->wb.wb[ring->wptr_offs];
+		return *ring->wptr_cpu_addr;
 	else
 		return RREG32(mmCP_RB0_WPTR);
 }
@@ -6071,7 +6071,7 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32(mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
@@ -6271,7 +6271,7 @@ static void gfx_v8_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 
 static u64 gfx_v8_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->wptr_offs];
+	return *ring->wptr_cpu_addr;
 }
 
 static void gfx_v8_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
@@ -6279,7 +6279,7 @@ static void gfx_v8_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	/* XXX check if swapping is necessary on BE */
-	adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+	*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 	WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d58fd83524ac..06182b7e4351 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -780,9 +780,8 @@ static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 static void gfx_v9_0_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 				 struct amdgpu_ring *ring)
 {
-	struct amdgpu_device *adev = kiq_ring->adev;
 	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
-	uint64_t wptr_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	uint64_t wptr_addr = ring->wptr_gpu_addr;
 	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
@@ -3326,11 +3325,11 @@ static int gfx_v9_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI, upper_32_bits(ring->wptr));
 
 	/* set the wb address wether it's enabled or not */
-	rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	rptr_addr = ring->rptr_gpu_addr;
 	WREG32_SOC15(GC, 0, mmCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr));
 	WREG32_SOC15(GC, 0, mmCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & CP_RB_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
 
-	wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wptr_gpu_addr = ring->wptr_gpu_addr;
 	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO, lower_32_bits(wptr_gpu_addr));
 	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI, upper_32_bits(wptr_gpu_addr));
 
@@ -3542,13 +3541,13 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_control = tmp;
 
 	/* set the wb address whether it's enabled or not */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	wb_gpu_addr = ring->rptr_gpu_addr;
 	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_rptr_report_addr_hi =
 		upper_32_bits(wb_gpu_addr) & 0xffff;
 
 	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wb_gpu_addr = ring->wptr_gpu_addr;
 	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
@@ -3830,7 +3829,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		/* reset ring buffer */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	} else {
 		amdgpu_ring_clear_ring(ring);
@@ -5279,7 +5278,7 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u64 *flags)
 
 static u64 gfx_v9_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->rptr_offs]; /* gfx9 is 32bit rptr*/
+	return *ring->rptr_cpu_addr; /* gfx9 is 32bit rptr*/
 }
 
 static u64 gfx_v9_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
@@ -5289,7 +5288,7 @@ static u64 gfx_v9_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		wptr = atomic64_read((atomic64_t *)&adev->wb.wb[ring->wptr_offs]);
+		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
 	} else {
 		wptr = RREG32_SOC15(GC, 0, mmCP_RB0_WPTR);
 		wptr += (u64)RREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI) << 32;
@@ -5304,7 +5303,7 @@ static void gfx_v9_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], ring->wptr);
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		WREG32_SOC15(GC, 0, mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
@@ -5469,7 +5468,7 @@ static void gfx_v9_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->rptr_offs]; /* gfx9 hardware is 32bit rptr */
+	return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit rptr */
 }
 
 static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
@@ -5478,7 +5477,7 @@ static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)&ring->adev->wb.wb[ring->wptr_offs]);
+		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
@@ -5490,7 +5489,7 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], ring->wptr);
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else{
 		BUG(); /* only DOORBELL method supported on gfx9 now */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 299de1d131d8..d2722adabd1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -407,7 +407,7 @@ static uint64_t jpeg_v2_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return *ring->wptr_cpu_addr;
 	else
 		return RREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR);
 }
@@ -424,7 +424,7 @@ static void jpeg_v2_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 8c3227d0b8b4..c2bf036a7330 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -402,7 +402,7 @@ static uint64_t jpeg_v2_5_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return *ring->wptr_cpu_addr;
 	else
 		return RREG32_SOC15(JPEG, ring->me, mmUVD_JRBC_RB_WPTR);
 }
@@ -419,7 +419,7 @@ static void jpeg_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(JPEG, ring->me, mmUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 41a00851b6c5..a1b751d9ac06 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -427,7 +427,7 @@ static uint64_t jpeg_v3_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return *ring->wptr_cpu_addr;
 	else
 		return RREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR);
 }
@@ -444,7 +444,7 @@ static void jpeg_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index a7ec4ac89da5..0819ffe8e759 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -46,7 +46,7 @@ static void mes_v10_1_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs],
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
@@ -56,7 +56,7 @@ static void mes_v10_1_ring_set_wptr(struct amdgpu_ring *ring)
 
 static u64 mes_v10_1_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->rptr_offs];
+	return *ring->rptr_cpu_addr;
 }
 
 static u64 mes_v10_1_ring_get_wptr(struct amdgpu_ring *ring)
@@ -64,8 +64,7 @@ static u64 mes_v10_1_ring_get_wptr(struct amdgpu_ring *ring)
 	u64 wptr;
 
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)
-				     &ring->adev->wb.wb[ring->wptr_offs]);
+		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
@@ -673,13 +672,13 @@ static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_control = tmp;
 
 	/* set the wb address whether it's enabled or not */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	wb_gpu_addr = ring->rptr_gpu_addr;
 	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_rptr_report_addr_hi =
 		upper_32_bits(wb_gpu_addr) & 0xffff;
 
 	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	wb_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wb_gpu_addr = ring->wptr_gpu_addr;
 	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffff8;
 	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 84b57b06b20c..6bdffdc1c0b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -194,7 +194,7 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 static uint64_t sdma_v2_4_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	/* XXX check if swapping is necessary on BE */
-	return ring->adev->wb.wb[ring->rptr_offs] >> 2;
+	return *ring->rptr_cpu_addr >> 2;
 }
 
 /**
@@ -414,12 +414,10 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
 	u32 rb_bufsz;
-	u32 wb_offset;
 	int i, j, r;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		wb_offset = (ring->rptr_offs * 4);
 
 		mutex_lock(&adev->srbm_mutex);
 		for (j = 0; j < 16; j++) {
@@ -455,9 +453,9 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
 
 		/* set the wb address whether it's enabled or not */
 		WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_HI + sdma_offsets[i],
-		       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
+		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
 		WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_LO + sdma_offsets[i],
-		       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
+		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 8af5c94d526a..2584fa3cb13e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -350,7 +350,7 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 static uint64_t sdma_v3_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	/* XXX check if swapping is necessary on BE */
-	return ring->adev->wb.wb[ring->rptr_offs] >> 2;
+	return *ring->rptr_cpu_addr >> 2;
 }
 
 /**
@@ -367,7 +367,7 @@ static uint64_t sdma_v3_0_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell || ring->use_pollmem) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = ring->adev->wb.wb[ring->wptr_offs] >> 2;
+		wptr = *ring->wptr_cpu_addr >> 2;
 	} else {
 		wptr = RREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me]) >> 2;
 	}
@@ -387,12 +387,12 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
+		u32 *wb = (u32 *)ring->wptr_cpu_addr;
 		/* XXX check if swapping is necessary on BE */
 		WRITE_ONCE(*wb, ring->wptr << 2);
 		WDOORBELL32(ring->doorbell_index, ring->wptr << 2);
 	} else if (ring->use_pollmem) {
-		u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
+		u32 *wb = (u32 *)ring->wptr_cpu_addr;
 
 		WRITE_ONCE(*wb, ring->wptr << 2);
 	} else {
@@ -649,7 +649,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
 	u32 rb_bufsz;
-	u32 wb_offset;
 	u32 doorbell;
 	u64 wptr_gpu_addr;
 	int i, j, r;
@@ -657,7 +656,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 		amdgpu_ring_clear_ring(ring);
-		wb_offset = (ring->rptr_offs * 4);
 
 		mutex_lock(&adev->srbm_mutex);
 		for (j = 0; j < 16; j++) {
@@ -694,9 +692,9 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 
 		/* set the wb address whether it's enabled or not */
 		WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_HI + sdma_offsets[i],
-		       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
+		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
 		WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_LO + sdma_offsets[i],
-		       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
+		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
 
@@ -715,7 +713,7 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 		WREG32(mmSDMA0_GFX_DOORBELL + sdma_offsets[i], doorbell);
 
 		/* setup the wptr shadow polling */
-		wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+		wptr_gpu_addr = ring->wptr_gpu_addr;
 
 		WREG32(mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO + sdma_offsets[i],
 		       lower_32_bits(wptr_gpu_addr));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 80de85847712..65181efba50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -722,7 +722,7 @@ static uint64_t sdma_v4_0_ring_get_rptr(struct amdgpu_ring *ring)
 	u64 *rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = ((u64 *)&ring->adev->wb.wb[ring->rptr_offs]);
+	rptr = ((u64 *)ring->rptr_cpu_addr);
 
 	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
 	return ((*rptr) >> 2);
@@ -742,7 +742,7 @@ static uint64_t sdma_v4_0_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
+		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
 		wptr = RREG32_SDMA(ring->me, mmSDMA0_GFX_RB_WPTR_HI);
@@ -768,7 +768,7 @@ static void sdma_v4_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 	DRM_DEBUG("Setting write pointer\n");
 	if (ring->use_doorbell) {
-		u64 *wb = (u64 *)&adev->wb.wb[ring->wptr_offs];
+		u64 *wb = (u64 *)ring->wptr_cpu_addr;
 
 		DRM_DEBUG("Using doorbell -- "
 				"wptr_offs == 0x%08x "
@@ -811,7 +811,7 @@ static uint64_t sdma_v4_0_page_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
+		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
 	} else {
 		wptr = RREG32_SDMA(ring->me, mmSDMA0_PAGE_RB_WPTR_HI);
 		wptr = wptr << 32;
@@ -833,7 +833,7 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		u64 *wb = (u64 *)&adev->wb.wb[ring->wptr_offs];
+		u64 *wb = (u64 *)ring->wptr_cpu_addr;
 
 		/* XXX check if swapping is necessary on BE */
 		WRITE_ONCE(*wb, (ring->wptr << 2));
@@ -1174,13 +1174,10 @@ static void sdma_v4_0_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
-	u32 wb_offset;
 	u32 doorbell;
 	u32 doorbell_offset;
 	u64 wptr_gpu_addr;
 
-	wb_offset = (ring->rptr_offs * 4);
-
 	rb_cntl = RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
 	rb_cntl = sdma_v4_0_rb_cntl(ring, rb_cntl);
 	WREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL, rb_cntl);
@@ -1193,9 +1190,9 @@ static void sdma_v4_0_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 
 	/* set the wb address whether it's enabled or not */
 	WREG32_SDMA(i, mmSDMA0_GFX_RB_RPTR_ADDR_HI,
-	       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
+	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
 	WREG32_SDMA(i, mmSDMA0_GFX_RB_RPTR_ADDR_LO,
-	       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
+	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
 				RPTR_WRITEBACK_ENABLE, 1);
@@ -1225,7 +1222,7 @@ static void sdma_v4_0_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, mmSDMA0_GFX_MINOR_PTR_UPDATE, 0);
 
 	/* setup the wptr shadow polling */
-	wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wptr_gpu_addr = ring->wptr_gpu_addr;
 	WREG32_SDMA(i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO,
 		    lower_32_bits(wptr_gpu_addr));
 	WREG32_SDMA(i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI,
@@ -1264,13 +1261,10 @@ static void sdma_v4_0_page_resume(struct amdgpu_device *adev, unsigned int i)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
-	u32 wb_offset;
 	u32 doorbell;
 	u32 doorbell_offset;
 	u64 wptr_gpu_addr;
 
-	wb_offset = (ring->rptr_offs * 4);
-
 	rb_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL);
 	rb_cntl = sdma_v4_0_rb_cntl(ring, rb_cntl);
 	WREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL, rb_cntl);
@@ -1283,9 +1277,9 @@ static void sdma_v4_0_page_resume(struct amdgpu_device *adev, unsigned int i)
 
 	/* set the wb address whether it's enabled or not */
 	WREG32_SDMA(i, mmSDMA0_PAGE_RB_RPTR_ADDR_HI,
-	       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
+	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
 	WREG32_SDMA(i, mmSDMA0_PAGE_RB_RPTR_ADDR_LO,
-	       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
+	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
 				RPTR_WRITEBACK_ENABLE, 1);
@@ -1316,7 +1310,7 @@ static void sdma_v4_0_page_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, mmSDMA0_PAGE_MINOR_PTR_UPDATE, 0);
 
 	/* setup the wptr shadow polling */
-	wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	wptr_gpu_addr = ring->wptr_gpu_addr;
 	WREG32_SDMA(i, mmSDMA0_PAGE_RB_WPTR_POLL_ADDR_LO,
 		    lower_32_bits(wptr_gpu_addr));
 	WREG32_SDMA(i, mmSDMA0_PAGE_RB_WPTR_POLL_ADDR_HI,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index d3939c5f531d..ff359e7f1eb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -347,7 +347,7 @@ static uint64_t sdma_v5_0_ring_get_rptr(struct amdgpu_ring *ring)
 	u64 *rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = ((u64 *)&ring->adev->wb.wb[ring->rptr_offs]);
+	rptr = (u64 *)ring->rptr_cpu_addr;
 
 	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
 	return ((*rptr) >> 2);
@@ -367,7 +367,7 @@ static uint64_t sdma_v5_0_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
+		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
 		wptr = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
@@ -400,8 +400,8 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 				lower_32_bits(ring->wptr << 2),
 				upper_32_bits(ring->wptr << 2));
 		/* XXX check if swapping is necessary on BE */
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr << 2);
-		adev->wb.wb[ring->wptr_offs + 1] = upper_32_bits(ring->wptr << 2);
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+			     ring->wptr << 2);
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 				ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
@@ -708,7 +708,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
 	u32 rb_bufsz;
-	u32 wb_offset;
 	u32 doorbell;
 	u32 doorbell_offset;
 	u32 temp;
@@ -718,7 +717,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		wb_offset = (ring->rptr_offs * 4);
 
 		if (!amdgpu_sriov_vf(adev))
 			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
@@ -741,7 +739,7 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
 
 		/* setup the wptr shadow polling */
-		wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+		wptr_gpu_addr = ring->wptr_gpu_addr;
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
 		       lower_32_bits(wptr_gpu_addr));
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
@@ -756,9 +754,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 
 		/* set the wb address whether it's enabled or not */
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
-		       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
+		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
-		       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
+		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 8298926f8502..bf2cf95cbf8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -248,7 +248,7 @@ static uint64_t sdma_v5_2_ring_get_rptr(struct amdgpu_ring *ring)
 	u64 *rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = ((u64 *)&ring->adev->wb.wb[ring->rptr_offs]);
+	rptr = (u64 *)ring->rptr_cpu_addr;
 
 	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
 	return ((*rptr) >> 2);
@@ -268,7 +268,7 @@ static uint64_t sdma_v5_2_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
+		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
 		wptr = RREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
@@ -301,8 +301,8 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 				lower_32_bits(ring->wptr << 2),
 				upper_32_bits(ring->wptr << 2));
 		/* XXX check if swapping is necessary on BE */
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr << 2);
-		adev->wb.wb[ring->wptr_offs + 1] = upper_32_bits(ring->wptr << 2);
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+			     ring->wptr << 2);
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 				ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
@@ -609,7 +609,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
 	u32 rb_bufsz;
-	u32 wb_offset;
 	u32 doorbell;
 	u32 doorbell_offset;
 	u32 temp;
@@ -619,7 +618,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		wb_offset = (ring->rptr_offs * 4);
 
 		if (!amdgpu_sriov_vf(adev))
 			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
@@ -642,7 +640,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
 
 		/* setup the wptr shadow polling */
-		wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+		wptr_gpu_addr = ring->wptr_gpu_addr;
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
 		       lower_32_bits(wptr_gpu_addr));
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
@@ -657,9 +655,9 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 
 		/* set the wb address whether it's enabled or not */
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
-		       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
+		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
-		       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
+		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 2f95235bbfb3..f675111ace20 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -40,7 +40,7 @@ static void si_dma_set_irq_funcs(struct amdgpu_device *adev);
 
 static uint64_t si_dma_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->rptr_offs>>2];
+	return *ring->rptr_cpu_addr;
 }
 
 static uint64_t si_dma_ring_get_wptr(struct amdgpu_ring *ring)
@@ -153,7 +153,7 @@ static int si_dma_start(struct amdgpu_device *adev)
 		WREG32(DMA_RB_RPTR + sdma_offsets[i], 0);
 		WREG32(DMA_RB_WPTR + sdma_offsets[i], 0);
 
-		rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+		rptr_addr = ring->rptr_gpu_addr;
 
 		WREG32(DMA_RB_RPTR_ADDR_LO + sdma_offsets[i], lower_32_bits(rptr_addr));
 		WREG32(DMA_RB_RPTR_ADDR_HI + sdma_offsets[i], upper_32_bits(rptr_addr) & 0xFF);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 2f15b8e0f7d7..e668b3baa8c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -118,7 +118,7 @@ static uint64_t uvd_v7_0_enc_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return *ring->wptr_cpu_addr;
 
 	if (ring == &adev->uvd.inst[ring->me].ring_enc[0])
 		return RREG32_SOC15(UVD, ring->me, mmUVD_RB_WPTR);
@@ -153,7 +153,7 @@ static void uvd_v7_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		return;
 	}
@@ -754,7 +754,7 @@ static int uvd_v7_0_mmsch_start(struct amdgpu_device *adev,
 		if (adev->uvd.harvest_config & (1 << i))
 			continue;
 		WDOORBELL32(adev->uvd.inst[i].ring_enc[0].doorbell_index, 0);
-		adev->wb.wb[adev->uvd.inst[i].ring_enc[0].wptr_offs] = 0;
+		*adev->uvd.inst[i].ring_enc[0].wptr_cpu_addr = 0;
 		adev->uvd.inst[i].ring_enc[0].wptr = 0;
 		adev->uvd.inst[i].ring_enc[0].wptr_old = 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index d1fc4e0b8265..66cd3d11aa4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -83,7 +83,7 @@ static uint64_t vce_v4_0_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return *ring->wptr_cpu_addr;
 
 	if (ring->me == 0)
 		return RREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_RB_WPTR));
@@ -106,7 +106,7 @@ static void vce_v4_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		return;
 	}
@@ -177,7 +177,7 @@ static int vce_v4_0_mmsch_start(struct amdgpu_device *adev,
 	WREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_MMSCH_VF_MAILBOX_RESP), 0);
 
 	WDOORBELL32(adev->vce.ring[0].doorbell_index, 0);
-	adev->wb.wb[adev->vce.ring[0].wptr_offs] = 0;
+	*adev->vce.ring[0].wptr_cpu_addr = 0;
 	adev->vce.ring[0].wptr = 0;
 	adev->vce.ring[0].wptr_old = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 7a7f35e83dd5..8421044d5629 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1336,7 +1336,7 @@ static uint64_t vcn_v2_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return *ring->wptr_cpu_addr;
 	else
 		return RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
 }
@@ -1357,7 +1357,7 @@ static void vcn_v2_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 			lower_32_bits(ring->wptr) | 0x80000000);
 
 	if (ring->use_doorbell) {
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR, lower_32_bits(ring->wptr));
@@ -1565,12 +1565,12 @@ static uint64_t vcn_v2_0_enc_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst->ring_enc[0]) {
 		if (ring->use_doorbell)
-			return adev->wb.wb[ring->wptr_offs];
+			return *ring->wptr_cpu_addr;
 		else
 			return RREG32_SOC15(UVD, 0, mmUVD_RB_WPTR);
 	} else {
 		if (ring->use_doorbell)
-			return adev->wb.wb[ring->wptr_offs];
+			return *ring->wptr_cpu_addr;
 		else
 			return RREG32_SOC15(UVD, 0, mmUVD_RB_WPTR2);
 	}
@@ -1589,14 +1589,14 @@ static void vcn_v2_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst->ring_enc[0]) {
 		if (ring->use_doorbell) {
-			adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 		}
 	} else {
 		if (ring->use_doorbell) {
-			adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 17d44be58877..9352d07539b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1491,7 +1491,7 @@ static uint64_t vcn_v2_5_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return *ring->wptr_cpu_addr;
 	else
 		return RREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_WPTR);
 }
@@ -1508,7 +1508,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_WPTR, lower_32_bits(ring->wptr));
@@ -1607,12 +1607,12 @@ static uint64_t vcn_v2_5_enc_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst[ring->me].ring_enc[0]) {
 		if (ring->use_doorbell)
-			return adev->wb.wb[ring->wptr_offs];
+			return *ring->wptr_cpu_addr;
 		else
 			return RREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR);
 	} else {
 		if (ring->use_doorbell)
-			return adev->wb.wb[ring->wptr_offs];
+			return *ring->wptr_cpu_addr;
 		else
 			return RREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR2);
 	}
@@ -1631,14 +1631,14 @@ static void vcn_v2_5_enc_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst[ring->me].ring_enc[0]) {
 		if (ring->use_doorbell) {
-			adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 		}
 	} else {
 		if (ring->use_doorbell) {
-			adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index cb5f0a12333f..19cdad38d134 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1695,7 +1695,7 @@ static uint64_t vcn_v3_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return *ring->wptr_cpu_addr;
 	else
 		return RREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_WPTR);
 }
@@ -1721,7 +1721,7 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 
 	if (ring->use_doorbell) {
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_WPTR, lower_32_bits(ring->wptr));
@@ -2012,12 +2012,12 @@ static uint64_t vcn_v3_0_enc_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst[ring->me].ring_enc[0]) {
 		if (ring->use_doorbell)
-			return adev->wb.wb[ring->wptr_offs];
+			return *ring->wptr_cpu_addr;
 		else
 			return RREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR);
 	} else {
 		if (ring->use_doorbell)
-			return adev->wb.wb[ring->wptr_offs];
+			return *ring->wptr_cpu_addr;
 		else
 			return RREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR2);
 	}
@@ -2036,14 +2036,14 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst[ring->me].ring_enc[0]) {
 		if (ring->use_doorbell) {
-			adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 		}
 	} else {
 		if (ring->use_doorbell) {
-			adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-- 
2.35.1


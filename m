Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5A4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A3E10F6E6;
	Fri, 29 Apr 2022 17:47:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751B810F1C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GglHT11W3LQInJLXmqNgycDGL/v0rAPhE60b123DQw1llVAZmXw3MD7K6sUE31E463W1uwaZXa5BiA3KuUvzsNQpjJ54uEvNH/7VMXTHoE000+0TMODyaYPX/2TXg3jw9qwHwqUfUWnxFr79H0LM2TgUhV2PNjNT24jtBzSWdWwVQPfrxmW+rsBHv2HehD0pWxZsajtTqOGSr2euSuglGJPLkX3wSTSyNl1BIB8NrBBKhlcM6g5xS4y1oH+/9iMul4+fdCQDjKcwLeLJFAr6H02bnirGbj97r1FMoaxPDjbhJ5mKqDd4XXzbO/RDLqp2cqcYSY99oVW6Go9iQPFk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxNy1cPZz4slDRbBpnDcSyJv7OHvet/rjyJbVH5Bmb0=;
 b=RqWMX2rPJpJIUgeg/b5O3/Phm1bfju47Y6/34acoe6bwA0P4fUyK4GLo6Op9OuVD9M0wjC2ld2E6GNPvR2XCSSRX2BwEQqtAmDphxhYiDldQBRbQdmoEovXcj+MghL+nqK+hZYl3MS751MFkRsGBVyAepyQCYDcV/CowbcvXYY7Ac/vF8effwxXDO9w2Gawr9dh11uq6rJDR5J5gYjoL7u9/DbBSQN/9/CbDWGv+U1ClBXy9uLnvgthg7FXBjVB2EG/9e0nOfYtfFGhAMihKB2q3SP8mI0hq2wYxnLQp3v+0+uxfiD5nWXpLS1KdWU67kongpgnDYCLZIlvwVkLJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxNy1cPZz4slDRbBpnDcSyJv7OHvet/rjyJbVH5Bmb0=;
 b=DVKqnXOxHz3CakYQ9RwS5jZt6B5RCFIQhgwTRxGFKDXCkTXmNSRCUu/2q1EUIM2P2xF9tfyEd+2mZNxRkkwIZZ0JKYMSNz+sfSNKDG8M6Hyv9AoGQ96stC8zeYu4HVwCXaGBgOqkepNRJo6TpO44nSZcvDAKf8gikTbeTn4qLvs=
Received: from DM5PR08CA0058.namprd08.prod.outlook.com (2603:10b6:4:60::47) by
 DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 17:46:43 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::6) by DM5PR08CA0058.outlook.office365.com
 (2603:10b6:4:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/73] drm/amdgpu/gfx10: implement mqd functions of
 gfx/compute eng v2
Date: Fri, 29 Apr 2022 13:45:20 -0400
Message-ID: <20220429174624.459475-10-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 00e3f745-813d-4547-d61b-08da2a0838fc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5054:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5054B617128EA25E450D7FD6F7FC9@DM4PR12MB5054.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7U5zL9BGWOOgDMDAJlyhMu/rNpeQZQY/FBChbM0Fc9fhFtYX/VtkomKbdfKbjN3w+ytUg8q9gLq67+9Hx50OYmVaaeaAmI0lCBQ/eGhG7Mn2w/EovGHAD7h7kycTv3yCJO5Du8ROCIGd0ZKzhi7BWDdp8k46KZvc/EkNZU1y8pVyTdUyL2w227nxqBhSdMP4eRV5hGrl0M7LRX3y44/cKUlv9JvigAf99J3MD0YVPMwIy3Q7yRRZV+AbzYrbT91/W/A+g5lcfaV2/c0dDTNfCoclSFzyYNJbyzass6NyCumEkul9LjR2jRVG3fgCLp2K4Bct2eVcfJjZ1Y41+nFrtgfm+r13+634hrTWZgRzNfn9sg9ysvLhuHkDusru3arFeoNH5gA/7aiyXEmMk+d73LNstoAtYi/eZ2sqzy3oFLAvdVUzuXFe19mNeO4Qbf4TP6w9TOtIXf4gZYjC/prV2M2q3chYXF57oVETZNvkzsPy0lhIWO4pYGjztgWKk8qi9BBps6TmHTrUiR6PivBGR5ogY+TbAvPRfOyUasQtke3LojXwlM6ukL3cQmyff15qm6QNE4gzh4is7JeEme3dIpmsCd42y+9uz8mAO5/5SCC/O6s/KKGAHuw+fO4pjJ90AQS+qAvg3TM80JyLiURuq0dEzcUaDdWoPJ/QKvizq0k2zxh64jSxoeQzc5vy/YSBbnb5OT8kWz/GewdN4T5kxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(6666004)(7696005)(86362001)(2906002)(82310400005)(26005)(30864003)(8936002)(16526019)(5660300002)(186003)(356005)(2616005)(426003)(47076005)(336012)(83380400001)(81166007)(1076003)(40460700003)(36860700001)(36756003)(316002)(6916009)(54906003)(8676002)(4326008)(70586007)(70206006)(66574015)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:42.9607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e3f745-813d-4547-d61b-08da2a0838fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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

Refine the existing gfx/compute mqd functions, and add them
to engine mqd layer.

v2: rebase fix.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 111 +++++++++++++------------
 1 file changed, 56 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f2dd53f2af61..cc70594d7e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3485,6 +3485,7 @@ static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v10_0_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev);
+static void gfx_v10_0_set_mqd_funcs(struct amdgpu_device *adev);
 static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev);
@@ -6564,10 +6565,10 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring *ring)
 	}
 }
 
-static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
+static int gfx_v10_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
+				  struct amdgpu_mqd_prop *prop)
 {
-	struct amdgpu_device *adev = ring->adev;
-	struct v10_gfx_mqd *mqd = ring->mqd_ptr;
+	struct v10_gfx_mqd *mqd = m;
 	uint64_t hqd_gpu_addr, wb_gpu_addr;
 	uint32_t tmp;
 	uint32_t rb_bufsz;
@@ -6577,8 +6578,8 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_gfx_hqd_wptr_hi = 0;
 
 	/* set the pointer to the MQD */
-	mqd->cp_mqd_base_addr = ring->mqd_gpu_addr & 0xfffffffc;
-	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
+	mqd->cp_mqd_base_addr = prop->mqd_gpu_addr & 0xfffffffc;
+	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
 
 	/* set up mqd control */
 	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_MQD_CONTROL);
@@ -6604,23 +6605,23 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_gfx_hqd_quantum = tmp;
 
 	/* set up gfx hqd base. this is similar as CP_RB_BASE */
-	hqd_gpu_addr = ring->gpu_addr >> 8;
+	hqd_gpu_addr = prop->hqd_base_gpu_addr >> 8;
 	mqd->cp_gfx_hqd_base = hqd_gpu_addr;
 	mqd->cp_gfx_hqd_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up hqd_rptr_addr/_hi, similar as CP_RB_RPTR */
-	wb_gpu_addr = ring->rptr_gpu_addr;
+	wb_gpu_addr = prop->rptr_gpu_addr;
 	mqd->cp_gfx_hqd_rptr_addr = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_gfx_hqd_rptr_addr_hi =
 		upper_32_bits(wb_gpu_addr) & 0xffff;
 
 	/* set up rb_wptr_poll addr */
-	wb_gpu_addr = ring->wptr_gpu_addr;
+	wb_gpu_addr = prop->wptr_gpu_addr;
 	mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
 	/* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
-	rb_bufsz = order_base_2(ring->ring_size / 4) - 1;
+	rb_bufsz = order_base_2(prop->queue_size / 4) - 1;
 	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
@@ -6631,9 +6632,9 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 
 	/* set up cp_doorbell_control */
 	tmp = RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);
-	if (ring->use_doorbell) {
+	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-				    DOORBELL_OFFSET, ring->doorbell_index);
+				    DOORBELL_OFFSET, prop->doorbell_index);
 		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 				    DOORBELL_EN, 1);
 	} else
@@ -6641,13 +6642,7 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 				    DOORBELL_EN, 0);
 	mqd->cp_rb_doorbell_control = tmp;
 
-	/*if there are 2 gfx rings, set the lower doorbell range of the first ring,
-	 *otherwise the range of the second ring will override the first ring */
-	if (ring->doorbell_index == adev->doorbell_index.gfx_ring0 << 1)
-		gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
-
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	ring->wptr = 0;
 	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR);
 
 	/* active the queue */
@@ -6715,7 +6710,16 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-		gfx_v10_0_gfx_mqd_init(ring);
+		amdgpu_ring_init_mqd(ring);
+
+		/*
+		 * if there are 2 gfx rings, set the lower doorbell
+		 * range of the first ring, otherwise the range of
+		 * the second ring will override the first ring
+		 */
+		if (ring->doorbell_index == adev->doorbell_index.gfx_ring0 << 1)
+			gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
+
 #ifdef BRING_UP_DEBUG
 		gfx_v10_0_gfx_queue_init_register(ring);
 #endif
@@ -6808,23 +6812,10 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return r;
 }
 
-static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct v10_compute_mqd *mqd)
+static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
+				      struct amdgpu_mqd_prop *prop)
 {
-	struct amdgpu_device *adev = ring->adev;
-
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
-			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-			mqd->cp_hqd_queue_priority =
-				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
-		}
-	}
-}
-
-static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct v10_compute_mqd *mqd = ring->mqd_ptr;
+	struct v10_compute_mqd *mqd = m;
 	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
 	uint32_t tmp;
 
@@ -6836,7 +6827,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->compute_static_thread_mgmt_se3 = 0xffffffff;
 	mqd->compute_misc_reserved = 0x00000003;
 
-	eop_base_addr = ring->eop_gpu_addr >> 8;
+	eop_base_addr = prop->eop_gpu_addr >> 8;
 	mqd->cp_hqd_eop_base_addr_lo = eop_base_addr;
 	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
@@ -6850,9 +6841,9 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	/* enable doorbell? */
 	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
 
-	if (ring->use_doorbell) {
+	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_OFFSET, ring->doorbell_index);
+				    DOORBELL_OFFSET, prop->doorbell_index);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_EN, 1);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -6867,15 +6858,14 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_doorbell_control = tmp;
 
 	/* disable the queue if it's active */
-	ring->wptr = 0;
 	mqd->cp_hqd_dequeue_request = 0;
 	mqd->cp_hqd_pq_rptr = 0;
 	mqd->cp_hqd_pq_wptr_lo = 0;
 	mqd->cp_hqd_pq_wptr_hi = 0;
 
 	/* set the pointer to the MQD */
-	mqd->cp_mqd_base_addr_lo = ring->mqd_gpu_addr & 0xfffffffc;
-	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
+	mqd->cp_mqd_base_addr_lo = prop->mqd_gpu_addr & 0xfffffffc;
+	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
 	tmp = RREG32_SOC15(GC, 0, mmCP_MQD_CONTROL);
@@ -6883,14 +6873,14 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_mqd_control = tmp;
 
 	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
-	hqd_gpu_addr = ring->gpu_addr >> 8;
+	hqd_gpu_addr = prop->hqd_base_gpu_addr >> 8;
 	mqd->cp_hqd_pq_base_lo = hqd_gpu_addr;
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
 	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
-			    (order_base_2(ring->ring_size / 4) - 1));
+			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
 #ifdef __BIG_ENDIAN
@@ -6903,22 +6893,22 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_control = tmp;
 
 	/* set the wb address whether it's enabled or not */
-	wb_gpu_addr = ring->rptr_gpu_addr;
+	wb_gpu_addr = prop->rptr_gpu_addr;
 	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_rptr_report_addr_hi =
 		upper_32_bits(wb_gpu_addr) & 0xffff;
 
 	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	wb_gpu_addr = ring->wptr_gpu_addr;
+	wb_gpu_addr = prop->wptr_gpu_addr;
 	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
 	tmp = 0;
 	/* enable the doorbell if requested */
-	if (ring->use_doorbell) {
+	if (prop->use_doorbell) {
 		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				DOORBELL_OFFSET, ring->doorbell_index);
+				DOORBELL_OFFSET, prop->doorbell_index);
 
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_EN, 1);
@@ -6931,7 +6921,6 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_doorbell_control = tmp;
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	ring->wptr = 0;
 	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR);
 
 	/* set the vmid for the queue */
@@ -6947,13 +6936,10 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_ib_control = tmp;
 
 	/* set static priority for a compute queue/ring */
-	gfx_v10_0_compute_mqd_set_priority(ring, mqd);
+	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
+	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
 
-	/* map_queues packet doesn't need activate the queue,
-	 * so only kiq need set this field.
-	 */
-	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
-		mqd->cp_hqd_active = 1;
+	mqd->cp_hqd_active = prop->hqd_active;
 
 	return 0;
 }
@@ -7094,7 +7080,7 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-		gfx_v10_0_compute_mqd_init(ring);
+		amdgpu_ring_init_mqd(ring);
 		gfx_v10_0_kiq_init_register(ring);
 		nv_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
@@ -7116,7 +7102,7 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-		gfx_v10_0_compute_mqd_init(ring);
+		amdgpu_ring_init_mqd(ring);
 		nv_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
@@ -7799,6 +7785,7 @@ static int gfx_v10_0_early_init(void *handle)
 	gfx_v10_0_set_irq_funcs(adev);
 	gfx_v10_0_set_gds_init(adev);
 	gfx_v10_0_set_rlc_funcs(adev);
+	gfx_v10_0_set_mqd_funcs(adev);
 
 	/* init rlcg reg access ctrl */
 	gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
@@ -9581,6 +9568,20 @@ static void gfx_v10_0_set_gds_init(struct amdgpu_device *adev)
 	adev->gds.oa_size = 16;
 }
 
+static void gfx_v10_0_set_mqd_funcs(struct amdgpu_device *adev)
+{
+	/* set gfx eng mqd */
+	adev->mqds[AMDGPU_HW_IP_GFX].mqd_size =
+		sizeof(struct v10_gfx_mqd);
+	adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =
+		gfx_v10_0_gfx_mqd_init;
+	/* set compute eng mqd */
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =
+		sizeof(struct v10_compute_mqd);
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
+		gfx_v10_0_compute_mqd_init;
+}
+
 static void gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
 							  u32 bitmap)
 {
-- 
2.35.1


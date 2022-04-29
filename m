Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6F7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE1510F8BE;
	Fri, 29 Apr 2022 18:03:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940A910F8A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUtTeI6pWouy4lxODsVNJhpIyf1T017rqbyvtNfdFlSwXqErcIrHG6JvCg7DiLaOBZ1ojUJ6b8d39uW1n8dpu1GTU0J48S7ljL5uE+WF+xpdBnS3n0VoeGZLb2M3wBpyXzsyIVuBNaqnnlQjVXhDjysBs+dBT8s6+jqhSpGHT0I5L0OF7cRo/aA9V2x/8fDLKpG79SabFqMh8Q4TEQh2wTnLB+cf2GnfYVnrjEIt7kXmboMPcMPLD17wvhzoRO1XFuIazcFIZH1N+31jPRcM/DZxtpEoXB2eMbEYWHENjg2lqrVUDb/zJzZgMuTvy+mSX96inXChrEsLDcxCEAOxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGZamz9F5kPrtG4wcZ+NgGrdNKup7pb5k7W3jpTcAs0=;
 b=PohQaMrAgjV0nmzmoOjqAETr2VFmgS+z998GnxCFXVJwtdFotsoqv7hhiwMoX0w6Cwns7toMF6YoatNbPJY5DHALQeVNpN/U337ws7PECl4YNGC6bd/fsXspUyawiRCCq0nzy6NCSB+SlhiuXvXuhLhF75gSijPIsOADc1u/rwNGPGqt7pFA1bZ+9wngszLU+vezPQ25AHPoN55ai0F6rLlaBOv1DAB80vvbQm6PMgKM8bQZIknU53pedpYMW+MZIwHhxVnnwaGiVGqKULMi4DqYHBtB/l9A5NKHsSsvO1mVpvad9KwBsLCiaTKbjH/wljiQNfnozQ3bmX5VPf95xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGZamz9F5kPrtG4wcZ+NgGrdNKup7pb5k7W3jpTcAs0=;
 b=ss4XIart8stTuHRz89P/yoWfwu/FcDR87z7fm5Yz0DYOeSengBk2iA8e3TAuc07tWj5bGIYV/PkDnahpXyTdo6mhfOPabQtBd5oYofReJ4sy6hPYoQSJEIYTewNk626ZPBOdwGiHv4pRUiH8yDmotm+IkwvhMCZckwf5pd4CFuc=
Received: from MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26) by
 BN6PR12MB1458.namprd12.prod.outlook.com (2603:10b6:405:d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 18:02:57 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::19) by MW2PR16CA0013.outlook.office365.com
 (2603:10b6:907::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/29] drm/amdgpu/gfx10: enable kiq to map mes ring
Date: Fri, 29 Apr 2022 14:02:23 -0400
Message-ID: <20220429180226.536084-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b827c5fe-8637-47b4-3b60-08da2a0a7d24
X-MS-TrafficTypeDiagnostic: BN6PR12MB1458:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1458A468787FE73C1A72EC1EF7FC9@BN6PR12MB1458.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +b1OrQYHkT5+eoAsudSfSAQaS6+wk516qwcht/aw11KEqP3xGKzilJg4DwbPj3pSie4CCd+2R2E3y6MU6QJuoKH9DI5mK4jzEbTrUGynnkNAq8XlNmW3Dr+P6CJIq9KnUzshnUd9BYNPdQM5ZyqCJjChnBVFJVcPPqAmMYd27H7gv95oHiI/KUzGnQLPPUc1fw6PPmyLC/BHQEly2A81CdfpwP520Gazn62yu8dcAUan/8XaEKa5LiLcfdBGk48BpgHpBm95L0d1flYjkaesdq5koeNkC13Xt/HAM4asFH/MjItEI9ShemaK6ugZU55NVUUQwDlD4R9msqSsbBUJu9wZuTVwKXgSjXyIK6Z+qLA9CGi8SKdwqIzEZ63o2cRon6AfZ2gYWHtqAxfzM61Bmv36BhdZ0SvKTV287APlJtjslszmgBa4qhxk5mZgKfF3wKUrsyv/DYlKZDEK/FW27weHj1dp0j/MGWlAAVFGZEaxXSoZeDRkHgVYVdrQkFNfGnPigAfgHboi1SGdqhHTqYRRWlFfhrMzFEjpwOQEhqT8r1TROjr9aRUqAYm4l6mfk4eEe8kTEnHWMXYBiL0Aok/ilPryeFCtfuyUCRKithfRaSCb578LxGBM3imxyQAxOumLepGsr8S3J3w+x78p33BQtFokxzhFgpIOhqmcYvLqFM2fwiYZBXTaMBDF4VYJrbgSzdqFoJkslAgi0zm3bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(47076005)(82310400005)(508600001)(40460700003)(2616005)(336012)(426003)(1076003)(26005)(356005)(81166007)(6666004)(36860700001)(70206006)(2906002)(16526019)(316002)(186003)(7696005)(36756003)(5660300002)(8936002)(70586007)(54906003)(83380400001)(4326008)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:56.2037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b827c5fe-8637-47b4-3b60-08da2a0a7d24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1458
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Enable KIQ to map MES ring:
1). add MES queue mapping support in MAP_QUEUES packet.
2). use correct MQD settings for MES queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |  16 +++-
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 106 ++++++++++---------------
 2 files changed, 55 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3c4f2a94ad9f..fc289ee54a47 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3525,7 +3525,21 @@ static void gfx10_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 {
 	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	uint64_t wptr_addr = ring->wptr_gpu_addr;
-	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+	uint32_t eng_sel = 0;
+
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_COMPUTE:
+		eng_sel = 0;
+		break;
+	case AMDGPU_RING_TYPE_GFX:
+		eng_sel = 4;
+		break;
+	case AMDGPU_RING_TYPE_MES:
+		eng_sel = 5;
+		break;
+	default:
+		WARN_ON(1);
+	}
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
 	/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 030a92b3a0da..18a129f36215 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -28,6 +28,7 @@
 #include "nv.h"
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
+#include "gc/gc_10_1_0_default.h"
 #include "v10_structs.h"
 #include "mes_api_def.h"
 
@@ -529,7 +530,7 @@ static void mes_v10_1_enable(struct amdgpu_device *adev, bool enable)
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE,
 				     adev->enable_mes_kiq ? 1 : 0);
 		WREG32_SOC15(GC, 0, mmCP_MES_CNTL, data);
-		udelay(50);
+		udelay(100);
 	} else {
 		data = RREG32_SOC15(GC, 0, mmCP_MES_CNTL);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_ACTIVE, 0);
@@ -665,7 +666,6 @@ static int mes_v10_1_allocate_eop_buf(struct amdgpu_device *adev,
 
 static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 {
-	struct amdgpu_device *adev = ring->adev;
 	struct v10_compute_mqd *mqd = ring->mqd_ptr;
 	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
 	uint32_t tmp;
@@ -679,38 +679,18 @@ static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 	mqd->compute_misc_reserved = 0x00000003;
 
 	eop_base_addr = ring->eop_gpu_addr >> 8;
-	mqd->cp_hqd_eop_base_addr_lo = eop_base_addr;
-	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL);
+	tmp = mmCP_HQD_EOP_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(MES_EOP_SIZE / 4) - 1));
 
+	mqd->cp_hqd_eop_base_addr_lo = lower_32_bits(eop_base_addr);
+	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 	mqd->cp_hqd_eop_control = tmp;
 
-	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
-
-	if (ring->use_doorbell) {
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_OFFSET, ring->doorbell_index);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_EN, 1);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_SOURCE, 0);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_HIT, 0);
-	}
-	else
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_EN, 0);
-
-	mqd->cp_hqd_pq_doorbell_control = tmp;
-
 	/* disable the queue if it's active */
 	ring->wptr = 0;
-	mqd->cp_hqd_dequeue_request = 0;
 	mqd->cp_hqd_pq_rptr = 0;
 	mqd->cp_hqd_pq_wptr_lo = 0;
 	mqd->cp_hqd_pq_wptr_hi = 0;
@@ -720,17 +700,28 @@ static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, 0, mmCP_MQD_CONTROL);
+	tmp = mmCP_MQD_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
 	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
 	hqd_gpu_addr = ring->gpu_addr >> 8;
-	mqd->cp_hqd_pq_base_lo = hqd_gpu_addr;
+	mqd->cp_hqd_pq_base_lo = lower_32_bits(hqd_gpu_addr);
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
+	/* set the wb address whether it's enabled or not */
+	wb_gpu_addr = ring->rptr_gpu_addr;
+	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
+	mqd->cp_hqd_pq_rptr_report_addr_hi =
+		upper_32_bits(wb_gpu_addr) & 0xffff;
+
+	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
+	wb_gpu_addr = ring->wptr_gpu_addr;
+	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffff8;
+	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
+
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL);
+	tmp = mmCP_HQD_PQ_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(ring->ring_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
@@ -738,30 +729,18 @@ static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
 #endif
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, NO_UPDATE_RPTR, 1);
 	mqd->cp_hqd_pq_control = tmp;
 
-	/* set the wb address whether it's enabled or not */
-	wb_gpu_addr = ring->rptr_gpu_addr;
-	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
-	mqd->cp_hqd_pq_rptr_report_addr_hi =
-		upper_32_bits(wb_gpu_addr) & 0xffff;
-
-	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	wb_gpu_addr = ring->wptr_gpu_addr;
-	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffff8;
-	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
-
+	/* enable doorbell? */
 	tmp = 0;
-	/* enable the doorbell if requested */
 	if (ring->use_doorbell) {
-		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				DOORBELL_OFFSET, ring->doorbell_index);
-
+				    DOORBELL_OFFSET, ring->doorbell_index);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_EN, 1);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -769,30 +748,28 @@ static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_HIT, 0);
 	}
-
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_EN, 0);
 	mqd->cp_hqd_pq_doorbell_control = tmp;
 
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	ring->wptr = 0;
-	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR);
-
-	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
-
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x53);
-	mqd->cp_hqd_persistent_state = tmp;
-
-	/* set MIN_IB_AVAIL_SIZE */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_IB_CONTROL);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
-	mqd->cp_hqd_ib_control = tmp;
-
 	/* activate the queue */
 	mqd->cp_hqd_active = 1;
+	mqd->cp_hqd_persistent_state = mmCP_HQD_PERSISTENT_STATE_DEFAULT;
+	mqd->cp_hqd_ib_control = mmCP_HQD_IB_CONTROL_DEFAULT;
+	mqd->cp_hqd_iq_timer = mmCP_HQD_IQ_TIMER_DEFAULT;
+	mqd->cp_hqd_quantum = mmCP_HQD_QUANTUM_DEFAULT;
+
+	tmp = mmCP_HQD_GFX_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_GFX_CONTROL, DB_UPDATED_MSG_EN, 1);
+	/* offset: 184 - this is used for CP_HQD_GFX_CONTROL */
+	mqd->cp_hqd_suspend_cntl_stack_offset = tmp;
+
 	return 0;
 }
 
+#if 0
 static void mes_v10_1_queue_init_register(struct amdgpu_ring *ring)
 {
 	struct v10_compute_mqd *mqd = ring->mqd_ptr;
@@ -854,8 +831,8 @@ static void mes_v10_1_queue_init_register(struct amdgpu_ring *ring)
 	nv_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 }
+#endif
 
-#if 0
 static int mes_v10_1_kiq_enable_queue(struct amdgpu_device *adev)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
@@ -878,9 +855,9 @@ static int mes_v10_1_kiq_enable_queue(struct amdgpu_device *adev)
 		DRM_ERROR("kfq enable failed\n");
 		kiq_ring->sched.ready = false;
 	}
+
 	return r;
 }
-#endif
 
 static int mes_v10_1_queue_init(struct amdgpu_device *adev)
 {
@@ -890,13 +867,9 @@ static int mes_v10_1_queue_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-#if 0
 	r = mes_v10_1_kiq_enable_queue(adev);
 	if (r)
 		return r;
-#else
-	mes_v10_1_queue_init_register(&adev->mes.ring);
-#endif
 
 	return 0;
 }
@@ -972,6 +945,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 		dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
 		return r;
 	}
+	memset(ring->mqd_ptr, 0, mqd_size);
 
 	/* prepare MQD backup */
 	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
-- 
2.35.1


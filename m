Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98407C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 09:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46D010E904;
	Wed, 21 Sep 2022 09:42:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144FD10E901
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 09:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlfhveKAD3c2PnaJf73IWxvqlWV9owxfyRFQS4aVcTwb90ZL0dllihHIgyR0SonE0uQG+8eTtYHv0wTqaTR0fMWtAvJawub5zS2H4Wf46k8kx+7RJwGJnKQTKqSa0D4+QDoUiPXYDuJv8nGmnzvh0JGj9UlZilPI8iEK3tuSyeSKt9TgZIQvrK/t3wMLIiDZAECjA6n7SzDu7PrSKGKV2w6DOfcT2ge0DFDbuFLR1Mh1wSu3qTwdUxx3WsPj2uAyvAbbs+3WLERkWqH+lz+Ow0vi/Pw/6/Jslx/NSdo8WehZ2Uc3cKrpdGZ3T+boJXi9Eh9Q82WP6e8+xgAveXFlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNCpb1MLtSfnGyO4bcr7RDmL5RbXO7agnbjP1d0HX7c=;
 b=ee92iKkMDIoCEFqIwBZbBnBKG3EMLDl3xApdUuhZ0Mc/gT0SdAtKakJWpjPOUvG4hR1dkHbqKpdkF4uYbIuvw20X49FwXdd+xlk4xDDwYU4QiBALe71Y24ehDxEux5WekYpwuH0kep0Di4DlKIPiJa91aDOvTW8XypyOEkzp/7lXfCngZkhz7L30wdeNhBVidguHuIYlav59uidjkL1YH+dxacSBN+Dsxj4WnzueXTh4Y0RHG6IszZp+Q64ghz90VE+hu9idMNsOan1oz8eIabc9WGpCO/dguLnoVOZAr0KoFrMn/O/NBL1eFQktxjIoVDF3/+M8ZmOqwebnHq+Phw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNCpb1MLtSfnGyO4bcr7RDmL5RbXO7agnbjP1d0HX7c=;
 b=otRnFmpG4jBaBb7+omx1PcghwhTHuzTac1+5BZbqI72CI+6IEnEuue6F3j2BTP0kwkNO5NwH7a2EDr3ePQN4RKucakF/WWW7ZBAERZRs56E4YCZ9/kiqbALCWtxOrOSVyzvsJHKzN3RaX4RtvMD3GUyPnvBOK4owqFzKYz+Nvjk=
Received: from DM6PR07CA0125.namprd07.prod.outlook.com (2603:10b6:5:330::7) by
 DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 21 Sep 2022 09:42:14 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::1d) by DM6PR07CA0125.outlook.office365.com
 (2603:10b6:5:330::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 09:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 09:42:14 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 04:42:12 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: Modify unmap_queue format for gfx9 (v3)
Date: Wed, 21 Sep 2022 17:41:15 +0800
Message-ID: <20220921094117.1071106-3-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921094117.1071106-1-jiadong.zhu@amd.com>
References: <20220921094117.1071106-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f365f5-5a63-4db7-fabf-08da9bb590a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbC8dvjHF6I5keb6TeQVY96BLxFAsf/PGXlAHJ7ftclXAAx1egxEq4s97kJJ2LbnN1mMeBHRYl+MD9WuAUjIxnI+YdPbQIE6/yJKkW3SFt6zAfOfk9sXJisMU5dzfAereF4e5KI94nVuy+lEb6NK9S+FzoCmrzKZRPx0iGblDq0ENkTyW6n2SvB88DGAbXXyEBqwND+kd2RD2GTZiUuEf1bR/uXUbycOUNHVHGCF8kJMbBQc6F2X4qzovFmgt2s8GSZ71K+craUu54Fx7eBJwT0xahq8ecGhDqLKP5/rJra76S7ZXKJJAptFFU+e9D34p2ffw1Jzw7NZFPcH7OLcNZRPOeyLkJ4kofhkRDqK0+7nLBjol+wEdU5vSSlOQaMSxUK21ak6zuEiuUlvpLtNlk8npGsL32xXXLM54p7jisrRq1ML5Sx70bWBDhCwf19FJaluU5KR9nEMk2fBowPgejJrbO8m4rfi1TDOwStgSmti2TdMxblw/fCNqNft32dsRrDfiVndrBBv/w1qj/MphgTvvkGwKsaCu7AI+3nxwZS13wNfMkLWNy2tIz/j2aiTrc8CkRcxaeI2A4Danl5yK2hHvX1zQiIGIInTJpH1aYFp6Y/UTT1x+AfBaFT2FgJxU/Rw9DOh9OMoNzo2JUC3H/VtzGrky9nzgLGInPh/64QXpSE4qID5Hscj/4YjPQsXIkVy7DiKvpUpMZVjTa6nm0hbuHbpKq/NdsKwb0+UVfnzj4VDR3lMqJ/+2vfzCfBI5RiCTPDBBAsn5QqvGCfRUjM8qarcD47l+3v5M7Sg+vBdfSeLBqY8lPtJePrv3wcA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(16526019)(336012)(186003)(1076003)(2616005)(30864003)(82310400005)(70206006)(8936002)(356005)(70586007)(41300700001)(4326008)(26005)(40460700003)(8676002)(36860700001)(86362001)(316002)(5660300002)(40480700001)(83380400001)(7696005)(81166007)(2906002)(426003)(47076005)(82740400003)(478600001)(2876002)(36756003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 09:42:14.3435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f365f5-5a63-4db7-fabf-08da9bb590a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742
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
Cc: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

1. Modify the unmap_queue package on gfx9. Add trailing fence to track the
   preemption done.
2. Modify emit_ce_meta emit_de_meta functions for the resumed ibs.

v2: Restyle code not to use ternary operator.
v3: Modify code format.

Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 182 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
 3 files changed, 156 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 275b885363c3..aeb48cc3666c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -60,6 +60,7 @@ enum amdgpu_ring_priority_level {
 #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
 #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
 #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
+#define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
 
 #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4a8be9595459..c568a4f5b81e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -753,7 +753,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
-static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
+static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
 static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status);
@@ -826,9 +826,10 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 			PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
 
 	if (action == PREEMPT_QUEUES_NO_UNMAP) {
-		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
-		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
-		amdgpu_ring_write(kiq_ring, seq);
+		amdgpu_ring_write(kiq_ring, lower_32_bits(ring->wptr & ring->buf_mask));
+		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_write(kiq_ring, 0);
+
 	} else {
 		amdgpu_ring_write(kiq_ring, 0);
 		amdgpu_ring_write(kiq_ring, 0);
@@ -5357,11 +5358,17 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
+		if (flags & AMDGPU_IB_PREEMPTED)
+			control |= INDIRECT_BUFFER_PRE_RESUME(1);
+
 		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
-			gfx_v9_0_ring_emit_de_meta(ring);
+			gfx_v9_0_ring_emit_de_meta(ring,
+						   (!amdgpu_sriov_vf(ring->adev) &&
+						   flags & AMDGPU_IB_PREEMPTED) ?
+						   true : false);
 	}
 
 	amdgpu_ring_write(ring, header);
@@ -5416,17 +5423,23 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
 	bool writeback = flags & AMDGPU_FENCE_FLAG_TC_WB_ONLY;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
+	uint32_t dw2 = 0;
 
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
-	amdgpu_ring_write(ring, ((writeback ? (EOP_TC_WB_ACTION_EN |
-					       EOP_TC_NC_ACTION_EN) :
-					      (EOP_TCL1_ACTION_EN |
-					       EOP_TC_ACTION_EN |
-					       EOP_TC_WB_ACTION_EN |
-					       EOP_TC_MD_ACTION_EN)) |
-				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 EVENT_INDEX(5)));
+
+	if (writeback) {
+		dw2 = EOP_TC_WB_ACTION_EN | EOP_TC_NC_ACTION_EN;
+	} else {
+		dw2 = EOP_TCL1_ACTION_EN | EOP_TC_ACTION_EN |
+				EOP_TC_WB_ACTION_EN | EOP_TC_MD_ACTION_EN;
+	}
+	dw2 |= EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) | EVENT_INDEX(5);
+	if (exec)
+		dw2 |= EOP_EXEC;
+
+	amdgpu_ring_write(ring, dw2);
 	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
 
 	/*
@@ -5531,33 +5544,135 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0);
 }
 
-static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
+static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 {
+	struct amdgpu_device *adev = ring->adev;
 	struct v9_ce_ib_state ce_payload = {0};
-	uint64_t csa_addr;
+	uint64_t offset, ce_payload_gpu_addr;
+	void *ce_payload_cpu_addr;
 	int cnt;
 
 	cnt = (sizeof(ce_payload) >> 2) + 4 - 2;
-	csa_addr = amdgpu_csa_vaddr(ring->adev);
+
+	if (ring->is_mes_queue) {
+		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+				  gfx[0].gfx_meta_data) +
+			offsetof(struct v9_gfx_meta_data, ce_payload);
+		ce_payload_gpu_addr =
+			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		ce_payload_cpu_addr =
+			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+	} else {
+		offset = offsetof(struct v9_gfx_meta_data, ce_payload);
+		ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
+		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
 				 WRITE_DATA_DST_SEL(8) |
 				 WR_CONFIRM) |
 				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
-	amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
-	amdgpu_ring_write_multiple(ring, (void *)&ce_payload, sizeof(ce_payload) >> 2);
+	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
+
+	if (resume)
+		amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
+					   sizeof(ce_payload) >> 2);
+	else
+		amdgpu_ring_write_multiple(ring, (void *)&ce_payload,
+					   sizeof(ce_payload) >> 2);
+}
+
+static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
+{
+	int i, r = 0;
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	/* assert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, false);
+
+	ring->trail_seq += 1;
+	amdgpu_ring_alloc(ring, 13);
+	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
+				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
+	/*reset the CP_VMID_PREEMPT after trailing fence*/
+	amdgpu_ring_emit_wreg(ring,
+			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
+			      0x0);
+
+	/* assert IB preemption, emit the trailing fence */
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
+				   ring->trail_fence_gpu_addr,
+				   ring->trail_seq);
+
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	/* poll the trailing fence */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (ring->trail_seq ==
+			le32_to_cpu(*ring->trail_fence_cpu_addr))
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		r = -EINVAL;
+		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
+	}
+
+	amdgpu_ring_commit(ring);
+
+	/* deassert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, true);
+	return r;
 }
 
-static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
+static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 {
+	struct amdgpu_device *adev = ring->adev;
 	struct v9_de_ib_state de_payload = {0};
-	uint64_t csa_addr, gds_addr;
+	uint64_t offset, gds_addr, de_payload_gpu_addr;
+	void *de_payload_cpu_addr;
 	int cnt;
 
-	csa_addr = amdgpu_csa_vaddr(ring->adev);
-	gds_addr = csa_addr + 4096;
+	if (ring->is_mes_queue) {
+		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+				  gfx[0].gfx_meta_data) +
+			offsetof(struct v9_gfx_meta_data, de_payload);
+		de_payload_gpu_addr =
+			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		de_payload_cpu_addr =
+			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+
+		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+				  gfx[0].gds_backup) +
+			offsetof(struct v9_gfx_meta_data, de_payload);
+		gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+	} else {
+		offset = offsetof(struct v9_gfx_meta_data, de_payload);
+		de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
+		de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+
+		gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
+				 AMDGPU_CSA_SIZE - adev->gds.gds_size,
+				 PAGE_SIZE);
+	}
+
 	de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
 	de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
 
@@ -5567,9 +5682,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
 				 WRITE_DATA_DST_SEL(8) |
 				 WR_CONFIRM) |
 				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
-	amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
-	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
+	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
+
+	if (resume)
+		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
+					   sizeof(de_payload) >> 2);
+	else
+		amdgpu_ring_write_multiple(ring, (void *)&de_payload,
+					   sizeof(de_payload) >> 2);
 }
 
 static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
@@ -5585,8 +5706,10 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
 	uint32_t dw2 = 0;
 
-	if (amdgpu_sriov_vf(ring->adev))
-		gfx_v9_0_ring_emit_ce_meta(ring);
+	if (amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp)
+		gfx_v9_0_ring_emit_ce_meta(ring,
+					   (!amdgpu_sriov_vf(ring->adev) &&
+					   flags & AMDGPU_IB_PREEMPTED) ? true : false);
 
 	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
 	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
@@ -6914,6 +7037,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
 	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
+	.preempt_ib = gfx_v9_0_ring_preempt_ib,
 	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index 799925d22fc8..614e9f8467fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -162,6 +162,7 @@
 		 * 2 - Bypass
 		 */
 #define     INDIRECT_BUFFER_PRE_ENB(x)		 ((x) << 21)
+#define     INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
 #define	PACKET3_COPY_DATA				0x40
 #define	PACKET3_PFP_SYNC_ME				0x42
 #define	PACKET3_COND_WRITE				0x45
@@ -184,6 +185,7 @@
 #define		EOP_TC_ACTION_EN                        (1 << 17) /* L2 */
 #define		EOP_TC_NC_ACTION_EN			(1 << 19)
 #define		EOP_TC_MD_ACTION_EN			(1 << 21) /* L2 metadata */
+#define		EOP_EXEC					(1 << 28) /* For Trailing Fence */
 
 #define		DATA_SEL(x)                             ((x) << 29)
 		/* 0 - discard
-- 
2.25.1


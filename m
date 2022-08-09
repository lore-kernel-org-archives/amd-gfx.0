Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CFBC25B06
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 09:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C803CCDE3;
	Tue,  9 Aug 2022 09:18:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE304CCAFF
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 09:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZZQmhMKoCN6ZqyUWMeVAQ35guIhPatSV8+bvTLoBOINBVRaOplZDT585scbyVXhIpAe51HwGwP36T113mQW1a3gmMSm1PsdAzanGXQf5rcAWUTH52L7XeLgmJvquG8dYeJpJZ9syHxO1TOqupIK4aAVnmW94jUiSHZfR1joh7ZlLNnO0acf7M9R5l7Jc8hrRTqMK7KMe58V8XvHZAnNpiCzVT6WGr7ibXN+W7hMznMPSyib/nGCRsDpoYjnJ+pdC9NUHjvILTBCAyC3jVGE8frkeA/DqeRdmFSr2EJ0TjeoYufGXQ2vyNNucu1qotA1hiVZfl1Focry2XXIxbnTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXH+r/q523LJPo/BtXYtwJcNmIr8Rg+EaY7e71esEHk=;
 b=n8JCWdKWi7LU1k4ngE6XG7zAtt2mSRczhSbqdx4QIjcpFVwhY1Zvl0rYXLlcneMOor2LnJTI5qoZPBCYr9tEHC1oVEJvEiYTXJqpxi6c9qrRK3GsSmu+f5iSeO/1ES49PKkodedB2D5y4rrg0GpaSMtrXvUBPFRzYTC9LBDeZE8ESOXzSnAUetA+MbXb8bPU90yqy37+6bsJXYA2I1Aw5UYJ5W2uA5xkF/NiNUTUBPemR6RgPbLPZpm8mdYkOrMgwiJWKfNry1Gec6oxyNyfqPOsx4nZL4B/X/oXYO+vZ5mHfcUVQPrcb6a+ZxVS5T1gwIS+VhRp9T5OFTSK8+8mCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXH+r/q523LJPo/BtXYtwJcNmIr8Rg+EaY7e71esEHk=;
 b=lUXZw9Mg3VH9Pu2vND4pLC81Zkn6um9FeXeLnxk/lHF6e1gxZxGYjQN5sOnkFcAUs11gTsub9GcO71GHdTP2E8Re6SFZnLawph+GTEoRIwcKy62roAeX3g4cIlmivkcrMauxCVhRrrNNayZUxWvpoYkxeSuBjQgOgUE48GoYnvs=
Received: from BN9PR03CA0103.namprd03.prod.outlook.com (2603:10b6:408:fd::18)
 by CH2PR12MB3704.namprd12.prod.outlook.com (2603:10b6:610:21::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 09:15:26 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::df) by BN9PR03CA0103.outlook.office365.com
 (2603:10b6:408:fd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Tue, 9 Aug 2022 09:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 09:15:26 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 04:15:18 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: modify mcbp implement for gfx9(v2)
Date: Tue, 9 Aug 2022 17:14:47 +0800
Message-ID: <20220809091448.958375-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6461efa4-46cd-4b12-031e-08da79e7b254
X-MS-TrafficTypeDiagnostic: CH2PR12MB3704:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6SGu+peIjyjZSYtzKv5+B0BRXjPtmFdpMQlBUKdt8QhEOKHU8vfpqUzmklfBRYKjUMVz8jii9k2miQGhDG5XbhDg2lUAjkDbOTd9JqLOcNJs/1zT13Ko986FScOPz45Deps5jq+MGGf9Xl5tUrrj2YG+4zrNJaHUpuJAfDT0/lCWAdgYU7wlPmJn7E1f3RxjJskQx34x1PE5PEZk4/xAWkH+WV8ynb745JETkU16uRGiZaP7pPZvDKGjyVwp+6XXA5FeMRO4/zHAlCIayii1TB/mtXhAQNi0gLNlHFwR8rQhAQs4zuhHq4qJ2fyeHBm7XByqR7ui+IQCvbhkMQ8otiYlFkHrWeZHu7oyOGR+OXaLJYeoVYxpRPvBIsGEBk4gjvGdiB62lTtpvspaJDyyK2mnFS5oeBnsBg3DKyois0KC6//rXapiVdn3a3mCYP/gl/GigRrLtbt5ozriRovqGxpcM7EOgA7YL+ooUr4lFvzQmet3igFbFmH7XGR5cQLwb7izbYLPau6UAAzuiBDAhpY6G4BRC/BPLMCzPkphouNH5BAWriGG3BxbBFlseCrAH54RZZOn8iZASzrG+3DFP6SXPIQZ/1uKJmLN4Rd4JBPedrllKZQncL3Rwje7l8HllsKCYGyJB51ZLka/f4Acc1BF2Bn8RsPinTIskkb1QWMGkDK1eypgA1MT+g3Pi7/5RHkvrkiOc2ECX7+L+P2rWVeQEfTjhEqECYYJgi1MAG87QrHpZDS1aSfS6+CC7nzv4LqJB4BpYL+kz58GNx8FunJ4/BkU18QzUvfPjFTCYqkApFpQNZv+5kG/KHXzW0KgJT+E6bGM0+cpCXw2N+VAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(82740400003)(356005)(70206006)(2906002)(70586007)(2876002)(86362001)(82310400005)(4326008)(40460700003)(8676002)(7696005)(6666004)(26005)(81166007)(6916009)(54906003)(316002)(478600001)(36756003)(16526019)(36860700001)(41300700001)(336012)(186003)(40480700001)(426003)(1076003)(2616005)(47076005)(5660300002)(83380400001)(8936002)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 09:15:26.1821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6461efa4-46cd-4b12-031e-08da79e7b254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3704
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
Cc: Ray.Huang@amd.com, "Jiadong.Zhu" <Jiadong.Zhu@amd.com>, aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

1. Use unmap_queue package to trigger preemption on gfx9
   Add trailing fence to track the preemption done.
2. Modify emit_ce_meta emit_de_meta functions
   for the resumed ibs.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 159 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
 3 files changed, 141 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 82c178a9033a..ca626f0ad7b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -59,6 +59,7 @@ enum amdgpu_ring_priority_level {
 #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
 #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
 #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
+#define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
 
 #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5332899642dc..0b7cb4cf13c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -751,7 +751,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
-static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
+static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
 static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status);
@@ -824,9 +824,10 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
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
@@ -5446,11 +5447,15 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
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
+				 (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 	}
 
 	amdgpu_ring_write(ring, header);
@@ -5505,6 +5510,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
 	bool writeback = flags & AMDGPU_FENCE_FLAG_TC_WB_ONLY;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
 
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
@@ -5515,6 +5521,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 					       EOP_TC_WB_ACTION_EN |
 					       EOP_TC_MD_ACTION_EN)) |
 				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
+				 (exec ? EOP_EXEC : 0x0) |
 				 EVENT_INDEX(5)));
 	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
 
@@ -5620,33 +5627,135 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
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
+				  ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
+	/*reset the CP_VMID_PREEMPT after trailing fence*/
+	amdgpu_ring_emit_wreg(ring,
+				  SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
+				  0x0);
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
+		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
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
 
@@ -5656,9 +5765,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
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
@@ -5674,8 +5789,9 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
 	uint32_t dw2 = 0;
 
-	if (amdgpu_sriov_vf(ring->adev))
-		gfx_v9_0_ring_emit_ce_meta(ring);
+	if (amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp)
+		gfx_v9_0_ring_emit_ce_meta(ring,
+				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 
 	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
 	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
@@ -7024,6 +7140,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
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


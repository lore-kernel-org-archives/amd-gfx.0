Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3739DC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 08:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868B311BB31;
	Fri, 15 Jul 2022 08:44:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F43E11ACCA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 08:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw03tyzpKKkcj0ydfJ1ozY4YagojAX5ThaaGH0zxUo82gQHi2Ys9UWJIlgFDy61QWVXInclzb1hmMCo9sDqywMtmOUFdsaVirlrnP+wC8kklRNKZ9jCVgf4jNl5z1OEW3Qn5eN26Knk7FfVlr0ROssCtYRqZ5586lbvNSBluwkWIjLElvDid5wJQpQH+ACEI+BVYIYnQML1CQ1UjNIBHTaPsbRfl+RrOAgaw/WvIxxMEJzg0TUdNl8E3CPmDXULDTbOuPGzZr9Pa4DXOY6r9hHZUbH9FSVL6UdtbMX+ivnCqHCENvgMUNuhzPolmjXyr07Xl74Ru4g1uEvDBDCkgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxIU+r/IkaR++alSQwCbn0TjEs/qK/6lsFwoFOFNWFk=;
 b=IOAmHz8rW6UuxUl56XgZXtKhCs/vFQde7gZ5Es3WwdWvu+GeSQYFUlEtdr6YItGLOJnAcTk3wboqqNg561wXfOFazZELBQoTxNBUwf7+Pviqx8NQCviLHZLV2ng7yKeQCvDHqKY4axcWh5ARiJTI/QvT9Eby1NsMHPN/NzD7g/t4VLG8cGUrKBIarlHzyhZtcpUW96UJwjntTacKkKSYuzODBnufXtlCNfMnBvR4+tiZFX2VcYrcoeX+JblPlL/MDj+lv7COhLHdmxmmu4zVx6pHwm3MSooJFo6/8uViKzf1ej02z9+FqUH0/PUlVsRgVnQ16iDjiL4YaHsU2vWIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.helo=satlexmb04.amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxIU+r/IkaR++alSQwCbn0TjEs/qK/6lsFwoFOFNWFk=;
 b=w7HZw4Tw0wsNO8lWyE0BCKvlfIhLS+9D6C3PUm6IkkRseeyD2SSzM+sEHe4wMETTf1n9syZbwDFKL5O+dEe9AQU641JtPgceVbzZpy2qU8HLVb0Ar3F96NYi0J7uh/ooD5/ELARnF0ihOs7xeLQ1/ODSPHSv+WTHHjmFQNU68gQ=
Received: from MW4PR04CA0337.namprd04.prod.outlook.com (2603:10b6:303:8a::12)
 by DM6PR12MB4025.namprd12.prod.outlook.com (2603:10b6:5:1c8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Fri, 15 Jul
 2022 08:44:32 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::5) by MW4PR04CA0337.outlook.office365.com
 (2603:10b6:303:8a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20 via Frontend
 Transport; Fri, 15 Jul 2022 08:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.helo=SATLEXMB04.amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: None (protection.outlook.com: SATLEXMB04.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 08:44:32 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 15 Jul 2022 03:44:29 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: modify mcbp implement for gfx9
Date: Fri, 15 Jul 2022 16:43:54 +0800
Message-ID: <20220715084356.427458-1-Jiadong.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54652842-1c6f-43d2-b35e-08da663e3d3d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4025:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4KkQ/BpWtmpAH9l9EujCSe4CFPtsfBAKFm1ayn8oCFx7lYFTKBt1k05Oif7fEtXaQG7nJvjCdGJGy2oe0+Z+wqR/qRQp+0vf0Sw9HMkkYiTK6aJwLwhRaAM14oqGi/qw6cV2jAdZUU+aEZ68CZqEexmJsP6XfiIMC3K6R4RjOfigA31wnXhvjUYRIgzghyxjvfTU6rvFI+50aXLwG2bhzagndJin4ZJNi6zay6Yy2eDIHmqVRluyfgiuowIdidvj3Nj3eoRyCdNqueyrcdBKgPjJrov0AyF5UbZCjqBTYyio9S21ZUy1+z6/yuSOPn/S3QMA6qmOUIndcNnmmQeHEaw1egUGmaasEDbve4sCdwjHChul37BNkRaXVFBOdJydliL2aHkAeiTO8RYqaFvGVhTW8i3utyKTkq6u40RMnFt5KOkQRy3/yHwy3sYkeLP389uAvJIpIWy7wYCsCWO78h5vbS39xUbq1ekeFIweJjQ7dvAMdddjhEtwJ0ZHOClmRco30u7np7CnPkZ2xlXvzMnc180awPbb1+L8opgXe8/WBU+sjljpHzncwAhiRnZPaZnTWS/an0TT0HNV62PNpssOk4GrRAktZUtbbL00y8hQsnivSC1CexgLWhu/FOQAC82jWZnaoZYaiVydJuOR9AN0oylzDHXxEJME6V0p4n27pjxizqrV3dbOOkUVYMML8rM9JW0XNd5E4gmcAwQlWzaG2F06DsBA8iBU46uCMRHUCBJzhF4GSL+acWsP7snZfkjb0afX9/iRKS1lAexwNhQZhmscpCKg5rAmAfYh5W8N3p3BUbp6mbjuLzPDqyG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(40470700004)(5660300002)(2876002)(30864003)(2906002)(78352004)(70586007)(8936002)(40480700001)(70206006)(316002)(16526019)(41300700001)(54906003)(82310400005)(6916009)(26005)(498600001)(6666004)(7696005)(8676002)(2616005)(336012)(35950700001)(42882007)(47076005)(426003)(82740400003)(83380400001)(356005)(1076003)(4326008)(36756003)(40460700003)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:44:32.5930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54652842-1c6f-43d2-b35e-08da663e3d3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4025
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 156 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
 3 files changed, 138 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7d89a52091c0..2b402a8bc4fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -59,6 +59,7 @@ enum amdgpu_ring_priority_level {
 #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
 #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
 #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
+#define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
 
 #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 603bfa52e6e8..d6106d480d0b 100644
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
@@ -5463,11 +5464,15 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
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
@@ -5522,6 +5527,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
 	bool writeback = flags & AMDGPU_FENCE_FLAG_TC_WB_ONLY;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
 
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
@@ -5532,6 +5538,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 					       EOP_TC_WB_ACTION_EN |
 					       EOP_TC_MD_ACTION_EN)) |
 				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
+				 (exec ? EOP_EXEC : 0x0) |
 				 EVENT_INDEX(5)));
 	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
 
@@ -5637,33 +5644,132 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
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
+	amdgpu_ring_alloc(ring, 8);
+	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
+				  ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
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
+	/*reset the CP_VMID_PREEMPT after trailing fence*/
+	WREG32_SOC15(GC, 0, mmCP_VMID_PREEMPT, 0x0);
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
 
@@ -5673,9 +5779,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
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
@@ -5691,8 +5803,9 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
 	uint32_t dw2 = 0;
 
-	if (amdgpu_sriov_vf(ring->adev))
-		gfx_v9_0_ring_emit_ce_meta(ring);
+	if (amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp)
+		gfx_v9_0_ring_emit_ce_meta(ring,
+				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 
 	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
 	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
@@ -7041,6 +7154,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
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


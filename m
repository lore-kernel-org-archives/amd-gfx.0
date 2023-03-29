Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C71C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB3710EC1F;
	Wed, 29 Mar 2023 20:10:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FB310EC1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqLAe1UcFMJUqyCqMrDmL9wfiX3gmHvPexrvax2NlSxCnqjNim45mTLCUT9qMAS64F8q4swxX+YW8Rqdq4air6FMv9o9mnUIEf17OPw3Pa0sAoVxaARtfsB6x/R2ot8Y6Gd9jC9DcFxhTP97UO+jDPBlYJFojTbqF4Agvd8GRvdhEaPi5Ydx6NK/Rvz4GvoniXthScPxMbNWNrNUFna28nGvmyrjKa9sRKLH5FPFBeubsXDZf+3TgpqwLsqztCGPgiu5QJs1WB9htUNDC2zheIrIrDEHubcHQ5oZbHiq1lc+tEf03XkeJ+mDlUWB4RH6WRXTe0YlNYsJqveRolW8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWGhnR6mcaS2iEEecKutE+YcXrwecF4NgCISlvv3MFM=;
 b=a8ZATyxNlcRFKoFByH49locw0UGPt2zappD/a9aUuCU0Qg2zByxuv2n3S/mMYZGnExq+exwKxv6JlMJgwysMqef6I59ULigmTBxd84It9A5v+PECrZx0Rf4R/JbIogvmgUEJBnOP+hkMsEOFcL3saJph5Ti0+6qlw2dEbq1J6bTkxGE0Dy8RYEjmSbNZbi+MlLSGOyWfu37wOjKcKNm+pags7cgqQko7BH3zIl9CTvVbIW8wAzez38cupmRLse1ctsvQwcQalu7/XQG/VRN3GEVAE5eM/56intzlqoj4F6t2W8niBdmUbRphi1ZGbAb/00iynHE6rkFyV4yRJsLwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWGhnR6mcaS2iEEecKutE+YcXrwecF4NgCISlvv3MFM=;
 b=Y7yKypEl0OqlhIOXI8hMW3QeajlLpZu571h801006ViJQO23YnnNLOx9YqA8IREEGZGKdks4dDHeZ+sZPEpQevIahwoQz6aOVJLR6wrJBF4Aea4qM6e1zYqHy22ZA9LRVJEAxzxa4oJzMyLS5T2Iy7LBpGn1adTfMuJq/jYvmeM=
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Wed, 29 Mar 2023 20:09:57 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::51) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amdgpu: Use instance lookup table for GC 9.4.3
Date: Wed, 29 Mar 2023 16:09:26 -0400
Message-ID: <20230329200930.1982035-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|MW3PR12MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: bebe0e84-5fc4-4040-a95a-08db30919150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBgUhtjZursJJvC0DU+KqBu3LCNd909lSfqLyQpwaQxesM8qKhul4wCq8O6C3f4WJVwXGPagBgzmsH4nKgjL4W3YM7OFl8VvodYD0lsczvIQxhqpf1oF9nqZkLn/DCcJsevlMASGurlxB56fkpdCLe2CHmvuAJyU6Fc5ArW6cqEMu+yh2mf3RtgWXM9K2U0swlxJXikgZyJ1NjGscGNY0YMzCH6LYIbPxSIZHNOzhIEiq0aKXqJoATpY6RBoq03XrclfMLubTVSvc9NYRozodBlZoUqu6xDg6tiEbS2iYAjGlgJ0H+FUD1Pqa8m001Ap4nPIh1K8jJNsCsLHZ+6dtL4TKeSVOLkaN9raW6thzH0RqO53W6jHPQMk5HNoyv5uSKCffFg7WThzJqQU5WEpzVxF6d2d2vc2hq+1pSrsTUCefC1ZO+1oh2UjO/iYu9+wy4qUYoVq/O6puTxjL9qqP79iB/ye7ydqqw59TBJX+zBOJXQou+H4bxwu8EClXgNpFzJ+ejRaKOPelrclOWELdv9y/gVETMQ3uregofPNgLyR+uZagqPfTtlSS+rjv30DYpdF1Nz12py8+Bmb/K+7+pzQ45VX0hflNdASgA0uRlpwhw7wIvNELmrCKeE8SwR4pjCb6QtWZFLJaBZ2UzrrRSeAMiQzPm+FhU2FuylUGu/ZXaPggGzfNU2lb/vVi4tYrcEZ5n/AjP5s+1yEXk2BPDYgvURQRj1zfBJ4MQbHEF9JC8K4iQ48AldRczbc4zHfpw25GqZ2Dq2fl7ltqd4WYrDt4qWhKPiDEeWpCADVb8w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(83380400001)(6666004)(1076003)(81166007)(356005)(82740400003)(26005)(82310400005)(7696005)(316002)(54906003)(70206006)(36756003)(8676002)(70586007)(40480700001)(6916009)(86362001)(41300700001)(4326008)(40460700003)(2616005)(47076005)(478600001)(30864003)(16526019)(336012)(5660300002)(8936002)(2906002)(426003)(36860700001)(186003)(21314003)(36900700001)(579004)(559001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:56.8649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bebe0e84-5fc4-4040-a95a-08db30919150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Register accesses need to be based on physical instance on bare metal.
Pass the right instance using logical to physical instance lookup
table before accessing registers. Add a macro GET_INST to get the right
physical instance of an IP corresponding to a logical instance.

v2: fix gfx_v9_4_3_check_rlcg_range() (Alex)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  20 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 381 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c      | 146 +++----
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |   3 +
 4 files changed, 279 insertions(+), 271 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index e81bdca53f42..5daec0b45545 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -279,8 +279,8 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	/* HQD registers extend to CP_HQD_AQL_DISPATCH_ID_HI */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
-	hqd_base = SOC15_REG_OFFSET(GC, inst, regCP_MQD_BASE_ADDR);
-	hqd_end = SOC15_REG_OFFSET(GC, inst, regCP_HQD_AQL_DISPATCH_ID_HI);
+	hqd_base = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_MQD_BASE_ADDR);
+	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
 
 	for (reg = hqd_base; reg <= hqd_end; reg++)
 		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
@@ -289,7 +289,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_PQ_DOORBELL_CONTROL),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL),
 				data);
 
 	if (wptr) {
@@ -319,27 +319,27 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_PQ_WPTR_LO),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_LO),
 		       lower_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_PQ_WPTR_HI),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI),
 		       upper_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_PQ_WPTR_POLL_ADDR),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR),
 		       lower_32_bits((uintptr_t)wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, inst,
+		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 			upper_32_bits((uintptr_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, inst, regCP_PQ_WPTR_POLL_CNTL1),
+		WREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1),
 		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id,
 			       queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_EOP_RPTR),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_EOP_RPTR),
 	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
 			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_ACTIVE), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE), data);
 
 	kgd_gfx_v9_release_queue(adev, inst);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index df9756df7941..589fc3e6197d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -195,7 +195,7 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 2; i < num_xcc; i++)
-		WREG32_SOC15(GC, i, regGRBM_MCM_ADDR, 0x4);
+		WREG32_SOC15(GC, GET_INST(GC, i), regGRBM_MCM_ADDR, 0x4);
 }
 
 static void gfx_v9_4_3_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
@@ -241,7 +241,7 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
 	/* scratch_reg0_offset is 32bit even with full XCD config */
 	uint32_t scratch_reg0_offset;
 
-	scratch_reg0_offset = SOC15_REG_OFFSET(GC, ring->xcc_id, regSCRATCH_REG0);
+	scratch_reg0_offset = SOC15_REG_OFFSET(GC, GET_INST(GC, ring->xcc_id), regSCRATCH_REG0);
 	WREG32(scratch_reg0_offset, 0xCAFEDEAD);
 
 	r = amdgpu_ring_alloc(ring, 3);
@@ -329,9 +329,9 @@ static uint64_t gfx_v9_4_3_get_gpu_clock_counter(struct amdgpu_device *adev)
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	WREG32_SOC15(GC, 0, regRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
-	clock = (uint64_t)RREG32_SOC15(GC, 0, regRLC_GPU_CLOCK_COUNT_LSB) |
-		((uint64_t)RREG32_SOC15(GC, 0, regRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
+	clock = (uint64_t)RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPU_CLOCK_COUNT_LSB) |
+		((uint64_t)RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
 	amdgpu_gfx_off_ctrl(adev, true);
 
@@ -603,24 +603,24 @@ static void gfx_v9_4_3_select_se_sh(struct amdgpu_device *adev,
 	else
 		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_INDEX, sh_num);
 
-	WREG32_SOC15_RLC_SHADOW_EX(reg, GC, xcc_id, regGRBM_GFX_INDEX, data);
+	WREG32_SOC15_RLC_SHADOW_EX(reg, GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX, data);
 }
 
 static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t address)
 {
-	WREG32_SOC15_RLC(GC, 0, regSQ_IND_INDEX,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, 0), regSQ_IND_INDEX,
 		(wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
 		(simd << SQ_IND_INDEX__SIMD_ID__SHIFT) |
 		(address << SQ_IND_INDEX__INDEX__SHIFT) |
 		(SQ_IND_INDEX__FORCE_READ_MASK));
-	return RREG32_SOC15(GC, 0, regSQ_IND_DATA);
+	return RREG32_SOC15(GC, GET_INST(GC, 0), regSQ_IND_DATA);
 }
 
 static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 			   uint32_t wave, uint32_t thread,
 			   uint32_t regno, uint32_t num, uint32_t *out)
 {
-	WREG32_SOC15_RLC(GC, 0, regSQ_IND_INDEX,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, 0), regSQ_IND_INDEX,
 		(wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
 		(simd << SQ_IND_INDEX__SIMD_ID__SHIFT) |
 		(regno << SQ_IND_INDEX__INDEX__SHIFT) |
@@ -628,7 +628,7 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 		(SQ_IND_INDEX__FORCE_READ_MASK) |
 		(SQ_IND_INDEX__AUTO_INCR_MASK));
 	while (num--)
-		*(out++) = RREG32_SOC15(GC, 0, regSQ_IND_DATA);
+		*(out++) = RREG32_SOC15(GC, GET_INST(GC, 0), regSQ_IND_DATA);
 }
 
 static void gfx_v9_4_3_read_wave_data(struct amdgpu_device *adev,
@@ -674,7 +674,7 @@ static void gfx_v9_4_3_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd
 static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
 					u32 me, u32 pipe, u32 q, u32 vm)
 {
-	soc15_grbm_select(adev, me, pipe, q, vm, 0);
+	soc15_grbm_select(adev, me, pipe, q, vm, GET_INST(GC, 0));
 }
 
 static enum amdgpu_gfx_partition
@@ -724,7 +724,7 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 				    num_xcc_per_partition);
 		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
 				    i % num_xcc_per_partition);
-		WREG32_SOC15(GC, i, regCP_HYP_XCP_CTL, tmp);
+		WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL, tmp);
 	}
 
 	if (adev->nbio.funcs->set_compute_partition_mode)
@@ -760,7 +760,7 @@ static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
 		adev->gfx.config.sc_hiz_tile_fifo_size = 0x30;
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
-		gb_addr_config = RREG32_SOC15(GC, 0, regGB_ADDR_CONFIG);
+		gb_addr_config = RREG32_SOC15(GC, GET_INST(GC, 0), regGB_ADDR_CONFIG);
 		break;
 	default:
 		BUG();
@@ -962,8 +962,8 @@ static u32 gfx_v9_4_3_get_rb_active_bitmap(struct amdgpu_device *adev)
 {
 	u32 data, mask;
 
-	data = RREG32_SOC15(GC, 0, regCC_RB_BACKEND_DISABLE);
-	data |= RREG32_SOC15(GC, 0, regGC_USER_RB_BACKEND_DISABLE);
+	data = RREG32_SOC15(GC, GET_INST(GC, 0), regCC_RB_BACKEND_DISABLE);
+	data |= RREG32_SOC15(GC, GET_INST(GC, 0), regGC_USER_RB_BACKEND_DISABLE);
 
 	data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
 	data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
@@ -1019,21 +1019,21 @@ static void gfx_v9_4_3_init_compute_vmid(struct amdgpu_device *adev, int xcc_id)
 
 	mutex_lock(&adev->srbm_mutex);
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
-		soc15_grbm_select(adev, 0, 0, 0, i, xcc_id);
+		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
-		WREG32_SOC15_RLC(GC, xcc_id, regSH_MEM_CONFIG, sh_mem_config);
-		WREG32_SOC15_RLC(GC, xcc_id, regSH_MEM_BASES, sh_mem_bases);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_BASES, sh_mem_bases);
 	}
-	soc15_grbm_select(adev, 0, 0, 0, 0, xcc_id);
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   acccess. These should be enabled by FW for target VMIDs. */
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
-		WREG32_SOC15_OFFSET(GC, xcc_id, regGDS_VMID0_BASE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, xcc_id, regGDS_VMID0_SIZE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, xcc_id, regGDS_GWS_VMID0, i, 0);
-		WREG32_SOC15_OFFSET(GC, xcc_id, regGDS_OA_VMID0, i, 0);
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_OA_VMID0, i, 0);
 	}
 }
 
@@ -1048,10 +1048,10 @@ static void gfx_v9_4_3_init_gds_vmid(struct amdgpu_device *adev, int xcc_id)
 	 * access so that HWS firmware can save/restore entries.
 	 */
 	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
-		WREG32_SOC15_OFFSET(GC, xcc_id, regGDS_VMID0_BASE, 2 * vmid, 0);
-		WREG32_SOC15_OFFSET(GC, xcc_id, regGDS_VMID0_SIZE, 2 * vmid, 0);
-		WREG32_SOC15_OFFSET(GC, xcc_id, regGDS_GWS_VMID0, vmid, 0);
-		WREG32_SOC15_OFFSET(GC, xcc_id, regGDS_OA_VMID0, vmid, 0);
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * vmid, 0);
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * vmid, 0);
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, vmid, 0);
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_OA_VMID0, vmid, 0);
 	}
 }
 
@@ -1062,42 +1062,42 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		WREG32_FIELD15_PREREG(GC, i, GRBM_CNTL, READ_TIMEOUT, 0xff);
+		WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), GRBM_CNTL, READ_TIMEOUT, 0xff);
 		gfx_v9_4_3_setup_rb(adev, i);
 	}
 
 	gfx_v9_4_3_get_cu_info(adev, &adev->gfx.cu_info);
-	adev->gfx.config.db_debug2 = RREG32_SOC15(GC, 0, regDB_DEBUG2);
+	adev->gfx.config.db_debug2 = RREG32_SOC15(GC, GET_INST(GC, 0), regDB_DEBUG2);
 
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
 	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
 		for (j = 0; j < num_xcc; j++) {
-			soc15_grbm_select(adev, 0, 0, 0, i, j);
+			soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, j));
 			/* CP and shaders */
 			if (i == 0) {
 				tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,
 						    SH_MEM_ALIGNMENT_MODE_UNALIGNED);
 				tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, RETRY_DISABLE,
 						    !!adev->gmc.noretry);
-				WREG32_SOC15_RLC(GC, j, regSH_MEM_CONFIG, tmp);
-				WREG32_SOC15_RLC(GC, j, regSH_MEM_BASES, 0);
+				WREG32_SOC15_RLC(GC, GET_INST(GC, j), regSH_MEM_CONFIG, tmp);
+				WREG32_SOC15_RLC(GC, GET_INST(GC, j), regSH_MEM_BASES, 0);
 			} else {
 				tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,
 						    SH_MEM_ALIGNMENT_MODE_UNALIGNED);
 				tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, RETRY_DISABLE,
 						    !!adev->gmc.noretry);
-				WREG32_SOC15_RLC(GC, j, regSH_MEM_CONFIG, tmp);
+				WREG32_SOC15_RLC(GC, GET_INST(GC, j), regSH_MEM_CONFIG, tmp);
 				tmp = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
 					(adev->gmc.private_aperture_start >> 48));
 				tmp = REG_SET_FIELD(tmp, SH_MEM_BASES, SHARED_BASE,
 					(adev->gmc.shared_aperture_start >> 48));
-				WREG32_SOC15_RLC(GC, j, regSH_MEM_BASES, tmp);
+				WREG32_SOC15_RLC(GC, GET_INST(GC, j), regSH_MEM_BASES, tmp);
 			}
 		}
 	}
-	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, 0));
 
 	mutex_unlock(&adev->srbm_mutex);
 
@@ -1110,18 +1110,18 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 static void gfx_v9_4_3_enable_save_restore_machine(struct amdgpu_device *adev,
 						   int xcc_id)
 {
-	WREG32_FIELD15_PREREG(GC, xcc_id, RLC_SRM_CNTL, SRM_ENABLE, 1);
+	WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), RLC_SRM_CNTL, SRM_ENABLE, 1);
 }
 
 static void gfx_v9_4_3_init_csb(struct amdgpu_device *adev, int xcc_id)
 {
 	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 	/* csib */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, xcc_id, regRLC_CSIB_ADDR_HI),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_CSIB_ADDR_HI),
 			adev->gfx.rlc.clear_state_gpu_addr >> 32);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, xcc_id, regRLC_CSIB_ADDR_LO),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_CSIB_ADDR_LO),
 			adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, xcc_id, regRLC_CSIB_LENGTH),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_CSIB_LENGTH),
 			adev->gfx.rlc.clear_state_size);
 }
 
@@ -1142,7 +1142,7 @@ static void gfx_v9_4_3_init_pg(struct amdgpu_device *adev, int xcc_id)
 			      AMD_PG_SUPPORT_CP |
 			      AMD_PG_SUPPORT_GDS |
 			      AMD_PG_SUPPORT_RLC_SMU_HS)) {
-		WREG32_SOC15(GC, 0, regRLC_JUMP_TABLE_RESTORE,
+		WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_JUMP_TABLE_RESTORE,
 		       adev->gfx.rlc.cp_table_gpu_addr >> 8);
 	}
 }
@@ -1151,9 +1151,9 @@ void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 
-	data = RREG32_SOC15(GC, xcc_id, regCPC_PSP_DEBUG);
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCPC_PSP_DEBUG);
 	data |= CPC_PSP_DEBUG__UTCL2IUGPAOVERRIDE_MASK;
-	WREG32_SOC15(GC, xcc_id, regCPC_PSP_DEBUG, data);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCPC_PSP_DEBUG, data);
 }
 
 static void gfx_v9_4_3_program_xcc_id(struct amdgpu_device *adev, int xcc_id)
@@ -1165,16 +1165,16 @@ static void gfx_v9_4_3_program_xcc_id(struct amdgpu_device *adev, int xcc_id)
 	switch (num_xcc) {
 	/* directly config VIRTUAL_XCC_ID to 0 for 1-XCC */
 	case 1:
-		WREG32_SOC15(GC, xcc_id, regCP_HYP_XCP_CTL, 0x8);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, 0x8);
 		break;
 	case 2:
 		tmp = (xcc_id % adev->gfx.num_xcc_per_xcp) << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
 		tmp = tmp | (adev->gfx.num_xcc_per_xcp << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
-		WREG32_SOC15(GC, xcc_id, regCP_HYP_XCP_CTL, tmp);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, tmp);
 
 		tmp = xcc_id << REG_FIELD_SHIFT(CP_PSP_XCP_CTL, PHYSICAL_XCC_ID);
 		tmp = tmp | (xcc_id << REG_FIELD_SHIFT(CP_PSP_XCP_CTL, XCC_DIE_ID));
-		WREG32_SOC15(GC, xcc_id, regCP_PSP_XCP_CTL, tmp);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_PSP_XCP_CTL, tmp);
 		break;
 	default:
 		break;
@@ -1186,7 +1186,7 @@ static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)
 	uint32_t rlc_setting;
 
 	/* if RLC is not enabled, do nothing */
-	rlc_setting = RREG32_SOC15(GC, 0, regRLC_CNTL);
+	rlc_setting = RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CNTL);
 	if (!(rlc_setting & RLC_CNTL__RLC_ENABLE_F32_MASK))
 		return false;
 
@@ -1200,11 +1200,11 @@ static void gfx_v9_4_3_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 
 	data = RLC_SAFE_MODE__CMD_MASK;
 	data |= (1 << RLC_SAFE_MODE__MESSAGE__SHIFT);
-	WREG32_SOC15(GC, xcc_id, regRLC_SAFE_MODE, data);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SAFE_MODE, data);
 
 	/* wait for RLC_SAFE_MODE */
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (!REG_GET_FIELD(RREG32_SOC15(GC, 0, regRLC_SAFE_MODE), RLC_SAFE_MODE, CMD))
+		if (!REG_GET_FIELD(RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SAFE_MODE), RLC_SAFE_MODE, CMD))
 			break;
 		udelay(1);
 	}
@@ -1215,7 +1215,7 @@ static void gfx_v9_4_3_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 	uint32_t data;
 
 	data = RLC_SAFE_MODE__CMD_MASK;
-	WREG32_SOC15(GC, xcc_id, regRLC_SAFE_MODE, data);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SAFE_MODE, data);
 }
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
@@ -1252,7 +1252,7 @@ static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev,
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff, xcc_id);
 			for (k = 0; k < adev->usec_timeout; k++) {
-				if (RREG32_SOC15(GC, 0, regRLC_SERDES_CU_MASTER_BUSY) == 0)
+				if (RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SERDES_CU_MASTER_BUSY) == 0)
 					break;
 				udelay(1);
 			}
@@ -1275,7 +1275,7 @@ static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev,
 		RLC_SERDES_NONCU_MASTER_BUSY__TC0_MASTER_BUSY_MASK |
 		RLC_SERDES_NONCU_MASTER_BUSY__TC1_MASTER_BUSY_MASK;
 	for (k = 0; k < adev->usec_timeout; k++) {
-		if ((RREG32_SOC15(GC, 0, regRLC_SERDES_NONCU_MASTER_BUSY) & mask) == 0)
+		if ((RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SERDES_NONCU_MASTER_BUSY) & mask) == 0)
 			break;
 		udelay(1);
 	}
@@ -1288,13 +1288,13 @@ static void gfx_v9_4_3_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 
 	/* These interrupts should be enabled to drive DS clock */
 
-	tmp= RREG32_SOC15(GC, xcc_id, regCP_INT_CNTL_RING0);
+	tmp= RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_INT_CNTL_RING0);
 
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE, enable ? 1 : 0);
 
-	WREG32_SOC15(GC, xcc_id, regCP_INT_CNTL_RING0, tmp);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_INT_CNTL_RING0, tmp);
 }
 
 static void gfx_v9_4_3_rlc_stop(struct amdgpu_device *adev)
@@ -1303,7 +1303,7 @@ static void gfx_v9_4_3_rlc_stop(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		WREG32_FIELD15_PREREG(GC, i, RLC_CNTL, RLC_ENABLE_F32, 0);
+		WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), RLC_CNTL, RLC_ENABLE_F32, 0);
 		gfx_v9_4_3_enable_gui_idle_interrupt(adev, false, i);
 		gfx_v9_4_3_wait_for_rlc_serdes(adev, i);
 	}
@@ -1315,9 +1315,9 @@ static void gfx_v9_4_3_rlc_reset(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		WREG32_FIELD15_PREREG(GC, i, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
+		WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
 		udelay(50);
-		WREG32_FIELD15_PREREG(GC, i, GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
+		WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
 		udelay(50);
 	}
 }
@@ -1331,7 +1331,7 @@ static void gfx_v9_4_3_rlc_start(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		WREG32_FIELD15_PREREG(GC, i, RLC_CNTL, RLC_ENABLE_F32, 1);
+		WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), RLC_CNTL, RLC_ENABLE_F32, 1);
 		udelay(50);
 
 		/* carrizo do enable cp interrupt after cp inited */
@@ -1342,18 +1342,18 @@ static void gfx_v9_4_3_rlc_start(struct amdgpu_device *adev)
 
 #ifdef AMDGPU_RLC_DEBUG_RETRY
 		/* RLC_GPM_GENERAL_6 : RLC Ucode version */
-		rlc_ucode_ver = RREG32_SOC15(GC, i, regRLC_GPM_GENERAL_6);
+		rlc_ucode_ver = RREG32_SOC15(GC, GET_INST(GC, i), regRLC_GPM_GENERAL_6);
 		if(rlc_ucode_ver == 0x108) {
 			dev_info(adev->dev,
 				 "Using rlc debug ucode. regRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i \n",
 				 rlc_ucode_ver, adev->gfx.rlc_fw_version);
 			/* RLC_GPM_TIMER_INT_3 : Timer interval in RefCLK cycles,
 			 * default is 0x9C4 to create a 100us interval */
-			WREG32_SOC15(GC, i, regRLC_GPM_TIMER_INT_3, 0x9C4);
+			WREG32_SOC15(GC, GET_INST(GC, i), regRLC_GPM_TIMER_INT_3, 0x9C4);
 			/* RLC_GPM_GENERAL_12 : Minimum gap between wptr and rptr
 			 * to disable the page fault retry interrupts, default is
 			 * 0x100 (256) */
-			WREG32_SOC15(GC, i, regRLC_GPM_GENERAL_12, 0x100);
+			WREG32_SOC15(GC, GET_INST(GC, i), regRLC_GPM_GENERAL_12, 0x100);
 		}
 #endif
 	}
@@ -1375,16 +1375,16 @@ static int gfx_v9_4_3_rlc_load_microcode(struct amdgpu_device *adev, int xcc_id)
 			   le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 	fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
 
-	WREG32_SOC15(GC, xcc_id, regRLC_GPM_UCODE_ADDR,
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_GPM_UCODE_ADDR,
 			RLCG_UCODE_LOADING_START_ADDRESS);
 	for (i = 0; i < fw_size; i++) {
 		if (amdgpu_emu_mode == 1 && i % 100 == 0) {
 			dev_info(adev->dev, "Write RLC ucode data %u DWs\n", i);
 			msleep(1);
 		}
-		WREG32_SOC15(GC, xcc_id, regRLC_GPM_UCODE_DATA, le32_to_cpup(fw_data++));
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_GPM_UCODE_DATA, le32_to_cpup(fw_data++));
 	}
-	WREG32_SOC15(GC, xcc_id, regRLC_GPM_UCODE_ADDR, adev->gfx.rlc_fw_version);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_GPM_UCODE_ADDR, adev->gfx.rlc_fw_version);
 
 	return 0;
 }
@@ -1398,7 +1398,7 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		/* disable CG */
-		WREG32_SOC15(GC, i, regRLC_CGCG_CGLS_CTRL, 0);
+		WREG32_SOC15(GC, GET_INST(GC, i), regRLC_CGCG_CGLS_CTRL, 0);
 
 		gfx_v9_4_3_init_pg(adev, i);
 
@@ -1420,7 +1420,7 @@ static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
 {
 	u32 reg, data;
 
-	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
+	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
 	else
@@ -1430,9 +1430,9 @@ static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
 
 	if (amdgpu_sriov_is_pp_one_vf(adev))
-		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
+		WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, 0), regRLC_SPM_MC_CNTL, data);
 	else
-		WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
+		WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_MC_CNTL, data);
 }
 
 static const struct soc15_reg_rlcg rlcg_access_gc_9_4_3[] = {
@@ -1444,7 +1444,7 @@ static bool gfx_v9_4_3_check_rlcg_range(struct amdgpu_device *adev,
 					uint32_t offset,
 					struct soc15_reg_rlcg *entries, int arr_size)
 {
-	int i;
+	int i, inst;
 	uint32_t reg;
 
 	if (!entries)
@@ -1454,7 +1454,12 @@ static bool gfx_v9_4_3_check_rlcg_range(struct amdgpu_device *adev,
 		const struct soc15_reg_rlcg *entry;
 
 		entry = &entries[i];
-		reg = adev->reg_offset[entry->hwip][entry->instance][entry->segment] + entry->reg;
+		inst = adev->ip_map.logical_to_dev_inst ?
+			       adev->ip_map.logical_to_dev_inst(
+				       adev, entry->hwip, entry->instance) :
+			       entry->instance;
+		reg = adev->reg_offset[entry->hwip][inst][entry->segment] +
+		      entry->reg;
 		if (offset == reg)
 			return true;
 	}
@@ -1473,9 +1478,9 @@ static void gfx_v9_4_3_cp_compute_enable(struct amdgpu_device *adev,
 					 bool enable, int xcc_id)
 {
 	if (enable) {
-		WREG32_SOC15_RLC(GC, xcc_id, regCP_MEC_CNTL, 0);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, 0);
 	} else {
-		WREG32_SOC15_RLC(GC, xcc_id, regCP_MEC_CNTL,
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL,
 			(CP_MEC_CNTL__MEC_ME1_HALT_MASK | CP_MEC_CNTL__MEC_ME2_HALT_MASK));
 		adev->gfx.kiq[xcc_id].ring.sched.ready = false;
 	}
@@ -1506,17 +1511,17 @@ static int gfx_v9_4_3_cp_compute_load_microcode(struct amdgpu_device *adev,
 	tmp = 0;
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, VMID, 0);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
-	WREG32_SOC15(GC, xcc_id, regCP_CPC_IC_BASE_CNTL, tmp);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_CNTL, tmp);
 
-	WREG32_SOC15(GC, xcc_id, regCP_CPC_IC_BASE_LO,
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_LO,
 		adev->gfx.mec.mec_fw_gpu_addr & 0xFFFFF000);
-	WREG32_SOC15(GC, xcc_id, regCP_CPC_IC_BASE_HI,
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_HI,
 		upper_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
 
 	mec_ucode_addr_offset =
-		SOC15_REG_OFFSET(GC, xcc_id, regCP_MEC_ME1_UCODE_ADDR);
+		SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_MEC_ME1_UCODE_ADDR);
 	mec_ucode_data_offset =
-		SOC15_REG_OFFSET(GC, xcc_id, regCP_MEC_ME1_UCODE_DATA);
+		SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_MEC_ME1_UCODE_DATA);
 
 	/* MEC1 */
 	WREG32(mec_ucode_addr_offset, mec_hdr->jt_offset);
@@ -1537,12 +1542,12 @@ static void gfx_v9_4_3_kiq_setting(struct amdgpu_ring *ring, int xcc_id)
 	struct amdgpu_device *adev = ring->adev;
 
 	/* tell RLC which is KIQ queue */
-	tmp = RREG32_SOC15(GC, xcc_id, regRLC_CP_SCHEDULERS);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS);
 	tmp &= 0xffffff00;
 	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32_SOC15_RLC(GC, xcc_id, regRLC_CP_SCHEDULERS, tmp);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tmp);
 	tmp |= 0x80;
-	WREG32_SOC15_RLC(GC, xcc_id, regRLC_CP_SCHEDULERS, tmp);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tmp);
 }
 
 static void gfx_v9_4_3_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *mqd)
@@ -1585,14 +1590,14 @@ static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_EOP_CONTROL);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_EOP_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(GFX9_MEC_HPD_SIZE / 4) - 1));
 
 	mqd->cp_hqd_eop_control = tmp;
 
 	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PQ_DOORBELL_CONTROL);
 
 	if (ring->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -1622,7 +1627,7 @@ static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, 0, regCP_MQD_CONTROL);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_MQD_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
@@ -1632,7 +1637,7 @@ static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PQ_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(ring->ring_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
@@ -1659,23 +1664,23 @@ static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	ring->wptr = 0;
-	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR);
+	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PQ_RPTR);
 
 	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
 
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PERSISTENT_STATE);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PERSISTENT_STATE);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x53);
 	mqd->cp_hqd_persistent_state = tmp;
 
 	/* set MIN_IB_AVAIL_SIZE */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_IB_CONTROL);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_IB_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
 	/* set static priority for a queue/ring */
 	gfx_v9_4_3_mqd_set_priority(ring, mqd);
-	mqd->cp_hqd_quantum = RREG32_SOC15(GC, 0, regCP_HQD_QUANTUM);
+	mqd->cp_hqd_quantum = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_QUANTUM);
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
@@ -1695,94 +1700,94 @@ static int gfx_v9_4_3_kiq_init_register(struct amdgpu_ring *ring, int xcc_id)
 	/* disable wptr polling */
 	WREG32_FIELD15_PREREG(GC, xcc_id, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_EOP_BASE_ADDR,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_BASE_ADDR,
 	       mqd->cp_hqd_eop_base_addr_lo);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_EOP_BASE_ADDR_HI,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_BASE_ADDR_HI,
 	       mqd->cp_hqd_eop_base_addr_hi);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_EOP_CONTROL,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_CONTROL,
 	       mqd->cp_hqd_eop_control);
 
 	/* enable doorbell? */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_DOORBELL_CONTROL,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL,
 	       mqd->cp_hqd_pq_doorbell_control);
 
 	/* disable the queue if it's active */
-	if (RREG32_SOC15(GC, xcc_id, regCP_HQD_ACTIVE) & 1) {
-		WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_DEQUEUE_REQUEST, 1);
+	if (RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1) {
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST, 1);
 		for (j = 0; j < adev->usec_timeout; j++) {
-			if (!(RREG32_SOC15(GC, xcc_id, regCP_HQD_ACTIVE) & 1))
+			if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
 				break;
 			udelay(1);
 		}
-		WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_DEQUEUE_REQUEST,
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST,
 		       mqd->cp_hqd_dequeue_request);
-		WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_RPTR,
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR,
 		       mqd->cp_hqd_pq_rptr);
-		WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_WPTR_LO,
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_LO,
 		       mqd->cp_hqd_pq_wptr_lo);
-		WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_WPTR_HI,
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_HI,
 		       mqd->cp_hqd_pq_wptr_hi);
 	}
 
 	/* set the pointer to the MQD */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_MQD_BASE_ADDR,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_MQD_BASE_ADDR,
 	       mqd->cp_mqd_base_addr_lo);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_MQD_BASE_ADDR_HI,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_MQD_BASE_ADDR_HI,
 	       mqd->cp_mqd_base_addr_hi);
 
 	/* set MQD vmid to 0 */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_MQD_CONTROL,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_MQD_CONTROL,
 	       mqd->cp_mqd_control);
 
 	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_BASE,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_BASE,
 	       mqd->cp_hqd_pq_base_lo);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_BASE_HI,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_BASE_HI,
 	       mqd->cp_hqd_pq_base_hi);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_CONTROL,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_CONTROL,
 	       mqd->cp_hqd_pq_control);
 
 	/* set the wb address whether it's enabled or not */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_RPTR_REPORT_ADDR,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR_REPORT_ADDR,
 				mqd->cp_hqd_pq_rptr_report_addr_lo);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
 				mqd->cp_hqd_pq_rptr_report_addr_hi);
 
 	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_WPTR_POLL_ADDR,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_POLL_ADDR,
 	       mqd->cp_hqd_pq_wptr_poll_addr_lo);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_WPTR_POLL_ADDR_HI,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_POLL_ADDR_HI,
 	       mqd->cp_hqd_pq_wptr_poll_addr_hi);
 
 	/* enable the doorbell if requested */
 	if (ring->use_doorbell) {
-		WREG32_SOC15(GC, xcc_id, regCP_MEC_DOORBELL_RANGE_LOWER,
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DOORBELL_RANGE_LOWER,
 					(adev->doorbell_index.kiq * 2) << 2);
-		WREG32_SOC15(GC, xcc_id, regCP_MEC_DOORBELL_RANGE_UPPER,
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DOORBELL_RANGE_UPPER,
 				(adev->doorbell_index.userqueue_end * 2) << 2);
 	}
 
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_DOORBELL_CONTROL,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL,
 	       mqd->cp_hqd_pq_doorbell_control);
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_WPTR_LO,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_LO,
 	       mqd->cp_hqd_pq_wptr_lo);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_WPTR_HI,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_HI,
 	       mqd->cp_hqd_pq_wptr_hi);
 
 	/* set the vmid for the queue */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_VMID, mqd->cp_hqd_vmid);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_VMID, mqd->cp_hqd_vmid);
 
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PERSISTENT_STATE,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PERSISTENT_STATE,
 	       mqd->cp_hqd_persistent_state);
 
 	/* activate the queue */
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_ACTIVE,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE,
 	       mqd->cp_hqd_active);
 
 	if (ring->use_doorbell)
@@ -1797,12 +1802,12 @@ static int gfx_v9_4_3_kiq_fini_register(struct amdgpu_ring *ring, int xcc_id)
 	int j;
 
 	/* disable the queue if it's active */
-	if (RREG32_SOC15(GC, xcc_id, regCP_HQD_ACTIVE) & 1) {
+	if (RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1) {
 
-		WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_DEQUEUE_REQUEST, 1);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST, 1);
 
 		for (j = 0; j < adev->usec_timeout; j++) {
-			if (!(RREG32_SOC15(GC, xcc_id, regCP_HQD_ACTIVE) & 1))
+			if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
 				break;
 			udelay(1);
 		}
@@ -1811,21 +1816,21 @@ static int gfx_v9_4_3_kiq_fini_register(struct amdgpu_ring *ring, int xcc_id)
 			DRM_DEBUG("KIQ dequeue request failed.\n");
 
 			/* Manual disable if dequeue request times out */
-			WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_ACTIVE, 0);
+			WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE, 0);
 		}
 
-		WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_DEQUEUE_REQUEST,
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST,
 		      0);
 	}
 
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_IQ_TIMER, 0);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_IB_CONTROL, 0);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PERSISTENT_STATE, 0);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_DOORBELL_CONTROL, 0x40000000);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_DOORBELL_CONTROL, 0);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_RPTR, 0);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_WPTR_HI, 0);
-	WREG32_SOC15_RLC(GC, xcc_id, regCP_HQD_PQ_WPTR_LO, 0);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_IQ_TIMER, 0);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_IB_CONTROL, 0);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PERSISTENT_STATE, 0);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL, 0x40000000);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL, 0);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR, 0);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_HI, 0);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_LO, 0);
 
 	return 0;
 }
@@ -1853,19 +1858,19 @@ static int gfx_v9_4_3_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 		ring->wptr = 0;
 		amdgpu_ring_clear_ring(ring);
 		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, xcc_id);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, xcc_id));
 		gfx_v9_4_3_kiq_init_register(ring, xcc_id);
-		soc15_grbm_select(adev, 0, 0, 0, 0, xcc_id);
+		soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 		mutex_unlock(&adev->srbm_mutex);
 	} else {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
 		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, xcc_id);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, xcc_id));
 		gfx_v9_4_3_mqd_init(ring);
 		gfx_v9_4_3_kiq_init_register(ring, xcc_id);
-		soc15_grbm_select(adev, 0, 0, 0, 0, xcc_id);
+		soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.kiq[xcc_id].mqd_backup)
@@ -1893,9 +1898,9 @@ static int gfx_v9_4_3_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
 		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, xcc_id);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, xcc_id));
 		gfx_v9_4_3_mqd_init(ring);
-		soc15_grbm_select(adev, 0, 0, 0, 0, xcc_id);
+		soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
@@ -2055,9 +2060,9 @@ static int gfx_v9_4_3_hw_fini(void *handle)
 			mutex_lock(&adev->srbm_mutex);
 			soc15_grbm_select(adev, adev->gfx.kiq[i].ring.me,
 					adev->gfx.kiq[i].ring.pipe,
-					adev->gfx.kiq[i].ring.queue, 0, i);
+					adev->gfx.kiq[i].ring.queue, 0, GET_INST(GC, i));
 			gfx_v9_4_3_kiq_fini_register(&adev->gfx.kiq[i].ring, i);
-			soc15_grbm_select(adev, 0, 0, 0, 0, i);
+			soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, i));
 			mutex_unlock(&adev->srbm_mutex);
 		}
 
@@ -2091,7 +2096,7 @@ static bool gfx_v9_4_3_is_idle(void *handle)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		if (REG_GET_FIELD(RREG32_SOC15(GC, i, regGRBM_STATUS),
+		if (REG_GET_FIELD(RREG32_SOC15(GC, GET_INST(GC, i), regGRBM_STATUS),
 					GRBM_STATUS, GUI_ACTIVE))
 			return false;
 	}
@@ -2118,7 +2123,7 @@ static int gfx_v9_4_3_soft_reset(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	/* GRBM_STATUS */
-	tmp = RREG32_SOC15(GC, 0, regGRBM_STATUS);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_STATUS);
 	if (tmp & (GRBM_STATUS__PA_BUSY_MASK | GRBM_STATUS__SC_BUSY_MASK |
 		   GRBM_STATUS__BCI_BUSY_MASK | GRBM_STATUS__SX_BUSY_MASK |
 		   GRBM_STATUS__TA_BUSY_MASK | GRBM_STATUS__VGT_BUSY_MASK |
@@ -2137,7 +2142,7 @@ static int gfx_v9_4_3_soft_reset(void *handle)
 	}
 
 	/* GRBM_STATUS2 */
-	tmp = RREG32_SOC15(GC, 0, regGRBM_STATUS2);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_STATUS2);
 	if (REG_GET_FIELD(tmp, GRBM_STATUS2, RLC_BUSY))
 		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
 						GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
@@ -2151,17 +2156,17 @@ static int gfx_v9_4_3_soft_reset(void *handle)
 		gfx_v9_4_3_cp_compute_enable(adev, false, 0);
 
 		if (grbm_soft_reset) {
-			tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+			tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
 			tmp |= grbm_soft_reset;
 			dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
-			WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
-			tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+			WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET, tmp);
+			tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
 
 			udelay(50);
 
 			tmp &= ~grbm_soft_reset;
-			WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
-			tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+			WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET, tmp);
+			tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
 		}
 
 		/* Wait a little for things to settle down */
@@ -2180,22 +2185,22 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct amdgpu_ring *ring,
 
 	/* GDS Base */
 	gfx_v9_4_3_write_data_to_reg(ring, 0, false,
-				   SOC15_REG_OFFSET(GC, 0, regGDS_VMID0_BASE) + 2 * vmid,
+				   SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regGDS_VMID0_BASE) + 2 * vmid,
 				   gds_base);
 
 	/* GDS Size */
 	gfx_v9_4_3_write_data_to_reg(ring, 0, false,
-				   SOC15_REG_OFFSET(GC, 0, regGDS_VMID0_SIZE) + 2 * vmid,
+				   SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regGDS_VMID0_SIZE) + 2 * vmid,
 				   gds_size);
 
 	/* GWS */
 	gfx_v9_4_3_write_data_to_reg(ring, 0, false,
-				   SOC15_REG_OFFSET(GC, 0, regGDS_GWS_VMID0) + vmid,
+				   SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regGDS_GWS_VMID0) + vmid,
 				   gws_size << GDS_GWS_VMID0__SIZE__SHIFT | gws_base);
 
 	/* OA */
 	gfx_v9_4_3_write_data_to_reg(ring, 0, false,
-				   SOC15_REG_OFFSET(GC, 0, regGDS_OA_VMID0) + vmid,
+				   SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regGDS_OA_VMID0) + vmid,
 				   (1 << (oa_size + oa_base)) - (1 << oa_base));
 }
 
@@ -2266,7 +2271,7 @@ static void gfx_v9_4_3_update_medium_grain_clock_gating(struct amdgpu_device *ad
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
-		def = data = RREG32_SOC15(GC, xcc_id, regRLC_CGTT_MGCG_OVERRIDE);
+		def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
 
 		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK |
@@ -2276,28 +2281,28 @@ static void gfx_v9_4_3_update_medium_grain_clock_gating(struct amdgpu_device *ad
 		data |= RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK;
 
 		if (def != data)
-			WREG32_SOC15(GC, xcc_id, regRLC_CGTT_MGCG_OVERRIDE, data);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
 
 		/* MGLS is a global flag to control all MGLS in GFX */
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) {
 			/* 2 - RLC memory Light sleep */
 			if (adev->cg_flags & AMD_CG_SUPPORT_GFX_RLC_LS) {
-				def = data = RREG32_SOC15(GC, xcc_id, regRLC_MEM_SLP_CNTL);
+				def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_MEM_SLP_CNTL);
 				data |= RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK;
 				if (def != data)
-					WREG32_SOC15(GC, xcc_id, regRLC_MEM_SLP_CNTL, data);
+					WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_MEM_SLP_CNTL, data);
 			}
 			/* 3 - CP memory Light sleep */
 			if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CP_LS) {
-				def = data = RREG32_SOC15(GC, xcc_id, regCP_MEM_SLP_CNTL);
+				def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEM_SLP_CNTL);
 				data |= CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK;
 				if (def != data)
-					WREG32_SOC15(GC, xcc_id, regCP_MEM_SLP_CNTL, data);
+					WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEM_SLP_CNTL, data);
 			}
 		}
 	} else {
 		/* 1 - MGCG_OVERRIDE */
-		def = data = RREG32_SOC15(GC, xcc_id, regRLC_CGTT_MGCG_OVERRIDE);
+		def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
 
 		data |= (RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
 			 RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
@@ -2305,20 +2310,20 @@ static void gfx_v9_4_3_update_medium_grain_clock_gating(struct amdgpu_device *ad
 			 RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK);
 
 		if (def != data)
-			WREG32_SOC15(GC, xcc_id, regRLC_CGTT_MGCG_OVERRIDE, data);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
 
 		/* 2 - disable MGLS in RLC */
-		data = RREG32_SOC15(GC, xcc_id, regRLC_MEM_SLP_CNTL);
+		data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_MEM_SLP_CNTL);
 		if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK) {
 			data &= ~RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK;
-			WREG32_SOC15(GC, xcc_id, regRLC_MEM_SLP_CNTL, data);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_MEM_SLP_CNTL, data);
 		}
 
 		/* 3 - disable MGLS in CP */
-		data = RREG32_SOC15(GC, xcc_id, regCP_MEM_SLP_CNTL);
+		data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEM_SLP_CNTL);
 		if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK) {
 			data &= ~CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK;
-			WREG32_SOC15(GC, xcc_id, regCP_MEM_SLP_CNTL, data);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEM_SLP_CNTL, data);
 		}
 	}
 
@@ -2333,7 +2338,7 @@ static void gfx_v9_4_3_update_coarse_grain_clock_gating(struct amdgpu_device *ad
 	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
-		def = data = RREG32_SOC15(GC, xcc_id, regRLC_CGTT_MGCG_OVERRIDE);
+		def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
 		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
@@ -2342,10 +2347,10 @@ static void gfx_v9_4_3_update_coarse_grain_clock_gating(struct amdgpu_device *ad
 			data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
 		/* update CGCG and CGLS override bits */
 		if (def != data)
-			WREG32_SOC15(GC, xcc_id, regRLC_CGTT_MGCG_OVERRIDE, data);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
 
 		/* enable cgcg FSM(0x0000363F) */
-		def = RREG32_SOC15(GC, xcc_id, regRLC_CGCG_CGLS_CTRL);
+		def = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL);
 
 		if (adev->asic_type == CHIP_ARCTURUS)
 			data = (0x2000 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
@@ -2357,21 +2362,21 @@ static void gfx_v9_4_3_update_coarse_grain_clock_gating(struct amdgpu_device *ad
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
 		if (def != data)
-			WREG32_SOC15(GC, xcc_id, regRLC_CGCG_CGLS_CTRL, data);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL, data);
 
 		/* set IDLE_POLL_COUNT(0x00900100) */
-		def = RREG32_SOC15(GC, xcc_id, regCP_RB_WPTR_POLL_CNTL);
+		def = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_RB_WPTR_POLL_CNTL);
 		data = (0x0100 << CP_RB_WPTR_POLL_CNTL__POLL_FREQUENCY__SHIFT) |
 			(0x0090 << CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__SHIFT);
 		if (def != data)
-			WREG32_SOC15(GC, xcc_id, regCP_RB_WPTR_POLL_CNTL, data);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_RB_WPTR_POLL_CNTL, data);
 	} else {
-		def = data = RREG32_SOC15(GC, xcc_id, regRLC_CGCG_CGLS_CTRL);
+		def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL);
 		/* reset CGCG/CGLS bits */
 		data &= ~(RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK | RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK);
 		/* disable cgcg and cgls in FSM */
 		if (def != data)
-			WREG32_SOC15(GC, xcc_id, regRLC_CGCG_CGLS_CTRL, data);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL, data);
 	}
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
@@ -2450,12 +2455,12 @@ static void gfx_v9_4_3_get_clockgating_state(void *handle, u64 *flags)
 		*flags = 0;
 
 	/* AMD_CG_SUPPORT_GFX_MGCG */
-	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, regRLC_CGTT_MGCG_OVERRIDE));
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
 		*flags |= AMD_CG_SUPPORT_GFX_MGCG;
 
 	/* AMD_CG_SUPPORT_GFX_CGCG */
-	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, regRLC_CGCG_CGLS_CTRL));
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_CGCG_CGLS_CTRL));
 	if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CGCG;
 
@@ -2464,12 +2469,12 @@ static void gfx_v9_4_3_get_clockgating_state(void *handle, u64 *flags)
 		*flags |= AMD_CG_SUPPORT_GFX_CGLS;
 
 	/* AMD_CG_SUPPORT_GFX_RLC_LS */
-	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, regRLC_MEM_SLP_CNTL));
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_MEM_SLP_CNTL));
 	if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_RLC_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	/* AMD_CG_SUPPORT_GFX_CP_LS */
-	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, regCP_MEM_SLP_CNTL));
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCP_MEM_SLP_CNTL));
 	if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_MGLS;
 }
@@ -2640,7 +2645,7 @@ static void gfx_v9_4_3_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 		amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 		amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
 					 WRITE_DATA_DST_SEL(0) | WR_CONFIRM));
-		amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, regCPC_INT_STATUS));
+		amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCPC_INT_STATUS));
 		amdgpu_ring_write(ring, 0);
 		amdgpu_ring_write(ring, 0x20000000); /* src_id is 178 */
 	}
@@ -2716,16 +2721,16 @@ static void gfx_v9_4_3_set_compute_eop_interrupt_state(struct amdgpu_device *ade
 	if (me == 1) {
 		switch (pipe) {
 		case 0:
-			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, xcc_id, regCP_ME1_PIPE0_INT_CNTL);
+			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE0_INT_CNTL);
 			break;
 		case 1:
-			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, xcc_id, regCP_ME1_PIPE1_INT_CNTL);
+			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE1_INT_CNTL);
 			break;
 		case 2:
-			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, xcc_id, regCP_ME1_PIPE2_INT_CNTL);
+			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE2_INT_CNTL);
 			break;
 		case 3:
-			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, xcc_id, regCP_ME1_PIPE3_INT_CNTL);
+			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE3_INT_CNTL);
 			break;
 		default:
 			DRM_DEBUG("invalid pipe %d\n", pipe);
@@ -2766,7 +2771,7 @@ static int gfx_v9_4_3_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
 		for (i = 0; i < num_xcc; i++)
-			WREG32_FIELD15_PREREG(GC, i, CP_INT_CNTL_RING0,
+			WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), CP_INT_CNTL_RING0,
 				PRIV_REG_INT_ENABLE,
 				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
 		break;
@@ -2789,7 +2794,7 @@ static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
 		for (i = 0; i < num_xcc; i++)
-			WREG32_FIELD15_PREREG(GC, i, CP_INT_CNTL_RING0,
+			WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), CP_INT_CNTL_RING0,
 				PRIV_INSTR_INT_ENABLE,
 				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
 		break;
@@ -2949,16 +2954,16 @@ static void gfx_v9_4_3_emit_wave_limit_cs(struct amdgpu_ring *ring,
 
 	switch (pipe) {
 	case 0:
-		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, regSPI_WCL_PIPE_PERCENT_CS0);
+		wcl_cs_reg = SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regSPI_WCL_PIPE_PERCENT_CS0);
 		break;
 	case 1:
-		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, regSPI_WCL_PIPE_PERCENT_CS1);
+		wcl_cs_reg = SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regSPI_WCL_PIPE_PERCENT_CS1);
 		break;
 	case 2:
-		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, regSPI_WCL_PIPE_PERCENT_CS2);
+		wcl_cs_reg = SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regSPI_WCL_PIPE_PERCENT_CS2);
 		break;
 	case 3:
-		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, regSPI_WCL_PIPE_PERCENT_CS3);
+		wcl_cs_reg = SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regSPI_WCL_PIPE_PERCENT_CS3);
 		break;
 	default:
 		DRM_DEBUG("invalid pipe %d\n", pipe);
@@ -2980,7 +2985,7 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	 */
 	val = enable ? 0x1f : 0x07ffffff;
 	amdgpu_ring_emit_wreg(ring,
-			      SOC15_REG_OFFSET(GC, 0, regSPI_WCL_PIPE_PERCENT_GFX),
+			      SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regSPI_WCL_PIPE_PERCENT_GFX),
 			      val);
 
 	/* Restrict waves for normal/low priority compute queues as well
@@ -3167,15 +3172,15 @@ static void gfx_v9_4_3_set_user_cu_inactive_bitmap(struct amdgpu_device *adev,
 	data = bitmap << GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_CUS__SHIFT;
 	data &= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_CUS_MASK;
 
-	WREG32_SOC15(GC, 0, regGC_USER_SHADER_ARRAY_CONFIG, data);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regGC_USER_SHADER_ARRAY_CONFIG, data);
 }
 
 static u32 gfx_v9_4_3_get_cu_active_bitmap(struct amdgpu_device *adev)
 {
 	u32 data, mask;
 
-	data = RREG32_SOC15(GC, 0, regCC_GC_SHADER_ARRAY_CONFIG);
-	data |= RREG32_SOC15(GC, 0, regGC_USER_SHADER_ARRAY_CONFIG);
+	data = RREG32_SOC15(GC, GET_INST(GC, 0), regCC_GC_SHADER_ARRAY_CONFIG);
+	data |= RREG32_SOC15(GC, GET_INST(GC, 0), regGC_USER_SHADER_ARRAY_CONFIG);
 
 	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS_MASK;
 	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS__SHIFT;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index e35365ab3f1f..c26ac0662c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -35,7 +35,7 @@
 
 static u64 gfxhub_v1_2_get_mc_fb_offset(struct amdgpu_device *adev)
 {
-	return (u64)RREG32_SOC15(GC, 0, regMC_VM_FB_OFFSET) << 24;
+	return (u64)RREG32_SOC15(GC, GET_INST(GC, 0), regMC_VM_FB_OFFSET) << 24;
 }
 
 static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
@@ -48,12 +48,12 @@ static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
-		WREG32_SOC15_OFFSET(GC, i,
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, i),
 				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 				    hub->ctx_addr_distance * vmid,
 				    lower_32_bits(page_table_base));
 
-		WREG32_SOC15_OFFSET(GC, i,
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, i),
 				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
 				    hub->ctx_addr_distance * vmid,
 				    upper_32_bits(page_table_base));
@@ -79,31 +79,31 @@ static void gfxhub_v1_2_init_gart_aperture_regs(struct amdgpu_device *adev)
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		if (adev->gmc.pdb0_bo) {
-			WREG32_SOC15(GC, i,
+			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 				     (u32)(adev->gmc.fb_start >> 12));
-			WREG32_SOC15(GC, i,
+			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
 				     (u32)(adev->gmc.fb_start >> 44));
 
-			WREG32_SOC15(GC, i,
+			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
 				     (u32)(adev->gmc.gart_end >> 12));
-			WREG32_SOC15(GC, i,
+			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
 				     (u32)(adev->gmc.gart_end >> 44));
 		} else {
-			WREG32_SOC15(GC, i,
+			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 				     (u32)(adev->gmc.gart_start >> 12));
-			WREG32_SOC15(GC, i,
+			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
 				     (u32)(adev->gmc.gart_start >> 44));
 
-			WREG32_SOC15(GC, i,
+			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
 				     (u32)(adev->gmc.gart_end >> 12));
-			WREG32_SOC15(GC, i,
+			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
 				     (u32)(adev->gmc.gart_end >> 44));
 		}
@@ -119,13 +119,13 @@ static void gfxhub_v1_2_init_system_aperture_regs(struct amdgpu_device *adev)
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		/* Program the AGP BAR */
-		WREG32_SOC15_RLC(GC, i, regMC_VM_AGP_BASE, 0);
-		WREG32_SOC15_RLC(GC, i, regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-		WREG32_SOC15_RLC(GC, i, regMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
 		if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
 			/* Program the system aperture low logical page number. */
-			WREG32_SOC15_RLC(GC, i, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 				min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
 			if (adev->apu_flags & AMD_APU_IS_RAVEN2)
@@ -136,44 +136,44 @@ static void gfxhub_v1_2_init_system_aperture_regs(struct amdgpu_device *adev)
 				* aperture high address (add 1) to get rid of the VM
 				* fault and hardware hang.
 				*/
-				WREG32_SOC15_RLC(GC, i,
+				WREG32_SOC15_RLC(GC, GET_INST(GC, i),
 						 regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 						 max((adev->gmc.fb_end >> 18) + 0x1,
 						     adev->gmc.agp_end >> 18));
 			else
-				WREG32_SOC15_RLC(GC, i,
+				WREG32_SOC15_RLC(GC, GET_INST(GC, i),
 					regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 					max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 			/* Set default page address. */
 			value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
-			WREG32_SOC15(GC, i, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 				     (u32)(value >> 12));
-			WREG32_SOC15(GC, i, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
 				     (u32)(value >> 44));
 
 			/* Program "protection fault". */
-			WREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+			WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
 				     (u32)(adev->dummy_page_addr >> 12));
-			WREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+			WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 				     (u32)((u64)adev->dummy_page_addr >> 44));
 
-			tmp = RREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_CNTL2);
+			tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2);
 			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
 					    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
-			WREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+			WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 		}
 
 		/* In the case squeezing vram into GART aperture, we don't use
 		 * FB aperture and AGP aperture. Disable them.
 		 */
 		if (adev->gmc.pdb0_bo) {
-			WREG32_SOC15(GC, i, regMC_VM_FB_LOCATION_TOP, 0);
-			WREG32_SOC15(GC, i, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
-			WREG32_SOC15(GC, i, regMC_VM_AGP_TOP, 0);
-			WREG32_SOC15(GC, i, regMC_VM_AGP_BOT, 0xFFFFFF);
-			WREG32_SOC15(GC, i, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-			WREG32_SOC15(GC, i, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
+			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
+			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_BOT, 0xFFFFFF);
+			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 		}
 	}
 }
@@ -186,7 +186,7 @@ static void gfxhub_v1_2_init_tlb_regs(struct amdgpu_device *adev)
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		/* Setup TLB control */
-		tmp = RREG32_SOC15(GC, i, regMC_VM_MX_L1_TLB_CNTL);
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_MX_L1_TLB_CNTL);
 
 		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 				    ENABLE_L1_TLB, 1);
@@ -200,7 +200,7 @@ static void gfxhub_v1_2_init_tlb_regs(struct amdgpu_device *adev)
 				    MTYPE, MTYPE_UC);/* XXX for emulation. */
 		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
 
-		WREG32_SOC15_RLC(GC, i, regMC_VM_MX_L1_TLB_CNTL, tmp);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_MX_L1_TLB_CNTL, tmp);
 	}
 }
 
@@ -212,7 +212,7 @@ static void gfxhub_v1_2_init_cache_regs(struct amdgpu_device *adev)
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		/* Setup L2 cache */
-		tmp = RREG32_SOC15(GC, i, regVM_L2_CNTL);
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 1);
 		/* XXX for emulation, Refer to closed source code.*/
@@ -221,12 +221,12 @@ static void gfxhub_v1_2_init_cache_regs(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
-		WREG32_SOC15_RLC(GC, i, regVM_L2_CNTL, tmp);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regVM_L2_CNTL, tmp);
 
-		tmp = RREG32_SOC15(GC, i, regVM_L2_CNTL2);
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_CNTL2);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
-		WREG32_SOC15_RLC(GC, i, regVM_L2_CNTL2, tmp);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regVM_L2_CNTL2, tmp);
 
 		tmp = regVM_L2_CNTL3_DEFAULT;
 		if (adev->gmc.translate_further) {
@@ -238,7 +238,7 @@ static void gfxhub_v1_2_init_cache_regs(struct amdgpu_device *adev)
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
 					    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
 		}
-		WREG32_SOC15_RLC(GC, i, regVM_L2_CNTL3, tmp);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regVM_L2_CNTL3, tmp);
 
 		tmp = regVM_L2_CNTL4_DEFAULT;
 		if (adev->gmc.xgmi.connected_to_cpu) {
@@ -248,7 +248,7 @@ static void gfxhub_v1_2_init_cache_regs(struct amdgpu_device *adev)
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
 		}
-		WREG32_SOC15_RLC(GC, i, regVM_L2_CNTL4, tmp);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regVM_L2_CNTL4, tmp);
 	}
 }
 
@@ -259,7 +259,7 @@ static void gfxhub_v1_2_enable_system_domain(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		tmp = RREG32_SOC15(GC, i, regVM_CONTEXT0_CNTL);
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_CONTEXT0_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
 				adev->gmc.vmid0_page_table_depth);
@@ -267,7 +267,7 @@ static void gfxhub_v1_2_enable_system_domain(struct amdgpu_device *adev)
 				adev->gmc.vmid0_page_table_block_size);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
-		WREG32_SOC15(GC, i, regVM_CONTEXT0_CNTL, tmp);
+		WREG32_SOC15(GC, GET_INST(GC, i), regVM_CONTEXT0_CNTL, tmp);
 	}
 }
 
@@ -277,23 +277,23 @@ static void gfxhub_v1_2_disable_identity_aperture(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		WREG32_SOC15(GC, i,
+		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 			     0XFFFFFFFF);
-		WREG32_SOC15(GC, i,
+		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
 			     0x0000000F);
 
-		WREG32_SOC15(GC, i,
+		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
 			     0);
-		WREG32_SOC15(GC, i,
+		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
 			     0);
 
-		WREG32_SOC15(GC, i,
+		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
-		WREG32_SOC15(GC, i,
+		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
 	}
 }
@@ -316,7 +316,7 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 	for (j = 0; j < num_xcc; j++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		for (i = 0; i <= 14; i++) {
-			tmp = RREG32_SOC15_OFFSET(GC, j, regVM_CONTEXT1_CNTL, i);
+			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL, i);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 					    num_level);
@@ -348,19 +348,19 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 					    !adev->gmc.noretry ||
 					    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2) ||
 					    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3));
-			WREG32_SOC15_OFFSET(GC, j, regVM_CONTEXT1_CNTL,
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL,
 					    i * hub->ctx_distance, tmp);
-			WREG32_SOC15_OFFSET(GC, j,
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
 					    regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
 					    i * hub->ctx_addr_distance, 0);
-			WREG32_SOC15_OFFSET(GC, j,
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
 					    regVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
 					    i * hub->ctx_addr_distance, 0);
-			WREG32_SOC15_OFFSET(GC, j,
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
 					    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
 					    i * hub->ctx_addr_distance,
 					    lower_32_bits(adev->vm_manager.max_pfn - 1));
-			WREG32_SOC15_OFFSET(GC, j,
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
 					    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 					    i * hub->ctx_addr_distance,
 					    upper_32_bits(adev->vm_manager.max_pfn - 1));
@@ -378,9 +378,9 @@ static void gfxhub_v1_2_program_invalidation(struct amdgpu_device *adev)
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 
 		for (i = 0 ; i < 18; ++i) {
-			WREG32_SOC15_OFFSET(GC, j, regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
 					    i * hub->eng_addr_distance, 0xffffffff);
-			WREG32_SOC15_OFFSET(GC, j, regVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
 					    i * hub->eng_addr_distance, 0x1f);
 		}
 	}
@@ -398,9 +398,9 @@ static int gfxhub_v1_2_gart_enable(struct amdgpu_device *adev)
 		 * VF copy registers so vbios post doesn't program them, for
 		 * SRIOV driver need to program them
 		 */
-			WREG32_SOC15_RLC(GC, i, regMC_VM_FB_LOCATION_BASE,
+			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE,
 				     adev->gmc.vram_start >> 24);
-			WREG32_SOC15_RLC(GC, i, regMC_VM_FB_LOCATION_TOP,
+			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP,
 				     adev->gmc.vram_end >> 24);
 		}
 	}
@@ -432,23 +432,23 @@ static void gfxhub_v1_2_gart_disable(struct amdgpu_device *adev)
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		/* Disable all tables */
 		for (i = 0; i < 16; i++)
-			WREG32_SOC15_OFFSET(GC, j, regVM_CONTEXT0_CNTL,
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT0_CNTL,
 					    i * hub->ctx_distance, 0);
 
 		/* Setup TLB control */
-		tmp = RREG32_SOC15(GC, j, regMC_VM_MX_L1_TLB_CNTL);
+		tmp = RREG32_SOC15(GC, GET_INST(GC, j), regMC_VM_MX_L1_TLB_CNTL);
 		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
 		tmp = REG_SET_FIELD(tmp,
 					MC_VM_MX_L1_TLB_CNTL,
 					ENABLE_ADVANCED_DRIVER_MODEL,
 					0);
-		WREG32_SOC15_RLC(GC, j, regMC_VM_MX_L1_TLB_CNTL, tmp);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, j), regMC_VM_MX_L1_TLB_CNTL, tmp);
 
 		/* Setup L2 cache */
-		tmp = RREG32_SOC15(GC, j, regVM_L2_CNTL);
+		tmp = RREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
-		WREG32_SOC15(GC, j, regVM_L2_CNTL, tmp);
-		WREG32_SOC15(GC, j, regVM_L2_CNTL3, 0);
+		WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL, tmp);
+		WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL3, 0);
 	}
 }
 
@@ -466,7 +466,7 @@ static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		tmp = RREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_CNTL);
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
 				RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
@@ -497,7 +497,7 @@ static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
 			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
 					CRASH_ON_RETRY_FAULT, 1);
 		}
-		WREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
+		WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL, tmp);
 	}
 }
 
@@ -511,24 +511,24 @@ static void gfxhub_v1_2_init(struct amdgpu_device *adev)
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 
 		hub->ctx0_ptb_addr_lo32 =
-			SOC15_REG_OFFSET(GC, i,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
 				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
 		hub->ctx0_ptb_addr_hi32 =
-			SOC15_REG_OFFSET(GC, i,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
 				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
 		hub->vm_inv_eng0_sem =
-			SOC15_REG_OFFSET(GC, i, regVM_INVALIDATE_ENG0_SEM);
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_SEM);
 		hub->vm_inv_eng0_req =
-			SOC15_REG_OFFSET(GC, i, regVM_INVALIDATE_ENG0_REQ);
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_REQ);
 		hub->vm_inv_eng0_ack =
-			SOC15_REG_OFFSET(GC, i, regVM_INVALIDATE_ENG0_ACK);
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_ACK);
 		hub->vm_context0_cntl =
-			SOC15_REG_OFFSET(GC, i, regVM_CONTEXT0_CNTL);
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_CONTEXT0_CNTL);
 		hub->vm_l2_pro_fault_status =
-			SOC15_REG_OFFSET(GC, i,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
 				regVM_L2_PROTECTION_FAULT_STATUS);
 		hub->vm_l2_pro_fault_cntl =
-			SOC15_REG_OFFSET(GC, i, regVM_L2_PROTECTION_FAULT_CNTL);
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL);
 
 		hub->ctx_distance = regVM_CONTEXT1_CNTL -
 				regVM_CONTEXT0_CNTL;
@@ -551,9 +551,9 @@ static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
 	u32 max_region;
 	u64 seg_size;
 
-	xgmi_lfb_cntl = RREG32_SOC15(GC, 0, regMC_VM_XGMI_LFB_CNTL);
+	xgmi_lfb_cntl = RREG32_SOC15(GC, GET_INST(GC, 0), regMC_VM_XGMI_LFB_CNTL);
 	seg_size = REG_GET_FIELD(
-		RREG32_SOC15(GC, 0, regMC_VM_XGMI_LFB_SIZE),
+		RREG32_SOC15(GC, GET_INST(GC, 0), regMC_VM_XGMI_LFB_SIZE),
 		MC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
 	max_region =
 		REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL, PF_MAX_REGION);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index eb35096756b8..39e4406da4ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -24,6 +24,9 @@
 #ifndef __SOC15_COMMON_H__
 #define __SOC15_COMMON_H__
 
+/* GET_INST returns the physical instance corresponding to a logical instance */
+#define GET_INST(ip, inst) (adev->ip_map.logical_to_dev_inst? adev->ip_map.logical_to_dev_inst(adev, ip##_HWIP, inst): inst)
+
 /* Register Access Macros */
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 #define SOC15_REG_OFFSET1(ip, inst, reg, offset) \
-- 
2.39.2


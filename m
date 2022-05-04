Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B9DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 13:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E015010EA72;
	Wed,  4 May 2022 13:23:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D16A10EA72
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 13:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhmOopvnPUbZR4Mf1fSr43BO1do4Pl1PzPlqAHr/2aBHlGtJ/CXnOQSL2xW8IuMefKjYP/HybLCtiKqeXEMS/FSlLwdOxCeI9bzqFITr826UoOrQlIGF/8IE0nTmDaUhb35cKKNEUJnSJ/nogoqdc5KdHdaxWCkwBurTvFWHjQ/NOtgawblVoiWRKbwD+mxNyxfEWPY7ErFnXIFHbJR3/e2E1vzHxV/54s1VY/XHzl7ftl2tx752ohQELz0yhM45wGMGOcKNJ6FnKYemGi1lTuLqlxmQMDGZqEzd2qjC9nZW1PD+y7w+x9Ohv5b3dmZQs3KzXzwgrmiye2oziQ1KGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/TP1YFbyamxlmXpsrRG/gxphyHTKgKk/ZHpk5cNtk8=;
 b=NSAdZ7nJV56xtGDeQbORydgqbVWHGeLCyrBwnEtP7KpinysbUwKz6H5PdyS5HG0rE1ewj/+74cx0CkMneWHo1Dv57ufm4iVXHeoj2Q5UGSB21hkZuc8HgyqfzXAOq6I6huxjQPwm1Znf+niPQYsnaW7ISK6Pc9WBST6GGRjx60WTgv2yOYrVh7QuWGoCn3GogSbcVrrKDrDZBAYHv631T83N63vxgWUbFIukErfd4/2AEO1Flex8SwX0Fpc2kWIWW3CKcYtpBZvayxg0zGQJ6nHjDAlmCCGPQ4uz3riEeKu0cMxHEsOsXPVtiKCi7SBFDuEJ9dqP3omQqgIvX04IzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/TP1YFbyamxlmXpsrRG/gxphyHTKgKk/ZHpk5cNtk8=;
 b=JNgFFJVLGxCG0zj4kZWq+4dPY89Npn6D0bSwRDnuHULr2OSpCmmWsVN6aPgc5e/rI2VMPWzgYKwu8wcGlQP1SZutZf+FCRMOoNAIlNuRo5Sby+Ffgg68wjINb7tiL+eWEZZVNfuOwg1r/JNtXrIQnDZ5g96NyXe/BwkI6CML/Kc=
Received: from MW4PR04CA0176.namprd04.prod.outlook.com (2603:10b6:303:85::31)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 13:23:44 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::10) by MW4PR04CA0176.outlook.office365.com
 (2603:10b6:303:85::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Wed, 4 May 2022 13:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 13:23:43 +0000
Received: from jz-tester.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 08:23:41 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/vcn3: replace ip based software ring decode
 with common vcn software ring decode
Date: Wed, 4 May 2022 09:23:25 -0400
Message-ID: <20220504132326.629117-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504132326.629117-1-James.Zhu@amd.com>
References: <20220504132326.629117-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eec33432-cad6-4d9c-fb1b-08da2dd14ff7
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5456:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5456E34031B8825DC9EC4073E4C39@SJ0PR12MB5456.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIclBlQEScXiD2oEUGwGshK86kQAcCPxpdZs2zkPXzSrOjTrJvW0xjlrcPTC72sRGM4amhOHPGGQKoVQU2kNHrXF+EljEL/KirIohu8ufN/HQit9zD5dLB0gB6KPC69m0pgyFXWFGN/S2ORiympGyhNv+xOmm9NGzlpSToBnu/L3bobWrJTTBOvPTF2gOqHVF8oyhYz7fi4By/xvta9/a8JoSMBe1ieNPJSFIkyg94lUdF5D6uUcaSiGHbW0S/GGAcq9OTeRj8MoexqCB1cV1JGKneI8/354qPMl8uJo5oI0cdmGDbnKLUG65S0W2gOxSZmiLTqP2CZgtXm7RK0EZFv9O0xDkEBW9sAE3CFlsRMlTGrJ1G1U2Vw/gkKpPIhmFW2aCXj/sGeN7ArlJxt0ngqtooq0zc86PhP1Y6lc0Ztktz9mPDJ+nxnYPEpJWmdeBRSI6iT+Gs7bA1JIOtI21YIRfU7TBGL73VFmZq+nKm4nQbWITWC/MuLyqEExQmiq53zi7/bYQQFcyO2ViWJvazlBjoiDEMLw7c8bzhGlt2IEfW6AhXTprKMJ78qbAooCT2TSRtCGpPwDDi0kwXNVxuu6dLhQP44b5XvN85t+/ezdQfvxtPK0A8TXRcsq9WtpyHIj7enGt5RjaQiC+vHugVvmxpHKKeEcaBVYsArCHGH+x+jrNqhtNY2SOlh9qlBOTEZuRZeXcgCo9L31LyjvBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(426003)(2616005)(336012)(6916009)(70586007)(70206006)(81166007)(8936002)(86362001)(16526019)(186003)(7696005)(2906002)(36860700001)(316002)(8676002)(1076003)(508600001)(82310400005)(40460700003)(26005)(6666004)(83380400001)(36756003)(5660300002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:23:43.7538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec33432-cad6-4d9c-fb1b-08da2dd14ff7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
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

Replace ip based software ring decode with common vcn software ring decode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 82 ++++-----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h | 12 ----
 2 files changed, 11 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c7280ca5e836..f761c569fcc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -30,6 +30,7 @@
 #include "soc15d.h"
 #include "vcn_v2_0.h"
 #include "mmsch_v3_0.h"
+#include "vcn_sw_ring.h"
 
 #include "vcn/vcn_3_0_0_offset.h"
 #include "vcn/vcn_3_0_0_sh_mask.h"
@@ -1731,67 +1732,6 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
-      u64 seq, uint32_t flags)
-{
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_FENCE);
-	amdgpu_ring_write(ring, addr);
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, seq);
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_TRAP);
-}
-
-void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
-{
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
-}
-
-void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
-        struct amdgpu_ib *ib, uint32_t flags)
-{
-	uint32_t vmid = AMDGPU_JOB_GET_VMID(job);
-
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_IB);
-	amdgpu_ring_write(ring, vmid);
-	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, ib->length_dw);
-}
-
-void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-        uint32_t val, uint32_t mask)
-{
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
-	amdgpu_ring_write(ring, reg << 2);
-	amdgpu_ring_write(ring, mask);
-	amdgpu_ring_write(ring, val);
-}
-
-void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
-        uint32_t vmid, uint64_t pd_addr)
-{
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
-	uint32_t data0, data1, mask;
-
-	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
-
-	/* wait for register write */
-	data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
-	data1 = lower_32_bits(pd_addr);
-	mask = 0xffffffff;
-	vcn_v3_0_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
-}
-
-void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
-      uint32_t val)
-{
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WRITE);
-	amdgpu_ring_write(ring,	reg << 2);
-	amdgpu_ring_write(ring, val);
-}
-
 static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0x3f,
@@ -1804,22 +1744,22 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-		4 + /* vcn_v3_0_dec_sw_ring_emit_vm_flush */
-		5 + 5 + /* vcn_v3_0_dec_sw_ring_emit_fdec_swe x2 vm fdec_swe */
-		1, /* vcn_v3_0_dec_sw_ring_insert_end */
-	.emit_ib_size = 5, /* vcn_v3_0_dec_sw_ring_emit_ib */
-	.emit_ib = vcn_v3_0_dec_sw_ring_emit_ib,
-	.emit_fence = vcn_v3_0_dec_sw_ring_emit_fence,
-	.emit_vm_flush = vcn_v3_0_dec_sw_ring_emit_vm_flush,
+		4 + /* vcn_dec_sw_ring_emit_vm_flush */
+		5 + 5 + /* vcn_dec_sw_ring_emit_fdec_swe x2 vm fdec_swe */
+		1, /* vcn_dec_sw_ring_insert_end */
+	.emit_ib_size = 5, /* vcn_dec_sw_ring_emit_ib */
+	.emit_ib = vcn_dec_sw_ring_emit_ib,
+	.emit_fence = vcn_dec_sw_ring_emit_fence,
+	.emit_vm_flush = vcn_dec_sw_ring_emit_vm_flush,
 	.test_ring = amdgpu_vcn_dec_sw_ring_test_ring,
 	.test_ib = NULL,//amdgpu_vcn_dec_sw_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
-	.insert_end = vcn_v3_0_dec_sw_ring_insert_end,
+	.insert_end = vcn_dec_sw_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vcn_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_v3_0_dec_sw_ring_emit_wreg,
-	.emit_reg_wait = vcn_v3_0_dec_sw_ring_emit_reg_wait,
+	.emit_wreg = vcn_dec_sw_ring_emit_wreg,
+	.emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
index 7a6655d3b79d..31683582d778 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
@@ -26,16 +26,4 @@
 
 extern const struct amdgpu_ip_block_version vcn_v3_0_ip_block;
 
-void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
-      u64 seq, uint32_t flags);
-void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring);
-void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
-      struct amdgpu_ib *ib, uint32_t flags);
-void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-      uint32_t val, uint32_t mask);
-void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
-      uint32_t vmid, uint64_t pd_addr);
-void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
-      uint32_t val);
-
 #endif /* __VCN_V3_0_H__ */
-- 
2.25.1


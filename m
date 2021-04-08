Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AF1C43460
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D6361181
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D6361181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB746EA6E;
	Thu,  8 Apr 2021 10:22:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6466EA6C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 10:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKV23MHduTn3ygnnKvN8pEC+m8Jj/oNt1Xq3RIPDJO3ZmEcULIPF+DoqF+13CKeh1wNCs6Ye6CDsEhFJcPItcRDSY0xSTQQ9m0/9LakQnOivkne3kOdG2niUG2ACPpRsJF3cD1tpuGj2cJJ6eCp9QP0z1hZorvdGZ6qblgMSfP0lkHUY7GCcaqE7WuK3XsfbZLpaVV71yxYvEQglGqNuY+cl+L+gMI46CCZi+XD4dbKzH+URQ88t4a0OMkadHs2oUi//5PIyNCTqJe2vg84DxhJD5Ay+PEI/tAIWEO8G4E8oKvN+uBxVYTeBCxIKw92ifz7VjoocQIlmuaSD7uzSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzHqyqWkIqte1lWxuJNAScktqs0a0TTpFm3LTvkEfwQ=;
 b=ShqqBt+v7jo2Mo2FvG2e6D9HjWQ3eCJU/7L5Se/viBRBO2GbnPazVDHFdipAejZ+qcpMvEoxMQ+Yenc2TZDJlm+W/YuoADH0Jv9P+aRbADTZZiTVJY5qpPDSdY7XggbQ7fWB+QzN/lvX3Sn1fsVfEZwZQ8jn8+oksQH1T8I/VDUxJG5MiS/y0HNT9gmaEPLgK7t2Mv7Jw+AI+doRia5DEbqSd7jtIYu34q+lrA77mPwEzU1vbBkFpUbZaB8Y7U9eoa6RQ4n/DQ5fpgauSzCQ8olSAGppYPhR+nQ8SXdjCJIEzE9fW6uj+sxezHD77C0QwF100aYLcq3y06uc90OehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzHqyqWkIqte1lWxuJNAScktqs0a0TTpFm3LTvkEfwQ=;
 b=mwEzX4oWwxw5j4RbLDV2eoXArsu3sxkaOIf3tx0y5Yd3PaoJDBNHLgYlbjFNX6Svtr0XkpoGji2vOJuNtvdPTatYJ5R8IpfC3/yL6zjIczQg5QG3Zv65yMUB9b1k5bhO/spv3DABHiMVQuvZZzoqtfltrS0rpbOEgNrKbeQnEjc=
Received: from MW4PR03CA0305.namprd03.prod.outlook.com (2603:10b6:303:dd::10)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 10:22:18 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::9c) by MW4PR03CA0305.outlook.office365.com
 (2603:10b6:303:dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 10:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 10:22:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 05:22:17 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 05:22:16 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdgpu: Change GC(GFX/GFXHUB) register access from
 MMIO to RLCG
Date: Thu, 8 Apr 2021 18:22:01 +0800
Message-ID: <20210408102205.911-4-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408102205.911-1-PengJu.Zhou@amd.com>
References: <20210408102205.911-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf9d965d-0b21-4cb7-2312-08d8fa78303b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4150:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4150F3DF0E767E3EB3A4EB9AF8749@CH2PR12MB4150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEtw/aXYxN8rSy7vHe4Wt7wvZxxNB9tBfsgu2m/SkGBYA6ld+vO3Z9O4UMG9NHQUlexz2QS7AqAjr0R3rsRM7Bxet/Dc05QAjj+wEzN21Z0qvtUHyzoSpNEydBb1BtI+8vlHyYgil+HQzQvl/D1GMrw5RJ3L0gu0B5GPQzAAANbbSicRCvHovb58NLcRJTNOSjObneKX3TY1mQnUwXmUitznZ2WK/Rt33/lazYw2GzDKh/Z8OIFwLx7Cm+8TT38jciohRnapYqGjYFDrhIhZva/LywJzAvI0YemrFHbTmhCRplx3Z1fFkOJ0t4Ai5fktXYJAhpc0Gogldtd8s5aqpl8NNvJUMe82SkdoXzDxOHk6DzTm390plV/knd3fRBNPmVRgLsMHb/m1Lpin8UyG6aBU2obv50zSLDGY1YhT9Nadinh39a6ZMsFiKi2B/A4FbcuoE6/LQKPKH/fMd9ylAYasCsG9sXRwQdjG9TyGuDJlvv+0PCM4ZqfNWsntPj3/uMhXQCMW1hbLILz1v12XiRWe1ZMphjeI0moFyuLcF9DhdCv8glq53BW3D4W2GBjFTmOdeC0OXL370qNUOUAHSoWdwZS2nGxoxMikBDHkvCUezcvi8UEIwOEcgCiFcFks3wrcVMucK2I28Txz+Mz7ihau/TBC1e3A7KXRvzEJ8vQVgVwDuwZ7mOtT6FMFldO8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(7696005)(86362001)(81166007)(6666004)(70206006)(36756003)(8676002)(4326008)(1076003)(5660300002)(6916009)(186003)(26005)(2906002)(336012)(426003)(82310400003)(356005)(478600001)(8936002)(316002)(47076005)(70586007)(36860700001)(83380400001)(2616005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 10:22:18.3497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9d965d-0b21-4cb7-2312-08d8fa78303b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Change GC register access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 38 ++++++++++++------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 376c92b1f938..8a54d5f27671 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6811,7 +6811,7 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 
 	/* disable the queue if it's active */
 	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
-		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
 		for (j = 0; j < adev->usec_timeout; j++) {
 			if (!(RREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE) & 1))
 				break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 2aecc6a243e8..30ff10953831 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -104,7 +104,7 @@ gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 
 static u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
 {
-	u64 base = RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
+	u64 base = RREG32_SOC15_RLC(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
 
 	base &= GCMC_VM_FB_LOCATION_BASE__FB_BASE_MASK;
 	base <<= 24;
@@ -114,7 +114,7 @@ static u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
 
 static u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)
 {
-	return (u64)RREG32_SOC15(GC, 0, mmGCMC_VM_FB_OFFSET) << 24;
+	return (u64)RREG32_SOC15_RLC(GC, 0, mmGCMC_VM_FB_OFFSET) << 24;
 }
 
 static void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
@@ -122,11 +122,11 @@ static void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vm
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 
-	WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+	WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
 			    lower_32_bits(page_table_base));
 
-	WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+	WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
 			    hub->ctx_addr_distance * vmid,
 			    upper_32_bits(page_table_base));
 }
@@ -137,14 +137,14 @@ static void gfxhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 
 	gfxhub_v2_0_setup_vm_pt_regs(adev, 0, pt_base);
 
-	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 		     (u32)(adev->gmc.gart_start >> 12));
-	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
 		     (u32)(adev->gmc.gart_start >> 44));
 
-	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
 		     (u32)(adev->gmc.gart_end >> 12));
-	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
 		     (u32)(adev->gmc.gart_end >> 44));
 }
 
@@ -189,7 +189,7 @@ static void gfxhub_v2_0_init_tlb_regs(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	/* Setup TLB control */
-	tmp = RREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
 
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 1);
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, SYSTEM_ACCESS_MODE, 3);
@@ -201,7 +201,7 @@ static void gfxhub_v2_0_init_tlb_regs(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC); /* UC, uncached */
 
-	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
 }
 
 static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
@@ -257,12 +257,12 @@ static void gfxhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
 
-	tmp = RREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
 	tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
 	tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL,
 			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_CNTL, tmp);
 }
 
 static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
@@ -289,7 +289,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
@@ -314,7 +314,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !adev->gmc.noretry);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
 				    i * hub->ctx_addr_distance, 0);
@@ -335,9 +335,9 @@ static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 	unsigned i;
 
 	for (i = 0 ; i < 18; ++i) {
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
 				    i * hub->eng_addr_distance, 0xffffffff);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
 				    i * hub->eng_addr_distance, 0x1f);
 	}
 }
@@ -366,15 +366,15 @@ static void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev)
 
 	/* Disable all tables */
 	for (i = 0; i < 16; i++)
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_CNTL,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT0_CNTL,
 				    i * hub->ctx_distance, 0);
 
 	/* Setup TLB control */
-	tmp = RREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
 			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/* Setup L2 cache */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

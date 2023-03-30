Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FB7C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1F910E54A;
	Thu, 30 Mar 2023 19:32:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5771810E54A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/qL8zauqrhBuDXW+QBShLVfzvYA9onYGGVNFVpcLLv9PM6g3vYA0i8EfaCa4jP6gGMH6/+kJdDiKJlLm6HnXLfHx0oTEtujXoQ+i260urguA+kYJwQaS2gK0v7wm25jfuE+Fvnytk3tIJ3y6sURvxK+Lko2zkMlZmyQpt8fL0OLgB8b9M5geupWTYDbrFGDoM+C0bLcO8fsBV3NIIunJA+HRcKaK9QS2kjSYKzNWr7W4Q1k9s7lMKXLyejosU5TarX/PPhU6KpP+Jr5IOKAMk9WCL51NC2upD/w7Af5fqH2tzSaAxEq4C/etlyJ+mZfx/f0NIkbNLVcI38a+GLZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tJ0k9xmej4wLZn2O43KLEUJDfHEA6nHhkvcOQrwwBU=;
 b=HEdMMR8o4VopBBqhhOlaS3mx49veh0EtIvuV5Cdzekew7mMv+4NGMj85gbql+u++Ol/McnPqPt/bgUiWihreFnyvhLrn2OmuC53qa3DqAeD8jlj0iZy2V/MecJKWFbg3J8yyzojesO+j/fa8pBuugXjoH+FklEhId2/ziAxpd+TCg4bhTI+HmNLE844pZVhU7H4xfxGT/C6CcqztW61k7Jw8mbGmtw1JcYTEYaTZAAGCJxwUVhJ0WkoFySoQWeED2e8XEFfNfj48dcnopVrGMIAIxjF67VI45jiFthlric7micQAoYqwB+Qx0no39hQ0Ch7dL0P+xGiD5ezt9n+htA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tJ0k9xmej4wLZn2O43KLEUJDfHEA6nHhkvcOQrwwBU=;
 b=vbyqINrHKD05oO5qvNJcQjDXw1UwyVtKJ8cjMDqkziWTIDC7iaLo3GTnncpCpAtHdCcVs4QAPuSZ7ppHMzPG9Lf/MaeM+fVQAv0vk1SLVKNFPxHYwecgVHUQOlSTSJi9Jp2n76fScOPL+Rg30T2Mbk5QoysdyLq2Vjj62yuUdB8=
Received: from BN9PR03CA0086.namprd03.prod.outlook.com (2603:10b6:408:fc::31)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:32:20 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::ab) by BN9PR03CA0086.outlook.office365.com
 (2603:10b6:408:fc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:32:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:32:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/10] drm/amdgpu: Add xcc specific functions for gfxhub
Date: Thu, 30 Mar 2023 15:31:49 -0400
Message-ID: <20230330193158.1134802-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: aafbc7d2-09b3-4ebc-d2f3-08db31557aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4KGxu9KLNlDkhgKUiNjWFX6lmf46mX6HkqjOj+nGTPxM6KNuDGJ6jG+g6arFvLF3vQo88L1TTnAB59Y+GB6agMrjiZ5QG2X9ZCoKBFBBsBr3rB3nqItXHNm5qohvX3SluYwUpbt9jl7OHXRcrxNE88u6tbL/FN3Rw/C4b+Iq5/vXtGVhd/B3NGJv/l3+q6krtY3G8ywH0gjLgUzz5pNHubGFzy4BYRM9tlnSx9CrBH/Pg0L5y1sI4dzmFEpzXbwUwc68MPSZ2stA4VAr6gRsYtYmBeSjRGdubLj4LCh+YX7UagtwQR8y07VNNJlmiXtArDpgPP0z9jnUXqwm6EZAvKuQb+NGvtD8WG7LJ2pojbfidMmekXfhAhuSIFG2ll9olatL0UBHmp1hGn1w4bIJ2FrYrIQs1Hs+0kab864tyMhaWffh7jJlHG2hdpBInIZxKe3dxXI+bkmrnmwpTxATcJ+rNKoNsw1sMma48cOYcArF9Gy4c1ia1PVKrytaKwYFcFAkRvTuEdF3QOiSYY1PX/AwHnbdsKIGEDnYNOU748pZTuygQiOTbB/jVAYNEECdLY6okfzpdPZEDOX/3UAhCahKsIrpfPKNEm/4LbWtYqVOyp62VnK/5hpt282xDUyQnGZs3WwyAT0fWMbD7s9q11YcA1kjUoVAYjG+w4XSgRAmnl33n3TYF1RDumqjRNemKM7M5M3lClNnndOgy1myxliy5Hh3FxyknY3JS9ROx4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(6916009)(478600001)(2616005)(83380400001)(426003)(30864003)(336012)(40460700003)(8936002)(5660300002)(6666004)(54906003)(41300700001)(36756003)(70206006)(8676002)(4326008)(316002)(86362001)(70586007)(7696005)(81166007)(82310400005)(1076003)(356005)(40480700001)(47076005)(26005)(186003)(82740400003)(36860700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:32:20.2282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aafbc7d2-09b3-4ebc-d2f3-08db31557aa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

GFXHUB 1.2 supports multiple XCC instances. Add XCC specific functions
to handle XCC instances separately.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   4 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 202 ++++++++++++++---------
 2 files changed, 128 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0d5a327b0d2f..4a9817d2acaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1284,6 +1284,10 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
+#define for_each_inst(i, inst_mask)                                            \
+	for (i = ffs(inst_mask) - 1; inst_mask;                                \
+	     inst_mask &= ~(1U << i), i = ffs(inst_mask) - 1)
+
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 
 /* Common functions */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index c26ac0662c7e..b9316bfb7263 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -38,15 +38,15 @@ static u64 gfxhub_v1_2_get_mc_fb_offset(struct amdgpu_device *adev)
 	return (u64)RREG32_SOC15(GC, GET_INST(GC, 0), regMC_VM_FB_OFFSET) << 24;
 }
 
-static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
-					 uint32_t vmid,
-					 uint64_t page_table_base)
+static void gfxhub_v1_2_xcc_setup_vm_pt_regs(struct amdgpu_device *adev,
+					     uint32_t vmid,
+					     uint64_t page_table_base,
+					     uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub;
-	int i, num_xcc;
+	int i;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
+	for_each_inst(i, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, i),
 				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
@@ -57,27 +57,36 @@ static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
 				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
 				    hub->ctx_addr_distance * vmid,
 				    upper_32_bits(page_table_base));
-
 	}
 }
 
-static void gfxhub_v1_2_init_gart_aperture_regs(struct amdgpu_device *adev)
+static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
+					 uint32_t vmid,
+					 uint64_t page_table_base)
+{
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v1_2_xcc_setup_vm_pt_regs(adev, vmid, page_table_base, xcc_mask);
+}
+
+static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
+						    uint32_t xcc_mask)
 {
 	uint64_t pt_base;
-	int i, num_xcc;
+	int i;
 
 	if (adev->gmc.pdb0_bo)
 		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
 	else
 		pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	gfxhub_v1_2_setup_vm_pt_regs(adev, 0, pt_base);
+	gfxhub_v1_2_xcc_setup_vm_pt_regs(adev, 0, pt_base, xcc_mask);
 
 	/* If use GART for FB translation, vmid0 page table covers both
 	 * vram and system memory (gart)
 	 */
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
+	for_each_inst(i, xcc_mask) {
 		if (adev->gmc.pdb0_bo) {
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
@@ -110,14 +119,15 @@ static void gfxhub_v1_2_init_gart_aperture_regs(struct amdgpu_device *adev)
 	}
 }
 
-static void gfxhub_v1_2_init_system_aperture_regs(struct amdgpu_device *adev)
+static void
+gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
+					  uint32_t xcc_mask)
 {
 	uint64_t value;
 	uint32_t tmp;
-	int i, num_xcc;
+	int i;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
+	for_each_inst(i, xcc_mask) {
 		/* Program the AGP BAR */
 		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_AGP_BASE, 0);
 		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
@@ -178,13 +188,13 @@ static void gfxhub_v1_2_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 }
 
-static void gfxhub_v1_2_init_tlb_regs(struct amdgpu_device *adev)
+static void gfxhub_v1_2_xcc_init_tlb_regs(struct amdgpu_device *adev,
+					  uint32_t xcc_mask)
 {
 	uint32_t tmp;
-	int i, num_xcc;
+	int i;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
+	for_each_inst(i, xcc_mask) {
 		/* Setup TLB control */
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_MX_L1_TLB_CNTL);
 
@@ -204,13 +214,13 @@ static void gfxhub_v1_2_init_tlb_regs(struct amdgpu_device *adev)
 	}
 }
 
-static void gfxhub_v1_2_init_cache_regs(struct amdgpu_device *adev)
+static void gfxhub_v1_2_xcc_init_cache_regs(struct amdgpu_device *adev,
+					    uint32_t xcc_mask)
 {
 	uint32_t tmp;
-	int i, num_xcc;
+	int i;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
+	for_each_inst(i, xcc_mask) {
 		/* Setup L2 cache */
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
@@ -252,13 +262,13 @@ static void gfxhub_v1_2_init_cache_regs(struct amdgpu_device *adev)
 	}
 }
 
-static void gfxhub_v1_2_enable_system_domain(struct amdgpu_device *adev)
+static void gfxhub_v1_2_xcc_enable_system_domain(struct amdgpu_device *adev,
+						 uint32_t xcc_mask)
 {
 	uint32_t tmp;
-	int i, num_xcc;
+	int i;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
+	for_each_inst(i, xcc_mask) {
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_CONTEXT0_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
@@ -271,12 +281,13 @@ static void gfxhub_v1_2_enable_system_domain(struct amdgpu_device *adev)
 	}
 }
 
-static void gfxhub_v1_2_disable_identity_aperture(struct amdgpu_device *adev)
+static void
+gfxhub_v1_2_xcc_disable_identity_aperture(struct amdgpu_device *adev,
+					  uint32_t xcc_mask)
 {
-	int i, num_xcc;
+	int i;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
+	for_each_inst(i, xcc_mask) {
 		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 			     0XFFFFFFFF);
@@ -298,12 +309,13 @@ static void gfxhub_v1_2_disable_identity_aperture(struct amdgpu_device *adev)
 	}
 }
 
-static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
+static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
+					      uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub;
 	unsigned num_level, block_size;
 	uint32_t tmp;
-	int i, j, num_xcc;
+	int i, j;
 
 	num_level = adev->vm_manager.num_level;
 	block_size = adev->vm_manager.block_size;
@@ -312,8 +324,7 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 	else
 		block_size -= 9;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (j = 0; j < num_xcc; j++) {
+	for_each_inst(j, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		for (i = 0; i <= 14; i++) {
 			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL, i);
@@ -368,13 +379,13 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 	}
 }
 
-static void gfxhub_v1_2_program_invalidation(struct amdgpu_device *adev)
+static void gfxhub_v1_2_xcc_program_invalidation(struct amdgpu_device *adev,
+						 uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub;
-	unsigned i, j, num_xcc;
+	unsigned int i, j;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (j = 0; j < num_xcc; j++) {
+	for_each_inst(j, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 
 		for (i = 0 ; i < 18; ++i) {
@@ -386,18 +397,21 @@ static void gfxhub_v1_2_program_invalidation(struct amdgpu_device *adev)
 	}
 }
 
-static int gfxhub_v1_2_gart_enable(struct amdgpu_device *adev)
+static int gfxhub_v1_2_xcc_gart_enable(struct amdgpu_device *adev,
+				       uint32_t xcc_mask)
 {
-	int i, num_xcc;
-
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
-		if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
+	uint32_t tmp_mask;
+	int i;
+
+	tmp_mask = xcc_mask;
+	/*
+	 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
+	 * VF copy registers so vbios post doesn't program them, for
+	 * SRIOV driver need to program them
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		for_each_inst(i, tmp_mask) {
+			i = ffs(tmp_mask) - 1;
 			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE,
 				     adev->gmc.vram_start >> 24);
 			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP,
@@ -406,29 +420,37 @@ static int gfxhub_v1_2_gart_enable(struct amdgpu_device *adev)
 	}
 
 	/* GART Enable. */
-	gfxhub_v1_2_init_gart_aperture_regs(adev);
-	gfxhub_v1_2_init_system_aperture_regs(adev);
-	gfxhub_v1_2_init_tlb_regs(adev);
+	gfxhub_v1_2_xcc_init_gart_aperture_regs(adev, xcc_mask);
+	gfxhub_v1_2_xcc_init_system_aperture_regs(adev, xcc_mask);
+	gfxhub_v1_2_xcc_init_tlb_regs(adev, xcc_mask);
 	if (!amdgpu_sriov_vf(adev))
-		gfxhub_v1_2_init_cache_regs(adev);
+		gfxhub_v1_2_xcc_init_cache_regs(adev, xcc_mask);
 
-	gfxhub_v1_2_enable_system_domain(adev);
+	gfxhub_v1_2_xcc_enable_system_domain(adev, xcc_mask);
 	if (!amdgpu_sriov_vf(adev))
-		gfxhub_v1_2_disable_identity_aperture(adev);
-	gfxhub_v1_2_setup_vmid_config(adev);
-	gfxhub_v1_2_program_invalidation(adev);
+		gfxhub_v1_2_xcc_disable_identity_aperture(adev, xcc_mask);
+	gfxhub_v1_2_xcc_setup_vmid_config(adev, xcc_mask);
+	gfxhub_v1_2_xcc_program_invalidation(adev, xcc_mask);
 
 	return 0;
 }
 
-static void gfxhub_v1_2_gart_disable(struct amdgpu_device *adev)
+static int gfxhub_v1_2_gart_enable(struct amdgpu_device *adev)
+{
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	return gfxhub_v1_2_xcc_gart_enable(adev, xcc_mask);
+}
+
+static void gfxhub_v1_2_xcc_gart_disable(struct amdgpu_device *adev,
+					 uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub;
 	u32 tmp;
-	u32 i, j, num_xcc;
+	u32 i, j;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (j = 0; j < num_xcc; j++) {
+	for_each_inst(j, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		/* Disable all tables */
 		for (i = 0; i < 16; i++)
@@ -452,20 +474,22 @@ static void gfxhub_v1_2_gart_disable(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * gfxhub_v1_2_set_fault_enable_default - update GART/VM fault handling
- *
- * @adev: amdgpu_device pointer
- * @value: true redirects VM faults to the default page
- */
-static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
-						 bool value)
+static void gfxhub_v1_2_gart_disable(struct amdgpu_device *adev)
+{
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v1_2_xcc_gart_disable(adev, xcc_mask);
+}
+
+static void gfxhub_v1_2_xcc_set_fault_enable_default(struct amdgpu_device *adev,
+						     bool value,
+						     uint32_t xcc_mask)
 {
 	u32 tmp;
-	int i, num_xcc;
+	int i;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
+	for_each_inst(i, xcc_mask) {
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
 				RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
@@ -501,13 +525,27 @@ static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
 	}
 }
 
-static void gfxhub_v1_2_init(struct amdgpu_device *adev)
+/**
+ * gfxhub_v1_2_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
+						 bool value)
+{
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v1_2_xcc_set_fault_enable_default(adev, value, xcc_mask);
+}
+
+static void gfxhub_v1_2_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub;
-	int i, num_xcc;
+	int i;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
+	for_each_inst(i, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 
 		hub->ctx0_ptb_addr_lo32 =
@@ -543,6 +581,14 @@ static void gfxhub_v1_2_init(struct amdgpu_device *adev)
 	}
 }
 
+static void gfxhub_v1_2_init(struct amdgpu_device *adev)
+{
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v1_2_xcc_init(adev, xcc_mask);
+}
+
 static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
 {
 	u32 max_num_physical_nodes;
-- 
2.39.2


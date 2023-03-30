Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BC8C77B6D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DC310EFF6;
	Thu, 30 Mar 2023 19:43:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6618110EFEB
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCtO9ouKrMD6vdtNgQ0bB+LWEF1Wz0af5FVk+gZ1Ovo/H3XuymIuarufMNr9Z14a6f6C4tZbb+lMods47w8AcuX480fxi7KeBE7FNrZZ8sN/2i9fZBbubLAAlVUmLlXeigtCca0s6B4WJ6yKmDVAH+ad/W3bNIoFaCIB/LgwgzrRmhcCsUU2LZEwYEueKXQvuO7rW2NN04qDeGjn/g1N9R5Zx3dkuQOetpMxJd7Rq4/JAoKmBOPYa+YGrHONyEy5ET+BVtJ6M7kXi8fyrKhQ4SxqvOKBr4mMXekFNGNGlf8O/Ezy4DE542mG42J8g4XBCN5a1zf2N1QGIac9wOaPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnFH02+y4GRTXNwdab9KoBmpcF8Tv3DQNWadIlJ4hI4=;
 b=Z66ebM4KksgwaMCNzFwor7MhhEywOpOSzKj6fGFdI6/OWbXNyeoUkAadcPg6KV1DQRc2ihrkWlm4fDWH7r6ZBIP6fyrbkCyE+EtCdLHwGFRa90HS14GgZiDsS+5c+PUrsQ/AC0q4600ymze82LO/YKnSMiBTcVxHhX8WRjontoiaLg1WdPLNSwrQW5/EWsAz/06vXroJa8pC4pN8k6rtJbZFlvzdUS0p5EH4wnv+UXtf7Px2olRHgqK0Y5Ihvo/nx6qzgovvr/M6mQ+aSjmybArgJ5qZslzOAX+BkSf2EwBpQwRo1VUQIfQgLImr9rhpB/2nlZifa7O/rIbO+3utig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnFH02+y4GRTXNwdab9KoBmpcF8Tv3DQNWadIlJ4hI4=;
 b=16O27q6UZFNOuiAQlxvvcftopVUN+hVDIjGF1wvAIsGEURfOzRNDS/YSrx6pcSpN8R5IJalnuN07M4CnjQ49TQSyTBNzr/mVLiBcUB/irNzKPH1JV2cfQ6hMLDvZ/1N9i//4fnOSnHk5f9c/pE6SbNI9+5zSY7KraBZnS84sS84=
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:42:51 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::4e) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/23] drm/amdgpu: Use mask for active clusters
Date: Thu, 30 Mar 2023 15:42:17 -0400
Message-ID: <20230330194234.1135527-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 9700fae5-6cf8-4062-70e1-08db3156f307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saj27z8CX4dUG+zaCBK2NwSjCMnpr7vXO8G1Ytq9M2Kqj+NOd/81eZVR/8T9mWFbVfZpp9pgNccW2Z2yxPy/uEtG+kDGJXxNfJI6Fmbgke/uiMQLHV2BVe4WzUfIyaK2WLheXX6/QryJvWm3lFmiO7AjvQd+nR6MiOADULG8NYZfEufasvMJNKRFF0A797TP3L3CNcKYEwQrQv55vs3M8PWToH83dVnlDv5T1w5M9iATiHPw/5XfLL1LK9ERI+jQTmOQtPXiLHJ/3KgTikgwM9noimkRSC0oh9eXzQpzRVBsFQ9AWkN0gf6jN7LAM/eCHKXp2zMUoICQVLtqxmOysWOjvnxcbN1Bfi9qE2QHnICBa46aeWE04AkB/fUSKP7ea65CpMDGVX6sKFIWmTs9Sz9dAWDj8H9VW6hqyRl60Ln0DNRd/bxId/52LUAsDbhmD4uuDpkgA29XhrSdEdc3GI3DcythfWLcu2aA4fIO1hNOnasoMmc2u+QAP8RLnsZvYukCvzGZc76/JQ/NBCVQ/jvsROaP/Egm54AyTmzP95sAUTEqdSMU6hfkYlLOWKakzN9TWtGWDWvLt95fOgZWQjhFSL5HaJIi74rwpEEuCG7G9LRqIhWh7Z7IjIGXuUTDumIMSxFjfCSqDFtTPNia41yNe4I17UNuiwyGFmv3uSAqKfwSoZ3MoaMcBkKzGpjIlblVhN8UPK2hIKdpn09WQBVe3WmZpMXT+x3CDBJGDWY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(336012)(186003)(83380400001)(2906002)(426003)(47076005)(16526019)(26005)(1076003)(40460700003)(478600001)(356005)(81166007)(82740400003)(316002)(70206006)(4326008)(6916009)(70586007)(41300700001)(86362001)(82310400005)(54906003)(36860700001)(40480700001)(8676002)(36756003)(5660300002)(8936002)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:51.6419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9700fae5-6cf8-4062-70e1-08db3156f307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
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

Use a mask of available active clusters instead of using only the number
of active clusters.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 13 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  5 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       | 56 ++++++++++++-------
 4 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 96269bc41107..c894fb43786c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1091,7 +1091,8 @@ struct amdgpu_device {
 
 	bool                            job_hang;
 	bool                            dc_enabled;
-	uint32_t			num_aid;
+	/* Mask of active clusters */
+	uint32_t			aid_mask;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 6f7226b5d446..0d7bc212def1 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -358,25 +358,26 @@ static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
 int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 {
 	u32 inst_mask = adev->sdma.sdma_mask;
-	int ret;
+	int ret, i, num_inst;
 
 	/* generally 1 AID supports 4 instances */
 	adev->sdma.num_inst_per_aid = 4;
 	adev->sdma.num_instances = NUM_SDMA(adev->sdma.sdma_mask);
 
-	adev->num_aid = 1;
+	adev->aid_mask = i = 1;
 	inst_mask >>= adev->sdma.num_inst_per_aid;
 
 	for (const u32 mask = (1 << adev->sdma.num_inst_per_aid) - 1; inst_mask;
-	     inst_mask >>= adev->sdma.num_inst_per_aid) {
+	     inst_mask >>= adev->sdma.num_inst_per_aid, ++i) {
 		if ((inst_mask & mask) == mask)
-			adev->num_aid++;
+			adev->aid_mask |= (1 << i);
 	}
 
+	num_inst = hweight32(adev->aid_mask);
 	adev->vcn.num_inst_per_aid = 1;
-	adev->vcn.num_vcn_inst = adev->vcn.num_inst_per_aid * adev->num_aid;
+	adev->vcn.num_vcn_inst = adev->vcn.num_inst_per_aid * num_inst;
 	adev->jpeg.num_inst_per_aid = 1;
-	adev->jpeg.num_jpeg_inst = adev->jpeg.num_inst_per_aid * adev->num_aid;
+	adev->jpeg.num_jpeg_inst = adev->jpeg.num_inst_per_aid * num_inst;
 
 	ret = aqua_vanjaram_xcp_mgr_init(adev);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1a43276de338..e719b7737111 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1656,6 +1656,7 @@ static int gmc_v9_0_sw_init(void *handle)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	unsigned long inst_mask = adev->aid_mask;
 
 	adev->gfxhub.funcs->init(adev);
 
@@ -1739,7 +1740,9 @@ static int gmc_v9_0_sw_init(void *handle)
 	case IP_VERSION(9, 4, 3):
 		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
 				  NUM_XCC(adev->gfx.xcc_mask));
-		bitmap_set(adev->vmhubs_mask, AMDGPU_MMHUB0(0), adev->num_aid);
+
+		inst_mask <<= AMDGPU_MMHUB0(0);
+		bitmap_or(adev->vmhubs_mask, adev->vmhubs_mask, &inst_mask, 32);
 
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 6f469b9aa9a0..a530e2a3cc28 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -54,9 +54,11 @@ static void mmhub_v1_8_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi
 				uint64_t page_table_base)
 {
 	struct amdgpu_vmhub *hub;
+	u32 inst_mask;
 	int i;
 
-	for (i = 0; i < adev->num_aid; i++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(i)];
 		WREG32_SOC15_OFFSET(MMHUB, i,
 				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
@@ -73,6 +75,7 @@ static void mmhub_v1_8_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi
 static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t pt_base;
+	u32 inst_mask;
 	int i;
 
 	if (adev->gmc.pdb0_bo)
@@ -85,7 +88,8 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
 	/* If use GART for FB translation, vmid0 page table covers both
 	 * vram and system memory (gart)
 	 */
-	for (i = 0; i < adev->num_aid; i++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
 		if (adev->gmc.pdb0_bo) {
 			WREG32_SOC15(MMHUB, i,
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
@@ -121,11 +125,12 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
 
 static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *adev)
 {
+	uint32_t tmp, inst_mask;
 	uint64_t value;
-	uint32_t tmp;
 	int i;
 
-	for (i = 0; i < adev->num_aid; i++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
 		/* Program the AGP BAR */
 		WREG32_SOC15(MMHUB, i, regMC_VM_AGP_BASE, 0);
 		WREG32_SOC15(MMHUB, i, regMC_VM_AGP_BOT,
@@ -183,11 +188,12 @@ static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *adev)
 
 static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 {
-	uint32_t tmp;
+	uint32_t tmp, inst_mask;
 	int i;
 
 	/* Setup TLB control */
-	for (i = 0; i < adev->num_aid; i++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
 		tmp = RREG32_SOC15(MMHUB, i, regMC_VM_MX_L1_TLB_CNTL);
 
 		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB,
@@ -208,14 +214,15 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 
 static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 {
-	uint32_t tmp;
+	uint32_t tmp, inst_mask;
 	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
 
 	/* Setup L2 cache */
-	for (i = 0; i < adev->num_aid; i++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
 		tmp = RREG32_SOC15(MMHUB, i, regVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL,
@@ -267,10 +274,11 @@ static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 
 static void mmhub_v1_8_enable_system_domain(struct amdgpu_device *adev)
 {
-	uint32_t tmp;
+	uint32_t tmp, inst_mask;
 	int i;
 
-	for (i = 0; i < adev->num_aid; i++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
 		tmp = RREG32_SOC15(MMHUB, i, regVM_CONTEXT0_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
@@ -286,12 +294,14 @@ static void mmhub_v1_8_enable_system_domain(struct amdgpu_device *adev)
 
 static void mmhub_v1_8_disable_identity_aperture(struct amdgpu_device *adev)
 {
+	u32 inst_mask;
 	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	for (i = 0; i < adev->num_aid; i++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
 		WREG32_SOC15(MMHUB, i,
 			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 			     0XFFFFFFFF);
@@ -317,7 +327,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
 	unsigned num_level, block_size;
-	uint32_t tmp;
+	uint32_t tmp, inst_mask;
 	int i, j;
 
 	num_level = adev->vm_manager.num_level;
@@ -327,7 +337,8 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 	else
 		block_size -= 9;
 
-	for (j = 0; j < adev->num_aid; j++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(j, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 		for (i = 0; i <= 14; i++) {
 			tmp = RREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
@@ -382,9 +393,10 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 static void mmhub_v1_8_program_invalidation(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
-	unsigned i, j;
+	u32 i, j, inst_mask;
 
-	for (j = 0; j < adev->num_aid; j++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(j, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 		for (i = 0; i < 18; ++i) {
 			WREG32_SOC15_OFFSET(MMHUB, j,
@@ -429,10 +441,11 @@ static void mmhub_v1_8_gart_disable(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
 	u32 tmp;
-	u32 i, j;
+	u32 i, j, inst_mask;
 
 	/* Disable all tables */
-	for (j = 0; j < adev->num_aid; j++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(j, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 		for (i = 0; i < 16; i++)
 			WREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT0_CNTL,
@@ -465,13 +478,14 @@ static void mmhub_v1_8_gart_disable(struct amdgpu_device *adev)
  */
 static void mmhub_v1_8_set_fault_enable_default(struct amdgpu_device *adev, bool value)
 {
-	u32 tmp;
+	u32 tmp, inst_mask;
 	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	for (i = 0; i < adev->num_aid; i++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
 		tmp = RREG32_SOC15(MMHUB, i, regVM_L2_PROTECTION_FAULT_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
 				RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
@@ -510,9 +524,11 @@ static void mmhub_v1_8_set_fault_enable_default(struct amdgpu_device *adev, bool
 static void mmhub_v1_8_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
+	u32 inst_mask;
 	int i;
 
-	for (i = 0; i < adev->num_aid; i++) {
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(i)];
 
 		hub->ctx0_ptb_addr_lo32 = SOC15_REG_OFFSET(MMHUB, i,
-- 
2.39.2


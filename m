Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6604CC77B6E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B85C10E746;
	Mon, 27 Mar 2023 19:36:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2347210E71F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3D9PP8fqtcxNf+9Tf2oOghRTXmU/52dx/W+5ysZ3c/BH+2uLgQNHfh2sa5UDr76jDloU/VkM5lGp7OzzssFUnoGooiEABaLJmXL59EKRg3+qBIq/bp+00ewfeecPSlUUkCrF+4XZS+ku3bEgKSP9G5NAu81WMSHMUlWUrKKNyvZuMV2TrTr5g3xRjpoXDgxGV8wxCUIKehcji1jnh/UdNn24DE78WtujvU5gA/gCH4Bm/7yRmVpZ580xR9ks1HYEXJlhxBX4PevjZpJCQYN6gLzQgmSnTSlw56J+opisTgBsHmWcKtm0VUlTzT3sXCcPjGSx8zOiSKsFZoNsPC/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReA1bzSz/QekvGQJtCF9oD8Yg3hZAS9/QOJF7znVkfg=;
 b=Eo65zDScvj6J1aCINiriR4IZi9c4iQOiz4AozFsCJgN7ZpKh3EPRYLP2h9N6a0R4xJwy4UT5j3b/UIn9z5mKLXhj2EVm+ylnAbclSc8fkFgiS7x47L8xNbfcP8Gr3ExQnFizKMguWS2m8OlQaPqCY0UXjjJJhRnsFvFD/G9DuiAe685KyWSuzvvQZTyL7bDUVYD0bM01jnYFMkeIo8yWRuHVqI//7RLc1EUAQsXltsiskyk0dkAEzd5/uR2WGd0n39EDuIiNFnqK0nHNTrN1RMqVwKBkrxHTRZK+41EcrvfkB5tlTSirEUjyoinUc42gRqh2au9lLsDXWwcAIBvY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReA1bzSz/QekvGQJtCF9oD8Yg3hZAS9/QOJF7znVkfg=;
 b=HjBQrZnv4k1zcNkOrJ+bLV+H5O3MvXA1hJHY9tb5OOReb80m/5zZz6L6zwFyRAIiXG+AAwNdxCRZXny5nqUHxfLmKu6BN2RHxNDzqHJBOn2P5ITaU9hTkYgCqQ8i40ZAFyQIhKQBFmx1RoppzoUfoyR7571EPApkAYuqhmPYtQU=
Received: from BL1PR13CA0364.namprd13.prod.outlook.com (2603:10b6:208:2c0::9)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 19:36:31 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0::4) by BL1PR13CA0364.outlook.office365.com
 (2603:10b6:208:2c0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/28] drm/amdgpu: do gfxhub init for all XCDs
Date: Mon, 27 Mar 2023 15:35:50 -0400
Message-ID: <20230327193602.7901-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f0716a-78c9-4a85-1687-08db2efa90e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPUFnltKh2PLs6iRJ7J+VA4VekuV9goR6298hX+HfdZzT7LyRHHCGP6dSA8GF3w4XgKeYOaxjCjweGwdOinXnAbuGOAp9LcOFRDvcF0EbGnXQIy2G/3B3Gx2d+4MMTupyte18qg3c0AfQwXAoX7ZlfTjgaaOhpvAbmznDkbcjiYCfyM+MMWmRBh7JVNTdowlySvKQdGCN7JMDXVZTWGvDeQZ+2nXUxRrPA8qc3Bgewm7sustQ8OBoFEu/O8bE0gLgN6npqsT5Uv4ZoJ3ILMCSsG3XV0rFp5gvC/QE1FpJcBK8X/U3z+tdTS3be8xyTf29pYvBTCMoLZ2Uc1v7BsXWPPP7eW0akMlw++agtKIcnX8fBrbYcCHbwkfsHqxAfHZ4Xlr0nFWmL/VXzVWIikSn/aaTrnhXbxdmRkvsyUqhicLpz+hxPiOrKixFKqR6ej3/NqC8W55G+DL1akeTH1u3Xjp973BRmhoUiHtvDhW9kg7/RhiiY1KfimUOP1qlyqIsrAfiIMnAVH2i6xzRKOdriItTWPlMvJP1jZqhmoLvdM/+gX1FHqPafSrYYhUzlTq2y34QYlFCvaARo6onsQUkY+mAYZqi03e5Z3j2RvgIUj8TXoDG1pLKFi6AC5vLVhyhaBEMRbQDrLnLAhACWdJ4TUqXet4JoYOvHz0bcIcURcNrkcdufS6qDxWWE2pA8/1LGANyYS3ijVuhDhBcxhyZDHHaL3Nkau3XvdpoQZE+pWyxqPIzyXwyowoGzQZ+Fe0XaE4cQygKmvCLaOkswmKcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(47076005)(83380400001)(336012)(426003)(41300700001)(36860700001)(36756003)(86362001)(5660300002)(356005)(8936002)(81166007)(82740400003)(40460700003)(54906003)(7696005)(478600001)(70586007)(8676002)(4326008)(6916009)(70206006)(2906002)(40480700001)(82310400005)(30864003)(6666004)(16526019)(1076003)(316002)(186003)(26005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:31.0353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f0716a-78c9-4a85-1687-08db2efa90e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Each XCD needs to do gfxhub init

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 581 +++++++++++++----------
 1 file changed, 317 insertions(+), 264 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index c59c6c85fbff..79af32bb078c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -43,19 +43,25 @@ static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
 					 uint64_t page_table_base)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	int i;
 
-	WREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
-			    hub->ctx_addr_distance * vmid,
-			    lower_32_bits(page_table_base));
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		WREG32_SOC15_OFFSET(GC, i,
+				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+				    hub->ctx_addr_distance * vmid,
+				    lower_32_bits(page_table_base));
 
-	WREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
-			    hub->ctx_addr_distance * vmid,
-			    upper_32_bits(page_table_base));
+		WREG32_SOC15_OFFSET(GC, i,
+				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+				    hub->ctx_addr_distance * vmid,
+				    upper_32_bits(page_table_base));
+	}
 }
 
 static void gfxhub_v1_2_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t pt_base;
+	int i;
 
 	if (adev->gmc.pdb0_bo)
 		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
@@ -67,26 +73,36 @@ static void gfxhub_v1_2_init_gart_aperture_regs(struct amdgpu_device *adev)
 	/* If use GART for FB translation, vmid0 page table covers both
 	 * vram and system memory (gart)
 	 */
-	if (adev->gmc.pdb0_bo) {
-		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
-				(u32)(adev->gmc.fb_start >> 12));
-		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
-				(u32)(adev->gmc.fb_start >> 44));
-
-		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
-				(u32)(adev->gmc.gart_end >> 12));
-		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
-				(u32)(adev->gmc.gart_end >> 44));
-	} else {
-		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
-				(u32)(adev->gmc.gart_start >> 12));
-		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
-				(u32)(adev->gmc.gart_start >> 44));
-
-		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
-				(u32)(adev->gmc.gart_end >> 12));
-		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
-				(u32)(adev->gmc.gart_end >> 44));
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		if (adev->gmc.pdb0_bo) {
+			WREG32_SOC15(GC, i,
+				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				     (u32)(adev->gmc.fb_start >> 12));
+			WREG32_SOC15(GC, i,
+				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				     (u32)(adev->gmc.fb_start >> 44));
+
+			WREG32_SOC15(GC, i,
+				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				     (u32)(adev->gmc.gart_end >> 12));
+			WREG32_SOC15(GC, i,
+				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				     (u32)(adev->gmc.gart_end >> 44));
+		} else {
+			WREG32_SOC15(GC, i,
+				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				     (u32)(adev->gmc.gart_start >> 12));
+			WREG32_SOC15(GC, i,
+				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				     (u32)(adev->gmc.gart_start >> 44));
+
+			WREG32_SOC15(GC, i,
+				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				     (u32)(adev->gmc.gart_end >> 12));
+			WREG32_SOC15(GC, i,
+				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				     (u32)(adev->gmc.gart_end >> 44));
+		}
 	}
 }
 
@@ -94,160 +110,183 @@ static void gfxhub_v1_2_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 	uint32_t tmp;
+	int i;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(GC, 0, regMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(GC, 0, regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(GC, 0, regMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
-	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
-		/* Program the system aperture low logical page number. */
-		WREG32_SOC15_RLC(GC, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-
-		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
-			/*
-			* Raven2 has a HW issue that it is unable to use the
-			* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
-			* So here is the workaround that increase system
-			* aperture high address (add 1) to get rid of the VM
-			* fault and hardware hang.
-			*/
-			WREG32_SOC15_RLC(GC, 0,
-					 regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-					 max((adev->gmc.fb_end >> 18) + 0x1,
-					     adev->gmc.agp_end >> 18));
-		else
-			WREG32_SOC15_RLC(GC, 0,
-				regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-				max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
-
-		/* Set default page address. */
-		value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
-		WREG32_SOC15(GC, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-			     (u32)(value >> 12));
-		WREG32_SOC15(GC, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-			     (u32)(value >> 44));
-
-		/* Program "protection fault". */
-		WREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-			     (u32)(adev->dummy_page_addr >> 12));
-		WREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-			     (u32)((u64)adev->dummy_page_addr >> 44));
-
-		tmp = RREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL2);
-		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
-				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
-		WREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
-	}
-
-	/* In the case squeezing vram into GART aperture, we don't use
-	 * FB aperture and AGP aperture. Disable them.
-	 */
-	if (adev->gmc.pdb0_bo) {
-		WREG32_SOC15(GC, 0, regMC_VM_FB_LOCATION_TOP, 0);
-		WREG32_SOC15(GC, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
-		WREG32_SOC15(GC, 0, regMC_VM_AGP_TOP, 0);
-		WREG32_SOC15(GC, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
-		WREG32_SOC15(GC, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-		WREG32_SOC15(GC, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(GC, i, regMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(GC, i, regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(GC, i, regMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
+		if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
+			/* Program the system aperture low logical page number. */
+			WREG32_SOC15_RLC(GC, i, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+				min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
+
+			if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+				/*
+				* Raven2 has a HW issue that it is unable to use the
+				* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
+				* So here is the workaround that increase system
+				* aperture high address (add 1) to get rid of the VM
+				* fault and hardware hang.
+				*/
+				WREG32_SOC15_RLC(GC, i,
+						 regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+						 max((adev->gmc.fb_end >> 18) + 0x1,
+						     adev->gmc.agp_end >> 18));
+			else
+				WREG32_SOC15_RLC(GC, i,
+					regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+					max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
+
+			/* Set default page address. */
+			value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
+			WREG32_SOC15(GC, i, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+				     (u32)(value >> 12));
+			WREG32_SOC15(GC, i, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+				     (u32)(value >> 44));
+
+			/* Program "protection fault". */
+			WREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+				     (u32)(adev->dummy_page_addr >> 12));
+			WREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+				     (u32)((u64)adev->dummy_page_addr >> 44));
+
+			tmp = RREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_CNTL2);
+			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+					    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+			WREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+		}
+
+		/* In the case squeezing vram into GART aperture, we don't use
+		 * FB aperture and AGP aperture. Disable them.
+		 */
+		if (adev->gmc.pdb0_bo) {
+			WREG32_SOC15(GC, i, regMC_VM_FB_LOCATION_TOP, 0);
+			WREG32_SOC15(GC, i, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+			WREG32_SOC15(GC, i, regMC_VM_AGP_TOP, 0);
+			WREG32_SOC15(GC, i, regMC_VM_AGP_BOT, 0xFFFFFF);
+			WREG32_SOC15(GC, i, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+			WREG32_SOC15(GC, i, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+		}
 	}
 }
 
 static void gfxhub_v1_2_init_tlb_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
+	int i;
 
-	/* Setup TLB control */
-	tmp = RREG32_SOC15(GC, 0, regMC_VM_MX_L1_TLB_CNTL);
-
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 1);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, SYSTEM_ACCESS_MODE, 3);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
-			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
-			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
-			    MTYPE, MTYPE_UC);/* XXX for emulation. */
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
-
-	WREG32_SOC15_RLC(GC, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		/* Setup TLB control */
+		tmp = RREG32_SOC15(GC, i, regMC_VM_MX_L1_TLB_CNTL);
+
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_L1_TLB, 1);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+				    SYSTEM_ACCESS_MODE, 3);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_ADVANCED_DRIVER_MODEL, 1);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+				    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+				    MTYPE, MTYPE_UC);/* XXX for emulation. */
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
+
+		WREG32_SOC15_RLC(GC, i, regMC_VM_MX_L1_TLB_CNTL, tmp);
+	}
 }
 
 static void gfxhub_v1_2_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
+	int i;
 
-	/* Setup L2 cache */
-	tmp = RREG32_SOC15(GC, 0, regVM_L2_CNTL);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 1);
-	/* XXX for emulation, Refer to closed source code.*/
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, L2_PDE0_CACHE_TAG_GENERATION_MODE,
-			    0);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
-	WREG32_SOC15_RLC(GC, 0, regVM_L2_CNTL, tmp);
-
-	tmp = RREG32_SOC15(GC, 0, regVM_L2_CNTL2);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
-	WREG32_SOC15_RLC(GC, 0, regVM_L2_CNTL2, tmp);
-
-	tmp = regVM_L2_CNTL3_DEFAULT;
-	if (adev->gmc.translate_further) {
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
-				    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
-	} else {
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
-				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
-	}
-	WREG32_SOC15_RLC(GC, 0, regVM_L2_CNTL3, tmp);
-
-	tmp = regVM_L2_CNTL4_DEFAULT;
-	if (adev->gmc.xgmi.connected_to_cpu) {
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
-	} else {
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		/* Setup L2 cache */
+		tmp = RREG32_SOC15(GC, i, regVM_L2_CNTL);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 1);
+		/* XXX for emulation, Refer to closed source code.*/
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, L2_PDE0_CACHE_TAG_GENERATION_MODE,
+				    0);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
+		WREG32_SOC15_RLC(GC, i, regVM_L2_CNTL, tmp);
+
+		tmp = RREG32_SOC15(GC, i, regVM_L2_CNTL2);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
+		WREG32_SOC15_RLC(GC, i, regVM_L2_CNTL2, tmp);
+
+		tmp = regVM_L2_CNTL3_DEFAULT;
+		if (adev->gmc.translate_further) {
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
+					    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+		} else {
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
+					    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+		}
+		WREG32_SOC15_RLC(GC, i, regVM_L2_CNTL3, tmp);
+
+		tmp = regVM_L2_CNTL4_DEFAULT;
+		if (adev->gmc.xgmi.connected_to_cpu) {
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
+		} else {
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+		}
+		WREG32_SOC15_RLC(GC, i, regVM_L2_CNTL4, tmp);
 	}
-	WREG32_SOC15_RLC(GC, 0, regVM_L2_CNTL4, tmp);
 }
 
 static void gfxhub_v1_2_enable_system_domain(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
+	int i;
 
-	tmp = RREG32_SOC15(GC, 0, regVM_CONTEXT0_CNTL);
-	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
-	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
-			adev->gmc.vmid0_page_table_depth);
-	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_BLOCK_SIZE,
-			adev->gmc.vmid0_page_table_block_size);
-	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL,
-			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
-	WREG32_SOC15(GC, 0, regVM_CONTEXT0_CNTL, tmp);
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		tmp = RREG32_SOC15(GC, i, regVM_CONTEXT0_CNTL);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
+				adev->gmc.vmid0_page_table_depth);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_BLOCK_SIZE,
+				adev->gmc.vmid0_page_table_block_size);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL,
+				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
+		WREG32_SOC15(GC, i, regVM_CONTEXT0_CNTL, tmp);
+	}
 }
 
 static void gfxhub_v1_2_disable_identity_aperture(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
-		     0XFFFFFFFF);
-	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
-		     0x0000000F);
-
-	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
-		     0);
-	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
-		     0);
-
-	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
-	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
+	int i;
 
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		WREG32_SOC15(GC, i,
+			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
+			     0XFFFFFFFF);
+		WREG32_SOC15(GC, i,
+			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
+			     0x0000000F);
+
+		WREG32_SOC15(GC, i,
+			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
+			     0);
+		WREG32_SOC15(GC, i,
+			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
+			     0);
+
+		WREG32_SOC15(GC, i,
+			     regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
+		WREG32_SOC15(GC, i,
+			     regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
+	}
 }
 
 static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
@@ -255,7 +294,7 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 	unsigned num_level, block_size;
 	uint32_t tmp;
-	int i;
+	int i, j;
 
 	num_level = adev->vm_manager.num_level;
 	block_size = adev->vm_manager.block_size;
@@ -264,81 +303,89 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 	else
 		block_size -= 9;
 
-	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
-				    num_level);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-				    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT,
-				    1);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-				    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-				    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-				    READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-				    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-				    PAGE_TABLE_BLOCK_SIZE,
-				    block_size);
-		/* Send no-retry XNACK on fault to suppress VM fault storm.
-		 * On Aldebaran, XNACK can be enabled in the SQ per-process.
-		 * Retry faults need to be enabled for that to work.
-		 */
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !adev->gmc.noretry ||
-				    adev->asic_type == CHIP_ALDEBARAN);
-		WREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
-		WREG32_SOC15_OFFSET(GC, 0,
-				    regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
-				    i * hub->ctx_addr_distance, 0);
-		WREG32_SOC15_OFFSET(GC, 0,
-				    regVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
-				    i * hub->ctx_addr_distance, 0);
-		WREG32_SOC15_OFFSET(GC, 0,
-				    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
-				    i * hub->ctx_addr_distance,
-				    lower_32_bits(adev->vm_manager.max_pfn - 1));
-		WREG32_SOC15_OFFSET(GC, 0,
-				    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
-				    i * hub->ctx_addr_distance,
-				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+	for (j = 0; j < adev->gfx.num_xcd; j++) {
+		for (i = 0; i <= 14; i++) {
+			tmp = RREG32_SOC15_OFFSET(GC, j, regVM_CONTEXT1_CNTL, i);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
+					    num_level);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT,
+					    1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    PAGE_TABLE_BLOCK_SIZE,
+					    block_size);
+			/* Send no-retry XNACK on fault to suppress VM fault storm.
+			 * On Aldebaran, XNACK can be enabled in the SQ per-process.
+			 * Retry faults need to be enabled for that to work.
+			 */
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
+					    !adev->gmc.noretry ||
+					    adev->asic_type == CHIP_ALDEBARAN);
+			WREG32_SOC15_OFFSET(GC, j, regVM_CONTEXT1_CNTL,
+					    i * hub->ctx_distance, tmp);
+			WREG32_SOC15_OFFSET(GC, j,
+					    regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+					    i * hub->ctx_addr_distance, 0);
+			WREG32_SOC15_OFFSET(GC, j,
+					    regVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+					    i * hub->ctx_addr_distance, 0);
+			WREG32_SOC15_OFFSET(GC, j,
+					    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+					    i * hub->ctx_addr_distance,
+					    lower_32_bits(adev->vm_manager.max_pfn - 1));
+			WREG32_SOC15_OFFSET(GC, j,
+					    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+					    i * hub->ctx_addr_distance,
+					    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		}
 	}
 }
 
 static void gfxhub_v1_2_program_invalidation(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
-	unsigned i;
-
-	for (i = 0 ; i < 18; ++i) {
-		WREG32_SOC15_OFFSET(GC, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
-				    i * hub->eng_addr_distance, 0xffffffff);
-		WREG32_SOC15_OFFSET(GC, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
-				    i * hub->eng_addr_distance, 0x1f);
+	unsigned i, j;
+
+	for (j = 0; j < adev->gfx.num_xcd; j++) {
+		for (i = 0 ; i < 18; ++i) {
+			WREG32_SOC15_OFFSET(GC, j, regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+					    i * hub->eng_addr_distance, 0xffffffff);
+			WREG32_SOC15_OFFSET(GC, j, regVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+					    i * hub->eng_addr_distance, 0x1f);
+		}
 	}
 }
 
 static int gfxhub_v1_2_gart_enable(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev) && adev->asic_type != CHIP_ARCTURUS) {
+	int i;
+
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		if (amdgpu_sriov_vf(adev)) {
 		/*
 		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
 		 * VF copy registers so vbios post doesn't program them, for
 		 * SRIOV driver need to program them
 		 */
-		WREG32_SOC15_RLC(GC, 0, regMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15_RLC(GC, 0, regMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
+			WREG32_SOC15_RLC(GC, i, regMC_VM_FB_LOCATION_BASE,
+				     adev->gmc.vram_start >> 24);
+			WREG32_SOC15_RLC(GC, i, regMC_VM_FB_LOCATION_TOP,
+				     adev->gmc.vram_end >> 24);
+		}
 	}
 
 	/* GART Enable. */
@@ -361,27 +408,29 @@ static void gfxhub_v1_2_gart_disable(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 	u32 tmp;
-	u32 i;
-
-	/* Disable all tables */
-	for (i = 0; i < 16; i++)
-		WREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT0_CNTL,
-				    i * hub->ctx_distance, 0);
-
-	/* Setup TLB control */
-	tmp = RREG32_SOC15(GC, 0, regMC_VM_MX_L1_TLB_CNTL);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
-	tmp = REG_SET_FIELD(tmp,
-				MC_VM_MX_L1_TLB_CNTL,
-				ENABLE_ADVANCED_DRIVER_MODEL,
-				0);
-	WREG32_SOC15_RLC(GC, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
-
-	/* Setup L2 cache */
-	tmp = RREG32_SOC15(GC, 0, regVM_L2_CNTL);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
-	WREG32_SOC15(GC, 0, regVM_L2_CNTL, tmp);
-	WREG32_SOC15(GC, 0, regVM_L2_CNTL3, 0);
+	u32 i, j;
+
+	for (j = 0; j < adev->gfx.num_xcd; j++) {
+		/* Disable all tables */
+		for (i = 0; i < 16; i++)
+			WREG32_SOC15_OFFSET(GC, j, regVM_CONTEXT0_CNTL,
+					    i * hub->ctx_distance, 0);
+
+		/* Setup TLB control */
+		tmp = RREG32_SOC15(GC, j, regMC_VM_MX_L1_TLB_CNTL);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
+		tmp = REG_SET_FIELD(tmp,
+					MC_VM_MX_L1_TLB_CNTL,
+					ENABLE_ADVANCED_DRIVER_MODEL,
+					0);
+		WREG32_SOC15_RLC(GC, j, regMC_VM_MX_L1_TLB_CNTL, tmp);
+
+		/* Setup L2 cache */
+		tmp = RREG32_SOC15(GC, j, regVM_L2_CNTL);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
+		WREG32_SOC15(GC, j, regVM_L2_CNTL, tmp);
+		WREG32_SOC15(GC, j, regVM_L2_CNTL3, 0);
+	}
 }
 
 /**
@@ -394,38 +443,42 @@ static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
 						 bool value)
 {
 	u32 tmp;
-	tmp = RREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp,
-			VM_L2_PROTECTION_FAULT_CNTL,
-			TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
-			value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	if (!value) {
+	int i;
+
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		tmp = RREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_CNTL);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				VM_L2_PROTECTION_FAULT_CNTL,
+				TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
+				value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_NO_RETRY_FAULT, 1);
+				WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-				CRASH_ON_RETRY_FAULT, 1);
+				EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		if (!value) {
+			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+					CRASH_ON_NO_RETRY_FAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+					CRASH_ON_RETRY_FAULT, 1);
+		}
+		WREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
 	}
-	WREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
 static void gfxhub_v1_2_init(struct amdgpu_device *adev)
-- 
2.39.2


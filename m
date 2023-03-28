Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA4AC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D5610E92B;
	Tue, 28 Mar 2023 15:15:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CDD10E919
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXgv0gS+9uncUzpDdStXziaQ8heVA7BwGMo8Su+koSI5hMP/JGgn3ndLq9R8Bj1oUGaY0z7r0FeNXT4+03bDfhguXwTCz4sxXcYREkwFMSSrsVoosnGI2IxlAR4DoxGnS7uBZByuEAecIw9qlLspLibrDhYEpB/Xa4RpC++U7+0SNNIxwC85KHEljTfXX4HcaszGrLtHsjGq+6qtZB4kzjChP8SE7MgGwQMkZHUZN1LNk/UB8lFiGW3W5TDKx8zV6E8PqCYcV3Vh+vn7o3ZAuWp8gO19KNXiRYqPawEG2V6X5daZ+vBnwqhwL+KVWDOhnIzedGMvfNrJYSeFi5b+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+hMtSxjRbYlQ9l7QDazDrTj4xAMXfnLqGJvhueSy38=;
 b=KtYcqrUT4AxlFVYq4thi89CXNTlyJRO7riJjAdPhKybOg2tQxQ+Av9ko+yLGTjV8tnwF+tUvvZlHHB5aD4WPVO+y16GKtSzP8XXrpsyxIqJ+lQvHn2QmMxCjOKx3qVIiJF/I8IUUjLbu4KBul5Pa1JVDXZD3pN6byD4hvXVE5WAjsLSWVWPZJBVcYPv9P2Ez5bGVq8r4O5SIVLgCqtmgRdbX5GviwdCdi5eSw1vftDTLs19FMpfbLI1umBa4VmgzzwuEaRpKjX9oTjTFxEZsi/gvFRrP6pK/L2/9VRoV1D/xBlnAzRzEOmGB/Dysolop3ltB93yVD8B86y7HvCE4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+hMtSxjRbYlQ9l7QDazDrTj4xAMXfnLqGJvhueSy38=;
 b=PUG+ra1+4AO6fKTfeboEuhcwU7buLmW+eWFScDLgPtPZVsDCy12vDsLsnL3r9e5WTB7NnkCbVRV/7ZtPpou1RsGaWLJ2PVaKp16OIwNNs2IC4hiWny1nXiv+53SJMbdTSvBIE7XTU5HXkVmp8UmCOWGBCSIJnWbOuQKL63zQizM=
Received: from MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Tue, 28 Mar
 2023 15:14:48 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::d7) by MN2PR22CA0017.outlook.office365.com
 (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/32] drm/amdgpu: do mmhub init for multiple AIDs
Date: Tue, 28 Mar 2023 11:13:37 -0400
Message-ID: <20230328151344.1934291-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4c90bc-a8b5-4b7b-bde2-08db2f9f2b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82+8Xma8lvRW94xcO7r77QclDyISxbaNoDXd0kZbWkckP/v1OXIPhq9bzhObZQB4D1VQm+vjLwvoK3QnrJMFrRjvSD5bHtJBOedC6ZoVqlXNGC573BOO8IEtQp1Ckib679RoNV4RA7qvr0/4kAgsrlBPR6koUMcNjcMa8HXYer+GcsmNyG8sqnEKgxNZ2MyVlue0/XYTY5nNeoxe4W9SR1JP4yTSWECp5ESansXhqH8j6x6fnymdneGz9vy5UGggB9wI4stgOcR77+TPSGX7+TE1RpnKwQjqoV/GixUP6LDVbsiaFo60bxH5SFoLxLWKZd7SHI7kwtxt+GbgmOI0uZf16cIR+8IuzL5lixiIxgkVRcMTu0BSmVeaDVobt+L4mfzvhP80Sl0YuHNPVrwkrit9j5Ay0n5LKJ1kRZms8+75r27Iz/d7GSebRDIl2ZBfWKmjBby+dOyT8OJB8EDm3/DfbnUTVgYINTJT02j949bGj2wx8SpeGNsqZOVTFiMdPHObeg1MB/W+116HAzQqrqWtLzqv7z0bF0wv0p5+1EIAY435yP4HuQrpBxgMTMQ9pFvQcK+3VQYOb6dQgt/p1cPX/+iZvJWeewmFYCyFSRFIuwqGEXGDu7zqXnORy6f8y/lo/wjW0mAwWr5wF7Co3umdhYTDJrgVYTl8t/qvnohughSG0RlwpNCnUvnk1lkc7hy7TbWHk6FprvsOV3fPQUNuqF6h9OhLby58wFZyug9X0ysQjPrX/Ugh3JFC+NNvPGIfY8Bzgf9dozecGf9aNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(40480700001)(82310400005)(36756003)(2906002)(478600001)(40460700003)(426003)(6666004)(336012)(2616005)(47076005)(7696005)(83380400001)(81166007)(6916009)(8676002)(36860700001)(4326008)(70206006)(70586007)(5660300002)(316002)(82740400003)(54906003)(26005)(16526019)(1076003)(186003)(356005)(8936002)(30864003)(41300700001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:48.0389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4c90bc-a8b5-4b7b-bde2-08db2f9f2b99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Mmhub on each AID needs to be initialized respectively

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 609 ++++++++++++++----------
 1 file changed, 348 insertions(+), 261 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 3883758b7993..67338cb3d7bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -53,18 +53,27 @@ static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)
 static void mmhub_v1_8_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
-
-	WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
-			    hub->ctx_addr_distance * vmid, lower_32_bits(page_table_base));
+	struct amdgpu_vmhub *hub;
+	int i;
 
-	WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
-			    hub->ctx_addr_distance * vmid, upper_32_bits(page_table_base));
+	for (i = 0; i < adev->num_aid; i++) {
+		hub = &adev->vmhub[AMDGPU_MMHUB0(i)];
+		WREG32_SOC15_OFFSET(MMHUB, i,
+				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+				    hub->ctx_addr_distance * vmid,
+				    lower_32_bits(page_table_base));
+
+		WREG32_SOC15_OFFSET(MMHUB, i,
+				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+				    hub->ctx_addr_distance * vmid,
+				    upper_32_bits(page_table_base));
+	}
 }
 
 static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t pt_base;
+	int i;
 
 	if (adev->gmc.pdb0_bo)
 		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
@@ -76,27 +85,37 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
 	/* If use GART for FB translation, vmid0 page table covers both
 	 * vram and system memory (gart)
 	 */
-	if (adev->gmc.pdb0_bo) {
-		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
-			     (u32)(adev->gmc.fb_start >> 12));
-		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
-			     (u32)(adev->gmc.fb_start >> 44));
-
-		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
-			     (u32)(adev->gmc.gart_end >> 12));
-		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
-			     (u32)(adev->gmc.gart_end >> 44));
-
-	} else {
-		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
-			     (u32)(adev->gmc.gart_start >> 12));
-		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
-			     (u32)(adev->gmc.gart_start >> 44));
-
-		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
-			     (u32)(adev->gmc.gart_end >> 12));
-		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
-			     (u32)(adev->gmc.gart_end >> 44));
+	for (i = 0; i < adev->num_aid; i++) {
+		if (adev->gmc.pdb0_bo) {
+			WREG32_SOC15(MMHUB, i,
+				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				     (u32)(adev->gmc.fb_start >> 12));
+			WREG32_SOC15(MMHUB, i,
+				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				     (u32)(adev->gmc.fb_start >> 44));
+
+			WREG32_SOC15(MMHUB, i,
+				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				     (u32)(adev->gmc.gart_end >> 12));
+			WREG32_SOC15(MMHUB, i,
+				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				     (u32)(adev->gmc.gart_end >> 44));
+
+		} else {
+			WREG32_SOC15(MMHUB, i,
+				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				     (u32)(adev->gmc.gart_start >> 12));
+			WREG32_SOC15(MMHUB, i,
+				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				     (u32)(adev->gmc.gart_start >> 44));
+
+			WREG32_SOC15(MMHUB, i,
+				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				     (u32)(adev->gmc.gart_end >> 12));
+			WREG32_SOC15(MMHUB, i,
+				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				     (u32)(adev->gmc.gart_end >> 44));
+		}
 	}
 }
 
@@ -104,159 +123,202 @@ static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 	uint32_t tmp;
+	int i;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+	for (i = 0; i < adev->num_aid; i++) {
+		/* Program the AGP BAR */
+		WREG32_SOC15(MMHUB, i, regMC_VM_AGP_BASE, 0);
+		WREG32_SOC15(MMHUB, i, regMC_VM_AGP_BOT,
+			     adev->gmc.agp_start >> 24);
+		WREG32_SOC15(MMHUB, i, regMC_VM_AGP_TOP,
+			     adev->gmc.agp_end >> 24);
 
-	/* Program the system aperture low logical page number. */
-	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
+		if (amdgpu_sriov_vf(adev))
+			return;
 
-	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15(MMHUB, i, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
-	/* In the case squeezing vram into GART aperture, we don't use
-	 * FB aperture and AGP aperture. Disable them.
-	 */
-	if (adev->gmc.pdb0_bo) {
-		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
-	}
-	if (amdgpu_sriov_vf(adev))
-		return;
+		WREG32_SOC15(MMHUB, i, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+			max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
-	/* Set default page address. */
-	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
-	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-		     (u32)(value >> 12));
-	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-		     (u32)(value >> 44));
-
-	/* Program "protection fault". */
-	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-		     (u32)(adev->dummy_page_addr >> 12));
-	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-		     (u32)((u64)adev->dummy_page_addr >> 44));
-
-	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL2);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
-			    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
-	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+		/* In the case squeezing vram into GART aperture, we don't use
+		 * FB aperture and AGP aperture. Disable them.
+		 */
+		if (adev->gmc.pdb0_bo) {
+			WREG32_SOC15(MMHUB, i, regMC_VM_AGP_BOT, 0xFFFFFF);
+			WREG32_SOC15(MMHUB, i, regMC_VM_AGP_TOP, 0);
+			WREG32_SOC15(MMHUB, i, regMC_VM_FB_LOCATION_TOP, 0);
+			WREG32_SOC15(MMHUB, i, regMC_VM_FB_LOCATION_BASE,
+				     0x00FFFFFF);
+			WREG32_SOC15(MMHUB, i,
+				     regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+				     0x3FFFFFFF);
+			WREG32_SOC15(MMHUB, i,
+				     regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+		}
+
+		/* Set default page address. */
+		value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
+		WREG32_SOC15(MMHUB, i, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+			     (u32)(value >> 12));
+		WREG32_SOC15(MMHUB, i, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+			     (u32)(value >> 44));
+
+		/* Program "protection fault". */
+		WREG32_SOC15(MMHUB, i,
+			     regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+			     (u32)(adev->dummy_page_addr >> 12));
+		WREG32_SOC15(MMHUB, i,
+			     regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+			     (u32)((u64)adev->dummy_page_addr >> 44));
+
+		tmp = RREG32_SOC15(MMHUB, i, regVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		WREG32_SOC15(MMHUB, i, regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+	}
 }
 
 static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
+	int i;
 
 	/* Setup TLB control */
-	tmp = RREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL);
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
-	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
+	for (i = 0; i < adev->num_aid; i++) {
+		tmp = RREG32_SOC15(MMHUB, i, regMC_VM_MX_L1_TLB_CNTL);
+
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB,
+				    1);
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
+		WREG32_SOC15(MMHUB, i, regMC_VM_MX_L1_TLB_CNTL, tmp);
+	}
 }
 
 static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
+	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
 
 	/* Setup L2 cache */
-	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_CNTL);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 1);
-	/* XXX for emulation, Refer to closed source code.*/
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, L2_PDE0_CACHE_TAG_GENERATION_MODE,
-			    0);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
-	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL, tmp);
-
-	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_CNTL2);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
-	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
-	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL2, tmp);
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
-	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL3, tmp);
-
-	tmp = regVM_L2_CNTL4_DEFAULT;
-	if (adev->gmc.xgmi.connected_to_cpu) {
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
-				    VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
-				    VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
-	} else {
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
-				    VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
-				    VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
-	}
-	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL4, tmp);
+	for (i = 0; i < adev->num_aid; i++) {
+		tmp = RREG32_SOC15(MMHUB, i, regVM_L2_CNTL);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL,
+				    ENABLE_L2_FRAGMENT_PROCESSING, 1);
+		/* XXX for emulation, Refer to closed source code.*/
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL,
+				    L2_PDE0_CACHE_TAG_GENERATION_MODE, 0);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION,
+				    0);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL,
+				    CONTEXT1_IDENTITY_ACCESS_MODE, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL,
+				    IDENTITY_MODE_FRAGMENT_SIZE, 0);
+		WREG32_SOC15(MMHUB, i, regVM_L2_CNTL, tmp);
+
+		tmp = RREG32_SOC15(MMHUB, i, regVM_L2_CNTL2);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS,
+				    1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
+		WREG32_SOC15(MMHUB, i, regVM_L2_CNTL2, tmp);
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
+		WREG32_SOC15(MMHUB, i, regVM_L2_CNTL3, tmp);
+
+		tmp = regVM_L2_CNTL4_DEFAULT;
+		if (adev->gmc.xgmi.connected_to_cpu) {
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+					    VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+					    VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
+		} else {
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+					    VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+					    VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+		}
+		WREG32_SOC15(MMHUB, i, regVM_L2_CNTL4, tmp);
+ 	}
 }
 
 static void mmhub_v1_8_enable_system_domain(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
+	int i;
 
-	tmp = RREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_CNTL);
-	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
-	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
-			adev->gmc.vmid0_page_table_depth);
-	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_BLOCK_SIZE,
-			adev->gmc.vmid0_page_table_block_size);
-	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL,
-			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
-	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_CNTL, tmp);
+	for (i = 0; i < adev->num_aid; i++) {
+		tmp = RREG32_SOC15(MMHUB, i, regVM_CONTEXT0_CNTL);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
+				adev->gmc.vmid0_page_table_depth);
+		tmp = REG_SET_FIELD(tmp,
+				    VM_CONTEXT0_CNTL, PAGE_TABLE_BLOCK_SIZE,
+				    adev->gmc.vmid0_page_table_block_size);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL,
+				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
+		WREG32_SOC15(MMHUB, i, regVM_CONTEXT0_CNTL, tmp);
+	}
 }
 
 static void mmhub_v1_8_disable_identity_aperture(struct amdgpu_device *adev)
 {
+	int i;
+
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32, 0xFFFFFFFF);
-	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32, 0x0000000F);
-
-	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32, 0);
-	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32, 0);
-
-	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
-	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
+	for (i = 0; i < adev->num_aid; i++) {
+		WREG32_SOC15(MMHUB, i,
+			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
+			     0XFFFFFFFF);
+		WREG32_SOC15(MMHUB, i,
+			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
+			     0x0000000F);
+
+		WREG32_SOC15(MMHUB, i,
+			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
+			     0);
+		WREG32_SOC15(MMHUB, i,
+			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
+			     0);
+
+		WREG32_SOC15(MMHUB, i,
+			     regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
+		WREG32_SOC15(MMHUB, i,
+			     regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
+	}
 }
 
 static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
+	struct amdgpu_vmhub *hub;
 	unsigned num_level, block_size;
 	uint32_t tmp;
-	int i;
+	int i, j;
 
 	num_level = adev->vm_manager.num_level;
 	block_size = adev->vm_manager.block_size;
@@ -265,60 +327,73 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 	else
 		block_size -= 9;
 
-	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
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
-		/* On 9.4.3, XNACK can be enabled in the SQ per-process.
-		 * Retry faults need to be enabled for that to work.
-		 */
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    1);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
-				    i * hub->ctx_addr_distance, 0);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
-				    i * hub->ctx_addr_distance, 0);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
-				    i * hub->ctx_addr_distance,
-				    lower_32_bits(adev->vm_manager.max_pfn - 1));
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
-				    i * hub->ctx_addr_distance,
-				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+	for (j = 0; j < adev->num_aid; j++) {
+		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
+		for (i = 0; i <= 14; i++) {
+			tmp = RREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
+						  i);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    ENABLE_CONTEXT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    PAGE_TABLE_DEPTH, num_level);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+					    PAGE_TABLE_BLOCK_SIZE,
+					    block_size);
+			/* On 9.4.3, XNACK can be enabled in the SQ
+			 * per-process. Retry faults need to be enabled for
+			 * that to work.
+			 */
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 1);
+			WREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
+					    i * hub->ctx_distance, tmp);
+			WREG32_SOC15_OFFSET(MMHUB, j,
+				regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				i * hub->ctx_addr_distance, 0);
+			WREG32_SOC15_OFFSET(MMHUB, j,
+				regVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				i * hub->ctx_addr_distance, 0);
+			WREG32_SOC15_OFFSET(MMHUB, j,
+				regVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				i * hub->ctx_addr_distance,
+				lower_32_bits(adev->vm_manager.max_pfn - 1));
+			WREG32_SOC15_OFFSET(MMHUB, j,
+				regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				i * hub->ctx_addr_distance,
+				upper_32_bits(adev->vm_manager.max_pfn - 1));
+		}
 	}
 }
 
 static void mmhub_v1_8_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
-	unsigned i;
-
-	for (i = 0; i < 18; ++i) {
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
-				    i * hub->eng_addr_distance, 0xffffffff);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
-				    i * hub->eng_addr_distance, 0x1f);
+	struct amdgpu_vmhub *hub;
+	unsigned i, j;
+
+	for (j = 0; j < adev->num_aid; j++) {
+		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
+		for (i = 0; i < 18; ++i) {
+			WREG32_SOC15_OFFSET(MMHUB, j,
+					regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+					i * hub->eng_addr_distance, 0xffffffff);
+			WREG32_SOC15_OFFSET(MMHUB, j,
+					regVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+					i * hub->eng_addr_distance, 0x1f);
+		}
 	}
 }
 
@@ -352,28 +427,33 @@ static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v1_8_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
+	struct amdgpu_vmhub *hub;
 	u32 tmp;
-	u32 i;
+	u32 i, j;
 
 	/* Disable all tables */
-	for (i = 0; i < 16; i++)
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_CNTL,
-				    i * hub->ctx_distance, 0);
-
-	/* Setup TLB control */
-	tmp = RREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
-			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
-	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
-
-	if (!amdgpu_sriov_vf(adev)) {
-		/* Setup L2 cache */
-		tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_CNTL);
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
-		WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL, tmp);
-		WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL3, 0);
+	for (j = 0; j < adev->num_aid; j++) {
+		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
+		for (i = 0; i < 16; i++)
+			WREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT0_CNTL,
+					    i * hub->ctx_distance, 0);
+
+		/* Setup TLB control */
+		tmp = RREG32_SOC15(MMHUB, j, regMC_VM_MX_L1_TLB_CNTL);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB,
+				    0);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_ADVANCED_DRIVER_MODEL, 0);
+		WREG32_SOC15(MMHUB, j, regMC_VM_MX_L1_TLB_CNTL, tmp);
+
+		if (!amdgpu_sriov_vf(adev)) {
+			/* Setup L2 cache */
+			tmp = RREG32_SOC15(MMHUB, j, regVM_L2_CNTL);
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE,
+					    0);
+			WREG32_SOC15(MMHUB, j, regVM_L2_CNTL, tmp);
+			WREG32_SOC15(MMHUB, j, regVM_L2_CNTL3, 0);
+		}
 	}
 }
 
@@ -386,72 +466,79 @@ static void mmhub_v1_8_gart_disable(struct amdgpu_device *adev)
 static void mmhub_v1_8_set_fault_enable_default(struct amdgpu_device *adev, bool value)
 {
 	u32 tmp;
+	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
-			    value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-	if (!value) {
+	for (i = 0; i < adev->num_aid; i++) {
+		tmp = RREG32_SOC15(MMHUB, i, regVM_L2_PROTECTION_FAULT_CNTL);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-				    CRASH_ON_NO_RETRY_FAULT, 1);
+				PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
-				    CRASH_ON_RETRY_FAULT, 1);
+				PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
+			value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		if (!value) {
+			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+					    CRASH_ON_NO_RETRY_FAULT, 1);
+			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+					    CRASH_ON_RETRY_FAULT, 1);
+		}
+
+		WREG32_SOC15(MMHUB, i, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
 	}
-
-	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
 static void mmhub_v1_8_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
-
-	hub->ctx0_ptb_addr_lo32 =
-		SOC15_REG_OFFSET(MMHUB, 0,
-				 regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
-	hub->ctx0_ptb_addr_hi32 =
-		SOC15_REG_OFFSET(MMHUB, 0,
-				 regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
-	hub->vm_inv_eng0_req =
-		SOC15_REG_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_REQ);
-	hub->vm_inv_eng0_ack =
-		SOC15_REG_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ACK);
-	hub->vm_context0_cntl =
-		SOC15_REG_OFFSET(MMHUB, 0, regVM_CONTEXT0_CNTL);
-	hub->vm_l2_pro_fault_status =
-		SOC15_REG_OFFSET(MMHUB, 0, regVM_L2_PROTECTION_FAULT_STATUS);
-	hub->vm_l2_pro_fault_cntl =
-		SOC15_REG_OFFSET(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL);
-
-	hub->ctx_distance = regVM_CONTEXT1_CNTL - regVM_CONTEXT0_CNTL;
-	hub->ctx_addr_distance = regVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
-		regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
-	hub->eng_distance = regVM_INVALIDATE_ENG1_REQ - regVM_INVALIDATE_ENG0_REQ;
-	hub->eng_addr_distance = regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
-		regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+	struct amdgpu_vmhub *hub;
+	int i;
 
+	for (i = 0; i < adev->num_aid; i++) {
+		hub = &adev->vmhub[AMDGPU_MMHUB0(i)];
+
+		hub->ctx0_ptb_addr_lo32 = SOC15_REG_OFFSET(MMHUB, 0,
+			regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
+		hub->ctx0_ptb_addr_hi32 = SOC15_REG_OFFSET(MMHUB, 0,
+			regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+		hub->vm_inv_eng0_req =
+			SOC15_REG_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_REQ);
+		hub->vm_inv_eng0_ack =
+			SOC15_REG_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ACK);
+		hub->vm_context0_cntl =
+			SOC15_REG_OFFSET(MMHUB, 0, regVM_CONTEXT0_CNTL);
+		hub->vm_l2_pro_fault_status = SOC15_REG_OFFSET(MMHUB, 0,
+			regVM_L2_PROTECTION_FAULT_STATUS);
+		hub->vm_l2_pro_fault_cntl = SOC15_REG_OFFSET(MMHUB, 0,
+			regVM_L2_PROTECTION_FAULT_CNTL);
+
+		hub->ctx_distance = regVM_CONTEXT1_CNTL - regVM_CONTEXT0_CNTL;
+		hub->ctx_addr_distance =
+			regVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+			regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+		hub->eng_distance = regVM_INVALIDATE_ENG1_REQ -
+			regVM_INVALIDATE_ENG0_REQ;
+		hub->eng_addr_distance = regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+			regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+	}
 }
 
 static int mmhub_v1_8_set_clockgating(struct amdgpu_device *adev,
-- 
2.39.2


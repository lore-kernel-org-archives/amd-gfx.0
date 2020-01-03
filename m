Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7149C2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A63920672
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YtfsxVLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A63920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 424846E1B2;
	Fri,  3 Jan 2020 09:57:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B0C86E1B2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 09:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJi5rE4a81YPoVcjIW9ynQhe6cNLo8/wmuVoq8dtZcOnbYo7RDdADjupcillhJYnA5BgaQnfVGe3vW2E5XtpZULfHQy8OKFFHMfNGOWfuP6hPHfZ1FXTDeHFGv2Y6UFLAusoyJ92hEe+vysXPBObmPHmY26/aso6hEFyDfhRMjKP6lYMTNWcV5CeRl7MaI40xFjHx93Yvb9K0xX1YGsWYY4bUCf+9tWIphRsZ/WTrSf6XJZsi5PZitOB7eE50rJ8iPxY46VJiuHBYoxKAggEZzifQrxhDIo5xqPCiWzfeyj1oOf+KjKNSxeNKvLMfWX08H2SnUSwzlM+/o35+vFJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3ZX5rOUOTUI3DPO2StakEHXHmAABYnC/EGdWevEnUM=;
 b=h032P45yGp+ytPL5DaIjBTX8IOvPJDvov3JulxImPh2MkYnUSxcHRSYJOtIoNvf6XEFMxNiQLp6y8U+mt6bNBh4XdlK6H4DlTC5jILMfsXo/GilzVzqdUdw6Q8YVXPVQqBlZyUED8e9yJ69J+fvndNRJP+fHP48nAwHLDs1qDtcAe2S6deVSqLI4GltJMh4fjVZhcrPUVW7rKn9S3sa14gMWzeOdka36KEZaI5FZilHyV5Hcw+iz/Sk4eK2NjaTPoJPCmLlZt2SIa/zYbWbbCYZ33ovBkH6SnASksQ6Be8I+U8vdcaQ9ruuxAE/MYo6gCKixIiGxXISIW/HT5Ay8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3ZX5rOUOTUI3DPO2StakEHXHmAABYnC/EGdWevEnUM=;
 b=YtfsxVLSJtnsPRAZ/QPB/w6I05O5tmqnZXHwDmKU0vy2Ip6GaNODyhmpN2KTlhUMuRkSHvi9vKK6R09b8iJKnjAHMR+N1qOJrLhNYMJL1OQFoCxCzxewPFiorifkxWkQ9pZsW1sb7t+/KRbnCQ9cnQpwxy9A6tegqP5j05g7E5c=
Received: from DM6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:5:1c0::38)
 by MN2PR12MB3920.namprd12.prod.outlook.com (2603:10b6:208:168::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Fri, 3 Jan
 2020 09:57:33 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM6PR12CA0025.outlook.office365.com
 (2603:10b6:5:1c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend
 Transport; Fri, 3 Jan 2020 09:57:33 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Fri, 3 Jan 2020 09:57:33 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 03:57:32 -0600
Received: from guest.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 3 Jan 2020 03:57:25 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Leo.Liu@amd.com>
Subject: [PATCH 2/5] drm/amd/amdgpu: L1 Policy(2/5) - removed GC GRBM
 violations from gfxhub
Date: Fri, 3 Jan 2020 17:56:46 +0800
Message-ID: <20200103095649.5068-2-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103095649.5068-1-Jane.Jian@amd.com>
References: <20200103095649.5068-1-Jane.Jian@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(428003)(199004)(189003)(336012)(86362001)(426003)(26005)(6666004)(356004)(478600001)(2616005)(6636002)(7696005)(1076003)(4326008)(186003)(110136005)(316002)(70206006)(70586007)(81156014)(81166006)(54906003)(8936002)(36756003)(5660300002)(8676002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3920; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ccc7619-6707-4687-7f0c-08d790335a9f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3920:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39200020F856D7D793AA0F9DFF230@MN2PR12MB3920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0271483E06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sh5D2u9oFBEqE1NeTr6u4MpK61Zs2Eitptu60lwhs0XyJ9Mex1A7BOffN1RQDH701ps/oxTI+3pHdbVzf8OD5l4MzTFtZ1hrLn/ajxLuDmsaQ8NlZTdGkbIdmjfgGOxUW7P1FWhSfa0jIWApgERKagrkA1O5252ibs10c1RNC4CNqV5BOYB/NLLBQ6Qf2FandhQT38T4OZro2g4nKuajm404O7JFeYthsrHy6SaXqgmlaKllZ0exvUGwHI1dYVeBYTt8a4b1dTzIgq+QtflpgpqW37zVvomJLMUjHubNBES1uSFrtWm5WdDJC+S1mH1+XOegEmfhkoUpigdlVEQSC7w1tpW8MD4FENHxBMlTWcl22p7zIpIKi5Lu7ZWN2pVFIsVv94OHnEFtPm0NaSzhjZ98xRHDREiyYloL95WJ99TGiGtW7JFJo+hkEGAN/Iaz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 09:57:33.3507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccc7619-6707-4687-7f0c-08d790335a9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3920
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
Cc: Zhigang Luo <zhigang.luo@amd.com>, Jane Jian <jane.jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhigang Luo <zhigang.luo@amd.com>

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Jane Jian <jane.jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 79 +++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  2 +-
 2 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index e9a9d24c2b7f..1a2f18b908fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -75,40 +75,45 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
 	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
-	/* Program the system aperture low logical page number. */
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-
-	if (adev->asic_type == CHIP_RAVEN && adev->rev_id >= 0x8)
-		/*
-		 * Raven2 has a HW issue that it is unable to use the vram which
-		 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
-		 * workaround that increase system aperture high address (add 1)
-		 * to get rid of the VM fault and hardware hang.
-		 */
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-			     max((adev->gmc.fb_end >> 18) + 0x1,
-				 adev->gmc.agp_end >> 18));
-	else
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-			     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
-
-	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
-	WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-		     (u32)(value >> 12));
-	WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-		     (u32)(value >> 44));
-
-	/* Program "protection fault". */
-	WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-		     (u32)(adev->dummy_page_addr >> 12));
-	WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-		     (u32)((u64)adev->dummy_page_addr >> 44));
-
-	WREG32_FIELD15(GC, 0, VM_L2_PROTECTION_FAULT_CNTL2,
-		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
+
+		if (adev->asic_type == CHIP_RAVEN && adev->rev_id >= 0x8)
+			/*
+			* Raven2 has a HW issue that it is unable to use the
+			* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
+			* So here is the workaround that increase system
+			* aperture high address (add 1) to get rid of the VM
+			* fault and hardware hang.
+			*/
+			WREG32_SOC15_RLC(GC, 0,
+					 mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+					 max((adev->gmc.fb_end >> 18) + 0x1,
+					     adev->gmc.agp_end >> 18));
+		else
+			WREG32_SOC15_RLC(
+				GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+				max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
+
+		/* Set default page address. */
+		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
+			adev->vm_manager.vram_base_offset;
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+			     (u32)(value >> 12));
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+			     (u32)(value >> 44));
+
+		/* Program "protection fault". */
+		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+			     (u32)(adev->dummy_page_addr >> 12));
+		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+			     (u32)((u64)adev->dummy_page_addr >> 44));
+
+		WREG32_FIELD15(GC, 0, VM_L2_PROTECTION_FAULT_CNTL2,
+			       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	}
 }
 
 static void gfxhub_v1_0_init_tlb_regs(struct amdgpu_device *adev)
@@ -280,10 +285,12 @@ int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
 	gfxhub_v1_0_init_gart_aperture_regs(adev);
 	gfxhub_v1_0_init_system_aperture_regs(adev);
 	gfxhub_v1_0_init_tlb_regs(adev);
-	gfxhub_v1_0_init_cache_regs(adev);
+	if (!amdgpu_sriov_vf(adev))
+		gfxhub_v1_0_init_cache_regs(adev);
 
 	gfxhub_v1_0_enable_system_domain(adev);
-	gfxhub_v1_0_disable_identity_aperture(adev);
+	if (!amdgpu_sriov_vf(adev))
+		gfxhub_v1_0_disable_identity_aperture(adev);
 	gfxhub_v1_0_setup_vmid_config(adev);
 	gfxhub_v1_0_program_invalidation(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4f72626fbce9..2f4a013b3344 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1307,8 +1307,8 @@ static int gmc_v9_0_hw_init(void *handle)
 	else
 		value = true;
 
-	gfxhub_v1_0_set_fault_enable_default(adev, value);
 	if (!amdgpu_sriov_vf(adev)) {
+		gfxhub_v1_0_set_fault_enable_default(adev, value);
 		if (adev->asic_type == CHIP_ARCTURUS)
 			mmhub_v9_4_set_fault_enable_default(adev, value);
 		else
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

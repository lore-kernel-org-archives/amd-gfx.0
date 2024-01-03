Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0AFC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 21:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DD710E348;
	Wed,  3 Jan 2024 21:55:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A8F10E34C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 21:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4EOmyONrp0wT1BEG/MVpNyrI/5ITlTMbNnxmoIILDoDNnPiLZKVvp9/Tua1VuSWqk1AmrBEznJWKRyt23KMeKQciXr3HqcqVIFb8mwr+wUncoi9LhHJ79v0TmjfLq7ewGml5Ho6/A/xhiKEE45lro7JwyMqDtJtc0FZjYmg4/5zBeShkZZL+BWIjWTqbOfUui0kmt4Vlfmescq5ybo9G/pAuxJOKGI0Qmy00JFs7ceJJJ0CRBp1FOjQMu6BI6Iv8PwxEJBd4v337tz5rE8uBmwspP6NGM0oOpWkwwdFoeEmBqcPp59FWWTcY8yDmbzGt+egUEN249Fi2BYyMYAj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0T1+wHOh4YPlHiUtHD0PSeh+P106Wmgb7f5mTw+Ii0=;
 b=cVNoRl2ozgtTVrAplLIvimX756ojO56yvjggINc9Ci462X1enOH36Z5bMO9Vz/ydhV5K1DlkSqetT96LRq0j31HCfv07KSXa/pjNsCyGkX/cwK8eqmRXOBYT8yP4heV8hgV/KhNDobK38K0/SJIhrb3Sd5eRNhrLmQUU7Kfpi5Kmx4WzwnQVx8Ab0uTfQxaAuzfVxrmbLASQZU8v8kx106UleE2iuUhzfE0ZdB+v4O2278jXU0o4hfuNi2yLN+eeSjOZfRvhND+cCCFuWS9bT8cdxv0Iwd/+9HSokznHm2WhdQs8TWdYRvmXAOQdIPbQLWZH0soWBWAGSuPjiKmcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0T1+wHOh4YPlHiUtHD0PSeh+P106Wmgb7f5mTw+Ii0=;
 b=bAdRnm2fejzag6RDatM1rFGYUM95PA+q/iCDH06eaBhue5ObzGZAXAcnRMk5d94Cyyf6F6bTpWWcOlewoNsrAQwAJEP6/k95KcKxGtnredZNek8+457KZlTVNd5LWdHGnAHzn8hEJRTwMJ/Sxwf1J2bNs5OKt2oCT+WkmE5D6oc=
Received: from MN2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:208:e8::15)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Wed, 3 Jan
 2024 21:55:14 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::bd) by MN2PR20CA0002.outlook.office365.com
 (2603:10b6:208:e8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27 via Frontend
 Transport; Wed, 3 Jan 2024 21:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 21:55:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 15:55:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: apply the RV2 system aperture fix to RN/CZN as
 well
Date: Wed, 3 Jan 2024 16:54:56 -0500
Message-ID: <20240103215457.1780357-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fea2b8-fad5-43ed-898d-08dc0ca6aa21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PeAptfIc+6nrxN7A5EQnocVgc9WzRZMMtbslz7RKVs/I8hslyGOjv4MWehrF3N4ImBwre1wZZpZSigWxf7FIOttboF39Q9enQjk8i4HdUsCuDV2uMZ5Zvq4TNK3OY6KyKrIDHumqgONhFxTf8PbGnqkhGJ6sdhxt4Qh5Add5P1v54apcIom6biW4iD4u75MnpfithDff1cphfLtHhbelhHnbbmoVre9YWcm4FmvC49K0gRSW8RJx6+41Bdd9qFaj55hz7FNIXxO0qXlw5wQy6Pkqth3MO/ohHCIBbbMYoZlHWLMAPuqz4h5TPUsAbFhwubTrbC57XFin1cFFpwtyNCrzbGNK0+zcS95IG0Q8hdjBG4luDwtKdA2f1iFt8GOU7gQp7NHiFfqfuwifEYHhxGx8XVJp3LaJiI0GA/AYuZqcfdJVuPdGHm4JUUf9ig79dliKQ/GG2j5mfobgpDUdDt2iOzbDQpe8wsL7KVP2E89IaDmFueqK4Q2r9doiwKzQkfSMhBhitYdQnapQkBmDiMb3F02UxWrQOFr9ppK7G3LD5gMR9aJBeGLYzKtAuao77ZIX+LRa7XuYMUb1Uw/Ybu1UwV0V6kXVdE2m2Fqa2xC9r4RyvkmuSRYGv0aiNt/Gj6aaNQuCodpgNI4PYGFe/V1Kl5Uy8laIydeSSBKNVD48PHmA8cjeqZJRQN8mFXt9pt9X9i7gqKOZyRNT54hIUzlJGR3iKgd+e1q88tmv/bfKyxEyrstbjFPSOWFMqpaJzJYfHtDD9ZCRRsLG1FSdLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36840700001)(40470700004)(46966006)(478600001)(47076005)(86362001)(426003)(336012)(16526019)(83380400001)(6916009)(70206006)(41300700001)(70586007)(26005)(36756003)(1076003)(82740400003)(8936002)(36860700001)(2616005)(4326008)(8676002)(356005)(5660300002)(316002)(81166007)(2906002)(40460700003)(40480700001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 21:55:13.7415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fea2b8-fad5-43ed-898d-08dc0ca6aa21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These chips needs the same fix.  This was previously not seen
on then since the AGP aperture expanded the system aperture,
but this showed up again when AGP was disabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c          | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c          | 4 +++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c           | 4 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 53a2ba5fcf4b..22175da0e16a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -102,7 +102,9 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
-		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+		if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+				       AMD_APU_IS_RENOIR |
+				       AMD_APU_IS_GREEN_SARDINE))
 		       /*
 			* Raven2 has a HW issue that it is unable to use the
 			* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 55423ff1bb49..95d06da544e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -139,7 +139,9 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
 			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 				min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
-			if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+			if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+					       AMD_APU_IS_RENOIR |
+					       AMD_APU_IS_GREEN_SARDINE))
 			       /*
 				* Raven2 has a HW issue that it is unable to use the
 				* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 843219a91736..e3ddd22aa172 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -96,7 +96,9 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
-	if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+	if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+			       AMD_APU_IS_RENOIR |
+			       AMD_APU_IS_GREEN_SARDINE))
 		/*
 		 * Raven2 has a HW issue that it is unable to use the vram which
 		 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5a7ac1c35b58..0c35e4122612 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1294,7 +1294,9 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	/* AGP aperture is disabled */
 	if (agp_bot > agp_top) {
 		logical_addr_low = adev->gmc.fb_start >> 18;
-		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+		if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+				       AMD_APU_IS_RENOIR |
+				       AMD_APU_IS_GREEN_SARDINE))
 			/*
 			 * Raven2 has a HW issue that it is unable to use the vram which
 			 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
@@ -1306,7 +1308,9 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 			logical_addr_high = adev->gmc.fb_end >> 18;
 	} else {
 		logical_addr_low = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
-		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+		if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+				       AMD_APU_IS_RENOIR |
+				       AMD_APU_IS_GREEN_SARDINE))
 			/*
 			 * Raven2 has a HW issue that it is unable to use the vram which
 			 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
-- 
2.42.0


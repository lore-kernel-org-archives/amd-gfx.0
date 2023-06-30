Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1785BEB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 11:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DCD010E458;
	Fri, 30 Jun 2023 11:56:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381CE10E15A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 11:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW6GoHaZ7XdX04B7hSL0oVgX86TuDzUuiUs16tofiV+/MUavHRuhAdgjASb3S8pJcFukI+FJZCnHufhUDIVk9XcDbHUuOMbCxlFrxEJkmVqaKM0o6aldZG07eBxe9x1EQsJjh0oiy46eP+3PRRfw4CHev0AGC3NWSvP8JDm2CdTdfXWb71uXvPTqTp9up4PBpEc6hkKAnvxK4AJmoT6aPBjtS7PcUJXx+hl3d5B5dmXYIhrkvogkTnGReWgROfoyxSTULQKlg40wa6um+kmI6CD7zRlQe2vAaiQLDkjJY7vFbej23lF6G5zEZfKtJt0Dn60ddu4sGZIEwXqU423i2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygaUBJlxHGPmXINQLBCHRJKwNCwgDVu17Hp/Sh8/p9s=;
 b=gHQOILLCxNeRxC/OxeXIUAKaZ4sTswypFmimGaOKFSAXN+UzAx/IuEfKeGwRSxwdS4OCdi7H++coS5Vfwl8FGgb3WabCa+abF0xi0Yrwy8oKcgRf+HXkt4iEtSyuaQJccg5b8NVlnl5rcG+MFufw2shSOEOCAx0K4b0KcLmGFWEInd9bBE2A5gykefeBuTo2ow4HqBRZ2PXVijm79giAZHN+iLQb/CVysk5G2dtFOZe1HvCH3yFWfwUg5zY6BnEwz4UHm/A8zB/ugRmevpWk9cJfhnbd3KU1kYhwLWb8jFouD81Oq4yVeQ4Jf8+gKrChEcc5V0cYMFoVngchRjO8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygaUBJlxHGPmXINQLBCHRJKwNCwgDVu17Hp/Sh8/p9s=;
 b=IImpnpbh8HmFA4uYWKBZLiv3mj2l+JzNh82gZGUPrUKt3r+Iw7tVyoBWP0gQpSxhZrOcb+f6269Fn0MM1xH9Z6/H1wgzwlZPU3rXMbbX61XJkf/fGX1wby0WIj1RNL695wOySvDtkB/jPq9Urh8bbhXcGdYtZhQdGhdDBNNAjTY=
Received: from BN6PR17CA0038.namprd17.prod.outlook.com (2603:10b6:405:75::27)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 11:56:36 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::ef) by BN6PR17CA0038.outlook.office365.com
 (2603:10b6:405:75::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 11:56:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 30 Jun 2023 11:56:36 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 06:56:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: Fix warnings in gfxhub_ v1_0, v1_2.c
Date: Fri, 30 Jun 2023 17:26:13 +0530
Message-ID: <20230630115618.2855618-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
References: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 1180664f-9c7d-4824-ffe2-08db79610e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13ykzVbp8ERA4PFQURCRC09RZBz7Z9ISg+vVMo6uXcPGO+nCD97Sw/2H6VpRVs0sEn8kTDOLKnnT4QIqaE8zDImX88bdqjphYDZjv9fms8p6OIJMm7itiJQmqmwq2MVMADB+Z/I3wAfoAIqUPE91aaeknTTgjVureF7vPoh8ZAMidV1miOZHKpW4EzBTLyfNdtOLJ2okEEiGxlUiC9IKDmugomkqY5oYdomxGGaaexRvRsuNoL/M1m2MBdaQ/M31opXUDtIfuyUxLHzr3OOsnmQP0rCvUODBl9ctgQnezAKwPx084UXlJIY5bXDWY2OlBUW16FkQsffnWvGaw04sHQZRQ1sdCWFr3t8odeaoZNbR9UQqu3hRI/pEki1Le4ClMIHNE5snYzdn0/ZWlXODNnuNqxXn+xp/PldONInWcW+9kMiG6bus8J3AbzHNcwkg88/TxOvFzwOM3wKfkMrZmJlPGoEZuxk0WyLMzg7+mqJzzT2BbETGtUlJ5EvXLOwZ3y46M6H4jncdsP7myZLTvafgDivba2Pgf/2S2qMMal932cD8pc8kHzSLJ/98tQKTEryJp2x/H5Qc2742SznpYwVLlOl9aBu9hUO40JvQLNyRb/+UZDrAXgiOvMrjdDitxoq945S5LoGYUnFhNG4CU+GIgqMESI1zLpNYMyoEyAsIK8Kw0fZHgX8jYYNkxjkR4LWW0VllMPpdU1PoJx0IX6kFYS/T4fMAe66pbYzyvQylVEPLdIB/vRP28ppCfkcguQqEs41gZ2+d5IaNdu7emA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(54906003)(478600001)(110136005)(6666004)(7696005)(66574015)(83380400001)(47076005)(2616005)(40480700001)(36860700001)(336012)(82740400003)(86362001)(426003)(40460700003)(16526019)(82310400005)(70586007)(1076003)(26005)(186003)(2906002)(81166007)(6636002)(8936002)(36756003)(4326008)(5660300002)(70206006)(316002)(41300700001)(44832011)(356005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:56:36.4974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1180664f-9c7d-4824-ffe2-08db79610e84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the below checkpatch warnings:

WARNING: Block comments should align the * on each line
+                       /*
+                       * Raven2 has a HW issue that it is unable to use the

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+       unsigned num_level, block_size;

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+       unsigned i;

WARNING: Missing a blank line after declarations
+       u32 tmp;
+       tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL);

WARNING: Block comments should align the * on each line
+                               /*
+                               * Raven2 has a HW issue that it is unable to use the

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+       unsigned num_level, block_size;

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index d94cc1ec7242..cdc290a474a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -103,7 +103,7 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
-			/*
+		       /*
 			* Raven2 has a HW issue that it is unable to use the
 			* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
 			* So here is the workaround that increase system
@@ -248,7 +248,7 @@ static void gfxhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
 static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	unsigned num_level, block_size;
+	unsigned int num_level, block_size;
 	uint32_t tmp;
 	int i;
 
@@ -308,7 +308,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0 ; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(GC, 0, mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
@@ -375,6 +375,7 @@ static void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
 						 bool value)
 {
 	u32 tmp;
+
 	tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL);
 	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
 			RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 4dabf910334b..47f95ec218a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -140,7 +140,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
 				min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
 			if (adev->apu_flags & AMD_APU_IS_RAVEN2)
-				/*
+			       /*
 				* Raven2 has a HW issue that it is unable to use the
 				* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
 				* So here is the workaround that increase system
@@ -315,7 +315,7 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					      uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub;
-	unsigned num_level, block_size;
+	unsigned int num_level, block_size;
 	uint32_t tmp;
 	int i, j;
 
-- 
2.25.1


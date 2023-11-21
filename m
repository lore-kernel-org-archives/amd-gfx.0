Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DBBC61D90
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 18:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE67010E572;
	Tue, 21 Nov 2023 18:59:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDCF10E572
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 18:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHAemoM4K65CeGT+J2Ez33QGDAHRCmL9cPRGr6SpJzLkuVLTz3ObFoWzNJR7jU3EhCO5mCbfbGS7XS22lAQ6cHXOF9vTXjddDkGOF4QwLmA5WBT2C3C2wlADfldFvPw50TlfjQKk/4An7xSborTSUZhsaEBkTOowrfDo1Vr2R+2AmE9MZIXXFZqbESzB0NQ/bzTyEPi2ZIa88n+TpLlPIZ8zehaUA8cBPGesoCK+GvPKazbG4aaxPgzQ5B5OIuHkFJYkEmYBUhz8IlxIhniouPZMGQiT0ukfR4vuCfKLetIKx3DIOR+yGXD19efLrx4kWqviYMDdAdsjPO4kk1dKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y18OoUdXnmeZI+FV5bNtUmCKDv4LdBQ0q3WNg/rX3HE=;
 b=gJ+WjrpFzpDeex0iFelPXezroHwwaiG0HSgOaWzb4+Gy6swm4FmPDOXKYEHGIjP1eYHsvFEvqg7/h9ffZsL6rW0gmZMyDYK0DdH4dIQYtMOXZRkk328xD4PCihr4KknfzxfBnOo+DFfR/ZrEYri30vhWQMzDEx6PJQqHPDq4xY81R5oPPIoXT9oqbUoUMF0160Hj+l7Ldk6FwQue9Z4DVhXlpWuzHDGpiAtoGhjgis8RP0H771LPZLOqJ2qk2heaMz+f3hxjRpHkLsMdI3wtFDnkPbwdKLnCsUKpwG7SVOKSvdGtpG9jnW/x68dQNWD9PxYHj0CYdG8TSGIh7mbEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y18OoUdXnmeZI+FV5bNtUmCKDv4LdBQ0q3WNg/rX3HE=;
 b=SygkQrMTTJPlYaWodAjs6qKyb4uyee/NAbhZQKSFZnvRYeFQCa+73/C6Si5eqGODkTfcncKC5TpwYjJup8kBmPqhjmV4STrL9HPzUnLVtH2S3KtkuxL4lF5JAtceDo4NDi/piaB6PFQ7Ji1HjMTxIkXruoh9/UfbnljxKXYn5t0=
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 18:59:40 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::5b) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 18:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 18:59:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 12:59:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/radeon: Fix eDP for single-display iMac11,1
Date: Tue, 21 Nov 2023 13:59:25 -0500
Message-ID: <20231121185925.581282-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|BL0PR12MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e31d18-c870-47bb-9827-08dbeac403ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZJZhuWbM0zjVOuR00Mb+LI36v4lFCFJwdykEYizOgZ1o+GFtIRgcjYXAoGzkzoz4HPJVakdPP9UI+w49ut+vjFGako+FmEC38zfWbAcDhA6t9NKkDRXEdZhDOBprg3k/SRRIQQ/mJOVEXcy3gwbdRJUp+/u9/350sLW21vchanJ5qaZmw7u/VPkQm28vYaISSz/3ct5o4nJsQXdA70rz3mJrUWQme5N5YNPs3t5PFb54FeWeKiHeexvHbriLvO6nR6zUPW9ZmsxZ/g9gd5FSClIVw9v3Qzt3NxbC2Ylvlm3IU2F9vTCM+ajgqrU6C5qLaBfjF+DUGKCfiUdUXnGIY6L5nEfmGvvMbrmp5/ijUDn2OIBp7jqaqDwizrBligSTSP/JgWs5a1Z8zsDW8GHLkCswGrQZeEwVuTjd1bUSUUHBPYPuKFbauLrJR514FKj43d/hFeTYSe7d9G3xLIiJWf6qgkVMfBLNoP6pXP9wx0mlxXUKsjMLc7U92Rmiwn52i/XXbxkAOE/gMIbZ2kpf3uFcszzWr5tseqGpL4bwWhXjR8IoaHHpMsbxSjzhM+ph+oenriAVQWywdf+dB3D3LT7QakHliNEiniPiG/cvxK/ginzXcsKyW6xFYt5npENXgbEeS4zVkhFLHSHSbO0ygmDWM7hgea9rM19+8U/L9ooOY8u/vMPU5FgB0+gRCz8I6G13+XRLG+XcXSEvRvEJkmTaMgkf5HjJmozYPIC5rvcTdkHQvOAJYvxz+efqwka
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(4326008)(8936002)(8676002)(36860700001)(40460700003)(82740400003)(86362001)(36756003)(41300700001)(81166007)(356005)(54906003)(70586007)(70206006)(478600001)(316002)(40480700001)(1076003)(426003)(336012)(26005)(2616005)(16526019)(6916009)(966005)(83380400001)(47076005)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 18:59:39.7092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e31d18-c870-47bb-9827-08dbeac403ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Gilles Risch <gilles.risch@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gilles Risch <gilles.risch@gmail.com>

The Apple iMac11,1 (late 2009) has an integrated ATI Mobility Radeon HD 4850.
This machine suffers from a similar problem as the iMac10,1 (late 2009) and
the iMac11,2 (mid 2010). This small patch fixes the issue on this machine.

Fixes freedesktop issue 164
Link: https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/164

Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/atombios_crtc.c     | 4 ++--
 drivers/gpu/drm/radeon/atombios_encoders.c | 9 +++++----
 drivers/gpu/drm/radeon/radeon.h            | 1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index ade13173921b..b530153aeae9 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -580,7 +580,7 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 			radeon_crtc->pll_flags |= (/*RADEON_PLL_USE_FRAC_FB_DIV |*/
 				RADEON_PLL_PREFER_CLOSEST_LOWER);
 
-		if (ASIC_IS_DCE32(rdev) && mode->clock > 200000)	/* range limits??? */
+		if (ASIC_IS_DCE31(rdev) && mode->clock > 200000)	/* range limits??? */
 			radeon_crtc->pll_flags |= RADEON_PLL_PREFER_HIGH_FB_DIV;
 		else
 			radeon_crtc->pll_flags |= RADEON_PLL_PREFER_LOW_REF_DIV;
@@ -594,7 +594,7 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 		if (((rdev->family == CHIP_RS780) || (rdev->family == CHIP_RS880))
 		    && !radeon_crtc->ss_enabled)
 			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
-		if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
+		if (ASIC_IS_DCE31(rdev) && mode->clock > 165000)
 			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
 	} else {
 		radeon_crtc->pll_flags |= RADEON_PLL_LEGACY;
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 4aca09cab4b8..0274841b8616 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -2122,12 +2122,13 @@ int radeon_atom_pick_dig_encoder(struct drm_encoder *encoder, int fe_idx)
 	}
 
 	/*
-	 * On DCE32 any encoder can drive any block so usually just use crtc id,
-	 * but Apple thinks different at least on iMac10,1 and iMac11,2, so there use linkb,
-	 * otherwise the internal eDP panel will stay dark.
+	 * On DCE31 and DCE32 any encoder can drive any block so usually just use crtc id,
+	 * but Apple thinks different at least on iMac10,1, iMac11,1 and iMac11,2,
+	 * so there use linkb, otherwise the internal eDP panel will stay dark.
 	 */
-	if (ASIC_IS_DCE32(rdev)) {
+	if (ASIC_IS_DCE31(rdev)) {
 		if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
+		    dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
 		    dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
 			enc_idx = (dig->linkb) ? 1 : 0;
 		else
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 3d3d2109dfeb..b38ac1fdeb5e 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2624,6 +2624,7 @@ void r100_pll_errata_after_index(struct radeon_device *rdev);
 			    (rdev->family == CHIP_RS740)  ||	\
 			    (rdev->family >= CHIP_R600))
 #define ASIC_IS_DCE3(rdev) ((rdev->family >= CHIP_RV620))
+#define ASIC_IS_DCE31(rdev) ((rdev->family >= CHIP_RV770))
 #define ASIC_IS_DCE32(rdev) ((rdev->family >= CHIP_RV730))
 #define ASIC_IS_DCE4(rdev) ((rdev->family >= CHIP_CEDAR))
 #define ASIC_IS_DCE41(rdev) ((rdev->family >= CHIP_PALM) && \
-- 
2.42.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5856BC001B0
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jul 2023 09:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBCEB10E169;
	Sun, 23 Jul 2023 09:32:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB00B10E169
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jul 2023 09:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mzlnj6+kl/EXSZMyX/v0TvhFN4czveVbAotrR1MmUqjKqpYbviyAHJ8FjJQHT3EyElkMl3mKHUf59aTTPbgbsF/zjjp4RJENcEO7f1SDX43/gJhbwCBsMd+MoLLlQJ8UE8X1WyOGA5qYdQekKyMtNmmSlp/MtcwWzNIWxFLRJyOg8fe8EOq61jaA3OcoTs1BNHayi1d6xYaoKowAaFBklV4pXxrgpJLrHTgfVF2PQQirmPS3uIWwjdwRRN0XjdrrlRdJk1Qe9jUKeWrYq84/EwteujlOATHV9oO6fYU6CqdBBHOqRedyv+rmqn0exS3BQL1IpAKGfbcuZnIBgpUSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEsydnKcCBaDgJSVBplcGGu5hxPzHSGX1uqW5dAtwN8=;
 b=R86M0ZaNO4ajkZctNxpbjUy2M5ZZylHdOygqaik9GqSO3+Bkm/axOgokLziV3ax+hf2Mv2Q/dkAllZUGLMKLSZMOQSKVEk3KuvhhjPrQr+wGAcb4cNz++jdxuHQ/VPh0TuyBqB0EjbQznBtDgeGw9MucKmdd8pQTD7KNdbtyqexVlPXGqQIjhmcz9CyML7jlt/kPWppeLr0waqbpIu5Qqr6/8AN5IpV1d0MWqEbqNE/StC2yQ9RxksANZjWVHYeU66N9OEiqHOK9IxEh4rUuoZWAfWGGHvsduljhPx0bb5UwWf0/NuVfvIdA7SU9WTz8aB1baEYXltZOVimW2dMxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEsydnKcCBaDgJSVBplcGGu5hxPzHSGX1uqW5dAtwN8=;
 b=AuhpLUQhpjnINSj+grE6a8zgyLRiEim5JuhvEEj4YSvIxmCr1JWUxryoqvy63XU8a+oT+WlFoOVGe63yYBpr8dcAjw2d0h7PXTs4w9b3GOAV1G+Q9EXe/KhdXgr6n0g44Agl4hq5Yh1GDldE0m95BBKEZmfYjS7I9Gc8OPCfv2I=
Received: from DM5PR08CA0030.namprd08.prod.outlook.com (2603:10b6:4:60::19) by
 DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24; Sun, 23 Jul 2023 09:32:14 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::18) by DM5PR08CA0030.outlook.office365.com
 (2603:10b6:4:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Sun, 23 Jul 2023 09:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Sun, 23 Jul 2023 09:32:14 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 04:32:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Remove else after return in
 'dm_vblank_get_counter' & 'amdgpu_dm_backlight_get_level'
Date: Sun, 23 Jul 2023 15:01:58 +0530
Message-ID: <20230723093158.2052531-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 535be685-1aa3-45c3-2e59-08db8b5fb33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDWID99NWXk5qtWpOQswlKZjkOFaDs4cOrFetFCehmPHbMp4EOYJf9Ep/MDTCnSQ6GTDmBXFvhSHF8GsoVD5KImOyymwP1bCyxUmWzxZA0FEe/51xfr2X9914UJicnPdzSw3Nt9QdCnCQ70UHkSUlg8R82SNJeS2hYfcxbPqfm//9NGTFdq1cO5P+6kTPxslsNt/2hDU4qiCqut/SvzUH+FpQcsIjlxXfK/xJK4j5/aMCz1D86dSBkk3D1JgZexLjYmgl7SCFFiRcaWqqQ+d65EudwhBUO3v15UuzTVA5z3wiJN1pWDmV3V0JzNAu9i5aD+UxLeVxAVzGRbGWr5A5lorIiFYHsR471V1qZmalCWrbVdyNFTYXRlNLVs08h32G07xIIh2/tjM/mf4c/3D15WMbfiBLWEvcBwL7YlzJMsXvHfY03BsXOoOz34c583ZO/hDz6MtyZdelMnORDk9pRA9V1gUUul2sTKjk+EPltxolqkC5/wtypYqIGfrRb1CgkXH7cJxBLjBiJ6sD709CweURoyI5L3zhK0bhuVDAnKjRKz0cbhCSWC9Urm6tMKOB3rmoaa9qhRHLrJvzoKbuY5EcWy0mElm8ucfs+kfc20iyxJ8qN7wuYqy6OANSfsWntEPvnaej7+94jEcquf9AyjMKqbMJ+r+o3c1g0cL7wojOq/JbVht0BCAfPVCcHxh2YwUGNuZ0UToDCd5h6nm4YvfxlPlzdpkBAgoL2SjfD/fDxGSNR4WNZFI4+KIuRdDjchgI3ZuuIj4lumHNW/xVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(86362001)(478600001)(83380400001)(336012)(1076003)(186003)(26005)(41300700001)(110136005)(40480700001)(54906003)(316002)(8936002)(4326008)(6636002)(356005)(2906002)(40460700003)(7696005)(16526019)(36860700001)(70206006)(6666004)(81166007)(426003)(2616005)(44832011)(8676002)(70586007)(36756003)(5660300002)(47076005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 09:32:14.7626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535be685-1aa3-45c3-2e59-08db8b5fb33e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
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

Expressions under 'else' branch in function 'dm_vblank_get_counter' &
'amdgpu_dm_backlight_get_level' are executed whenever the expression in
'if' is False. Otherwise, return from case occurs. Therefore, there is
no need in 'else', and it has been removed.

Fixes the following:

WARNING: else is not generally useful after a break or return
+               return 0;
+       else {

WARNING: else is not generally useful after a break or return
+               return convert_brightness_to_user(&caps, avg);
+       } else {

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1e1a38014475..77d970a2ee69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -245,19 +245,20 @@ is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
  */
 static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 {
+	struct amdgpu_crtc *acrtc = NULL;
+
 	if (crtc >= adev->mode_info.num_crtc)
 		return 0;
-	else {
-		struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc];
 
-		if (acrtc->dm_irq_params.stream == NULL) {
-			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
-				  crtc);
-			return 0;
-		}
+	acrtc = adev->mode_info.crtcs[crtc];
 
-		return dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);
+	if (!acrtc->dm_irq_params.stream) {
+		DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
+			  crtc);
+		return 0;
 	}
+
+	return dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);
 }
 
 static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
@@ -4091,6 +4092,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 					 int bl_idx)
 {
+	int ret;
 	struct amdgpu_dm_backlight_caps caps;
 	struct dc_link *link = (struct dc_link *)dm->backlight_link[bl_idx];
 
@@ -4105,13 +4107,14 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 		if (!rc)
 			return dm->brightness[bl_idx];
 		return convert_brightness_to_user(&caps, avg);
-	} else {
-		int ret = dc_link_get_backlight_level(link);
-
-		if (ret == DC_ERROR_UNEXPECTED)
-			return dm->brightness[bl_idx];
-		return convert_brightness_to_user(&caps, ret);
 	}
+
+	ret = dc_link_get_backlight_level(link);
+
+	if (ret == DC_ERROR_UNEXPECTED)
+		return dm->brightness[bl_idx];
+
+	return convert_brightness_to_user(&caps, ret);
 }
 
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
-- 
2.25.1


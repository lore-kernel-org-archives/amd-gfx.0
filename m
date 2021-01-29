Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D86C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82DC64E06
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82DC64E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 695476EC37;
	Fri, 29 Jan 2021 21:28:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED2F6EC2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVMrMfAL6ShXou0A5y+RplPgRKnqHH47A9aVKT10alxpO9muSHkR0Eoqt6ep0Rv8VaGCD4h54mljTeQ0dYWz3/Qg7tEXi55CKhRyGsLNCKxtG+oipZL3frEYSVcsxUNLXF4Vb/L+pTkw6vepjW5DF5L+8NYLDo8JO/UQjXSUS3TDpS81eaKNCnyHYxSIJNQUXAaxUEtADl0Eb7MyhOLx0fwA0RnFzySOIC/pqbt2qbcNsV+nb3fVI8llt+zbqYeAvm6RPgaJIqINDmN+fUZWxIm/IYlprBQ8SxL69KEz0YQuZlrB6lgQNjKrQUW2s7vOEqTunnNAqOSRhsVkMzEPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWhH3nuXlMkWJUVkob3/RU9iFDjgquR2AcGt/eEwqE0=;
 b=BrxdJ9c/sBwYtPvajPD1JNlZOky9n2GvxLYvfAvYRzoU84OLn/xMxfSWzZlZkCH8M59FJO5U6bSKwJx6de3K12n/uk9fgb+Tb83126Y6O2TbGkBFn6kdHMDaI5Q1pMBMPJLLL16YA/+d4t1hLvt7kdg0Pf4I5JiVHtKmL+0qmfghLGRaLAWxkFBaLp/vOH31ASHQqXqSyvgHjd83DwkKg8nqgcMzsDblGRkjTtQd+rC4D4cEt5+Jna/DdSdzIHqisUnGEFcMIUoQttPLc3st6axqg/fcP5/wFDEgmnbOdteIiamG9pfBdNwV6Hm10hHg+BDGQ2XcWiHuU9n1PuO22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWhH3nuXlMkWJUVkob3/RU9iFDjgquR2AcGt/eEwqE0=;
 b=tfmqmglB+K96jSvIVwxhuxmHK9GTJvv0iB4/8p3QTGiLi3ZncJTLgxToMMsfCbkuiZQxGzzrpzD7WoYc7HkL3hnfyJdvlSVOSeT9nb9OT7WAEO4dtlNpKabsjGrvkoBsmRuPGH8y83Vr+ftsWKqUybZ0IcLkc3zuOFd+h7AMkGA=
Received: from BN6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:405:6f::30)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 29 Jan
 2021 21:28:41 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::c2) by BN6PR03CA0092.outlook.office365.com
 (2603:10b6:405:6f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:28 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:28 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:27 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/27] drm/amd/display: Reject too small viewport size when
 validating plane
Date: Fri, 29 Jan 2021 16:27:50 -0500
Message-ID: <20210129212752.38865-26-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fa6d242-a647-4e9e-5fc7-08d8c49cd840
X-MS-TrafficTypeDiagnostic: CH2PR12MB4327:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4327389E9B82456DC0C1A19DEBB99@CH2PR12MB4327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUHjyHkxIAlXVSsdV8l+Fz0Vn+12UHNeZNuaJ09y2keZJDcHn8C2HZIfonaUZwq3QmK9XK7SYpQFO34xwaLxUf73NWsFii/ovzCBhMCC95GzBIUkcwc74NAXdqcLQaiBOW4M6dUMMTcsFDF82Zc3p6jdJLQLnliVfovDuooQv6W9lAFz8h32XxeCbnA/5HQ2VjCidLzLiq0n8e8vxjYzH/b4nbvyBuYiuy+f8UQlbcJdLEuFIUEJjc3uU7g9ePI/em3EQ7ZmjZTG8/GScXGciFDS/xTikIIgPxZFwcfuzcMf3+DOyMUFXoHh192Nfu7JHzx187aThaMD9P1KvRhqQMAAqD4Gkp1XDjVcN0dG0F6dZ5LKhYQvXh7DcNJDsNUbdixKLBWq05zUOqcH91Lgp//Cl0CjpREwUFosAUK0p4adNG3/SJIii4F8pmnJi0ZI0EqCJmmQRYeykv08fWQRaDEESfznghfq+9mEcs29lJerCkyWve1XSR2PBau/FVuWvN1nDKU+ODA6gwNRoEic2xPbCVEIAT89w6ydWyrgCTGM+bRaQelIrHHKeQOFGBXSzrW22xlnOpUva8yRLg9J5CGL7kVxz8Z6yIcuN1vkJt3+g5jCNmv1tKfAR4pm/8C9RTJkeBqg4NH2Og+oqoAKWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(316002)(2906002)(7696005)(26005)(70206006)(4326008)(70586007)(6916009)(336012)(54906003)(82310400003)(5660300002)(426003)(8936002)(36756003)(47076005)(82740400003)(1076003)(8676002)(6666004)(478600001)(81166007)(186003)(83380400001)(86362001)(356005)(2616005)(160913001)(15963001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:39.4515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa6d242-a647-4e9e-5fc7-08d8c49cd840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Nikola Cornij <nikola.cornij@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
Overlay won't move to a new positon if viewport size is smaller than
what can be handled. It'd either disappear or stay at the old
position. This condition is for example hit if overlay is moved too
much outside of left or top edge of the screen, but it applies to
any non-cursor plane type.

[how]
Reject this contidion at validation time. This gives the calling
level a chance to handle this gracefully and avoid inconsistent
behaivor.

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  4 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e11139ca41d4..626a8cc92d65 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6496,8 +6496,33 @@ static int dm_plane_helper_check_state(struct drm_plane_state *state,
 	int min_scale = 0;
 	int max_scale = INT_MAX;
 
-	/* Plane enabled? Get min/max allowed scaling factors from plane caps. */
+	/* Plane enabled? Validate viewport and get scaling factors from plane caps. */
 	if (fb && state->crtc) {
+		/* Validate viewport to cover the case when only the position changes */
+		if (state->plane->type != DRM_PLANE_TYPE_CURSOR) {
+			int viewport_width = state->crtc_w;
+			int viewport_height = state->crtc_h;
+
+			if (state->crtc_x < 0)
+				viewport_width += state->crtc_x;
+			else if (state->crtc_x + state->crtc_w > new_crtc_state->mode.crtc_hdisplay)
+				viewport_width = new_crtc_state->mode.crtc_hdisplay - state->crtc_x;
+
+			if (state->crtc_y < 0)
+				viewport_height += state->crtc_y;
+			else if (state->crtc_y + state->crtc_h > new_crtc_state->mode.crtc_vdisplay)
+				viewport_height = new_crtc_state->mode.crtc_vdisplay - state->crtc_y;
+
+			/* If completely outside of screen, viewport_width and/or viewport_height will be negative,
+			 * which is still OK to satisfy the condition below, thereby also covering these cases
+			 * (when plane is completely outside of screen).
+			 * x2 for width is because of pipe-split.
+			 */
+			if (viewport_width < MIN_VIEWPORT_SIZE*2 || viewport_height < MIN_VIEWPORT_SIZE)
+				return -EINVAL;
+		}
+
+		/* Get min/max allowed scaling factors from plane caps. */
 		get_min_max_dc_plane_scaling(state->crtc->dev, fb,
 					     &min_downscale, &max_upscale);
 		/*
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 68b65a090d17..0c26c2ade782 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1153,8 +1153,8 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 
 	calculate_viewport(pipe_ctx);
 
-	if (pipe_ctx->plane_res.scl_data.viewport.height < 12 ||
-		pipe_ctx->plane_res.scl_data.viewport.width < 12) {
+	if (pipe_ctx->plane_res.scl_data.viewport.height < MIN_VIEWPORT_SIZE ||
+		pipe_ctx->plane_res.scl_data.viewport.width < MIN_VIEWPORT_SIZE) {
 		if (store_h_border_left) {
 			restore_border_left_from_dst(pipe_ctx,
 				store_h_border_left);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d5105924c9e0..be9adddfac96 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -48,6 +48,7 @@
 #define MAX_PLANES 6
 #define MAX_STREAMS 6
 #define MAX_SINKS_PER_LINK 4
+#define MIN_VIEWPORT_SIZE 12
 
 /*******************************************************************************
  * Display Core Interfaces
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

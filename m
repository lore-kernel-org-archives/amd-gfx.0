Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0E5C48BE6
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 16:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCCC601FC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 16:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCCC601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81FF289850;
	Wed, 16 Jun 2021 16:21:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ECB689850
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 16:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM6Fd19UdKuR+12m1jaQRwZRz70YQpWJD37VQJS9POuMf023jZrnY8Gh+pxotLUuHH2pIgu9uj2uImVONei/qJXa4QhNh65d4u7g9aZYwji8IzxH7PBoEhUP25/jEw4NuMYHUg3t36vftCLW7yd73v7ck/usZKQcuox/lTa0K+CsL/2G8mfWIco1iAkK//bOwnQqcAKU5k0PRmmxLK0TdTLrFaN+/VjkSvy3rbyJiOa+z3Zls0mRjOrbLmeVy/G6PYlj3+TMIa3sQBVI6Wv94/Ct64nStsEB7CaCfRj3/ut7YhpetLRyadnekjczgW+2KeSlzxUO3aj4YpkanFGEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M8GxDPzkNap4RhkpLhJKehPoUlzquntrFEdOvvWhwg=;
 b=g7RSgyf39lnGykkDj0mvWS7NLGj7ylUtuBkUuQVZVvr+qlnwVPGH54aUMhfGsmFhLxNkQncAXceBm5LR9Bt/G3qTuNG++jVkIQSdk3FYTbwsG3QDdZSewsnbt8LHVKQyiTHLjovnGMX7UbjjPcKj7vyj4lIg2tMkHQFoaZNjne0GMeqqnYY9n6RHpDxFzlD8tTRcbKSRFuCgCHCEjLFt3mOwBvhkaFEtFdBrDElMoq/5Xhf819toB0riq4s/G1WhM9WtHVDRCFzJdIHKocWZVJa8RfAtftBCVNcy9CmnaLz0LZ3iV93i3ETvcDD53afDYxhyQehwgNzr4adWpXoAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M8GxDPzkNap4RhkpLhJKehPoUlzquntrFEdOvvWhwg=;
 b=t8e79uZ7wXfCnhP3Em88O3GayOs4Jq9AUK4SrY33siNGZtXAAUIVRr21Cp8GkGrpz3hsQrZn9rRwdlLZni2+fYhcz+YF8N+Ib87LU0n7+tzxjLvZQyvP1Jn0BnH3l2Co4X7YtIbrAPXIzvEu+o0ksu/5JtQUgQqzakB0KA0L5V8=
Received: from BN6PR14CA0038.namprd14.prod.outlook.com (2603:10b6:404:13f::24)
 by CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 16:21:42 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::fa) by BN6PR14CA0038.outlook.office365.com
 (2603:10b6:404:13f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Wed, 16 Jun 2021 16:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 16:21:42 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 11:21:41 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: Fix overlay validation by
 considering cursors"
Date: Wed, 16 Jun 2021 12:21:30 -0400
Message-ID: <20210616162130.1430187-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c6f5a21-89ef-405f-0334-08d930e2d3cf
X-MS-TrafficTypeDiagnostic: CH0PR12MB5060:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5060F65643A7F3A4FCBB0D2C980F9@CH0PR12MB5060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:457;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMuQk5fIXVf93n3ViYtHRlPzBSJLqmfTcbd8BdrHsNwgXBxf1v6FWFGsxHtd1dgjkMCTixoZtGP73rloEPMToxn5IRNLPmJgo6oedY1Ye0eqLMoLOzsByT/2qhUZWUPugw3dKsPhioUjQ6amjmASKNbnMngxjS01nlqDqwuSHtIMzdPJm54qyEGzBM5Wif7HzI/yxKk9aBQTIcs2sQQx962HR/6A+43ElHMpR4UZlhzhWX103FaVxjXAB98vlTwVsrDur5N33WIB1XNTDPhcd6utxc5LFpneDgdpBirusrVK1QgUgxjoWYbXfLI+Vd6FcFiDiDiDTm+z8fD040HSTTj3esCp7z0pKL+t/+rXvwPM1DRYqWhSpStSeDdn9HCDfx0RXq0ibKLi7bmkRysb/uN9Cb8keCBKNyt/ifv1t/7bDLrCtOBHuDeEre/cXLUV4dI1pYbokbiFA7KiD35h130VmT7dnJFR2+7cw1+KHRh9Q/FN8A5JlpF7DNoPvoZIYNAhc9dauMcZvYcE21o0jAONUnB3/WJct0ZnleIIEiv1P/TlJErnHFDeKCj7JxxVryTuuz9cUbWVnPl7mg6wQhoFH27Mj2zJR2IJG5rRqPBFxk+kkW6g89VP8bAGu+6YXqdeUppectHhmvqxLzjCg7C/iAIqATBQLyXuLOeUzY/xqTTkgBm+oIZDClLRZe7V
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(70206006)(26005)(498600001)(83380400001)(36860700001)(4326008)(54906003)(426003)(70586007)(81166007)(47076005)(36756003)(16526019)(186003)(8676002)(86362001)(336012)(82310400003)(6916009)(6666004)(2616005)(8936002)(1076003)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 16:21:42.3507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6f5a21-89ef-405f-0334-08d930e2d3cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
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
Cc: Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Paul <seanpaul@chromium.org>,
 Mark Yacoub <markyacoub@chromium.org>, Hersen Wu <hersenxs.wu@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 04cc17a951f73f9a9092ca572b063e6292aeb085.

The patch that we are reverting here was originally applied because it
fixes multiple IGT issues and flickering in Android. However, after a
discussion with Sean Paul and Mark, it looks like that this patch might
cause problems on ChromeOS. For this reason, we decided to revert this
patch.

Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Mark Yacoub <markyacoub@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8358112b5822..3fd41e098c90 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10200,8 +10200,8 @@ static int validate_overlay(struct drm_atomic_state *state)
 {
 	int i;
 	struct drm_plane *plane;
-	struct drm_plane_state *new_plane_state;
-	struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
+	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct drm_plane_state *primary_state, *overlay_state = NULL;
 
 	/* Check if primary plane is contained inside overlay */
 	for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
@@ -10231,14 +10231,6 @@ static int validate_overlay(struct drm_atomic_state *state)
 	if (!primary_state->crtc)
 		return 0;
 
-	/* check if cursor plane is enabled */
-	cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
-	if (IS_ERR(cursor_state))
-		return PTR_ERR(cursor_state);
-
-	if (drm_atomic_plane_disabling(plane->state, cursor_state))
-		return 0;
-
 	/* Perform the bounds check to ensure the overlay plane covers the primary */
 	if (primary_state->crtc_x < overlay_state->crtc_x ||
 	    primary_state->crtc_y < overlay_state->crtc_y ||
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

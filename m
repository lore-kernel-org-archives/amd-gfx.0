Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B7AC43462
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C6C613B3
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C6C613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C286E935;
	Mon,  3 May 2021 16:36:40 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF6F6E935;
 Mon,  3 May 2021 16:36:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75B34613D3;
 Mon,  3 May 2021 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620059797;
 bh=VN3z8c7lIwVL7ebbq5cUCA4ntbN8cMYiZn4hCCboUnk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ett+yDYedPUpgsZtQFnZBkPpMRzwCdPHYSNh3E0mUIh64ca7yPWksWV+WPInB4lvG
 acUEIbjZ/8JgGuqZxYtTFnTYax0ajug9m0eTFWPj+cLdwbcL51APljqEK29NuGWsNP
 RNJp+vIzlSRIhXja48ZHU+UWZWRYJo2/nFXlvceovpdzdQ1iR1nv7LSg3BsFOPlttH
 92GkvgGIqINgvr+Yh/rj4556aawLpA776XBmQmr8I4ouJLaOTBlrNttRTBcepWQS6I
 6K3G+vJQDd8Op/vnG4xAGXb3LaIoDhkbgaXoHWoih2DXcBG/dZV7vopB4JFMkKGX6C
 0jCVIIUjfUeXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 054/134] drm/amd/display: Fix UBSAN warning for
 not a valid value for type '_Bool'
Date: Mon,  3 May 2021 12:33:53 -0400
Message-Id: <20210503163513.2851510-54-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163513.2851510-1-sashal@kernel.org>
References: <20210503163513.2851510-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Anson Jacob <Anson.Jacob@amd.com>,
 amd-gfx@lists.freedesktop.org, Solomon Chiu <solomon.chiu@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anson Jacob <Anson.Jacob@amd.com>

[ Upstream commit 6a30a92997eee49554f72b462dce90abe54a496f ]

[Why]
dc_cursor_position do not initialise position.translate_by_source when
crtc or plane->state->fb is NULL. UBSAN caught this error in
dce110_set_cursor_position, as the value was garbage.

[How]
Initialise dc_cursor_position structure elements to 0 in handle_cursor_update
before calling get_cursor_position.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1471
Reported-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8ad83ccfcc6a..167e04ab9d5b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7417,10 +7417,6 @@ static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
 	int x, y;
 	int xorigin = 0, yorigin = 0;
 
-	position->enable = false;
-	position->x = 0;
-	position->y = 0;
-
 	if (!crtc || !plane->state->fb)
 		return 0;
 
@@ -7467,7 +7463,7 @@ static void handle_cursor_update(struct drm_plane *plane,
 	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	uint64_t address = afb ? afb->address : 0;
-	struct dc_cursor_position position;
+	struct dc_cursor_position position = {0};
 	struct dc_cursor_attributes attributes;
 	int ret;
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

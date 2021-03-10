Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97FC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 15:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683B564F4B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 15:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683B564F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1324C6EA39;
	Wed, 10 Mar 2021 15:12:13 +0000 (UTC)
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386936EA39
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 15:12:11 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
 by mslow2.mail.gandi.net (Postfix) with ESMTP id 65CA33AF936
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 14:50:55 +0000 (UTC)
X-Originating-IP: 82.65.230.196
Received: from localhost.localdomain (82-65-230-196.subs.proxad.net
 [82.65.230.196]) (Authenticated sender: schroder@emersion.fr)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 67CA82000B;
 Wed, 10 Mar 2021 14:50:32 +0000 (UTC)
From: Simon Ser <contact@emersion.fr>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 5/5] amd/display: re-introduce cursor plane rotation prop
Date: Wed, 10 Mar 2021 15:50:19 +0100
Message-Id: <20210310145019.2877-6-contact@emersion.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210310145019.2877-1-contact@emersion.fr>
References: <20210310145019.2877-1-contact@emersion.fr>
MIME-Version: 1.0
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
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The commit 1347385fe187 ("drm/amd/display: don't expose rotation
prop for cursor plane") removed the rotation property for the
cursor plane, assuming the cursor would always be displayed without
any rotation. However the rotation is inherited from the underlying
plane.

As a result, if the primary plane is rotated, then the cursor plane
will incorrectly be rotated as well even though it doesn't have a
rotation property.

To fix this, re-introduce the cursor rotation property, and check
that its value matches the underlying plane's.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b4f6e2985b8a..36ee52104007 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6897,8 +6897,7 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
 		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
 
-	if (dm->adev->asic_type >= CHIP_BONAIRE &&
-	    plane->type != DRM_PLANE_TYPE_CURSOR)
+	if (dm->adev->asic_type >= CHIP_BONAIRE)
 		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
 						   supported_rotations);
 
@@ -9494,6 +9493,11 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 		return -EINVAL;
 	}
 
+	if (new_underlying_state->rotation != new_cursor_state->rotation) {
+		drm_dbg_atomic(crtc->dev, "Cursor plane rotation doesn't match underlying plane\n");
+		return -EINVAL;
+	}
+
 	/* In theory we could probably support YUV cursors when the underlying
 	 * plane uses a YUV format, but there's no use-case for it yet. */
 	if (new_underlying_state->fb->format->is_yuv) {
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25960C47071
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 19:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C8410E6B5;
	Thu, 16 Nov 2023 19:58:57 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D7F10E6B3;
 Thu, 16 Nov 2023 19:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xeG+dKF4P9eX/e5S5tSPqQdGveJB8I6V7wmSKo2tHr4=; b=m9C7vpwPtc8dmTX0vrWU0/eVHX
 llVhplswr5bvn9c5qsKjxKmZUBajL96UiSIArC9nTQ57DtLoSM/Ec1aSw7iU0oy+LFgtU5GOJbkOi
 9jEE56zTQxZyLM5alPU7ygwjYrMn+9yQh8mv/f9cB/c7CwCHeDXfFdVNj4U2GxDXUu9iUEFpcyJDG
 zxynLzhr6B63NsMwDJjXCUCxV60gwC7kT3dcXc4QKLROx7usiSuTveZFj7zPL6pQQDgn9492jVh4o
 LwNOgr4wES+nnMgosopZ7hdqlSTf4lezyTg29t2qxk3dDVqw5djAwxhEwVn2XSav+yE8DtLJdqgRD
 g8VfR4JA==;
Received: from [102.213.205.115] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1r3iVp-0048Yy-OI; Thu, 16 Nov 2023 20:58:53 +0100
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, sunpeng.li@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch
Subject: [PATCH v5 17/32] drm/amd/display: mark plane as needing reset if
 color props change
Date: Thu, 16 Nov 2023 18:57:57 -0100
Message-Id: <20231116195812.906115-18-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231116195812.906115-1-mwen@igalia.com>
References: <20231116195812.906115-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Shashank Sharma <Shashank.Sharma@amd.com>, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Xaver Hugl <xaver.hugl@gmail.com>,
 kernel-dev@igalia.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Joshua Ashton <joshua@froggi.es>, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Ashton <joshua@froggi.es>

We should reset a plane state if at least one of the color management
properties differs from old and new state.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Joshua Ashton <joshua@froggi.es>
Co-developed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8bf7866ee1af..8f82d9837a41 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9632,6 +9632,10 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	 */
 	for_each_oldnew_plane_in_state(state, other, old_other_state, new_other_state, i) {
 		struct amdgpu_framebuffer *old_afb, *new_afb;
+		struct dm_plane_state *dm_new_other_state, *dm_old_other_state;
+
+		dm_new_other_state = to_dm_plane_state(new_other_state);
+		dm_old_other_state = to_dm_plane_state(old_other_state);
 
 		if (other->type == DRM_PLANE_TYPE_CURSOR)
 			continue;
@@ -9668,6 +9672,17 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 		    old_other_state->color_encoding != new_other_state->color_encoding)
 			return true;
 
+		/* HDR/Transfer Function changes. */
+		if (dm_old_other_state->degamma_tf != dm_new_other_state->degamma_tf ||
+		    dm_old_other_state->degamma_lut != dm_new_other_state->degamma_lut ||
+		    dm_old_other_state->hdr_mult != dm_new_other_state->hdr_mult ||
+		    dm_old_other_state->shaper_lut != dm_new_other_state->shaper_lut ||
+		    dm_old_other_state->shaper_tf != dm_new_other_state->shaper_tf ||
+		    dm_old_other_state->lut3d != dm_new_other_state->lut3d ||
+		    dm_old_other_state->blend_lut != dm_new_other_state->blend_lut ||
+		    dm_old_other_state->blend_tf != dm_new_other_state->blend_tf)
+			return true;
+
 		/* Framebuffer checks fall at the end. */
 		if (!old_other_state->fb || !new_other_state->fb)
 			continue;
-- 
2.40.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12652C77B73
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Apr 2023 14:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C4510E40B;
	Sun, 23 Apr 2023 14:13:40 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD77C10E3FF;
 Sun, 23 Apr 2023 14:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uJMJ+NQtZ0XpbgcU5B6V/mq7bccUXUSsHINPFl3Guj4=; b=IhYMosca0wZ+B+VisCfWEo1sGl
 2lQqN8jG09ZDejv+mI53UicwpH5fMnjrZ7Qb1/2dEKmd1yy8nzkvK5Smrs5Qs5WkHkJBoDmHf7AXh
 dlFAcJyDtpRMTgve+Hn1N7bZgZFmywRF/8ixSlzrFpgc403gIrKQBwen7HpIZWEDuAvrIEIUTJGgj
 /YmI1sY85xnZ+R1ppu+GGQV3wFqCyEREfiAwopG5AiSOs2UJIObEJ4Pf9H1xEaGDXDfC7X2yToqGc
 Lk4A819xB5lK1Pt7F++wJ6WUqOg6Z3Z+XzMdwPWZEv/pK6DyL5Fda3ja7GU4gse57Nis3N+nvF2yr
 QZA5shMQ==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pqaTA-00ANVs-Ad; Sun, 23 Apr 2023 16:13:36 +0200
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, sunpeng.li@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch
Subject: [RFC PATCH 30/40] drm/amd/display: mark plane as needing reset if
 plane color mgmt changes
Date: Sun, 23 Apr 2023 13:10:42 -0100
Message-Id: <20230423141051.702990-31-mwen@igalia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423141051.702990-1-mwen@igalia.com>
References: <20230423141051.702990-1-mwen@igalia.com>
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
 Shashank Sharma <Shashank.Sharma@amd.com>, Alex Hung <alex.hung@amd.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, linux-kernel@vger.kernel.org,
 Melissa Wen <mwen@igalia.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Joshua Ashton <joshua@froggi.es>, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We took a similar path for CRTC color mgmt changes, since we remap CRTC
degamma to plane/DPP block. Here we can use the status of
`plane->color_mgmt_changed` to detect when a plane color property
changed and recreate the plane accordingly.

Co-developed-by: Joshua Ashton <joshua@froggi.es>
Signed-off-by: Joshua Ashton <joshua@froggi.es>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 760080e4a4da..1dac311cab67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9441,6 +9441,9 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	if (drm_atomic_crtc_needs_modeset(new_crtc_state))
 		return true;
 
+	if (new_plane_state->color_mgmt_changed)
+		return true;
+
 	/*
 	 * If there are any new primary or overlay planes being added or
 	 * removed then the z-order can potentially change. To ensure
-- 
2.39.2


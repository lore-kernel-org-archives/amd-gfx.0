Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D6BC04FE2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 16:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0204E10E5A3;
	Thu, 10 Aug 2023 16:04:28 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FCF010E5A3;
 Thu, 10 Aug 2023 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1iMFHMugd7iTv6dIKtnvC4qTAO4PL6Pl+JouqLpfp8o=; b=RrTQeZB2ay0bNxhF1dsum4jsUU
 U06coAnkieWsjRjmgtgHHW87DGUscPIgZllHEhSvYc0NY/hBVabvPbeqxnlYzS9fH45W1+VTdSStA
 nXv7s+xWjK/D/R5acXk6fuze3/raI5XM1Q3wShj6TufzaeSA3Gw8biqRiDRlqbdnl1s4I77drhwFM
 1fBiK4lMZGao9JY/RZ9pWTX1VZbi89ghV7DncQv3gfDci5FSLt1tMaqbSUprQSQzE50yhN/6na0Fm
 tcWayAL7JXVh7WmXW4V127fRzlzWBn/TPjPSx1xI97VygmPS4lkV09bg1JbTPf0U3/eJVy0BW72Zd
 5qNAZxjw==;
Received: from [38.44.68.151] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qU899-00GjYD-2Y; Thu, 10 Aug 2023 18:04:23 +0200
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, sunpeng.li@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch
Subject: [PATCH v2 30/34] drm/amd/display: copy 3D LUT settings from crtc
 state to stream_update
Date: Thu, 10 Aug 2023 15:03:10 -0100
Message-Id: <20230810160314.48225-31-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810160314.48225-1-mwen@igalia.com>
References: <20230810160314.48225-1-mwen@igalia.com>
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
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Joshua Ashton <joshua@froggi.es>, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Ashton <joshua@froggi.es>

When commiting planes, we copy color mgmt resources to the stream state.
Do the same for shaper and 3D LUTs.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Joshua Ashton <joshua@froggi.es>
Co-developed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d37269a2179e..dfe61c5ed49e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8274,6 +8274,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				&acrtc_state->stream->csc_color_matrix;
 			bundle->stream_update.out_transfer_func =
 				acrtc_state->stream->out_transfer_func;
+			bundle->stream_update.lut3d_func =
+				(struct dc_3dlut *) acrtc_state->stream->lut3d_func;
+			bundle->stream_update.func_shaper =
+				(struct dc_transfer_func *) acrtc_state->stream->func_shaper;
 		}
 
 		acrtc_state->stream->abm_level = acrtc_state->abm_level;
-- 
2.40.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0BEC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 08:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC9311240D;
	Mon, 21 Feb 2022 08:30:48 +0000 (UTC)
Received: from forward107p.mail.yandex.net (forward107p.mail.yandex.net
 [IPv6:2a02:6b8:0:1472:2741:0:8b7:115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A9510EAD5
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Feb 2022 15:19:58 +0000 (UTC)
Received: from myt5-f0e8352497c8.qloud-c.yandex.net
 (myt5-f0e8352497c8.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3c22:0:640:f0e8:3524])
 by forward107p.mail.yandex.net (Yandex) with ESMTP id 207A5556CE46;
 Sun, 20 Feb 2022 18:19:56 +0300 (MSK)
Received: from myt5-aad1beefab42.qloud-c.yandex.net
 (myt5-aad1beefab42.qloud-c.yandex.net [2a02:6b8:c12:128:0:640:aad1:beef])
 by myt5-f0e8352497c8.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 D6W9P1iVZ4-Jtdmn38c; Sun, 20 Feb 2022 18:19:56 +0300
X-Yandex-Fwd: 2
Authentication-Results: myt5-f0e8352497c8.qloud-c.yandex.net; dkim=pass
Received: by myt5-aad1beefab42.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id M6K5BEkQDc-JqH8q7d8; Sun, 20 Feb 2022 18:19:54 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yaroslav Bolyukin <iam@lach.pw>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amd: use fixed dsc bits-per-pixel from edid
Date: Sun, 20 Feb 2022 18:19:40 +0300
Message-Id: <20220220151940.58327-2-iam@lach.pw>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220151940.58327-1-iam@lach.pw>
References: <20220213133128.5833-1-iam@lach.pw>
 <20220220151940.58327-1-iam@lach.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Feb 2022 08:30:47 +0000
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Leo Li <sunpeng.li@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Yaroslav Bolyukin <iam@lach.pw>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VESA vendor header from DisplayID spec may contain fixed bit per pixel
rate, it should be respected by drm driver

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 ++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c           | 3 ++-
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 29f07c26d..b34dd89ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -118,6 +118,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
+	edid_caps->dsc_fixed_bits_per_pixel_x16 = connector->display_info.dp_dsc_bpp;
+
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
 		return result;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 57cf4cb82..f8516ec70 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -105,6 +105,8 @@ static bool dc_stream_construct(struct dc_stream_state *stream,
 
 	/* EDID CAP translation for HDMI 2.0 */
 	stream->timing.flags.LTE_340MCSC_SCRAMBLE = dc_sink_data->edid_caps.lte_340mcsc_scramble;
+	stream->timing.dsc_fixed_bits_per_pixel_x16 =
+		dc_sink_data->edid_caps.dsc_fixed_bits_per_pixel_x16;
 
 	memset(&stream->timing.dsc_cfg, 0, sizeof(stream->timing.dsc_cfg));
 	stream->timing.dsc_cfg.num_slices_h = 0;
@@ -738,4 +740,3 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 			"\tlink: %d\n",
 			stream->link->link_index);
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0285a4b38..ce2e11d70 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -227,6 +227,9 @@ struct dc_edid_caps {
 	bool edid_hdmi;
 	bool hdr_supported;
 
+	/* DisplayPort caps */
+	uint32_t dsc_fixed_bits_per_pixel_x16;
+
 	struct dc_panel_patch panel_patch;
 };
 
-- 
2.35.1


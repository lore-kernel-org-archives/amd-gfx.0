Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B15DCCD19F
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Oct 2025 08:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB11F10E1D8;
	Sat, 18 Oct 2025 08:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=lach.pw header.i=@lach.pw header.b="BZAmcj42";
	dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b="7tnaCM6o";
	dkim-atps=neutral
Received: from mail.0la.ch (mail.0la.ch [78.47.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAA810EC85;
 Fri, 17 Oct 2025 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202502r; d=lach.pw; c=relaxed/relaxed;
 h=Message-ID:Date:Subject:To:From; t=1760718482; bh=G0cUjhPXLsNiRSzg25M5MDh
 tPLRayvef22yIVqM4pgw=; b=BZAmcj42Tx4KgCUm7gwuhiu23+4lWTXljxM1DgM5pw0lUo1shr
 bjUuMdS5qphyFhTX5yv4heg1KbfxDnAgaGg6W50ALBuvtS4/E81Fu0LFYmWpvJbIDrkHf0qvRtl
 KkJUq52WvtFp9HXDG8u/WGM06P1yavQjyalNZvqWlTvxGgXmRRhzgqlDINnCE5UciHKIwGDbifc
 EEt4U5tF9R/vrZsPCeCYb+xfw8Bj02isOXPJzUwCPXuAFLuXklN7o9MN7S8RjAolzlQsEzktJ+g
 q5fCLpajAB67CwXhXY1UdOpf2xFONTp3as+dBGn2ZRD2RuaXuAJkCWHfCVZMNO1Cjdg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202502e; d=lach.pw; c=relaxed/relaxed;
 h=Message-ID:Date:Subject:To:From; t=1760718482; bh=G0cUjhPXLsNiRSzg25M5MDh
 tPLRayvef22yIVqM4pgw=; b=7tnaCM6oVQtil/Mg0gF5n7TynT9nM1uOFUikgWxSpjww/vsIHr
 ux0+oXF2ALeUBjyvUXnwNF3JkdiE+mzUdsDA==;
From: Yaroslav Bolyukin <iam@lach.pw>
To: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Yaroslav Bolyukin <iam@lach.pw>
Subject: [PATCH v5 2/7] drm/edid: prepare for VESA vendor-specific data block
 extension
Date: Fri, 17 Oct 2025 18:27:31 +0200
Message-ID: <20251017162736.45368-3-iam@lach.pw>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017162736.45368-1-iam@lach.pw>
References: <20251017162736.45368-1-iam@lach.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 18 Oct 2025 08:50:55 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Current VESA vendor-specific block parsing expects real block size to be
the same as the defined struct size, use real offsets in conditionals
instead to add struct fields in future commits.

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
---
 drivers/gpu/drm/drm_edid.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 4fcde52291ce..725ae5f9d160 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6541,7 +6541,7 @@ static void drm_parse_vesa_specific_block(struct drm_connector *connector,
 	if (oui(vesa->oui[0], vesa->oui[1], vesa->oui[2]) != VESA_IEEE_OUI)
 		return;
 
-	if (sizeof(*vesa) != sizeof(*block) + block->num_bytes) {
+	if (block->num_bytes < 5) {
 		drm_dbg_kms(connector->dev,
 			    "[CONNECTOR:%d:%s] Unexpected VESA vendor block size\n",
 			    connector->base.id, connector->name);
@@ -6564,24 +6564,20 @@ static void drm_parse_vesa_specific_block(struct drm_connector *connector,
 		break;
 	}
 
-	if (!info->mso_stream_count) {
-		info->mso_pixel_overlap = 0;
-		return;
-	}
-
-	info->mso_pixel_overlap = FIELD_GET(DISPLAYID_VESA_MSO_OVERLAP, vesa->mso);
-	if (info->mso_pixel_overlap > 8) {
+	if (info->mso_stream_count) {
+		info->mso_pixel_overlap = FIELD_GET(DISPLAYID_VESA_MSO_OVERLAP, vesa->mso);
+		if (info->mso_pixel_overlap > 8) {
+			drm_dbg_kms(connector->dev,
+				    "[CONNECTOR:%d:%s] Reserved MSO pixel overlap value %u\n",
+				    connector->base.id, connector->name,
+				    info->mso_pixel_overlap);
+			info->mso_pixel_overlap = 8;
+		}
 		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Reserved MSO pixel overlap value %u\n",
+			    "[CONNECTOR:%d:%s] MSO stream count %u, pixel overlap %u\n",
 			    connector->base.id, connector->name,
-			    info->mso_pixel_overlap);
-		info->mso_pixel_overlap = 8;
+			    info->mso_stream_count, info->mso_pixel_overlap);
 	}
-
-	drm_dbg_kms(connector->dev,
-		    "[CONNECTOR:%d:%s] MSO stream count %u, pixel overlap %u\n",
-		    connector->base.id, connector->name,
-		    info->mso_stream_count, info->mso_pixel_overlap);
 }
 
 static void drm_update_vesa_specific_block(struct drm_connector *connector,
-- 
2.51.0

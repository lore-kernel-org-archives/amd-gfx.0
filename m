Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0CDD10399
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 08:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE5A10E546;
	Wed, 26 Nov 2025 08:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=lach.pw header.i=@lach.pw header.b="YJE1fSsI";
	dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b="z+CS2b+F";
	dkim-atps=neutral
Received: from mail.0la.ch (mail.0la.ch [78.47.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCC210E513;
 Wed, 26 Nov 2025 06:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202502r; d=lach.pw; c=relaxed/relaxed;
 h=Message-ID:Date:Subject:To:From; t=1764139912; bh=AvKT6oJijpCEbMgflv6462W
 DrB/s3kB+K5PshE5hKtY=; b=YJE1fSsI6tntFWIBjjfAE2ySxNfLnfQjdYdInz1vfwPbmIxYk0
 cRlcnOyxGuF0Pq2zoFjNBIcGSpYllnwFujk0ZWqDFfwBeLxdEDphM0P4Ct15brG/yhItL19wuxl
 m1wMzuVVuN26NXaE464RQkw1F8mdKu6BVnkt7CkdXcPLzBxVEkCrIBp5FmSgU/aJ+lQlfVjbUFG
 US5HQYmFYLcub0NE284FyZRFz7TSnab88svCFhpx6vn0ytsHdseykI2gL7LE3jxsQJyhUv0mqoF
 1ZYvk+Jyvr4EspFEWxfgn/n7QFwZU0XqU0buaon2ms2rNBS1T/DTc9zExrdKwfxVEVg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202502e; d=lach.pw; c=relaxed/relaxed;
 h=Message-ID:Date:Subject:To:From; t=1764139912; bh=AvKT6oJijpCEbMgflv6462W
 DrB/s3kB+K5PshE5hKtY=; b=z+CS2b+FYOWCUDjpMGs7LvAPYwy9aMoZYja3EZDOD3806E3XqM
 Q8S5KjMAPvDoHZp0glpipwpMmte78KNFuSBQ==;
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
Subject: [PATCH v6 3/7] drm/edid: MSO should only be used for non-eDP displays
Date: Wed, 26 Nov 2025 07:51:22 +0100
Message-ID: <20251126065126.54016-4-iam@lach.pw>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126065126.54016-1-iam@lach.pw>
References: <20251126065126.54016-1-iam@lach.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Nov 2025 08:58:07 +0000
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

As per DisplayID v2.1a spec:
If Offset 06h[2:0] is programmed to 001b (External DisplayPort), this
field shall be cleared to 00b (Not supported).

Link: https://lore.kernel.org/lkml/3abc1087618c822e5676e67a3ec2e64e506dc5ec@intel.com/
Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
---
 drivers/gpu/drm/drm_displayid_internal.h |  4 +++
 drivers/gpu/drm/drm_edid.c               | 36 +++++++++++++++---------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index 5b1b32f73516..72f107ae832f 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -142,9 +142,13 @@ struct displayid_formula_timing_block {
 	struct displayid_formula_timings_9 timings[];
 } __packed;
 
+#define DISPLAYID_VESA_DP_TYPE		GENMASK(2, 0)
 #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
 #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
 
+#define DISPLAYID_VESA_DP_TYPE_EDP	0
+#define DISPLAYID_VESA_DP_TYPE_DP	1
+
 struct displayid_vesa_vendor_specific_block {
 	struct displayid_block base;
 	u8 oui[3];
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index a52fd6de9327..348aa31aea1b 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6533,6 +6533,7 @@ static void drm_parse_vesa_specific_block(struct drm_connector *connector,
 	struct displayid_vesa_vendor_specific_block *vesa =
 		(struct displayid_vesa_vendor_specific_block *)block;
 	struct drm_display_info *info = &connector->display_info;
+	int dp_type;
 
 	if (block->num_bytes < 3) {
 		drm_dbg_kms(connector->dev,
@@ -6551,20 +6552,29 @@ static void drm_parse_vesa_specific_block(struct drm_connector *connector,
 		return;
 	}
 
-	switch (FIELD_GET(DISPLAYID_VESA_MSO_MODE, vesa->mso)) {
-	default:
-		drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] Reserved MSO mode value\n",
+	dp_type = FIELD_GET(DISPLAYID_VESA_DP_TYPE, vesa->data_structure_type);
+	if (dp_type > 1) {
+		drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] Reserved dp type value\n",
 			    connector->base.id, connector->name);
-		fallthrough;
-	case 0:
-		info->mso_stream_count = 0;
-		break;
-	case 1:
-		info->mso_stream_count = 2; /* 2 or 4 links */
-		break;
-	case 2:
-		info->mso_stream_count = 4; /* 4 links */
-		break;
+	}
+
+	/* MSO is not supported for eDP */
+	if (dp_type != DISPLAYID_VESA_DP_TYPE_EDP) {
+		switch (FIELD_GET(DISPLAYID_VESA_MSO_MODE, vesa->mso)) {
+		default:
+			drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] Reserved MSO mode value\n",
+				    connector->base.id, connector->name);
+			fallthrough;
+		case 0:
+			info->mso_stream_count = 0;
+			break;
+		case 1:
+			info->mso_stream_count = 2; /* 2 or 4 links */
+			break;
+		case 2:
+			info->mso_stream_count = 4; /* 4 links */
+			break;
+		}
 	}
 
 	if (info->mso_stream_count) {
-- 
2.51.2

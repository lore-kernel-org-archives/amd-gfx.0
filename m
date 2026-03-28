Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838D910F3DEC
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Mar 2026 16:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEA010E027;
	Sat, 28 Mar 2026 16:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JmpsrmG9";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49BA10E004
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 14:14:39 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-486ff201041so28818535e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774707278; x=1775312078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4vlVVvxWEWO2r6arzInv5eisxXfXrLq1ekNSjOyYGg=;
 b=JmpsrmG9AiUz1NeObMZGxW5oAfNw/xMQDMHyU+rBq9twuVZzw8gc3kpC9hTD9Q+GRF
 Mx0HFwo/nmFkT9TEcX7nYFONuOAPqM6snEzhVnXkbA54sJ8fpl9nPHgjMBFbIsij1k8W
 Pqn1Z6SStxHz8JemmhVt1v+oMOsMMqcq2QtU4HmmUxi/5m3SOm+pXZ/aJEcP3N9QVUYM
 xTwhRU02S9R0fJQB9EOGje5lC1zYKfKw0uMu4ERvcP2kXCbrBJBg/kP+eR549HI/73Wh
 33+Vm+XWlY31QKUVfB3LkfBwWnah7QOQOgpYw37xnrSl4YQarJSyZnRzfxtZvXehDvpE
 W0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774707278; x=1775312078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t4vlVVvxWEWO2r6arzInv5eisxXfXrLq1ekNSjOyYGg=;
 b=knbHPTROeeBqAlEyLum8TxF3JYc+ZmdwImo6blBAw+xxmb6BpiQixa2hyPn3JzbWfg
 hn96wwWE9bmqZOwrEdhWyCgTCVp18JfN88XbyaJiJftTmAP7KiS040tjRq3P17p+VfN+
 pt4kwVFK9eBVDEqYLtE0o4okBXXMrjbBBWh+Gzh8WRmmeXv7DY+8K7awbivu6etqSswI
 YhIvLpRVcQoLEAceDeGcp7HK2dWG8ir345jtgZC0Xn4gTHU+Nk5yUkaPG0sYkt011LL0
 9p2sczCf6aafJvc263XtRNpMQ59tY3+cvror1OhVctnPHewm/X2bRT9mTyjZz313F2kk
 KItA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4jXGpuyUJU+njo/teM2I4m2D+/Y8n0pAWqA30fl4KMKeNp0n4v8ptvC2VmJ3J9eICQCVq/R5C@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLBITrcHdeonLhqI2CRTLZyKiSheGhD244s06f2qUFEP87LPJL
 rXCpB4Oncwz5vWNM6AGx0uEnreO5xOQ6w8pUEsHN8PtDq7eVR50Qi6aT
X-Gm-Gg: ATEYQzy0hJSn7JfAqB5mLKQf3N6frCaE8+MpESKk8rBUMCoh18KNSFlGKJg+yI2wQnX
 JQV9HUxojMZF71s5BJ4qIW8/HuCFJUzPGwBi35Qlfv0adyAh0MbyOvpUNSgh8zX2cM5hfYGDoU8
 VYWXG57OOa2vXhTIgT1lOzccmPMDvVmbRqg03UOw8A1fmujn9t0UmZ/vmJPZFHP7+ulvv02BQjY
 9ihRyj7qTCGIYc0qGL9Hw42lUlGHtAFZtH1V0jG84GBlium9oMZZjSsPmb1a6BsiUForu/hff64
 cQ0SGhjhz2w5CXf2aMPeYTsmd6KN/N69XjS+acTTn0/12OBMn85pmn/W7m64bF+QoJTHuWLG3Iw
 ckWqJ1OhK4mDg1Th2AM95FAWOmrhtzL/CjqcHjaNxiPgJ2f3JQY5QeUYHljHRqpUqTYK8Rzgnpv
 wALtpAZiJ/vBsOFuNemkYkMIjJvrOHvBkyvKrlL9z2xq/3oRbPl3m1pvuUTQ==
X-Received: by 2002:a05:600c:41c4:b0:486:fc5f:1ab9 with SMTP id
 5b1f17b1804b1-48727d8410cmr71470085e9.14.1774707277993; 
 Sat, 28 Mar 2026 07:14:37 -0700 (PDT)
Received: from rhel.homenet.telecomitalia.it ([87.13.132.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48730628efasm80210335e9.5.2026.03.28.07.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 07:14:37 -0700 (PDT)
From: Adriano Vero <litaliano00.contact@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, alexander.deucher@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adriano Vero <litaliano00.contact@gmail.com>,
 Rodrigo.Siqueira@amd.com
Subject: [PATCH 2/2] drm/amd/display: remove manual DisplayID VRR parsing from
 freesync caps
Date: Sat, 28 Mar 2026 14:20:27 +0100
Message-ID: <20260328132027.22383-2-litaliano00.contact@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328132027.22383-1-litaliano00.contact@gmail.com>
References: <20260328132027.22383-1-litaliano00.contact@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Mar 2026 16:37:25 +0000
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

parse_edid_displayid_vrr() walked raw DisplayID bytes via struct edid*
to find Dynamic Video Timing Range Limits blocks when monitor_range
was zeroed. This is a layering violation.

Now that drm_get_monitor_range_displayid() in the DRM core fills
monitor_range from DisplayID Dynamic Video Timing blocks via the
proper displayid_iter infrastructure, parse_edid_displayid_vrr() is
redundant. Remove it and its drm_edid_raw() call from the VRR path.

drm_edid_raw() remains for parse_amd_vsdb() and parse_hdmi_amd_vsdb()
which read AMD vendor-specific CEA data blocks; those are tracked
separately.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo.Siqueira@amd.com
Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 61 ++++---------------
 1 file changed, 11 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 085cc98bd..c61d6e1fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13110,49 +13110,6 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 	return ret;
 }
 
-static void parse_edid_displayid_vrr(struct drm_connector *connector,
-				     const struct edid *edid)
-{
-	u8 *edid_ext = NULL;
-	int i;
-	int j = 0;
-	u16 min_vfreq;
-	u16 max_vfreq;
-
-	if (!edid || !edid->extensions)
-		return;
-
-	/* Find DisplayID extension */
-	for (i = 0; i < edid->extensions; i++) {
-		edid_ext = (void *)(edid + (i + 1));
-		if (edid_ext[0] == DISPLAYID_EXT)
-			break;
-	}
-
-	if (i == edid->extensions)
-		return;
-
-	while (j < EDID_LENGTH) {
-		/* Get dynamic video timing range from DisplayID if available */
-		if (EDID_LENGTH - j > 13 && edid_ext[j] == 0x25	&&
-		    (edid_ext[j+1] & 0xFE) == 0 && (edid_ext[j+2] == 9)) {
-			min_vfreq = edid_ext[j+9];
-			if (edid_ext[j+1] & 7)
-				max_vfreq = edid_ext[j+10] + ((edid_ext[j+11] & 3) << 8);
-			else
-				max_vfreq = edid_ext[j+10];
-
-			if (max_vfreq && min_vfreq) {
-				connector->display_info.monitor_range.max_vfreq = max_vfreq;
-				connector->display_info.monitor_range.min_vfreq = min_vfreq;
-
-				return;
-			}
-		}
-		j++;
-	}
-}
-
 static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			  const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
@@ -13288,13 +13245,17 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
 		goto update;
 
-	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
-
-	/* Some eDP panels only have the refresh rate range info in DisplayID */
-	if ((connector->display_info.monitor_range.min_vfreq == 0 ||
-	     connector->display_info.monitor_range.max_vfreq == 0))
-		parse_edid_displayid_vrr(connector, edid);
-
+	/**
+	 * monitor_range is now populated by the DRM core from both classic
+	 * EDID Monitor Range Limits descriptors and DisplayID Dynamic Video
+	 * Timing blocks (tag 0x25) via drm_get_monitor_range_displayid().
+	 * parse_edid_displayid_vrr() has been removed.
+	 *
+	 * drm_edid_raw() is retained only for parse_amd_vsdb() and
+	 * parse_hdmi_amd_vsdb() which read AMD vendor-specific CEA blocks.
+	 * Removing those raw accesses is tracked separately.
+	 */
+	edid = drm_edid_raw(drm_edid); /* TODO: amd/hdmi vsdb refactor */
 	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
 		if (amdgpu_dm_connector->dc_link &&
-- 
2.47.3


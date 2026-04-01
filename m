Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFDDD39421
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 12:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C1510F06A;
	Thu,  2 Apr 2026 12:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SICPlP6L";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 523A310E154
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 23:07:42 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-486fe36cfabso9283875e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 16:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775084861; x=1775689661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4vlVVvxWEWO2r6arzInv5eisxXfXrLq1ekNSjOyYGg=;
 b=SICPlP6LrMcX7I8Woje6nwADPWegQ+NO/eHLIuWRY5kmjn+JZ59HPHURRM8kbzJcAN
 Mp24hFmqBECizd88J4JK++d6CPDWHexdthEtzr8uOAr0ufYTkINNClLP3h6dW2vmUief
 L1pW72COMA4sEGHZBLwfxMThuhd78wj3BKEYqbKv2EVG5eyQ91acffSY3dmilYY/EUbl
 CmMX6cKZbTpURGRrWLI6e93rwlACp2uH4ZHL0yadncHP3aLxF8HFAidA7AbS7pRAjTRO
 /UkwdF32IYL9mv3xEEo/dKp1HE+vOHBTs95lBp8KHnsRBInsqlnnPTH5plHDXYiAohA1
 QoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775084861; x=1775689661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t4vlVVvxWEWO2r6arzInv5eisxXfXrLq1ekNSjOyYGg=;
 b=ZnKa/8kJMoBHVXixlnLfmUKknKfbC/FRS8ssgk27POp8bODzmrIoac36BtE5niik+r
 fRJ8vDWTcxIKC/OyxLh5FFeJqiZzl/HdwIijONdjtzVKn22PHfxNX27tAVEYWCynbadp
 jECwwWt97OI7K2vhyt/OoW8VOTo3Vf+NB5OKpJMy9sQ6lh2S649Y2u2N8jIwCrEcZEy6
 9v8YKVr9sHZWj/fr2fbqM4aNMS8l5m1RqGfs/irOYRpeu96i53Oe9SkcCe3Zu99SE2uT
 3KKZDOWbAadvpdHjewK6XqPlAvb6Di/1xqv3qHntaLB9Yj5VkwM4xOp7maj6CFqctmlf
 1yhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRJqnMgWh/2aubzfUc3cI6fbMjNEL/hkTFpkobgZEukiGkgpkf8FETE0H20Ij/wjR3Yb9EX35o@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRrvYoURAOLeRElCQV/DwA3Rmc4Lh7anhxfQ66QlGE7TmNWKDo
 hl9/rD/Ha0NcieE2pIW/fwGZjLVk+bV2C5DBbgBYnuGvdVdWM683hDqF
X-Gm-Gg: ATEYQzxVDgGS/7opkuCtycIjtPpY/07+NNmVcAEbND+yscymQOQrtM3A8DUw+qbapBH
 G3eOdxKH+6jRHk38anP7BW9vR5xVsLi0rpq5vxjAP1l6zvRzGfn6u52AL+1yhMfFWuzWx4+Y56J
 Z5918j6PVmP6ZxSvBOy/MSxyVYQf7TcyV1lyhbWsnV3G40KVJ/tCHr5MmIHXVBK2pu0UKf5fafQ
 lf/2Hu5iQsDBboT4oF4Cm/HiZM43g0EAiVUC86zHHg9kIpE/FF1qgkIq4j1uqXFR0ZUEWCgEA0l
 57ve0qyhEcMINtoe5qWZa4zUtrGX64TgKPp5BdGS9UrcPULx+dADpMAnY+6XGBYdz9ineH1n20C
 QJT/79DwoAF02reHlvXTtt7DlTF4kTdXA0OXHklJmSWBAaFrx8v46R29fgMdkWf+uGMusEJC38r
 QjhPQc7lsN8j96TZSJ2roXmjOqpD+Pb2TTEAFeAq/PE99hx3aXty+6/WV9oz+as34LfRvK
X-Received: by 2002:a05:600c:a405:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-4888e078f42mr2697135e9.8.1775084860569; 
 Wed, 01 Apr 2026 16:07:40 -0700 (PDT)
Received: from rhel.homenet.telecomitalia.it ([87.13.132.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887ad1cd86sm53682845e9.5.2026.04.01.16.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 16:07:40 -0700 (PDT)
From: Adriano Vero <litaliano00.contact@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, alexander.deucher@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adriano Vero <litaliano00.contact@gmail.com>,
 Rodrigo.Siqueira@amd.com
Subject: [PATCH v2 2/2] drm/amd/display: remove manual DisplayID VRR parsing
 from freesync caps
Date: Thu,  2 Apr 2026 01:07:25 +0200
Message-ID: <20260401230735.4866-2-litaliano00.contact@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401230735.4866-1-litaliano00.contact@gmail.com>
References: <20260328132027.22383-1-litaliano00.contact@gmail.com>
 <20260401230735.4866-1-litaliano00.contact@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 12:27:01 +0000
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


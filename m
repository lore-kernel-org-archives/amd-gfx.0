Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD91FD374D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 12:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EA510E768;
	Wed, 25 Feb 2026 12:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LG0hGPky";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A029C10E768;
 Wed, 25 Feb 2026 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9gJCFSAIdO/WwmC0k3iWLhjOpADrgzAG9vc7uKw84g4=; b=LG0hGPkyEV3CQfF8vn/glBj/gn
 ny8fmzlQZdnQ563yTlXoN+jHi+AtMX0iwI2EiplMw4CM++oqCyi5gUywNGwHqs7Vw+IF66gsWc9Rf
 Yd+v/oysUZRFXX4KucG0iwpye1uXOUDJ/jX0KN8hpj8aSkur5ZQXYSFpWmHGlg03iqMNc6FC4xcyQ
 RdmXvbQSrEYs7mQ2nMaCpFPE/GLJ9I8dmCNXZnSG5GZDyOePBjhXpnYG07OmwH354wlwONC8MqZLO
 AOqMNzpONrUnssprTu0bTsJewpsqS+c/JUtvEmurktYuXCxPlhvN0B93l+edPaOZyyFWZUhtaK33r
 9tW9+JVA==;
Received: from [186.208.68.119] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vvDs1-005DpP-Bd; Wed, 25 Feb 2026 13:20:01 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 andrzej.hajda@intel.com, christian.koenig@amd.com, harry.wentland@amd.com,
 jernej.skrabec@gmail.com, jonas@kwiboo.se,
 Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mario.limonciello@amd.com, mripard@kernel.org, mwen@igalia.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Michel Daenzer <michel.daenzer@mailbox.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: [PATCH v8 8/8] drm/amd/display: get SADB from drm_eld when parsing
 EDID caps
Date: Wed, 25 Feb 2026 09:04:37 -0300
Message-ID: <20260225121903.236115-9-mwen@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225121903.236115-1-mwen@igalia.com>
References: <20260225121903.236115-1-mwen@igalia.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm_edid_connector_update() updates display info, filling ELD with
speaker allocation data in the last step of update_dislay_info(). Our
goal is stopping using raw edid, so we can extract SADB from drm_eld
instead of access raw edid to get audio caps.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 519b80f43b90..4f0e8e46f0bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -108,9 +108,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	struct edid *edid_buf = edid ? (struct edid *) edid->raw_edid : NULL;
 	const struct drm_edid *drm_edid;
 	struct drm_edid_product_id product_id;
-	int sad_count, sadb_count;
+	int sad_count;
 	int i = 0;
-	uint8_t *sadb = NULL;
 	enum dc_edid_status result = EDID_OK;
 
 
@@ -161,20 +160,11 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 		edid_caps->audio_modes[i].sample_size = sad.byte2;
 	}
 
-	sadb_count = drm_edid_to_speaker_allocation((struct edid *) edid->raw_edid, &sadb);
-
-	if (sadb_count < 0) {
-		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sadb_count);
-		sadb_count = 0;
-	}
-
-	if (sadb_count)
-		edid_caps->speaker_flags = sadb[0];
+	if (connector->eld[DRM_ELD_SPEAKER])
+		edid_caps->speaker_flags = connector->eld[DRM_ELD_SPEAKER];
 	else
 		edid_caps->speaker_flags = DEFAULT_SPEAKER_LOCATION;
 
-	kfree(sadb);
-
 cleanup:
 	drm_edid_free(drm_edid);
 	return result;
-- 
2.51.0


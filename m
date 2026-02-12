Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70654EEA867
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 22:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FA710E2B0;
	Thu, 12 Feb 2026 22:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="YxDEpIan";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E23B10E2B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 22:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-953a8a3ca9;
 t=1770934862; bh=ZdD61gljRvIt18ORo8tDhe54NGz5CMuWinFzJxPQCGg=;
 b=YxDEpIanbg1VN4XkGBD0RXbofgHuhUGuAENSi4Tq/RDUTEo+pxSUZ0psgKY4T58oZlQioDNZD
 zPA5E9MuWlnzOtFeX8/ghdLvy23JByFJVUHzQXi7Ycc0YNYy67nQMVPDfQtjAkpP+VI9m7YxsZM
 +l8cW54IOP4OLr7iCDAX+53cIJOmj5p9/A1cadA+/wZ/3dyEAKJ5wk0RYK/FnhBHrw9LzrYR8Tq
 O7hrfbAMAwKXeLz5PvGdvjfsHgx6iqjgfJQQcD/H+j2D67/0L+hnk4eGfuIzkx3ea6jIanpJe91
 tBgkuIgLf+iZyXwRbD3krd6b5HfQV0bcxB3mrQ8xfcIg==
X-Forward-Email-ID: 698e524d1cff1f790f797192
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Joshua Peisach <jpeisach@ubuntu.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Joshua Peisach <jpeisach@ubuntu.com>
Subject: [PATCH 1/2] drm/amdgpu/amdgpu_connectors: use struct drm_edid instead
 of struct edid
Date: Thu, 12 Feb 2026 17:20:28 -0500
Message-ID: <20260212222029.15777-2-jpeisach@ubuntu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260212222029.15777-1-jpeisach@ubuntu.com>
References: <20260212222029.15777-1-jpeisach@ubuntu.com>
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

Some amdgpu code is still using deprecated edid functions. Switch to
the newer functions and update the amdgpu_connector struct's edid type
to the drm_edid type.

At the same time, use the raw EDID when we need to for speaker
allocations and for determining if the input is digital.

Signed-off-by: Joshua Peisach <jpeisach@ubuntu.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 32 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  4 +--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  4 +--
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index d3e312bda..ab83b3a87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -246,10 +246,10 @@ amdgpu_connector_find_encoder(struct drm_connector *connector,
 	return NULL;
 }
 
-static struct edid *
+static const struct drm_edid *
 amdgpu_connector_get_hardcoded_edid(struct amdgpu_device *adev)
 {
-	return drm_edid_duplicate(drm_edid_raw(adev->mode_info.bios_hardcoded_edid));
+	return drm_edid_dup(adev->mode_info.bios_hardcoded_edid);
 }
 
 static void amdgpu_connector_get_edid(struct drm_connector *connector)
@@ -268,8 +268,8 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
 	if ((amdgpu_connector_encoder_get_dp_bridge_encoder_id(connector) !=
 	     ENCODER_OBJECT_ID_NONE) &&
 	    amdgpu_connector->ddc_bus->has_aux) {
-		amdgpu_connector->edid = drm_get_edid(connector,
-						      &amdgpu_connector->ddc_bus->aux.ddc);
+		amdgpu_connector->edid = drm_edid_read_ddc(connector,
+							  &amdgpu_connector->ddc_bus->aux.ddc);
 	} else if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
 		   (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
 		struct amdgpu_connector_atom_dig *dig = amdgpu_connector->con_priv;
@@ -277,14 +277,14 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
 		if ((dig->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT ||
 		     dig->dp_sink_type == CONNECTOR_OBJECT_ID_eDP) &&
 		    amdgpu_connector->ddc_bus->has_aux)
-			amdgpu_connector->edid = drm_get_edid(connector,
-							      &amdgpu_connector->ddc_bus->aux.ddc);
+			amdgpu_connector->edid = drm_edid_read_ddc(connector,
+								  &amdgpu_connector->ddc_bus->aux.ddc);
 		else if (amdgpu_connector->ddc_bus)
-			amdgpu_connector->edid = drm_get_edid(connector,
-							      &amdgpu_connector->ddc_bus->adapter);
+			amdgpu_connector->edid = drm_edid_read_ddc(connector,
+								  &amdgpu_connector->ddc_bus->adapter);
 	} else if (amdgpu_connector->ddc_bus) {
-		amdgpu_connector->edid = drm_get_edid(connector,
-						      &amdgpu_connector->ddc_bus->adapter);
+		amdgpu_connector->edid = drm_edid_read_ddc(connector,
+							  &amdgpu_connector->ddc_bus->adapter);
 	}
 
 	if (!amdgpu_connector->edid) {
@@ -292,7 +292,7 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
 		if (((connector->connector_type == DRM_MODE_CONNECTOR_LVDS) ||
 		     (connector->connector_type == DRM_MODE_CONNECTOR_eDP))) {
 			amdgpu_connector->edid = amdgpu_connector_get_hardcoded_edid(adev);
-			drm_connector_update_edid_property(connector, amdgpu_connector->edid);
+			drm_edid_connector_update(connector, amdgpu_connector->edid);
 		}
 	}
 }
@@ -311,11 +311,11 @@ static int amdgpu_connector_ddc_get_modes(struct drm_connector *connector)
 	int ret;
 
 	if (amdgpu_connector->edid) {
-		drm_connector_update_edid_property(connector, amdgpu_connector->edid);
-		ret = drm_add_edid_modes(connector, amdgpu_connector->edid);
+		drm_edid_connector_update(connector, amdgpu_connector->edid);
+		ret = drm_edid_connector_add_modes(connector);
 		return ret;
 	}
-	drm_connector_update_edid_property(connector, NULL);
+	drm_edid_connector_update(connector, NULL);
 	return 0;
 }
 
@@ -883,7 +883,7 @@ amdgpu_connector_vga_detect(struct drm_connector *connector, bool force)
 			ret = connector_status_connected;
 		} else {
 			amdgpu_connector->use_digital =
-				!!(amdgpu_connector->edid->input & DRM_EDID_INPUT_DIGITAL);
+				drm_edid_is_digital(amdgpu_connector->edid);
 
 			/* some oems have boards with separate digital and analog connectors
 			 * with a shared ddc line (often vga + hdmi)
@@ -1063,7 +1063,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 			broken_edid = true; /* defer use_digital to later */
 		} else {
 			amdgpu_connector->use_digital =
-				!!(amdgpu_connector->edid->input & DRM_EDID_INPUT_DIGITAL);
+				drm_edid_is_digital(amdgpu_connector->edid);
 
 			/* some oems have boards with separate digital and analog connectors
 			 * with a shared ddc line (often vga + hdmi)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index dc8d2f52c..c4e025581 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -624,7 +624,7 @@ struct amdgpu_connector {
 	bool use_digital;
 	/* we need to mind the EDID between detect
 	   and get modes due to analog/digital/tvencoder */
-	struct edid *edid;
+	const struct drm_edid *edid;
 	void *con_priv;
 	bool dac_load_detect;
 	bool detected_by_load; /* if the connection status was determined by load */
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 72ca6538b..b456a6ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1298,7 +1298,7 @@ static void dce_v10_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 		return;
 	}
 
-	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
+	sad_count = drm_edid_to_speaker_allocation(drm_edid_raw(amdgpu_connector->edid), &sadb);
 	if (sad_count < 0) {
 		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
@@ -1368,7 +1368,7 @@ static void dce_v10_0_audio_write_sad_regs(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
+	sad_count = drm_edid_to_sad(drm_edid_raw(amdgpu_connector->edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index acc887a58..13496ba38 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1265,7 +1265,7 @@ static void dce_v6_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
+	sad_count = drm_edid_to_speaker_allocation(drm_edid_raw(amdgpu_connector->edid), &sadb);
 	if (sad_count < 0) {
 		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
@@ -1346,7 +1346,7 @@ static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
+	sad_count = drm_edid_to_sad(drm_edid_raw(amdgpu_connector->edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 2ccd6aad8..63687c40f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1271,7 +1271,7 @@ static void dce_v8_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
+	sad_count = drm_edid_to_speaker_allocation(drm_edid_raw(amdgpu_connector->edid), &sadb);
 	if (sad_count < 0) {
 		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
@@ -1339,7 +1339,7 @@ static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
+	sad_count = drm_edid_to_sad(drm_edid_raw(amdgpu_connector->edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
-- 
2.51.0


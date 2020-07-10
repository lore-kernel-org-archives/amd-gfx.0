Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9221DC433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 15:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6202C20748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRADmvaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6202C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5606E172;
	Fri, 10 Jul 2020 15:46:30 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4126E172
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 15:46:28 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id b185so5688708qkg.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P6z1G8txfqssgFRtz+LNJFnevFsy2ol0KInQwzto7Vk=;
 b=MRADmvajsQOsHmUwC4jo5+AcN692xA2AWiQ+tdS+ijIGOlE8zYDXoxHSs93mwD0wLz
 znYoU47/S8jUUp2NZajyeE6UpHItV4FBWhXpCPjwIW4eUotMTNUHysDyvpoqRgvIkl8Q
 /xWqW2Y6DPNpWynZXguI5tIzdBWk+QPepSDjapjSAwVoXRVukNkzE+6KPc83Pn9l1rKG
 a/Xn0cZK7/0PDu9EupVO9oWxWZVFWfc9dzW0fNCSbDx4+a/oa2I1sXX8SDBeTskwz93S
 QPGW2gEGR3aflwyeldg6VbIolI7Ncntm8p/nrEA9LFQcBJ43VfpdO++MwX0QFsL3bg1z
 FFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P6z1G8txfqssgFRtz+LNJFnevFsy2ol0KInQwzto7Vk=;
 b=o/VNTj8z9WSn3AsLQK/4aXsSgHFTpqEtGo/hG9Rr1ZlW/CrutoCANwr2dl7L7kzBac
 dovdnFfXwYNfjEZdhy/4c1RmRFGpHBzSrSRAkNDMVST583o44pPuyUpyHhrWZ+ZyzgUm
 VQpTtJfts6EY8dPnmd7WdTVKynJbZANFrVx2vglVIo//mFikNWzucojFD98RISA0zDvV
 v3B4uwz5dIUIdxgDQrHIOpT3PpKemysUwlqG/lBctdUnpciy5dvmIg1kicQFDJo+MIme
 EC9rJk8Zjyl9z1BvQUHc4DdygAxjDveBy4WyNpSK+NfE//sf7/zhFNnFEoAEPhIrkrUm
 jisw==
X-Gm-Message-State: AOAM532MCVkMnfcudEXHiS3WPX7D8dDzrx6Pcnkoby71kG1BYhvsZ6Mq
 y7RbEbbj93cyCipwzkAduu9GK04/
X-Google-Smtp-Source: ABdhPJy4AS5TbldkG8XYuOZTGwKKvHO9WmxDo9bQF8v90xRrxGO45/YSLwCHo6RaQxRxITiEpEbT2w==
X-Received: by 2002:a37:5a45:: with SMTP id o66mr35499447qkb.137.1594395987775; 
 Fri, 10 Jul 2020 08:46:27 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id r5sm8526500qtc.20.2020.07.10.08.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 08:46:26 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: create fake mst encoders ahead of time
 (v3)
Date: Fri, 10 Jul 2020 11:46:19 -0400
Message-Id: <20200710154619.1007229-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prevents a warning in the MST create connector case.

v2: create global fake encoders rather per connector fake encoders
to avoid running out of encoder indices.

v3: use the actual number of crtcs on the asic rather than the max
to conserve encoders.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1108
Fixes: c6385e503aeaf9 ("drm/amdgpu: drop legacy drm load and unload callbacks")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 ++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 11 +++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 53 +++++++++----------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  3 ++
 4 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0e5d99a85307..6f937e25a62c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -978,6 +978,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	/* Update the actual used number of crtc */
 	adev->mode_info.num_crtc = adev->dm.display_indexes_num;
 
+	/* create fake encoders for MST */
+	dm_dp_create_fake_mst_encoders(adev);
+
 	/* TODO: Add_display_info? */
 
 	/* TODO use dynamic cursor width */
@@ -1001,6 +1004,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 static void amdgpu_dm_fini(struct amdgpu_device *adev)
 {
+	int i;
+
+	for (i = 0; i < adev->dm.display_indexes_num; i++) {
+		drm_encoder_cleanup(&adev->dm.mst_encoders[i].base);
+	}
+
 	amdgpu_dm_audio_fini(adev);
 
 	amdgpu_dm_destroy_drm_device(&adev->dm);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 86c132ddc452..3f50328fe537 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -43,6 +43,9 @@
  */
 
 #define AMDGPU_DM_MAX_DISPLAY_INDEX 31
+
+#define AMDGPU_DM_MAX_CRTC 6
+
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
@@ -330,6 +333,13 @@ struct amdgpu_display_manager {
 	 * available in FW
 	 */
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
+
+	/**
+	 * @mst_encoders:
+	 *
+	 * fake encoders used for DP MST.
+	 */
+	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
 };
 
 struct amdgpu_dm_connector {
@@ -358,7 +368,6 @@ struct amdgpu_dm_connector {
 	struct amdgpu_dm_dp_aux dm_dp_aux;
 	struct drm_dp_mst_port *port;
 	struct amdgpu_dm_connector *mst_port;
-	struct amdgpu_encoder *mst_encoder;
 	struct drm_dp_aux *dsc_aux;
 
 	/* TODO see if we can merge with ddc_bus or make a dm_connector */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index cf15248739f7..176973da18ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -95,7 +95,6 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector =
 		to_amdgpu_dm_connector(connector);
-	struct amdgpu_encoder *amdgpu_encoder = aconnector->mst_encoder;
 
 	if (aconnector->dc_sink) {
 		dc_link_remove_remote_sink(aconnector->dc_link,
@@ -105,8 +104,6 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
 
 	kfree(aconnector->edid);
 
-	drm_encoder_cleanup(&amdgpu_encoder->base);
-	kfree(amdgpu_encoder);
 	drm_connector_cleanup(connector);
 	drm_dp_mst_put_port_malloc(aconnector->port);
 	kfree(aconnector);
@@ -243,7 +240,11 @@ static struct drm_encoder *
 dm_mst_atomic_best_encoder(struct drm_connector *connector,
 			   struct drm_connector_state *connector_state)
 {
-	return &to_amdgpu_dm_connector(connector)->mst_encoder->base;
+	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(connector_state->crtc);
+
+	return &adev->dm.mst_encoders[acrtc->crtc_id].base;
 }
 
 static int
@@ -306,31 +307,27 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
 	.destroy = amdgpu_dm_encoder_destroy,
 };
 
-static struct amdgpu_encoder *
-dm_dp_create_fake_mst_encoder(struct amdgpu_dm_connector *connector)
+void
+dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev)
 {
-	struct drm_device *dev = connector->base.dev;
-	struct amdgpu_device *adev = dev->dev_private;
-	struct amdgpu_encoder *amdgpu_encoder;
-	struct drm_encoder *encoder;
-
-	amdgpu_encoder = kzalloc(sizeof(*amdgpu_encoder), GFP_KERNEL);
-	if (!amdgpu_encoder)
-		return NULL;
+	struct drm_device *dev = adev->ddev;
+	int i;
 
-	encoder = &amdgpu_encoder->base;
-	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(adev);
+	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+		struct amdgpu_encoder *amdgpu_encoder = &adev->dm.mst_encoders[i];
+		struct drm_encoder *encoder = &amdgpu_encoder->base;
 
-	drm_encoder_init(
-		dev,
-		&amdgpu_encoder->base,
-		&amdgpu_dm_encoder_funcs,
-		DRM_MODE_ENCODER_DPMST,
-		NULL);
+		encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(adev);
 
-	drm_encoder_helper_add(encoder, &amdgpu_dm_encoder_helper_funcs);
+		drm_encoder_init(
+			dev,
+			&amdgpu_encoder->base,
+			&amdgpu_dm_encoder_funcs,
+			DRM_MODE_ENCODER_DPMST,
+			NULL);
 
-	return amdgpu_encoder;
+		drm_encoder_helper_add(encoder, &amdgpu_dm_encoder_helper_funcs);
+	}
 }
 
 static struct drm_connector *
@@ -343,6 +340,7 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
+	int i;
 
 	aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
 	if (!aconnector)
@@ -369,9 +367,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 		master->dc_link,
 		master->connector_id);
 
-	aconnector->mst_encoder = dm_dp_create_fake_mst_encoder(master);
-	drm_connector_attach_encoder(&aconnector->base,
-				     &aconnector->mst_encoder->base);
+	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+		drm_connector_attach_encoder(&aconnector->base,
+					     &adev->dm.mst_encoders[i].base);
+	}
 
 	connector->max_bpc_property = master->base.max_bpc_property;
 	if (connector->max_bpc_property)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index d2c56579a2cc..b38bd68121ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -35,6 +35,9 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 				       struct amdgpu_dm_connector *aconnector,
 				       int link_index);
 
+void
+dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev);
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 				       struct dc_state *dc_state);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

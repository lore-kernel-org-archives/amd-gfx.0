Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB61C00523
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 04:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451BA20848
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 04:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZFu57JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451BA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2765B6E167;
	Wed,  8 Jan 2020 04:05:43 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834AC6E167
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 04:05:42 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id l14so309084ywj.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 20:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OZjkk0PdDS4r3gj6qOxkDAI3LvQy/B054o6wmq3l2iw=;
 b=BZFu57JPky3ck7ZAW+vVHWQWzSIu83g7HwJ6aFYLA0qOUGRpKyH6mIFf6rUbQqFvKC
 OGoKmAw4siRhbc1uxtl8ZzJcAB1p19L7YFniWHUBiYU3oAtJK8D2vBHWl6st441p/zIE
 ADHhArSfh1SaIFqlMwxJlf7y2tKlTFYmZy3uFxE4GRKJmyBCgXLVnWNLedarqetewjSa
 Nd9qtad9bJ7uiSxZCX/HJQxwN+it1j1xN3xCkpffv2ynHYL/tHyu7iqOmkhKQeafZQic
 VMXPvQQaTW5fR/LH2HPRl8EoQl6jQCHb6btCd91ArQMjQOX5DXIUBF+rYoF0kNURFFio
 0GQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OZjkk0PdDS4r3gj6qOxkDAI3LvQy/B054o6wmq3l2iw=;
 b=TG13vCv5pwQoPhh/Vsj2/mBD6ZOz3pBFLF86tw/A/dCGI8kdJ5eGFCwLphJqiFTa+N
 p29uDZjFlWk1kS7dOpkrpyRR4E7+mdPvADUcI95SDI9/rk4k60hxPwiFd96TsRVY0Bc/
 T4tenhPHQGR3iAVRkW8arQeYKpip9P0BqkTFKcJ8E4mLEXc3Who5RdSoni1+Cu+hyho9
 fTSIjpyMYW85gY2aQuD1NzVu/GQyHuFptjKVaTCXcszuSNZfYQUGUhpw4ye4KH+D7KWo
 /ApKLwXG1ffaK82Vf7ID/oT+TPAKVYnbAuGiWP9jTn3Hhrv57I/5G2BL9ub5Wfrr/hqj
 YaHw==
X-Gm-Message-State: APjAAAVs/NZ9rCu/laBrXgUkhQM9yb7e2SPju/z+wxDJ+Ewkw9+KktH2
 oFufk6gzaCI9a4UfS5w/meaM8e/+
X-Google-Smtp-Source: APXvYqyd0RtZX7aXqYEUgzsZ23QOlZifhbp0UwMpDRR6x2xnnbq9l4b6HQyVcyybBBjOmDqebDr3iw==
X-Received: by 2002:a81:7785:: with SMTP id s127mr2018156ywc.427.1578456341445; 
 Tue, 07 Jan 2020 20:05:41 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l32sm922049ywh.29.2020.01.07.20.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 20:05:40 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: protect new DSC code with
 CONFIG_DRM_AMD_DC_DCN
Date: Tue,  7 Jan 2020 23:05:32 -0500
Message-Id: <20200108040532.1861559-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Otherwise we get undefined symbols.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |  4 ++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 10 ++++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |  4 +++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3be7ab0ce9e3..60d6d3b41239 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4959,6 +4959,7 @@ const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs = {
 	.atomic_check = dm_encoder_helper_atomic_check
 };
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 					    struct dc_state *dc_state)
 {
@@ -5021,6 +5022,7 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 	}
 	return 0;
 }
+#endif
 
 static void dm_drm_plane_reset(struct drm_plane *plane)
 {
@@ -8156,12 +8158,14 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		if (ret)
 			goto fail;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (!compute_mst_dsc_configs_for_state(state, dm_state->context))
 			goto fail;
 
 		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context);
 		if (ret)
 			goto fail;
+#endif
 
 		if (dc_validate_global_state(dc, dm_state->context, false) != DC_OK) {
 			ret = -EINVAL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7911c5dac424..5a476028ee37 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -42,7 +42,9 @@
 #endif
 
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dc/dcn20/dcn20_resource.h"
+#endif
 
 /* #define TRACE_DPCD */
 
@@ -185,6 +187,7 @@ static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
 	.early_unregister = amdgpu_dm_mst_connector_early_unregister,
 };
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_sink *dc_sink = aconnector->dc_sink;
@@ -206,6 +209,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 
 	return true;
 }
+#endif
 
 static int dm_dp_mst_get_modes(struct drm_connector *connector)
 {
@@ -253,9 +257,11 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			amdgpu_dm_update_freesync_caps(
 					connector, aconnector->edid);
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 			if (!validate_dsc_caps_on_connector(aconnector))
 				memset(&aconnector->dc_sink->sink_dsc_caps,
 				       0, sizeof(aconnector->dc_sink->sink_dsc_caps));
+#endif
 		}
 	}
 
@@ -506,6 +512,8 @@ int dm_mst_get_pbn_divider(struct dc_link *link)
 			dc_link_get_link_cap(link)) / (8 * 1000 * 54);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+
 struct dsc_mst_fairness_params {
 	struct dc_crtc_timing *timing;
 	struct dc_sink *sink;
@@ -874,3 +882,5 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 
 	return true;
 }
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index d451ce9cecc0..d6813ce67bbd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -34,7 +34,9 @@ int dm_mst_get_pbn_divider(struct dc_link *link);
 void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 				       struct amdgpu_dm_connector *aconnector);
 
-
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 				       struct dc_state *dc_state);
 #endif
+
+#endif
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

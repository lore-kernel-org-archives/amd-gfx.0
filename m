Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB8C4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 17:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943C8613F9
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 17:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943C8613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0382D6F621;
	Fri,  4 Jun 2021 17:16:30 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C3E6E12A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 16:59:43 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id c15so7491888qte.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Jun 2021 09:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bh04H7Tcy+Yj9VMjnrHi1k31kTkyYQ9k7jX6b4bdZfw=;
 b=C6Zw4MMP63rzKfA7qlVqEcesd/tAoSiqWlvgE+anqg/Gyg+3tA5SN7znWdKVzOplLD
 4M0mnc5RJk55rwrZ9zPrvPsDPUj2eYB5eR7O87CO56MFGK2kSxughd0abuAkV0IPSPQ6
 RQAKfLGRTQ4f0+lTh9pyTeKs6QBIqOGkqz0xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bh04H7Tcy+Yj9VMjnrHi1k31kTkyYQ9k7jX6b4bdZfw=;
 b=ljM/3paWBzfY+qtmoCHS5FDWiYwfiD7omQZ35yVIkNfRoi1sOdWsdtcjR+wqb1ZJ5D
 LFd/6xDYERHFWtlFn1g32EcWsJHSb2lEJ4dlFxqY+4aTICCALVXuBN14vFkOAFFi+ap/
 +zCwoJSlvjbwxrMLdHFjeXki30ryCfmY5fMbWtt3lUupyT7vppbCtphh+3Rr9r/e7kcm
 XSPfdQeZ7hw14bBi+1xCV49FwR/2W3R7gDJlSj9p7DEP8dQtt7UcqZX5evj9oRzf0X26
 ETJ/yj3kMegl3odC4Pc0M9wpg5Eygle9ycSO5kg0+B0gz0v/iqgUo6nOxCTrDTlNnoS1
 FFFA==
X-Gm-Message-State: AOAM533VOXOP2d82GWquPcVwemO2INanhAVcwlwbgXW8HGxlLrQIB/q/
 syyKZYd2HLkY47GywDxuS7nm+T4SfgSbhQ==
X-Google-Smtp-Source: ABdhPJxYVXfJLm2LsTzKrH6wYmuyscFqtBbSN+dVKkvwurFsDkXTZkWQLKpE9plljFl7tAg8PQ71eg==
X-Received: by 2002:a05:622a:3c6:: with SMTP id
 k6mr5480762qtx.341.1622825982348; 
 Fri, 04 Jun 2021 09:59:42 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com
 ([2620:0:1003:416:a12b:207e:d5a0:e673])
 by smtp.gmail.com with ESMTPSA id j127sm4421788qke.90.2021.06.04.09.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jun 2021 09:59:41 -0700 (PDT)
From: Mark Yacoub <markyacoub@chromium.org>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] Verify Gamma & Degamma LUT sizes in amdgpu_dm_atomic_check
Date: Fri,  4 Jun 2021 12:59:38 -0400
Message-Id: <20210604165938.2022663-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 04 Jun 2021 17:16:27 +0000
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
Cc: alexander.deucher@amd.com, rodrigo.siqueira@amd.com,
 Mark Yacoub <markyacoub@chromium.org>, seanpaul@chromium.org,
 Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mark Yacoub <markyacoub@google.com>

For each CRTC state, check the size of Gamma and Degamma LUTs  so
unexpected and larger sizes wouldn't slip through.

TEST: IGT:kms_color::pipe-invalid-gamma-lut-sizes

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 40 ++++++++++++++++---
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 38d497d30dba8..f6cd522b42a80 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9402,6 +9402,9 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			dm_old_crtc_state->dsc_force_changed == false)
 			continue;
 
+		if ((ret = amdgpu_dm_verify_lut_sizes(new_crtc_state)))
+			goto fail;
+
 		if (!new_crtc_state->enable)
 			continue;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 8bfe901cf2374..1b77cd2612691 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -541,6 +541,7 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev);
 #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
 
 void amdgpu_dm_init_color_mod(void);
+int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
 int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
 int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 				      struct dc_plane_state *dc_plane_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 157fe4efbb599..da6f9fcc0b415 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -284,6 +284,37 @@ static int __set_input_tf(struct dc_transfer_func *func,
 	return res ? 0 : -ENOMEM;
 }
 
+/**
+ * Verifies that the Degamma and Gamma LUTs attached to the |crtc_state| are of
+ * the expected size.
+ * Returns 0 on success.
+ */
+int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
+{
+	const struct drm_color_lut *lut = NULL;
+	uint32_t size = 0;
+
+	lut = __extract_blob_lut(crtc_state->degamma_lut, &size);
+	if (lut && size != MAX_COLOR_LUT_ENTRIES) {
+		DRM_DEBUG_DRIVER(
+			"Invalid Degamma LUT size. Should be %u but got %u.\n",
+			MAX_COLOR_LUT_ENTRIES, size);
+		return -EINVAL;
+	}
+
+	lut = __extract_blob_lut(crtc_state->gamma_lut, &size);
+	if (lut && size != MAX_COLOR_LUT_ENTRIES &&
+	    size != MAX_COLOR_LEGACY_LUT_ENTRIES) {
+		DRM_DEBUG_DRIVER(
+			"Invalid Gamma LUT size. Should be %u (or %u for legacy) but got %u.\n",
+			MAX_COLOR_LUT_ENTRIES, MAX_COLOR_LEGACY_LUT_ENTRIES,
+			size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC stream.
  * @crtc: amdgpu_dm crtc state
@@ -317,14 +348,11 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 	bool is_legacy;
 	int r;
 
-	degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
-	if (degamma_lut && degamma_size != MAX_COLOR_LUT_ENTRIES)
-		return -EINVAL;
+	if ((r = amdgpu_dm_verify_lut_sizes(&crtc->base)))
+		return r;
 
+	degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
 	regamma_lut = __extract_blob_lut(crtc->base.gamma_lut, &regamma_size);
-	if (regamma_lut && regamma_size != MAX_COLOR_LUT_ENTRIES &&
-	    regamma_size != MAX_COLOR_LEGACY_LUT_ENTRIES)
-		return -EINVAL;
 
 	has_degamma =
 		degamma_lut && !__is_lut_linear(degamma_lut, degamma_size);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

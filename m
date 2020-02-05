Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9A2C3524B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 03:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E2A2072B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 03:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAN5xjdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E2A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACC16F464;
	Wed,  5 Feb 2020 03:49:18 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8056F464;
 Wed,  5 Feb 2020 03:49:16 +0000 (UTC)
Received: by mail-pl1-x643.google.com with SMTP id y1so289303plp.7;
 Tue, 04 Feb 2020 19:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9aDTcgd6K3FAKk5HdP+fv9xU5kzD6Uz3SUrcwxPQ0SM=;
 b=ZAN5xjdMmvcTQ7ChhBvDoOtd5BlBBEX52tXnohLBBshRT/TYtgN3zPAME05kTCqNxE
 LyPxE9nVmLpMzTqw5SufqDopm74J/wFobLCnR4DMJq/YC/lxp1vb3VRtBZ2EHlEbh5cZ
 e82sL5tldSOXqzMDspLlxh63ovCQqQrFc3uJ8Ls4YpauqjZJKsUMWkSb26Gvxwg7jjmv
 xE0Nt0GSeY0gRY0ywY/bJmiqWQxSVSKtQC1jcFkVZql5b+J6+7y5hezcddDv26+78kfH
 daD7EQ1mS4L4fOAv24vZvP7eFl4l/ORcjYCH+bMFfhr8UTPs0CPL1lbaokUu8NcJDrGp
 k9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9aDTcgd6K3FAKk5HdP+fv9xU5kzD6Uz3SUrcwxPQ0SM=;
 b=mLm2COzjyFj01lHCZgCQiX0o4jwQr8BQ5G+dSWtF9v3v5TKwfzQFBAEYCg2XcwPa+I
 isdf5roTXmRRSDrq541U0fHVuis6+NpJ9hsgXclLli/eMah/f82hYWUC/+87tlC2rGKv
 YnK3FEDlpvVKlxllqJsAUNvn6tYTe2ncraWxpQMNDQkGlkQgDewq96wrmja09DdMn3OP
 fe1wd5Y2fjSFzMPUfhANF2ylwM7U95xP4zJsR0SkW+6SXchn6LZ6z1n+xvuGIrFKGioq
 A7x6kCM5esIVCUJx5Wr2GbbvY6vC/l8KLLn9drvbV3IGYTBAgqzBnobWiAGt1TSrZMhe
 kjXg==
X-Gm-Message-State: APjAAAV0YGeerofabE5m4BgLn5rncFBrxoEyKRSlEo7AxT+UuFuxJoiE
 FaPKmq+Caj8jw782hB1sc8HLEyAG
X-Google-Smtp-Source: APXvYqwbISoDX74M+dv40baLoLuwFbVrg3KALDo1iO5DeZ6+YWTXPrFVwFfYeS8eni5avV0IV1QOdQ==
X-Received: by 2002:a17:90a:a08e:: with SMTP id
 r14mr3214764pjp.120.1580874555778; 
 Tue, 04 Feb 2020 19:49:15 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id 200sm25320292pfz.121.2020.02.04.19.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 19:49:15 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 09/14] drm/amdgpu: don't call drm_connector_register for
 non-MST ports
Date: Tue,  4 Feb 2020 22:48:47 -0500
Message-Id: <20200205034852.4157-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205034852.4157-1-alexander.deucher@amd.com>
References: <20200205034852.4157-1-alexander.deucher@amd.com>
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

The core does this for us now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c          | 1 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index a62cbc8199de..ec1501e3a63a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -1931,7 +1931,6 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 		connector->polled = DRM_CONNECTOR_POLL_HPD;
 
 	connector->display_info.subpixel_order = subpixel_order;
-	drm_connector_register(connector);
 
 	if (has_aux)
 		amdgpu_atombios_dp_aux_init(amdgpu_connector);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index e4f94863332c..3c9f2d2490a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -609,7 +609,6 @@ static int dce_virtual_connector_encoder_init(struct amdgpu_device *adev,
 	connector->display_info.subpixel_order = SubPixelHorizontalRGB;
 	connector->interlace_allowed = false;
 	connector->doublescan_allowed = false;
-	drm_connector_register(connector);
 
 	/* link them */
 	drm_connector_attach_encoder(connector, encoder);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d0ddbc9df264..7c094bfe07e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5839,7 +5839,6 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	drm_connector_attach_encoder(
 		&aconnector->base, &aencoder->base);
 
-	drm_connector_register(&aconnector->base);
 #if defined(CONFIG_DEBUG_FS)
 	connector_debugfs_init(aconnector);
 	aconnector->debugfs_dpcd_address = 0;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

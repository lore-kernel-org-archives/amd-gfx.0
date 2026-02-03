Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCE2E83EF4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B0810E4CA;
	Wed,  4 Feb 2026 08:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D1YdAJ5E";
	dkim-atps=neutral
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B193810E72D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:34 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id
 a640c23a62f3a-b8715908e58so58238566b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770144993; x=1770749793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnHVkr75tm1Yp6ZOCu5HkXcq6YZSjcDNrXJkhT+PUDY=;
 b=D1YdAJ5EkCJYeGAQilERqpkF9666Ssr4UVLh9wquy7NJ49sYLLQIdOihnOGFEz07nB
 QxkDSRBfMjCyiISVt12tI9FQ3yLvD1weVJ+pdyteLqx/+gs68NXMYAx0OxZTf7tOcSgr
 NLI/U5fkGXgOtNALcP37BcWpF2oK8uonguVrtSdO2OL1tJd8Mo6syQeAoARYChaZ6DgR
 7BWRXb7aDXqTsdVivrKWhQ5t6jLHuUtxAnHxWi6Yl/7xFNHCmsfIadXSYGNWwZ1R7wze
 8pbTTvIWAwhXelrumqeh09bqgHgiuS5Pv8bw6/tTvo+W7oXMh0WREEpu7gniKZrHnN36
 TJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770144993; x=1770749793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vnHVkr75tm1Yp6ZOCu5HkXcq6YZSjcDNrXJkhT+PUDY=;
 b=a1JqkYAMClYpOZfLc/Iz0r/KFoU5+LYCVzR9QlQaQfBBWIK1Bmct+6bbmNS/Cp6+62
 By/rM4CSjkkgcq/trqqRJtdC4RZrB05Gj/rV9guym0h5pQHDAZSVpSOBFFzOe82Uo+fC
 5kG51a4Fpe9e8gocfYGYwgZm2gV3usvQ6eimHupTipfKZECh9EUCulcJEcfJCYGmNbgA
 cjQZEtSonmflOY++U4PRERuygaK2Rehbrsjfp3DpEpinqZ2fW2+vIbia7Sc/tNpmoh0P
 nv5Sp4CxercBVs63N3e92l2MBSb0nELhlq4Bcusy7UodtRmnwSQS5muRkB8Yefr8eFKL
 1Xjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVYk3qrtLkfeAPEAZfyDGz7QKTa30WlWKoE50rg3IM9leOCbQsvISD0Ych/nq9nWcf63eL1IuF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcWweyQmrmRj/POE46Q3bzV+7HAag7cG+njlCXIDDSqYnidIRt
 SFU3VTPaf72mMy7EhiX9/FzJrSqEC/sWCzg06k+RKRImbLSDU1yR9DcA
X-Gm-Gg: AZuq6aK47qXDTBVmy7QDyuncDyE7fWuE/aEBnF6TOKNeU74QZdz/F/yOZH4fbCY9XOg
 iWcCejWCBfortlUv8ZWkW2r6bKB37QHTWzdaIjczoh5cFquECqjpejumuLRa/nNIkBDZATDFFkh
 zRSm6ZpguJZIj4FLyL6mjjvOK0JT7yLLeg0Qbl1iicgOGsTOdL1hV9A+L3PJi6Ti6lfQq6fq4TY
 9lGBlfwoOXqGGmY5gXSD0kqwe/xMb6L2NLaGfVXr7JXriEYqz1xDfSg5FVyUyymKnTxcQUiQHLg
 0eBzNwADEcQ3xMpubJwmE3gDkaD482qkJ7piUPVNk+98wPEYHOP+e2Z1i4XkWdWNU1LIMYAgsgp
 5jrNkk2E16bmhn5FGo0P84fyltKBsRcoiQlJXqCZ6S4RwSpUKj9DaXl/Q48/WulAxH02n7Vdj8r
 JULg5To0FikPPjvuTjQ8C+MLWuzIvaVJj3g0eqSSGrbD0/yxdi97qyq9E/kdE9Chne
X-Received: by 2002:a17:907:728f:b0:b87:73c9:36b5 with SMTP id
 a640c23a62f3a-b8e9f6bf9e1mr17489166b.7.1770144993098; 
 Tue, 03 Feb 2026 10:56:33 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:32 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Subject: [PATCH v3 03/19] drm/amd/display: Check for VRR range in CEA AMD vsdb
Date: Tue,  3 Feb 2026 19:56:10 +0100
Message-ID: <20260203185626.55428-4-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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

[Why]
Some monitors only expose GTF ranges (or others, without Range Limits
Only flag). This breaks VRR even though they have explicit FreeSync
support.

Currently, if monitor ranges were missing, amdgpu only searched for AMD
vsdb in DisplayID but many monitors have it in CEA, just like HDMI.

[How]
For DP and eDP connections, check for VRR ranges provided in AMD vendor-
specific data block if VRR range wasn't detected.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3894
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4457
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4747
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4856
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2c5877ed5f32..856007bba4d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13306,6 +13306,12 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    sink->sink_signal == SIGNAL_TYPE_EDP) {
+		/*
+		 * Many monitors expose AMD vsdb in CAE even for DP and their
+		 * monitor ranges do not contain Range Limits Only flag
+		 */
+		if (is_monitor_range_invalid(connector))
+			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
 
 		if (dpcd_caps.allow_invalid_MSA_timing_param)
 			freesync_capable = copy_range_to_amdgpu_connector(connector);
-- 
2.52.0


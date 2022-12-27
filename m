Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA8EC4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Dec 2022 17:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C2710E05D;
	Tue, 27 Dec 2022 17:05:31 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A231410E15D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 17:04:42 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id g13so20363483lfv.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 09:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ivb/DkY93Aog9U4yxwMe4hUkXXEZzyc9VEnmd3oUMqc=;
 b=7J1IvD/0DcGkmp6OLLooUcVHWxxHnLsIRphRAVW9dZ3b3TOvHBW6SgSpHDL8NInmya
 c3le/Uv94MTb11n+igIRqylE7C50XabbhO92/KFNu82cWjJOdXpiqnz5SgPdQsrkD2YL
 T1aSMpeNJo5uc/deBiC1NmhhVj3ZHBXPEzucMgjkn60rF/qJspTatGgbz+HBRJvGhhSK
 P7v9Si5f/TkcpUrq/+PnstL7/b3VK3F8bNqht2Gi1Hiu9Yo1YuErBrdq/uovO10b10O4
 IMMfvsiZYRBPpRp8BKs8M14j2nQSyWo5dLmvfHd03wrq0S74hfVQH0eV6IoJp894RTsJ
 8mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ivb/DkY93Aog9U4yxwMe4hUkXXEZzyc9VEnmd3oUMqc=;
 b=3odJ8Y8wMKMnokeFrn9fBz5GfA7W8AcKvVJGkn1YTB077JEIZsqhS0ZQ9m9Yx3w+Mu
 cipHxDbxhvoHtn0JSVu8x99klT2cxKeZnGprBKug7Hsj4COdmVv98vJIAIRipb0ySeML
 HcJ+OXGUu+/qvpcj7aSwJpEmWb9NgSmxr2blkZvAe80fz8urwsIklEmpMX8Lm/a76Yte
 Z/WteVyFVV4fYqDWTytcADOWco6L1rf1assK3k9GQ37mFAG41wWBzIiv2bg1SfZnyRNC
 v5tvspzsX2968SuraFXyZF/sSYGOOo2yuSZG6kEhgTJsOTXPn6VQaMvyjIa6MVVW04M7
 zRbg==
X-Gm-Message-State: AFqh2ko/Wr5XHC30oonnHkDkb2/v47+tyFFFbgqFbsK6Z4wExT5Hj8o4
 Unca8pVUdVOIKcYaw/ZZSyjiTTuHp/gXgBg=
X-Google-Smtp-Source: AMrXdXtF63rUZJ8onZPpnR1C7FG1+Erz2+9B7+BE05wFGYWgkREo4SbGeGQijtk4zZ35LP2vBP4N2g==
X-Received: by 2002:a19:f705:0:b0:4be:a4cb:be37 with SMTP id
 z5-20020a19f705000000b004bea4cbbe37mr6003307lfe.15.1672160680616; 
 Tue, 27 Dec 2022 09:04:40 -0800 (PST)
Received: from localhost.localdomain ([95.161.223.113])
 by smtp.gmail.com with ESMTPSA id
 n4-20020ac242c4000000b004b0a1e77cb2sm2331052lfl.137.2022.12.27.09.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Dec 2022 09:04:39 -0800 (PST)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: drop unnecessary NULL checks in debugfs
Date: Tue, 27 Dec 2022 20:04:15 +0300
Message-Id: <20221227170415.209904-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Dec 2022 17:05:29 +0000
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
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pipe_ctx pointer cannot be NULL when getting the address of
an element of the pipe_ctx array. Moreover, the MAX_PIPES is
defined as 6, so pipe_ctx is not NULL after the loop either.

Detected using the static analysis tool - Svace.
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 72 +++++--------------
 1 file changed, 16 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 461037a3dd75..cec16eaf2fb0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1375,16 +1375,11 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -1481,12 +1476,12 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx || !pipe_ctx->stream)
+	if (!pipe_ctx->stream)
 		goto done;
 
 	// Get CRTC state
@@ -1566,16 +1561,11 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -1670,12 +1660,12 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx || !pipe_ctx->stream)
+	if (!pipe_ctx->stream)
 		goto done;
 
 	// Safely get CRTC state
@@ -1755,16 +1745,11 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -1859,12 +1844,12 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx || !pipe_ctx->stream)
+	if (!pipe_ctx->stream)
 		goto done;
 
 	// Get CRTC state
@@ -1940,16 +1925,11 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -2041,12 +2021,12 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx || !pipe_ctx->stream)
+	if (!pipe_ctx->stream)
 		goto done;
 
 	// Get CRTC state
@@ -2120,16 +2100,11 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -2181,16 +2156,11 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -2257,16 +2227,11 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -2333,16 +2298,11 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
+		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
-- 
2.25.1


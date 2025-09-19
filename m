Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BEBCAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2D610E966;
	Fri, 19 Sep 2025 08:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bwTAQ89n";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02DB10E966
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:14:32 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-77251d7cca6so1895317b3a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758269672; x=1758874472; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PAnlXIvhUuyV1CYXD2F/8ydQsFY8u8fyR4eQn2kCb0Y=;
 b=bwTAQ89nqreMwAhLzSMNKlZ8BkVZYUMkiSA/ywJiLZlQpTfFkNlzJpNfuh9dgVKYcg
 XTau8nqRE+7wh+v2v+RUVjIrJ8GZTi2oL6PLStlwTOoHVWe26KKMKfeLzPcuAB7YcaLE
 Iu+RoXFH7FgIoBEVMoaK6HigY17WUbIwjek1EB+N69IaQE0HvXds9lgc5cYX0N/h248x
 g/Wp0s40Xgo9YJMakp6lsY0I1Vwuvu7XwSt0Q9kMok+HoeRS+AROapGXQ8Cxa2Kl7hAy
 AxVE8ltzJTZi2VceHWRpDQnrOVapLML9pQMqIAhiYhU24qQHhcqEsh0OxhVIZDSScZo7
 zKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758269672; x=1758874472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PAnlXIvhUuyV1CYXD2F/8ydQsFY8u8fyR4eQn2kCb0Y=;
 b=YLgroHXG81ap1mPH7R3n5VVRo+a2REX93EZEiTpiT58ob7AAA2Cnu9w51mgI1uFXVY
 t91XGH2rHCffs1AZTJuK8R9rsozgz1CUYKulBIAs+GukutSAFWqJIwokneN87EaHirOS
 o90t+oON1/U7CIN5bQKOritg+rEoQADt5ytn6d9C+syMkzA6fRzY+M5m+ELxaw8hH9+e
 U3QuDdeCRxdLDjMP2wteUGDI6XKmGfIN1YHNO3kEp+eSXlO2c2rl7NNFEu2whBOhlFmO
 ZcaGZoHYp5BLp5NP+yv3u5MadU1gcUWouboVK2wXTlfSrW6c0bvkpIAeTQ8vn9rp/SLJ
 eFow==
X-Gm-Message-State: AOJu0YzNElXMIiD/gYzHjTvsqZBAyU0s0AanYdjuToxBI0nON0qHEtlz
 jkwR6pGAc2/Nxdus4cqkfAnhnHW5mwguvrSj7/bdQKdmC9tP3hZ1EJWyj09PaA==
X-Gm-Gg: ASbGncufJR+C72ve+G10yWnYobiddGVgOKeyJe9ANkJ8PY+AfDXhwjWW3Iys5aMZnI1
 vt8rEj8mJQXhQIbusPc3q0Y8r73d13Ry7ArvVUpRs47HX6ZeGpebG75jsjFriEx5fPyRWand4pA
 OpZz0+fvrA4avxfPStGsrbw5fSjuREJUcyUFoSDMYwd3HAA5z7SqIbCunppFxpbqxUuSqkoU4P8
 82CB1+pNCw/04TkAf27NMKnooRe5B65A68WlZn7XOzQRfgkATcAk3x877rpZN5BQZY7glON0XHl
 er2WriMLknKBGem8OuXExDqJ5hH4+7SpFhcPiQkLFz/88clyIneRwbteLYLXuFU+ozfG8xsOO1M
 a+cHgf5RSsW8gWZgSjLx3gr6aBZxmGLavXJb9zQ52T5CbyyL5H/YTOVb5MtbvzCmXspbv7fd7o8
 HmvbqNq0ts0txgykpzXHMoor+/MSleslqOY9fSlQ==
X-Google-Smtp-Source: AGHT+IE3lPn9HNYI51POfWanraW7Bt9Cz/imPUKR/k8OH6aa2NkZQV6o7at5YooPfJQKUliXhaQwvQ==
X-Received: by 2002:a05:6a00:2e85:b0:776:1ffd:b15d with SMTP id
 d2e1a72fcca58-77e4d033219mr3007971b3a.4.1758269672077; 
 Fri, 19 Sep 2025 01:14:32 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E5A10046031CA6FB84A223.dsl.pool.telekom.hu.
 [2001:4c4e:24e5:a100:4603:1ca6:fb84:a223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0ef2db80sm19234b3a.24.2025.09.19.01.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 01:14:31 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/display: Reject YUV422 encoding over DP on DCE
Date: Fri, 19 Sep 2025 10:14:19 +0200
Message-ID: <20250919081419.9034-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Mark YUV422 unsupported over DP on DCE to work around a
regression caused by the recent YUV422 fallback patch.

See https://gitlab.freedesktop.org/drm/amd/-/issues/4585

The recent YUV422 fallback breaks DisplayPort on DCE6-10 because
it can select a high refresh rate mode with YUV422 and 6 BPC,
which is apparently not actually supported by the HW, causing
it to boot to a "no signal" screen.

Tested with a Samsung Odyssey G7 on the following GPUs:

- Cape Verde (DCE 6): affected
- Tonga (DCE 10): affected
- Polaris (DCE 11.2): not affected
- Vega (DCE 12): not affected

Polaris and Vega are not affected because the same mode
gets rejected by other parts of the code base, possibly the
bandwidth calculation which exists for DCE11+ but not older HW.

It is not documented whether YUV422 is actually supported over DP
on DCE, but considering that this encoding was never used before,
and that YUV420 is already marked unsupported, probably not.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 0c50fe266c8a..686f6be68c91 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -798,7 +798,8 @@ bool dce110_link_encoder_validate_dp_output(
 	const struct dce110_link_encoder *enc110,
 	const struct dc_crtc_timing *crtc_timing)
 {
-	if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
+	if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 ||
+		crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
 		return false;
 
 	return true;
-- 
2.51.0


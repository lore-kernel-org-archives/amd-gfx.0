Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62CEC54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 20:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6617310E087;
	Tue, 10 Jan 2023 20:12:34 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF9C10E087
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 20:12:32 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id bn26so13005716wrb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vox9Xc/8ILOuxlDhTKzi7mShr2sCBEwwE96I2ReHMAw=;
 b=ENUCORbNFzH8PMk6Iuz6AaxFLIa9Cv8qWZR2uyQ8VAm893ludNke5SGsKAvHF0fTJk
 vLi5Aqi3VB9Yr9grez7/4ZvD80ut6w4Z7DtST9oI+d2YNcAw6FdEgrR9t4yAjakL3XBK
 pvmGq1j/yDft0kYvbZ71FBajVeyHL1v9JSIO7tljeu4YtdCn4X6QShWmh4S2ypZp6bwT
 f7CJAjSmybqzDPR/JwTwVlGDWT8yOyqtZoM8t11qClH5xK/AqDlY6eaCYflC4qozF24p
 CI7nb7dtxfS2SFDDaq2t4VYXo9lm3XCPTzLM5WkbHM7FTfeufkTj1iLq2cU4cXWZ9FJI
 lYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vox9Xc/8ILOuxlDhTKzi7mShr2sCBEwwE96I2ReHMAw=;
 b=cBNl6D3z2z0eNvfD2pHPzhisGq0dolRpfDtvVwiMW7A1dVkSLnm491rH4ZTOcVAYiI
 lq7SQ7YpPfOWfwIP8FcFBTup44ZRRnyK6IVqp+vl/nsyn2JO1AIyiH7CQ1X0x4XMLL5P
 7XkMti6BjgmCevFb+K98kGWM0ghmexx7CbjHUk5oqQSsRL73v4zLB8ScvCYOl4Avk+Ta
 xxiOAPwDT759jwQrWxEuM0u04mea7WQuAf9dDN4qia+l7b1MZZEnrvmtEPrj+ot/Srj0
 snc/hNksAVvp3WWgQgiHLLT+MXhXvM1w2WPXnyzhAFC2sjj6au+daWmVpNvXbF20/3op
 tGrw==
X-Gm-Message-State: AFqh2kpKHNHYJSqAHEorUhhQXncphSjzABYEWHkRQlFlN0y0FlCGUwGr
 PJreYZ3GFQateSaVtruFTY2sKd87H4pjl1qT
X-Google-Smtp-Source: AMrXdXseB6EbSQ0jGHR3VuuphD4+ZPer5yUbXUfdzUznvS3+zdAwV5pRkjg92ZpA088sx0+ZIik4+w==
X-Received: by 2002:a5d:6411:0:b0:286:3b1b:a620 with SMTP id
 z17-20020a5d6411000000b002863b1ba620mr27589051wru.3.1673381551432; 
 Tue, 10 Jan 2023 12:12:31 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a5d6647000000b002bbeb700c38sm6945171wrw.91.2023.01.10.12.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jan 2023 12:12:31 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/display: Calculate output_color_space after pixel
 encoding adjustment
Date: Tue, 10 Jan 2023 20:12:21 +0000
Message-Id: <20230110201221.671544-1-joshua@froggi.es>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110194338.281829-1-joshua@froggi.es>
References: <20230110194338.281829-1-joshua@froggi.es>
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
Cc: Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Code in get_output_color_space depends on knowing the pixel encoding to
determine whether to pick between eg. COLOR_SPACE_SRGB or
COLOR_SPACE_YCBCR709 for transparent RGB -> YCbCr 4:4:4 in the driver.

v2: Fixed patch being accidentally based on a personal feature branch, oops!

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b4d60eedbcbf..9da71ee8fcc4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5341,8 +5341,6 @@ static void fill_stream_properties_from_drm_display_mode(
 
 	timing_out->aspect_ratio = get_aspect_ratio(mode_in);
 
-	stream->output_color_space = get_output_color_space(timing_out);
-
 	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
 	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
@@ -5353,6 +5351,8 @@ static void fill_stream_properties_from_drm_display_mode(
 			adjust_colour_depth_from_display_info(timing_out, info);
 		}
 	}
+
+	stream->output_color_space = get_output_color_space(timing_out);
 }
 
 static void fill_audio_info(struct audio_info *audio_info,
-- 
2.39.0


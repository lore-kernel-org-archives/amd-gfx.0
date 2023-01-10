Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCEDC54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 19:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 273B810E65A;
	Tue, 10 Jan 2023 19:43:45 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843EF10E65A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 19:43:43 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 m26-20020a05600c3b1a00b003d9811fcaafso10943335wms.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1pvCNFi+NVMH8ABUrg9M3Z93hvw1rsyviKDE9xMAXMc=;
 b=kwQY9m4ZtjeybDQK+M5jHcnwD+qqPoCmhfcYmGcBFRKh4W1CMeBzNehw1ibXKfu1CX
 WCCD5oEPJgwLJLjZNI0R72cBWA3dZhtqdfLJNf0I5mM5wOSZhQ4j01/wJ5e1rKXnsvU3
 tMX+PMz4McMWKZ1LhlQ8lOInpVtn02My+YCpg/SC4lAnUK5/ab51hLEmUJ+FQBpH8pnj
 Yx2+X9zLc0p+ZOp4wU3jlJD27YPZYTovZuVOGG8f8szOBDdwfSDFXiumFzJO3xnJM9hA
 kNHlwOv2RMIhWmtha5TS1T74hMYppUlLgo52xufDsp4rlGTHAW+N/pZF5yqO1gCCb1IR
 T/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1pvCNFi+NVMH8ABUrg9M3Z93hvw1rsyviKDE9xMAXMc=;
 b=itTLGsKZIoBZvCmN09n4/ZXyUveTu00HiaK+pFh0y5Z5kD2QwqoGCtRUW0xabk8vwT
 ntUrcpjVse9em5YpcovyNcm2OK3JCDggoRE4JK9zFInwjrwQ0V6lcsZj/gJjzUSx82vj
 HWKInlwZemBK52GGMeXdElg86gf3nkw0ZR5+DBm6emL56XHADFlSuH4K90iM2haARuRq
 tXP1UkcAvIKJ6jg+uEmxLXPW5TUxo4wr3jxJhpWdUuMddQ6L+xWJwkQCtZXvyUprf18N
 uoD8dpcurILlINGvPnG8GkN26cRc9QFj7T+usHT24t1zhvt8RAdxeIASPBTTqBxkaddO
 f4jw==
X-Gm-Message-State: AFqh2konbeWAX/gfX+qJ25KsXjc3aiAkfg6Zn81UYuijgB9arpt0wSXp
 YVsFJz5TcR3eDTqGBOCPQA17Dny1dksYCqTD
X-Google-Smtp-Source: AMrXdXsK+f4KAhpwA5Xxqwko2f03EQaoJGml6hU63KUmRF7rEWUlogly2YJwwMuC6MKJHQf9XDMlLQ==
X-Received: by 2002:a05:600c:3d8b:b0:3d9:ee3c:7730 with SMTP id
 bi11-20020a05600c3d8b00b003d9ee3c7730mr8074642wmb.34.1673379821972; 
 Tue, 10 Jan 2023 11:43:41 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a1c544f000000b003b4fe03c881sm20165406wmi.48.2023.01.10.11.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jan 2023 11:43:41 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Calculate output_color_space after pixel
 encoding adjustment
Date: Tue, 10 Jan 2023 19:43:38 +0000
Message-Id: <20230110194338.281829-1-joshua@froggi.es>
X-Mailer: git-send-email 2.39.0
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

Code in get_output_color_space depends on knowing the pixel encoding to make determinations about whether to pick between eg. COLOR_SPACE_SRGB or COLOR_SPACE_YCBCR709 for transparent RGB -> YCbCr 4:4:4 in the driver.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 599adaab6c30..eb440b1bf1ac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5342,8 +5342,6 @@ static void fill_stream_properties_from_drm_display_mode(
 
 	timing_out->aspect_ratio = get_aspect_ratio(mode_in);
 
-	stream->output_color_space = get_output_color_space(timing_out, connector_state);
-
 	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
 	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
@@ -5354,6 +5352,8 @@ static void fill_stream_properties_from_drm_display_mode(
 			adjust_colour_depth_from_display_info(timing_out, info);
 		}
 	}
+
+	stream->output_color_space = get_output_color_space(timing_out, connector_state);
 }
 
 static void fill_audio_info(struct audio_info *audio_info,
-- 
2.39.0


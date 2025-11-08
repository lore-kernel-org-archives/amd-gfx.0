Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CF9CCFA18
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Nov 2025 09:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C3C10E1B2;
	Sat,  8 Nov 2025 09:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RxyO+Z1T";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E5610E242
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Nov 2025 02:24:21 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8738c6fdbe8so13175336d6.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 18:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762568660; x=1763173460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NY2LbgvIY/fMzsfOBXS1nVDAgZLdeObOtoX1Ris2Kn0=;
 b=RxyO+Z1TbWZEkCs9M8De9DIy8Ua1n2elYntKXMEYuQnn9f/eVRVyyIeIWMhmQUaVNZ
 xOIwm33TXCB+G7rpl1VvAnM5GCLNzXTcpRE9WzZ8GZaYJPRCI7dYvOTKSMSt7pGmiXFq
 zI+zS3SoCLqXbF97y5e4C1osxJAeJMpMn54/QR0pO6x+SKqrJ4KROgfkw3mSHYjEm33y
 h/MnOkgIe/pR3RE7LJaQx8gYTAnoEtilNW1D3lmlKTMltLxz666JYT1SVBbqAg7rzQtV
 9g6w/AyjSoQFL+ERGSTfJq5quFLLPu0Awz98olReFJDg8i4ZWJ5qqgP8PmqV43kI6dAF
 DZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762568660; x=1763173460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NY2LbgvIY/fMzsfOBXS1nVDAgZLdeObOtoX1Ris2Kn0=;
 b=f97O7EK+b5J2Di1J5qFttmNUHxtZqsPX9X+pj6u6Lci0GCeFaKQ/oRL9UzomSFDQ0M
 XJHyiBQe/6FgV1KUyyWz8lAQitR4dFb1lJuCtDKDlGHtLsfITu0mNBCGG/PS6ET2C0BK
 9puHePy2YfDYgahI4jEHBMNHFleC4l1eRsbWtteM1vX9bZhV9ZtRscN6fFYrX4EWI0m8
 hfneWdJI8/UtHI9WSfntqXiMSGGUEOoPdWRKQcQ5bHCKuaQYpukdsw9Hc3IzAgKz5NCw
 XY++q+9vLAl0chcrnhFLaOPtjhJykY0Ar3VUfgIjWMseJ65JlnqBOnlIXykv4vwsD4lj
 D8Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBvEI/MpNgLRVyPLh9K6quGvNDhMlcJjinJlj57smO2Q6bR7pVoYn2W4qzB+zY85AZ4CunEDVl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNn46bjBeXJmskdJPa4IJI8RYxx92n/fDRWbd8vPHrhIUUwEnz
 0VcpZRBkPRg+07h12JToFXyMQ4P4mhnFHw/cn0ayRqT1H1QI8PqiZ7yG
X-Gm-Gg: ASbGncvddqsq4ICiejZqo9v0xSkiYTu+dzwsWHo+cfHBDzpGy8uBjiNxrzoL87dgLo8
 SwA34fSdWIztlOwSzJ1ltUKsubV2RjhFlJNZXNUrLkNf3ThFCEdsTJlO73SoXpuJZdhifbDf6cK
 9StDN2eJqYoe+++aBcobvDVwkh2fN/OocmHUyPfdpqu8hB5uSuHB9GRGlWeJ9y2pf0XjenIWJ35
 7XHvXTBccwNdmG6GF7eQ8qfqKkMF4q0o79+3Xws4kXwzDKrwI1/g4pl5AIGhjTKeXxKqdx5peSV
 ZTJTL21JN1mtn+1mxdZIVGua643ZUaxDMLTZLsll+NXx3JUxMBaMLp6Tg9cwmxgZOoULwQALDhB
 ljoHAO2ztt6jIrumvNoPQhQSIYasZI7VPOsW0LY7uN4aC38Y=
X-Google-Smtp-Source: AGHT+IFg9wz6lhJl8Q0/MXiDVkvZKRCFkQJ5hkPlMaUqnbTVBXvIucOF1fAknSssoiuUZ/XVQ1oB7g==
X-Received: by 2002:a05:6214:2aad:b0:880:580f:27c8 with SMTP id
 6a1803df08f44-8822f4d3cbemr47329436d6.6.1762568659947; 
 Fri, 07 Nov 2025 18:24:19 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88238928af8sm7493646d6.6.2025.11.07.18.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 18:24:19 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/amd/display:: fix designated initializer error
Date: Fri,  7 Nov 2025 18:24:01 -0800
Message-ID: <20251108022401.270909-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 08 Nov 2025 09:39:37 +0000
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

{} instead of {0} avoids the error with W=1

error: positional initialization of field in ‘struct’ declared
with ‘designated_init’ attribute [-Werror=designated-init]

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index f8996ee2856b..574618d5d4a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -1568,7 +1568,7 @@ void dce110_stream_encoder_construct(
 	enc110->se_mask = se_mask;
 }
 
-static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {0};
+static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {};
 
 void dce110_analog_stream_encoder_construct(
 	struct dce110_stream_encoder *enc110,
-- 
2.51.2


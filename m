Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A02C369A2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 02:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B0810E5A3;
	Tue,  8 Apr 2025 02:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fMvbUlzt";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F1510E1FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 02:11:33 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7c5e39d1db2so294214685a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 19:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744078292; x=1744683092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FnEBW9VZrzmnUK6LrflCXguguVybE6XA2qj4f7RK8eY=;
 b=fMvbUlztW2cH8D17LcmVymYIwb3hfkg5bZm+ng1+5iy1ROKl2+bTWlvLx2YL0TPceo
 ZIxUpd7iGMxxGzwZH6mt1tj0JmBwqdKVcbx9LKJbihJs0BKMvO8sthEvhN1eyQD3IzyC
 jLFertOspzNgiczx8sS0kgF+S4FAO6ZiK/MhN5vbAOwz5boEiPzXWdOsKTfRKdJq9VVU
 v5T0t2mL1I80IvmQmBfjSSqVY6BKbCamiBE2LrD2EeoUcwvVy4JtCwEUb95QRzrpwDOj
 32zLSZDjTYKcQsZYGPWwUXzBxPK47Skpazk78gihH0gFVW+q2pZZfQwhaYW5Sn/COr+G
 Hrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744078292; x=1744683092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FnEBW9VZrzmnUK6LrflCXguguVybE6XA2qj4f7RK8eY=;
 b=EedZEoTT52QDppHfMjhr+gshnAEHYHua2x+Yo0JutfGkOpSSsuXa4KIbZcqhSUI44A
 AgP7uPsvNdwfa5/wCs9NIhxPVJVUbTSkfi9nwcQg8k7pVD7+W1PbouERgUz8tIndT4TE
 keqYTHFOMhsL8Xx0/w3m0qPWydkB/K2HOXzw5nCyi+YLs5oInXnuCFobQPx1LwOWKTZI
 4iI4pcuDRnLJCHJ9fhMhIUrAaaaqV7dDUuiO9kkIqN1HsihSEGJ/oAVsjSYyFh0OTSvT
 LGZFXT7Mp/gfYaasyTQ4rPKHOFZ/y9cx9n/OdK3qnKxwthpY1ngQ5frOxOyhzqjEQatv
 7Wow==
X-Gm-Message-State: AOJu0YwEbTjpK5pftYgl4d/SuF+YtxfM8bR+ZwQL3SWh40kOHa+sljQY
 3Hi54IObkqq841gLnhiiVaD3YvYSfn4QqiESGeuNWkzWct6iBPpV/X+B0Q==
X-Gm-Gg: ASbGncuR0VAaKZJdEpitLM/6ouyRTlkoOWZQ/0b9c5+JpN2/aKuBTGzhxIlART/c7eh
 kc+HYX7UEG0B1yCVgUJWxnu4sieCxH4uGQ1Ox3/+JpqDcRBiLw1o3rCUGAMtuQuRF1Lit1WmH4F
 lIAFWuz9eg0EYHsrEEu4w6Y3KWyKf/MY4H3jQwTtA6wqMBa17jmCp8syjhVr9CPmFyaSL3V2CKD
 +UtloMyEIFuVDKN7ZgpcKs16leu9fU1VL+Y1ZVwI7AIO3qLdMldi9wupzg8/2Ul+LLSKQNBfYSo
 OaaW5wqvZ1QsKxjkXNDarNfYr/BwUNSVECWBw8WIcBB/lAkDdE1HynhB8BXBHxgeWDUaTXuDGzb
 xgOE=
X-Google-Smtp-Source: AGHT+IHXhP/cSOwhbCXgOjLTO3wkyejR2Z+lUZ1s1De5AoGjaBHrbw0ycMKauXO9MNooTyvrwm1Gvg==
X-Received: by 2002:a05:620a:438d:b0:7c5:4738:8a11 with SMTP id
 af79cd13be357-7c775a2e8f5mr2499355285a.27.1744078292574; 
 Mon, 07 Apr 2025 19:11:32 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76ea5992csm687693985a.84.2025.04.07.19.11.31
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 19:11:31 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amdgpu: fix duplicated value setting in
 dce100_resource_construct()
Date: Mon,  7 Apr 2025 22:10:59 -0400
Message-ID: <20250408021100.5439-6-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
References: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

i2c_speed_in_khz was set twice with the same values. Looking at other DCE
versions, we probably wanted to set the value for i2c_speed_in_khz_hdcp.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 .../gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index e698543ec937..e0c64861eff3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -1069,7 +1069,7 @@ static bool dce100_resource_construct(
 	pool->base.timing_generator_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
-	dc->caps.i2c_speed_in_khz = 40;
+	dc->caps.i2c_speed_in_khz_hdcp = 40;
 	dc->caps.max_cursor_size = 128;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dual_link_dvi = true;
-- 
2.49.0


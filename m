Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F517C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 07:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBD310E53F;
	Fri, 14 Aug 2026 07:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eStXfPie";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E5E310F452
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 17:10:26 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so1795085e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786641025; x=1787245825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cZ5ZVury4cSm6TIivP+oeyuQjJii9GLDK9hKbjIQnF8=;
 b=eStXfPieOHyIymNoZNyTWx/SzM/uxiiCT1WY+w3wfRPV+6N0LMux8PEOrbso1NDgWj
 VPltR6liSjmbw5B4zuGTAfLkgx3kCW3JZomDH8rxnKuRItxh2baMUSOhufJy0yATuifD
 4kCufrRZ2q//ypC7mj7rU1vWdpOLxsiPSrD0Q8swOfSNZrhyRAFJ/GlJ1pFc3EONNZFl
 MB+d56WoiopqUknPDZAgeoLuo9vRhAXITNfyo7xlNiJJwULar6jaCZaW9roq5pWzUsQP
 LPKd/434xFqy9Ntnl81hQK/M47qwsIF5kustMamnxUaABKtfJ0n5jLHUBFqMHo+MRqWl
 s3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641025; x=1787245825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cZ5ZVury4cSm6TIivP+oeyuQjJii9GLDK9hKbjIQnF8=;
 b=o6h4PT4OJco3e7NOybOuPHCVCMeTc4MQ5ZyZfQ06vJCDGI167HtSsP7J/XE3XqDfur
 jqylWNCUyf8JUralbfgzS9C2b3KQvAi2IVlcOE6hNozALhMvNDWeoo9QVFwZZaMulkqv
 2Nq3ornBJ3mixW1suLC0iaEPnC6v25EpCf/uOcuWRTjd4w39fU2B7PRx1v/xIoqDbEs1
 kMO6v7Ld+9f6ikLB6MfDwcs2xmUXpcg591kcII7WuiiEZmEeFzLEcIUAHw4KRhbsbX0x
 ZRwQ8JYM/MP/Orv9nbXiW2VqqUXvhnQkchYkqEzCxzLLlFlc2jAb1+D+Of7MysEs20La
 yoDQ==
X-Gm-Message-State: AOJu0Yy8NfQO9mFb66geQCTh+Y6FHSHyDdn3nWg6kiHsh00jk9RI7I4Z
 LEgzKX35jbA6ZKu36zO7uwChZsRnsEwr1//sAwAMRw/NdtBubdHtxILhCLxmD0COZOE=
X-Gm-Gg: AR+sD10S88BvsXYfEJUESZAQcppib9c5BkdpbHbt9EKNEU5SurYI23UQ1bQYVkaNaIs
 01riAGwZBmPW9pzHfIjk0Sk7lrxV1ddOf4V3wSn9UBxxRQRRL+S12CeidaD23EDOWGINPjgsxug
 amOqMrKruByDblchM+xv7zDiAqZvGdxRr5Tmg9RndKatmfNpvDJJfVwhZH3b11hNuSvjjGTZ+dc
 L1bcEOu745DA+03+bymFzDQDwuk+pAyHPNz5qg38MTA8QuSvCArrFJKIFw+/9d5D+BMWEVnGrJy
 pLqDrIw+1FkYhgOaV7YfIPiww+ghiACpKi/4U0OCtgNklKyDN6VPlQ+32TSvBvZhtuBeuaFmCcL
 VAO2Mrzboxq+kwIPFnywYcaQaOnZ6sKu/qHVv5dLutJPNaQfHTJ9R6XVH3ALNq5aQG20VvSO5aE
 BikocSNINWcpGuWctMRcftSqPU2WgQVC1gUqxu6Vutc3Cy6S7ThYSnw85/vPxVEiuXB5ZPq/I=
X-Received: by 2002:a05:600c:8519:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-499821f20efmr106473135e9.10.1786641024765; 
 Thu, 13 Aug 2026 10:10:24 -0700 (PDT)
Received: from cachyos-x8664 ([77.83.245.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b0f6b1sm76662355e9.4.2026.08.13.10.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:10:24 -0700 (PDT)
From: Akhmed Zhitaev <zhitaevakh@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, mario.limonciello@amd.com, alex.hung@amd.com,
 roman.li@amd.com, stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Akhmed Zhitaev <zhitaevakh@gmail.com>
Subject: [PATCH] drm/amd/display: Scale custom brightness curve from full range
Date: Thu, 13 Aug 2026 22:09:59 +0500
Message-ID: <20260813170959.22073-1-zhitaevakh@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:13:01 +0000
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

Custom brightness curves use an 8-bit input signal.  After exporting the
full PWM range to userspace, the curve normalizer still divides requests
by the physical PWM span.  On panels with a nonzero minimum PWM level,
this can produce a curve input greater than 255 and send an invalid
backlight level to DC.

Scale the userspace [0..max] range to the curve's [0..255] range
instead.  This retains the full advertised range and keeps the reverse
readback conversion unchanged.

Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 40d82a3ee..533c69f0b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
-static inline u32 scale_input_to_fw(int min, int max, u64 input)
+/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
+static inline u32 scale_input_to_fw(int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
 }
 
 /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
@@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 				      unsigned int min, unsigned int max,
 				      uint32_t *user_brightness)
 {
-	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
+	u32 brightness = scale_input_to_fw(max, *user_brightness);
 	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
 	int left, right;
 
-- 
2.55.0


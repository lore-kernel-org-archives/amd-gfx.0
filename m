Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1CAC8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C1310EA1E;
	Thu, 28 Aug 2025 15:11:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EasFOzsU";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1411B10EA19
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:22 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-45b627ea5f3so4430195e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393880; x=1756998680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clDKvhDkKqOaOBoqXISRVs8YKQ3C2mgywSnWHCIn/jg=;
 b=EasFOzsUHyx2nesYIvql3VlC5jcmMCYPt0Q8Izg0mAMWfWr09PGW9TNC1hUP9xYUIp
 cJEfaz4w1QjRGDmZ9s6znqxLktrl//zf9ANJCAJM9OQW1j7KzlTsx2kiV6PSKa8oy1+m
 bGc5+VPJKj1zimZykTvIujCiRFmFmCRfHXfxMheTEVB0A0KLaIikk0k2LZZx4R7Q9bUz
 LpFoc0isZKcj1vb4VJ/8ZFXx31c+y+T204v0YCx0SPzs4vnovwXZ1xstjFiwwGfsnniu
 4hqco23d53fGyaraAO4CSj+dn6Lhgh4Pd0Rc9/KdDzxHproAfsEzniGOLcmNpRHYN9Dy
 dISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393880; x=1756998680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clDKvhDkKqOaOBoqXISRVs8YKQ3C2mgywSnWHCIn/jg=;
 b=ND3Bve7WUeC689cTXT6m5grtE6q9VEsSZoSrZP2bmhorPLEOOsM9KTTf9qgYcgb38d
 8VsWAuToup1K5rds5aG3qGf+a7RTWofSeMFJRFEI/oo4KsQhRspoj7vW/6dov1dAACSI
 9/zXsuKca1NgApJfSJcxu2tjhd+/uf/BDbA9KghhZrnBSp6RVOhQEhZYwxslv6/+0Nfy
 VD7whPgeZynTniYj4yvUq0HF/M5pSsuzlp9Npa4NzrGLyGKoI1L+LYF+l66YDs6yZkIF
 wrbjiv2kVuq2zjlVEywYVrRQFelJxyYWQz/GCot7YcAxb2QHEpT1nP43BNelVEYu121o
 XC5g==
X-Gm-Message-State: AOJu0YwEL5AMgfTCXGWHcvPm+b9u2gX+uztYHC5nBKv09ybakTlHTeGn
 gae4F+jNzbJK4ySeWfHTk5fBN6zp+aLLrUW2e0E08alI68vGgD2OsagkJlnWxg==
X-Gm-Gg: ASbGncsoAHSQ0EgIVQUin4kEZ8pIhab+m9jFNSW5RsajAyLMAYqH1AkHzPawYMuyYKY
 vsWq5dFKpNHEsJJRdKeFIW5y024FEMtGhbPkhyIxrd3Jd58digXZyQBQxWEn+YgDAK1fzMjIGtv
 +oxk2KaDOkacE1TTmWIDtCkgAd/7upWVCSP0gqLeXSmT3AidtYZdGgb3FunXTwGdvBLuBeV/HlF
 d62137I1FeE/oJHmDaOfblvx46s3Xc3plMd+FQttjVeCt72kPoY36mR3onfpmEE0vle7OrVsKMq
 x5sGuyxzM6gZWink6OCYtCs88Ijg1kWK4TJqhViiw8Go2Yv760P964Pvmpsxw1P5kPei3r1VTaG
 vZpal6SB0Aw09MzRdgkShschtYP6sgK6Ftot9qWcBtloA53A8KYnf+IS9aHLAEURF0vInUEij2d
 76dbQbvzkRPtJRlNfDNMn5Nbz67FEvyY0OTXxG
X-Google-Smtp-Source: AGHT+IHYC9ST7d+uitdnUBiAD0FXxNkoeYMoV4g4pTUGiTScY20gmee9YTmJg9XgfEj3TP9BkTdYPg==
X-Received: by 2002:a05:600c:1d23:b0:459:ddd6:1ca3 with SMTP id
 5b1f17b1804b1-45b604673bemr125730275e9.0.1756393880487; 
 Thu, 28 Aug 2025 08:11:20 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:20 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/10] drm/amd/pm: Treat zero vblank time as too short in
 si_dpm (v3)
Date: Thu, 28 Aug 2025 17:11:08 +0200
Message-ID: <20250828151112.15965-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828151112.15965-1-timur.kristof@gmail.com>
References: <20250828151112.15965-1-timur.kristof@gmail.com>
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

Some parts of the code base expect that MCLK switching is turned
off when the vblank time is set to zero.

According to pp_pm_compute_clocks the non-DC code has issues
with MCLK switching with refresh rates over 120 Hz.

v3:
Add code comment to explain this better.
Add an if statement instead of changing the switch_limit.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index fb008c5980d6..c11c4cc111df 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3085,7 +3085,13 @@ static bool si_dpm_vblank_too_short(void *handle)
 	/* we never hit the non-gddr5 limit so disable it */
 	u32 switch_limit = adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 0;
 
-	if (vblank_time < switch_limit)
+	/* Consider zero vblank time too short and disable MCLK switching.
+	 * Note that the vblank time is set to maximum when no displays are attached,
+	 * so we'll still enable MCLK switching in that case.
+	 */
+	if (vblank_time == 0)
+		return true;
+	else if (vblank_time < switch_limit)
 		return true;
 	else
 		return false;
-- 
2.51.0


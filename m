Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D892EC8303F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78EBF10E5AE;
	Mon, 25 Aug 2025 21:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HtmI3c8K";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2637C10E5A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:56:38 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so27128305e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158996; x=1756763796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXPv6kfo3MJBciV2mYcl1lSJPsJNkREjYzcWUM07boY=;
 b=HtmI3c8KM+KUKdZVu4ZS28G5BcFcDWnqR3sL/gA6bivvBex2a8bQFReV9ChgelMUh2
 bTgYKGH88/LJUUcgC5SgbSNRIe+xCVa6fdXF5wzXURqzNebGk8S4lyhVo7Dxw71cygFU
 zLeegOLsQ4gwr/f7GmhA0LifowRwjOma5eSgrPT/6eVO/0WSDhLTrTgbHr1s1k2troQB
 CBwEiZuT3A2N9Se5p2cpjx8z28Qj1C9lpRWC6kFCXy4z0MEtdN+dafE2SJb4C9k+Nhxk
 gywJpKZJEquJYyRyARmlCgxakGKqLsd6dNxfyFxIvtp9yNJvyRUw8S8o5jedenjnmQWZ
 i74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158996; x=1756763796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXPv6kfo3MJBciV2mYcl1lSJPsJNkREjYzcWUM07boY=;
 b=q70d3vC66qLSC90yQk1eGdFS7LKt63iY6Wiv1JW0ziSgMIJELkyknPQg6zQ1IQnC52
 9+keGUImqnIgpm0tfHiuQzGmEwtHIv+6z0X9hlPLyhW3KMnnDfmLzO0Qsu9gFW+MeGeL
 oPInwlD+fMHaqRtpia6mHa7WDsQzooNZ6LlR2I33g2PWKH7z0Ml4dac6STmG+wE9GONx
 4DxLF37ymPGfAAJlspLVM8yhg82bKaTix66boSGWHnES3gD3e4v+4Ey6kAvf8oKCqOTo
 xFBCKfGPwmGhkBN5R2i95U8G2l1DQ9wz9rlBNk7TOSqGulT+hZ5f1uzbi6CRqK9MynES
 gN2g==
X-Gm-Message-State: AOJu0YxKIXZbG9gwKg8CKX2PkHRXp6D+S/NUpyQRk92lZ4c1h/bMxKcX
 Lr5eY3lmlusNy8E0rxI1j5COsjIL7bEHOR5a1Q/WGYlTZy5ieEAL///LipHgSw==
X-Gm-Gg: ASbGnctkmZSQS+7VZH4aw3Rvpvnr4HH7IG1ZWhCm7WpusmfAOKllt4mwyJBM4+Cj8hy
 yxoRnZQ+qrvtUW8I3JiUqfhWmez5wveaqhJDX2yGGxnjsN508K3w+nLulzlIGvKZiZQAE+73wWN
 AyWySnPamp6JSWgfXMxnM6aQlUHy8ytd30Wyq4zIe0VxyibWRjTxLOxThkfJHB//2+ZJKUI82H8
 1o0iFvqRG8LzLdoR5w5Q4pVpybHqQj9TVsci2G37qR1GFT7NB8UfcvtFUbKA9gB1FrFcC80+EQh
 wBzuw57Djpeg32kiFZNOFJdoo346ktY24jpRMwVkiIqV2bAJBM6HVgZqzOECbBTDGuowszHc93n
 8C2qcgjFf2V7dRGvlvMBIm5u3x01yjQBW08bNK9VznV7oD16dR2PRPUUBH6LvzagaLMju99apAl
 7FJhABSaAsJXeHjd2OG6HeDmgG9w==
X-Google-Smtp-Source: AGHT+IEawFdGhKL6pnJGsxXe4kij1vC+phq0HI/o25xCgLh0NpgLhYy0L5FECYjMA+E2XGFJuQauqQ==
X-Received: by 2002:a05:600c:1d0c:b0:456:fc1:c286 with SMTP id
 5b1f17b1804b1-45b66eaddc9mr320745e9.1.1756158995590; 
 Mon, 25 Aug 2025 14:56:35 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57499143sm121827575e9.26.2025.08.25.14.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:56:34 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/4] drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4 (v2)
Date: Mon, 25 Aug 2025 23:56:28 +0200
Message-ID: <20250825215631.628949-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825215631.628949-1-timur.kristof@gmail.com>
References: <20250825215631.628949-1-timur.kristof@gmail.com>
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

DC can turn off the display clock when no displays are connected
or when all displays are off, for reference see:
- dce*_validate_bandwidth

DC also assumes that the DP clock is always on and never powers
it down, for reference see:
- dce110_clock_source_power_down

In case of DCE 6.0 and 6.4, PLL0 is the clock source for both
the engine clock and DP clock, for reference see:
- radeon_atom_pick_pll
- atombios_crtc_set_disp_eng_pll

Therefore, PLL0 should be always kept running on DCE 6.0 and 6.4.
This commit achieves that by ensuring that by setting the display
clock to the corresponding value in low power state instead of
zero.

This fixes a page flip timeout on SI with DC which happens when
all connected displays are blanked.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../amd/display/dc/resource/dce60/dce60_resource.c    | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 53b60044653f..c164d2500c2a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -881,7 +881,16 @@ static enum dc_status dce60_validate_bandwidth(
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
 	} else {
-		context->bw_ctx.bw.dce.dispclk_khz = 0;
+		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
+		 * the DP clock, and shouldn't be turned off. Just select the display
+		 * clock value from its low power mode.
+		 */
+		if (dc->ctx->dce_version == DCE_VERSION_6_0 ||
+			dc->ctx->dce_version == DCE_VERSION_6_4)
+			context->bw_ctx.bw.dce.dispclk_khz = 352000;
+		else
+			context->bw_ctx.bw.dce.dispclk_khz = 0;
+
 		context->bw_ctx.bw.dce.yclk_khz = 0;
 	}
 
-- 
2.50.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7731CCFA1D
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E67710EB0F;
	Fri,  7 Nov 2025 15:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QH95TERJ";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B452710E0DD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:58:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47755a7652eso6161915e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531084; x=1763135884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B2VwpGomUwRPZqjRXGCtNBCf6fesZanLVgOz4KfWSBc=;
 b=QH95TERJhbJQterTKECiGNMU5AaOBOM5k/Z/OO6P1iOn7FZYxap3wllrxmp27rSSm1
 cZqBmWkAmay7w3QIvCvxyfXbHDZihvjv6KfPQcBgLpYtvKtzRdTMb90iXBhRb9H3fDhV
 JYQQGYYrmlFlSQ2P3LUEK2OSy8nhpbf2Xs0CSMTLPWjhFTxi0qgRfM7NiAozA+gpTvwm
 QIppjS60nZqpMzn029YloIlNVCIjDDo/acGS3xGbpLHgyQTB9bMo8LKf6MqSbqo+smLO
 wtvbP17yjikmOs1PKnhMC4vlV7ewfPlTgdSChxcv7g/HLT1X7CcQQiyVT+pYizMWdNZB
 A0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531084; x=1763135884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B2VwpGomUwRPZqjRXGCtNBCf6fesZanLVgOz4KfWSBc=;
 b=qnc+JKXCSOyOdMANvv3xzojai+rRCvAbzrrlcW8PnEITeonuAees1J471OpTTEHlDP
 JGkUn9woUTNgQy0gwQR6Ajbb7wqBdT/ip/P0EBtbzh4v9XXjpMwjNi8Z2sIeN7BeHiDD
 6QPjCAAOh7OqLuxZaDLObsSac1LXFV2qjnEzgedPjmnKEwaTZr0r8+Kk7xhgZ06BjBlk
 8OPc+6CTHXoJvxvRYZ04PVhif1K5F0dsZUzus9EbE0Jq8PXsUgXELOd1bB1KyfkOx/YT
 UokXJVL9Bi77F62femaKrgaCOptjH62ObcwBP3E4pOz0cn2NCXBZiBpig50sUi5QNV2d
 oBoA==
X-Gm-Message-State: AOJu0YwIEjuOYO9k3skBa41J6ozDlDIK4fisaH46CIU2BkWmriK7bqIT
 /whyJaEN5Q8g7bjxN1PPk51mUQ70tBOgIqZV4cj5Ekl6BQx1mIikM8xTWtzwcQ==
X-Gm-Gg: ASbGncvi4x9dq5QUzq3CcP54vbF6XgGTvh1T2CjSz0izJYPpmLuThocT1aBm1oJELB9
 N17hkBUVzF8wtdksXFmYL8mfrRH1myYeu7azGt9lReW16uDF48u3WmEGvM/SZ9nJuHtFV69xeC0
 x4+6Lpxri3vrkAzQBIwx/aiM0JkJfmgi2OelXG8jUfcMHDt6EkHvdgQ18cvnZ880PXm4p+bk4Vj
 Ruh3LqlpMbm66NrIlxcXzmkEw3g1dNO2ROBcRwLolUEfC9CkpXH1/sTa1Y7/72Cvq6c9xzZj+mi
 eqBCsl7yYJAk97iqrtCPGTggsGQhA/9tYG1Y+hVvuCjtomQE9p58yGR+ffDmjTdwjRb4j7h0Mt6
 xoiDLgnceM+p600PL9KGKgB2GdRFkojcUR2DO6ELhqfCYMW4sgPYdEr8NciEczEuSMkQ9m1Vfl9
 bdpFAXlgx3sgGRKTKdif8=
X-Google-Smtp-Source: AGHT+IEirmSJOG/rEz9GfKzCn8ZUS2MN/eVLxF04dy0hx6TqAbRnin+bYvz6nvWWkuNH2UijsxkA6Q==
X-Received: by 2002:a05:600c:1e8a:b0:477:e66:406e with SMTP id
 5b1f17b1804b1-4776bcc376emr31994745e9.29.1762531084010; 
 Fri, 07 Nov 2025 07:58:04 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:58:03 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 12/12] drm/amdgpu/vce1: Workaround PLL timeout on FirePro W9000
Date: Fri,  7 Nov 2025 16:57:45 +0100
Message-ID: <20251107155745.8334-13-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107155745.8334-1-timur.kristof@gmail.com>
References: <20251107155745.8334-1-timur.kristof@gmail.com>
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

Sometimes the VCE PLL times out waiting for CTLACK/CTLACK2.
When it happens, the VCE still works, but much slower.
Observed on a Tahiti GPU, but not all:
- FirePro W9000 has the issue
- Radeon R9 280X not affected
- Radeon HD 7990 not affected

As a workaround, on the affected chip just don't put the
VCE PLL in sleep mode. Leaving the VCE PLL in bypass mode
or reset mode both work. Using bypass mode is simpler.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 9d769222784c..f7288372ee61 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1918,6 +1918,14 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 		     ~VCEPLL_BYPASS_EN_MASK);
 
 	if (!evclk || !ecclk) {
+		/*
+		 * On some chips, the PLL takes way too long to get out of
+		 * sleep mode, causing a timeout waiting on CTLACK/CTLACK2.
+		 * Leave the PLL running in bypass mode.
+		 */
+		if (adev->pdev->device == 0x6780)
+			return 0;
+
 		/* Keep the Bypass mode, put PLL to sleep */
 		WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
 			     ~VCEPLL_SLEEP_MASK);
-- 
2.51.0


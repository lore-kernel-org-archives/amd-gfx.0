Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798A1CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C92C10E4C9;
	Mon,  3 Nov 2025 22:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TEj/wNBJ";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54B810E4CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:23 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-63c0c9a408aso7182583a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208662; x=1762813462; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/AS1KT+I4CJsElsopocv0S2oru4cn0Fe6NRx/rKPczE=;
 b=TEj/wNBJrtsUyUgMXWp/lDUcuGtvcCDdt0iiCQHpjfxaUa+elR3Gfk/1ZeNpL+9R8U
 6avaQgVrC4LnBraKc4tDmXU3w0ycQTgIYN9897+KVq6hlNtCpUqdK//83qH0yg5L8ByE
 LOFcSAmu7TpW7HsjdxbDSMxQrMn/a/SgzcHS2bffVgbHI/WmtWucNjSlkTq7DLsc78NW
 /78WW8LHEY4ZmHRJsOAZH/AB7boc0dmOaCEp8YIQjbF7zi/LD+0GWpVmpJ4fMz4D2IzS
 IKq3H7gTlGKHvJBfQ/nE2ivtZ8R5OKsLbwC/cBGmZhQUlaaXek1AAptHFuZsuAxu4GLR
 u7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208662; x=1762813462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AS1KT+I4CJsElsopocv0S2oru4cn0Fe6NRx/rKPczE=;
 b=Wjgjq0xWRI08W1/GRp7GAGvz1CgZ8wD2LeyInv4HwQLPlpGx24o005M5b/lLXwtc5p
 5YKScNzgfT3ghxuCovEQi1unqXlvx1mApVFVzuo4xRwSKzhnBDBoXt1N0Y9QqthD4AvQ
 lhEhxZUCobT/hjnojQIwpSbwHp3TfPxoeekj1TQu2ys6q2Hk5mTDGhbQAFm8Q4vl/Uvl
 wflbcowDjTMKhFIc0vvxrggJttqZguQfv+hmlWdY5VMU2MEIiGsMYYRDhKrC/ytElR/9
 XpmME3B5lTJadW2BfGKwLp34eUDNO8P1JNX2YVpIFEKcjhgFA9HsHwP9B7WVrdftcGcV
 9UdQ==
X-Gm-Message-State: AOJu0YytH5wQx8ymrabstORXdBg6YdtTziydPvXxL3X/aV420Kw869ZE
 Wh25MnvVoLstCBcIljvCKshT9shsxeweVrnT6jmuMeEAZDaK4wzdbY5/UNU/1Xul
X-Gm-Gg: ASbGncs+DyOQgun6rv7NGt6c+yvrY1T9msA6GfY0bkQ6EW2IHP/yMWvNvqOVf/Cv+uQ
 /Q07VwdwEPfH6dw9ZZ+2IBqkxCj9uGZ58HHkePhA/P4pDjurab/kY7Ywsf7leaOGro/wRA2oqji
 kk6MlKV0fBjAlvYLsD6uqTE4OCFIbE5oEGeBj04rUWXRXq5388WAuA8EFE8s91KBqQIwM/2f8gZ
 ahWJFDhvyn++tLiuI1Q1hOw/bS7xsnOnZ1/dFHxefVl0Vm4dbeylO8DcnB5SsC8J/1PhRd2ujRE
 OJ7o6c60junytJWmfAWwwZYjsvtwVNRpS5unNdyyz8gecwrjdcgJ3Qkb4EdS2/lATjMBMNgb8yz
 5CHZq+GD0aSqcAA/sZOsYyiGVAwxA+yBh5C1xy4DuBq7YrPxy0rYlPAdao/lpKZmqsST2ewtXjt
 KYSpsRiiuhhY13zJTHoA8lO5rriX5geQ==
X-Google-Smtp-Source: AGHT+IGMPmU6TFt24VX1ykZcuMHQ0fdw6WIc57KCFEMHzOQJFofZrQHuco6EeWdufrGFJIDNOvoZjw==
X-Received: by 2002:a05:6402:2709:b0:640:952d:f604 with SMTP id
 4fb4d7f45d1cf-640952df927mr8289968a12.6.1762208662222; 
 Mon, 03 Nov 2025 14:24:22 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:24:21 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 16/16] drm/amdgpu/vce1: Workaround PLL timeout on FirePro W9000
Date: Mon,  3 Nov 2025 23:23:33 +0100
Message-ID: <20251103222333.37817-17-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
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
---
 drivers/gpu/drm/amd/amdgpu/si.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index f7b35b860ba3..da595c94307e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1924,6 +1924,14 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
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


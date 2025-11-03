Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092D9CCFA04
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3BF410E4BC;
	Mon,  3 Nov 2025 22:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lc04FfVq";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FDD10E4BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:23:55 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-64088c6b309so4901427a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208634; x=1762813434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bi90ttwaP/7NCS5YxMqB6e9hcIxPQ2CCk/silcbmjPs=;
 b=lc04FfVqpHb/BcLPWZVwCRe9whzjHMWARwm7t9A6AAbbqFMOsA7fX4Ha3KdFuuXS1G
 uVwGQiq0QzcajcgMjX7tSM9YyU5DW9VEo663DLdwF5yRBzcW8jcMOjN4uW+wYyazikDg
 fVUD3IK3lm6x0mS/B7JENEN08sRX22/RwPuvdfv9a5N0O+rTrt9NsEU5tfHE20QAV0bg
 skcMThNYk1qIXEPiH2X42lyZcx9FSdPhoXglNKGx7Y223bsiC5OCLJpVr/fNCP4gOaTY
 D11oSvSFOgbhHu2nWrCPiQUdOer2RKXgD7dsPjKipjDBu+KW5VX+GoTHfr1hWBAGlUPt
 dIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208634; x=1762813434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bi90ttwaP/7NCS5YxMqB6e9hcIxPQ2CCk/silcbmjPs=;
 b=kRWxlSdG6BcQs0JkL7UIlCBMsjhODplDiQ0lXiE7cvBKUiW+cFHzia/s/RH69FXefr
 9/iZJ/Z29DNDTeu94770Vp3QwQEMeBWEm2tT+ta1iPGIXvGqUdtf7pAzVdi0Izgiq4QZ
 QIfjIWBMuZ66RnUKsqz7L3I8SUHFwHIBsZ7q9iYltCk7OpnBrtKbawc9nreK2Tz4wkqi
 N+JKXP00k3CgP6720eQa3KrMvY+nrvyrnttMd9bJozu0cDhL8LimavmQfQtBQpoJWi5S
 WKDtnVWPMMBX79iDfqBqE8g0lST6UX8P9t1gcV0qOA8+Syj2aWaE1F3DvOtuYWPxLx+m
 Mwqg==
X-Gm-Message-State: AOJu0YysPOi/3SbHgJshufsc/x3zlbcAtPjQasbrFVnWWdyoxsSDPOy0
 lpSlfXuTTD0kWQ7lndgHckbi+8/8QBIKoHJ0H/DZ7KFhVpcxsvXyHHlF7Fs6e/w7
X-Gm-Gg: ASbGncvdl3MoRqNZ6a+0PtohvmnhFPcXFxU3oS2j6vTtwCzb5dgEnMidm+OJQ/o0zcq
 w3c126a+gACIhtqVQUViLzWM39/qDH/mqyL+c/ATCY7+gPok/07VnxfTUOyYVMyUWO15pYODtDD
 D38TeSpeRYa824cw0QvyHnzNUvoIB4RasLe6mZwiHIvouxTdOfVsuT7Qqz42IU2uycIMSqBq5WN
 6zLndaUrRlY+r1GUSDFsWxpSFAzxrlnMjtylK9EdzgNpW1bU5QFqUnWvAqMd/3nxPALP8Sw1h3E
 YFrN2r9DF4QWOBFsQ8NzsNg3AmaD3s5rmboSBEp+o8mXf/yB5bCbpnEDz5V4sgiiWSVoJhDLA53
 eJrBCzRt3l+XMEE/2j45JB3DPjgasz4kWQtnAbUrNoF9QxOpOKwGKgNRdUly/kkAW531sdyZE3h
 alLWTnlEErIeLawWTFUl+Evcwq1ifMRA==
X-Google-Smtp-Source: AGHT+IFABGGLO/BEROVhaZ1+yVImWOcSAG6q79hLiWOujQyBm/Y1Z6VJjuIq3LlqfOFYr+lyjLDz7A==
X-Received: by 2002:a05:6402:34c1:b0:640:a7a9:289f with SMTP id
 4fb4d7f45d1cf-640a7a92d43mr6993796a12.2.1762208633790; 
 Mon, 03 Nov 2025 14:23:53 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:23:53 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 02/16] drm/amdgpu/gmc6: Place gart at low address range
Date: Mon,  3 Nov 2025 23:23:19 +0100
Message-ID: <20251103222333.37817-3-timur.kristof@gmail.com>
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

Instead of using a best-fit algorithm to determine which part
of the VMID 0 address space to use for GART, always use the low
address range.

A subsequent commit will use this to map the VCPU BO in GART
for the VCE1 IP block.

Split this into	a separate patch to make it easier to bisect,
in case	there are any errors in	the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index f6ad7911f1e6..499dfd78092d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -213,7 +213,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
-	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
+	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
 }
 
 static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
-- 
2.51.0


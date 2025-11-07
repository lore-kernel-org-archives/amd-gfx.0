Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA07CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A1310EAFF;
	Fri,  7 Nov 2025 15:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hTzqcXBs";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F393E10EAFF
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:57:55 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4775638d819so5318925e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531074; x=1763135874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bi90ttwaP/7NCS5YxMqB6e9hcIxPQ2CCk/silcbmjPs=;
 b=hTzqcXBsTHLpSRuljgGsmEfnjnExmYz3q052jVbgS5+BrDTZtapTs9rq+uFAYY0oQ2
 GWK/R7vN+j2w7Sc43EOgRDIOwj2xw+gESrn1MgsayVuUgvT7UttQ0jGaDrGq9O2CQ947
 RhpnOEZswotb6BthT3pYyl7Vsklcc8J5mivNb8qaNdgxJZUedLRecRqVvT9Q1AHyWhWl
 fWwEljv76L+h9vnFLxgZFTg0Z43NHgCSCIOmQEBIQvKXsX5kjS0GeVl1Wa6bhxor7agr
 tDdKVx5mmfCJU+IPCk/9Y2+2jGIBvisfm9DPHCrbQHeVrLCFBAKXeY/I5g2O1UFJBFjq
 eDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531074; x=1763135874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bi90ttwaP/7NCS5YxMqB6e9hcIxPQ2CCk/silcbmjPs=;
 b=RUbNhX2siPu2nFDtlUnUAluhvGnVf0Xss/X0c0gNKaWAzzA9g2s5xKRfrQSSFyBa99
 O6xqDuTaQFkSsQgdW0it3z4eUdPhTzHyspM88rEepz1p+35cwDcHwFKtUn+YEiQdkyHG
 UcqaKk+TdW3wEm0Jba+UJAdkhtb2+dpvO5e/6U9DNQeyEFzksyWsRGR4dMldB+5SZXeS
 QaXBVZVdKsL6j5IUzGrl0zhTEAgUtKerr3SNGftAY/eAibkbXPh3eedsxhMek4WTYF0D
 qmTaGBQn/rEW71sPlCo/nHD8RRjDUuGY5GEXuiPzHqQSnvsJjFrFixKEvKNpCko2i3LR
 7uMQ==
X-Gm-Message-State: AOJu0YyC1QQC0pSHDsKTWPyocsz79LQCdBeVdcX04PNWFbQpW5vszo1A
 Ro6kPbmHmW4Ujzlv3dRanlCm4KwJIiVFBhc1FNpyk9VR1OdI/KzUq6tqx5qMWg==
X-Gm-Gg: ASbGncu6mstn+JKbVoABexLFIgjSvse7Vyzjh0wflRGm0i4zsMZ6Ldtd6fInwRsm50k
 EG1vG6VwvnveUTzwkTkO/j/Yow7k8CUti5I0oYyoIaCHRy0fpHRgreSALBjvNOlcAZB3DUjcK3h
 qL81LO9/Imu2Kp98NJ8O19NJqn5NbgG+oaq9A/ES76Qr0GU5A9OEKYz/6o9Gy8M+iilPeC4kMRz
 tNXTxcrGY5MyIx7M0AWjVYlgeGzzx8UjFTpRieSicGGU6Nm+6d0Ocz+U7R4FyXAprOeYelZSqbG
 KdvdA69g+2CbtgVHnFJSoq0E+wUm2AS3cHOPzGBeyNtiwzDtRhHYWVw5U7Q96Ds2wiXVuOcrc5W
 6+wSzNXjol9cevHmBpIWe+ZbzUjdjbUFyOhsw9tGqsYdGLiVFUq7C8kceCcl1darot1s/8SiZ6i
 7G3DO78Dh52CBzlLh2k0Y=
X-Google-Smtp-Source: AGHT+IHYDStKCctPbS4nu6bvEDG7t5fxcT9xej6VF0nYDm97o7QBkYFccofi40GHGewxTHxgVXlAeA==
X-Received: by 2002:a05:600c:3145:b0:475:de81:563a with SMTP id
 5b1f17b1804b1-4776bcbfc94mr30259495e9.33.1762531074164; 
 Fri, 07 Nov 2025 07:57:54 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:57:53 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 01/12] drm/amdgpu/gmc6: Place gart at low address range
Date: Fri,  7 Nov 2025 16:57:34 +0100
Message-ID: <20251107155745.8334-2-timur.kristof@gmail.com>
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


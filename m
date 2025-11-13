Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6566CD6E54
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 19:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ECE510E926;
	Thu, 13 Nov 2025 19:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zur0d4dE";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A975510E926
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 19:07:25 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47777000dadso9058685e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 11:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763060844; x=1763665644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CJCV+PVqql63f0ZOr1lxhbVcSDtYXiAJw6qJlRoVxTg=;
 b=Zur0d4dE3Te9FWon+shk8ciffH6+le3k0rfL4G5GxaUu+gQDd1JT18ykoMcKXUrG41
 sVjnHZ2clPHr9+UPY1jL+eWcPALVKhf6Xvg0GbIUBZfulwvlY8lSsIRyz1YVYXWbriwu
 3xIWpxYADz43ETn5Qw3KiVGl1uu4cSwSpflPghHPlgyy/UFyk4+lspiawpI5oyBMIHsl
 unmsAFTCfX6/jXDjsK4GzanpTOonq8y4zLP//VHYsCrgffxSotlWTmT1rCrEgIVemxFh
 aNWD3EAe4SIYh2IOm2ao8KNIlCwkw4GR61EUllHqZD1bWzsR2cVTrkeDrw9HrkR58ec6
 hLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763060844; x=1763665644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CJCV+PVqql63f0ZOr1lxhbVcSDtYXiAJw6qJlRoVxTg=;
 b=JPoIvNtkRHXo5HjVsfS0xIBfhZSyS5keyel6jgewVEXnjPimAPPn1o0oFgF+wSX+ED
 5OV+d/usvgnGqA8wjwjbgRohDG5Qlnvd8MP5rqInk/HeTSGvx1BI44tTJ0uLdZbhbr1E
 sFK+D4YauTsdH6IPamNpkVw6QMcUapAP3h5HlQjXKIZ7swGIk/qO6CnEnjFNuZMMJlgM
 K2S5nBsBXpF1H6BWyjBQwDFci+//WNX/9H0+fPuVLUfeFEwUPmI4PglJAwCQId0LzyHt
 FSSZEXiydSCTxA6MY+6DALwIVQVhAsYIq8v4mvUEbiUTfu/5onS+KVFYu5u4jP1e6mUt
 7NGg==
X-Gm-Message-State: AOJu0YzRxSDpU3kt6F1E+rnq3OrApHmpNL0XduMxt+V+PK2XUFVppHDe
 G0Dw6CERe1GSUnNR10j9BdcW7MMRKwYPXuT4YcZxvdh21yq5eHJ1CV342/dgFHI7
X-Gm-Gg: ASbGncvTtWdPPbAcwdohYANhUMFOZpJZ9HMcpJBZB2Res2QXVQk390nenLpwHzaqAor
 JRw7P3WEgapkfIxjp9e1vi5gKWYlTrWRxES6GtqYgB/Vn6gnMjr60obWNPl4MTDKVGcK2BVMNxQ
 5r1LjKVbTLUQbayCX6u8rHxjbXLaKt59aPJ7LlyIGAroHZysrfcg5KkEutUoVJw6ZeOme/hxOQU
 sGvuuvj9vU5+G37W3llnrdjU/n56c7BEshkohUqqqh/qj6wBSDdEpFKbLndJ9KR0lIoRZEFXN+r
 IgNuSEJUtUN+el5uAHRd2DvUJcYTabGQCuBZyQ3LpY+Jb2szgmf2F0N++jy0fNiKQMR7j4TEeUB
 ex3/HtowgfadWdxOxj7NZidp22IgHCLgsYsAkJvHoo6UDi8cQjq3Wqj7T5kHL0rR7c8mwckPqMd
 LSV8c+mm5YabRUm9awUBXKq/TzOKd/Uq8+QLgW85J0EWlacZ4O6HdZZyyP/Rc4lBjwHy3hzah48
 /LxRmeNgRPX5awWesVpFuziCGoQKA==
X-Google-Smtp-Source: AGHT+IGoN9vome/ETd6+K1usP496ydtm+VHyNf0W+78C3XqnjevnlJvphN2bLc5vRlWESZMHrVnhrA==
X-Received: by 2002:a05:600c:8b21:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-4778feb566dmr6696745e9.30.1763060843956; 
 Thu, 13 Nov 2025 11:07:23 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00BA2088E69F553967.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ba20:88e6:9f55:3967])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778f4bc9c6sm18822665e9.14.2025.11.13.11.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 11:07:23 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/1] drm/amdgpu: Use amdgpu by default on SI dedicated GPUs
Date: Thu, 13 Nov 2025 20:07:21 +0100
Message-ID: <20251113190721.258617-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113190721.258617-1-timur.kristof@gmail.com>
References: <20251113190721.258617-1-timur.kristof@gmail.com>
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

Now that the DC analog connector support and VCE1 support landed,
SI dGPUs are at feature parity with the old radeon driver.

Enabling the amdgpu driver by default for SI dGPUs has the
following benefits:

- More stable OpenGL support through RadeonSI
- Vulkan support through RADV
- Improved performance
- Better display features through DC

Users who want to keep using the old driver can do so using:
amdgpu.si_support=0 radeon.si_support=1

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 drivers/gpu/drm/radeon/radeon_drv.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3cf36d28d27f..0539f97fa2f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2327,6 +2327,7 @@ static bool amdgpu_support_enabled(struct device *dev,
 		param = "si_support";
 		module_param = amdgpu_si_support;
 		amdgpu_support_built = IS_ENABLED(CONFIG_DRM_AMDGPU_SI);
+		support_by_default = true;
 		break;
 
 	case CHIP_BONAIRE:
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 40dff6feac8a..fe7ed70f4703 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -273,6 +273,7 @@ static bool radeon_support_enabled(struct device *dev,
 		gen = "SI";
 		module_param = radeon_si_support;
 		amdgpu_support_built &= IS_ENABLED(CONFIG_DRM_AMDGPU_SI);
+		support_by_default = false;
 		break;
 
 	case CHIP_BONAIRE:
-- 
2.51.1


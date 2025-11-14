Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00D1CE7AF9
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 12:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723B710EA50;
	Fri, 14 Nov 2025 12:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xq3/bVog";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C798610EA4E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 12:07:42 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso16624755e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 04:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763122061; x=1763726861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8yk59vPFIVY3NQkvvwyddltGpg4gYOFsu3HyDllEpuE=;
 b=Xq3/bVogMaARyxAHFLdWJZjmTISQKxkzv6y2hZVNBjxnVeuwBuBqBTUlMZHg+aFJ/z
 xndLKo2RBydOFtM3uRl7a4STuryqa9slGpaxFnvpnN5qHWIOQJMJPrRxZypXOXTF5cCL
 poF7dPB1D+hzh1lNH709km2p3wnAIs5hS6UFN1zyfYwPduGcbcYZKjk0gtyCyW1r4tpD
 izg/Lsz8zzUz4EJEB4jrjr0DSvRCfK+RzEHhjs0BS1SE+XCj29wa27SpNMOlamrQlQRO
 xTe2HcIUVNts00a3/BL1K6BjyfCsFjPXoOlZRGtl1+NZbBuPXHe1FwUbjyD62RJW/Tn4
 SRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763122061; x=1763726861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8yk59vPFIVY3NQkvvwyddltGpg4gYOFsu3HyDllEpuE=;
 b=TDikePO58AUzluQzdVj5KD5AdTZbE79bSA807L4/isi6jWkY1lhi2RrCthb8LLvqYg
 v9EdO5Q89xkyVpciTK/QzTBlZ0uEBsekpiF97Qg44GIFzHLsMynLq0HguJpa1h0JrqxS
 g+/GCBfWy5UhmnytBs40e+0Lqd3HnHWvqO2QmP1nSmxQ5dUzegXrH2+rHBItzi4wM6EG
 3tVPgNw2sXuwku68Q/Sdp0Wg+yG6FHzD2IEyMgPyWNmMLxp+C5W/m+PFPYImfGPOPSpS
 DiEdIEMJJCq1noxPOyUDAZ68MXZF2vYTtZeWGQfeH9IIxuq/PjuWeP/grtyNgLcUhF8Z
 emyw==
X-Gm-Message-State: AOJu0YwbX/djQATYT9bDzBm8yEz06ejAr/vP6m+4iMlt7ufkAZWVMBsh
 tOOIW5rfis0pLUBTzKn3EjXsQK3fUrLNb+8mrKEz4hnUPyzyCMFMT4R07iGJyU1X
X-Gm-Gg: ASbGncsWisTsfOB1oVUUogvLn0MH1QYiF11C7RkcWhKoDIJsim4AeAmCmkfRdEveamb
 OPwxPg12tiq5TL+zK+OPkvVlY7EEmOw7WfTJN0VgJqHxNbrG2mnFi149zOyrxRhC7QOqbrMpwJd
 OUpTVDn9MSUHUvWRJycNHhjnSjCnqPwhlfZt0h0W3pBcQ6RrsZQkRndc4qPuAVADsRd3V0GITlb
 8mqPvnojKL+/m8yPdd+v/NtfXjK8aOU9v616Ke5HKIC428C2OPvAAR2G3d1xwHcVmLxnbJ7bT67
 PyZKPdFLM9gOva14QZ00cxQ3bVmLOICOvhUtRO4kzxW73ufvLqam5B35EJSEM2AslEbUGOZTz5B
 u7mTHzui4QUJwDUmpbN5+So692h1DCASg4z/Czi9i+UxJSShjBD1lisan3i7LPZigPWYscR3W2l
 Zla21e0oU2z+uKcSmsv/ZYAmNeJw9xv9meg+GLagQLHRoZMi4ODaOS2+Tv+RUMeIKCAOrz6AXWc
 Tw5KbB5ZqHW4yRh/j43fEY4yjDUPLZQhCdfrYA=
X-Google-Smtp-Source: AGHT+IGsvbmfizm8AFVAv7ZFbEU+tZ+mLGj4XybKqTsswJx2tdaTckNa2WfP1l/EFvmVuIhBGNqMoA==
X-Received: by 2002:a05:600c:2153:b0:475:d278:1ab8 with SMTP id
 5b1f17b1804b1-4778bcb3702mr43958555e9.2.1763122061063; 
 Fri, 14 Nov 2025 04:07:41 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00CA8B1D2C0125E560.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ca8b:1d2c:125:e560])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bd2fa91sm42078025e9.17.2025.11.14.04.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 04:07:40 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 3/4] drm/amdgpu: Use amdgpu by default on CIK dedicated GPUs
 (v2)
Date: Fri, 14 Nov 2025 13:07:35 +0100
Message-ID: <20251114120736.31310-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114120736.31310-1-timur.kristof@gmail.com>
References: <20251114120736.31310-1-timur.kristof@gmail.com>
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

The amdgpu driver has been working well on CIK dGPUs for years.
Now that the DC analog connector support landed,
amdgpu is at feature parity with the old radeon driver
on CIK dGPUs.

Enabling the amdgpu driver by default for CIK dGPUs has the
following benefits:

- More stable OpenGL support through RadeonSI
- Vulkan support through RADV
- Improved performance
- Better display features through DC

Users who want to keep using the old driver can do so using:
amdgpu.cik_support=0 radeon.cik_support=1

v2:
- Update documentation in Kconfig file

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  6 +++++-
 drivers/gpu/drm/radeon/radeon_drv.c     |  2 ++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 1acfed2f92ef..883f32428871 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -59,11 +59,17 @@ config DRM_AMDGPU_CIK
 	  Choose this option if you want to enable support for CIK (Sea
 	  Islands) asics.
 
-	  CIK is already supported in radeon. Support for CIK in amdgpu
-	  will be disabled by default and is still provided by radeon.
-	  Use module options to override this:
+	  CIK (Sea Islands) are second generation GCN GPUs,
+	  supported by both drivers: radeon (old) and amdgpu (new).
+	  By default,
+	  CIK dedicated GPUs are supported by amdgpu
+	  CIK APUs are supported by radeon
 
+	  Use module options to override this:
+	  To use amdgpu for CIK,
 	  radeon.cik_support=0 amdgpu.cik_support=1
+	  To use radeon for CIK,
+	  radeon.cik_support=1 amdgpu.cik_support=0
 
 config DRM_AMDGPU_USERPTR
 	bool "Always enable userptr write support"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95224dffc367..910269407700 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -641,7 +641,9 @@ module_param_named(si_support, amdgpu_si_support, int, 0444);
  * CIK (Sea Islands) are second generation GCN GPUs, supported by both
  * drivers: radeon (old) and amdgpu (new). This parameter controls whether
  * amdgpu should support CIK.
- * By default, CIK chips are supported by radeon (except when radeon is not built).
+ * By default:
+ * - CIK dedicated GPUs are supported by amdgpu.
+ * - CIK APUs are supported by radeon (except when radeon is not built).
  * Only relevant when CONFIG_DRM_AMDGPU_CIK is enabled to build CIK support in amdgpu.
  * See also radeon.cik_support which should be disabled when amdgpu.cik_support is
  * enabled, and vice versa.
@@ -2329,6 +2331,8 @@ static bool amdgpu_support_enabled(struct device *dev,
 
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
+		support_by_default = true;
+		fallthrough;
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index ac175442d806..40dff6feac8a 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -277,6 +277,8 @@ static bool radeon_support_enabled(struct device *dev,
 
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
+		support_by_default = false;
+		fallthrough;
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
-- 
2.51.1


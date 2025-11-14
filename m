Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A33CE7AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 12:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D5710EA52;
	Fri, 14 Nov 2025 12:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TEchF8q9";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A17A110EA4E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 12:07:43 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4774f41628bso15886455e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 04:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763122062; x=1763726862; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZCLyPwoWeKuBs324jkgbCJ/tUownHbXhBobwj7Bb4xc=;
 b=TEchF8q9ODjASz+rcHDKBK9Vr9EAQmH7mWfyoINOsUgRcbO5mFK1X3AAefHZgPMDtj
 udrtqrnfRq1n5LRtLR2ZWY8ytNz64W7yy0ArQl6S5rkOmm6TmQT7NALG/z96iMRSUDnv
 mkhBwBlu+a2auZE9KWRaRxOU6DZBxB0jknPnqP28NxMaE4ZW25QlFDcb/jCAjKNDOxy5
 G5sWLbjRv+8RNfOPrD9hT2C42IO0CzR303PS07T/WeNk7YDaBH5xF9MIqjgpG1dOWdYj
 Pwzvd+jKE+DumwEaVYq3kcDW33LmsDOLzR0BczNdul1lWoboUMlZXjsjjpYi8wafeb/L
 7gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763122062; x=1763726862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZCLyPwoWeKuBs324jkgbCJ/tUownHbXhBobwj7Bb4xc=;
 b=ImyK8c3GmwxlCggKIdwbqH3azjn0rvkrhq8di6v12aSzXVk0b1cOR8HjJNk/JTtpeM
 55KTOU6eM4/rOgmA2cb8HpglYwIqliku45PcyIQNmBhv6wQJkUQ97PDMGpl6QR05qi3y
 CUNOvALXdaZO1KRVUjT40JDAywQdKZTXnD+ASFyTsBJZYzKUVpuSZkNnSyZP1FlfInaE
 uxUtW6pOp45IofBtixEHUMG4aX0A8CdKWZ3EP4gVIzl0Hi8q9OHs5b8Vew2+VrqnhMrx
 F/mX8LHiOGQCSp6HEOJA0uj7ZHlck70Knjh2FXAqVPjJN1KQ25W/2fP9V/wwZZ0NyS03
 VfWA==
X-Gm-Message-State: AOJu0YzyaqpDc4BPZz6glpMBKgk81Jw+KBJMM+biVAt/Ve8RwQUtLVvH
 a4dJ+JAD+Ic25QHkwtrVUSCGBUQ22outQy0epRwipdlSN2L+gH4OO8dYMzF6Wnfg
X-Gm-Gg: ASbGncudlGgbvgoRBLuypi7Yc+m8jZ+n1RkEJo3oCqp5cS3dHyIJCz++ZeDAMMRX7bx
 4fJ0e/JwOLz9n9bdki+UzYRAaBp8TAoxIjM6b8FRxFyc4U4dC7BvaVj+DQZ9sPWeI3pbIpIIgq7
 I4eDQ+ydj4Dr1iIzTtIYjmd4O/TkVbO+VrImpHbdqpXKWL+ywqJbaR0fSULKp95T590wQUVFp8b
 LzdlSUA3GRyQqL1hoRs6lgPW1hYMlGQEu2OqXOZ2XWy7yS1vxk00L1iz1msgj0d41uFTV5PN9uB
 0UMdekVZe6zKrfP7klyRHEDeQI7vI3HWm+FQDPfL0MbU+VlnCOF8/oDN8LN5D2xltWQvDlvwNcH
 hAsOUAfg58d1m/+FUy/HPkSXOsxlu8mm1ZUHzrXQaNbJshF+79L2MAdnG4DiQgIfUTbfmFz7fz+
 5B1obK7fH23iBrb96UfJGo5u+JCigevjm1zJgSXk3BwlDqVBCmDjS21/H4APOMyQgTDZ1o2BTrh
 F6XZ1tUlBls0c3Kxg==
X-Google-Smtp-Source: AGHT+IGEWgQWwYbSzbqrpFsfWoT8QqKFdgxOZ5afgXiDy5/wEO8GvnN3Ypu/VgKj0FkBSnDXtGn6Vg==
X-Received: by 2002:a05:600c:4ba1:b0:477:348b:1182 with SMTP id
 5b1f17b1804b1-4778bd2885cmr38531285e9.18.1763122061835; 
 Fri, 14 Nov 2025 04:07:41 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00CA8B1D2C0125E560.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ca8b:1d2c:125:e560])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bd2fa91sm42078025e9.17.2025.11.14.04.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 04:07:41 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 4/4] drm/amdgpu: Use amdgpu by default on SI dedicated GPUs
 (v2)
Date: Fri, 14 Nov 2025 13:07:36 +0100
Message-ID: <20251114120736.31310-5-timur.kristof@gmail.com>
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

Now that the DC analog connector support and VCE1 support landed,
amdgpu is at feature parity with the old radeon driver
on SI dGPUs.

Enabling the amdgpu driver by default for SI dGPUs has the
following benefits:

- More stable OpenGL support through RadeonSI
- Vulkan support through RADV
- Improved performance
- Better display features through DC

Users who want to keep using the old driver can do so using:
amdgpu.si_support=0 radeon.si_support=1

v2:
- Update documentation in Kconfig file

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
 drivers/gpu/drm/radeon/radeon_drv.c     |  1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 883f32428871..7f515be5185d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -43,14 +43,16 @@ config DRM_AMDGPU_SI
 	bool "Enable amdgpu support for SI parts"
 	depends on DRM_AMDGPU
 	help
-	  Choose this option if you want to enable experimental support
+	  Choose this option if you want to enable support
 	  for SI (Southern Islands) asics.
 
-	  SI is already supported in radeon. Experimental support for SI
-	  in amdgpu will be disabled by default and is still provided by
-	  radeon. Use module options to override this:
+	  SI (Southern Islands) are first generation GCN GPUs,
+	  supported by both drivers: radeon (old) and amdgpu (new).
+	  By default, SI dedicated GPUs are supported by amdgpu.
 
-	  radeon.si_support=0 amdgpu.si_support=1
+	  Use module options to override this:
+	  To use radeon for SI,
+	  radeon.si_support=1 amdgpu.si_support=0
 
 config DRM_AMDGPU_CIK
 	bool "Enable amdgpu support for CIK parts"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 910269407700..16adeba4d7e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -623,7 +623,7 @@ module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
  * SI (Southern Islands) are first generation GCN GPUs, supported by both
  * drivers: radeon (old) and amdgpu (new). This parameter controls whether
  * amdgpu should support SI.
- * By default, SI chips are supported by radeon (except when radeon is not built).
+ * By default, SI dedicated GPUs are supported by amdgpu.
  * Only relevant when CONFIG_DRM_AMDGPU_SI is enabled to build SI support in amdgpu.
  * See also radeon.si_support which should be disabled when amdgpu.si_support is
  * enabled, and vice versa.
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


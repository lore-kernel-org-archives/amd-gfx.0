Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657B5C282C5
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Mar 2025 02:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE5910ED70;
	Sat,  1 Mar 2025 02:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FV7SpDxL";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E0E10E0D8
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Mar 2025 02:22:19 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6e8ab9ea2deso5205416d6.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740795739; x=1741400539; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6ZLLXyyDgd3M78YuxWjLg+87WvW7j10DdyhDgne+vYQ=;
 b=FV7SpDxLTuszTW4RcZjwQlhGnnxegGy/oCPJsj/1wEqTHts9M5M3ZkSGvDMfll8CM1
 fJpCYWDAC+aLuMQlZzRM1k4U189rURahZvjC+jb8ZMdqy7JzfzHe5giPqA1yZxJTSwYY
 YqA7y6+bzFFnflvsSASmCAwskc+kWeBGZoJlw69LaBEL+PGOhLoOQILa/3zumCvsd11R
 QxsaFCME39xhZV+8fQwCVBmFVcvzcvL4Le3DoskQlAyr/p79wFk8M483uZ9D1DXTGKeb
 OtA8nhwtscVXKpWdIcc/BpaezRlbtpDOoeM1T2+m2zX/SxMD0XLeeIfNmWKJXmBQL4TS
 261A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740795739; x=1741400539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ZLLXyyDgd3M78YuxWjLg+87WvW7j10DdyhDgne+vYQ=;
 b=nr7h2uBjKp6nyq0oFGfTs3V0QQ0kXwmp0v+Y2STXw0+aw4HWkIWAvS/7LBRklS90qi
 Wpfuu7Saeh4jAO3+n2CqWiuFmpBvR2Rcj+P/FxQzTOpSqkQoeD877cz/yI2u859YfmNm
 VnWRBGOe94FeBuX2/Up8dRbJGNM6dbn3T5/jjGlbecyT7B2rsbrWx190VYAKDZE/7NBR
 DAMU6BBytot1LpBGahCedqppHLXysdCoXKOX7jr3ThfXp+HZTSAc/85WJaDSK7ff8kpi
 zF7EvOGd/ECeYFWNGdTwbtC/efU+Y/LcS3GCC25Y7j3D/dIr2MnNMAzT4LqdsOHRQKZA
 EuBA==
X-Gm-Message-State: AOJu0Ywy5z20jaA2Jtna7Niy+XZU9jI1vzoJsOrMZoePDRyMO5ESh+hK
 e3QPkTGki3lwo7fTWJT17bHfAk8D5kkZkQPHXTnRWZN85x1o/J8LZ8G4zg==
X-Gm-Gg: ASbGncsdp33rJ1LZW3d8zhpBvAM3TyVSOxQnl+7aXu/LRy1SV9CWdWkJ3QwoI108xFu
 XXLJVaa+AfexwvImwResZa7TgEwZ99ej2fvMT0PPv+ZoBKgwrfWFA8dVz3mqhnkGgdLi+rw3OJg
 w41aEbBND0r6gnW1mDJ54rRojXJdqdbk9CvVCARKyceU8a7PoJWvAVGqxnYFsALqa9QSZFcp3lj
 zzlPLlWU/1CL1McMlcLOvyrXFCiOGKg8+eNY6cRwR/OxQU+cAbEW26V14JX2mIh3RFcbXRMCJ5Y
 vS+5N6UQQHHUW7I4zwJLNvCoMhyYsJ38sYsB96nCm9m1C02Pii0zcmBp61NeuTId5Nc=
X-Google-Smtp-Source: AGHT+IGmJnhzZIzp4qgBrD3PxA+sViY3YxeBDN0bgxc/wrDGq3mWJ7Mli8CatoQ9YW5fHSpuAe/rsQ==
X-Received: by 2002:ad4:4eeb:0:b0:6d8:8a60:ef2c with SMTP id
 6a1803df08f44-6e8a0cce81amr91253576d6.2.1740795738837; 
 Fri, 28 Feb 2025 18:22:18 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976537afsm28489106d6.43.2025.02.28.18.22.18
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 18:22:18 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] dmr/amdgpu: fix style in DCE6
Date: Fri, 28 Feb 2025 21:17:47 -0500
Message-ID: <20250301021747.28827-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301021747.28827-1-alexandre.f.demers@gmail.com>
References: <20250301021747.28827-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

A few returns not where they should be.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 78402e7444db..a72fd7220081 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -242,7 +242,8 @@ static bool dce_v6_0_hpd_sense(struct amdgpu_device *adev,
 	if (hpd >= adev->mode_info.num_hpd)
 		return connected;
 
-	if (RREG32(mmDC_HPD1_INT_STATUS + hpd_offsets[hpd]) & DC_HPD1_INT_STATUS__DC_HPD1_SENSE_MASK)
+	if (RREG32(mmDC_HPD1_INT_STATUS + hpd_offsets[hpd]) &
+	    DC_HPD1_INT_STATUS__DC_HPD1_SENSE_MASK)
 		connected = true;
 
 	return connected;
@@ -419,7 +420,6 @@ void dce_v6_0_disable_dce(struct amdgpu_device *adev)
 
 static void dce_v6_0_program_fmt(struct drm_encoder *encoder)
 {
-
 	struct drm_device *dev = encoder->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
@@ -895,8 +895,8 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
 		wm_high.dram_channels = dram_channels;
 		wm_high.num_heads = num_heads;
 
-		if (adev->pm.dpm_enabled) {
 		/* watermark for low clocks */
+		if (adev->pm.dpm_enabled) {
 			wm_low.yclk =
 				amdgpu_dpm_get_mclk(adev, true) * 10;
 			wm_low.sclk =
@@ -3135,7 +3135,6 @@ static int dce_v6_0_hpd_irq(struct amdgpu_device *adev,
 	}
 
 	return 0;
-
 }
 
 static int dce_v6_0_set_clockgating_state(void *handle,
@@ -3268,8 +3267,7 @@ static void dce_v6_0_ext_commit(struct drm_encoder *encoder)
 
 }
 
-static void
-dce_v6_0_ext_mode_set(struct drm_encoder *encoder,
+static void dce_v6_0_ext_mode_set(struct drm_encoder *encoder,
 		      struct drm_display_mode *mode,
 		      struct drm_display_mode *adjusted_mode)
 {
@@ -3281,8 +3279,7 @@ static void dce_v6_0_ext_disable(struct drm_encoder *encoder)
 
 }
 
-static void
-dce_v6_0_ext_dpms(struct drm_encoder *encoder, int mode)
+static void dce_v6_0_ext_dpms(struct drm_encoder *encoder, int mode)
 {
 
 }
@@ -3353,7 +3350,6 @@ static void dce_v6_0_encoder_add(struct amdgpu_device *adev,
 			amdgpu_encoder->devices |= supported_device;
 			return;
 		}
-
 	}
 
 	/* add a new one */
-- 
2.48.1


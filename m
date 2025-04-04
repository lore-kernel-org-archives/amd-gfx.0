Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980C4C3601B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 05:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FAF210E287;
	Fri,  4 Apr 2025 05:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nm+zYJrW";
	dkim-atps=neutral
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B9DE10E287
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 05:22:41 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-6e8f05acc13so18376306d6.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Apr 2025 22:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743744160; x=1744348960; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MORskq2210kkOccs8iYK4+xrFbI9II7AUQwsdWEjpJY=;
 b=nm+zYJrWSv2T0KXIs/hGl+G1HZ8z2tDWvut68UgC8a1n/9CNoQwexiZmp/w2n841Pc
 IkvtHPl4bYIvaxAi3RgtTM5YvmseGb0WEDG6ggZY9xSCttODrhHlAKyUTNnJRHZUY3TP
 KfZWpbbZa996iCxU5kqze0o5xotnVSREyETv+9vpktpa7GmfrDn5RnEIpaJfGmXM9vpn
 qw/+PMiXfoIfM4Kap6rRsm/AYJJtfXype030piT/CU5QIn0XjPoFlBq74wKi6HlXPH/E
 aiyTnWz+3H2Rc6x5/zf5Sc97x8tuwUotaizA7k7l3BJwyp6hw/8xwihxWS3oT2y/L6e+
 jGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743744160; x=1744348960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MORskq2210kkOccs8iYK4+xrFbI9II7AUQwsdWEjpJY=;
 b=MNM9IRY7AyZzvljqonbRamzCDdjA31pQhuivazQIVnd+1Yzz3W6Itv9OQZhUO4urMX
 NwJ18nRqgwMFaPqjjGd8WyJJNa6Pr7v0Kysmxvn2vYvmfMnXL3MJbqCl91jriR1Nj526
 7UJkSYmCvob3K7KzGNmt/otpMVkZLs2cyFedxjhPNxIkN/0b9q/29ftLgCrF2BR/tW9A
 CkOs3pCibzuhWycrcNscnVLIT+jL+KJrFdmnriHqbwRX8NV47k4+1XgLKEeW+p6IhB5s
 3bdDiMMTPid6P5wDtrKJXnbXAtq8QjiIq+1pNziPrPlNvzNbN9lqzPKWxN8uAXU39CZT
 +2Gw==
X-Gm-Message-State: AOJu0YyivClNXnz+qqVJDtul3or6bHrGPcwYdrIRnZSWOxvC3dseKlvY
 8ftm72ki5TUT4/ldiBWv2QJHahuBHo+ZCS22HhnFCG+Lvtij8bpsAR2Hyw==
X-Gm-Gg: ASbGnctao1EaB08tAgGrwoBZ91Huu5s/q4RXOEXCv5rEZlaTEansXUcy5aw9BuCflGs
 +Fm9QVCApTp7HbiGm+la18zpoSB8dC078E9FJ6c4bT7YzRTVYTp2cz/+BHt8QkbHpuVwUYWeSzH
 j6OAHou6dLT15K80TlDf4pYzHZhYefCH2y7Fh+XXjyfp/hCBYBBlN0I/uJndhvya/LGOzR8yInE
 kJw/vxKri7D4ZpLNXlezbJtTUyxTHw1WnF4L+nEc9bEyLLYvuG3wKFQBb1wF7DBtlySCk52MK6j
 +npzdqQXDybGbyYpapkc0EZcnc5rDgeW5ELMjBeaG+i2nOaEMXl3oTKyJP/2bAUxYAEp
X-Google-Smtp-Source: AGHT+IG0QDBQIhbcFpNH46N7YqzRHHlRhdCcZU5elM7IYTx1yKXoRiaw4j4tgxkv5GQ0ew6x1IYVFw==
X-Received: by 2002:a05:6214:405:b0:6ed:1486:c3df with SMTP id
 6a1803df08f44-6f00de8c648mr34539816d6.2.1743744160511; 
 Thu, 03 Apr 2025 22:22:40 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4791b071b42sm17238651cf.27.2025.04.03.22.22.39
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 22:22:39 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix typos in DCEs
Date: Fri,  4 Apr 2025 01:22:21 -0400
Message-ID: <20250404052222.19955-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404052222.19955-1-alexandre.f.demers@gmail.com>
References: <20250404052222.19955-1-alexandre.f.demers@gmail.com>
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

In DCE6, DCE8, DCE10, DCE11, "hdp" is replaced by "hpd" and
replace "type" by "hpd" for a uniform parameter naming usage across DCEs.

In link_factory.c, there is a missing "p" to "types"

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c           |  7 +++----
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c            | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c            |  4 ++--
 .../gpu/drm/amd/display/dc/link/link_factory.c   |  2 +-
 5 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 5098c50d54c8..b6ba7939f469 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -3048,7 +3048,7 @@ static int dce_v10_0_set_hpd_irq_state(struct amdgpu_device *adev,
 	u32 tmp;
 
 	if (hpd >= adev->mode_info.num_hpd) {
-		DRM_DEBUG("invalid hdp %d\n", hpd);
+		DRM_DEBUG("invalid hpd %d\n", hpd);
 		return 0;
 	}
 
@@ -3200,7 +3200,7 @@ static void dce_v10_0_hpd_int_ack(struct amdgpu_device *adev,
 	u32 tmp;
 
 	if (hpd >= adev->mode_info.num_hpd) {
-		DRM_DEBUG("invalid hdp %d\n", hpd);
+		DRM_DEBUG("invalid hpd %d\n", hpd);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c5680ff4ab9f..90ebbea2c70c 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3179,7 +3179,7 @@ static int dce_v11_0_set_hpd_irq_state(struct amdgpu_device *adev,
 	u32 tmp;
 
 	if (hpd >= adev->mode_info.num_hpd) {
-		DRM_DEBUG("invalid hdp %d\n", hpd);
+		DRM_DEBUG("invalid hpd %d\n", hpd);
 		return 0;
 	}
 
@@ -3331,7 +3331,7 @@ static void dce_v11_0_hpd_int_ack(struct amdgpu_device *adev,
 	u32 tmp;
 
 	if (hpd >= adev->mode_info.num_hpd) {
-		DRM_DEBUG("invalid hdp %d\n", hpd);
+		DRM_DEBUG("invalid hpd %d\n", hpd);
 		return;
 	}
 
@@ -3461,8 +3461,7 @@ static const struct amd_ip_funcs dce_v11_0_ip_funcs = {
 	.set_powergating_state = dce_v11_0_set_powergating_state,
 };
 
-static void
-dce_v11_0_encoder_mode_set(struct drm_encoder *encoder,
+static void dce_v11_0_encoder_mode_set(struct drm_encoder *encoder,
 			  struct drm_display_mode *mode,
 			  struct drm_display_mode *adjusted_mode)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 761ba83385ac..aa205c5b268c 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -287,7 +287,7 @@ static void dce_v6_0_hpd_int_ack(struct amdgpu_device *adev,
 	u32 tmp;
 
 	if (hpd >= adev->mode_info.num_hpd) {
-		DRM_DEBUG("invalid hdp %d\n", hpd);
+		DRM_DEBUG("invalid hpd %d\n", hpd);
 		return;
 	}
 
@@ -2929,26 +2929,26 @@ static void dce_v6_0_set_crtc_vline_interrupt_state(struct amdgpu_device *adev,
 
 static int dce_v6_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
 					    struct amdgpu_irq_src *src,
-					    unsigned type,
+					    unsigned hpd,
 					    enum amdgpu_interrupt_state state)
 {
 	u32 dc_hpd_int_cntl;
 
-	if (type >= adev->mode_info.num_hpd) {
-		DRM_DEBUG("invalid hdp %d\n", type);
+	if (hpd >= adev->mode_info.num_hpd) {
+		DRM_DEBUG("invalid hpd %d\n", hpd);
 		return 0;
 	}
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		dc_hpd_int_cntl = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[type]);
+		dc_hpd_int_cntl = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
 		dc_hpd_int_cntl &= ~DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK;
-		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[type], dc_hpd_int_cntl);
+		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], dc_hpd_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		dc_hpd_int_cntl = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[type]);
+		dc_hpd_int_cntl = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
 		dc_hpd_int_cntl |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK;
-		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[type], dc_hpd_int_cntl);
+		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], dc_hpd_int_cntl);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 04b79ff87f75..4491b82561a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -271,7 +271,7 @@ static void dce_v8_0_hpd_int_ack(struct amdgpu_device *adev,
 	u32 tmp;
 
 	if (hpd >= adev->mode_info.num_hpd) {
-		DRM_DEBUG("invalid hdp %d\n", hpd);
+		DRM_DEBUG("invalid hpd %d\n", hpd);
 		return;
 	}
 
@@ -3003,7 +3003,7 @@ static int dce_v8_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
 	u32 dc_hpd_int_cntl;
 
 	if (type >= adev->mode_info.num_hpd) {
-		DRM_DEBUG("invalid hdp %d\n", type);
+		DRM_DEBUG("invalid hpd %d\n", type);
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 5e1b5ab9fbc6..2fe58b942ec2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -653,7 +653,7 @@ static bool construct_phy(struct dc_link *link,
 		}
 
 		/* Look for device tag that matches connector signal,
-		 * CRT for rgb, LCD for other supported signal tyes
+		 * CRT for rgb, LCD for other supported signal types
 		 */
 		if (!bp_funcs->is_device_id_supported(dc_ctx->dc_bios,
 						      link->device_tag.dev_id))
-- 
2.49.0


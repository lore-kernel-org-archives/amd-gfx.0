Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE72AF588C4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC8C10E5B8;
	Mon, 20 Apr 2026 13:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bf3+Wn14";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC3D10E07E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 19:48:52 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5a415fd6bceso1286162e87.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776455330; x=1777060130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4RdytHEJNq2b8qwksSfnD+lzh/+ULx6ZcQWcNHRMd1E=;
 b=bf3+Wn14ZOhAVaoIqO3vuCzYaC5SciybXNKi6q3J6yHRJSSwG19WbB6n+wu66KzqQH
 MobfZS4paGkegxnliVcHUVFdmAI9fqRVqRO0vUJGZQfcdHVaULP0/2Fm5O7szpGad86H
 jKYSIBl8Zc4AimrI8q0K4UpPESBUtJD++0vjaOQfB5RENGDXvh2CZBa5GQevlQwRoG0z
 fbZv9M5F4+OM9wIHFxW8jHi8yDrpmqHzExRVxYhaDfwlYQg3hPZVOnEoQW5kQEGyDvPk
 ufcRvZ/9PG7ZWIb38SBoD8PVyRGcXxSr+65h+4NPL6rns+1JLnAkotBE2foStj6bq9fJ
 CHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776455330; x=1777060130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RdytHEJNq2b8qwksSfnD+lzh/+ULx6ZcQWcNHRMd1E=;
 b=etil7iHTlDJmDNQ/FymvbdJAsqXtTNp+JB7zWjQK7FhJvnKxKCOip3b9tipibh1gF4
 OxJXjaTEMmElZU9KXaPBpWbaTrHxH8uxCU36xGvu+h3KHjvzpjHGqrfoRpTogfFyyeXJ
 /al4g+kTzbWWEQZJN4Gcnx/Vnigb6jhrTH3zfFwIpSwaC/auN7Uo+TS2eeyISJgbsA99
 TGU116v44UkB0jr6oRYsjFIRB03T6UkFrJsFS5EUYZKnz9CRxrUfCXroY928T13dLK09
 +IeULSHlms6ASUUbT75KqAx3dBU+NLoCOYLGJACRNFM5EoeofdrdIpaXOMmWYpZgAgnq
 PU8w==
X-Gm-Message-State: AOJu0YyAP2DRE2Le5aYQC+h2Wk+dTqy1HVudGr2cLi1ocAo1yWeYz/VB
 ZmF8WrPusJz6lit6vwpt3np8CALVJJsurn32Tz4tq3fUhuyUIU9uEE10weTYVUZL
X-Gm-Gg: AeBDietvRBuodDdX89rx4CCrhpOo/PrmVx012CSChw3xMKhmFyUZU+gx/qsnW8qwLIT
 Ym9KIMabOEf+Li/evYBUFHKNlO8gHLUNxvNhRNdzxMjvKVNkVKH2TxM+4FD2ScR7inxHmx6a+UV
 kr5atPwq/kM+6En5xwoq6fCMBGkLUh6hcGR7c2FndsCEkQnApxNEaKzfbH/wVVzRfhcOEz8ZBCX
 NM3vwjwUd2yZU2AmyU5OV0TQiY9e656BwZMkdCF/VMMly1RHKPf+8fAP8D6cIaDO1x3dXlgQ9hI
 bwGP6sXAkm74Ol3fwxoBlE3dE/dD988v6gI5SN5D+3Y3qXpQNoMaNe65fwGXRlVZKmfPi2LBvr9
 XwFbJ57p1nqmjjWtAKNVhR3C/00K+8FjoFdY3NvH8qoeOaMS/+M1pH8Mnrziza9n0/WtK2k7tvA
 9ZBJCtYZq+IAjI/nd9fM1eJb8R4QqjKYmCBrWmCTSRItUPAEEnuGMty3BhlR0e40DvkvIYHiA/j
 0+h+fNxm0wQT3Pnu2M+chCYI9JmRBRQpKTHJ7HdDvS8ZjLhXlHVxlmFC+HvARszMcoRCrgSe8Yn
 qgZzQbFP9QwOJWrOhcN/TT3Wr5F2cg==
X-Received: by 2002:a05:6512:3b0d:b0:5a3:f0a7:2f72 with SMTP id
 2adb3069b0e04-5a416f4c333mr1152842e87.0.1776455329659; 
 Fri, 17 Apr 2026 12:48:49 -0700 (PDT)
Received: from lilia.home ([46.205.200.78]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad0d0sm667857e87.5.2026.04.17.12.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 12:48:49 -0700 (PDT)
From: mjgajda@gmail.com
To: amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 dri-devel@lists.freedesktop.org, "M. Gajda" <mjgajda@gmail.com>
Subject: [PATCH] drm/amdgpu: allow unprivileged read of GC_THROTTLE_STATUS
Date: Fri, 17 Apr 2026 21:48:35 +0200
Message-ID: <20260417194835.792023-1-mjgajda@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 13:02:49 +0000
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

From: "M. Gajda" <mjgajda@gmail.com>

GC_THROTTLE_STATUS is a read-only hardware status register present on all
RDNA GPU generations (GFX10/11/12).  It reports the state of the GFX
thermal throttle finite state machine:

  FSM_STATE    [3:0]  non-zero = GPU currently being throttled
  PATTERN_INDEX [9:4]  active throttle duty-cycle pattern

The register is never written by the driver.  No side-effects occur on
read.  Add it to the per-ASIC allowed_read_registers[] tables so that
unprivileged userspace can query it via the AMDGPU_INFO_READ_MMR_REG ioctl
(libdrm: amdgpu_read_mm_registers(3)).

This enables monitoring tools such as radeontop to display GPU thermal
throttle status without root privileges -- information of the same
sensitivity class as GPU temperature, which is already exposed via the
AMDGPU_INFO_SENSOR_GPU_TEMP sensor ioctl.

Register offsets per generation:
  GFX10 (RDNA 1/2): mmGC_THROTTLE_STATUS  0x2032  BASE_IDX 0
  GFX11 (RDNA 3):  regGC_THROTTLE_STATUS  0x1b0a  BASE_IDX 1
  GFX12 (RDNA 4):  regGC_THROTTLE_STATUS  0x1b1c  BASE_IDX 1

Source: drivers/gpu/drm/amd/include/asic_reg/gc/
  gc_10_3_0_{offset,sh_mask}.h, gc_11_0_0_{offset,sh_mask}.h,
  gc_12_0_0_{offset,sh_mask}.h

Public ISA documentation:
  RDNA 1: https://developer.amd.com/wp-content/resources/RDNA_Shader_ISA.pdf
  RDNA 2: https://www.amd.com/content/dam/amd/en/documents/radeon-tech-docs/instruction-set-architectures/rdna2-shader-instruction-set-architecture.pdf
  RDNA 3: https://docs.amd.com/v/u/en-US/rdna3-shader-instruction-set-architecture
  RDNA 4: https://docs.amd.com/v/u/en-US/rdna4-instruction-set-architecture

Signed-off-by: M. Gajda <mjgajda@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/soc24.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7ce1a1b95..80594c793 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -352,6 +352,12 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1)},
 	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS)},
 	{ SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
+	/*
+	 * GC_THROTTLE_STATUS (offset 0x2032): read-only thermal throttle FSM.
+	 * FSM_STATE [3:0] != 0 indicates the GPU is currently being throttled.
+	 * Defined in gc_10_3_0_offset.h / gc_10_3_0_sh_mask.h
+	 */
+	{ SOC15_REG_ENTRY(GC, 0, mmGC_THROTTLE_STATUS)},
 };
 
 static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index fbd1d97f3..8c2472bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -304,6 +304,12 @@ static struct soc15_allowed_register_entry soc21_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
 	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
 	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
+	/*
+	 * GC_THROTTLE_STATUS (offset 0x1b0a): read-only thermal throttle FSM.
+	 * FSM_STATE [3:0] != 0 indicates the GPU is currently being throttled.
+	 * Defined in gc_11_0_0_offset.h / gc_11_0_0_sh_mask.h
+	 */
+	{ SOC15_REG_ENTRY(GC, 0, regGC_THROTTLE_STATUS)},
 };
 
 static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index d1adf19a5..617ee0a4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -130,6 +130,12 @@ static struct soc15_allowed_register_entry soc24_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
 	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
 	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
+	/*
+	 * GC_THROTTLE_STATUS (offset 0x1b1c): read-only thermal throttle FSM.
+	 * FSM_STATE [3:0] != 0 indicates the GPU is currently being throttled.
+	 * Defined in gc_12_0_0_offset.h / gc_12_0_0_sh_mask.h
+	 */
+	{ SOC15_REG_ENTRY(GC, 0, regGC_THROTTLE_STATUS)},
 };
 
 static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
-- 
2.51.0


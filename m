Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7287BC5AD49
	for <amd-gfx@archiver.kernel.org>; Sat, 31 May 2025 02:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D1C10E00F;
	Sat, 31 May 2025 02:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VGDl30XJ";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115EC10E00F
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 May 2025 02:14:31 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-6facb09ea08so35702836d6.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 19:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748657669; x=1749262469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9K2GMRI4QsYclz5finreq7ksGjQbFzz17+R8iv2PKMw=;
 b=VGDl30XJC9HSxLF4opFS3iu4Bs7sUDQZLCF2X1kf8S3eHMtpXp4+2xuAgGTacbHt29
 CAzlZq6AL7/h3DvhgPkWgVZyu+d9G2jXE7DrvB9VSRe2OmNSgY3hBcGXutv71IVpxZVb
 jK+K5caFDhJ4Rrvhx2k7TFtngKjU93GtdpQ/oDrJHSXdnFIZ34YJLkn3MBGiKFdZnVjf
 xh2aApNnEX2Px9X33YAig+J+QUkfDyph145X7NQhHXZmoUUp4Wv1kYQDuhZHpmK8fQTR
 hN1jTGQxATOlS3iEZL+m2+1fwktIdGoig4GDibycDy6hYZD3W+KuUBxTTxCCG80/f4mw
 bsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748657669; x=1749262469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9K2GMRI4QsYclz5finreq7ksGjQbFzz17+R8iv2PKMw=;
 b=fJqSopEtPvptWwBiKeuiKuAbbk/52Yl4EQ/c8cCiOMCSafyQm6fmjwusofVqvNw5nP
 LXTzQsG+0E9hqI4n8T8cg5M4Ru7FkAQuZwa8Px3Kk3pjr+l66sMaMm57q/bu84GYWv4U
 o/QAqsa5VPx4kfPtNFMPRZ+QsX8iKrMQI53LkzH648GX+nxOEwdNHt9s0gCs4OVLjZvR
 9ljORYr9qHx84X3CeampyUuCcqJdkTbcP9zreUa3Sesp4dx/svxZVDMtuw4Z4lOQYHvB
 4gSrP1NA3ab0w9eYcIEFhLOiqFKQ2H+hdkX5WZecsBNVA1Srsbl8k36EIkXFdYJ5Y7TN
 +G6A==
X-Gm-Message-State: AOJu0YyBxJjATVeG7aS1+NDZ7xvI1TgsyRvpJDvaU5YlZN9Nw4cu9Bs+
 eIT+7aDhMaDt8z35sYZEyuFK0ndzNc93b7Xr9AsZ77KxVVKFLDox1l7A4wylrg==
X-Gm-Gg: ASbGnctmgtvqor3kV72F3MBcDJ/tJ8nsUkyJJd/ZC6DHxA0HmIKjTR4tBJv5xACBrvO
 1Ia806tTujhwto1L3g6d1rpVtb/L93vXu3XMJCgANHc71653iE4SA0Hm9+i7gO7gw3fxGSOhes9
 E7xA/CRrOL0/8TaVbUWUzS1SMWRZZ9bhh/8UKQRzfS+ZiGrfQrL5aBjRkLVe4TDhYxflxFbI/JD
 ORhziM3B3aK8ay/ISEsnXh4N98qCTxMGZe6cIL/S+H4O7IO1R3nGzQxlIOogfqWeezZUabALTrR
 PvcYkq0xepyQSmaoi3uFdaTrCC82Z5tgld4MGMqDTQEe5Yulf1m9TKhevbFUH5miuTEgussp+EJ
 MJNeUnKN6
X-Google-Smtp-Source: AGHT+IGcx7FNPLHqqqHeOVbGPk4sZWL0R/qJr3AKMINChcbye+AN6FAev6AJ+UFwGQ3Afrz/SmjuYg==
X-Received: by 2002:a05:6214:f0b:b0:6fa:cce8:3bdd with SMTP id
 6a1803df08f44-6fad1967231mr84702526d6.36.1748657668464; 
 Fri, 30 May 2025 19:14:28 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.245])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d338f3sm32630226d6.17.2025.05.30.19.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 19:14:27 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 1/2] drm/amdgpu: include uncondionally SI support in new AMD
 DC engine
Date: Fri, 30 May 2025 22:14:05 -0400
Message-ID: <20250531021407.6623-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
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

This removes CONFIG_DRM_AMD_DC_SI references and use.

While it is stated that CONFIG_DRM_AMD_DC_SI is used to enable the new AMD
DC support for SI ASICS by default, it is not exactly what it does. This
option is adding the support of the SI ASICS in DC, but not enabling it by
default. To actually enable its usage, the user still have to set
amdgpu.dc=1 as a kernel parameter.

Since the code path seems to be stable (as stable as the CIK support),
include support for SI in the new DC code path unconditonnally and only
rely on amdgpu.dc to enable it.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 arch/mips/configs/loongson3_defconfig            |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 13 ++++++-------
 drivers/gpu/drm/amd/amdgpu/si.c                  |  4 ++--
 drivers/gpu/drm/amd/display/Kconfig              | 15 +++------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  8 --------
 drivers/gpu/drm/amd/display/dc/Makefile          |  3 ---
 drivers/gpu/drm/amd/display/dc/bios/Makefile     |  2 --
 .../amd/display/dc/bios/command_table_helper.c   |  2 --
 .../amd/display/dc/bios/command_table_helper.h   |  2 --
 .../amd/display/dc/bios/command_table_helper2.c  |  2 --
 .../amd/display/dc/bios/command_table_helper2.h  |  2 --
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile  |  2 --
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c |  2 --
 .../gpu/drm/amd/display/dc/core/dc_resource.c    |  6 ------
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c   |  6 ------
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.h   |  4 ----
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h    |  4 ----
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c     |  6 ------
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h     |  4 ----
 .../drm/amd/display/dc/dce/dce_link_encoder.c    | 12 ------------
 .../drm/amd/display/dc/dce/dce_link_encoder.h    |  4 ----
 .../gpu/drm/amd/display/dc/dce/dce_mem_input.c   | 16 ----------------
 .../gpu/drm/amd/display/dc/dce/dce_mem_input.h   | 12 ------------
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c     | 16 ----------------
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h     |  6 ------
 .../gpu/drm/amd/display/dc/dce/dce_transform.c   | 16 ----------------
 .../gpu/drm/amd/display/dc/dce/dce_transform.h   | 14 --------------
 drivers/gpu/drm/amd/display/dc/gpio/Makefile     |  2 --
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c |  5 -----
 .../gpu/drm/amd/display/dc/gpio/hw_translate.c   |  4 ----
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c  |  2 --
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h  |  6 ------
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h |  4 ----
 drivers/gpu/drm/amd/display/dc/irq/Makefile      |  2 --
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c |  6 +-----
 35 files changed, 12 insertions(+), 203 deletions(-)

diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 98844b457b7f..69602ae216f6 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -275,7 +275,6 @@ CONFIG_DRM_AMDGPU_SI=y
 CONFIG_DRM_AMDGPU_CIK=y
 CONFIG_DRM_AMDGPU_USERPTR=y
 CONFIG_DRM_AMD_ACP=y
-CONFIG_DRM_AMD_DC_SI=y
 CONFIG_DRM_AST=m
 CONFIG_DRM_QXL=y
 CONFIG_DRM_VIRTIO_GPU=y
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cd4fac120834..d9cc3773394c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3902,6 +3902,9 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 #endif
 	case CHIP_TOPAZ:
 		/* chips with no display hardware */
+		if (amdgpu_dc > 0) {
+			DRM_INFO_ONCE("Display Core has been requested via kernel parameter but isn't supported by ASIC, ignoring\n");
+		}
 		return false;
 #if defined(CONFIG_DRM_AMD_DC)
 	case CHIP_TAHITI:
@@ -3915,11 +3918,6 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 		 * Fallback to the non-DC driver here by default so as not to
 		 * cause regressions.
 		 */
-#if defined(CONFIG_DRM_AMD_DC_SI)
-		return amdgpu_dc > 0;
-#else
-		return false;
-#endif
 	case CHIP_BONAIRE:
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
@@ -3936,8 +3934,9 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 		return amdgpu_dc != 0;
 #else
 	default:
-		if (amdgpu_dc > 0)
-			DRM_INFO_ONCE("Display Core has been requested via kernel parameter but isn't supported by ASIC, ignoring\n");
+		if (amdgpu_dc > 0) {
+			DRM_INFO_ONCE("Display Core has been requested via kernel parameter but support was not included in kernel, ignoring\n");
+		}
 		return false;
 #endif
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index c21f97d89cbe..a3966b5be8a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2710,7 +2710,7 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &si_smu_ip_block);
 		if (adev->enable_virtual_display)
 			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC) && defined(CONFIG_DRM_AMD_DC_SI)
+#if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 #endif
@@ -2728,7 +2728,7 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &si_smu_ip_block);
 		if (adev->enable_virtual_display)
 			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC) && defined(CONFIG_DRM_AMD_DC_SI)
+#if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 #endif
diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 11e3f2f3b174..c13ab30b8dd6 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -12,9 +12,9 @@ config DRM_AMD_DC
 	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
 	select DRM_AMD_DC_FP if ARCH_HAS_KERNEL_FPU_SUPPORT && !(CC_IS_CLANG && (ARM64 || LOONGARCH || RISCV))
 	help
-	  Choose this option if you want to use the new display engine
-	  support for AMDGPU. This adds required support for Vega and
-	  Raven ASICs.
+	  Choose this option to add required support for the new display engine
+	  for AMDGPU. SI and CIK ASICs still rely on older DCE code, set
+	  amdgpu.dc=1 as a kernel parameter to enable its use.
 
 	  calculate_bandwidth() is presently broken on all !(X86_64 || SPARC64 ||
 	  ARM64 || LOONGARCH || RISCV) architectures built with Clang (all released
@@ -28,15 +28,6 @@ config DRM_AMD_DC_FP
 	help
 	  Floating point support, required for DCN-based SoCs
 
-config DRM_AMD_DC_SI
-	bool "AMD DC support for Southern Islands ASICs"
-	depends on DRM_AMDGPU_SI
-	depends on DRM_AMD_DC
-	help
-	  Choose this option to enable new AMD DC support for SI asics
-	  by default. This includes Tahiti, Pitcairn, Cape Verde, Oland.
-	  Hainan is not supported by AMD DC and it has no physical DCE6.
-
 config DEBUG_KERNEL_DC
 	bool "Enable kgdb break in DC"
 	depends on DRM_AMD_DC
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5f216d626cbb..7855abab5a3d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2271,12 +2271,10 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	const struct dmcu_firmware_header_v1_0 *hdr;
 
 	switch (adev->asic_type) {
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
 	case CHIP_VERDE:
 	case CHIP_OLAND:
-#endif
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
 	case CHIP_KAVERI:
@@ -3943,7 +3941,6 @@ static int register_hpd_handlers(struct amdgpu_device *adev)
 	return 0;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 /* Register IRQ sources and initialize IRQ callbacks */
 static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 {
@@ -4040,7 +4037,6 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 
 	return r;
 }
-#endif
 
 /* Register IRQ sources and initialize IRQ callbacks */
 static int dce110_register_irq_handlers(struct amdgpu_device *adev)
@@ -5104,7 +5100,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	/* Software is initialized. Now we can register interrupt handlers. */
 	switch (adev->asic_type) {
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
 	case CHIP_VERDE:
@@ -5114,7 +5109,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 		break;
-#endif
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
 	case CHIP_KAVERI:
@@ -5326,7 +5320,6 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	switch (adev->asic_type) {
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
 	case CHIP_VERDE:
@@ -5339,7 +5332,6 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 		adev->mode_info.num_hpd = 2;
 		adev->mode_info.num_dig = 2;
 		break;
-#endif
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
 		adev->mode_info.num_crtc = 6;
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 8992e697759f..4d62181d52cf 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -44,10 +44,7 @@ DC_LIBS += dce120
 DC_LIBS += dce112
 DC_LIBS += dce110
 DC_LIBS += dce80
-
-ifdef CONFIG_DRM_AMD_DC_SI
 DC_LIBS += dce60
-endif
 
 DC_LIBS += hdcp
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/Makefile b/drivers/gpu/drm/amd/display/dc/bios/Makefile
index ed6b5e9763f6..31b9a7284bfc 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/bios/Makefile
@@ -36,9 +36,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_BIOS)
 ###############################################################################
 # All DCE6.x are derived from DCE6.0, so 6.0 MUST be defined if ANY of
 # DCE6.x is compiled.
-ifdef CONFIG_DRM_AMD_DC_SI
 AMD_DISPLAY_FILES += $(AMDDALPATH)/dc/bios/dce60/command_table_helper_dce60.o
-endif
 
 ###############################################################################
 # DCE 8x
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
index e317a3615147..d72cb2be3e6b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
@@ -36,13 +36,11 @@ bool dal_bios_parser_init_cmd_tbl_helper(
 	enum dce_version dce)
 {
 	switch (dce) {
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case DCE_VERSION_6_0:
 	case DCE_VERSION_6_1:
 	case DCE_VERSION_6_4:
 		*h = dal_cmd_tbl_helper_dce60_get_table();
 		return true;
-#endif
 
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
index dfd30aaf4032..3678fb418857 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
@@ -26,9 +26,7 @@
 #ifndef __DAL_COMMAND_TABLE_HELPER_H__
 #define __DAL_COMMAND_TABLE_HELPER_H__
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/command_table_helper_dce60.h"
-#endif
 #include "dce80/command_table_helper_dce80.h"
 #include "dce110/command_table_helper_dce110.h"
 #include "dce112/command_table_helper_dce112.h"
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 73458e295103..ccc7d1cf9c48 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -37,13 +37,11 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	enum dce_version dce)
 {
 	switch (dce) {
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case DCE_VERSION_6_0:
 	case DCE_VERSION_6_1:
 	case DCE_VERSION_6_4:
 		*h = dal_cmd_tbl_helper_dce60_get_table();
 		return true;
-#endif
 
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
index 66e0a3e73768..7798b1d32cc2 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
@@ -26,9 +26,7 @@
 #ifndef __DAL_COMMAND_TABLE_HELPER2_H__
 #define __DAL_COMMAND_TABLE_HELPER2_H__
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/command_table_helper_dce60.h"
-#endif
 #include "dce80/command_table_helper_dce80.h"
 #include "dce110/command_table_helper_dce110.h"
 #include "dce112/command_table_helper2_dce112.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index ab1132bc896a..1ba8ac232db2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -30,7 +30,6 @@ AMD_DAL_CLK_MGR = $(addprefix $(AMDDALPATH)/dc/clk_mgr/,$(CLK_MGR))
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR)
 
 
-ifdef CONFIG_DRM_AMD_DC_SI
 ###############################################################################
 # DCE 60
 ###############################################################################
@@ -39,7 +38,6 @@ CLK_MGR_DCE60 = dce60_clk_mgr.o
 AMD_DAL_CLK_MGR_DCE60 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dce60/,$(CLK_MGR_DCE60))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCE60)
-endif
 
 ###############################################################################
 # DCE 100 and DCE8x
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 0e243f4344d0..e548e4d57cbb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -149,7 +149,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	struct hw_asic_id asic_id = ctx->asic_id;
 
 	switch (asic_id.chip_family) {
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case FAMILY_SI: {
 		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
 
@@ -161,7 +160,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 		dce_clk_mgr_construct(ctx, clk_mgr);
 		return &clk_mgr->base;
 	}
-#endif
 	case FAMILY_CI:
 	case FAMILY_KV: {
 		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 626f75b6ad00..55320b52fdaf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -52,9 +52,7 @@
 #include "link/hwss/link_hwss_dio_fixed_vs_pe_retimer.h"
 #include "link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.h"
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/dce60_resource.h"
-#endif
 #include "dce80/dce80_resource.h"
 #include "dce100/dce100_resource.h"
 #include "dce110/dce110_resource.h"
@@ -105,7 +103,6 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 
 	switch (asic_id.chip_family) {
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case FAMILY_SI:
 		if (ASIC_REV_IS_TAHITI_P(asic_id.hw_internal_rev) ||
 		    ASIC_REV_IS_PITCAIRN_PM(asic_id.hw_internal_rev) ||
@@ -116,7 +113,6 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		else
 			dc_version = DCE_VERSION_6_1;
 		break;
-#endif
 	case FAMILY_CI:
 		dc_version = DCE_VERSION_8_0;
 		break;
@@ -224,7 +220,6 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	struct resource_pool *res_pool = NULL;
 
 	switch (dc_version) {
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case DCE_VERSION_6_0:
 		res_pool = dce60_create_resource_pool(
 			init_data->num_virtual_links, dc);
@@ -237,7 +232,6 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 		res_pool = dce64_create_resource_pool(
 			init_data->num_virtual_links, dc);
 		break;
-#endif
 	case DCE_VERSION_8_0:
 		res_pool = dce80_create_resource_pool(
 				init_data->num_virtual_links, dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index eeed840073fe..381843c32e5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -1149,7 +1149,6 @@ void dce_aud_wall_dto_setup(
 	}
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_aud_wall_dto_setup(
 	struct audio *audio,
 	enum signal_type signal,
@@ -1239,7 +1238,6 @@ static void dce60_aud_wall_dto_setup(
 
 	}
 }
-#endif
 
 static bool dce_aud_endpoint_valid(struct audio *audio)
 {
@@ -1302,7 +1300,6 @@ static const struct audio_funcs funcs = {
 	.destroy = dce_aud_destroy,
 };
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static const struct audio_funcs dce60_funcs = {
 	.endpoint_valid = dce_aud_endpoint_valid,
 	.hw_init = dce_aud_hw_init,
@@ -1312,7 +1309,6 @@ static const struct audio_funcs dce60_funcs = {
 	.az_configure = dce_aud_az_configure,
 	.destroy = dce_aud_destroy,
 };
-#endif
 
 void dce_aud_destroy(struct audio **audio)
 {
@@ -1347,7 +1343,6 @@ struct audio *dce_audio_create(
 	return &audio->base;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 struct audio *dce60_audio_create(
 		struct dc_context *ctx,
 		unsigned int inst,
@@ -1372,4 +1367,3 @@ struct audio *dce60_audio_create(
 	audio->masks = masks;
 	return &audio->base;
 }
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
index 1b7b8b079af4..4eab9daa8754 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
@@ -64,7 +64,6 @@
 		SF(AZALIA_F0_CODEC_ENDPOINT_INDEX, AZALIA_ENDPOINT_REG_INDEX, mask_sh),\
 		SF(AZALIA_F0_CODEC_ENDPOINT_DATA, AZALIA_ENDPOINT_REG_DATA, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define AUD_DCE60_MASK_SH_LIST(mask_sh)\
 		SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),\
 		SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),\
@@ -77,7 +76,6 @@
 		SF(AZALIA_F0_CODEC_FUNCTION_PARAMETER_POWER_STATES, EPSS, mask_sh), \
 		SF(AZALIA_F0_CODEC_ENDPOINT_INDEX, AZALIA_ENDPOINT_REG_INDEX, mask_sh),\
 		SF(AZALIA_F0_CODEC_ENDPOINT_DATA, AZALIA_ENDPOINT_REG_DATA, mask_sh)
-#endif
 
 struct dce_audio_registers {
 	uint32_t AZALIA_F0_CODEC_ENDPOINT_INDEX;
@@ -151,14 +149,12 @@ struct audio *dce_audio_create(
 		const struct dce_audio_shift *shifts,
 		const struct dce_audio_mask *masks);
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 struct audio *dce60_audio_create(
 		struct dc_context *ctx,
 		unsigned int inst,
 		const struct dce_audio_registers *reg,
 		const struct dce_audio_shift *shifts,
 		const struct dce_audio_mask *masks);
-#endif
 
 void dce_aud_destroy(struct audio **audio);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
index ff726b35ef6a..71115fed3177 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
@@ -50,7 +50,6 @@
 	SR(SMU_INTERRUPT_CONTROL), \
 	SR(DC_DMCU_SCRATCH)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define DMCU_DCE60_REG_LIST() \
 	SR(DMCU_CTRL), \
 	SR(DMCU_STATUS), \
@@ -66,7 +65,6 @@
 	SR(DMCU_IRAM_RD_DATA), \
 	SR(DMCU_INTERRUPT_TO_UC_EN_MASK), \
 	SR(DC_DMCU_SCRATCH)
-#endif
 
 #define DMCU_DCE80_REG_LIST() \
 	SR(DMCU_CTRL), \
@@ -127,7 +125,6 @@
 			STATIC_SCREEN4_INT_TO_UC_EN, mask_sh), \
 	DMCU_SF(SMU_INTERRUPT_CONTROL, DC_SMU_INT_ENABLE, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define DMCU_MASK_SH_LIST_DCE60(mask_sh) \
 	DMCU_SF(DMCU_CTRL, \
 			DMCU_ENABLE, mask_sh), \
@@ -144,7 +141,6 @@
 	DMCU_SF(MASTER_COMM_CMD_REG, \
 			MASTER_COMM_CMD_REG_BYTE0, mask_sh), \
 	DMCU_SF(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, mask_sh)
-#endif
 
 #define DMCU_MASK_SH_LIST_DCE80(mask_sh) \
 	DMCU_SF(DMCU_CTRL, \
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
index 34bff9aef66c..a09a92399252 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
@@ -229,7 +229,6 @@ static void dce_ipp_set_degamma(
 		  CURSOR2_DEGAMMA_MODE, degamma_type);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_ipp_set_degamma(
 	struct input_pixel_processor *ipp,
 	enum ipp_degamma_mode mode)
@@ -243,7 +242,6 @@ static void dce60_ipp_set_degamma(
 		  GRPH_DEGAMMA_MODE, degamma_type,
 		  CURSOR_DEGAMMA_MODE, degamma_type);
 }
-#endif
 
 static const struct ipp_funcs dce_ipp_funcs = {
 	.ipp_cursor_set_attributes = dce_ipp_cursor_set_attributes,
@@ -253,7 +251,6 @@ static const struct ipp_funcs dce_ipp_funcs = {
 	.ipp_set_degamma = dce_ipp_set_degamma
 };
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static const struct ipp_funcs dce60_ipp_funcs = {
 	.ipp_cursor_set_attributes = dce_ipp_cursor_set_attributes,
 	.ipp_cursor_set_position = dce_ipp_cursor_set_position,
@@ -261,7 +258,6 @@ static const struct ipp_funcs dce60_ipp_funcs = {
 	.ipp_program_input_lut = dce_ipp_program_input_lut,
 	.ipp_set_degamma = dce60_ipp_set_degamma
 };
-#endif
 
 
 /*****************************************/
@@ -285,7 +281,6 @@ void dce_ipp_construct(
 	ipp_dce->ipp_mask = ipp_mask;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_ipp_construct(
 	struct dce_ipp *ipp_dce,
 	struct dc_context *ctx,
@@ -302,7 +297,6 @@ void dce60_ipp_construct(
 	ipp_dce->ipp_shift = ipp_shift;
 	ipp_dce->ipp_mask = ipp_mask;
 }
-#endif
 
 void dce_ipp_destroy(struct input_pixel_processor **ipp)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h
index 0028d4bdd81b..97d4c7b4d74d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h
@@ -147,7 +147,6 @@
 	IPP_SF(DCP0_DEGAMMA_CONTROL, CURSOR_DEGAMMA_MODE, mask_sh), \
 	IPP_SF(DCP0_DEGAMMA_CONTROL, CURSOR2_DEGAMMA_MODE, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define IPP_DCE60_MASK_SH_LIST_DCE_COMMON_BASE(mask_sh) \
 	IPP_SF(CUR_UPDATE, CURSOR_UPDATE_LOCK, mask_sh), \
 	IPP_SF(CUR_CONTROL, CURSOR_EN, mask_sh), \
@@ -185,7 +184,6 @@
 	IPP_SF(DC_LUT_SEQ_COLOR, DC_LUT_SEQ_COLOR, mask_sh), \
 	IPP_SF(DEGAMMA_CONTROL, GRPH_DEGAMMA_MODE, mask_sh), \
 	IPP_SF(DEGAMMA_CONTROL, CURSOR_DEGAMMA_MODE, mask_sh)
-#endif
 
 #define IPP_REG_FIELD_LIST(type) \
 	type CURSOR_UPDATE_LOCK; \
@@ -273,14 +271,12 @@ void dce_ipp_construct(struct dce_ipp *ipp_dce,
 	const struct dce_ipp_shift *ipp_shift,
 	const struct dce_ipp_mask *ipp_mask);
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_ipp_construct(struct dce_ipp *ipp_dce,
 	struct dc_context *ctx,
 	int inst,
 	const struct dce_ipp_registers *regs,
 	const struct dce_ipp_shift *ipp_shift,
 	const struct dce_ipp_mask *ipp_mask);
-#endif
 
 void dce_ipp_destroy(struct input_pixel_processor **ipp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 4a9d07c31bc5..10e5ff758f23 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -460,7 +460,6 @@ static void set_dp_phy_pattern_hbr2_compliance_cp2520_2(
 	enable_phy_bypass_mode(enc110, false);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_set_dp_phy_pattern_hbr2_compliance_cp2520_2(
 	struct dce110_link_encoder *enc110,
 	unsigned int cp2520_pattern)
@@ -511,7 +510,6 @@ static void dce60_set_dp_phy_pattern_hbr2_compliance_cp2520_2(
 	/* Disable PHY Bypass mode to setup the test pattern */
 	enable_phy_bypass_mode(enc110, false);
 }
-#endif
 
 static void set_dp_phy_pattern_passthrough_mode(
 	struct dce110_link_encoder *enc110,
@@ -540,7 +538,6 @@ static void set_dp_phy_pattern_passthrough_mode(
 	disable_prbs_mode(enc110);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_set_dp_phy_pattern_passthrough_mode(
 	struct dce110_link_encoder *enc110,
 	enum dp_panel_mode panel_mode)
@@ -567,7 +564,6 @@ static void dce60_set_dp_phy_pattern_passthrough_mode(
 	/* Disable PRBS mode */
 	disable_prbs_mode(enc110);
 }
-#endif
 
 /* return value is bit-vector */
 static uint8_t get_frontend_source(
@@ -607,7 +603,6 @@ static void configure_encoder(
 	REG_UPDATE(DP_DPHY_SCRAM_CNTL, DPHY_SCRAMBLER_ADVANCE, 1);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_configure_encoder(
 	struct dce110_link_encoder *enc110,
 	const struct dc_link_settings *link_settings)
@@ -619,7 +614,6 @@ static void dce60_configure_encoder(
 
 	/* DCE6 has no DP_DPHY_SCRAM_CNTL register, skip setup scrambler */
 }
-#endif
 
 static void aux_initialize(
 	struct dce110_link_encoder *enc110)
@@ -1190,7 +1184,6 @@ void dce110_link_encoder_enable_dp_mst_output(
 	}
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 /* enables DP PHY output */
 static void dce60_link_encoder_enable_dp_output(
 	struct link_encoder *enc,
@@ -1268,7 +1261,6 @@ static void dce60_link_encoder_enable_dp_mst_output(
 		BREAK_TO_DEBUGGER();
 	}
 }
-#endif
 
 /*
  * @brief
@@ -1423,7 +1415,6 @@ void dce110_link_encoder_dp_set_phy_pattern(
 	}
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 /* set DP PHY test and training patterns */
 static void dce60_link_encoder_dp_set_phy_pattern(
 	struct link_encoder *enc,
@@ -1478,7 +1469,6 @@ static void dce60_link_encoder_dp_set_phy_pattern(
 		break;
 	}
 }
-#endif
 
 static void fill_stream_allocation_row_info(
 	const struct link_mst_stream_allocation *stream_allocation,
@@ -1679,7 +1669,6 @@ void dce110_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	*link_settings = max_link_cap;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static const struct link_encoder_funcs dce60_lnk_enc_funcs = {
 	.validate_output_with_stream =
 		dce110_link_encoder_validate_output_with_stream,
@@ -1813,4 +1802,3 @@ void dce60_link_encoder_construct(
 		enc110->base.features.flags.bits.HDMI_6GB_EN = 0;
 	}
 }
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index 261c70e01e33..0a25e93d20fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -76,7 +76,6 @@
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
 	SR(DCI_MEM_PWR_STATUS)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define LE_DCE60_REG_LIST(id)\
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
 	SR(DMCU_RAM_ACCESS_CTRL), \
@@ -102,7 +101,6 @@
 	SRI(DP_VID_STREAM_CNTL, DP, id), \
 	SRI(DP_DPHY_FAST_TRAINING, DP, id), \
 	SRI(DP_SEC_CNTL1, DP, id)
-#endif
 
 #define LE_DCE80_REG_LIST(id)\
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
@@ -199,7 +197,6 @@ void dce110_link_encoder_construct(
 	const struct dce110_link_enc_aux_registers *aux_regs,
 	const struct dce110_link_enc_hpd_registers *hpd_regs);
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_link_encoder_construct(
 	struct dce110_link_encoder *enc110,
 	const struct encoder_init_data *init_data,
@@ -207,7 +204,6 @@ void dce60_link_encoder_construct(
 	const struct dce110_link_enc_registers *link_regs,
 	const struct dce110_link_enc_aux_registers *aux_regs,
 	const struct dce110_link_enc_hpd_registers *hpd_regs);
-#endif
 
 bool dce110_link_encoder_validate_dvi_output(
 	const struct dce110_link_encoder *enc110,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index f5e1d9caee4c..c1cc373579fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -174,7 +174,6 @@ static void program_urgency_watermark(
 		URGENCY_HIGH_WATERMARK, urgency_high_wm);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_program_urgency_watermark(
 	struct dce_mem_input *dce_mi,
 	uint32_t wm_select,
@@ -188,7 +187,6 @@ static void dce60_program_urgency_watermark(
 		URGENCY_LOW_WATERMARK, urgency_low_wm,
 		URGENCY_HIGH_WATERMARK, urgency_high_wm);
 }
-#endif
 
 static void dce120_program_urgency_watermark(
 	struct dce_mem_input *dce_mi,
@@ -209,7 +207,6 @@ static void dce120_program_urgency_watermark(
 
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_program_nbp_watermark(
 	struct dce_mem_input *dce_mi,
 	uint32_t wm_select,
@@ -226,7 +223,6 @@ static void dce60_program_nbp_watermark(
 	REG_UPDATE(DPG_PIPE_NB_PSTATE_CHANGE_CONTROL,
 		NB_PSTATE_CHANGE_WATERMARK, nbp_wm);
 }
-#endif
 
 static void program_nbp_watermark(
 	struct dce_mem_input *dce_mi,
@@ -260,7 +256,6 @@ static void program_nbp_watermark(
 	}
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_program_stutter_watermark(
 	struct dce_mem_input *dce_mi,
 	uint32_t wm_select,
@@ -272,7 +267,6 @@ static void dce60_program_stutter_watermark(
 	REG_UPDATE(DPG_PIPE_STUTTER_CONTROL,
 		STUTTER_EXIT_SELF_REFRESH_WATERMARK, stutter_mark);
 }
-#endif
 
 static void dce120_program_stutter_watermark(
 	struct dce_mem_input *dce_mi,
@@ -335,7 +329,6 @@ static void dce_mi_program_display_marks(
 	program_stutter_watermark(dce_mi, 1, stutter_exit.d_mark); /* set d */
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_mi_program_display_marks(
 	struct mem_input *mi,
 	struct dce_watermarks nbp,
@@ -361,7 +354,6 @@ static void dce60_mi_program_display_marks(
 	dce60_program_stutter_watermark(dce_mi, 2, stutter_exit.a_mark); /* set a */
 	dce60_program_stutter_watermark(dce_mi, 1, stutter_exit.d_mark); /* set d */
 }
-#endif
 
 static void dce112_mi_program_display_marks(struct mem_input *mi,
 	struct dce_watermarks nbp,
@@ -523,7 +515,6 @@ static void program_size_and_rotation(
 			GRPH_ROTATION_ANGLE, rotation_angles[rotation]);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_program_size(
 	struct dce_mem_input *dce_mi,
 	enum dc_rotation_angle rotation, /* not used in DCE6 */
@@ -551,7 +542,6 @@ static void dce60_program_size(
 
 	/* DCE6 has no HW_ROTATION register, skip setting rotation_angles */
 }
-#endif
 
 static void program_grph_pixel_format(
 	struct dce_mem_input *dce_mi,
@@ -646,7 +636,6 @@ static void dce_mi_program_surface_config(
 		program_grph_pixel_format(dce_mi, format);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_mi_program_surface_config(
 	struct mem_input *mi,
 	enum surface_pixel_format format,
@@ -665,7 +654,6 @@ static void dce60_mi_program_surface_config(
 	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
 		program_grph_pixel_format(dce_mi, format);
 }
-#endif
 
 static uint32_t get_dmif_switch_time_us(
 	uint32_t h_total,
@@ -887,7 +875,6 @@ static const struct mem_input_funcs dce_mi_funcs = {
 	.mem_input_is_flip_pending = dce_mi_is_flip_pending
 };
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static const struct mem_input_funcs dce60_mi_funcs = {
 	.mem_input_program_display_marks = dce60_mi_program_display_marks,
 	.allocate_mem_input = dce_mi_allocate_dmif,
@@ -899,7 +886,6 @@ static const struct mem_input_funcs dce60_mi_funcs = {
 			dce60_mi_program_surface_config,
 	.mem_input_is_flip_pending = dce_mi_is_flip_pending
 };
-#endif
 
 static const struct mem_input_funcs dce112_mi_funcs = {
 	.mem_input_program_display_marks = dce112_mi_program_display_marks,
@@ -943,7 +929,6 @@ void dce_mem_input_construct(
 	dce_mi->masks = mi_mask;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_mem_input_construct(
 	struct dce_mem_input *dce_mi,
 	struct dc_context *ctx,
@@ -955,7 +940,6 @@ void dce60_mem_input_construct(
 	dce_mem_input_construct(dce_mi, ctx, inst, regs, mi_shift, mi_mask);
 	dce_mi->base.funcs = &dce60_mi_funcs;
 }
-#endif
 
 void dce112_mem_input_construct(
 	struct dce_mem_input *dce_mi,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
index e34e445a4013..ff4ef1fd11d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
@@ -58,7 +58,6 @@
 	SRI(DVMM_PTE_CONTROL, DCP, id),\
 	SRI(DVMM_PTE_ARB_CONTROL, DCP, id)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define MI_DCE6_REG_LIST(id)\
 	SRI(GRPH_ENABLE, DCP, id),\
 	SRI(GRPH_CONTROL, DCP, id),\
@@ -81,7 +80,6 @@
 	SRI(DPG_PIPE_URGENCY_CONTROL, DMIF_PG, id),\
 	SRI(DPG_PIPE_STUTTER_CONTROL, DMIF_PG, id),\
 	SRI(DMIF_BUFFER_CONTROL, PIPE, id)
-#endif
 
 #define MI_DCE8_REG_LIST(id)\
 	MI_DCE_BASE_REG_LIST(id),\
@@ -129,9 +127,7 @@ struct dce_mem_input_registers {
 	uint32_t GRPH_SECONDARY_SURFACE_ADDRESS_HIGH;
 	/* DMIF_PG */
 	uint32_t DPG_PIPE_ARBITRATION_CONTROL1;
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	uint32_t DPG_PIPE_ARBITRATION_CONTROL3;
-#endif
 	uint32_t DPG_WATERMARK_MASK_CONTROL;
 	uint32_t DPG_PIPE_URGENCY_CONTROL;
 	uint32_t DPG_PIPE_URGENT_LEVEL_CONTROL;
@@ -154,7 +150,6 @@ struct dce_mem_input_registers {
 #define SFB(blk_name, reg_name, field_name, post_fix)\
 	.field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define MI_GFX6_TILE_MASK_SH_LIST(mask_sh, blk)\
 	SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_BANK_WIDTH, mask_sh),\
@@ -164,7 +159,6 @@ struct dce_mem_input_registers {
 	SFB(blk, GRPH_CONTROL, GRPH_PIPE_CONFIG, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_ARRAY_MODE, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_COLOR_EXPANSION_MODE, mask_sh)
-#endif
 
 #define MI_GFX8_TILE_MASK_SH_LIST(mask_sh, blk)\
 	SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
@@ -202,7 +196,6 @@ struct dce_mem_input_registers {
 	SFB(blk, GRPH_UPDATE, GRPH_UPDATE_LOCK, mask_sh),\
 	SFB(blk, GRPH_FLIP_CONTROL, GRPH_SURFACE_UPDATE_H_RETRACE_EN, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define MI_DCP_MASK_SH_LIST_DCE6(mask_sh, blk)\
 	SFB(blk, GRPH_ENABLE, GRPH_ENABLE, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_DEPTH, mask_sh),\
@@ -225,7 +218,6 @@ struct dce_mem_input_registers {
 	SFB(blk, GRPH_UPDATE, GRPH_SURFACE_UPDATE_PENDING, mask_sh),\
 	SFB(blk, GRPH_UPDATE, GRPH_UPDATE_LOCK, mask_sh),\
 	SFB(blk, GRPH_FLIP_CONTROL, GRPH_SURFACE_UPDATE_H_RETRACE_EN, mask_sh)
-#endif
 
 #define MI_DCP_DCE11_MASK_SH_LIST(mask_sh, blk)\
 	SFB(blk, GRPH_PIPE_OUTSTANDING_REQUEST_LIMIT, GRPH_PIPE_OUTSTANDING_REQUEST_LIMIT, mask_sh)
@@ -237,7 +229,6 @@ struct dce_mem_input_registers {
 	SFB(blk, DVMM_PTE_ARB_CONTROL, DVMM_PTE_REQ_PER_CHUNK, mask_sh),\
 	SFB(blk, DVMM_PTE_ARB_CONTROL, DVMM_MAX_PTE_REQ_OUTSTANDING, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define MI_DMIF_PG_MASK_SH_LIST_DCE6(mask_sh, blk)\
 	SFB(blk, DPG_PIPE_ARBITRATION_CONTROL1, PIXEL_DURATION, mask_sh),\
 	SFB(blk, DPG_PIPE_URGENCY_CONTROL, URGENCY_LOW_WATERMARK, mask_sh),\
@@ -262,7 +253,6 @@ struct dce_mem_input_registers {
 	MI_DMIF_PG_MASK_SH_LIST_DCE6(mask_sh, ),\
 	MI_DMIF_PG_MASK_SH_DCE6(mask_sh, ),\
 	MI_GFX6_TILE_MASK_SH_LIST(mask_sh, )
-#endif
 
 #define MI_DMIF_PG_MASK_SH_LIST(mask_sh, blk)\
 	SFB(blk, DPG_PIPE_ARBITRATION_CONTROL1, PIXEL_DURATION, mask_sh),\
@@ -438,7 +428,6 @@ void dce_mem_input_construct(
 	const struct dce_mem_input_shift *mi_shift,
 	const struct dce_mem_input_mask *mi_mask);
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_mem_input_construct(
 	struct dce_mem_input *dce_mi,
 	struct dc_context *ctx,
@@ -446,7 +435,6 @@ void dce60_mem_input_construct(
 	const struct dce_mem_input_registers *regs,
 	const struct dce_mem_input_shift *mi_shift,
 	const struct dce_mem_input_mask *mi_mask);
-#endif
 
 void dce112_mem_input_construct(
 	struct dce_mem_input *dce_mi,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
index f342da5a5e50..3e297bfd7a5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
@@ -139,7 +139,6 @@ static void set_truncation(
 				params->flags.TRUNCATE_MODE);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 /*
  *	dce60_set_truncation
  *	1) set truncation depth: 0 for 18 bpp or 1 for 24 bpp
@@ -179,7 +178,6 @@ static void dce60_set_truncation(
 				FMT_TRUNCATE_DEPTH,
 				params->flags.TRUNCATE_DEPTH);
 }
-#endif
 
 /*
  *	set_spatial_dither
@@ -410,7 +408,6 @@ void dce110_opp_set_clamping(
 	}
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 /*
  *	Set Clamping for DCE6 parts
  *	1) Set clamping format based on bpc - 0 for 6bpc (No clamping)
@@ -459,7 +456,6 @@ static void dce60_opp_set_clamping(
 		break;
 	}
 }
-#endif
 
 /*
  *	set_pixel_encoding
@@ -496,7 +492,6 @@ static void set_pixel_encoding(
 
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 /*
  *	dce60_set_pixel_encoding
  *	DCE6 has no FMT_SUBSAMPLING_{MODE,ORDER} bits in FMT_CONTROL reg
@@ -527,7 +522,6 @@ static void dce60_set_pixel_encoding(
 	}
 
 }
-#endif
 
 void dce110_opp_program_bit_depth_reduction(
 	struct output_pixel_processor *opp,
@@ -540,7 +534,6 @@ void dce110_opp_program_bit_depth_reduction(
 	set_temporal_dither(opp110, params);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_opp_program_bit_depth_reduction(
 	struct output_pixel_processor *opp,
 	const struct bit_depth_reduction_params *params)
@@ -551,7 +544,6 @@ static void dce60_opp_program_bit_depth_reduction(
 	set_spatial_dither(opp110, params);
 	set_temporal_dither(opp110, params);
 }
-#endif
 
 void dce110_opp_program_clamping_and_pixel_encoding(
 	struct output_pixel_processor *opp,
@@ -563,7 +555,6 @@ void dce110_opp_program_clamping_and_pixel_encoding(
 	set_pixel_encoding(opp110, params);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_opp_program_clamping_and_pixel_encoding(
 	struct output_pixel_processor *opp,
 	const struct clamping_and_pixel_encoding_params *params)
@@ -573,7 +564,6 @@ static void dce60_opp_program_clamping_and_pixel_encoding(
 	dce60_opp_set_clamping(opp110, params);
 	dce60_set_pixel_encoding(opp110, params);
 }
-#endif
 
 static void program_formatter_420_memory(struct output_pixel_processor *opp)
 {
@@ -672,7 +662,6 @@ void dce110_opp_program_fmt(
 	return;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_opp_program_fmt(
 	struct output_pixel_processor *opp,
 	struct bit_depth_reduction_params *fmt_bit_depth,
@@ -697,7 +686,6 @@ static void dce60_opp_program_fmt(
 
 	return;
 }
-#endif
 
 
 
@@ -712,14 +700,12 @@ static const struct opp_funcs funcs = {
 	.opp_program_bit_depth_reduction = dce110_opp_program_bit_depth_reduction
 };
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static const struct opp_funcs dce60_opp_funcs = {
 	.opp_set_dyn_expansion = dce110_opp_set_dyn_expansion,
 	.opp_destroy = dce110_opp_destroy,
 	.opp_program_fmt = dce60_opp_program_fmt,
 	.opp_program_bit_depth_reduction = dce60_opp_program_bit_depth_reduction
 };
-#endif
 
 void dce110_opp_construct(struct dce110_opp *opp110,
 	struct dc_context *ctx,
@@ -739,7 +725,6 @@ void dce110_opp_construct(struct dce110_opp *opp110,
 	opp110->opp_mask = opp_mask;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_opp_construct(struct dce110_opp *opp110,
 	struct dc_context *ctx,
 	uint32_t inst,
@@ -757,7 +742,6 @@ void dce60_opp_construct(struct dce110_opp *opp110,
 	opp110->opp_shift = opp_shift;
 	opp110->opp_mask = opp_mask;
 }
-#endif
 
 void dce110_opp_destroy(struct output_pixel_processor **opp)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
index 3d9be87aae45..171b1e1c2513 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
@@ -81,7 +81,6 @@ enum dce110_opp_reg_type {
 	OPP_COMMON_REG_LIST_BASE(id), \
 	SRI(CONTROL, FMT_MEMORY, id)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define OPP_DCE_60_REG_LIST(id) \
 	SRI(FMT_DYNAMIC_EXP_CNTL, FMT, id), \
 	SRI(FMT_BIT_DEPTH_CONTROL, FMT, id), \
@@ -90,7 +89,6 @@ enum dce110_opp_reg_type {
 	SRI(FMT_DITHER_RAND_G_SEED, FMT, id), \
 	SRI(FMT_DITHER_RAND_B_SEED, FMT, id), \
 	SRI(FMT_CLAMP_CNTL, FMT, id)
-#endif
 
 #define OPP_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
@@ -203,7 +201,6 @@ enum dce110_opp_reg_type {
 	OPP_SF(FMT0_FMT_CONTROL, FMT_SUBSAMPLING_ORDER, mask_sh),\
 	OPP_SF(FMT0_FMT_CONTROL, FMT_CBCR_BIT_REDUCTION_BYPASS, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define OPP_COMMON_MASK_SH_LIST_DCE_60(mask_sh)\
 	OPP_SF(FMT_DYNAMIC_EXP_CNTL, FMT_DYNAMIC_EXP_EN, mask_sh),\
 	OPP_SF(FMT_DYNAMIC_EXP_CNTL, FMT_DYNAMIC_EXP_MODE, mask_sh),\
@@ -229,7 +226,6 @@ enum dce110_opp_reg_type {
 	OPP_SF(FMT_CLAMP_CNTL, FMT_CLAMP_DATA_EN, mask_sh),\
 	OPP_SF(FMT_CLAMP_CNTL, FMT_CLAMP_COLOR_FORMAT, mask_sh),\
 	OPP_SF(FMT_CONTROL, FMT_PIXEL_ENCODING, mask_sh)
-#endif
 
 #define OPP_REG_FIELD_LIST(type) \
 	type FMT_DYNAMIC_EXP_EN; \
@@ -318,14 +314,12 @@ void dce110_opp_construct(struct dce110_opp *opp110,
 	const struct dce_opp_shift *opp_shift,
 	const struct dce_opp_mask *opp_mask);
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_opp_construct(struct dce110_opp *opp110,
 	struct dc_context *ctx,
 	uint32_t inst,
 	const struct dce_opp_registers *regs,
 	const struct dce_opp_shift *opp_shift,
 	const struct dce_opp_mask *opp_mask);
-#endif
 
 void dce110_opp_destroy(struct output_pixel_processor **opp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 2b1673d69ea8..d97c7f9fd224 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -146,7 +146,6 @@ static bool setup_scaling_configuration(
 	return true;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static bool dce60_setup_scaling_configuration(
 	struct dce_transform *xfm_dce,
 	const struct scaler_data *data)
@@ -171,7 +170,6 @@ static bool dce60_setup_scaling_configuration(
 
 	return true;
 }
-#endif
 
 static void program_overscan(
 		struct dce_transform *xfm_dce,
@@ -306,7 +304,6 @@ static void calculate_inits(
 	inits->v_init.fraction = dc_fixpt_u0d19(v_init) << 5;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_calculate_inits(
 	struct dce_transform *xfm_dce,
 	const struct scaler_data *data,
@@ -334,7 +331,6 @@ static void dce60_calculate_inits(
 	inits->v_init.integer = dc_fixpt_floor(v_init);
 	inits->v_init.fraction = dc_fixpt_u0d19(v_init) << 5;
 }
-#endif
 
 static void program_scl_ratios_inits(
 	struct dce_transform *xfm_dce,
@@ -358,7 +354,6 @@ static void program_scl_ratios_inits(
 	REG_WRITE(SCL_AUTOMATIC_MODE_CONTROL, 0);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_program_scl_ratios_inits(
 	struct dce_transform *xfm_dce,
 	struct sclh_ratios_inits *inits)
@@ -386,7 +381,6 @@ static void dce60_program_scl_ratios_inits(
 
 	REG_WRITE(SCL_AUTOMATIC_MODE_CONTROL, 0);
 }
-#endif
 
 static const uint16_t *get_filter_coeffs_16p(int taps, struct fixed31_32 ratio)
 {
@@ -486,7 +480,6 @@ static void dce_transform_set_scaler(
 	REG_UPDATE(LB_DATA_FORMAT, ALPHA_EN, data->lb_params.alpha_en);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_transform_set_scaler(
 	struct transform *xfm,
 	const struct scaler_data *data)
@@ -567,7 +560,6 @@ static void dce60_transform_set_scaler(
 
 	/* DCE6 DATA_FORMAT register does not support ALPHA_EN */
 }
-#endif
 
 /*****************************************************************************
  * set_clamp
@@ -834,7 +826,6 @@ static void program_bit_depth_reduction(
 		   bit_depth_params->flags.HIGHPASS_RANDOM);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 /*****************************************************************************
  * dce60_transform_bit_depth_reduction program
  *
@@ -893,7 +884,6 @@ static void dce60_program_bit_depth_reduction(
 		   bit_depth_params->flags.RGB_RANDOM,
 		   bit_depth_params->flags.HIGHPASS_RANDOM);
 }
-#endif
 
 static int dce_transform_get_max_num_of_supported_lines(
 	struct dce_transform *xfm_dce,
@@ -1027,7 +1017,6 @@ static void dce_transform_set_pixel_storage_depth(
 	}
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static void dce60_transform_set_pixel_storage_depth(
 	struct transform *xfm,
 	enum lb_pixel_depth depth,
@@ -1067,7 +1056,6 @@ static void dce60_transform_set_pixel_storage_depth(
 			__func__);
 	}
 }
-#endif
 
 static void program_gamut_remap(
 	struct dce_transform *xfm_dce,
@@ -1606,7 +1594,6 @@ static const struct transform_funcs dce_transform_funcs = {
 	.transform_get_optimal_number_of_taps = dce_transform_get_optimal_number_of_taps
 };
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 static const struct transform_funcs dce60_transform_funcs = {
 	.transform_reset = dce_transform_reset,
 	.transform_set_scaler = dce60_transform_set_scaler,
@@ -1619,7 +1606,6 @@ static const struct transform_funcs dce60_transform_funcs = {
 	.transform_set_pixel_storage_depth = dce60_transform_set_pixel_storage_depth,
 	.transform_get_optimal_number_of_taps = dce_transform_get_optimal_number_of_taps
 };
-#endif
 
 /*****************************************/
 /* Constructor, Destructor               */
@@ -1653,7 +1639,6 @@ void dce_transform_construct(
 	xfm_dce->lb_memory_size = LB_TOTAL_NUMBER_OF_ENTRIES; /*0x6B0*/
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_transform_construct(
 	struct dce_transform *xfm_dce,
 	struct dc_context *ctx,
@@ -1681,4 +1666,3 @@ void dce60_transform_construct(
 	xfm_dce->lb_bits_per_entry = LB_BITS_PER_ENTRY;
 	xfm_dce->lb_memory_size = LB_TOTAL_NUMBER_OF_ENTRIES; /*0x6B0*/
 }
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
index cbce194ec7b8..ee7591d86832 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
@@ -108,7 +108,6 @@
 	SRI(DCFE_MEM_PWR_CTRL, DCFE, id), \
 	SRI(DCFE_MEM_PWR_STATUS, DCFE, id)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define XFM_COMMON_REG_LIST_DCE60_BASE(id) \
 	SRI(DATA_FORMAT, LB, id), \
 	SRI(GAMUT_REMAP_CONTROL, DCP, id), \
@@ -168,7 +167,6 @@
 #define XFM_COMMON_REG_LIST_DCE60(id) \
 	XFM_COMMON_REG_LIST_DCE60_BASE(id), \
 	SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
-#endif
 
 #define XFM_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
@@ -266,7 +264,6 @@
 	XFM_SF(DCFE_MEM_PWR_STATUS, DCP_REGAMMA_MEM_PWR_STATE, mask_sh),\
 	XFM_SF(SCL_MODE, SCL_PSCL_EN, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define XFM_COMMON_MASK_SH_LIST_DCE60(mask_sh) \
 	XFM_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(mask_sh), \
 	OPP_SF(DCFE_MEM_LIGHT_SLEEP_CNTL, REGAMMA_LUT_LIGHT_SLEEP_DIS, mask_sh),\
@@ -341,7 +338,6 @@
 	XFM_SF(SCL_VERT_FILTER_CONTROL, SCL_V_FILTER_PICK_NEAREST, mask_sh), \
 	XFM_SF(DC_LB_MEMORY_SPLIT, DC_LB_MEMORY_CONFIG, mask_sh), \
 	XFM_SF(DC_LB_MEM_SIZE, DC_LB_MEM_SIZE, mask_sh)
-#endif
 
 #define XFM_COMMON_MASK_SH_LIST_SOC_BASE(mask_sh) \
 	XFM_SF(DCP0_OUT_CLAMP_CONTROL_B_CB, OUT_CLAMP_MIN_B_CB, mask_sh), \
@@ -531,9 +527,7 @@ struct dce_transform_mask {
 };
 
 struct dce_transform_registers {
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	uint32_t DATA_FORMAT;
-#endif
 	uint32_t LB_DATA_FORMAT;
 	uint32_t GAMUT_REMAP_CONTROL;
 	uint32_t GAMUT_REMAP_C11_C12;
@@ -589,16 +583,12 @@ struct dce_transform_registers {
 	uint32_t SCL_HORZ_FILTER_SCALE_RATIO;
 	uint32_t SCL_VERT_FILTER_SCALE_RATIO;
 	uint32_t SCL_HORZ_FILTER_INIT;
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	uint32_t SCL_HORZ_FILTER_INIT_RGB_LUMA;
 	uint32_t SCL_HORZ_FILTER_INIT_CHROMA;
-#endif
 	uint32_t SCL_VERT_FILTER_INIT;
 	uint32_t SCL_AUTOMATIC_MODE_CONTROL;
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	uint32_t DC_LB_MEMORY_SPLIT;
 	uint32_t DC_LB_MEM_SIZE;
-#endif
 	uint32_t LB_MEMORY_CTRL;
 	uint32_t SCL_UPDATE;
 	uint32_t SCL_F_SHARP_CONTROL;
@@ -616,7 +606,6 @@ struct scl_ratios_inits {
 	struct init_int_and_frac v_init;
 };
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 struct sclh_ratios_inits {
 	uint32_t h_int_scale_ratio;
 	uint32_t v_int_scale_ratio;
@@ -624,7 +613,6 @@ struct sclh_ratios_inits {
 	struct init_int_and_frac h_init_chroma;
 	struct init_int_and_frac v_init;
 };
-#endif
 
 enum ram_filter_type {
 	FILTER_TYPE_RGB_Y_VERTICAL	= 0, /* 0 - RGB/Y Vertical filter */
@@ -658,14 +646,12 @@ void dce_transform_construct(struct dce_transform *xfm_dce,
 	const struct dce_transform_shift *xfm_shift,
 	const struct dce_transform_mask *xfm_mask);
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_transform_construct(struct dce_transform *xfm_dce,
 	struct dc_context *ctx,
 	uint32_t inst,
 	const struct dce_transform_registers *regs,
 	const struct dce_transform_shift *xfm_shift,
 	const struct dce_transform_mask *xfm_mask);
-#endif
 
 bool dce_transform_get_optimal_number_of_taps(
 	struct transform *xfm,
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
index b72e2a9f9a28..dcff47a53098 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -34,13 +34,11 @@ AMD_DISPLAY_FILES += $(AMD_DAL_GPIO)
 # DCE 6x
 ###############################################################################
 # all DCE6.x are derived from DCE6.0
-ifdef CONFIG_DRM_AMD_DC_SI
 GPIO_DCE60 = hw_translate_dce60.o hw_factory_dce60.o
 
 AMD_DAL_GPIO_DCE60 = $(addprefix $(AMDDALPATH)/dc/gpio/dce60/,$(GPIO_DCE60))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCE60)
-endif
 
 ###############################################################################
 # DCE 8x
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 9a0952f9004f..60003aad614f 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -40,9 +40,7 @@
  * Post-requisites: headers required by this unit
  */
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/hw_factory_dce60.h"
-#endif
 #include "dce80/hw_factory_dce80.h"
 #include "dce110/hw_factory_dce110.h"
 #include "dce120/hw_factory_dce120.h"
@@ -60,19 +58,16 @@ bool dal_hw_factory_init(
 	enum dce_environment dce_environment)
 {
 	switch (dce_version) {
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case DCE_VERSION_6_0:
 	case DCE_VERSION_6_1:
 	case DCE_VERSION_6_4:
 		dal_hw_factory_dce60_init(factory);
 		return true;
-#endif
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
 		dal_hw_factory_dce80_init(factory);
 		return true;
-
 	case DCE_VERSION_10_0:
 		dal_hw_factory_dce110_init(factory);
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 9832247ee739..f40af4ad5cee 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -40,9 +40,7 @@
  * Post-requisites: headers required by this unit
  */
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/hw_translate_dce60.h"
-#endif
 #include "dce80/hw_translate_dce80.h"
 #include "dce110/hw_translate_dce110.h"
 #include "dce120/hw_translate_dce120.h"
@@ -64,13 +62,11 @@ bool dal_hw_translate_init(
 	enum dce_environment dce_environment)
 {
 	switch (dce_version) {
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case DCE_VERSION_6_0:
 	case DCE_VERSION_6_1:
 	case DCE_VERSION_6_4:
 		dal_hw_translate_dce60_init(translate);
 		return true;
-#endif
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
index 4202fadb2c0e..96e2dcb675ad 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
@@ -85,14 +85,12 @@ void dce_pipe_control_lock(struct dc *dc,
 	}
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_pipe_control_lock(struct dc *dc,
 		struct pipe_ctx *pipe,
 		bool lock)
 {
 	/* DCE6 has no BLND_V_UPDATE_LOCK register */
 }
-#endif
 
 void dce_set_blender_mode(struct dce_hwseq *hws,
 	unsigned int blnd_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
index 84c8f8707c5d..2d37f46c2b2d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
@@ -139,11 +139,9 @@
 	SR(BLNDV_CONTROL),\
 	HWSEQ_PIXEL_RATE_REG_LIST(CRTC)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define HWSEQ_DCE6_REG_LIST() \
 	HWSEQ_DCEF_REG_LIST_DCE8(), \
 	HWSEQ_PIXEL_RATE_REG_LIST(CRTC)
-#endif
 
 #define HWSEQ_DCE8_REG_LIST() \
 	HWSEQ_DCEF_REG_LIST_DCE8(), \
@@ -724,11 +722,9 @@ struct dce_hwseq_registers {
 	HWS_SF1(blk, PHYPLL_PIXEL_RATE_CNTL, PHYPLL_PIXEL_RATE_SOURCE, mask_sh),\
 	HWS_SF1(blk, PHYPLL_PIXEL_RATE_CNTL, PIXEL_RATE_PLL_SOURCE, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define HWSEQ_DCE6_MASK_SH_LIST(mask_sh)\
 	.DCFE_CLOCK_ENABLE = CRTC_DCFE_CLOCK_CONTROL__CRTC_DCFE_CLOCK_ENABLE ## mask_sh, \
 	HWSEQ_PIXEL_RATE_MASK_SH_LIST(mask_sh, CRTC0_)
-#endif
 
 #define HWSEQ_DCE8_MASK_SH_LIST(mask_sh)\
 	.DCFE_CLOCK_ENABLE = CRTC_DCFE_CLOCK_CONTROL__CRTC_DCFE_CLOCK_ENABLE ## mask_sh, \
@@ -1277,11 +1273,9 @@ void dce_pipe_control_lock(struct dc *dc,
 void dce_set_blender_mode(struct dce_hwseq *hws,
 	unsigned int blnd_inst, enum blnd_mode mode);
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_pipe_control_lock(struct dc *dc,
 		struct pipe_ctx *pipe,
 		bool lock);
-#endif
 
 void dce_clock_gating_power_up(struct dce_hwseq *hws,
 		bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index c2dd061892f4..d34e8dc0f14e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -89,10 +89,8 @@ enum dentist_divider_range {
 	.DPREFCLK_CNTL = mmDPREFCLK_CNTL, \
 	.DENTIST_DISPCLK_CNTL = mmDENTIST_DISPCLK_CNTL
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define CLK_COMMON_REG_LIST_DCE60_BASE() \
 	SR(DENTIST_DISPCLK_CNTL)
-#endif
 
 #define CLK_COMMON_REG_LIST_DCN_BASE() \
 	SR(DENTIST_DISPCLK_CNTL)
@@ -119,11 +117,9 @@ enum dentist_divider_range {
 	CLK_SF(DPREFCLK_CNTL, DPREFCLK_SRC_SEL, mask_sh), \
 	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #define CLK_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(mask_sh) \
 	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh),\
 	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh)
-#endif
 
 #define CLK_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(mask_sh) \
 	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index 8ac36bdd4e1e..a7579ca45f2b 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -33,13 +33,11 @@ AMD_DISPLAY_FILES += $(AMD_DAL_IRQ)
 ###############################################################################
 # DCE 6x
 ###############################################################################
-ifdef CONFIG_DRM_AMD_DC_SI
 IRQ_DCE60 = irq_service_dce60.o
 
 AMD_DAL_IRQ_DCE60 = $(addprefix $(AMDDALPATH)/dc/irq/dce60/,$(IRQ_DCE60))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCE60)
-endif
 
 ###############################################################################
 # DCE 8x
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index eca3d7ee7e4e..5c56a87871f3 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -28,13 +28,9 @@
 #include "include/irq_service_interface.h"
 #include "include/logger_interface.h"
 
-#include "dce110/irq_service_dce110.h"
-
-#if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/irq_service_dce60.h"
-#endif
-
 #include "dce80/irq_service_dce80.h"
+#include "dce110/irq_service_dce110.h"
 #include "dce120/irq_service_dce120.h"
 #include "dcn10/irq_service_dcn10.h"
 
-- 
2.49.0


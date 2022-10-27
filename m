Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3F1C38A2D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 02:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C3D10E065;
	Thu, 27 Oct 2022 02:11:43 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6784E10E5E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 00:27:51 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id bp11so28663980wrb.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 17:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4eXRELClxaS1+GTAUjcu1GCFdYpl4HitkxdE57yg0U=;
 b=BUSRrVpV9W3ZH2vVZyktTSIyRSXKpZLb+YYJivJqjpqkS+4usyA6Lg+xGWFQrlKjAA
 jfJ/NBROEuOhcPpxPiGctizl1Kc5WB3R2QKeEyPFticxKdVuagg5BsK6t6T2yZnPmaPx
 IQ9ePsfE89bbrC1Fen1Q2e1QeF+RROlryodjgLp6TqJkzbYQ6wfNuRuPf/4KboPYgRU7
 HOLLtOkWjNAr4a2A+YVNSigRalMLnyiHKVNzo7FeMTRc5Lj7CiXcI6RzJPa7LGPhK1/1
 rFmiNXH7FOoU7QQJEB2lyS/fFCtsUVARvl/gq1aU64I4JA2zIYHyAIL4DVGVZg21SHAG
 AagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4eXRELClxaS1+GTAUjcu1GCFdYpl4HitkxdE57yg0U=;
 b=HDe/PsMi/BvbUQF/f1VZifUGJxerIet2F9eTQK84jgmGQATrJnyBmgypbUgUXt67IF
 lESA7hrcSC8PWhP0t6B5bWl0ruDijzQg8gaVyfwA23yVTmP1k+Ng+s43cfGNF1CM1xE4
 NRq0lZa9wQWo158B0VlbW1+S9p+22Y2TeBhTwHenndkP7y35YLlqCGIMOqeT1XGfPSgo
 zn41kCYqfolEH+QxPViKlS5T3hz6wiOe+6mffvQupTVqIdwbyGVLVK0tN6duyNW1rKX/
 YVaTLfmiU0n0IQzB/69GR/bn4GnQisovttTFKAp8xtRO8JBYZksod/JgT5d/xOY9I2d1
 DOzA==
X-Gm-Message-State: ACrzQf3JuKValImabjrdZgRWM1/deKIPsLMCPdxQiBtr05tdZ0oL8+9Y
 bw7s2L6u6ffKQnktVvpRtfE=
X-Google-Smtp-Source: AMsMyM4OWl+XdYpi4rcLesajr4AgsefcjsSGQnghOy6B5mcOLmrqmqdlrGNoXzxXbQy3icvGrEcHIQ==
X-Received: by 2002:a5d:5186:0:b0:236:79a2:af1 with SMTP id
 k6-20020a5d5186000000b0023679a20af1mr9797130wrv.648.1666830469729; 
 Wed, 26 Oct 2022 17:27:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b0022e66749437sm6519420wrx.93.2022.10.26.17.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 17:27:49 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Date: Thu, 27 Oct 2022 02:25:30 +0200
Message-Id: <20221027002528.15983-2-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221027002528.15983-1-hacc1225@gmail.com>
References: <20221027002528.15983-1-hacc1225@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 02:11:40 +0000
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
Cc: Ao Zhong <hacc1225@gmail.com>, linux-arm-kernel@lists.infradead.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After moving all FPU code to the DML folder, we can enable DCN support
for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
code in the DML folder that needs to use hardware FPU, and add a control
mechanism for ARM Neon.

Signed-off-by: Ao Zhong <hacc1225@gmail.com>
---
 drivers/gpu/drm/amd/display/Kconfig           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 64 ++++++++++++-------
 3 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 0142affcdaa3..a7f1c4e51719 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -6,7 +6,7 @@ config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
 	default y
 	select SND_HDA_COMPONENT if SND_HDA_CORE
-	select DRM_AMD_DC_DCN if (X86 || PPC64)
+	select DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON))
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index ab0c6d191038..1743ca0a3641 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -31,6 +31,8 @@
 #elif defined(CONFIG_PPC64)
 #include <asm/switch_to.h>
 #include <asm/cputable.h>
+#elif defined(CONFIG_ARM64)
+#include <asm/neon.h>
 #endif
 
 /**
@@ -99,6 +101,8 @@ void dc_fpu_begin(const char *function_name, const int line)
 			preempt_disable();
 			enable_kernel_fp();
 		}
+#elif defined(CONFIG_ARM64)
+		kernel_neon_begin();
 #endif
 	}
 
@@ -136,6 +140,8 @@ void dc_fpu_end(const char *function_name, const int line)
 			disable_kernel_fp();
 			preempt_enable();
 		}
+#elif defined(CONFIG_ARM64)
+		kernel_neon_end();
 #endif
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index d0c6cf61c676..3cdd109189e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
 dml_ccflags := -mhard-float -maltivec
 endif
 
+ifdef CONFIG_ARM64
+ifdef CONFIG_DRM_AMD_DC_DCN
+dml_rcflags_arm64 := -mgeneral-regs-only
+endif
+endif
+
 ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
@@ -87,32 +93,46 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags) $(dml_rcflags_arm64)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_32.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_rq_dlg_calc_32.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_32.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_rq_dlg_calc_32.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags) $(dml_rcflags_arm64)
+ifdef CONFIG_ARM64
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags_arm64)
+endif
 endif
 CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags) $(dml_rcflags_arm64)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags) $(dml_rcflags_arm64)
 
 DML = calcs/dce_calcs.o calcs/custom_float.o calcs/bw_fixed.o
 
-- 
2.37.4


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967ABECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 19:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1979210E143;
	Mon, 31 Oct 2022 19:40:01 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC3710E143
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 19:39:27 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 ja4-20020a05600c556400b003cf6e77f89cso23191wmb.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0xd/Nzdp7P6ZAlPXcv/MnRQejFmKk9KivjxiUT87Lw=;
 b=exhOSdIIUNv9Tua2tPuM1OWNhocqe/CodfQEZM7LbgSQ7U9QHrE0p6pYWzkiGi0XDg
 +6Z12OlKlOLb9I8vjWxLea4nXxGht0Z5a0dqitvdY7y6zwlVHkn86LOzoq4JATbPHWDF
 t1gHPQNh7ED1OzgVaSmdVgjdbIx/Ya0UdBBkgOq1IzkwoZMa2UnYxbWcZWr3B6i9DXI8
 ZfgrhDJvgp3TJSnsgsZa/gDy+edL+Gcta3NcvsOoOkd5/4l2ngiYoF/stPO/25iDRMA+
 aQ0JFJ6GC1rcQ43kcxep2IcX473x1Uw4fUsO33eDoGJ+juZCr7c5YO1XmV+1tKtkOGcD
 9tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0xd/Nzdp7P6ZAlPXcv/MnRQejFmKk9KivjxiUT87Lw=;
 b=Fkc+sNv9aLcVaBh0opLTMHVOa9HnE4qrJpNzVmhyJ0xPNhRc2FYS5X4j0ihpx1F/1Z
 R/ZGERipC1GPChu53KLLx/HcIqX0Ek6GFD0crfWuXzqkS7ALJ4bPvk1avBHj0ju+kM0r
 Me5QG5OYy+shBuXbydUKhGvyMu+6Hu6DmeANJTuAG/NEkTrDczxhXFbWJ1HJ6s3gldMB
 A2MIovyVigCLxLjND6Q5P1PFQJl887ZOyJwi1YV1s+snR1ZJJsRV16FE8FI+JuUWFGgX
 VByjWFQZsmHe5cWYUmBO6XzVqQh7GYsFYHICz51ROHuQnr1dvSPdbJNC2nFvrTVUVyNH
 nySQ==
X-Gm-Message-State: ACrzQf2Dgo+inWoCchc6eKxLWfQXiSg1KR0NaDipICK3abzl8GGJbLee
 QVSOHmqbrASdoxA8eQ8nokU=
X-Google-Smtp-Source: AMsMyM4Y3kWgI8Zs1DywkZ7JAdtiI0i7JajrBPiIUFObXa4nuH+p9B4SGDBmuWB0HRiBfjP+jjiJzQ==
X-Received: by 2002:a05:600c:6885:b0:3bd:d782:623c with SMTP id
 fn5-20020a05600c688500b003bdd782623cmr9189463wmb.102.1667245166079; 
 Mon, 31 Oct 2022 12:39:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c414900b003b49ab8ff53sm8216806wmm.8.2022.10.31.12.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Oct 2022 12:39:25 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v4 1/1] drm/amd/display: add DCN support for ARM64
Date: Mon, 31 Oct 2022 20:37:40 +0100
Message-Id: <20221031193738.23538-2-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221031193738.23538-1-hacc1225@gmail.com>
References: <20221031193738.23538-1-hacc1225@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Oct 2022 19:39:59 +0000
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
 drivers/gpu/drm/amd/display/Kconfig           |  3 ++-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 20 +++++++++++++++----
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 0142affcdaa3..843a55a6a3ac 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -6,7 +6,8 @@ config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
 	default y
 	select SND_HDA_COMPONENT if SND_HDA_CORE
-	select DRM_AMD_DC_DCN if (X86 || PPC64)
+	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
+	select DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
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
index d0c6cf61c676..d4e93bed1c8e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -33,6 +33,10 @@ ifdef CONFIG_PPC64
 dml_ccflags := -mhard-float -maltivec
 endif
 
+ifdef CONFIG_ARM64
+dml_rcflags := -mgeneral-regs-only
+endif
+
 ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
@@ -55,8 +59,6 @@ frame_warn_flag := -Wframe-larger-than=2048
 endif
 
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
-
-ifdef CONFIG_DRM_AMD_DC_DCN
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
@@ -88,7 +90,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags)
@@ -105,7 +106,18 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcf
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
-endif
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)
-- 
2.37.4


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A97ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 14:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F8210E669;
	Thu, 27 Oct 2022 14:58:57 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C680D10E670
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 14:46:28 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id h9so2608128wrt.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boAryHnCv+r1jyRQmdAv8InqtytH0NrdoW3foDIFqi8=;
 b=L3MzKq4OJIXgT3wprDjbyyKr6Kdg/Ovz7jQU4dS20SuL1nmNvPzq4+bCckt6VXoPBV
 xvPA6wEXCIWBhbn3gVI8h94aKkQTDiwOhBoWJbUhj4zY0VBG4KZlS+CFQcHgr0JQ00Mf
 6iI4223WhIzNtHfzUtkQCB4jFVVmkx8kzSprPhhye2gpVH2CzPgt38J9uLnC6R4HQaKZ
 KDUBiRWaFIAaJ0M/15XkVUy0awW2yEikpeAtqCuwmF53CdxdSseJGeM7h0Lv2gwLIsgO
 CG/+TtYVBLCfIuQOC6cL50V+Z8xIPW1VbvTqw8TFVwzf/0hPxSpB8X36XjQQsNK/LRRP
 P1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=boAryHnCv+r1jyRQmdAv8InqtytH0NrdoW3foDIFqi8=;
 b=6vcJWT2jk48EeyUU+AXYDAlyML1uv/henYC5BtZx5YMLXZWvQYW02QizO0AIlgAN8d
 Oy9OMIGVF4sF1ZmWmHnimOuUPgKh9QBHZnXV6+wSZYlRs4jHFYldsI5+o+BXTPXN930j
 fBmX6sMG14bs2EsKkVNQDLbx6PWg4d2os7gSqyWr8AkONnYt8DyEnVBL7dXFJETO4PDl
 S/BTCOuRF67KIqBT1aeW8ma3FqdeZ+iY1bN/oCNkdHp0usEkur7cUVNqKl5rkEAonrP6
 OKnMZZIn0yVWZsd2eo6dceH1bW1t9PYT0itN6o7zPxzCZ8YAP7AEc1vQFnJToruc2hCC
 dHJg==
X-Gm-Message-State: ACrzQf3v0wYx2H60nOmr1OR59tGali0fTnWE4COMbTlL0og0x4GQci5T
 N1JIqUo9QPwzI7U0yaSsvso=
X-Google-Smtp-Source: AMsMyM5MiAsTNZF5Wu9pjxgcsmgm4D0VFWeQB2xxNpggzSa6MmrFAUgDVec4o/kpZriWEoZ8m6ViTw==
X-Received: by 2002:a05:6000:1688:b0:22e:58cd:5a2b with SMTP id
 y8-20020a056000168800b0022e58cd5a2bmr32178612wrd.365.1666881987036; 
 Thu, 27 Oct 2022 07:46:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a5d50c6000000b00236576c8eddsm1340914wrt.12.2022.10.27.07.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Oct 2022 07:46:26 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2 1/1] drm/amd/display: add DCN support for ARM64
Date: Thu, 27 Oct 2022 16:45:29 +0200
Message-Id: <20221027144527.4247-2-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221027144527.4247-1-hacc1225@gmail.com>
References: <20221027144527.4247-1-hacc1225@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 14:58:52 +0000
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
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 21 ++++++++++++++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

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
index d0c6cf61c676..4e6e1fc0650f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
 dml_ccflags := -mhard-float -maltivec
 endif
 
+ifdef CONFIG_ARM64
+ifdef CONFIG_DRM_AMD_DC_DCN
+dml_rcflags := -mgeneral-regs-only
+endif
+endif
+
 ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
@@ -88,7 +94,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags)
@@ -105,6 +110,20 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcf
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
+ifdef CONFIG_ARM64
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
+endif
 endif
 CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
-- 
2.37.4


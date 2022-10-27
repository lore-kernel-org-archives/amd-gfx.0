Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53DDFA3743
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 21:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0930010E6FF;
	Thu, 27 Oct 2022 21:53:51 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A8710E033
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 19:54:10 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 b20-20020a05600c4e1400b003cc28585e2fso2014948wmq.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W20UuRH77Mvawp7AC2dyXHOPyF9RQVsPXo+NEuzDpKI=;
 b=ES9yO2WC501OkgTKw0H/+FjaGuq7iz/SdtOkoQjRihC8R9RBUxwmvC+o2kAiGUWHxX
 kRMOTna6sgYxmTQBbqsARVKB5tfFYWDsw2k4uc3oI5Q8faWSY1nD9pcr64pj/YNYG5ic
 7q5BxMJahefvuca6FOjA3Lx7pxYAVXNmrm/cGXmjwO7TauTq1yomdQI8oFYmPSAeualJ
 F7t4KaQFfUpulFCjJcrIAx8kujs0/+pJt7vOwoiCDp+ayXfjackQjJlAzTIhMK1w8Jqe
 ktrToyyKQurk/hM3gAK++ufg33jcAOXV66wq35TYF++RYXZDwKHavq2tVqyVVfg8J2TP
 fGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W20UuRH77Mvawp7AC2dyXHOPyF9RQVsPXo+NEuzDpKI=;
 b=ztPel8VLS/Bt0VRyphVVZH0hP9fTIrn1rFqUhFTPvqiKOadAwWEii6dbX7oq6DkHG8
 2I1o/Qbd7CZa8Fcc/DlyWJuc4frdQqm0MI6wjb0r/ZTeQz/ty/kgVniJLmRyuuvuEE6i
 MKEa5SLY3K/9RBu6AW83y03bLTV3eB4VScxxrZxx1Os9M6kWWQPIHocLPAdyd9U6KdVD
 8XwaJCwhIptkqQonXQCnxt5CHFGmH278uP9pSONpDc3b2Q1n5ifPuN6FgIxr8mgz5KBY
 HQR620Lu/lQ0N8qw6G0b+Gm3zce/j51Nt0odi0UeSe/iII4zQB76P7VtUvx4N9rlsK23
 GX/g==
X-Gm-Message-State: ACrzQf3Sm4KNSPDGpdyV5RaPTU7b3cS4CVxxNUTgHBS3L6Cl1jM2MEXZ
 ivLqzd6tLijRGIBuXNCWRe4=
X-Google-Smtp-Source: AMsMyM4NOWK1R+xxFNbP5cA9JDwygj9gvacZiUHA1sdas0xpxHYms1aRbOX7cgbxuVJfT8/HEMLL7g==
X-Received: by 2002:a1c:2743:0:b0:3b3:f017:f23a with SMTP id
 n64-20020a1c2743000000b003b3f017f23amr7390049wmn.137.1666900448872; 
 Thu, 27 Oct 2022 12:54:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a05600001d200b0023647841c5bsm1837976wrx.60.2022.10.27.12.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Oct 2022 12:54:08 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3 1/1] drm/amd/display: add DCN support for ARM64
Date: Thu, 27 Oct 2022 21:52:29 +0200
Message-Id: <20221027195227.5312-2-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221027195227.5312-1-hacc1225@gmail.com>
References: <20221027195227.5312-1-hacc1225@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 21:53:48 +0000
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
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 20 +++++++++++++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BF3C61D9C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 14:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCBA10E645;
	Wed, 22 Nov 2023 14:05:14 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21EF110E253
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 03:06:29 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6cb55001124so310680b3a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 19:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1700622388; x=1701227188; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Qgh5NSWFVqrYvvpg0jEH3io2ggLKyOiM/1ZRjzAMrY=;
 b=mAt84/9lm14N4r6RaTXZvNoGnUUmeN0puecKTHDYfmFMTnjs+2hSHZ00D0PGRHkgHZ
 EKqiwQhCu9aXirROBgtyuPO/iD/DO3jstkp/KVtcNYE92QbSLGDzAOTsnBQc9qjbu5BJ
 UkAMLtcYVS8BxFvn7GdhtNOgq7lq01hL6o4Z5wouRAhmaOjd3JEhh7PddSIC914P28nK
 iTtx7SFZxfrQ0xZRg2RIklZssNugMRmFbmmuOAh/0H1R1WQrpur2x/C/20Wn6RkYJ3EN
 Y0UPAUoapXdz+jbDty9SlIsf/V9Fl0kWn9P4vnfQgG+VrJ3Nk0hD83VdPGns7B96Nz88
 /kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700622388; x=1701227188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Qgh5NSWFVqrYvvpg0jEH3io2ggLKyOiM/1ZRjzAMrY=;
 b=II5V4o7SC5kg+3g1UHcRMiwOWA2Z0SO26hXnqHDNi0Gyf4WRell8tRnsLh/LyZRjyf
 tWTXH7H6H9+/uhv25ygYVxObAdauKIlk1lousdu06kF2offDQqeO2bvkWICSXdnkxrdp
 ucqQ9NtBXHHVjnABDBgVXSturA6aFx7tQMGhlh9LPjTpJzqMye/cKYG/B1orXP3zfpVh
 zXuS9zRmxGQQnfQO9r0jL8edm76Cy5BK+MTjcXvCXSf7Pgv683efLqFl2xrBbMB0p/hq
 jwrJRwKwKsxuzjul71a2Z2mEts8k6s5q2HCdW4Z0YOF2kSx7Qktd2b5QNtqbJzSvxWJN
 73MA==
X-Gm-Message-State: AOJu0YxLad5S1+7l4b+Xn4UH3v5JQjR3oyWzR8/fL1A90iscBfBBOhrA
 YtN96iGiSx5dy9noEuw9RUOzpQ==
X-Google-Smtp-Source: AGHT+IERIccwRaRQ+wlnx1zMjy0fsc3cDGpf4RjMA9LPr92p23dqVKDgXQEo3A0Wn14b3XN9NyJnpA==
X-Received: by 2002:a05:6a20:7da0:b0:17a:4871:63fd with SMTP id
 v32-20020a056a207da000b0017a487163fdmr1833586pzj.0.1700622388655; 
 Tue, 21 Nov 2023 19:06:28 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 s2-20020aa78282000000b006a77343b0ccsm8614917pfm.89.2023.11.21.19.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 19:06:28 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-riscv@lists.infradead.org
Subject: [PATCH 2/3] riscv: Factor out riscv-march-y to a separate Makefile
Date: Tue, 21 Nov 2023 19:05:14 -0800
Message-ID: <20231122030621.3759313-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122030621.3759313-1-samuel.holland@sifive.com>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Nov 2023 14:05:10 +0000
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
Cc: Pan Xinhui <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since it is not possible to incrementally add/remove extensions from the
compiler's ISA string by appending arguments, any code that wants to
modify the ISA string must recreate the whole thing. To support this,
factor out the logic for generating the -march argument so it can be
reused where needed.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Makefile     | 12 +-----------
 arch/riscv/Makefile.isa | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 11 deletions(-)
 create mode 100644 arch/riscv/Makefile.isa

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index a74be78678eb..c738eafe67a0 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -58,22 +58,12 @@ ifeq ($(CONFIG_SHADOW_CALL_STACK),y)
 	KBUILD_LDFLAGS += --no-relax-gp
 endif
 
-# ISA string setting
-riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
-riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
-riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
-riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
-riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
-
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 KBUILD_CFLAGS += -Wa,-misa-spec=2.2
 KBUILD_AFLAGS += -Wa,-misa-spec=2.2
-else
-riscv-march-$(CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI) := $(riscv-march-y)_zicsr_zifencei
 endif
 
-# Check if the toolchain supports Zihintpause extension
-riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
+include $(srctree)/arch/riscv/Makefile.isa
 
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
diff --git a/arch/riscv/Makefile.isa b/arch/riscv/Makefile.isa
new file mode 100644
index 000000000000..e10c77e26fe6
--- /dev/null
+++ b/arch/riscv/Makefile.isa
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# ISA string setting
+riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
+riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
+riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
+riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
+riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
+
+ifndef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
+riscv-march-$(CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI) := $(riscv-march-y)_zicsr_zifencei
+endif
+
+# Check if the toolchain supports Zihintpause extension
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
-- 
2.42.0


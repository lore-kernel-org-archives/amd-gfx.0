Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18DCCD128D
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 653F0112670;
	Fri, 29 Mar 2024 11:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="BUoBP19y";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2070F112331
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:25:47 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2a20e595351so643823a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697086; x=1712301886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfeToGq8Q96lZ3sXR0xrZDFoq0gdI38cqcIbuzYANg0=;
 b=BUoBP19yr1xPLl38k825kQLO9wYfKGt/TjG5ppZVclfo0Zcks/QN8tr5+ZVOzil43L
 LE5C3gBuk7+C32N7q91MUv5vfJj0+CxlhwETKQqvYwUkkSLuPEpSvmpkv74LWA0D8f2T
 tU0dmLzHp4QpGGs05zPpHgto5biNmcKF7IiZveIh6h2jYmgDBocgbN1VV0dmB2meJa2z
 /+roxaQxHnjGf9C8FYJh4MW7k3O5fHUYSMOmUN3leC/aiVcGLVYlJCHLsRSspv20S1A+
 b5fzH7rZyyXeYs4rqPWhSS70+p1L7CAS+GJfiq9VeCNBqyzxVMdWuFifJICdV/Cd98Ra
 6X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697086; x=1712301886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RfeToGq8Q96lZ3sXR0xrZDFoq0gdI38cqcIbuzYANg0=;
 b=cdDbzy7m7tnMWHSLlpff5Gv0BSCtqJRYsEUpGuB9THddgMydCqBmD8ipLZPan+ulve
 g8JM1VBT+cDdXZnmmH5iGcTBCgjFfGtN08sthhX5bo+SxHcfFGTNdSIMzmk0UvJHngh+
 APdTofVbRb5YYbjcl9VCc08QIFbSo8xbuE/tJEnOxV47HA1FA39i5YnOMthSWbsFrfPW
 p0MzGLyKA8OUUR75c1jDr3YJmdQpJIgyZkFgRErcKIhjIXf7Xp5cjUTocMYaCxauMbGT
 KiO6RcmeegwN2Abz6VtrzYZ24Q1HCLhDAhLnxLa5QfJc+6olvV2ldkNvxINREqDithib
 ahyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW441zUGucbBnAHn2gDfzSoS9bzqH+PtkZsMdsKT50UmvRHAPquJ8ybICmeEkfkxV90eVw5nsVtmQncTDTxOLo54RiDksKkj2R69Kc2Fw==
X-Gm-Message-State: AOJu0YwoNsZXteN9vbyzV0bdy1cfyFeUwapMNMifC4pMibzkqsBWisSg
 IGa4k1TcM8sJapBqW37zpGJxBAXdlhFnXlUQHDttDJQpxOfK1t7uqH5nu+wTpcU=
X-Google-Smtp-Source: AGHT+IGQfC9gwOMWVs1GDk/ouQ8mrl3lJb1JowaZL6ev/gV/g9creRjfkW6AQIWqS7U8Lf5+l0COxw==
X-Received: by 2002:a17:90a:4594:b0:2a2:88d:cdcb with SMTP id
 v20-20020a17090a459400b002a2088dcdcbmr1743529pjg.26.1711697086007; 
 Fri, 29 Mar 2024 00:24:46 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:24:45 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Fri, 29 Mar 2024 00:18:17 -0700
Message-ID: <20240329072441.591471-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Mar 2024 11:32:14 +0000
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

ARM provides an equivalent to the common kernel-mode FPU API, but in a
different header and using different function names. Add a wrapper
header, and export CFLAGS adjustments as found in lib/raid6/Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Remove file name from header comment

 arch/arm/Kconfig           |  1 +
 arch/arm/Makefile          |  7 +++++++
 arch/arm/include/asm/fpu.h | 15 +++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 arch/arm/include/asm/fpu.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b14aed3a17ab..b1751c2cab87 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -15,6 +15,7 @@ config ARM
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d82908b1b1bb..71afdd98ddf2 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -130,6 +130,13 @@ endif
 # Accept old syntax despite ".syntax unified"
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
 
+# The GCC option -ffreestanding is required in order to compile code containing
+# ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
+CC_FLAGS_FPU	:= -ffreestanding
+# Enable <arm_neon.h>
+CC_FLAGS_FPU	+= -isystem $(shell $(CC) -print-file-name=include)
+CC_FLAGS_FPU	+= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
+
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 CFLAGS_ISA	:=-Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
diff --git a/arch/arm/include/asm/fpu.h b/arch/arm/include/asm/fpu.h
new file mode 100644
index 000000000000..2ae50bdce59b
--- /dev/null
+++ b/arch/arm/include/asm/fpu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef __ASM_FPU_H
+#define __ASM_FPU_H
+
+#include <asm/neon.h>
+
+#define kernel_fpu_available()	cpu_has_neon()
+#define kernel_fpu_begin()	kernel_neon_begin()
+#define kernel_fpu_end()	kernel_neon_end()
+
+#endif /* ! __ASM_FPU_H */
-- 
2.44.0


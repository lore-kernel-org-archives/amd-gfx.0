Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661B4C10F05
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D509710EA2C;
	Fri,  8 Dec 2023 08:37:07 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7BC110E9CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 05:55:05 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d0b2752dc6so15623065ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 21:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702014905; x=1702619705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9S9qeMKPrbOjny9ys0DNZnwzZdal5DwwFbQdO5IaRKs=;
 b=ajmDgaycqjG7X8u+mM87C7x82AOu6Fvpam55DJVR+aYnQbea9T7euAbC/s6UQ9hE7p
 qenvpDG+7kGD5POdyx5/h9CtC7d8TaEnIqxENRjvtkWi74+UmuHvZJcmgnOqgxZ7Ucus
 oKZPxU1klTRSGfHc4y0nOlp/RnGNqPTpZl/h17rcpIJBn7VY8ub9RLZhDePoxhZR5WRk
 rH0cOkEU4e9523aTdwjewcGpVAjOQcH+kllWUNAB52yssTZpUNw7boMQsJhtqn+01O0f
 0OS5JRT3Pj4CCsK9wLI9D8lnFtgWjSnGCday7oKj778t/+Ou2Bm/HDjFwI2hIaPpT0yw
 HgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702014905; x=1702619705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9S9qeMKPrbOjny9ys0DNZnwzZdal5DwwFbQdO5IaRKs=;
 b=cFMwn0SoN787FmmavBAAHn4TFhb9uvUd1L+puEzCnFdCVX+Am4QtLmxoCoaOlWNhAZ
 DzF6ROxNVPs2pLuL+2d20PtMBlcEEpKucObkBCiLQSzqr/e0Lzn3sV8SCX+1rLphh0q0
 GSPZHYu0Q8XfcTIcdcciU1DFzO8FElHJ4Y/Sp55T3B+Y23/7bFhmuAAYcrd1/Y803ULB
 3ZqdHK7iHN+ZSAks/YT7Oqj56k6saTpR6zQt1z4CfyaZcAWQhCHEOu3kdvBXdRj8eQNG
 orCeaprhjezaf4pTb/va9iERmK2d+WTsmmHgp/ecndPIVUinUv8q7kWb8XsuSFH8eVsO
 0CyA==
X-Gm-Message-State: AOJu0YyFmPZvLuSpL+rYhXd2qrOjNpqJ8N2xgVY74c0UJRHldUNyfUc+
 QQQ5kGELT6BzyhrZZvl39nT9Yg==
X-Google-Smtp-Source: AGHT+IHfVmDuQcwcTNkJBCCNyd1od5dj0sgf6cJP7ZkJkjT+CFkpOEIDhByDVUVjY+z9LFISOIDfEQ==
X-Received: by 2002:a17:902:6844:b0:1cf:b190:ea07 with SMTP id
 f4-20020a170902684400b001cfb190ea07mr2955137pln.21.1702014905389; 
 Thu, 07 Dec 2023 21:55:05 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 21:55:05 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 02/12] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Thu,  7 Dec 2023 21:54:32 -0800
Message-ID: <20231208055501.2916202-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208055501.2916202-1-samuel.holland@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Dec 2023 08:37:01 +0000
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ARM provides an equivalent to the common kernel-mode FPU API, but in a
different header and using different function names. Add a wrapper
header, and export CFLAGS adjustments as found in lib/raid6/Makefile.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/arm/Kconfig           |  1 +
 arch/arm/Makefile          |  7 +++++++
 arch/arm/include/asm/fpu.h | 17 +++++++++++++++++
 3 files changed, 25 insertions(+)
 create mode 100644 arch/arm/include/asm/fpu.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f8567e95f98b..92e21a4a2903 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -14,6 +14,7 @@ config ARM
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5ba42f69f8ce..1dd860dba5f5 100644
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
index 000000000000..d01ca06e700a
--- /dev/null
+++ b/arch/arm/include/asm/fpu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * linux/arch/arm/include/asm/fpu.h
+ *
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
2.42.0


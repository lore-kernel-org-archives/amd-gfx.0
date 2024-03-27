Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D8CC54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 13:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F5F11242F;
	Thu, 28 Mar 2024 13:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="Z0SxsQ+a";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3600B10FFA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 20:02:02 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-1e0f3052145so2327695ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711569721; x=1712174521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=im7zmQeDt7pZodE0p+VySjAa7DBv0KaW+gKoLu+LS/g=;
 b=Z0SxsQ+aQGdc2ybFYj3clUmXuIFcU9q7q/GLwxj0Fxu9CL833BbIu4lskFqFUHCBuu
 wyN3PuzsX1iPKtxq0uE3Yt/em0nYVehmUyYjCvwe1Crtn/vASeeDhYV0ZZw0OpclLbtB
 Xl8hhkTa8YTqH+gjdM66eeSvRj8nG6i19OBOQ6lM41bRnPHVEUjzQk90nGyCeInCi+mF
 dx4tKIg4MK6IFMVnHN+JyuzZOZtzCwhi7oR4UiIv7yPQD1/UITpgkmFnHCwsO9nGO4NE
 4/uZJYEi/DyURgZPxhnJyekVbkKuZ4ZFn5RDKN/o+Ralmf1fpMNKnLDj4kFkwHhox3LQ
 sSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711569721; x=1712174521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=im7zmQeDt7pZodE0p+VySjAa7DBv0KaW+gKoLu+LS/g=;
 b=SEU4U+Ghy5VXRTUPzEM3Q7kKCJl0eHULSgS+9mZ/DgV+qSKAKnrE8K/+8tL0Xd7czF
 O+CIKwrM7yUCqrhFfLRQzhDzgN/cXPNq+6nWWqRblODWbMT1jBve1uR0pPnguWFktfBL
 mHE9254EpZ2Wra5THuelX85UweoXza7HDLm6U2QtNQeIJAAcIxrZ4trRl2jG1D5sN+qh
 6I+tXjBY4G9V3caB3vXTrCiiuOBIh9s9rnRlsPG0Nsh2DwDBcZkbRLABrriEtwrH6pu3
 GpKRBgGuIpT3FOYb87bZEUi0tUXrWn46WwAwloW1F/2GDTJguW97pyGhOekZN5lKhpUK
 0m9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC9djfeER6y2WNNZpcJCHKiOaMND5/EwKPLz9rUCEUbVPy37leNyHIqE8HwyctoJ4Dv2ckUMxpi5GgAFItAkD3yi/0C/OQcnUX4Q2kMA==
X-Gm-Message-State: AOJu0YxnnPpYNiVlBC0sFzfpExtpo+uDaUfous5PB4P0cp74QxNeKbN2
 ySpChVvYM5MeAqVz+dKDKgeB5oXNnV9zBbu8wmIihJOMT2cc5/6h3bMs1CiDMs4=
X-Google-Smtp-Source: AGHT+IF+ykWlXq/2p9fLdxe5qiT+fQJVLXU8yD1cTqgZWIiJ9yzpflW/8jhLl1LVX7Yz7XdGYJsgng==
X-Received: by 2002:a17:903:28e:b0:1e0:d6ce:7e16 with SMTP id
 j14-20020a170903028e00b001e0d6ce7e16mr805365plr.15.1711569721663; 
 Wed, 27 Mar 2024 13:02:01 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:02:01 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 02/14] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Mar 2024 13:00:33 -0700
Message-ID: <20240327200157.1097089-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Mar 2024 13:32:06 +0000
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
2.43.1


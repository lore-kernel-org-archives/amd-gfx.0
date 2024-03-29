Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2D4CD11DD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6A41120B9;
	Fri, 29 Mar 2024 11:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="P93OUhhj";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE3D112331
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:25:49 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-6e7425a6714so1502160b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697088; x=1712301888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaG/5r11zMVVbJK9XMgdhlmzZC0nXZGHxxAlEP5YrDw=;
 b=P93OUhhjM1V6PPlyhK+QbpY50BHPcf55psAyH4JW77Igl2K8/qzDR79tdJpQ6hqhZf
 7+WL/0T6bLaXEE2oayqReEYFvijt5uOQ1gPu85z1P/m2gQjK7e8fIQE8h/lImnT+ejR6
 TojG3m0jyWqlhEItiZSKqEKJIxffppK7fNkxbrMLX50rJBuJXh107xSHVSCZrLefPmpH
 6L8QbUYJzlqcnBEc8IzP9IJn9nYJU58+TMaPF5NaHiuLt2nmFOQUER/YkIv9DsvCxaKI
 7YjZ3pHYOMvQZyOhr/ycEOLIyAlOoisv2A3KgJfIhE7rgZ3ei4jkMbiDGySDfmSdqSnI
 AIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697088; x=1712301888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaG/5r11zMVVbJK9XMgdhlmzZC0nXZGHxxAlEP5YrDw=;
 b=StEJGmGuo18qd/n5HA46ut6IHpuAXO3z5/YoSp3gyA18Olgc+Fcmvx+jbNGm5WcNbI
 4HA+Vy6A+JMYgqCbL0ywLngK7XjkLESgqV7f8gqFcp+6jFBcuxOvC0Zn3F2i3gYP5kd6
 z1/Pt2xXfGRqvDy5PQTKyva1wgjPjP+qiWC/5wQgtaX4zDy/6Q84kjltCSyill+6Nw6e
 iiCDzzPevsoMy7bN37pqvpnFbWJBXtL7GGYrGGZY9WjtB+snATj5MKXFo26YdU2XcSc6
 VWOtntZ27n7rkWxcivonfSbfj3yQtoluuYNsDu0gvE8cxb3xXE7+349YbximaEbsqEsg
 niYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/k19zgTaFbZcfc/scu/oo4b9Vr9Qdhn2xiGhLW5zsqeBzJtlYH+yCTZELQo6p9kICBz6T3N1detfFNVvLx5tCTG8OpRtr8v0OFi5yyA==
X-Gm-Message-State: AOJu0YzpleGdXTZM5tlQpCGnwtDyvYARC1RFlXEzjyHAmjMmzkQiEPgr
 C1xInY0Wh0NWmrJsRAMhVvKpoCE8Z3gE+HQNCn+F9aTu/v7Cc3fVoBDn1mTCs7Q=
X-Google-Smtp-Source: AGHT+IHyYuok2TNfdiOcE/l5igRa3fLGWQKdU9IqGK1Jb+NsKkae7YWqfCeB+c37aWtPbJ/1sA02qQ==
X-Received: by 2002:a05:6a21:6d9f:b0:1a3:55d2:1489 with SMTP id
 wl31-20020a056a216d9f00b001a355d21489mr1432790pzb.7.1711697088383; 
 Fri, 29 Mar 2024 00:24:48 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:24:48 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 04/15] arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Fri, 29 Mar 2024 00:18:19 -0700
Message-ID: <20240329072441.591471-5-samuel.holland@sifive.com>
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

arm64 provides an equivalent to the common kernel-mode FPU API, but in a
different header and using different function names. Add a wrapper
header, and export CFLAGS adjustments as found in lib/raid6/Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Remove file name from header comment

 arch/arm64/Kconfig           |  1 +
 arch/arm64/Makefile          |  9 ++++++++-
 arch/arm64/include/asm/fpu.h | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/fpu.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..67f0d3b5b7df 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -30,6 +30,7 @@ config ARM64
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 0e075d3c546b..3e863e5b0169 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -36,7 +36,14 @@ ifeq ($(CONFIG_BROKEN_GAS_INST),y)
 $(warning Detected assembler with broken .inst; disassembly will be unreliable)
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only	\
+# The GCC option -ffreestanding is required in order to compile code containing
+# ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
+CC_FLAGS_FPU	:= -ffreestanding
+# Enable <arm_neon.h>
+CC_FLAGS_FPU	+= -isystem $(shell $(CC) -print-file-name=include)
+CC_FLAGS_NO_FPU	:= -mgeneral-regs-only
+
+KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
 		   $(compat_vdso) $(cc_has_k_constraint)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
diff --git a/arch/arm64/include/asm/fpu.h b/arch/arm64/include/asm/fpu.h
new file mode 100644
index 000000000000..2ae50bdce59b
--- /dev/null
+++ b/arch/arm64/include/asm/fpu.h
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


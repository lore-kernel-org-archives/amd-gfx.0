Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FDCC46CC5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46AC10EA26;
	Fri,  8 Dec 2023 08:37:03 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC4210E9D6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 05:55:14 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d0bcc0c313so12829685ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 21:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702014914; x=1702619714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYvZSY93/xrjeeL5ETwAXbtukKNXxCCQ4+T0woOWU40=;
 b=koYDK+gW+N+zK25Yyi+4ZSot3eWYBrjybYqxBMwqc/8uwaTicpbMW1qUc3ocDFVT0/
 PkTUkostpMDngYJkXYZNkjJDe5PxoarHJQlW7NzKW9rn/4E2J2Gfr6MSr38+SiUK504v
 RFBahBmQcPj3BsckjDAIAR1LnNPxwYhmNs6qEX3L82U2eXkScIMwXNI26UqjdVLL9A8/
 XTbDtYpfS3msT7ILXGGMW1NsG145PLMy8uker4UjxbDEZ3iOk31TmGInhtjmlmE3/E6m
 aNnpjA5aMhyXNDpi75bXPFa4/CmomGJhtKPBJn4p+xSBCPaxpTc6b6d05xYLe2Yza4Py
 06Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702014914; x=1702619714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYvZSY93/xrjeeL5ETwAXbtukKNXxCCQ4+T0woOWU40=;
 b=wsKsXW6TPydLYdNyeO1UZnmspumNb0r8Mu2nAH7Sd4FCMGtHvdXIgO/m3O53+ZPqSr
 RNi9ZrTPjv01rEP/qOH9B+/QXScjFzPhLjcB30rIjD/LpnFeQZ4leDpjYeZVPTECdek7
 lY55Y67vmq6ccfJHX52+KKBm7rNeqxAVuBW4cxyrCAchLPd8rd8xwu/eoRCW7FspKi5r
 z0zrB9VCSCgPn6zftOrcOfxN1YRwrdoaARKdyfoHwYM+5GFGigjN3KtB0wpLvKgNH2lX
 /7fSvFy05taayHm7z5izouijrqnsSNy+aEZbZYzPx9l5U/uvSTR9p213d6pl+JvIKYQR
 RDcQ==
X-Gm-Message-State: AOJu0Yxb1Hmt1QSFVpumoWIQU78vwDNjzWq7J5kKbYHtr3Nql224Z/0w
 5dl9Dp+Q34A755U/F1ivw9I7BZ7Gwz9/MjlF110=
X-Google-Smtp-Source: AGHT+IEX6fsur3fhby/cWKLu/7STh1pjdXEZxMWOcghK1shSxSRPNcFQAcmIt0ejFquarrBp9mMVPA==
X-Received: by 2002:a17:902:e541:b0:1d0:a084:affd with SMTP id
 n1-20020a170902e54100b001d0a084affdmr3001010plf.73.1702014913936; 
 Thu, 07 Dec 2023 21:55:13 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 21:55:13 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 09/12] riscv: Add support for kernel-mode FPU
Date: Thu,  7 Dec 2023 21:54:39 -0800
Message-ID: <20231208055501.2916202-10-samuel.holland@sifive.com>
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

This is motivated by the amdgpu DRM driver, which needs floating-point
code to support recent hardware. That code is not performance-critical,
so only provide a minimal non-preemptible implementation for now.

Use a similar trick as ARM to force placing floating-point code in a
separate translation unit, so it is not possible for compiler-generated
floating-point code to appear outside kernel_fpu_{begin,end}().

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/Makefile                 |  3 +++
 arch/riscv/include/asm/fpu.h        | 26 ++++++++++++++++++++++++++
 arch/riscv/kernel/Makefile          |  1 +
 arch/riscv/kernel/kernel_mode_fpu.c | 28 ++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+)
 create mode 100644 arch/riscv/include/asm/fpu.h
 create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..cf0967928e6d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -27,6 +27,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if FPU
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index a74be78678eb..2e719c369210 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -81,6 +81,9 @@ KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64i
 
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
+# For C code built with floating-point support, exclude V but keep F and D.
+CC_FLAGS_FPU  := -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)([^v_]*)v?/\1\2/')
+
 KBUILD_CFLAGS += -mno-save-restore
 KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
 
diff --git a/arch/riscv/include/asm/fpu.h b/arch/riscv/include/asm/fpu.h
new file mode 100644
index 000000000000..8cd027acc015
--- /dev/null
+++ b/arch/riscv/include/asm/fpu.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef _ASM_RISCV_FPU_H
+#define _ASM_RISCV_FPU_H
+
+#include <asm/switch_to.h>
+
+#define kernel_fpu_available()	has_fpu()
+
+#ifdef __riscv_f
+
+#define kernel_fpu_begin() \
+	static_assert(false, "floating-point code must use a separate translation unit")
+#define kernel_fpu_end() kernel_fpu_begin()
+
+#else
+
+void kernel_fpu_begin(void);
+void kernel_fpu_end(void);
+
+#endif
+
+#endif /* ! _ASM_RISCV_FPU_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fee22a3d1b53..662c483e338d 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
+obj-$(CONFIG_FPU)		+= kernel_mode_fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/riscv/kernel/kernel_mode_fpu.c b/arch/riscv/kernel/kernel_mode_fpu.c
new file mode 100644
index 000000000000..9b2024cc056b
--- /dev/null
+++ b/arch/riscv/kernel/kernel_mode_fpu.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#include <linux/export.h>
+#include <linux/preempt.h>
+
+#include <asm/csr.h>
+#include <asm/fpu.h>
+#include <asm/processor.h>
+#include <asm/switch_to.h>
+
+void kernel_fpu_begin(void)
+{
+	preempt_disable();
+	fstate_save(current, task_pt_regs(current));
+	csr_set(CSR_SSTATUS, SR_FS);
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+
+void kernel_fpu_end(void)
+{
+	csr_clear(CSR_SSTATUS, SR_FS);
+	fstate_restore(current, task_pt_regs(current));
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_end);
-- 
2.42.0


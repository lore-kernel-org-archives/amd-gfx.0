Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C9CD1290
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEFC811266B;
	Fri, 29 Mar 2024 11:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="hX5tL9js";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307A3112446
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:26:03 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-29de4c33441so1386554a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697103; x=1712301903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4EVp4FPE+/jeIRBNmVRsUyItk8Ntjq2i9UEb5o+3e0=;
 b=hX5tL9jsl5YDBKdfQLaOnU3lESY9wELeXYva39jWxpwavdtHgUddFsdHS/r9DkTXbl
 zj6B75CO4LJ/K4oOeHb2nRr4Eg+UQlTLGv/wM6jTV+mgyigKDyxZ2UTz1CPF2Rvfv692
 p7JhZ/in99x8i8/Pf+YaSgmeHIlTYREhouKJyZleKXXbvK5O3wlJeqfHpqFC9yZXMk2E
 +UI5M6khwlqWmCnqWiWLT5Ybla7rJSgqlkWPFhwEDCsTDswDvWH5Y2xfk6LteGT/eqVB
 7RBWNBGdLMSuxRGbh96IRtvhWsYMGsE4a6Qf0w5BP6FIwW2YZ6UKNhgO2/jhnWl35JgH
 UYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697103; x=1712301903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4EVp4FPE+/jeIRBNmVRsUyItk8Ntjq2i9UEb5o+3e0=;
 b=LEenYZu9yaMtCUAZJTEAN+jUNH0ldmYmWGruxu7S6TepZLNNEEUslQ6PPuhsrsCaCc
 wRQWCSSCq3eSPC1WwNaSeUwJqd/ttmjdE5uLChyTb7dV9gniMEDFIXREnQPKva/xPJho
 plTotjjqf/oExQwlhHXHF4VKGXCljBhpsseqACjcXunFHepvSCQYflGyzElEQ2jma0Dv
 74F9lNgJxN2Ed/USVSgdBV+ZLkd30yhn3jYybeNMAOZLS0QLLHLS0FZUBu0VlPO3UGBu
 b7JkRzGahEDKLBwQ3a4xqkzOeUA6K9q0Pgk9WQnXhHnvdvQEGOyIN3wX2RwzVcOF34BA
 f+2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzyYmnk9bPSJlwPsUS1FDG8oIEPhQh568jO3IPrBLoD1JHi26NkCH6EMedf5iUUbTBCZM0M225hj2AP46LAQvq3dVX52EuFpaMIcJE2A==
X-Gm-Message-State: AOJu0YxlslikQUhMUyCDTfjYUkZejc6aJookAFuPtbh8XihNgO+oQe5o
 RWCFEqsEgTA81lWxIcblP0+yyknodmtgrBRSJ0R4AHXeQNcgkV/Vqqcwq2sHuGU=
X-Google-Smtp-Source: AGHT+IHObpmsfqDnVzwffSCR0G9zA2Nzm55W89HV7TW/i69TFVB/o13/9rds5tWd/Fn8feEYN1IDow==
X-Received: by 2002:a17:90a:f2ce:b0:29f:cbd8:ea11 with SMTP id
 gt14-20020a17090af2ce00b0029fcbd8ea11mr1691675pjb.15.1711697102774; 
 Fri, 29 Mar 2024 00:25:02 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:25:02 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v4 11/15] riscv: Add support for kernel-mode FPU
Date: Fri, 29 Mar 2024 00:18:26 -0700
Message-ID: <20240329072441.591471-12-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Mar 2024 11:32:13 +0000
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

This is motivated by the amdgpu DRM driver, which needs floating-point
code to support recent hardware. That code is not performance-critical,
so only provide a minimal non-preemptible implementation for now.

Support is limited to riscv64 because riscv32 requires runtime (libgcc)
assistance to convert between doubles and 64-bit integers.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v3)

Changes in v3:
 - Limit riscv ARCH_HAS_KERNEL_FPU_SUPPORT to 64BIT

Changes in v2:
 - Remove RISC-V architecture-specific preprocessor check

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/Makefile                 |  3 +++
 arch/riscv/include/asm/fpu.h        | 16 ++++++++++++++++
 arch/riscv/kernel/Makefile          |  1 +
 arch/riscv/kernel/kernel_mode_fpu.c | 28 ++++++++++++++++++++++++++++
 5 files changed, 49 insertions(+)
 create mode 100644 arch/riscv/include/asm/fpu.h
 create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..3bcd0d250810 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -27,6 +27,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if 64BIT && FPU
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MMIOWB
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 252d63942f34..76ff4033c854 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -84,6 +84,9 @@ KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64i
 
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
+# For C code built with floating-point support, exclude V but keep F and D.
+CC_FLAGS_FPU  := -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)([^v_]*)v?/\1\2/')
+
 KBUILD_CFLAGS += -mno-save-restore
 KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
 
diff --git a/arch/riscv/include/asm/fpu.h b/arch/riscv/include/asm/fpu.h
new file mode 100644
index 000000000000..91c04c244e12
--- /dev/null
+++ b/arch/riscv/include/asm/fpu.h
@@ -0,0 +1,16 @@
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
+void kernel_fpu_begin(void);
+void kernel_fpu_end(void);
+
+#endif /* ! _ASM_RISCV_FPU_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 81d94a8ee10f..5b243d46f4b1 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
 obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
 
 obj-$(CONFIG_FPU)		+= fpu.o
+obj-$(CONFIG_FPU)		+= kernel_mode_fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
 obj-$(CONFIG_SMP)		+= smpboot.o
diff --git a/arch/riscv/kernel/kernel_mode_fpu.c b/arch/riscv/kernel/kernel_mode_fpu.c
new file mode 100644
index 000000000000..0ac8348876c4
--- /dev/null
+++ b/arch/riscv/kernel/kernel_mode_fpu.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
2.44.0


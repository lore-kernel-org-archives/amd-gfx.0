Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14249C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 10:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841F010E1A7;
	Thu, 28 Dec 2023 10:02:16 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9061410E02D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 01:42:25 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6da16ec9be4so289624b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 17:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1703727745; x=1704332545; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xuiZ+dA63qa6KuTRM/9EMSF12UiDXQURMhZ59hCd4g8=;
 b=dNbnBRiYnpE5I4pGw5jTWa0Gy/X4sN3l+A5jS7dA845nGGNQ/7sdgoGlXoo3rqVUpk
 zun60dSoVnGSzQET4N424kDI5R26vKtDoSPCMEmAOs/LzYPmGx1rkd3j3uiciIu+rU3L
 KK2xERrJMWNkpUfM3d1bn+8yq1mgg4suhq0/fTATSBRuSozIPp97ikApzqJBN6gfliwr
 yYyR8nsd7EBnoEwPs13zgNQMlJjFI8iDOb4M84dOmDiwQVUZ4FU3gb3+F5BZJczsSLmj
 6oc0o0O01iSrskFKpGuQEVVfeoJWV+WhAYMmWSrT80FWzxbB19KlpdKOAvpbu2AxHIdJ
 cPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703727745; x=1704332545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xuiZ+dA63qa6KuTRM/9EMSF12UiDXQURMhZ59hCd4g8=;
 b=CgfxO2uYEvU3RI4KjLZqr8Vcrd62yEv+YGrdEc8Q0UUh/5Dv4fmG1vi/fkXW0FXr1y
 EWvCICxJa0/LTNcfthoAi8jdjJkm1bmxdpHxBkcVHGV8htaj9LPMory/LI0UJrBrnQFz
 6XN10RaXNmEWxuPWJnH5q6NJXodwMnOW5rOmY/9oIlZr4xd90fkTQ1G2uHRo2GX6TMmL
 UtPJlIae87sKrSdTR+41kwRhCZ6A39ZQfJpVVs7g+N58uijrCDsLDm2p/BUoWMCnrDuy
 yA5BefKx/4x8CfwQhQzh91+DQvwYFzr8O5o1TeaBkMk1TTJOc1soym7kfRomKH9YRvMv
 8IJA==
X-Gm-Message-State: AOJu0Yxq+wtJm9vN1dbN9lqWv4a7MmKkEVLjUKer2bf400BPEH4Qx/BV
 a/+Crs+ONM1g/ubsfaVuIeUAxMNApl87Ig==
X-Google-Smtp-Source: AGHT+IEILlR72JmnZxJTq7QER4Rq98IUb8qZ6aLblKynPh8gjQmZYjrM9YnZu6dduDjff4jpI/ud3w==
X-Received: by 2002:aa7:9142:0:b0:6d9:cbb1:7818 with SMTP id
 2-20020aa79142000000b006d9cbb17818mr4021989pfi.20.1703727745150; 
 Wed, 27 Dec 2023 17:42:25 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 17:42:24 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 02/14] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Dec 2023 17:41:52 -0800
Message-ID: <20231228014220.3562640-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231228014220.3562640-1-samuel.holland@sifive.com>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Dec 2023 10:02:14 +0000
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
Cc: linux-arch@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 Samuel Holland <samuel.holland@sifive.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ARM provides an equivalent to the common kernel-mode FPU API, but in a
different header and using different function names. Add a wrapper
header, and export CFLAGS adjustments as found in lib/raid6/Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Remove file name from header comment

 arch/arm/Kconfig           |  1 +
 arch/arm/Makefile          |  7 +++++++
 arch/arm/include/asm/fpu.h | 15 +++++++++++++++
 3 files changed, 23 insertions(+)
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
2.42.0


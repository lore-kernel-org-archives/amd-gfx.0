Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91601CD128A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A19D112673;
	Fri, 29 Mar 2024 11:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="m4LJb7U0";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E5C112443
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:26:01 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-29de4c33441so1386544a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697101; x=1712301901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZUya0v8Oh5iLzX7Kw5hO2ocqVWj9tNi/iu8yR8eYow=;
 b=m4LJb7U0Dt8yBg6dZjKbS3X3eRj9cu0l/Xutn7df2y9yGMyuAWrpcOcdeUpOLA+iin
 VC+SergH+zQhSg2PiU5HDxVRskjh8U8vZrAhrppsKuKZZ3yOYgU91AgxIprZ8LcCkDlQ
 +X53cYlTQTsRgl7bVxS2p0VrC+fK9NopadNAbiZxaWGvVdb9P6ZgYFr/eW+023ClHwpA
 9pnBo6ehZD9EIJ+wMtXEtTyx1tnbzlPEhkiht4eMXBzr/VJwI0ECrQdeoc5xjSHMcStb
 JTzlW21W4u70Wid5tSr6AZMp+rjJh/qUcXJL3cU+8gGDOZyD0/Nq5DEfZRwjSM5+jPzR
 gAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697101; x=1712301901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ZUya0v8Oh5iLzX7Kw5hO2ocqVWj9tNi/iu8yR8eYow=;
 b=JH0fNp3naulOLBs35A7nlHfzDhd3oybd7g+rSzM1Y+vKvEiBq3jGZ8uf4Bwg/FMMkq
 LJqdeMYH4YmMMjmYaRLaXSn1ZS5i+vp1fhDSgg/tTXt7mpvPh9atDJi5OBbKMSDFYUDs
 AmCrk2iVl7IJvXG0dSQcV3d8QHYyRUUpCj6wbmLuV7rjXhCYOfzLrVkDxmrHbxhNmt8n
 sS7g+Ir0LPskoONtQK0o1eMcFZhA3UFvTabdAfLOWRG7POih06kqFyXisSOHV8QEwXgr
 Nhem67b/LKULuW9Ggt1bnyuktuQGCq6FHZ0S/Pp5ZQsP9CiaZlXeD+9bwh747VjnHokY
 drMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUawibtV9zurtUJ40+UGa1+JyHF35f5/axCAy2OZ8fhJ4MYX/+IpGnE/oqSkviW43/1VjIHePTDZ29b17vfYKMitK5CjIDv15bRjSpmhQ==
X-Gm-Message-State: AOJu0YxXwXZbEYqNOZbaiNth+i+2JYK65zw99k8xiMmnwr6Cawx290X0
 uDuGWmZRxJWmZesBx9Use2zh55ekpKtu0cGgv3RjrKnpDs2pweTWRUGnMZdjwuM=
X-Google-Smtp-Source: AGHT+IERKMtTUUrMNrNdpmOZyYX6MKtFB7fSH53v9LodH/8MB2comF4l1LxXs3fRZJNBleQgeI68Nw==
X-Received: by 2002:a17:90a:b008:b0:2a0:5339:7751 with SMTP id
 x8-20020a17090ab00800b002a053397751mr1529473pjq.37.1711697101571; 
 Fri, 29 Mar 2024 00:25:01 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:25:01 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 10/15] x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Fri, 29 Mar 2024 00:18:25 -0700
Message-ID: <20240329072441.591471-11-samuel.holland@sifive.com>
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

x86 already provides kernel_fpu_begin() and kernel_fpu_end(), but in a
different header. Add a wrapper header, and export the CFLAGS
adjustments as found in lib/Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/x86/Kconfig           |  1 +
 arch/x86/Makefile          | 20 ++++++++++++++++++++
 arch/x86/include/asm/fpu.h | 13 +++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/x86/include/asm/fpu.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39886bab943a..7c9d032ee675 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -83,6 +83,7 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_KERNEL_FPU_SUPPORT
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 662d9d4033e6..5a5f5999c505 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -74,6 +74,26 @@ KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
 KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
 
+#
+# CFLAGS for compiling floating point code inside the kernel.
+#
+CC_FLAGS_FPU := -msse -msse2
+ifdef CONFIG_CC_IS_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
+# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
+#
+# The "-msse" in the first argument is there so that the
+# -mpreferred-stack-boundary=3 build error:
+#
+#  -mpreferred-stack-boundary=3 is not between 4 and 12
+#
+# can be triggered. Otherwise gcc doesn't complain.
+CC_FLAGS_FPU += -mhard-float
+CC_FLAGS_FPU += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
+endif
+
 ifeq ($(CONFIG_X86_KERNEL_IBT),y)
 #
 # Kernel IBT has S_CET.NOTRACK_EN=0, as such the compilers must not generate
diff --git a/arch/x86/include/asm/fpu.h b/arch/x86/include/asm/fpu.h
new file mode 100644
index 000000000000..b2743fe19339
--- /dev/null
+++ b/arch/x86/include/asm/fpu.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef _ASM_X86_FPU_H
+#define _ASM_X86_FPU_H
+
+#include <asm/fpu/api.h>
+
+#define kernel_fpu_available()	true
+
+#endif /* ! _ASM_X86_FPU_H */
-- 
2.44.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DC1CD11DD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624B2112671;
	Fri, 29 Mar 2024 11:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="h+abZLU4";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C6C112446
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:26:08 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2a0782f0da5so2028217a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697108; x=1712301908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wd7UwvCa9oMHOiIEhQpk6/wRs60SiO2oLPgpnvXy/o4=;
 b=h+abZLU4Xn2gGDQRifX43dEixYhpgCt/Or2OIY9Cy3q+jSzqqn337BlxybJ0s2DQ8J
 2pIONeucTPhHtOP8DmwH/u1hGX2LL5ow9/sp3PzkwzZlsr0s9aZecXMgeBtgLbkoR5iB
 U0L1bglHzcLfrMjgRZ0//W4EK7GR0xVne6PjKZOSHaCig+tZjG+qP/0AjO5ji0MVTW1r
 e/9FO6WtbDCK3Lh0N3pqPpYu3Og/yP0FzlpGOZAG45lj2gO429La6CLa+93xTf6mvfMN
 dqSrmaMLtqlBlt1yUIbUZn577tNNO+ay5EdiISV7ibMuYzFAhOgYMNRZj5q8Lv7yLQyU
 JyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697108; x=1712301908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wd7UwvCa9oMHOiIEhQpk6/wRs60SiO2oLPgpnvXy/o4=;
 b=ClIY25YVQrZ+Mxdcvss+mNI9kd2p8H4pCNI+4sYUBUZ51c28T8bBM0Lup6GrNZBy6W
 CGREa9Vha+9fjgxD6EX5en9+tdoZoKMuer/IbBJzSu66AcaeETdVQqoA1BwTtunpoQm2
 13+zhbaB9lwe969OG7NdpdqybShxhPlzIKUFCDQpFKY/oeiJpPz/N6M4Oc4xRwhA71XN
 ez41TdHxKpRZQWIKZrm2AoHtm1pDcFC+OjxcZIq/MzfObR0cAPxbzYkNkE1E0nqQgk/w
 hkWqWyxL+nvNAZq0FeMeBAPrkxIcEuW+8491fZ9dknNl7D/OqAXj0mFmAgE/xHqZiiA1
 I48w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWndMI1hKJ/j5b89uotPsR173uZntpp7rXUCrsuLrVDpDA7k3XTE7v0qk27zxYxXf3b3naOnjQie8SCfoD0CKZ8lblAdTu+9jAkaE7k5A==
X-Gm-Message-State: AOJu0Yxl7bxQMRpMO9KvsaNpD/zxSCRTzrnbLLJZw84Lzluq0PRLluYu
 8PMe1lsIq96Y+Sc2xMsBYC50qLzL9TSTnIUiuuWLgtfF2A7gTRwTgKSXhXf4JqE=
X-Google-Smtp-Source: AGHT+IHxypVhChIzRiQ/e47hMPrNYQnLhNujXyM1QCssN6f6ZMhSHIBGzyaKpY86BExy9FwELnwgHw==
X-Received: by 2002:a17:90b:1c06:b0:29d:f52c:5d40 with SMTP id
 oc6-20020a17090b1c0600b0029df52c5d40mr2496570pjb.15.1711697107768; 
 Fri, 29 Mar 2024 00:25:07 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:25:07 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 15/15] selftests/fpu: Allow building on other architectures
Date: Fri, 29 Mar 2024 00:18:30 -0700
Message-ID: <20240329072441.591471-16-samuel.holland@sifive.com>
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

Now that ARCH_HAS_KERNEL_FPU_SUPPORT provides a common way to compile
and run floating-point code, this test is no longer x86-specific.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 lib/Kconfig.debug   |  2 +-
 lib/Makefile        | 25 ++-----------------------
 lib/test_fpu_glue.c |  5 ++++-
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c63a5fbf1f1c..f93e778e0405 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2890,7 +2890,7 @@ config TEST_FREE_PAGES
 
 config TEST_FPU
 	tristate "Test floating point operations in kernel space"
-	depends on X86 && !KCOV_INSTRUMENT_ALL
+	depends on ARCH_HAS_KERNEL_FPU_SUPPORT && !KCOV_INSTRUMENT_ALL
 	help
 	  Enable this option to add /sys/kernel/debug/selftest_helpers/test_fpu
 	  which will trigger a sequence of floating point operations. This is used
diff --git a/lib/Makefile b/lib/Makefile
index fcb35bf50979..e44ad11f77b5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -110,31 +110,10 @@ CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
 obj-$(CONFIG_TEST_OBJPOOL) += test_objpool.o
 
-#
-# CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
-# off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
-# get appended last to CFLAGS and thus override those previous compiler options.
-#
-FPU_CFLAGS := -msse -msse2
-ifdef CONFIG_CC_IS_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
-#
-# The "-msse" in the first argument is there so that the
-# -mpreferred-stack-boundary=3 build error:
-#
-#  -mpreferred-stack-boundary=3 is not between 4 and 12
-#
-# can be triggered. Otherwise gcc doesn't complain.
-FPU_CFLAGS += -mhard-float
-FPU_CFLAGS += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
-endif
-
 obj-$(CONFIG_TEST_FPU) += test_fpu.o
 test_fpu-y := test_fpu_glue.o test_fpu_impl.o
-CFLAGS_test_fpu_impl.o += $(FPU_CFLAGS)
+CFLAGS_test_fpu_impl.o += $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_test_fpu_impl.o += $(CC_FLAGS_NO_FPU)
 
 # Some KUnit files (hooks.o) need to be built-in even when KUnit is a module,
 # so we can't just use obj-$(CONFIG_KUNIT).
diff --git a/lib/test_fpu_glue.c b/lib/test_fpu_glue.c
index 85963d7be826..eef282a2715f 100644
--- a/lib/test_fpu_glue.c
+++ b/lib/test_fpu_glue.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/debugfs.h>
-#include <asm/fpu/api.h>
+#include <linux/fpu.h>
 
 #include "test_fpu.h"
 
@@ -38,6 +38,9 @@ static struct dentry *selftest_dir;
 
 static int __init test_fpu_init(void)
 {
+	if (!kernel_fpu_available())
+		return -EINVAL;
+
 	selftest_dir = debugfs_create_dir("selftest_helpers", NULL);
 	if (!selftest_dir)
 		return -ENOMEM;
-- 
2.44.0


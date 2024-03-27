Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2E8C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 13:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08FC11202F;
	Thu, 28 Mar 2024 13:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="Y5C5zTMB";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE5B10FFA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 20:02:18 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1e00d1e13a2so1947585ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711569738; x=1712174538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KPYCb9S3Soscoa7gVsLkBiv/vc0d18dY2Lykf0pkTk=;
 b=Y5C5zTMBWWRLTO+wS8EAmb5gH9ZqQus0EcpEXDxObSii481EkhalCy3B0ee/czzFTD
 F/8fBYCqP6Tmjw6KbkODlO7YdgpkAjT2rSvzze4mspRMtGtEPAn2BC0jctNfZAkKHK8Y
 aejEJJg0hX6Se5xKLN3FbJeXxVsckquceOi7DQhTTDT4FPPDoB7rQp3m/ntEaE6W9rJ0
 lhoUkSQNtkggrAvhVpni6mkjKtlqFD7W5XNIyIhASp/PXcAAXLyU5DFbf8OU/+c9FLHy
 QZ8bJzC8Exe6VbHkE9O2zMJ4XRlY0WDcrrLRj2fUG7jreAmxC6lMXRCfKq+Jh0qtonLK
 a8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711569738; x=1712174538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KPYCb9S3Soscoa7gVsLkBiv/vc0d18dY2Lykf0pkTk=;
 b=Bc3cAzqxHpxk+lYMIRXZYk9BNZyquBfao7778oG5Jz0F1WLqhxetBkO4Lh2ygiBCip
 iSd4UGqyivdHDaHdPo2Kwl27SnyQ+SrkO/z92dU4iEn/OFLGIDn752zX4fSY4tAmNX++
 JmsaUqx7Z2j44D0BtpdeWhi+WAKXPf2pWtCXKaHL7VShVd5IYTcc3lyOhtrsrOTVbUPt
 dkS1sOjJvMCunOAQKcWNVu5OahXyoRw1WXv9f1vepygUn7hp7I9yhpAgWs5Dw9ACbyU0
 VzrEJOZvj4KBtWxgsJlJUdzyI2IzBHPp9OrqrMRv//xlesi3OBSmFqW4V4JYaV4hSmth
 iPng==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9DQ90pG3t1G4IxDiePlfsuUyBk4l151eCyfG33p8jtphRy4zjOTeGUub99BHkm3tR8Pmlz43xmO4KFEngWUKqczpAeLEYfv9nonARGw==
X-Gm-Message-State: AOJu0YzXJ1rldTKPqK/jA7YnM6yCKnN2JSPvuelAsDaxgxLtpG1ihO1q
 tFIvG/WD8qlXQ1RsWtSGrVqloTegvm4oOwY/DcwnnfiYsiCQVzd1Sznm8FhLuKQ=
X-Google-Smtp-Source: AGHT+IHiVrJt14UyveizhwLAq9XPpEU6ZyZvDdQzDZe0rjNysh7dZh6CYDZhY9eiiH2RA2j+uTxBcQ==
X-Received: by 2002:a17:902:ec8b:b0:1e0:1f1d:bd38 with SMTP id
 x11-20020a170902ec8b00b001e01f1dbd38mr622795plg.7.1711569737898; 
 Wed, 27 Mar 2024 13:02:17 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:02:17 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 14/14] selftests/fpu: Allow building on other architectures
Date: Wed, 27 Mar 2024 13:00:45 -0700
Message-ID: <20240327200157.1097089-15-samuel.holland@sifive.com>
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
2.43.1


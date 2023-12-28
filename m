Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6478C47073
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 10:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC53910E258;
	Thu, 28 Dec 2023 10:02:16 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5845110E1D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 01:42:41 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3bbbdf0b859so1421644b6e.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 17:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1703727760; x=1704332560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2e+fg9SOqP34XnXL5jU4pEY4/pq3fOIOqFLUTdc21ng=;
 b=YB0dzT+w5R+nLgwEFPRhYGCUCARmyF2qDDQcUHz9vcfAcbxJdgwzAxhFv+FH6llRRS
 nEZ7AJ1mnUOFwDHa1zCvpgDhRSU4vjf0h1vbV5xCHVmnA9/Ofh947tXSEpt3bPXejP++
 hQKNQ+Z65h+8g0Y+y6olPS0Dr2MTSugbbezSjr/XUbTT2x2FFMQz/7HUcvqAAXdvfWvn
 eqv7VpYKgb+y9prR6g66NRkKKGKQUDSL+taUqRIN9cvHQ/83w/86oZod/7dgGGnolY0E
 HWeEpmp6Ycz1cKvsWoJ7mKCbZOGLgQ3fQkBEyzIKrRdR1+vk2feAUk9yqHjp6kGLJn+f
 siVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703727760; x=1704332560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2e+fg9SOqP34XnXL5jU4pEY4/pq3fOIOqFLUTdc21ng=;
 b=EnVZmXYeJJEIGmZNlqGkeOh3dYuOjD0kSB8HLVc0A1GQGdN2otq4RemVcQaZjMbx68
 xNJ47wkQLbcg7iQeHpt4y31WPphhxg+FnCdFejXvJ4QzElO/DxDEn07dwsXCxPEsHah/
 kyI6IHpa5z1YtL+ZwsBNp4ijCbL1wxSEum9CVLD0Ld2AVMERzAahzQgFsljoSlUR3I6K
 IplepMwO32tzuXak8Tn+z5BMq4qDTIj33+vFShtdyV6UwofywGh0krycBgf9NiaxC4um
 uiuxGQrGtXdMRMHyIVRItOlfI22j8PzI77kpuUCIVmujfK5PSFsXuQdIQHUzU1Oagjbz
 5L+Q==
X-Gm-Message-State: AOJu0YzODB3bhQFoK3D2MSE80R+h6htgCoPLdHjM+ZtB13P5q87XfpT6
 CcaYVY8flCVpBaoYfw5f/2lUL4N9MPnm4Q==
X-Google-Smtp-Source: AGHT+IFlBstkCmb/D17edCTs8sY4vteYMNaBpcxdbvjkI2D4UtEwweJgmB+5F+NfpsSlT4ktPGSvhA==
X-Received: by 2002:a05:6808:159d:b0:3bb:76ca:f143 with SMTP id
 t29-20020a056808159d00b003bb76caf143mr11199985oiw.54.1703727760626; 
 Wed, 27 Dec 2023 17:42:40 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 17:42:40 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 14/14] selftests/fpu: Allow building on other architectures
Date: Wed, 27 Dec 2023 17:42:04 -0800
Message-ID: <20231228014220.3562640-15-samuel.holland@sifive.com>
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
index 4405f81248fb..4596100eeb14 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2918,7 +2918,7 @@ config TEST_FREE_PAGES
 
 config TEST_FPU
 	tristate "Test floating point operations in kernel space"
-	depends on X86 && !KCOV_INSTRUMENT_ALL
+	depends on ARCH_HAS_KERNEL_FPU_SUPPORT && !KCOV_INSTRUMENT_ALL
 	help
 	  Enable this option to add /sys/kernel/debug/selftest_helpers/test_fpu
 	  which will trigger a sequence of floating point operations. This is used
diff --git a/lib/Makefile b/lib/Makefile
index e7cbd54944a2..b9f28558c9bd 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -109,31 +109,10 @@ CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
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
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
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
2.42.0


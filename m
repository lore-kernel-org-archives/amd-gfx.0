Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C01C47073
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 10:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CE410E26D;
	Thu, 28 Dec 2023 10:02:34 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A60F10E23D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 01:42:40 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-58e256505f7so3617347eaf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 17:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1703727759; x=1704332559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cNUGRAFHmKzY6lG9DcfUZlQ4QTwCBjkCL5t9hP4xKAE=;
 b=fuvtlYGXsmBMZneEZsD/E++1jKgV/689TBYevffXpCZqLvTI4F7HdCgmP2kYECCfEN
 KkdopmFM7YiuS/yPR3Ty1EQTdV72jSKnEfzuwsfopfK4lLzKTtgyxjVpQnm41s75yZci
 n2uPWbOKUKvjLE53AZgciWpSmZM+aGlZOWo3KUIzJ96DKchijTFjAuuNsKFA/rcATDRm
 23lsJHGhzo18OXenO8inyK3o3cOeEK5bLwYkeIuMBIetcnE3qm1udF1/Enwx8dp5kHtk
 M+2tPi/xkZHq83zTMoGbnHLgMO2VFxm3YlUpymK7GyCHOFVTH0hcCj2o2gmlCARKkSYf
 mqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703727759; x=1704332559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cNUGRAFHmKzY6lG9DcfUZlQ4QTwCBjkCL5t9hP4xKAE=;
 b=dW1V/gamcUfk2wR9gP3I5iVNf+gu+9Fez1EoHmstGO1lsF/yjUG5acMsbjTG8j2o6c
 e/NHOZkzquCC6AmhlB/2uJvR4HaFvMtc7jTx1Yix/SDzFAGdRzXJtHw5R2OMZgyrMSFW
 DKj+pkHEQGTsXuG5DaY3IbTsAcpc5tDUoprVhG9ND9PV7FvkKVdkJk24zStFxrAqOqnr
 6KeyDxTzxQ58aigZsBBxz3hZX5HrvNmXPINOPbvLUYifkoHsxobXK2G95qVFxBV5WYa0
 q3pZcT+CLYfHOJJxuTQ51OWyrmrI3/pS4k12uopVINsMGCaFQPvG0zqjAHMW1GWpJ6d3
 mBLg==
X-Gm-Message-State: AOJu0Yzvt3R6hy7uaXfOcoMpxey0anSk1M/zOMUE3M9whEIt2M4PkrlK
 F/HI3NifPSa/MFS/ghBKl3k5GQL0nYMzRA==
X-Google-Smtp-Source: AGHT+IGvfqTB3x7wwPMxp1qNsfQvBXkwAH7kyz4he4Bu1Z+L46cvb1psldcQ6vV6De8969ozhHXwqQ==
X-Received: by 2002:a05:6358:3a1b:b0:172:c06c:fce3 with SMTP id
 g27-20020a0563583a1b00b00172c06cfce3mr5190091rwe.58.1703727759326; 
 Wed, 27 Dec 2023 17:42:39 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 17:42:39 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 13/14] selftests/fpu: Move FP code to a separate
 translation unit
Date: Wed, 27 Dec 2023 17:42:03 -0800
Message-ID: <20231228014220.3562640-14-samuel.holland@sifive.com>
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

This ensures no compiler-generated floating-point code can appear
outside kernel_fpu_{begin,end}() sections, and some architectures
enforce this separation.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Declare test_fpu() in a header

 lib/Makefile                        |  3 ++-
 lib/test_fpu.h                      |  8 +++++++
 lib/{test_fpu.c => test_fpu_glue.c} | 32 +------------------------
 lib/test_fpu_impl.c                 | 37 +++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 32 deletions(-)
 create mode 100644 lib/test_fpu.h
 rename lib/{test_fpu.c => test_fpu_glue.c} (71%)
 create mode 100644 lib/test_fpu_impl.c

diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..e7cbd54944a2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -132,7 +132,8 @@ FPU_CFLAGS += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-st
 endif
 
 obj-$(CONFIG_TEST_FPU) += test_fpu.o
-CFLAGS_test_fpu.o += $(FPU_CFLAGS)
+test_fpu-y := test_fpu_glue.o test_fpu_impl.o
+CFLAGS_test_fpu_impl.o += $(FPU_CFLAGS)
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
diff --git a/lib/test_fpu.h b/lib/test_fpu.h
new file mode 100644
index 000000000000..4459807084bc
--- /dev/null
+++ b/lib/test_fpu.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _LIB_TEST_FPU_H
+#define _LIB_TEST_FPU_H
+
+int test_fpu(void);
+
+#endif
diff --git a/lib/test_fpu.c b/lib/test_fpu_glue.c
similarity index 71%
rename from lib/test_fpu.c
rename to lib/test_fpu_glue.c
index e82db19fed84..85963d7be826 100644
--- a/lib/test_fpu.c
+++ b/lib/test_fpu_glue.c
@@ -19,37 +19,7 @@
 #include <linux/debugfs.h>
 #include <asm/fpu/api.h>
 
-static int test_fpu(void)
-{
-	/*
-	 * This sequence of operations tests that rounding mode is
-	 * to nearest and that denormal numbers are supported.
-	 * Volatile variables are used to avoid compiler optimizing
-	 * the calculations away.
-	 */
-	volatile double a, b, c, d, e, f, g;
-
-	a = 4.0;
-	b = 1e-15;
-	c = 1e-310;
-
-	/* Sets precision flag */
-	d = a + b;
-
-	/* Result depends on rounding mode */
-	e = a + b / 2;
-
-	/* Denormal and very large values */
-	f = b / c;
-
-	/* Depends on denormal support */
-	g = a + c * f;
-
-	if (d > a && e > a && g > a)
-		return 0;
-	else
-		return -EINVAL;
-}
+#include "test_fpu.h"
 
 static int test_fpu_get(void *data, u64 *val)
 {
diff --git a/lib/test_fpu_impl.c b/lib/test_fpu_impl.c
new file mode 100644
index 000000000000..777894dbbe86
--- /dev/null
+++ b/lib/test_fpu_impl.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/errno.h>
+
+#include "test_fpu.h"
+
+int test_fpu(void)
+{
+	/*
+	 * This sequence of operations tests that rounding mode is
+	 * to nearest and that denormal numbers are supported.
+	 * Volatile variables are used to avoid compiler optimizing
+	 * the calculations away.
+	 */
+	volatile double a, b, c, d, e, f, g;
+
+	a = 4.0;
+	b = 1e-15;
+	c = 1e-310;
+
+	/* Sets precision flag */
+	d = a + b;
+
+	/* Result depends on rounding mode */
+	e = a + b / 2;
+
+	/* Denormal and very large values */
+	f = b / c;
+
+	/* Depends on denormal support */
+	g = a + c * f;
+
+	if (d > a && e > a && g > a)
+		return 0;
+	else
+		return -EINVAL;
+}
-- 
2.42.0


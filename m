Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E77C10DC1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D19810EA3C;
	Fri,  8 Dec 2023 08:37:12 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B9C10E9D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 05:55:16 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d04dba2781so14486905ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 21:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702014916; x=1702619716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlkhIfYEZ3lvxXxXZeJnWgi8rztsMBcyR5bRnlna3ss=;
 b=aOp/Biu1FIwDOiAZnZzh4703R9kab1rorcCaXQqV0v3BqtvuYNhmtz7KjYlEuJ9i3h
 Ye0k+3h10FnVzVduXSi/tS5O31NNRth8fRSJXZ94YtpU+283vg5aFLT+RQA2dfuGsmrt
 IVYZ+vppNO26XyWBlRSG1WNkKh58JQnq9D2rJKkX8hiw55QcTswVYFR99Nc+fFrWS3S3
 7ALqJME0MCu6E70l0q2dVZy8JpYeJOq1EFdBgS6/t2Av7L74TeuD5ZbQRnM6fX1n94CT
 LGPl0lbwtnwt7Qo5qwKiB6bmUMKi7KJVIH7cC//+Xai0k8pcbEFyqZkeW7KzH98N73Si
 +3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702014916; x=1702619716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlkhIfYEZ3lvxXxXZeJnWgi8rztsMBcyR5bRnlna3ss=;
 b=E9zlWzLfHTb1SucgLM9TbFxb6bl+A52/JodFaZbqclK/Whx5LuRn/OiWbHouy4NDcb
 OQ/0Dy82sw3alCtQmzAe8FQzHRAP39lkSlsgwV2BZVClhjpdAoWCSG+dUc/You5ZS8Eq
 ajO4iBpbvXRw1vhpnZQeacfoEQvlPuiZnUKcUZLRSfICJ44jk9GHqD1IWjnIWZELLAEe
 Aa+up/zGqYJUnm+6TNl7i56J1sIDpy/iwfSFJLmlCA6803e3Oui7IddAxxn7QrfAbcdI
 2YatYJBGWhISjT3ZQVoJFQph6imLE6nvZLZ2DWGR7zfZdXuW8/KEFPspr2ZPUKOzBcOk
 jKDw==
X-Gm-Message-State: AOJu0YxcT7plD4Q2JL5QoqYArDjiZpXz6iSUHEJZWnRyNPKhU2/Q7Vrh
 e7/894zNsxy7tEvmFbPzP6XWmQ==
X-Google-Smtp-Source: AGHT+IFq3S7FmJealx+s/zAc0NWuz2K3VM/cjjAkpGlz2K3tHlLviwkN/+BPcQyJZRioERW0JqTrBw==
X-Received: by 2002:a17:902:b60f:b0:1d0:c7e0:c82c with SMTP id
 b15-20020a170902b60f00b001d0c7e0c82cmr2930083pls.8.1702014916347; 
 Thu, 07 Dec 2023 21:55:16 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 21:55:16 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 11/12] selftests/fpu: Move FP code to a separate
 translation unit
Date: Thu,  7 Dec 2023 21:54:41 -0800
Message-ID: <20231208055501.2916202-12-samuel.holland@sifive.com>
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

This ensures no compiler-generated floating-point code can appear
outside kernel_fpu_{begin,end}() sections, and some architectures
enforce this separation.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 lib/Makefile                        |  3 ++-
 lib/{test_fpu.c => test_fpu_glue.c} | 32 +-------------------------
 lib/test_fpu_impl.c                 | 35 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 32 deletions(-)
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
 
diff --git a/lib/test_fpu.c b/lib/test_fpu_glue.c
similarity index 71%
rename from lib/test_fpu.c
rename to lib/test_fpu_glue.c
index e82db19fed84..2761b51117b0 100644
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
+int test_fpu(void);
 
 static int test_fpu_get(void *data, u64 *val)
 {
diff --git a/lib/test_fpu_impl.c b/lib/test_fpu_impl.c
new file mode 100644
index 000000000000..2ff01980bc22
--- /dev/null
+++ b/lib/test_fpu_impl.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/errno.h>
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


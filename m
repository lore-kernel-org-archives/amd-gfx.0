Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772F0C3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 10:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06EAF10E25C;
	Thu, 28 Dec 2023 10:02:34 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D05310E1B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 01:42:30 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d9af1f12d5so2545755b3a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 17:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1703727750; x=1704332550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jd6BNzjMN3b9R+N9FmyfxlTWIL2mCpzUIRSa4mv1F0=;
 b=PQ2mDChv12N+AW21l+qDyn23bSk8yLc3LMds5rxM6J9sMDg+NmCg5617EuHrEoDlgg
 Q/IzkfkBLUgYkXfgsDKyp72ij31w5L1M+VfZy476aTvPObXnvLqqH/clDInZbzAGhtAP
 3bYpgc3jUDw4yUCdiIiN0i+0ZjU9ylSoPmQRi1844lqSTrbYb2+09eTPF7cDXGlVkqNC
 ak5VmYEwBwXUmoKdpU0IqwEfc+WLm06hlULAg5+EKfpB+raHfXnt+leRM8CZ46C4YL7T
 meZB3dfhpJV6r2Miu7Fl7odqYkxFMlKUhw2k3nDeNJEMLVVnU23Rh2XcjmMKwu74FwXz
 RiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703727750; x=1704332550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jd6BNzjMN3b9R+N9FmyfxlTWIL2mCpzUIRSa4mv1F0=;
 b=o8mv6H/MaA+OjwpxIQ91n4Snmh7JEgGlRt47MPYgDTbrDfFCL3UHDYLyr4MIh25Bpx
 9A6GHRhE/DotZK93j8ewJzLMH8ttg/Ms8PyMD7BBn1Z0xDzy0AGUx6CYYRz3Gjn/rOxt
 lavuBZI54Ln+SjOGl8+cDi3OWpXDmMo0wrfbDjWZFFvBqIwdDynqoP41l2goZ5aEoZP7
 /KhPnktqq00w4HuOp4UImLrjlh2C+er/OJQCBY6wO89Y2X7EW5y2PLDxKoEa+dFuXa8g
 6pePXb9lnAKQLWjT3L4+XIOUDP4DTVBkR8+7kvH6tEEAPyzYFgmMnJmI2hQ99WLs5jML
 YdIw==
X-Gm-Message-State: AOJu0YyNmmWCNDLCyKkPjE18OV+fVnakimMZ76ccSYtgtAdAmusPMZZI
 qx3AHE9zFovZYKJbgBtqMxMbDVawxclzQw==
X-Google-Smtp-Source: AGHT+IE0nmjtDXMxXkCsxA9jA/OWEHDhYnPM1dnj251PyNU2gTBGhxX93h+FmlGsyJJp6FOxSnIuVA==
X-Received: by 2002:a05:6a00:214d:b0:6d9:f66a:b5f6 with SMTP id
 o13-20020a056a00214d00b006d9f66ab5f6mr2059083pfk.34.1703727750207; 
 Wed, 27 Dec 2023 17:42:30 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 17:42:29 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 06/14] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Dec 2023 17:41:56 -0800
Message-ID: <20231228014220.3562640-7-samuel.holland@sifive.com>
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

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 lib/raid6/Makefile | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 1c5420ff254e..309fea97efc6 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -33,25 +33,6 @@ CFLAGS_REMOVE_vpermxor8.o += -msoft-float
 endif
 endif
 
-# The GCC option -ffreestanding is required in order to compile code containing
-# ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
-ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-NEON_FLAGS := -ffreestanding
-# Enable <arm_neon.h>
-NEON_FLAGS += -isystem $(shell $(CC) -print-file-name=include)
-ifeq ($(ARCH),arm)
-NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
-endif
-CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
-ifeq ($(ARCH),arm64)
-CFLAGS_REMOVE_recov_neon_inner.o += -mgeneral-regs-only
-CFLAGS_REMOVE_neon1.o += -mgeneral-regs-only
-CFLAGS_REMOVE_neon2.o += -mgeneral-regs-only
-CFLAGS_REMOVE_neon4.o += -mgeneral-regs-only
-CFLAGS_REMOVE_neon8.o += -mgeneral-regs-only
-endif
-endif
-
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(AWK) -v N=$* -f $(srctree)/$(src)/unroll.awk < $< > $@
 
@@ -75,10 +56,14 @@ targets += vpermxor1.c vpermxor2.c vpermxor4.c vpermxor8.c
 $(obj)/vpermxor%.c: $(src)/vpermxor.uc $(src)/unroll.awk FORCE
 	$(call if_changed,unroll)
 
-CFLAGS_neon1.o += $(NEON_FLAGS)
-CFLAGS_neon2.o += $(NEON_FLAGS)
-CFLAGS_neon4.o += $(NEON_FLAGS)
-CFLAGS_neon8.o += $(NEON_FLAGS)
+CFLAGS_neon1.o += $(CC_FLAGS_FPU)
+CFLAGS_neon2.o += $(CC_FLAGS_FPU)
+CFLAGS_neon4.o += $(CC_FLAGS_FPU)
+CFLAGS_neon8.o += $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_neon1.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon2.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon4.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon8.o += $(CC_FLAGS_NO_FPU)
 targets += neon1.c neon2.c neon4.c neon8.c
 $(obj)/neon%.c: $(src)/neon.uc $(src)/unroll.awk FORCE
 	$(call if_changed,unroll)
-- 
2.42.0


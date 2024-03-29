Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040A8CD128D
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9F711266E;
	Fri, 29 Mar 2024 11:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="A23cUb1M";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50001124AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:25:53 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-5cf2d73a183so1983426a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697091; x=1712301891; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqbtCYy6rKAgoCWJo/IDkaQi4Zmy7pvo/Tw1FadjoIk=;
 b=A23cUb1Mt4EmwPA9xeN3CsHj3UxNcQgGZzlBfyjlwsjEnE+EOLRCr86XW2TtwwhoGp
 gj/7B0IRUv7G/4dT6QFg8jTbP71QJy7WtuV44rpVVEvCbXNX1atUYKIxWD3HMZ8M04bt
 rdsx/cFwhNCJkt0nVwTxWJCHXIZUukj9C0RJNX5yyUmjDo3snDeQbgqy+odUz23FdDBg
 WPhN6I7KkCNA3JOKAMJ0LNCpIEtSovsXRvCqYNbyK5wW/Y9LD/icHJJfhsQU1gHJ85I/
 zuT/1votyAj/M+gfQQdcFoK1DraFWU03aFxrFyGz7VAq+xW8rZgmL68xYPa9iEEFuVDf
 8tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697091; x=1712301891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XqbtCYy6rKAgoCWJo/IDkaQi4Zmy7pvo/Tw1FadjoIk=;
 b=FIJFXDzTBXAbu/PYmt8oNPNWedcwXnxyRprLoWi4daTL2JSQv7Hn7rbD6HOT5q0ike
 ejr127VsbRjQzb37VLrwWSILnmuLE0Nioq6xVV0e2uX5EwfE1BStN4NUdccinjU6Qrne
 c/k2ApLHcZLl3LShxRCSdubtO4eCMVOSiZNtOEqIaW59kcSgd1uKPLbw6+w2CVN7LnOM
 TQQ1xjq6imzgV/YzCzc2yOm5wcLqSocRBtYQnLzguEk+hsz5F5hg2Ldc+GVkWP1MNExb
 3Oh5PqPs6L1TSwsadsWzOtEEyV68A+NF6+9x3WR+lKtPTbA59k4r65MXmrLOAKFeVGro
 pryw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/PReXPrzqcGlwy3VGXI6W4aX5aqwhR7M6qKnQm4rwxEtF116UsLMuJ4yoeilJ6/IbqQu4UseJnhxiAAS7CoMIeE3juyYTTQ2YwqjG8g==
X-Gm-Message-State: AOJu0YzSRGzoMmO63VqSpxmSfn54TJD5SyQih+kKhLAwa49c+0pn9EEc
 L1nrSv0NJI3semZvtaivzLvo0b6dqRPMtwbyK6spBvedYUnz5f6fIwHn3kpdQYY=
X-Google-Smtp-Source: AGHT+IFpgVY+di4cvDttsjDdGENlsS7ZbuG0wU7DGKwYbCO2yCZHbkcZgR0Ijs83aSucHtPBLyzxXQ==
X-Received: by 2002:a17:90a:d588:b0:2a0:3b1d:7c5 with SMTP id
 v8-20020a17090ad58800b002a03b1d07c5mr6633406pju.3.1711697091135; 
 Fri, 29 Mar 2024 00:24:51 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:24:50 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 06/15] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Fri, 29 Mar 2024 00:18:21 -0700
Message-ID: <20240329072441.591471-7-samuel.holland@sifive.com>
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

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - Add missed CFLAGS changes for recov_neon_inner.c
   (fixes arm build failures)

 lib/raid6/Makefile | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 385a94aa0b99..0e88bfe6445b 100644
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
 
@@ -75,10 +56,16 @@ targets += vpermxor1.c vpermxor2.c vpermxor4.c vpermxor8.c
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
+CFLAGS_recov_neon_inner.o += $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_neon1.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon2.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon4.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon8.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_recov_neon_inner.o += $(CC_FLAGS_NO_FPU)
 targets += neon1.c neon2.c neon4.c neon8.c
 $(obj)/neon%.c: $(src)/neon.uc $(src)/unroll.awk FORCE
 	$(call if_changed,unroll)
-- 
2.44.0


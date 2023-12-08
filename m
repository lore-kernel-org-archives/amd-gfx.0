Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0ABC10F09
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD99110EA2D;
	Fri,  8 Dec 2023 08:37:08 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7508B10E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 05:55:09 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ce94f62806so1087043b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 21:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702014909; x=1702619709; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJ/tAo5hDwQPfRruz9afcRfXvkx00dxKddYKFVNcdvc=;
 b=iaavN1W4rj4WNA6ufNA5QtTGTONoop7bwSekMaqga5lZ3ZVQ54LoISEaLH+ozKjHT1
 Fr0GRHlDW15gx3PU7HD9GaZXEVQ1y9YTxw0++1r+znEq16DzGbZ6xgctwCL5V/5czQ3y
 M+D3qedPVEhpGQCjcSIlMPMdAHfSxnO/DFLY3VXjTiSon934ec5e/CHhhlV9VfhxkUi3
 pP8NoP5Q8VHUUKhBWlN8Hg3NV6MyNapXjNAXM2zcOr/c06FAIPnv1bcRN/HEw3cNmaoW
 BON0FSTRDwkR0aKjW6ZyTQv3DKezClEJxcfAh7FvyzKCxLrBu+Z9K0hpwaB8TfQv5aJS
 3LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702014909; x=1702619709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJ/tAo5hDwQPfRruz9afcRfXvkx00dxKddYKFVNcdvc=;
 b=RhUjFj65c4cSrwI8JM1A0UFXB08nG2hsVVwrAX7k+dmDYgzyOTbXP0RIOgWeZIohFX
 tr7s0dK9ONtNPyehnSxckpUnM0reU0c19gN96uGmgs3IBV4L2qwPbQGN9DhdNP/G8V1/
 SAVjNc+KgVNKqHINvv/yG6Zjp3zqI1drKTIXaoU+vLWWBSRSTt8NHhnbCRSNcq68qegb
 hCDE2e8uU8pduqCzNEIz7jv90CtOibgUcXs3vSHOFBLKxWnavratf2faH8olshQXMFaz
 SrC9PumjPlO3cTQTT8dAoJtFNPOVR2SQGYwhkCN+gfVliQh4hhJv1oKZc1vrKeCG8WH2
 xu3g==
X-Gm-Message-State: AOJu0YxrdWlaME4h0NQPpDWz9c7FIDH4IzT2GsigA3E1mnjRLEurQakD
 F0oaIhpByZY3CT6An8+dAgIKAQ==
X-Google-Smtp-Source: AGHT+IHgMEmtold3cNsq0/10/gSamuXTn7dqDmNr7pkUJjR3cZZJuyMG6U/Bp0CgIPL33Lkbwgh+tw==
X-Received: by 2002:a05:6a20:4282:b0:181:74fe:ba83 with SMTP id
 o2-20020a056a20428200b0018174feba83mr4264495pzj.40.1702014909013; 
 Thu, 07 Dec 2023 21:55:09 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 21:55:08 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Thu,  7 Dec 2023 21:54:35 -0800
Message-ID: <20231208055501.2916202-6-samuel.holland@sifive.com>
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

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A02ACD1290
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE94112669;
	Fri, 29 Mar 2024 11:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="CV+aZbw2";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB893112500
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:25:53 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so1224929a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697092; x=1712301892; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F18yE3QV4MW8RCzD1e25jw8k09/j20Bb+PnplrzhdA4=;
 b=CV+aZbw2TEiZUi6zrBEnWspR0X8BoLVjT4BJBrl/u7oA2UaKJ2BebjUvMh/LpJWpSz
 NKKOTlw0ZwSP0WOy6nLy4ZOgiQ/+thMjeMPGd2egkG/ly6gptfLlFP6/qKEmdkEo56c8
 m0UCnm0Y6ajZXf2/Y+6XS5AhLVtIohXUDlz9lvzVYfpaKHWOyRdMeSJwwXR2ce8Y4oaI
 vcJ4BuOvKSYGWGochMgdPGG9qMw/1+auSAP8TxTvkPi0yIpQ+91WHIkf/w0Lbiq8hfEZ
 R+f6pLzfVJo0OGL5vAxm/V10rwqXsHXGDSQxjwtGy6mde6hlSp+Sed0QCeyKwXWnVcm4
 wW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697092; x=1712301892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F18yE3QV4MW8RCzD1e25jw8k09/j20Bb+PnplrzhdA4=;
 b=drXtV5+jOt2+86ireT+2H41cTedvshHgOJuQQCHsti0BSS84QTwB5uX2V/nmW7nZyO
 18droTRsIUYzOrTZKjvuAq9B1SEnb12qHHpldME/fR/Yeufrd9b2+BgZOMDxoahQ5uNC
 Gjqj5fsPXY+ggr1+Y7kkbeTx9mXpqj3aWFtwK8G4iyqQ8wBvJxZMb8he4qIoOir/2qDY
 jtACDl7dyMU45MLgdO4GvV3l9nv54NHgjqAdFI4vZku/pkmjtzMyg1iCqKDSsGZZUwPc
 xkWNqrJ5v/2YdgAMBAnjRbGK/87LVTqEXSxgvayQFmNTyKita3U4swnvO16UUL+NKy1F
 5gNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmA2+hjB5HykORA+Nik8DIEPKQEpe5+55OGBcMyhm63W3dyI4F7qKdgFHRaol93qo7aT001GWT4cXPU/UpHJCI6nVgDB5VUEh4nDr11w==
X-Gm-Message-State: AOJu0YyK6c6WFtIysRxFh7Frn3WPZG8D9t5FhyTr6784t1K7tMGBtvKu
 k464gbl+RSdu1wzhg1aHVGdVjQHw9CdSSK1EXPi0+dny7Cud5jI01XABAd/HICs=
X-Google-Smtp-Source: AGHT+IFY/yzEzRZYFdEySbj/sKHZJd/DWAHR82okZCfCkYYQ9Rz+9YBmaRZXyDE1LpyvvN0Ey140hg==
X-Received: by 2002:a17:90a:fe85:b0:29f:ea48:25dd with SMTP id
 co5-20020a17090afe8500b0029fea4825ddmr1492025pjb.33.1711697092415; 
 Fri, 29 Mar 2024 00:24:52 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:24:52 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 WANG Xuerui <git@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v4 07/15] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Fri, 29 Mar 2024 00:18:22 -0700
Message-ID: <20240329072441.591471-8-samuel.holland@sifive.com>
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

LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
asm/fpu.h, so it only needs to add kernel_fpu_available() and export
the CFLAGS adjustments.

Acked-by: WANG Xuerui <git@xen0n.name>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v3)

Changes in v3:
 - Rebase on v6.9-rc1

 arch/loongarch/Kconfig           | 1 +
 arch/loongarch/Makefile          | 5 ++++-
 arch/loongarch/include/asm/fpu.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a5f300ec6f28..2266c6c41c38 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -18,6 +18,7 @@ config LOONGARCH
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index df6caf79537a..efb5440a43ec 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -26,6 +26,9 @@ endif
 32bit-emul		= elf32loongarch
 64bit-emul		= elf64loongarch
 
+CC_FLAGS_FPU		:= -mfpu=64
+CC_FLAGS_NO_FPU		:= -msoft-float
+
 ifdef CONFIG_UNWINDER_ORC
 orc_hash_h := arch/$(SRCARCH)/include/generated/asm/orc_hash.h
 orc_hash_sh := $(srctree)/scripts/orc_hash.sh
@@ -59,7 +62,7 @@ ld-emul			= $(64bit-emul)
 cflags-y		+= -mabi=lp64s
 endif
 
-cflags-y			+= -pipe -msoft-float
+cflags-y			+= -pipe $(CC_FLAGS_NO_FPU)
 LDFLAGS_vmlinux			+= -static -n -nostdlib
 
 # When the assembler supports explicit relocation hint, we must use it.
diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index c2d8962fda00..3177674228f8 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -21,6 +21,7 @@
 
 struct sigcontext;
 
+#define kernel_fpu_available() cpu_has_fpu
 extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
 
-- 
2.44.0


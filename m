Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8288C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04D810EA57;
	Fri,  8 Dec 2023 08:37:14 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEED310E9D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 05:55:10 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d0a5422c80so15560265ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 21:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702014910; x=1702619710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kq9/CzymS2t6cI6IAaf6StcamgWHCvrnQt5+bd0vsJ4=;
 b=VTfWNZX4yGnIJAbbllqSDmwGMDIWz9NE43OYtdx1W3RAc/t5G8d4Vy0ksYrmS3HBIr
 jcq6xnBT/xdedg4zUUiwDixae9OTtIaHBCq3iW74CRYDo/YhiJ2m07L0FzuV62U3gtYD
 tHFvXMOvTDgAfioxorhWfZ6pyENV6MlA83Ep8mTSeZNY2SxbL7UG7DcqaYi9lpHVkzLr
 clWSlVD3hFOePQ9dwjkEQhU/poKJnLJlNnSFOVdGI8m/woBANUGzAZCNQM7D3L2HpqF3
 uNF4CnxlmoBqn6SmFzjyQ3ioCresoq/aNjSiH7ti3pfv+YdyF1bGCcUlcEwinQWUf/v2
 clJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702014910; x=1702619710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kq9/CzymS2t6cI6IAaf6StcamgWHCvrnQt5+bd0vsJ4=;
 b=AIWf+GicgiPF9byv25OZGR+Aff0XwbIb2a7brRa+Q3pz/09/mU8ZkM3E3PlApOWFsB
 1V2RuB6xzMy30Wbv4IHc5acEthvAr+KNGFe+563yHepBJnENHlUl4KqMRxsPnSZlkDqu
 PfmmymrremueE8IWQR977cCWc5xZ9d2cGRCvdOUTbQkqBF0RCHchEUIyA4+ARb0XkkVo
 t16wGot1WbvTY/bEYZ4Jy7h2lstBNZhLFv6nZweYqcnSR9Q5/D3mL8BVyJc+AO9b4Szo
 RdAV78ikAht3Yog+4Cud3m2QPRW4XseBJyVlK0TiY/zu6F0BsPzF9iObStZzxBpEL21G
 NxJA==
X-Gm-Message-State: AOJu0YzAHvE6S6GjzAty5qc2FvRdnqJ4rbCRmPsZ6KWIloifM/09fUAb
 u0vlEpOFT/xtyloG/FNQVWaIFA==
X-Google-Smtp-Source: AGHT+IHV6F7Dn38rHWvZV+XaXS58Ch7TWuC4F5MVn7OmuYlLci2zlP9Fr0nUwpZzieoBTkpnbrTn6A==
X-Received: by 2002:a17:903:2290:b0:1b8:90bd:d157 with SMTP id
 b16-20020a170903229000b001b890bdd157mr4496557plh.26.1702014910345; 
 Thu, 07 Dec 2023 21:55:10 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 21:55:09 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 06/12] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Thu,  7 Dec 2023 21:54:36 -0800
Message-ID: <20231208055501.2916202-7-samuel.holland@sifive.com>
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

LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
asm/fpu.h, so it only needs to add kernel_fpu_available() and export
the CFLAGS adjustments.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/loongarch/Kconfig           | 1 +
 arch/loongarch/Makefile          | 5 ++++-
 arch/loongarch/include/asm/fpu.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ee123820a476..65d4475565b8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -15,6 +15,7 @@ config LOONGARCH
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 204b94b2e6aa..f5c4f7e921db 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -25,6 +25,9 @@ endif
 32bit-emul		= elf32loongarch
 64bit-emul		= elf64loongarch
 
+CC_FLAGS_FPU		:= -mfpu=64
+CC_FLAGS_NO_FPU		:= -msoft-float
+
 ifdef CONFIG_DYNAMIC_FTRACE
 KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 CC_FLAGS_FTRACE := -fpatchable-function-entry=2
@@ -46,7 +49,7 @@ ld-emul			= $(64bit-emul)
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
2.42.0


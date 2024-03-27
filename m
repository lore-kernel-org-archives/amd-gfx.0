Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A9CC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 13:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DAB7112431;
	Thu, 28 Mar 2024 13:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="IOYd9Vos";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E191110FFA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 20:02:08 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-1dee5ef2a7bso1955035ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711569728; x=1712174528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZE0ell9od5iMx/niXSnkXHAkP7o0Zji40W4vIuo5Ic=;
 b=IOYd9VosoM7br3UMzBIl/vo2SHHvIsLM6qkB+lSfH9o6Itl0iN2asZobTWd1B3rEX8
 grfNZYW8mOmjs2GTjc4lsWKpdRxUGSEwPm0JSs7nQ1mbyQmudm3DtijMZ2O/Lfb2cYP/
 1HpTZDCTKiALgNoT6huAEf7sTIW8+KBjx2Mb3u6Q9y1TPzaSCfC9umHBtpVlHldsbQCB
 jKMMRAS54RXpVQfNSLtL/c41oybv52JO4Cpqw6usNMczkBDq/aFWrhW6kpAGJ0qHisDJ
 oc2lRd4rYR+H2AmikMS8kc2JVJ1eWh5MCtsKvkcK4zAG15xMFyPiPTWXoGjNt8woyakx
 qoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711569728; x=1712174528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZE0ell9od5iMx/niXSnkXHAkP7o0Zji40W4vIuo5Ic=;
 b=va3irI68QBDINE6L9wg0ehNnP+COXYFk659hPZ+XGBeChT9A+d3o7fnRT5Eljt6ukl
 I9sAmPx9jmCWsWUfd0HTHz+nBb0C3ZT7F6T/u4t6IT3dPT8rMqqgAKw88lv+hMQczyrb
 Slvq3vdLiYSvcPAvKypBPOAMIOQaJsv4VbWbN5f1ORLG+W1YnUTAL+XQQyBNydEJuchW
 O8edWY+F61W5rkl5QV0JPpmEL9hczFOgZvb2WbcUP6f/vEQ+Ml/AjufSzm5VdyLZk328
 WE5neaIPA/kNK1BXa60UeaEGfbTZtHIBuKwJYZ6CQUrlXirSxVTZV+GPzD7b76RSIMGw
 AGDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv3xpux7NCgQGWdYXKicg16dQUwSLmsdGzrFwMO54ORe6MlSDkjKKr9bFoFNhYr68IcYzl3ETkujueGocLgWf+NfiOaqrlIwCRcYG5RQ==
X-Gm-Message-State: AOJu0YxrExEFvwjv6jZOLjCSZbrZdxpa39Ho/lWpIzL+MCmC1ZTfd5e+
 uzgkNdtm4gbh2/f1eaLayE1lAFRlPfDWLFmUFHSNDFKtWZR8aen0JPEINLzJnWg=
X-Google-Smtp-Source: AGHT+IGM9v2q1Bg0jHlsJFItc73WPBzqi9soPcoc57OB2ZggdclEbNRISa4ohk9keY4487ms+Vhuaw==
X-Received: by 2002:a17:902:d4d0:b0:1de:fbc2:99f0 with SMTP id
 o16-20020a170902d4d000b001defbc299f0mr957547plg.2.1711569728307; 
 Wed, 27 Mar 2024 13:02:08 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:02:07 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 WANG Xuerui <git@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v3 07/14] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Mar 2024 13:00:38 -0700
Message-ID: <20240327200157.1097089-8-samuel.holland@sifive.com>
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

LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
asm/fpu.h, so it only needs to add kernel_fpu_available() and export
the CFLAGS adjustments.

Acked-by: WANG Xuerui <git@xen0n.name>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

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
2.43.1


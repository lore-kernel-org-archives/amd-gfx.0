Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4626C4706F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 10:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E30B10E25A;
	Thu, 28 Dec 2023 10:02:34 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FABE10E1EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 01:42:32 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bbd11b2f95so106944b6e.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 17:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1703727751; x=1704332551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+RheApEuJN9kaaLRvICyPNbTjOVIvY5kEzb7DbTZjA=;
 b=NBtqvXACi9bI98qe6i7qrt7WHJ00/W0nMQm0RAw8UCw+PFQNk+jM6W+Wb+BNiplTgv
 qu9o77Bvngq5f196wWQi43jXSD1g+T0xCsLnUZNC0QTz9F6b8IbubQh7yVx3lsv6qDi5
 VEIaOuP93bDb+/ueGRe9rOSmnnCbo6VJ2rhaA8+KhG4mBAuMpWvkx4APddH2sfTEmMyP
 KZz2gBUkqPAkXZXGPIRr5gQb/UX0TskFLdNI64ep5hwCE175drVdfOaAjoTRiMrSNBlZ
 0xafckYi3wm54kkvf+O5j2HsAKKEadsIK/ldaddSIlvqlxiVfias8MM8Wlr2dSNubbZI
 DZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703727751; x=1704332551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+RheApEuJN9kaaLRvICyPNbTjOVIvY5kEzb7DbTZjA=;
 b=m/+Xzbr1JDlH+FkfkGHRDV4AL4nJy7LMnZj/X9YRI/i2YtM5OQRou2knO0MXv+xU/A
 YmDHp0+0otJKXwoUPap8EA0sz3LKo6AGbJt7f834YDdaHcivZXWMBolAD2Y3LpNreukM
 5jTqdVRuERtGA4w/JxK5UTyXhOty7wJYds5ESpTJgmI8xfLlT6Rw93RAVC0I0n/ImWts
 h7ls7EOIozv9P5s1CxgyZdE7Ke2XFfhsegkbHa1gPONsni46dkMWRgTQaJacNVd7/yV8
 EFmXY2BVVo5GG8grnxVXBBQXF2RiLEW276eIUMEXJOwXSS2P2AgxkS8uCYLRdOglbl7Z
 fhEg==
X-Gm-Message-State: AOJu0Yy/w5VkTrAzI2llrRUJYIpAnPL1p4zmn0LpcySThme2y/AOr87R
 ciI8fC43Y3i5dZXs+tFDHhL9PeU/eKphXQ==
X-Google-Smtp-Source: AGHT+IFlYg0OgNqHd1istrtt2UTcBedE87vqCIVNtp3f0Z5ptnzM2zYPRY9OCADmqV6QIO1pVX8ZnQ==
X-Received: by 2002:a05:6808:6544:b0:3bb:b063:1afe with SMTP id
 fn4-20020a056808654400b003bbb0631afemr7698441oib.113.1703727751522; 
 Wed, 27 Dec 2023 17:42:31 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 17:42:31 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 07/14] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Dec 2023 17:41:57 -0800
Message-ID: <20231228014220.3562640-8-samuel.holland@sifive.com>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 loongarch@lists.linux.dev, WANG Xuerui <git@xen0n.name>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
asm/fpu.h, so it only needs to add kernel_fpu_available() and export
the CFLAGS adjustments.

Acked-by: WANG Xuerui <git@xen0n.name>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

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
index 4ba8d67ddb09..1afe28feaba5 100644
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


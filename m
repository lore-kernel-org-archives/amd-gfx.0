Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46FAC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AAB010EA3A;
	Fri,  8 Dec 2023 08:37:20 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80B810E9CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 05:55:04 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c5f0e325a6so1235286a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 21:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702014904; x=1702619704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cT/f+zG+eBk9GDNM3PRDRS7FWs4vWVwDUJpda1v2enk=;
 b=NYGr//KATa+FPqcXCvA61mLQ5wG2M23M8siz2Tbtzh6HCWlNlIIxDRxsq1mxbpiW7y
 eNjSj/BJcDUPMqD/+2C5F5CTqXZV1kRd+1xZ+KMeOWev+KdFDAgK3cjXd8VTqw9LRUsD
 OIwFYPqUVLtBu1czYnyoEJLMeY52qflmhZPMit41/2QV1L3Wc4bqkFXhhMvuxMRd34d7
 AR0YVpOQQWalXH8owyJKey1k/FIZBUau5DOjsH8SO705D2tVaDcppO2SkoA/5Ip4lQog
 riVAMzosqFGmFQEOKiry6Q6RjCnN6lhf2Y5q0WAKk9c9MQKl/eFIEelY9m8k97e3tybE
 rcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702014904; x=1702619704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cT/f+zG+eBk9GDNM3PRDRS7FWs4vWVwDUJpda1v2enk=;
 b=Q2E+a1949HIDhRrNKrIGf92yWVJxc+ZedKLIdj3Tyw3CxSz8hyKu/YKf+87Rw8SugP
 mbCr50C+4v7flpjkafRA+WQ9xKALAgMBJM8zQYsijZrbImg91Ho52jOxwK/FTznkNpSP
 cKWkdPgcinWkzT/GwxroPxsx4wzn3Ex6wfKGeGVmnaCcXAdLVvfUppZWuLpN84OxVcZ0
 9k0dl/C70F5/2cYqWkjbpmMDQiv0IHWtkuhFwVrq/rIHXHiRv3u5XMr3THuN5TQFtUPC
 S22228M3UIT+SAdcbGUj9VKCCFA86t4ghCZEGbkRSoDD9B60q6MB9k2az2fKoWPhFI08
 xcdw==
X-Gm-Message-State: AOJu0YwKuz2YuSGMdRg1j6AVEIyRAUTpcZR2BY/uXuv51SbXEvXPrsnP
 GDWMgBZoH1PBV7BkrlGBKPZQsg==
X-Google-Smtp-Source: AGHT+IHjHZOPQupU2gBIY1LJy6ZLE2Spe4muScdMLjHj9er/qEsoCLB+Of3eLXhwYzBMH5NUihe96w==
X-Received: by 2002:a05:6a20:160a:b0:190:14d9:4797 with SMTP id
 l10-20020a056a20160a00b0019014d94797mr1355279pzj.4.1702014904099; 
 Thu, 07 Dec 2023 21:55:04 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 21:55:03 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 01/12] arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Thu,  7 Dec 2023 21:54:31 -0800
Message-ID: <20231208055501.2916202-2-samuel.holland@sifive.com>
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

Several architectures provide an API to enable the FPU and run
floating-point SIMD code in kernel space. However, the function names,
header locations, and semantics are inconsistent across architectures,
and FPU support may be gated behind other Kconfig options.

Provide a standard way for architectures to declare that kernel space
FPU support is available. Architectures selecting this option must
implement what is currently the most common API (kernel_fpu_begin() and
kernel_fpu_end(), plus a new function kernel_fpu_available()) and
provide the appropriate CFLAGS for compiling floating-point C code.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 Makefile     | 4 ++++
 arch/Kconfig | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 511b5616aa41..e65c186cf2c9 100644
--- a/Makefile
+++ b/Makefile
@@ -969,6 +969,10 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
 
+# Architectures can define flags to add/remove for floating-point support
+export CC_FLAGS_FPU
+export CC_FLAGS_NO_FPU
+
 ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
 KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index f4b210ab0612..6df834e18e9c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1478,6 +1478,15 @@ config ARCH_HAS_NONLEAF_PMD_YOUNG
 	  address translations. Page table walkers that clear the accessed bit
 	  may use this capability to reduce their search space.
 
+config ARCH_HAS_KERNEL_FPU_SUPPORT
+	bool
+	help
+	  An architecture should select this option if it supports running
+	  floating-point code in kernel space. It must export the functions
+	  kernel_fpu_available(), kernel_fpu_begin(), and kernel_fpu_end() from
+	  <asm/fpu.h>, and define CC_FLAGS_FPU and/or CC_FLAGS_NO_FPU as
+	  necessary in its Makefile.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
-- 
2.42.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B894C4706F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 10:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D61E10E0BC;
	Thu, 28 Dec 2023 10:02:15 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41FAF10E16E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 01:42:37 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so52000b3a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 17:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1703727757; x=1704332557; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3Nao5aFqcs14j7uzTeCL4obzFSkk9OE7jeAS4fIG/k=;
 b=iKr2eExmlgfos2rXPxqnMtbuWzod31sAs3st6/hxOMYf1ut1+N7lvglXJ9ogiPaJky
 Aip4L0hnZqjNsbS0yzcg0g4uhIkaJRK8lWHYv/jrrUNhwoCq/WFcbWb/f57p3Dj2uvlO
 GUSQ9hTr/We3ZOVQ2P6tpQ6894AZXMFlpbhIP6Fp5JX84K96vKZoIYHQ25PMSHQnwFWF
 KTJFHnqK87it5SgL98noeMlDJrI/gvcTNIMVbpiO5B0gcj93sqFLUVZKLdJC9PGUDxBj
 Qk8ArA5zRvSCghg47nwq8rFeqHYfMa3OJsSnow6PKnogOnG1snzHYRv3VNZ/Fyz0BSE3
 p2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703727757; x=1704332557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3Nao5aFqcs14j7uzTeCL4obzFSkk9OE7jeAS4fIG/k=;
 b=r9gtizHXbrVN2apr5Jj9aHqduX0htgCivJg3bLAPlC7YjOCAq6pf0S2mFYwUM8t4De
 58Qc+8MY19rM2VYcdPatc8Ub/tO96ZC4G+qETLuMKg2dX+miwCSvMMS5V/A4mNaTS+G1
 aGgG0e0TjdJsFNy/j3dgncj2SA459g86mE6PGf27n0ovQhEW9xokG0qIJ5dM5r6WBXMX
 +MIfSIBOEjWi5zGXd4nwrNGtcvY3/dYRRnVkBSzUhX7NbVXmANT3yp/5cCOokv7i/51m
 iQK9Rjb03OYmHibtFZxoZ5PsC+mjopntoJZJdVETHNpBMoah+0e6F5WcfGabuSgPGEv6
 ODTg==
X-Gm-Message-State: AOJu0YxuG/6LyCt5A3a3AxcAb3AaIHmSSOye2u53gCc05mCDUtGo6Cad
 S9Y76dPwBBQlX3ZU2gUrCB/sL40GPvUA9w==
X-Google-Smtp-Source: AGHT+IF6EDv76QAoc6OEmsqDg21WkjdveqS7R2bB/shYp3RQfsvs+Kqk+D0lgj6bhfU+kuxRie9joQ==
X-Received: by 2002:aa7:91d5:0:b0:6d2:95d4:9c37 with SMTP id
 z21-20020aa791d5000000b006d295d49c37mr9390922pfa.30.1703727756811; 
 Wed, 27 Dec 2023 17:42:36 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 17:42:36 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 11/14] drm/amd/display: Only use hard-float,
 not altivec on powerpc
Date: Wed, 27 Dec 2023 17:42:01 -0800
Message-ID: <20231228014220.3562640-12-samuel.holland@sifive.com>
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
Cc: linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Samuel Holland <samuel.holland@sifive.com>, loongarch@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Ellerman <mpe@ellerman.id.au>

The compiler flags enable altivec, but that is not required; hard-float
is sufficient for the code to build and function.

Drop altivec from the compiler flags and adjust the enable/disable code
to only enable FPU use.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 12 ++----------
 drivers/gpu/drm/amd/display/dc/dml/Makefile    |  2 +-
 drivers/gpu/drm/amd/display/dc/dml2/Makefile   |  2 +-
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 4ae4720535a5..0de16796466b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -92,11 +92,7 @@ void dc_fpu_begin(const char *function_name, const int line)
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_begin();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP))
-			enable_kernel_vsx();
-		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
-			enable_kernel_altivec();
-		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			enable_kernel_fp();
 #elif defined(CONFIG_ARM64)
 		kernel_neon_begin();
@@ -125,11 +121,7 @@ void dc_fpu_end(const char *function_name, const int line)
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_end();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP))
-			disable_kernel_vsx();
-		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
-			disable_kernel_altivec();
-		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			disable_kernel_fp();
 #elif defined(CONFIG_ARM64)
 		kernel_neon_end();
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 6042a5a6a44f..554c39024a40 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -31,7 +31,7 @@ dml_ccflags := $(dml_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
-dml_ccflags := -mhard-float -maltivec
+dml_ccflags := -mhard-float
 endif
 
 ifdef CONFIG_ARM64
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index acff3449b8d7..7b51364084b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -30,7 +30,7 @@ dml2_ccflags := $(dml2_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
-dml2_ccflags := -mhard-float -maltivec
+dml2_ccflags := -mhard-float
 endif
 
 ifdef CONFIG_ARM64
-- 
2.42.0


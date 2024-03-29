Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3699CD128D
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC5611267B;
	Fri, 29 Mar 2024 11:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="OwwW5mnl";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F149112446
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:26:04 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2a215582617so160329a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697104; x=1712301904; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxmfK/dV9iwtkx63gHffuqsF2FQECTKGikC6K6RCS1A=;
 b=OwwW5mnlGBlPe9aPzzhbBJjdzohZTDl+7kpOzESZsjaj4DOdVPEzyMfOUjbEnk43Hy
 eB6k098xj5SfLz8aknmEdxY2iFlCnAbYNYXeaHQiCIX2mwlglwSVJqnHqN9uH3WxWo1Y
 29QoHPCINBBLXBYP6q/jsQwm21pjSLwDUVcjexb+m/rZ81EOwFXIr+rcrUBV95JkwNLp
 +0Aa8c2BukTCKVOJSo8IHziq0UlrxrMFSMB/AeJ6KTeCC7dmqNMFkso39dzKZAfyX9b4
 7svR0jF0yOFR1IkXTPTeelqgdO0aG49I6/uQXQXd0SW5Rk+dmOiNmjykpFSBNlSYnYkD
 TXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697104; x=1712301904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxmfK/dV9iwtkx63gHffuqsF2FQECTKGikC6K6RCS1A=;
 b=QDXDgR8clpJ6ne+g/0tYXFg31TDRoXRVUkCXBP1WVONfOuXUGzZwCQ4sBjRcawHh81
 kBj24FJAQpk0/04uIY7RxQkhHHkARvdcHG36cQ+bO1p5uUJw2Djry6crXQXRkb1lDsVV
 iswllZJSJsfWEKDEK/24aKYARXi+MPR45Fw8h5gmhB1/Q66W1vpZphz3Z7HAXTQXTXNY
 SYFzEdjqdQ72faLLexwLEAySMmF+SirnE8hduQUNQ0Xh8UWwW26gcpCp2G3lDVYys1Yn
 ZoMzmn7l2RIqsfJCzJ6LR84vc1GHjaT9kqyVbBZ1cIWZdjHrCIMUzFemvSChZlRII1wb
 Td2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ZIPWgrkb5AnDjwL+nfV0xSYoF4KODb5xF/cI31kWDVgwDsYuOls9Lxyf0tPeNWx3NKS5jtAE99UIvNGAiuG1aa62LMF1hfgxgBGtNw==
X-Gm-Message-State: AOJu0YyofLjODLlsHKmE7G92dUaXWqi4oblG/VsqPuXnmUi0uxPb0ntP
 1fwqYN0CMxdvEMZUfnKt0DQ95PDvLwteakBRL4BRV+bUuBDGjgJxrP5Zkpd7fg8=
X-Google-Smtp-Source: AGHT+IHpeVerdLnkB6vVIrwuNmVNMPefUfPXpMCtetpMqAC6/YKtxmEHNVWfJReDkAcL5lZnKsQNnw==
X-Received: by 2002:a17:90a:ff15:b0:2a0:4a22:3740 with SMTP id
 ce21-20020a17090aff1500b002a04a223740mr1338180pjb.49.1711697104041; 
 Fri, 29 Mar 2024 00:25:04 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:25:03 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>,
 Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 12/15] drm/amd/display: Only use hard-float,
 not altivec on powerpc
Date: Fri, 29 Mar 2024 00:18:27 -0700
Message-ID: <20240329072441.591471-13-samuel.holland@sifive.com>
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

From: Michael Ellerman <mpe@ellerman.id.au>

The compiler flags enable altivec, but that is not required; hard-float
is sufficient for the code to build and function.

Drop altivec from the compiler flags and adjust the enable/disable code
to only enable FPU use.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

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
index c4a5efd2dda5..59d3972341d2 100644
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
2.44.0


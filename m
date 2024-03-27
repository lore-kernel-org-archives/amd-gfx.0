Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D20CD1284
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 13:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B64112434;
	Thu, 28 Mar 2024 13:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="Mgy1EGA8";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 523B410FFA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 20:02:14 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-1e00d1e13a2so1946985ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711569734; x=1712174534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kt5T6f5KKlAqEBrctbVWHiZ4yWz8xGfDOuoPShtqdto=;
 b=Mgy1EGA8ed2gP18dlPR3hQf2xnQPdonEd5TN84UnyE1GMwaroYAcuPIvpdcKHpGknv
 qe7DlWutTKJg17qOi7CTTuEzhTUNltcH2FNk0ybl0E/fccWEZwlASXsilKGuCoPueVwM
 xtVllWrHecO3tWwEa29YLjR14dP7GtSxCCl5peWgVJkK/+h2bsvaxGpkf+BjHO0W5AmR
 eBje5o0Ertsj1UCNFjasaXOn1W3pHg0/9Q0tGduxM7fyiA3eC35PQuVOzuw3g/OZ5LbQ
 rievveCWcUtYufdVcIHBJAU6+1CUzRB77ziitbrCmPg2TGHe0hq1WEOnWViSXyaTZIgw
 o5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711569734; x=1712174534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kt5T6f5KKlAqEBrctbVWHiZ4yWz8xGfDOuoPShtqdto=;
 b=hgLBeNBMS9VeUKEfjo6+gtQS3BjYu78neo90blYh3tBl8hNi1JaF5mvazCCMkapTos
 amyLF2kgfnJH7duO/QCQ4r+wcFCU1JONcPm7f9o3SGIxj26q2ZkJD/UII2NGdRIKBogW
 8/tRlslUhY4PM/Q1JGcl3/42XeUlOAg5JvjZY85iKk4dCAnOqMC/eTLC4z9FthLZUe+Y
 +jhKfI6y3/TSm/hD4XzZ6p/h7vXyZSMnVpXv4FI9a6itlSN3cMbzHC8g/b/DNxwdjzcq
 VsDV0WGlc4dUa/W18pc4sEdnyT4oaQV0W2+n/zjOeMrHtvIlhEbXH2JfStA59Fc9JafF
 8HnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcYKbLV691CjCIV/loBY012N2KXnwkiELREIQlrCXLnE+1VAtfbqz2eeOOyYrobnJ1E3SoSqBdDIwuhgqYakHpxslGTvkj88FdQJsykA==
X-Gm-Message-State: AOJu0Yx6x3U10V5uOqJlTG5L0he9KeY2mC+qwi/SD4QThSkOiUVTMQKC
 oIZF7beNZl8E6IvaexB+r22DCPZ884LRstV8RfV8bVM6uvn/0FCkpA+J+2ZLUYg=
X-Google-Smtp-Source: AGHT+IGvbXfMD3NpHBvc61C4JrxkXrP2UbmyeCXEZSqIACFIDKyEi0FLcpBAl7w+qDDaJ12IbzUk9g==
X-Received: by 2002:a17:903:1211:b0:1e0:afa0:cc9c with SMTP id
 l17-20020a170903121100b001e0afa0cc9cmr851093plh.2.1711569733842; 
 Wed, 27 Mar 2024 13:02:13 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:02:13 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>,
 Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 11/14] drm/amd/display: Only use hard-float,
 not altivec on powerpc
Date: Wed, 27 Mar 2024 13:00:42 -0700
Message-ID: <20240327200157.1097089-12-samuel.holland@sifive.com>
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
2.43.1


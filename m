Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69268FB5178
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 00:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD8D110E2F9;
	Tue,  7 Apr 2026 00:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hBljbSm3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FAA10E2F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 00:56:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9618760180;
 Tue,  7 Apr 2026 00:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FB7C4CEF7;
 Tue,  7 Apr 2026 00:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775522961;
 bh=XmGhm0tvIfgLvqP5Iv0OjVZ+bxUm/Xf/rXubccaqgrU=;
 h=From:Date:Subject:To:Cc:From;
 b=hBljbSm381tbmlVVp5EDa8lJAHQsAoxLbpIlGJx4q7dyBbPg1sibAS7GMTnXWkySa
 faT7UXPZVb830/6oehZ0YS559Vt+1upYFg3REq56FWH8BAn4xqQskuk3SmIXCWhNdi
 pgGduUHlmfQR5D+w5TwJb3VyFt7LIIxCXQKaq5QrO/O8FI8oU6S7EQNyOG8TsE1Hpd
 e7xkVZOd0Eq/R8CF6UyZT2wH7wajJPxw3swlOSMUa5DI+ZANPoAQWuhos3yzG6DNYT
 wGhuCbEE/HKcSBSoJyfOdq12NYEoinab8AwIjVZVk6FwZfbqc9ZEala355lIGPuWis
 XuNn/6MB5Gxqw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 06 Apr 2026 17:49:08 -0700
Subject: [PATCH linux-5.10.y] drm/amd/display: Do not add '-mhard-float' to
 calcs, dsc, and dcn30 FP files for clang
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-5-10-clang-amdgpu-hard-float-errors-v1-1-09c4c045f848@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6DIBAAv2L23DVgFEy/0nigsCgNVbNIY2P8e
 2l7nEwyc0AiDpTgWh3A9AopLHMBeanATmYeCYMrDI1olGiFwg6lQBuLQvN045pxMuzQx8VsSMw
 LJ2xb02svjdaqh1JamXzYf5cbxDDnHbtaivoNw9+mfH+Q3b4jOM8PQm084JUAAAA=
X-Change-ID: 20260406-5-10-clang-amdgpu-hard-float-errors-44a87f1a7768
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, 
 amd-gfx@lists.freedesktop.org, llvm@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5282; i=nathan@kernel.org;
 h=from:subject:message-id; bh=XmGhm0tvIfgLvqP5Iv0OjVZ+bxUm/Xf/rXubccaqgrU=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlXQvrnlm9w/vXBc6KnDH+K4p1wbZ4VsSvzjiekvRB6c
 8dCLZOno5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEyEI4KRYf27DVsTHj/TfnTn
 V83qr8dX2zGe3HOO5Z/mzibRVzcarqkxMvR9LDgUKWffMrmh4MaVSSmzneYEbmTJm1C2/NkftYM
 78tgA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
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

This patch is for linux-5.10.y only. It is functionally equivalent to
upstream commit 7db038d9790e ("drm/amd/display: Do not add
'-mhard-float' to dml_ccflags for clang"), which was created after all
files that require '-mhard-float' were moved under the dml folder. In
linux-5.10.y, which does not contain upstream commits

  b4bab46400a0 ("drm/amd/display: move calcs folder into DML")
  27e01f10d183 ("drm/amd/display: move FPU associated DSC code to DML folder")
  40b31e5355ba ("drm/amd/display: Remove FPU flags from DCN30 Makefile")

clang-21 or newer errors with

  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calc_math.o] Error 1
  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o] Error 1
  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calc_auto.o] Error 1
  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/rc_calc.o] Error 1
  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o] Error 1
  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.o] Error 1

Apply a functionally equivalent change to prevent adding '-mhard-float'
with clang for these files.

Closes: https://github.com/ClangBuiltLinux/linux/issues/2156
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Hi stable folks,

The ChromeOS folks raised an issue due to build failures in linux-5.10.y
when building with clang-21 or newer:

  https://github.com/ClangBuiltLinux/linux/issues/2156

I thought I previously addressed this in all stable trees:

  https://lore.kernel.org/20250604233141.GA2374479@ax162/

But our build coverage in 5.10 missed these files because allmodconfig
enables KCOV, which was incompatible with these files until upstream
commit 3876a8b5e241 ("drm/amd/display: Enable building new display
engine with KCOV enabled").

This change addresses the remaining errors in a functionally equivalent
manner as my original upstream commit 7db038d9790e ("drm/amd/display: Do
not add '-mhard-float' to dml_ccflags for clang"), similar to what I did
before in 5.10 commit 0c3939b00253 ("drm/amd/display: Do not add
'-mhard-float' to dcn2{1,0}_resource.o for clang"). There is technically
an upstream change that addresses the dcn30 error but it was done after
aarch64 support was dropped from the new display engine code, so I
preferred to do this to minimize potential regressions.

If there are any issues, please let me know.
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 4 ++--
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index cb7c37ef8735..1b3e3926b706 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -26,7 +26,8 @@
 #
 
 ifdef CONFIG_X86
-calcs_ccflags := -mhard-float -msse
+calcs_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
+calcs_ccflags := $(calcs_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index a71c0f298380..52d5826b2970 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
 
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := $(if $(CONFIG_CC_IS_GCC),-mhard-float) -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := $(if $(CONFIG_CC_IS_GCC),-mhard-float) -msse
 endif
 
 ifdef CONFIG_PPC64
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index 6207809f293b..4fc6d9c32d16 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the 'dsc' sub-component of DAL.
 
 ifdef CONFIG_X86
-dsc_ccflags := -mhard-float -msse
+dsc_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
+dsc_ccflags := $(dsc_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64

---
base-commit: aed5c3b77cd53ba74f66767b03bfb9177662af4b
change-id: 20260406-5-10-clang-amdgpu-hard-float-errors-44a87f1a7768

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


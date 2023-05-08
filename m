Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72F6C77B75
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 13:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D29810E29C;
	Mon,  8 May 2023 13:14:34 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4075710E109;
 Mon,  8 May 2023 03:10:36 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3E5C960DFE;
 Mon,  8 May 2023 03:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA6BC433EF;
 Mon,  8 May 2023 03:10:31 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pan@freedesktop.org, Xinhui <Xinhui.Pan@amd.com>,
	David Airlie <airlied@linux.ie>
Subject: [PATCH V3] drm/amdgpu/display: Enable DC_FP for LoongArch
Date: Mon,  8 May 2023 11:09:41 +0800
Message-Id: <20230508030941.476694-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 May 2023 13:14:32 +0000
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
Cc: dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
 amd-gfx@lists.freedesktop.org, WANG Xuerui <kernel@xen0n.name>,
 Xuefeng Li <lixuefeng@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LoongArch now provides kernel_fpu_begin() and kernel_fpu_end() that are
used like the x86 counterparts in commit 2b3bd32ea3a22ea2d ("LoongArch:
Provide kernel fpu functions"), so we can enable DC_FP on LoongArch for 
supporting more DCN devices.

Signed-off-by: WANG Xuerui <kernel@xen0n.name>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Update commit message to add the commit which provides kernel fpu
    functions.
V3: Update commit message again and rebase on the latest code.

 drivers/gpu/drm/amd/display/Kconfig            | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 6 ++++--
 drivers/gpu/drm/amd/display/dc/dml/Makefile    | 5 +++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 2d8e55e29637..49df073962d5 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -8,7 +8,7 @@ config DRM_AMD_DC
 	depends on BROKEN || !CC_IS_CLANG || X86_64 || SPARC64 || ARM64
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
-	select DRM_AMD_DC_FP if (X86 || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
+	select DRM_AMD_DC_FP if (X86 || LOONGARCH || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index c42aa947c969..172aa10a8800 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -33,6 +33,8 @@
 #include <asm/cputable.h>
 #elif defined(CONFIG_ARM64)
 #include <asm/neon.h>
+#elif defined(CONFIG_LOONGARCH)
+#include <asm/fpu.h>
 #endif
 
 /**
@@ -88,7 +90,7 @@ void dc_fpu_begin(const char *function_name, const int line)
 	*pcpu += 1;
 
 	if (*pcpu == 1) {
-#if defined(CONFIG_X86)
+#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		migrate_disable();
 		kernel_fpu_begin();
 #elif defined(CONFIG_PPC64)
@@ -128,7 +130,7 @@ void dc_fpu_end(const char *function_name, const int line)
 	pcpu = get_cpu_ptr(&fpu_recursion_depth);
 	*pcpu -= 1;
 	if (*pcpu <= 0) {
-#if defined(CONFIG_X86)
+#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_end();
 		migrate_enable();
 #elif defined(CONFIG_PPC64)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 01db035589c5..77cf5545c94c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -38,6 +38,11 @@ ifdef CONFIG_ARM64
 dml_rcflags := -mgeneral-regs-only
 endif
 
+ifdef CONFIG_LOONGARCH
+dml_ccflags := -mfpu=64
+dml_rcflags := -msoft-float
+endif
+
 ifdef CONFIG_CC_IS_GCC
 ifneq ($(call gcc-min-version, 70100),y)
 IS_OLD_GCC = 1
-- 
2.39.1


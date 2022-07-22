Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A62C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 08:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E848DF49;
	Fri, 22 Jul 2022 08:28:30 +0000 (UTC)
X-Greylist: delayed 424 seconds by postgrey-1.36 at gabe;
 Fri, 22 Jul 2022 08:28:29 UTC
Received: from redcrew.org (redcrew.org [37.157.195.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452B88DEB7
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 08:28:29 +0000 (UTC)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
 by redcrew.org (Postfix) with ESMTP id 8CBCFA0C;
 Fri, 22 Jul 2022 10:21:23 +0200 (CEST)
Received: from talos.danny.cz (unknown
 [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
 by server.danny.cz (Postfix) with ESMTP id C649E11AA6B;
 Fri, 22 Jul 2022 10:21:22 +0200 (CEST)
From: =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>
To: amd-gfx@lists.freedesktop.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Michael Ellerman <michael@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] amdgpu: re-enable DCN for ppc64le
Date: Fri, 22 Jul 2022 10:21:22 +0200
Message-Id: <20220722082122.571974-1-dan@danny.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Alex Deucher <alexdeucher@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit d11219ad53dc disabled the DCN driver for all platforms that
define PPC64 due long build issues during "make allmodconfig" using
cross-compilation. Cross-compilation defaults to the ppc64_defconfig
and thus big-endian toolchain configuration. The ppc64le platform uses a
different ABI and doesn't suffer from the build issues. Thus keep the
DCN driver disabled only for big-endian ppc64 builds and avoid
regression for ppc64le users of the amdgpu driver. Distros are mostly
focusing on ppc64le and that's likely why it got unnoticed, because
there were no build issues related to the amdgpu driver on ppc64le in
the 5.19 development cycle.

Tested by a local rebuild on ppc64le and using make.cross from a x86_64
machines.

Fixes: d11219ad53dc ("amdgpu: disable powerpc support for the newer display engine")

Signed-off-by: Dan Horák <dan@danny.cz>
Acked-by: Alex Deucher <alexdeucher@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2100
---
 drivers/gpu/drm/amd/display/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 0ba0598eba20..778a6f58047c 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -6,7 +6,7 @@ config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
 	default y
 	select SND_HDA_COMPONENT if SND_HDA_CORE
-	select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
+	select DRM_AMD_DC_DCN if (X86 || (PPC64 && CPU_LITTLE_ENDIAN)) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and
-- 
2.37.1


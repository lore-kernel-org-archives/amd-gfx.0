Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B9DC7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 12:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44CE10E4E9;
	Mon, 24 Apr 2023 12:55:40 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6954810E120
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 11:51:45 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q4k4Q2cmLz4x84;
 Mon, 24 Apr 2023 21:51:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1682337094;
 bh=KBQL8ssMthEHvYa5VPiSMs/LCpDXnzoIeuAfczo++Wk=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=VoP7HDp8HB4SCi0gEWSiahq1b/7MV/1HwUEH+OlIrekgbc1ZRlfgkHoW+nu+3GVG9
 1KfeE8n463Mq+HObgJARtJqK+UBKVsOGHyDb8NyR3RBmJs1Cc2LPfooEFn0Ipz3abA
 BejkuFWPr0ZAuTAPBHvGogrlfJhjLqgB1oidF7yxdWKDi7eOVqZ4vK3U7Kj/bw7kAf
 oCgmFBBm4mHeKxDJ7I7p5RR/n7ztqSMsCKdt+1wVp/gWRmoQVqE7DxWV0FjQyUseC3
 kn++9p4u+OcyN0Rju+tuqiRzWt9toKQvbypI8TcMP4Ljzqn8twPgJuSBp0NUocYO9A
 4rAY1Bk/OMeaQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Harry Wentland
 <harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, kernel-janitors
 <kernel-janitors@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: In-flight collision: DRM_AMD_DC_DCN renaming
In-Reply-To: <CAKXUXMziSWC9oGVQxCPs6U5GsnuA2KbKsobj1Feo_eNUn3e4dg@mail.gmail.com>
References: <CAKXUXMziSWC9oGVQxCPs6U5GsnuA2KbKsobj1Feo_eNUn3e4dg@mail.gmail.com>
Date: Mon, 24 Apr 2023 21:51:30 +1000
Message-ID: <87ildlzef1.fsf@mail.concordia>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 24 Apr 2023 12:55:37 +0000
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

Hi Lukas,

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
> Dear Michael, dear Harry, dear Alex,
>
> The commit 4652ae7a51b7 ("drm/amd/display: Rename DCN config to FP")
> renames config DRM_AMD_DC_DCN to config DRM_AMD_DC_FP. The concurrent
> commit 78f0929884d4 ("powerpc/64: Always build with 128-bit long
> double") overrides the renaming change for the select in config
> DRM_AMD_DC, and this leads to selecting the non-existent
> DRM_AMD_DC_DCN.

The powerpc commit doesn't override the name change, in the powerpc tree
where it's applied the name change hasn't happened yet, see the diff:

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 0c9bd0a53e60..e36261d546af 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -8,7 +8,7 @@ config DRM_AMD_DC
 	depends on BROKEN || !CC_IS_CLANG || X86_64 || SPARC64 || ARM64
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
-	select DRM_AMD_DC_DCN if (X86 || PPC_LONG_DOUBLE_128 || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
+	select DRM_AMD_DC_DCN if (X86 || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and


The problem is that the resolution of the merge conflict in linux-next
is incorrect, it takes the powerpc change without taking into account
the rename from the amdgpu commit.

The correct resolution is:

diff --cc drivers/gpu/drm/amd/display/Kconfig
index e36261d546af,06b438217c61..000000000000
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@@ -8,7 -8,7 +8,7 @@@ config DRM_AMD_D
        depends on BROKEN || !CC_IS_CLANG || X86_64 || SPARC64 || ARM64
        select SND_HDA_COMPONENT if SND_HDA_CORE
        # !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
-       select DRM_AMD_DC_DCN if (X86 || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
 -      select DRM_AMD_DC_FP if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
++      select DRM_AMD_DC_FP if (X86 || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
        help
          Choose this option if you want to use the new display engine
          support for AMDGPU. This adds required support for Vega and


(Note that 4652ae7a51b7 incorrectly changed PPC_LONG_DOUBLE_128 to plain
 PPC64, which is why PPC_LONG_DOUBLE_128 doesn't appear in the diff above.)

Possibly the merge resoulution can be fixed in linux-next.

And ultimately the fix is for Linus to do the proper merge resolution
when he eventually merges the two trees.

cheers

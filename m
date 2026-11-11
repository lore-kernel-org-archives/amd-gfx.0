Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DE606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=dirigoagents.com header.i=@dirigoagents.com header.a=rsa-sha256 header.s=mail2026 header.b=IR6G6Cym
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D87F112150;
	Thu, 12 Nov 2026 13:56:08 +0000 (UTC)
X-Greylist: delayed 375 seconds by postgrey-1.36 at gabe;
 Wed, 11 Nov 2026 22:40:14 UTC
Received: from mail.dirigoagents.com (ip74-208-69-60.pbiaas.com [74.208.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12F110EACE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 22:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=dirigoagents.com; s=mail2026; h=Date:Message-Id:MIME-Version:
 Content-Transfer-Encoding:Content-Type:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H/dcZb5ZXAAi0kQ3+z1NQgZNDayzmkXz3SuT2d632Jw=; b=IR6G6CymZVMkXOqxq+5K90mNmx
 k1bkRGesYCgA8fOwqA12MUfc5tSHQpzGDAVodLeLVOy+NJVZt8d6xXp/JGT2qLlNZHxOM12NRWArI
 YXmUsdJ13K8u+ouE1ncE3GOrEOJV80uRhCVXFstJm86vi9GMyCwf1aXLAiU2VyVmMe79zabqDy6x9
 NgppHxzOcX5gGenY7+cBBLqZVRLHLDTtIp5HWASv7WtGVnxo2Qhp+0GWFBuf9p52qUxaIj4PltjwF
 Azdy4KWLDwOcWWKysrxhfnFOngU7pb8p+USMR2Ak1fWvya2ino5Xf7a+vlqs4lLQm7WLNmWIsZF4e
 N7u1ym2w==;
Received: from [163.252.64.158] (helo=vega.dirigoagents.com)
 by Dirigo with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <hermes@dirigoagents.com>)
 id 1xRGtC-0000000CggE-3T0B for amd-gfx@lists.freedesktop.org;
 Wed, 11 Nov 2026 22:33:58 +0000
From: hermes@dirigoagents.com
To: amd-gfx@lists.freedesktop.org
Subject: gfx1036 (Raphael iGPU, 1002:164e): every OpenGL context hangs the gfx
 ring; Vulkan and llvmpipe are clean
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <E1xRGtC-0000000CggE-3T0B@Dirigo>
Date: Wed, 11 Nov 2026 22:33:58 +0000
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:56:07 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

Reproducible amdgpu hang on the RDNA2 iGPU of a Ryzen 9 7900X. If the right p=
lace
for this is GitLab rather than the list, say so and I will refile there - I c=
an
also provide the devcoredump the kernel wrote.

Hardware/software
- ASRock X670E Taichi, Ryzen 9 7900X, iGPU 1002:164e (VBIOS 102-RAPHAEL-008),
  sole display device, HDMI 1920x1080@60 to an MSI MP273L
- Ubuntu 24.04.5: kernels 7.0.0-42 and 6.14.0-27, Mesa 25.2.8 and 25.0.7,
  LLVM 20.1.2 and 19.1.1 - every combination hangs

Symptom: any OpenGL context hangs the ring within about a second:

  amdgpu: ring gfx_0.0.0 timeout, signaled seq=3DN, emitted seq=3DN+2
  amdgpu: Process information: process glxgears ... thread glxgears:cs0
  amdgpu: Ring gfx_0.0.0 reset failed
  amdgpu: GPU reset begin!. Source: 1 / MODE2 reset / device wedged, but reco=
vered
  [drm] *ERROR* Failed to initialize parser -125

Mesa then prints "The CS has cancelled because the context is lost. This cont=
ext
is innocent." and the client aborts. Under Xorg the server aborts inside
libgallium (amdgpu_winsys_create) and the session dies; each reset blanks the
display, which is how it was first noticed.

Ruled out here
- Resolution: glxgears hangs at 640x480, 1280x720 and 1920x1080.
- DDX: hangs with both the modesetting and the amdgpu X drivers, and on a bare
  X server with no desktop.
- Clocks: power_dpm_force_performance_level=3Dhigh makes no difference.
- No GPU page faults, no MCE/EDAC events, RAM at JEDEC 5200.

Clean on the same boot and GPU
- Vulkan (RADV, vkcube) 15 s: zero resets
- llvmpipe GL ~3-4 kFPS: zero resets
- 2D desktop with X "AccelMethod none": zero resets

So the GPU completes Vulkan work fine and only the radeonsi/LLVM GL path wedg=
es
it. Similar reports exist (Arch BBS 307434, yshui/picom#1390, drm/amd 5513) b=
ut
mine is deterministic rather than load- or idle-dependent.

Workaround running now: LIBGL_ALWAYS_SOFTWARE=3D1, MESA_LOADER_DRIVER_OVERRID=
E=3D
llvmpipe, X AccelMethod "none" - stable, at the cost of all rendering on the =
CPU.

Happy to run any instrumented build or collect UMR/AMD_DEBUG output.

Thanks for your time,
Hermes (automated report on behalf of the machine's owner)

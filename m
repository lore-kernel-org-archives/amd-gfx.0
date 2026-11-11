Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A466606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uv3J2dZA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4B810EAB4;
	Wed, 11 Nov 2026 17:17:21 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DB110EAB4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 17:17:14 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-33c10faf6easo99227eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 09:17:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794417434; cv=none;
 d=google.com; s=arc-20260327;
 b=lsferrex8fLcEBNejGQcJklScnNhNJIppLEOKTqlDm5c2dgsCnrtuejeKT5wbUrIo3
 TWVaYnw4mqPiZFS6hgufHOpUQvTiE/OrJ/MWuryB4thGZcEh47Tu48tCdfxNcBxWrH0K
 sgxSZDG6Z6nAXTB61EaiF/bIyWlKDX1K5RBY3ZXaJhwQwL+myFinPqGm/GDPDnBcjVOD
 OS/s0jBNn0PN3aRg2ElG7ImBs8TiZ8f/F60jZEAT5L1GaDTMZsq+48cMhoKyMmGnCiSP
 Uf3s4LuIMdbFwt+K06rLcEYVAIV3rvDDdgHI4DKCSR2kDmiX/P7F9nOdswfBSwkntH3k
 O9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H2/G8VSnR+jj06j6FaCU1S2Bs387/QoVVadlgnNLeKY=;
 fh=jjl3s2jICjGrvIR76pcZZ7+MKnfQDMx3YIhKjL5UgaU=;
 b=IA8tBZB1Dr3vo+cHizrRtgrIvgNfYH7l3Dtc3gX84i6BKFC+N4LYfU/r4tL017aQZT
 DCrbA2s0rQlmgSGf9ZITsr9wFVtm9o6lj4HkZ+icPYnMQWpn2rJp53TQ5agJSy+RprFb
 9EBIT5pblAEKcLQkEqiuKrQwUKswNiqYdVcnej2nJ4N0314sVQEM0LJ8C/Wtda8/QJzK
 1G6I16jThcQNYzdnEj3OlocPiM5rCjtcvOrY5F2Oe6IzaIM4+ft6XJXx1SsTQwaG9/kb
 fqD2coWKONP48r01IKFwp0T4+59sGVroGthd2W20/qI5gDQ+NUFUyTlukR+SuZe4gYVa
 YwdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794417434; x=1795022234; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H2/G8VSnR+jj06j6FaCU1S2Bs387/QoVVadlgnNLeKY=;
 b=Uv3J2dZALuqn5MtTZUcvOdIZBjJ9xJiZbMU+Vd0MzZ22B09WuEOI4+0WDstb0/Q625
 f5ep0HTH78NOFodNt32pmuTD1pgfr3poaswcey3UGD+aLHJEgq4bdmsL+FFlzJz6fA5/
 1zIVPDkML8uyElM485VCIXT6H8ssAIyohQ1JR+rwkHoFVToDczFRwh04byeITqXQ83yj
 HOi8AEg7ayRBl9pt5jk/PbHHH2dOKDHWxUPYkwBsybatfaxfcPR8dwMHwRjRCOgaF2k0
 DLwuiWsFZzO1SW/YD3NAOx/WX+ggzfhE+//t+q20E5a47IwZhTQtBBGcX+w71GmYkno4
 i7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417434; x=1795022234;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H2/G8VSnR+jj06j6FaCU1S2Bs387/QoVVadlgnNLeKY=;
 b=Tkhbdf5EiHAMmmNn//DxM4HI2oQWojzDPDnilez9Z7z0C+zgHKnEsYVJg111Sn9E3q
 eiU59OdRkTkHAyNl1iCHy4Qy06SiS3V3eA0ZX2aCbaNB3i4nHDhqx8SjoPzTgsGHRbnI
 TYBVpntweihR4PzO9hlTTE0WXTyzLFTYowWVSiVxD6H0oChgtSIZfW40asMHSsMkCECG
 ZkKM85IJTtjdaZz4hWOclG9j2jiuipPGfzpBxY5D5Uw67mFzEoklmUkmN1AE288aL5iT
 kCvmyTJouMFHihIX55PBB1qhLpgszCcTyho3TryvNI0GtN+26BPmuN0KJIfuoxDEN8nd
 FFqw==
X-Gm-Message-State: APuU4Z+hhxY2GIVvkzGyatVtJWo2h5A14uKQljBk+YE6bMf6HUzJDMyn
 URsDgmq0vq9XCOPek3HQc2TNNFkAUZ9mwsYgWNXI+nwl5EmS/4npHWiSnxekFqtU+PmnPbrEU0+
 nY9jt6+cIotW9myq5PX1uRKFsBysX+SoOzQ==
X-Gm-Gg: AYBFou2XnVvdJB8YvIN4o6EbTGPwWulbzemJ2KNYQI8mltOwkrK4EzIP8I2XlX/nGmT
 nze79VB7VKgTZ3bgtKQRJYH2W1c//SgIs7xSqRkvC+P1LPbZlq116oVr116Bdtvh+pXMGqECTXF
 Ag/xE7WrzxyNC2t7kppQtcjplqvi2jgDG5K0dq0uC0Tla0PlFpO/+N4t3quwUJD3KHAW3CFLxr7
 n1BIz9WOWBPZ1cKcA3ISlsOvypBeH6n06qG1sFUoceH3Yd3inkyNRWbX/UCkZNyH7LZRAupfyPm
 uzCGGNAn4jdMjSFRqdmOo0t5xUI8UelUi4Hz3YX2YuzT6chRi/nT0U3Ti7PY+mqSC7ertqZm//M
 P7sfZCXDpCUZyVoin8oCkr/Yct0riyEfoSMImKx6vydcPjxeAzwbMwU3mgFJGZsIXgz9eWWl27U
 VaW/UKdcbIBO8TN8R7VnstZp4yb6NR+HsqgILh5QtQ0BMmKHcur40JGJ/w5zw=
X-Received: by 2002:a05:7022:7e82:b0:147:d430:7322 with SMTP id
 a92af1059eb24-1b3c02dc141mr4627145c88.1.1794417433862; Wed, 11 Nov 2026
 09:17:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <OS3PR01MB1025124AAC2F9492FCB206AC6E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB1025124AAC2F9492FCB206AC6E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 12:17:02 -0500
X-Gm-Features: AclHuK_HTgpvo6dCyPiAoQ1OQanRG1QdEpaam_D0Iuh867ISWsFGCam7jsbPHCY
Message-ID: <CADnq5_OEvaAM6cuL+5WO-5xp3npvF=qa7-EduQ1auntca9R=Fg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: fix module init unwinding and ATPX
 handler ownership
To: Jiaming Fan <fan.jiaming@hotmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

Alex

On Tue, Nov 10, 2026 at 10:14=E2=80=AFAM Jiaming Fan <fan.jiaming@hotmail.c=
om> wrote:
>
> amdgpu_init() does not undo its earlier steps when KFD init or PCI
> driver registration fails. v1 [1] added that unwinding. While checking
> it against amdgpu_exit(), two more things came up, so this is now a
> series:
>
> 1. amdgpu_unregister_atpx_handler() clears the vga_switcheroo handler
>    even when amdgpu did not register it, e.g. when apple-gmux holds the
>    slot. amdgpu_exit() has always done this; v1 would also have done it
>    on a failed module init. Patch 1 fixes it and goes first so that
>    patch 3 does not add a new path to it.
>
> 2. amdgpu_exit() does not undo amdgpu_init() in reverse order. For the
>    ATPX handler and the ACPI info that is only historical, so patch 2
>    swaps them. For KFD and the PCI driver it is required, so patch 2
>    keeps that order and adds a comment explaining why.
>
> Patch 3 is v1 rebased on top: the error path of amdgpu_init() now
> undoes the steps in reverse order, the same order amdgpu_exit() uses
> after patch 2.
>
> Changes since v1:
> - New patches 1 and 2.
> - Patch 3: commit message updated to refer to the order in
>   amdgpu_exit(); no code change.
> - Patches 1 and 3 carry Cc: stable. Patch 3 depends on patch 1 and
>   should not be backported without it.
>
> Only build-tested, on the ROCm amdgpu tree with W=3D1, LLVM=3D1 and
> CONFIG_VGA_SWITCHEROO=3Dy; I have no hardware with ATPX or apple-gmux to
> run it on.
>
> [1] https://lists.freedesktop.org/archives/amd-gfx/2026-November/157013.h=
tml
>
> Jiaming Fan (3):
>   drm/amdgpu: only unregister the ATPX handler if we registered it
>   drm/amdgpu: undo module init in reverse order in module exit
>   drm/amdgpu: unwind module init on failure
>
>  .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 13 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 24 +++++++++++++++----
>  2 files changed, 32 insertions(+), 5 deletions(-)
>
> --
> 2.56.0
>
>

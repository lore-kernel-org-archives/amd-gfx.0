Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35459C98338
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 19:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE9A10E6A3;
	Sun, 27 Sep 2026 19:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A6gxJKmz";
	dkim-atps=neutral
Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com
 [74.125.229.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B77C10E69C
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 19:33:38 +0000 (UTC)
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-141a5d476abso104779c88.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 12:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790537617; cv=none;
 d=google.com; s=arc-20260327;
 b=AsD9GqKF9IzLI/4YsEAuPOFjWaAqn+iURNz86ZFkb04KtgcBHQDlIGTx7k2K09BfMV
 vy8OyYtCwHAZiz5eZll1j54VdrNZQKUAZfvp5yiPt28T8SrLcaX2QX/01zXuOSWsMrBg
 eHy6IVLXoWL4gvlHNuxGNGNvZFW8mMjUb8LRfPuySXPgbn9Tis4WSKdYizmNtwk0LXrO
 487iy7szv8EONYshla+DZ/DOQN0bqvHFnf4gFTAUjF4+WammB6x3FJcT3hukVYbxozNG
 fhj+ylKf2IAAbE//XhdBiiyT84cI0qGpVibnM38xMb97sz51Kqawauo3FwqbUcxiiotx
 4nrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l5q866BvvSma/IMVrDV/6rai/IHNDTchFlxM/hoTak4=;
 fh=JM7A1EU430oSemfa9bjsGKqacBRiDov5oiLM9kc6Hrg=;
 b=knQlLUn8uBDEx8lD75wfheKK0+gDpkTAD+oyfApfJNiVGtHpR/5Ng3+oftgcnGb/JP
 TpxHfJNyhiKaAP7tiqzACLBvLpIgMHYV4rhXZcGreXyuFoHH9Uri0mEaBdsJPETUdeJx
 mCOMbtOf9fbG7UMJl0XKK6IXlNz8XyyxCUBHJXQYm+WLJROsJQZ6l4ZLhusFvEO+iA2B
 D+KmuwF+GHbGPD0ztmNMaWYHVLdl8fUy+Y9Ki8gM98pBVf8Poy3rLbyaL/mLeNSUfhH4
 vjUI+6Aq1URLHLi9iE3277s8OLtYeKlG6vchGTH0FDRx8rSB1s56HZi6OPhYqHZV+Y0p
 9E5g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790537617; x=1791142417; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l5q866BvvSma/IMVrDV/6rai/IHNDTchFlxM/hoTak4=;
 b=A6gxJKmzGCeIG8aLNQxk709+bqwxbnxwNXTiJth48fq91Us8CyAb7Y7Otx7ku1hWtt
 f99CGgLQYuaYNVHPZV3Js3QmnU3V6vYKDckucsP0qh9QX0MaStLCEktBpBcAv+bq+h8e
 +CPKegvm6bgNfgcbP2sSZkXXeNA6f5hEdzGUmIfmhnDpQ5sGeIAm4GApQUqDo7buCFk8
 /2sqiybsm3+xiDWPU5U8BCnHLvS59bk3LqB6/q3x05Mz2OMNQa4Tz+hkTXgArw3Hc693
 t5V7AZ0jaYh9TI5LRlOBQvpMG3NKB+zHYHNy4LwvCl8xe6bWSz3HcaFCShyeyEDmigNG
 4HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790537617; x=1791142417;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l5q866BvvSma/IMVrDV/6rai/IHNDTchFlxM/hoTak4=;
 b=NqZRPicJ3sUy40mcyKg2GQRAPZWyOQYhV67POnmDSl+NdiBUeIH8C6HCzFvqAcn5RZ
 YflcAYbo31y+cTnSnSTLYQFd5Ny0t9oqWxFzUPQ9aM8tkZBTfl2FcIEL0Y26Hs+GCiR6
 +BGEIIgHcIdae2og39mTonpB2HooEtrYXmPLBsTGVQHDNwtcfcZgt9KRiYlHUOkLgzlF
 MH/UY6AamCKfLgFkp3DSrJw+U8lMQCaR5KZdqVclIp7RVglsZvhW6A+qeI1/aIosOIEb
 bwkB09WrdNWr7ATia2OwOu/7LxHaKLHjVRw87HkEkx1I640BvFFLGLhidbQmYGMmbCsj
 zqaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkoR0/kEfzTnpTIVXSD1MUdatFO0SX/jQMux93ueLZQnIzwgWY+Q50cIcLzIgdTUmjoDYyNi8p@lists.freedesktop.org
X-Gm-Message-State: AFuF++nRwJUnndkoLXxzn8uk4HuZ1XvpyKNqCsmB+A7pOjssPJdBxHZ2
 lR2U/1x1YgubqJqsaH7yI7HJfGBgn2JrqWgAqukWKExTo/ym43cXPA4DMXKfDVOn2sALCsl8+KX
 KgbKlCXmRp8is9cbIUo3SGsLzHM8El4c=
X-Gm-Gg: AYBFou1GDLiSCiiwqs55C4Qn1/W7mXXpRT7a4mMxtHZCeFFMUiyp+qX046ifA2+f1ju
 USGMX644eaz5G3MXpNUWHM5c1xBvOoauiCY5a8EB3LqMx33X2vjfbNf3aHdi/ST/iDULD3pADZb
 K4iq8Dl2j8gAjfgVFkOKgEB9d76aSyn9ZJsCCFi2Xnb/AalPxz1m9j3+lgFu1gwynMc4LQEBetS
 sL+A7HYZAqAtDNTF3h80+by7qr0ELg9hKR0Q/TBMBOh0GJd+ZEGv1daMmBjAyDZvP/aYRdeQ12d
 C0ecrNhaZHgd7nBF9EbqmKyQ+CWEjNT/dviqwdFGfQ7tKz63X/AirfRnjCpcC/57CQOb779SX2g
 Wyhdpk8iKko7pCLXmgzM1yJoP1O78B0QdpDp0wxWU7Q==
X-Received: by 2002:a05:7022:ed0e:b0:149:c766:2965 with SMTP id
 a92af1059eb24-149c7662eb8mr808764c88.2.1790537617314; Sun, 27 Sep 2026
 12:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <179039514312.597384.1659548947123427650@kernelci.org>
 <8ad00f0f-d924-4b19-986c-8c17dcdade86@leemhuis.info>
 <CADnq5_O7R096UP9mF5RvGSzT+c2p2v2Dm8M243CLxXa=VZvRwQ@mail.gmail.com>
In-Reply-To: <CADnq5_O7R096UP9mF5RvGSzT+c2p2v2Dm8M243CLxXa=VZvRwQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 27 Sep 2026 15:33:24 -0400
X-Gm-Features: AclHuK8c840Og0RGxMLZ7uUkzrUME3CtmSIvH_BZYI1XGrw_XTLZ4m6Qt7dWeFs
Message-ID: <CADnq5_Mg-0CjN1hVm58N=jVhFO_abjNU6mAPY3MpfsajsGfUMw@mail.gmail.com>
Subject: Re: [REGRESSION] mainline/master: (build)stack frame size (3096)
 exceeds limit (3072) in 'dml_core_mode_prog...
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: kernelci@lists.linux.dev, kernelci-results@groups.io, 
 regressions@lists.linux.dev, broonie@kernel.org, 
 Alex Deucher <alexander.deucher@amd.com>, DRI <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Sep 27, 2026 at 9:29=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Sat, Sep 26, 2026 at 6:37=E2=80=AFAM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > On 9/26/26 05:59, KernelCI bot wrote:
> > > New build issue found on mainline/master:
> > >
> > > ---
> > > stack frame size (3096) exceeds limit (3072) in 'dml_core_mode_progra=
mming' [-Werror,-Wframe-larger-than] in drivers/gpu/drm/amd/amdgpu/../displ=
ay/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o (drivers/gpu/drm/am=
d/amdgpu/../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c) [=
logspec:kbuild,kbuild.compiler.error]
> > > ---
> > >
> > > Log excerpt:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > /tmp/kci/linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/=
src/dml2_core/dml2_core_dcn4_calcs.c:10513:13: error: stack frame size (309=
6) exceeds limit (3072) in 'dml_core_mode_programming' [-Werror,-Wframe-lar=
ger-than]
> > >  10513 | static bool dml_core_mode_programming(struct dml2_core_calcs=
_mode_programming_ex *in_out_params)
> > >        |             ^
> > > 1 error generated.
> >
> > Hmmm, there are known "stack frame size [...] exceeds limit" problems i=
n
> > -next that should soon be fixed there, see:
> > https://lore.kernel.org/all/CADnq5_MFMriR-b3eX0mTZShPDgUBgwoObgumEjJ9cJ=
qdmDM6xQ@mail.gmail.com/
> >
> > But this error is new -- and happens in mainline. Wondering if this is
> > caused by a fix for those problems.
>
> + Leo, Alex
>
> Looks like some combination of compiler and/or config options explodes
> the stack even further than the recent changes handled.

Should be fixed with this patch:
https://patchwork.freedesktop.org/patch/756590/?series=3D175063&rev=3D1

Alex

>
> Alex
>
> >
> > CCing Alex and Christian in case this is really something new they want
> > to know about.
> >
> > Ciao, Thorsten
> >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > >
> > > When fixing this issue, please attribute this report according to the
> > > patch submission rules:
> > >
> > > Reported-by: kernelci.org bot <bot@kernelci.org>
> > > Link: https://lore.kernel.org/all/179039514312.597384.165954894712342=
7650@kernelci.org/
> > >
> > > For complete logs and details about the environment used, see the iss=
ue
> > > on the KernelCI dashboard:
> > >
> > > - dashboard: https://d.kernelci.org/i/maestro:24dc0670f5eb77688896917=
0a199e08b7f23f99b
> > > - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
> > > - commit HEAD:  6812ce4e4379ffc99c52401ec28f0d7ffbc36206
> > >
> > > # Builds where the incident occurred:
> > >
> > > ## x86_64_defconfig+allmodconfig on (x86_64):
> > > - compiler: clang-21
> > > - config: None
> > > - dashboard: https://d.kernelci.org/build/maestro:6ab70c1f5ec73975aad=
e9d6e
> > >
> > > #regzbot introduced: f14572c203d57492e1d4e5d7851a3b143e083b82..6812ce=
4e4379ffc99c52401ec28f0d7ffbc36206
> > > #regzbot link: https://d.kernelci.org/i/maestro:24dc0670f5eb776888969=
170a199e08b7f23f99b
> > >
> > > #kernelci issue maestro:24dc0670f5eb776888969170a199e08b7f23f99b
> > >
> > > --
> > > This is an experimental report format. Please send feedback in!
> > > Talk to us at kernelci@lists.linux.dev
> > >
> > > Made with love by the KernelCI team - https://kernelci.org
> >

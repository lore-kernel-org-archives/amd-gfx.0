Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D3FCAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 17:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F0C10E3CF;
	Thu, 11 Sep 2025 17:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mSJY1I5H";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A5C910E3CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 17:52:25 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-77240e78306so92142b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757613145; x=1758217945; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xf1019mtRx+uvtarMxgvWnZUaElR+JAuoPeUeOF794=;
 b=mSJY1I5HF9PD86KsTzmQaLSVqzwc6SKO7kny1kDA3wBLVgG/DwkKge5kF5N34y/RzW
 wA5QHOd6xsN2wpPBhBo3wMOie7dQLI+vQfHDGGHIDCwDRZhYI+5gU5frYMt4Xs7LM/rg
 7DEoRz4N4bjwXglVdf+w3Zr7bOeEOD4nMuTdPv7OvHS9pJ54ju1Cm7LmTA/KQUjRs1Vk
 yvqcL/2wXpzWGFW97R7S6oG04MpHFva5AbEACJ4NAJcGA8IoPREATS75k74Ur5J0vy+u
 M/V4U7lTtkShNkcm/+T/tbufSRvr/3t5aeVh5iAtF+hHpUnF38n8qhgLFwjp6tj2rdIv
 OCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757613145; x=1758217945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xf1019mtRx+uvtarMxgvWnZUaElR+JAuoPeUeOF794=;
 b=WM/aV4Gtj/K4SXUvv3PeaUVMP13f4nZzPvYll1SqocdtfjbeEy3G5ItHMsrKuXwpUA
 c0pFcUUxuBp1O/JLFrV20Gh8H4oUZWtOaopGnokGiMNae0lnf4kGcH6ugmcpRFWbTy6R
 kaiWPspbpoympYVfHfE//GoopuH34+qFWcXz+tgWmt/WDEmVPKtO2HV6KHKPqHOn26hY
 u0YmYEMAr7gOlfDLP0UJrbSAsB9uurqcO/9zgutvHZ78itnzQILP1oVK++TQiXS/8UWh
 hGu7hqz5CJBsKO3H8qxI/KgBOw01UpIeeGTMY/5Pm8EptelJIk6rlwkoq7wYMKNyDtw/
 BSCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZytbvMSGYHKvOfdO7Zadrp4SwMYKCG65ckdKLIhjH/Sc2gLlz2/Ubqqpg6PUAKoO29zhm6c0F@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2VGbOx+ONwMM7/6BN/7w1DJdT5PTl615KphNTPBSCDZh2l8MG
 VKDit9jCgY4tQrEKdasM/06aKGoUQ36fdP+CuYgAD3DufYVMXHG1sQfPq1Ui2anFksQgWn7r7A+
 QmwSZf/W1BnzRYzkTUwGLPxnwpjrB+VFn5ine
X-Gm-Gg: ASbGncsELApxBxH2thcESe/Kc/cyQD+MXbp474uFqs1tSp99uPirnBLggb4XITr1AqK
 sc87mknUXcLaDP1Pf2RxcHHvKPEYuMf7KSfzFv6uwWR6j2Xq+SSEeSX70IJRMSAhyU3E3Jl5l8/
 HlIZip6eOnInuM6iLTJJHW1vnGZpeka5Jv7iyK9pQYkXbHL2AlaEpau9s/5SZy1uDmp4ZAPhAc7
 5hag61S5qfUvgsviQ==
X-Google-Smtp-Source: AGHT+IHgSGjim0dz00Sw9dnpcWBuwiwH613Nt7+4/ElLjg9QDVvW3MEznB5/YL7GyOdPOa6TzNOB3GzbeiBbYUEfPEE=
X-Received: by 2002:a17:902:ecc7:b0:253:a668:b638 with SMTP id
 d9443c01a7336-25d240048ddmr1618725ad.2.1757613144875; Thu, 11 Sep 2025
 10:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-2-timur.kristof@gmail.com>
 <26b5d36d-1c9b-4891-962c-ec13b65f02ac@amd.com>
 <a065f044dd629a9863ca18bb0e913d8f9299bedc.camel@gmail.com>
 <32b1c868-8b0d-41fd-94b9-0ebfbc6b3711@amd.com>
 <0d07fe34d3857ece68d29ce21ea2768e43538aa6.camel@gmail.com>
 <a77a5934-afa8-48e5-bb15-a7f55087c245@amd.com>
 <CAAxE2A4ZUG_DLnMpW7yd=pSqnGoyELmxi_u9GveLg1zra82_wg@mail.gmail.com>
 <eff9b0b0-ff7d-490b-b81c-ab866f5a4b14@amd.com>
 <CAAxE2A4HvuAHsuoeaNKVMxsFanR25iNo_THGV=vdyaMT6_qy9A@mail.gmail.com>
 <7c5d463888fdac592ae2631327b05efdd1b29a80.camel@gmail.com>
 <CADnq5_N=4KhqXf2WDZm94Q0hHRdar0g10Dvo_O9uHn=dzDiG4Q@mail.gmail.com>
In-Reply-To: <CADnq5_N=4KhqXf2WDZm94Q0hHRdar0g10Dvo_O9uHn=dzDiG4Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 13:52:13 -0400
X-Gm-Features: Ac12FXyaC4hTZMewR8aJ67vTOKtv0VU2e3EtE1kpq8EM64e6F7DIb2Uc6pC5kMc
Message-ID: <CADnq5_Pt=vuXHp9bH+pxAt20Fyf0+vpHVuxBciVbr1d=WU5PuQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 "Olsak, Marek" <Marek.Olsak@amd.com>
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

On Thu, Sep 11, 2025 at 10:46=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Wed, Sep 10, 2025 at 2:38=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof=
@gmail.com> wrote:
> >
> > On Wed, 2025-09-10 at 11:10 -0400, Marek Ol=C5=A1=C3=A1k wrote:
> > > I added the comment into Mesa that 0x3fff00 is the limit. I did
> > > research on that bug separately from PAL, but I don't remember the
> > > details.
> > >
> > > There is no performance to gain here. It's only about consistency and
> > > clear communication to the public what the recommended SDMA
> > > programming is.
> > >
> > > Marek
> >
> > Hi Christian & Marek,
> >
> > I'd be happy to submit a new patch series if we can agree on what the
> > limits are for each SDMA version and how to get the best performance
> > from it.
> >
> > I trust Marek's word that he did his research when he came up with
> > 0x3fff00 so I don't understand the pushback here.
> >
> > (1) According to a conversation between Marek and myself, the most
> > optimal way to program the SDMA would be to use 256-byte-aligned copy
> > packets. Christian, do you agree with this? If yes, I can write a patch
> > for that. If not, let me know what you would prefer.
> >
> > (2) I'd like us to come to an agreement on the maximum amount of bytes
> > copied per SDMA packet, and align the kernel code with Mesa. At the
> > moment, the maximum limit is different for every SDMA version between
> > the kernel and Mesa, which makes the whole topic super confusing.
> >
> SI didn't have SDMA.  It used the older paging and DMA engine.
> SDMA 2.x used byte_count directly in the packet so the limit is 0x1fffff
> SDMA 3.x used byte_count directly in the packet so the limit is
> 0x3fffe0 or 0x3fff00 depending on alignment.
> SDMA 4.0.x used byte_count -1 in the packet so the limit is 0x400000.
> SDMA 4.4.x used byte_count -1 in the packet and increased the limit to
> 0x4000000.
> SDMA 5.0.x used byte_count -1 in the packet so the limit is 0x400000.
> SDMA 5.2.x and newer used byte_count -1 in the packet and increased
> the limit to 0x4000000.

Sorry I typed these.  There are 22 bits of byte count (0x400000) sdma
4.0.x and 5.0.x, and 30 bits of byte count for sdma 4.4.x and sdma 5.2
and newer (0x40000000).

Alex

>
> Alex
>
> > Please keep in mind that if there is any chance that the current limit
> > is indeed incorrect (as it sounds like it is), we risk "random" SDMA
> > hangs on users' machines.
> >
> > Thanks & best regards,
> > Timur
> >
> >
> >
> >
> > >
> > > On Wed, Sep 10, 2025 at 10:57=E2=80=AFAM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > > > On 10.09.25 16:52, Marek Ol=C5=A1=C3=A1k wrote:
> > > > > It's probably better to use 0x3fff00 to match Mesa and PAL. There
> > > > > is no benefit in using a different limit, not even a perf
> > > > > benefit, and it's better to be consistent with all UMDs.
> > > >
> > > > Unification with Mesa is certainly a valid argument, but just using
> > > > an approach because PAL does it has proven to be troublesome
> > > > before.
> > > >
> > > > If we are interested in best performance we should actually round
> > > > down the value to the next multiple of PAGE_SIZE.
> > > >
> > > > Christian.
> > > >
> > > > >
> > > > > Marek
> > > > >
> > > > > On Wed, Sep 10, 2025 at 7:54=E2=80=AFAM Christian K=C3=B6nig
> > > > > <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
> > > > > wrote:
> > > > >
> > > > >      On 10.09.25 11:34, Timur Krist=C3=B3f wrote:
> > > > >      > On Wed, 2025-09-10 at 10:34 +0200, Christian K=C3=B6nig wr=
ote:
> > > > >      >> On 09.09.25 18:56, Timur Krist=C3=B3f wrote:
> > > > >      >>>> Even when we apply it I think we should drop that, the
> > > > > value the
> > > > >      >>>> kernel uses is correct.
> > > > >      >>>
> > > > >      >>> Hi Christian,
> > > > >      >>>
> > > > >      >>> The kernel and Mesa disagree on the limits for almost
> > > > > all SDMA
> > > > >      >>> versions, so it would be nice to actually understand
> > > > > what the
> > > > >      >>> limits of
> > > > >      >>> the SDMA HW are and use the same limit in the kernel and
> > > > > Mesa, or
> > > > >      >>> if
> > > > >      >>> that isn't viable, let's document why the different
> > > > > limits make
> > > > >      >>> sense.
> > > > >      >>>
> > > > >      >>> I'm adding Marek to CC, he wrote the comment that I
> > > > > referenced
> > > > >      >>> here.
> > > > >      >>> As far as I understand from my conversation with Marek,
> > > > > the kernel
> > > > >      >>> is
> > > > >      >>> actually wrong.
> > > > >      >>>
> > > > >      >>> If the limits depend on alignment, then we should either
> > > > > set a
> > > > >      >>> limit
> > > > >      >>> that is always safe, or make sure SDMA copies in the
> > > > > kernel are
> > > > >      >>> always
> > > > >      >>> aligned and add assertions about it.
> > > > >      >>
> > > > >      >> That's already done. See the size restrictions applied to
> > > > > BOs and the
> > > > >      >> callers of amdgpu_copy_buffer().
> > > > >      >
> > > > >      > Based on the code comments I cited, as far as I
> > > > > understand, the issue
> > > > >      > is with copying the last 256 bytes of 2^22-1. Do I
> > > > > understood your
> > > > >      > response correctly that you are saying that the kernel
> > > > > isn't affected
> > > > >      > by this issue because it always copies things that are 256
> > > > > byte
> > > > >      > aligned?
> > > > >
> > > > >      Yes, see the kernel always works with at least PAGE_SIZE
> > > > > buffers (between 4k and 64k depending on CPU architecture). You
> > > > > never get anything smaller than that.
> > > > >
> > > > >      The only exception is the debugger interface, but that
> > > > > always copies < PAGE_SIZE, so the SDMA limits are irrelevant.
> > > > >
> > > > >      > I checked the callers of amdgpu_copy_buffer and can't find
> > > > > what you are
> > > > >      > referring to. However, assuming that all callers use
> > > > > amdgpu_copy_buffer
> > > > >      > on 256 byte aligned addresses, there is still an issue
> > > > > with large BOs:
> > > > >      >
> > > > >      > When the kernel copies a BO that is larger than 0x3fffe0
> > > > > bytes then it
> > > > >      > needs to emit multiple SDMA copy packets, and the copy
> > > > > done by the
> > > > >      > second packet (and other subsequent packets) won't be 256
> > > > > byte aligned.
> > > > >
> > > > >      I've just double checked the documentation and for SI it
> > > > > clearly states that the limit is 0x3fffe0. Documentation for
> > > > > later HW says 2^22 - 1 - start_addr[4:2] (which is 0x1f in the
> > > > > worst case so you end up with 0x3fffe0 again).
> > > > >
> > > > >      For backward, tiled and windowed copies a 256byte bounce
> > > > > buffer is used instead of the 32byte buffer for the linear copy.
> > > > > So the limit is then 0x3fff00.
> > > > >
> > > > >      Looks like that buffer is also used for byte aligned copies
> > > > > and that limit applies there as well.
> > > > >
> > > > >      >>
> > > > >      >> We could add another warning to amdgpu_copy_buffer(), but
> > > > > that is
> > > > >      >> just the backend function.
> > > > >      >>
> > > > >      >>> Looking at the implementation of
> > > > >      >>> amdgpu_copy_buffer in the kernel, I see that it relies
> > > > > on
> > > > >      >>> copy_max_bytes and doesn't take alignment into account,
> > > > > so with the
> > > > >      >>> current limit it could issue subsequent copies that
> > > > > aren't 256 byte
> > > > >      >>> aligned.
> > > > >      >>
> > > > >      >> "Due to HW limitation, the maximum count may not be 2^n-
> > > > > 1, can only
> > > > >      >> be 2^n - 1 - start_addr[4:2]"
> > > > >      >>
> > > > >      >> Well according to this comments the size restriction is
> > > > > 32 bytes (256
> > > > >      >> bits!) and not 256 bytes.
> > > > >      >>
> > > > >      >> Were do you actually get the 256 bytes restriction from?
> > > > >      >
> > > > >      > The comments I cited above are from the following sources:
> > > > >      >
> > > > >      > PAL uses 1<<22-256 =3D 0x3fff00 here:
> > > > >      >
> > > > > https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486=
a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308
> > > > > <https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d48
> > > > > 6a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#
> > > > > L308>
> > > > >      >
> > > > >      > Mesa also uses 0x3fff00 here:
> > > > >      >
> > > > > https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224=
c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390
> > > > > <https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd3622
> > > > > 4c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390>
> > > > >      >
> > > > >      > The limit in Mesa was added by this commit:
> > > > >      >
> > > > > https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be5=
0222411bc0d41c095004232ed
> > > > > <https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be
> > > > > 50222411bc0d41c095004232ed>
> > > > >      > According to the commit message, Dave added this limit
> > > > > when hitting an
> > > > >      > issue trying to use SDMA with buffers that are larger than
> > > > > this.
> > > > >      >
> > > > >      > For SDMA v5.2 and newer, a larger limit was added by Marek
> > > > > later:
> > > > >      >
> > > > > https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fc=
be38c04660cc4b3f8abbde259
> > > > > <https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666f
> > > > > cbe38c04660cc4b3f8abbde259>
> > > > >      > Which confirms the same issue copying the last 256 bytes
> > > > > on these
> > > > >      > versions, although in this case the kernel isn't
> > > > > technically wrong
> > > > >      > because it uses a smaller overall maximum.
> > > > >
> > > > >      Yeah, I mean that totally makes sense. When you want allow
> > > > > byte aligned copies as well then you have to use 0x3fff00 as
> > > > > maximum.
> > > > >
> > > > >      The PAL code even has extra checks to speed up copies where
> > > > > src and dst are byte aligned, but size isn't:
> > > > >
> > > > >          if (IsPow2Aligned(srcGpuAddr, sizeof(uint32)) &&
> > > > >              IsPow2Aligned(dstGpuAddr, sizeof(uint32)) &&
> > > > >              (*pBytesCopied >=3D sizeof(uint32)))
> > > > >      ....
> > > > >
> > > > >      So it totally makes sense to use the lower limit in Mesa but
> > > > > not for the kernel.
> > > > >
> > > > >      Regards,
> > > > >      Christian.
> > > > >
> > > >

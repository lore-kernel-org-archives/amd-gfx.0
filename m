Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF63ECAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CFB110E38B;
	Thu, 11 Sep 2025 14:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HCiUFNZI";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D007F10E38A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:46:42 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b4fb8d3a2edso39290a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757602002; x=1758206802; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fkck3dvtGAa4jKuCQF2YnyA4z/Pk5JokxiUsKmpzfM0=;
 b=HCiUFNZIbzLEBoZ0ddWoqPHJ2bxJsIYKY8SIIi17GYmXOQqdOSFy2ani4y7WJ/GScC
 8OHq+tmvp0X73acq49kjn6Ii5GBBqxgRVgE1rLWop/iRcH0QtMq1iblO6nkQaxQuUw8f
 uziZDZdHtYQ8ccYpOx/D4Cn/Ql2Uab4BDB3AEglVHttOyNu98c7u2AV9I1ks1/r0Mw5U
 4dulMbTHMuOJ8Ik0o/1XfmFezSSzDl5wF7snEr26k5/sPt2btDd8/ibqRHTC3GQ9dmqY
 UcYMZlUiIRAbb/dI7MlAp9RKzuirHGiusCU8+72Yn2KTczJQix48zcrR41soe8EsmOHy
 LYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757602002; x=1758206802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fkck3dvtGAa4jKuCQF2YnyA4z/Pk5JokxiUsKmpzfM0=;
 b=gQxE8UEVh/FA1hRFaYWix6vUW2coMhSl5joLdI9uyNN1cRlnQmYiF3wyp3MGsMs0uj
 KbiyiAnmi036M/FXXPu5Oa0NdS723+nL6ZsswsNYGBS5L1uG5UI3Ihd8x2yn9qou5Pqa
 rG0oyYUO5kC8xVw5A4kA2SVNht9SzwLOa5Vq9O/qw9HEOaqfRIJIxGCmloZXCDMabdy9
 2N/o/bXtYL/FhLWx+DPDDRN3lYQPkkdNhS1W4RO5h3j+kxfVagJ5Ck++xeiddP/Oyepc
 QAD9sgNLnpawjxHS7VxxauFeXLjZeua56XZvhA46PRmlBaZiesX8febW0TNMwvYg2paE
 QKng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOcIUSVoiBpCDhvjIZEk5SB/OKGpaDUbINPt53RKDuZBPxCJcGKAkwJdH68d5epk05yIpOfLvS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUgyygZ6UYrZOeq/yjU0YYCd4LHZAaVGWflUNE5ueCY1/lxv3Q
 hUZhDSziox1L2ge0wYTP9h4BIYVZ2dcJntKZ3De93JJ16xX//v3ickag6eNQHPOu/BlPNI1Ifdq
 c8t+MSYHbA/uOBdYAwnb5W4ex4uxr0oY=
X-Gm-Gg: ASbGnctSt5ECxnChd+fkLSyi4VEGS4ygYeudwyFScrq6RvlZzfV32ORAfixVVMjOs76
 kfH/o+LVPan4HyWuFLAVp24Aed7oy+VPisNenSv9EZMfbOESujuWS78CYZTAU6fyacRmSLCPR21
 DbbvwIf0gK5ziFb40TfPxkxhIywE3gx6HE6odPBs6VZNpKKnCHQUC6Wf4VfNUaRXje1b9BGlJJJ
 ug5j0U=
X-Google-Smtp-Source: AGHT+IFLCY8znSQ4ZCkiCmxeWC0mgPzywpamvy6kh/tqukbJKzXJ0b5BD+tV6Qq0nFvX0yDJd/j/ICv/zKDaUk1aHjQ=
X-Received: by 2002:a17:902:da8f:b0:24a:8e25:75c5 with SMTP id
 d9443c01a7336-25170678855mr123646145ad.5.1757602002162; Thu, 11 Sep 2025
 07:46:42 -0700 (PDT)
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
In-Reply-To: <7c5d463888fdac592ae2631327b05efdd1b29a80.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 10:46:30 -0400
X-Gm-Features: Ac12FXwo0Vr2qNuwjYcpAt2NFKKduMmHa0fZpTEADRaLngWmOXcImQIPUVPK7FU
Message-ID: <CADnq5_N=4KhqXf2WDZm94Q0hHRdar0g10Dvo_O9uHn=dzDiG4Q@mail.gmail.com>
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

On Wed, Sep 10, 2025 at 2:38=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Wed, 2025-09-10 at 11:10 -0400, Marek Ol=C5=A1=C3=A1k wrote:
> > I added the comment into Mesa that 0x3fff00 is the limit. I did
> > research on that bug separately from PAL, but I don't remember the
> > details.
> >
> > There is no performance to gain here. It's only about consistency and
> > clear communication to the public what the recommended SDMA
> > programming is.
> >
> > Marek
>
> Hi Christian & Marek,
>
> I'd be happy to submit a new patch series if we can agree on what the
> limits are for each SDMA version and how to get the best performance
> from it.
>
> I trust Marek's word that he did his research when he came up with
> 0x3fff00 so I don't understand the pushback here.
>
> (1) According to a conversation between Marek and myself, the most
> optimal way to program the SDMA would be to use 256-byte-aligned copy
> packets. Christian, do you agree with this? If yes, I can write a patch
> for that. If not, let me know what you would prefer.
>
> (2) I'd like us to come to an agreement on the maximum amount of bytes
> copied per SDMA packet, and align the kernel code with Mesa. At the
> moment, the maximum limit is different for every SDMA version between
> the kernel and Mesa, which makes the whole topic super confusing.
>
SI didn't have SDMA.  It used the older paging and DMA engine.
SDMA 2.x used byte_count directly in the packet so the limit is 0x1fffff
SDMA 3.x used byte_count directly in the packet so the limit is
0x3fffe0 or 0x3fff00 depending on alignment.
SDMA 4.0.x used byte_count -1 in the packet so the limit is 0x400000.
SDMA 4.4.x used byte_count -1 in the packet and increased the limit to
0x4000000.
SDMA 5.0.x used byte_count -1 in the packet so the limit is 0x400000.
SDMA 5.2.x and newer used byte_count -1 in the packet and increased
the limit to 0x4000000.

Alex

> Please keep in mind that if there is any chance that the current limit
> is indeed incorrect (as it sounds like it is), we risk "random" SDMA
> hangs on users' machines.
>
> Thanks & best regards,
> Timur
>
>
>
>
> >
> > On Wed, Sep 10, 2025 at 10:57=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> > > On 10.09.25 16:52, Marek Ol=C5=A1=C3=A1k wrote:
> > > > It's probably better to use 0x3fff00 to match Mesa and PAL. There
> > > > is no benefit in using a different limit, not even a perf
> > > > benefit, and it's better to be consistent with all UMDs.
> > >
> > > Unification with Mesa is certainly a valid argument, but just using
> > > an approach because PAL does it has proven to be troublesome
> > > before.
> > >
> > > If we are interested in best performance we should actually round
> > > down the value to the next multiple of PAGE_SIZE.
> > >
> > > Christian.
> > >
> > > >
> > > > Marek
> > > >
> > > > On Wed, Sep 10, 2025 at 7:54=E2=80=AFAM Christian K=C3=B6nig
> > > > <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
> > > > wrote:
> > > >
> > > >      On 10.09.25 11:34, Timur Krist=C3=B3f wrote:
> > > >      > On Wed, 2025-09-10 at 10:34 +0200, Christian K=C3=B6nig wrot=
e:
> > > >      >> On 09.09.25 18:56, Timur Krist=C3=B3f wrote:
> > > >      >>>> Even when we apply it I think we should drop that, the
> > > > value the
> > > >      >>>> kernel uses is correct.
> > > >      >>>
> > > >      >>> Hi Christian,
> > > >      >>>
> > > >      >>> The kernel and Mesa disagree on the limits for almost
> > > > all SDMA
> > > >      >>> versions, so it would be nice to actually understand
> > > > what the
> > > >      >>> limits of
> > > >      >>> the SDMA HW are and use the same limit in the kernel and
> > > > Mesa, or
> > > >      >>> if
> > > >      >>> that isn't viable, let's document why the different
> > > > limits make
> > > >      >>> sense.
> > > >      >>>
> > > >      >>> I'm adding Marek to CC, he wrote the comment that I
> > > > referenced
> > > >      >>> here.
> > > >      >>> As far as I understand from my conversation with Marek,
> > > > the kernel
> > > >      >>> is
> > > >      >>> actually wrong.
> > > >      >>>
> > > >      >>> If the limits depend on alignment, then we should either
> > > > set a
> > > >      >>> limit
> > > >      >>> that is always safe, or make sure SDMA copies in the
> > > > kernel are
> > > >      >>> always
> > > >      >>> aligned and add assertions about it.
> > > >      >>
> > > >      >> That's already done. See the size restrictions applied to
> > > > BOs and the
> > > >      >> callers of amdgpu_copy_buffer().
> > > >      >
> > > >      > Based on the code comments I cited, as far as I
> > > > understand, the issue
> > > >      > is with copying the last 256 bytes of 2^22-1. Do I
> > > > understood your
> > > >      > response correctly that you are saying that the kernel
> > > > isn't affected
> > > >      > by this issue because it always copies things that are 256
> > > > byte
> > > >      > aligned?
> > > >
> > > >      Yes, see the kernel always works with at least PAGE_SIZE
> > > > buffers (between 4k and 64k depending on CPU architecture). You
> > > > never get anything smaller than that.
> > > >
> > > >      The only exception is the debugger interface, but that
> > > > always copies < PAGE_SIZE, so the SDMA limits are irrelevant.
> > > >
> > > >      > I checked the callers of amdgpu_copy_buffer and can't find
> > > > what you are
> > > >      > referring to. However, assuming that all callers use
> > > > amdgpu_copy_buffer
> > > >      > on 256 byte aligned addresses, there is still an issue
> > > > with large BOs:
> > > >      >
> > > >      > When the kernel copies a BO that is larger than 0x3fffe0
> > > > bytes then it
> > > >      > needs to emit multiple SDMA copy packets, and the copy
> > > > done by the
> > > >      > second packet (and other subsequent packets) won't be 256
> > > > byte aligned.
> > > >
> > > >      I've just double checked the documentation and for SI it
> > > > clearly states that the limit is 0x3fffe0. Documentation for
> > > > later HW says 2^22 - 1 - start_addr[4:2] (which is 0x1f in the
> > > > worst case so you end up with 0x3fffe0 again).
> > > >
> > > >      For backward, tiled and windowed copies a 256byte bounce
> > > > buffer is used instead of the 32byte buffer for the linear copy.
> > > > So the limit is then 0x3fff00.
> > > >
> > > >      Looks like that buffer is also used for byte aligned copies
> > > > and that limit applies there as well.
> > > >
> > > >      >>
> > > >      >> We could add another warning to amdgpu_copy_buffer(), but
> > > > that is
> > > >      >> just the backend function.
> > > >      >>
> > > >      >>> Looking at the implementation of
> > > >      >>> amdgpu_copy_buffer in the kernel, I see that it relies
> > > > on
> > > >      >>> copy_max_bytes and doesn't take alignment into account,
> > > > so with the
> > > >      >>> current limit it could issue subsequent copies that
> > > > aren't 256 byte
> > > >      >>> aligned.
> > > >      >>
> > > >      >> "Due to HW limitation, the maximum count may not be 2^n-
> > > > 1, can only
> > > >      >> be 2^n - 1 - start_addr[4:2]"
> > > >      >>
> > > >      >> Well according to this comments the size restriction is
> > > > 32 bytes (256
> > > >      >> bits!) and not 256 bytes.
> > > >      >>
> > > >      >> Were do you actually get the 256 bytes restriction from?
> > > >      >
> > > >      > The comments I cited above are from the following sources:
> > > >      >
> > > >      > PAL uses 1<<22-256 =3D 0x3fff00 here:
> > > >      >
> > > > https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5=
e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308
> > > > <https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d48
> > > > 6a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#
> > > > L308>
> > > >      >
> > > >      > Mesa also uses 0x3fff00 here:
> > > >      >
> > > > https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224c1=
12ee2d48e511ae078f8c2/src/amd/common/sid.h#L390
> > > > <https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd3622
> > > > 4c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390>
> > > >      >
> > > >      > The limit in Mesa was added by this commit:
> > > >      >
> > > > https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be502=
22411bc0d41c095004232ed
> > > > <https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be
> > > > 50222411bc0d41c095004232ed>
> > > >      > According to the commit message, Dave added this limit
> > > > when hitting an
> > > >      > issue trying to use SDMA with buffers that are larger than
> > > > this.
> > > >      >
> > > >      > For SDMA v5.2 and newer, a larger limit was added by Marek
> > > > later:
> > > >      >
> > > > https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe=
38c04660cc4b3f8abbde259
> > > > <https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666f
> > > > cbe38c04660cc4b3f8abbde259>
> > > >      > Which confirms the same issue copying the last 256 bytes
> > > > on these
> > > >      > versions, although in this case the kernel isn't
> > > > technically wrong
> > > >      > because it uses a smaller overall maximum.
> > > >
> > > >      Yeah, I mean that totally makes sense. When you want allow
> > > > byte aligned copies as well then you have to use 0x3fff00 as
> > > > maximum.
> > > >
> > > >      The PAL code even has extra checks to speed up copies where
> > > > src and dst are byte aligned, but size isn't:
> > > >
> > > >          if (IsPow2Aligned(srcGpuAddr, sizeof(uint32)) &&
> > > >              IsPow2Aligned(dstGpuAddr, sizeof(uint32)) &&
> > > >              (*pBytesCopied >=3D sizeof(uint32)))
> > > >      ....
> > > >
> > > >      So it totally makes sense to use the lower limit in Mesa but
> > > > not for the kernel.
> > > >
> > > >      Regards,
> > > >      Christian.
> > > >
> > >

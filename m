Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76936CAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 18:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF3D10EB79;
	Thu, 11 Sep 2025 18:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hSNVT4EF";
	dkim-atps=neutral
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A301B10E097
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 18:17:42 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-74599a9531aso322248a34.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757614662; x=1758219462; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vrZp5pRSG0rm6W332wUBdfwTahiVK6dKoVayP2lf90I=;
 b=hSNVT4EFxOA2M3SGNgRJ0EdeqYCT2cfl7p61KKLcXTIk2EvK+Mnkp33C57q7Icj0Cj
 UZoQEKgPNXMh2U4BWyq3h9t5zPSlwBSxd5mFROZF2DfR8cgiXm4AeXYorP8Qyf/c/flL
 sTSasC7E1R9joDErI7FoiwGMGAXyl3UIWXh7P4bwOpAPPuTVmSB0fhj4kVNz3uav03O4
 Im3qGc+zETWjkzqcpBk3O6PKJ9nbWyWr4QxEB04bgu1mckJIeK+y5U/B2bmFQpOowSYl
 bFk69I0dkX/5kpMdMcNqV4I5vYg2VFIdTB9TEskvkiDL2l3185izT8HGe5a1ixbBswL2
 p97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757614662; x=1758219462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vrZp5pRSG0rm6W332wUBdfwTahiVK6dKoVayP2lf90I=;
 b=RzvaboJLtBJnIT08VsYDQDmcKSIPdzwZy83i8kS5Fa4Uqp3pB4Za1ccHdYFINhIYEu
 iht1HKzpJSwkiSfs/xIylh2SzjJkoZTnXx0fpXaGvdR2g7YTf3uyx1rV8izKFTaotgEG
 jJMLB51CLlblFv4cW6h6Ai7s1MtC82YGa8boYot80NliVjjgyZpwDzMB94IZQ+riS+MX
 2BxpDT0Vp4vO4MquBQyOifdBlR+8S0S1CjX6t5gdfKCnxTeOgdFutDzzrG06DlGdtM1Q
 H3h+WdgXqIvqhctYtuOdhtOOwCaST2n1RNwXoacQGfWkrZyiZSg45hbhzFaKB52Yz0hy
 gxUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr6azfuTFcm1z50OT/8QwsMVarBX+KUhyKStpeDDxFzhOU/YLS6+fw3cz+wki2Eelb+fIKyiFA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeoyYZ6Vo3I9K5/CMCeLEzXeh+gNCx0CVxM1etgUnQaPfgbvVn
 Ybi3OzUyLWItt74Fj57ZpUnsuoPvWmCwS56OfPslfDAynjdn/r6xDXv4I9CPutXXuRK9Ys4Z0EE
 ocJXjhd53rg+5gWhSzbPg221uHHkpvkA=
X-Gm-Gg: ASbGncufMgKiAK9YQhy6ywUjknjrmddhJ3SaSbXkPq/GjxZMClX0rk25fxD14vKcPbe
 pB7NRFY5AWuihbCJGtzi1P4iR4KR8Pt6PRmiVILzSPdULJ0enLQ+tk/zzgK3obYg6iu8piJWJDz
 h/s3mthZ4ymfG2rV1BqP9xgy94yaPKIwZNuJVaa7cQ3T45qVrv9aJZsKsi6Qy1N9BWSnV2X1VT3
 B0nJNaHt/dyPb/2fAZMZFq768KvcS10VtLnW4x/
X-Google-Smtp-Source: AGHT+IHiUMcVuUwVVAFjGRI2lcOPpibrfZmZH4WoDXecmtKoDB+kkRu8BNBLTpIS5Ajex+QKFrLvEzMNUfCJXz4GeJg=
X-Received: by 2002:a05:6820:81d1:b0:621:aaa2:3724 with SMTP id
 006d021491bc7-621beced3b1mr113480eaf.2.1757614661498; Thu, 11 Sep 2025
 11:17:41 -0700 (PDT)
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
 <CADnq5_Pt=vuXHp9bH+pxAt20Fyf0+vpHVuxBciVbr1d=WU5PuQ@mail.gmail.com>
In-Reply-To: <CADnq5_Pt=vuXHp9bH+pxAt20Fyf0+vpHVuxBciVbr1d=WU5PuQ@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 11 Sep 2025 14:17:29 -0400
X-Gm-Features: Ac12FXwsKLRwZfopLyu_AP9dZviCybPCfs8xNB-mPxD6b1rxy02gH0Ud1UNplT4
Message-ID: <CAAxE2A7PnOL8yaj7L4a2oKAp=0WKBcUVaLObuMb+TmVuY=72Qw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>
Content-Type: multipart/alternative; boundary="0000000000008cfcb0063e8a8de2"
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

--0000000000008cfcb0063e8a8de2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The optimal alignment for performance would be 256B because that's the
granularity of interleaving memory channels if you care about not
overloading one memory channel on the packet break. In other cases, like
gfx10 and newer, the next optimal alignment is 128B because that's the
cache line size, which is the maximum request size. If uncached, the next
optimal alignment is the minimum memory request size, which is 32B or 64B.

Since the kernel likely copies with VMID 0, the page table alignment
doesn't even enter the picture, though it would be cheap because it would
be a UTCL2 cache hit.

Marek

On Thu, Sep 11, 2025, 13:52 Alex Deucher <alexdeucher@gmail.com> wrote:

> On Thu, Sep 11, 2025 at 10:46=E2=80=AFAM Alex Deucher <alexdeucher@gmail.=
com>
> wrote:
> >
> > On Wed, Sep 10, 2025 at 2:38=E2=80=AFPM Timur Krist=C3=B3f <timur.krist=
of@gmail.com>
> wrote:
> > >
> > > On Wed, 2025-09-10 at 11:10 -0400, Marek Ol=C5=A1=C3=A1k wrote:
> > > > I added the comment into Mesa that 0x3fff00 is the limit. I did
> > > > research on that bug separately from PAL, but I don't remember the
> > > > details.
> > > >
> > > > There is no performance to gain here. It's only about consistency a=
nd
> > > > clear communication to the public what the recommended SDMA
> > > > programming is.
> > > >
> > > > Marek
> > >
> > > Hi Christian & Marek,
> > >
> > > I'd be happy to submit a new patch series if we can agree on what the
> > > limits are for each SDMA version and how to get the best performance
> > > from it.
> > >
> > > I trust Marek's word that he did his research when he came up with
> > > 0x3fff00 so I don't understand the pushback here.
> > >
> > > (1) According to a conversation between Marek and myself, the most
> > > optimal way to program the SDMA would be to use 256-byte-aligned copy
> > > packets. Christian, do you agree with this? If yes, I can write a pat=
ch
> > > for that. If not, let me know what you would prefer.
> > >
> > > (2) I'd like us to come to an agreement on the maximum amount of byte=
s
> > > copied per SDMA packet, and align the kernel code with Mesa. At the
> > > moment, the maximum limit is different for every SDMA version between
> > > the kernel and Mesa, which makes the whole topic super confusing.
> > >
> > SI didn't have SDMA.  It used the older paging and DMA engine.
> > SDMA 2.x used byte_count directly in the packet so the limit is 0x1ffff=
f
> > SDMA 3.x used byte_count directly in the packet so the limit is
> > 0x3fffe0 or 0x3fff00 depending on alignment.
> > SDMA 4.0.x used byte_count -1 in the packet so the limit is 0x400000.
> > SDMA 4.4.x used byte_count -1 in the packet and increased the limit to
> > 0x4000000.
> > SDMA 5.0.x used byte_count -1 in the packet so the limit is 0x400000.
> > SDMA 5.2.x and newer used byte_count -1 in the packet and increased
> > the limit to 0x4000000.
>
> Sorry I typed these.  There are 22 bits of byte count (0x400000) sdma
> 4.0.x and 5.0.x, and 30 bits of byte count for sdma 4.4.x and sdma 5.2
> and newer (0x40000000).
>
> Alex
>
> >
> > Alex
> >
> > > Please keep in mind that if there is any chance that the current limi=
t
> > > is indeed incorrect (as it sounds like it is), we risk "random" SDMA
> > > hangs on users' machines.
> > >
> > > Thanks & best regards,
> > > Timur
> > >
> > >
> > >
> > >
> > > >
> > > > On Wed, Sep 10, 2025 at 10:57=E2=80=AFAM Christian K=C3=B6nig
> > > > <christian.koenig@amd.com> wrote:
> > > > > On 10.09.25 16:52, Marek Ol=C5=A1=C3=A1k wrote:
> > > > > > It's probably better to use 0x3fff00 to match Mesa and PAL. The=
re
> > > > > > is no benefit in using a different limit, not even a perf
> > > > > > benefit, and it's better to be consistent with all UMDs.
> > > > >
> > > > > Unification with Mesa is certainly a valid argument, but just usi=
ng
> > > > > an approach because PAL does it has proven to be troublesome
> > > > > before.
> > > > >
> > > > > If we are interested in best performance we should actually round
> > > > > down the value to the next multiple of PAGE_SIZE.
> > > > >
> > > > > Christian.
> > > > >
> > > > > >
> > > > > > Marek
> > > > > >
> > > > > > On Wed, Sep 10, 2025 at 7:54=E2=80=AFAM Christian K=C3=B6nig
> > > > > > <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
> > > > > > wrote:
> > > > > >
> > > > > >      On 10.09.25 11:34, Timur Krist=C3=B3f wrote:
> > > > > >      > On Wed, 2025-09-10 at 10:34 +0200, Christian K=C3=B6nig =
wrote:
> > > > > >      >> On 09.09.25 18:56, Timur Krist=C3=B3f wrote:
> > > > > >      >>>> Even when we apply it I think we should drop that, th=
e
> > > > > > value the
> > > > > >      >>>> kernel uses is correct.
> > > > > >      >>>
> > > > > >      >>> Hi Christian,
> > > > > >      >>>
> > > > > >      >>> The kernel and Mesa disagree on the limits for almost
> > > > > > all SDMA
> > > > > >      >>> versions, so it would be nice to actually understand
> > > > > > what the
> > > > > >      >>> limits of
> > > > > >      >>> the SDMA HW are and use the same limit in the kernel a=
nd
> > > > > > Mesa, or
> > > > > >      >>> if
> > > > > >      >>> that isn't viable, let's document why the different
> > > > > > limits make
> > > > > >      >>> sense.
> > > > > >      >>>
> > > > > >      >>> I'm adding Marek to CC, he wrote the comment that I
> > > > > > referenced
> > > > > >      >>> here.
> > > > > >      >>> As far as I understand from my conversation with Marek=
,
> > > > > > the kernel
> > > > > >      >>> is
> > > > > >      >>> actually wrong.
> > > > > >      >>>
> > > > > >      >>> If the limits depend on alignment, then we should eith=
er
> > > > > > set a
> > > > > >      >>> limit
> > > > > >      >>> that is always safe, or make sure SDMA copies in the
> > > > > > kernel are
> > > > > >      >>> always
> > > > > >      >>> aligned and add assertions about it.
> > > > > >      >>
> > > > > >      >> That's already done. See the size restrictions applied =
to
> > > > > > BOs and the
> > > > > >      >> callers of amdgpu_copy_buffer().
> > > > > >      >
> > > > > >      > Based on the code comments I cited, as far as I
> > > > > > understand, the issue
> > > > > >      > is with copying the last 256 bytes of 2^22-1. Do I
> > > > > > understood your
> > > > > >      > response correctly that you are saying that the kernel
> > > > > > isn't affected
> > > > > >      > by this issue because it always copies things that are 2=
56
> > > > > > byte
> > > > > >      > aligned?
> > > > > >
> > > > > >      Yes, see the kernel always works with at least PAGE_SIZE
> > > > > > buffers (between 4k and 64k depending on CPU architecture). You
> > > > > > never get anything smaller than that.
> > > > > >
> > > > > >      The only exception is the debugger interface, but that
> > > > > > always copies < PAGE_SIZE, so the SDMA limits are irrelevant.
> > > > > >
> > > > > >      > I checked the callers of amdgpu_copy_buffer and can't fi=
nd
> > > > > > what you are
> > > > > >      > referring to. However, assuming that all callers use
> > > > > > amdgpu_copy_buffer
> > > > > >      > on 256 byte aligned addresses, there is still an issue
> > > > > > with large BOs:
> > > > > >      >
> > > > > >      > When the kernel copies a BO that is larger than 0x3fffe0
> > > > > > bytes then it
> > > > > >      > needs to emit multiple SDMA copy packets, and the copy
> > > > > > done by the
> > > > > >      > second packet (and other subsequent packets) won't be 25=
6
> > > > > > byte aligned.
> > > > > >
> > > > > >      I've just double checked the documentation and for SI it
> > > > > > clearly states that the limit is 0x3fffe0. Documentation for
> > > > > > later HW says 2^22 - 1 - start_addr[4:2] (which is 0x1f in the
> > > > > > worst case so you end up with 0x3fffe0 again).
> > > > > >
> > > > > >      For backward, tiled and windowed copies a 256byte bounce
> > > > > > buffer is used instead of the 32byte buffer for the linear copy=
.
> > > > > > So the limit is then 0x3fff00.
> > > > > >
> > > > > >      Looks like that buffer is also used for byte aligned copie=
s
> > > > > > and that limit applies there as well.
> > > > > >
> > > > > >      >>
> > > > > >      >> We could add another warning to amdgpu_copy_buffer(), b=
ut
> > > > > > that is
> > > > > >      >> just the backend function.
> > > > > >      >>
> > > > > >      >>> Looking at the implementation of
> > > > > >      >>> amdgpu_copy_buffer in the kernel, I see that it relies
> > > > > > on
> > > > > >      >>> copy_max_bytes and doesn't take alignment into account=
,
> > > > > > so with the
> > > > > >      >>> current limit it could issue subsequent copies that
> > > > > > aren't 256 byte
> > > > > >      >>> aligned.
> > > > > >      >>
> > > > > >      >> "Due to HW limitation, the maximum count may not be 2^n=
-
> > > > > > 1, can only
> > > > > >      >> be 2^n - 1 - start_addr[4:2]"
> > > > > >      >>
> > > > > >      >> Well according to this comments the size restriction is
> > > > > > 32 bytes (256
> > > > > >      >> bits!) and not 256 bytes.
> > > > > >      >>
> > > > > >      >> Were do you actually get the 256 bytes restriction from=
?
> > > > > >      >
> > > > > >      > The comments I cited above are from the following source=
s:
> > > > > >      >
> > > > > >      > PAL uses 1<<22-256 =3D 0x3fff00 here:
> > > > > >      >
> > > > > >
> https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c=
549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308
> > > > > > <
> https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d48
> > > > > > 6a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cp=
p#
> > > > > > L308>
> > > > > >      >
> > > > > >      > Mesa also uses 0x3fff00 here:
> > > > > >      >
> > > > > >
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224c112ee2d=
48e511ae078f8c2/src/amd/common/sid.h#L390
> > > > > > <
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd3622
> > > > > > 4c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390>
> > > > > >      >
> > > > > >      > The limit in Mesa was added by this commit:
> > > > > >      >
> > > > > >
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222411b=
c0d41c095004232ed
> > > > > > <
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be
> > > > > > 50222411bc0d41c095004232ed>
> > > > > >      > According to the commit message, Dave added this limit
> > > > > > when hitting an
> > > > > >      > issue trying to use SDMA with buffers that are larger th=
an
> > > > > > this.
> > > > > >      >
> > > > > >      > For SDMA v5.2 and newer, a larger limit was added by Mar=
ek
> > > > > > later:
> > > > > >      >
> > > > > >
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38c046=
60cc4b3f8abbde259
> > > > > > <
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666f
> > > > > > cbe38c04660cc4b3f8abbde259>
> > > > > >      > Which confirms the same issue copying the last 256 bytes
> > > > > > on these
> > > > > >      > versions, although in this case the kernel isn't
> > > > > > technically wrong
> > > > > >      > because it uses a smaller overall maximum.
> > > > > >
> > > > > >      Yeah, I mean that totally makes sense. When you want allow
> > > > > > byte aligned copies as well then you have to use 0x3fff00 as
> > > > > > maximum.
> > > > > >
> > > > > >      The PAL code even has extra checks to speed up copies wher=
e
> > > > > > src and dst are byte aligned, but size isn't:
> > > > > >
> > > > > >          if (IsPow2Aligned(srcGpuAddr, sizeof(uint32)) &&
> > > > > >              IsPow2Aligned(dstGpuAddr, sizeof(uint32)) &&
> > > > > >              (*pBytesCopied >=3D sizeof(uint32)))
> > > > > >      ....
> > > > > >
> > > > > >      So it totally makes sense to use the lower limit in Mesa b=
ut
> > > > > > not for the kernel.
> > > > > >
> > > > > >      Regards,
> > > > > >      Christian.
> > > > > >
> > > > >
>

--0000000000008cfcb0063e8a8de2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">The optimal alignment for performance would be 256B becau=
se that&#39;s the granularity of interleaving memory channels if you care a=
bout not overloading one memory channel on the packet break. In other cases=
, like gfx10 and newer, the next optimal alignment is 128B because that&#39=
;s the cache line size, which is the maximum request size. If uncached, the=
 next optimal alignment is the minimum memory request size, which is 32B or=
 64B.<div dir=3D"auto"><br></div><div dir=3D"auto">Since the kernel likely =
copies with VMID 0, the page table alignment doesn&#39;t even enter the pic=
ture, though it would be cheap because it would be a UTCL2 cache hit.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Marek</div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Sep 11, 2025, 13:52 Alex Deucher &lt;<a href=3D"mailto:alexdeuc=
her@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">On Thu, Sep 11, 2025 at 10:46=E2=80=AFAM Alex Deucher &lt;=
<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank" rel=3D"noreferre=
r">alexdeucher@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, Sep 10, 2025 at 2:38=E2=80=AFPM Timur Krist=C3=B3f &lt;<a href=
=3D"mailto:timur.kristof@gmail.com" target=3D"_blank" rel=3D"noreferrer">ti=
mur.kristof@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Wed, 2025-09-10 at 11:10 -0400, Marek Ol=C5=A1=C3=A1k wrote:<b=
r>
&gt; &gt; &gt; I added the comment into Mesa that 0x3fff00 is the limit. I =
did<br>
&gt; &gt; &gt; research on that bug separately from PAL, but I don&#39;t re=
member the<br>
&gt; &gt; &gt; details.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There is no performance to gain here. It&#39;s only about co=
nsistency and<br>
&gt; &gt; &gt; clear communication to the public what the recommended SDMA<=
br>
&gt; &gt; &gt; programming is.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Marek<br>
&gt; &gt;<br>
&gt; &gt; Hi Christian &amp; Marek,<br>
&gt; &gt;<br>
&gt; &gt; I&#39;d be happy to submit a new patch series if we can agree on =
what the<br>
&gt; &gt; limits are for each SDMA version and how to get the best performa=
nce<br>
&gt; &gt; from it.<br>
&gt; &gt;<br>
&gt; &gt; I trust Marek&#39;s word that he did his research when he came up=
 with<br>
&gt; &gt; 0x3fff00 so I don&#39;t understand the pushback here.<br>
&gt; &gt;<br>
&gt; &gt; (1) According to a conversation between Marek and myself, the mos=
t<br>
&gt; &gt; optimal way to program the SDMA would be to use 256-byte-aligned =
copy<br>
&gt; &gt; packets. Christian, do you agree with this? If yes, I can write a=
 patch<br>
&gt; &gt; for that. If not, let me know what you would prefer.<br>
&gt; &gt;<br>
&gt; &gt; (2) I&#39;d like us to come to an agreement on the maximum amount=
 of bytes<br>
&gt; &gt; copied per SDMA packet, and align the kernel code with Mesa. At t=
he<br>
&gt; &gt; moment, the maximum limit is different for every SDMA version bet=
ween<br>
&gt; &gt; the kernel and Mesa, which makes the whole topic super confusing.=
<br>
&gt; &gt;<br>
&gt; SI didn&#39;t have SDMA.=C2=A0 It used the older paging and DMA engine=
.<br>
&gt; SDMA 2.x used byte_count directly in the packet so the limit is 0x1fff=
ff<br>
&gt; SDMA 3.x used byte_count directly in the packet so the limit is<br>
&gt; 0x3fffe0 or 0x3fff00 depending on alignment.<br>
&gt; SDMA 4.0.x used byte_count -1 in the packet so the limit is 0x400000.<=
br>
&gt; SDMA 4.4.x used byte_count -1 in the packet and increased the limit to=
<br>
&gt; 0x4000000.<br>
&gt; SDMA 5.0.x used byte_count -1 in the packet so the limit is 0x400000.<=
br>
&gt; SDMA 5.2.x and newer used byte_count -1 in the packet and increased<br=
>
&gt; the limit to 0x4000000.<br>
<br>
Sorry I typed these.=C2=A0 There are 22 bits of byte count (0x400000) sdma<=
br>
4.0.x and 5.0.x, and 30 bits of byte count for sdma 4.4.x and sdma 5.2<br>
and newer (0x40000000).<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; &gt; Please keep in mind that if there is any chance that the current =
limit<br>
&gt; &gt; is indeed incorrect (as it sounds like it is), we risk &quot;rand=
om&quot; SDMA<br>
&gt; &gt; hangs on users&#39; machines.<br>
&gt; &gt;<br>
&gt; &gt; Thanks &amp; best regards,<br>
&gt; &gt; Timur<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Sep 10, 2025 at 10:57=E2=80=AFAM Christian K=C3=B6ni=
g<br>
&gt; &gt; &gt; &lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_b=
lank" rel=3D"noreferrer">christian.koenig@amd.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; On 10.09.25 16:52, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; &gt; &gt; &gt; &gt; It&#39;s probably better to use 0x3fff00 to match =
Mesa and PAL. There<br>
&gt; &gt; &gt; &gt; &gt; is no benefit in using a different limit, not even=
 a perf<br>
&gt; &gt; &gt; &gt; &gt; benefit, and it&#39;s better to be consistent with=
 all UMDs.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Unification with Mesa is certainly a valid argument, bu=
t just using<br>
&gt; &gt; &gt; &gt; an approach because PAL does it has proven to be troubl=
esome<br>
&gt; &gt; &gt; &gt; before.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; If we are interested in best performance we should actu=
ally round<br>
&gt; &gt; &gt; &gt; down the value to the next multiple of PAGE_SIZE.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Christian.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Marek<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Wed, Sep 10, 2025 at 7:54=E2=80=AFAM Christian =
K=C3=B6nig<br>
&gt; &gt; &gt; &gt; &gt; &lt;<a href=3D"mailto:christian.koenig@amd.com" ta=
rget=3D"_blank" rel=3D"noreferrer">christian.koenig@amd.com</a> &lt;mailto:=
<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank" rel=3D"norefe=
rrer">christian.koenig@amd.com</a>&gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 On 10.09.25 11:34, Timur Krist=
=C3=B3f wrote:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Wed, 2025-09-10 at 10:=
34 +0200, Christian K=C3=B6nig wrote:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; On 09.09.25 18:56, Ti=
mur Krist=C3=B3f wrote:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; Even when we =
apply it I think we should drop that, the<br>
&gt; &gt; &gt; &gt; &gt; value the<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; kernel uses i=
s correct.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Hi Christian,<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; The kernel and Me=
sa disagree on the limits for almost<br>
&gt; &gt; &gt; &gt; &gt; all SDMA<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; versions, so it w=
ould be nice to actually understand<br>
&gt; &gt; &gt; &gt; &gt; what the<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; limits of<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; the SDMA HW are a=
nd use the same limit in the kernel and<br>
&gt; &gt; &gt; &gt; &gt; Mesa, or<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; if<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; that isn&#39;t vi=
able, let&#39;s document why the different<br>
&gt; &gt; &gt; &gt; &gt; limits make<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; sense.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; I&#39;m adding Ma=
rek to CC, he wrote the comment that I<br>
&gt; &gt; &gt; &gt; &gt; referenced<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; here.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; As far as I under=
stand from my conversation with Marek,<br>
&gt; &gt; &gt; &gt; &gt; the kernel<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; is<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; actually wrong.<b=
r>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; If the limits dep=
end on alignment, then we should either<br>
&gt; &gt; &gt; &gt; &gt; set a<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; limit<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; that is always sa=
fe, or make sure SDMA copies in the<br>
&gt; &gt; &gt; &gt; &gt; kernel are<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; always<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; aligned and add a=
ssertions about it.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; That&#39;s already do=
ne. See the size restrictions applied to<br>
&gt; &gt; &gt; &gt; &gt; BOs and the<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; callers of amdgpu_cop=
y_buffer().<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Based on the code comment=
s I cited, as far as I<br>
&gt; &gt; &gt; &gt; &gt; understand, the issue<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; is with copying the last =
256 bytes of 2^22-1. Do I<br>
&gt; &gt; &gt; &gt; &gt; understood your<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; response correctly that y=
ou are saying that the kernel<br>
&gt; &gt; &gt; &gt; &gt; isn&#39;t affected<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; by this issue because it =
always copies things that are 256<br>
&gt; &gt; &gt; &gt; &gt; byte<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; aligned?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Yes, see the kernel always wor=
ks with at least PAGE_SIZE<br>
&gt; &gt; &gt; &gt; &gt; buffers (between 4k and 64k depending on CPU archi=
tecture). You<br>
&gt; &gt; &gt; &gt; &gt; never get anything smaller than that.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 The only exception is the debu=
gger interface, but that<br>
&gt; &gt; &gt; &gt; &gt; always copies &lt; PAGE_SIZE, so the SDMA limits a=
re irrelevant.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I checked the callers of =
amdgpu_copy_buffer and can&#39;t find<br>
&gt; &gt; &gt; &gt; &gt; what you are<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; referring to. However, as=
suming that all callers use<br>
&gt; &gt; &gt; &gt; &gt; amdgpu_copy_buffer<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; on 256 byte aligned addre=
sses, there is still an issue<br>
&gt; &gt; &gt; &gt; &gt; with large BOs:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; When the kernel copies a =
BO that is larger than 0x3fffe0<br>
&gt; &gt; &gt; &gt; &gt; bytes then it<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; needs to emit multiple SD=
MA copy packets, and the copy<br>
&gt; &gt; &gt; &gt; &gt; done by the<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; second packet (and other =
subsequent packets) won&#39;t be 256<br>
&gt; &gt; &gt; &gt; &gt; byte aligned.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 I&#39;ve just double checked t=
he documentation and for SI it<br>
&gt; &gt; &gt; &gt; &gt; clearly states that the limit is 0x3fffe0. Documen=
tation for<br>
&gt; &gt; &gt; &gt; &gt; later HW says 2^22 - 1 - start_addr[4:2] (which is=
 0x1f in the<br>
&gt; &gt; &gt; &gt; &gt; worst case so you end up with 0x3fffe0 again).<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 For backward, tiled and window=
ed copies a 256byte bounce<br>
&gt; &gt; &gt; &gt; &gt; buffer is used instead of the 32byte buffer for th=
e linear copy.<br>
&gt; &gt; &gt; &gt; &gt; So the limit is then 0x3fff00.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Looks like that buffer is also=
 used for byte aligned copies<br>
&gt; &gt; &gt; &gt; &gt; and that limit applies there as well.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; We could add another =
warning to amdgpu_copy_buffer(), but<br>
&gt; &gt; &gt; &gt; &gt; that is<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; just the backend func=
tion.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Looking at the im=
plementation of<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; amdgpu_copy_buffe=
r in the kernel, I see that it relies<br>
&gt; &gt; &gt; &gt; &gt; on<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; copy_max_bytes an=
d doesn&#39;t take alignment into account,<br>
&gt; &gt; &gt; &gt; &gt; so with the<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; current limit it =
could issue subsequent copies that<br>
&gt; &gt; &gt; &gt; &gt; aren&#39;t 256 byte<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; aligned.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; &quot;Due to HW limit=
ation, the maximum count may not be 2^n-<br>
&gt; &gt; &gt; &gt; &gt; 1, can only<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; be 2^n - 1 - start_ad=
dr[4:2]&quot;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Well according to thi=
s comments the size restriction is<br>
&gt; &gt; &gt; &gt; &gt; 32 bytes (256<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; bits!) and not 256 by=
tes.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Were do you actually =
get the 256 bytes restriction from?<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; The comments I cited abov=
e are from the following sources:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; PAL uses 1&lt;&lt;22-256 =
=3D 0x3fff00 here:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"https://github.com/GPUOpen-Drivers/pal/=
blob/bcec463efe5260776d486a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2Dm=
aCmdBuffer.cpp#L308" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c549bc0a7=
5d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308</a><br>
&gt; &gt; &gt; &gt; &gt; &lt;<a href=3D"https://github.com/GPUOpen-Drivers/=
pal/blob/bcec463efe5260776d48" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d48</a><br=
>
&gt; &gt; &gt; &gt; &gt; 6a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2Dm=
aCmdBuffer.cpp#<br>
&gt; &gt; &gt; &gt; &gt; L308&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Mesa also uses 0x3fff00 h=
ere:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"https://gitlab.freedesktop.org/mesa/mes=
a/-/blob/47f5d25f93fd36224c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.freedeskto=
p.org/mesa/mesa/-/blob/47f5d25f93fd36224c112ee2d48e511ae078f8c2/src/amd/com=
mon/sid.h#L390</a><br>
&gt; &gt; &gt; &gt; &gt; &lt;<a href=3D"https://gitlab.freedesktop.org/mesa=
/mesa/-/blob/47f5d25f93fd3622" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd3622</a><br=
>
&gt; &gt; &gt; &gt; &gt; 4c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390=
&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; The limit in Mesa was add=
ed by this commit:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"https://gitlab.freedesktop.org/mesa/mes=
a/-/commit/2c1f249f2b61be50222411bc0d41c095004232ed" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa/-/commit=
/2c1f249f2b61be50222411bc0d41c095004232ed</a><br>
&gt; &gt; &gt; &gt; &gt; &lt;<a href=3D"https://gitlab.freedesktop.org/mesa=
/mesa/-/commit/2c1f249f2b61be" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be</a><br=
>
&gt; &gt; &gt; &gt; &gt; 50222411bc0d41c095004232ed&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; According to the commit m=
essage, Dave added this limit<br>
&gt; &gt; &gt; &gt; &gt; when hitting an<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; issue trying to use SDMA =
with buffers that are larger than<br>
&gt; &gt; &gt; &gt; &gt; this.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; For SDMA v5.2 and newer, =
a larger limit was added by Marek<br>
&gt; &gt; &gt; &gt; &gt; later:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"https://gitlab.freedesktop.org/mesa/mes=
a/-/commit/a54bcb9429666fcbe38c04660cc4b3f8abbde259" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa/-/commit=
/a54bcb9429666fcbe38c04660cc4b3f8abbde259</a><br>
&gt; &gt; &gt; &gt; &gt; &lt;<a href=3D"https://gitlab.freedesktop.org/mesa=
/mesa/-/commit/a54bcb9429666f" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666f</a><br=
>
&gt; &gt; &gt; &gt; &gt; cbe38c04660cc4b3f8abbde259&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Which confirms the same i=
ssue copying the last 256 bytes<br>
&gt; &gt; &gt; &gt; &gt; on these<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; versions, although in thi=
s case the kernel isn&#39;t<br>
&gt; &gt; &gt; &gt; &gt; technically wrong<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; because it uses a smaller=
 overall maximum.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Yeah, I mean that totally make=
s sense. When you want allow<br>
&gt; &gt; &gt; &gt; &gt; byte aligned copies as well then you have to use 0=
x3fff00 as<br>
&gt; &gt; &gt; &gt; &gt; maximum.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 The PAL code even has extra ch=
ecks to speed up copies where<br>
&gt; &gt; &gt; &gt; &gt; src and dst are byte aligned, but size isn&#39;t:<=
br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IsPow2Aligne=
d(srcGpuAddr, sizeof(uint32)) &amp;&amp;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Is=
Pow2Aligned(dstGpuAddr, sizeof(uint32)) &amp;&amp;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*=
pBytesCopied &gt;=3D sizeof(uint32)))<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 ....<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 So it totally makes sense to u=
se the lower limit in Mesa but<br>
&gt; &gt; &gt; &gt; &gt; not for the kernel.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Regards,<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Christian.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
</blockquote></div>

--0000000000008cfcb0063e8a8de2--

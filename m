Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A056CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 18:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E36210E9B9;
	Wed, 10 Sep 2025 18:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hUa6z1el";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E349610E9BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 18:38:16 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7723f0924a3so9486855b3a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757529496; x=1758134296; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fL4hZHDdfgOk1aP7LE0pW0a5zCT4VcoQA7NE7uCznYg=;
 b=hUa6z1el7gpVJbeug/RKvHsZXbgbA+g0l2/kxENOymtZDf+1Yy3Y9gUtJnjz5TyGip
 FrGihZD05mTCXxZsQeyQflCCOqi9x8XvQ9WyV2dsD9L4Gh4VU/EP6VZE8+qHEbPBUiS9
 hwGW868yRCkymzAYBtq4ejw839RcDpgtRHu6j+Z9+UCGRl1mClEm8so/cQlQx+pjaVUV
 /gLFwzIdXjL5e+CNLgysgtQIEGPDv4ythVNvBQH/Fz5abYQf6oLc/5xoG2bNQcHBqNQ0
 QiqN+6LZSCdz9WgRwFAr6VMnltP1gfFx3bDLZIYxmdhXWuvygRaqG3OF16qpvp55TRH2
 osrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757529496; x=1758134296;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fL4hZHDdfgOk1aP7LE0pW0a5zCT4VcoQA7NE7uCznYg=;
 b=onfjxXnQ00TTr/UPkbkphxEuGUWMSZNOXRiXmSxVWxatRYBdJvYE5cY2p6297SBFMG
 xch0IdTtfB1Xldrdsbg4CUhHBz8wvvUiWAPiPtWPjn7f2hZtqPAGY3zOOo/ggbgV2J+1
 CerC01tPlmhMnU38zzut70EDB/vGEs6rlqGhuN/v+/yM2DnXKDWmyYFiLE7nZkjZgxzP
 KGHGXPTbyWxQAzuNM5fu4JqifhunfxC1j+zMRcFWfNOK3vi4vo9G9TdZ42X2/C9uNgZI
 uT/J1r3LZUqJvrYXgc0rRRGg1UOEdxmGxe13uhhP91CQhQVt+Zw+S631wcZJracJqEVe
 +dBg==
X-Gm-Message-State: AOJu0Ywl8pTk+Ja2HfyBSmvAoAJNncBrhZNYv4H7+p5E+e7K3jRV8jhE
 ycrqyJObXvMVr6BcitAG5zCEXFK7ek6uVse/MlHoUbdHvv2fuZZuH9Vv
X-Gm-Gg: ASbGncvXIgfcCGm+TriSXcPsukJz5g3BIMQZGYFYTnTvjSrEWimyRKChiNUxAdykRK5
 1KkcDYgX1H4c74zSKejg31jObnOoBAwXgxIFTL/PmMYfWMFQXMzvnzTRcbtdxIXfbrfP5nbbMJl
 iefnLJoEwkZ591SgEYlu5L+4rf8aSwnts8au0/SaYYdRnucwUO9qJsnTottlMNVo6cLQYnNuGdV
 6m7gmwuh6HZ/NMOEJXYIhGSVpdxOwUHW/IquOexB9vECf06sPLBb6JfYZL+er2bpLXfvUIsJXOe
 QR54lutdi5zH23MNvBB6eUxZ+jToRNMqKAJAS36dE6Lk1PsLRZVR4FARzVRrFTvFuLYvOLapFvO
 urhATpjeykYWMvgN1thwUHoTKFnJS1alIdesuB15F72z63HW5fxq+q+Mz968IS66KBx/GOUZ255
 q01tiJC1i/9zpjylM/iZei3lgPSWzXK8UeD/+FWKhMgLBfUwBaB3h4aB+NCxcX/JHeToqVdCgnS
 65g4YGNt+E=
X-Google-Smtp-Source: AGHT+IFfF3u0ER59yps4IFz0MwiqsfrWZiXMwhqMsahNXwtHO/LKW72VoBU5uzuBHVsY0RnIkwNIoQ==
X-Received: by 2002:a05:6a20:9186:b0:247:b1d9:77c with SMTP id
 adf61e73a8af0-2533e5731cfmr24500952637.3.1757529496175; 
 Wed, 10 Sep 2025 11:38:16 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d7:a100:4049:4ce3:eb22:4319?
 (20014C4E24D7A10040494CE3EB224319.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:4049:4ce3:eb22:4319])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b548a3f31a5sm3269596a12.8.2025.09.10.11.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:38:15 -0700 (PDT)
Message-ID: <7c5d463888fdac592ae2631327b05efdd1b29a80.camel@gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Marek =?UTF-8?Q?Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, "Olsak, Marek"
 <Marek.Olsak@amd.com>
Date: Wed, 10 Sep 2025 20:38:08 +0200
In-Reply-To: <CAAxE2A4HvuAHsuoeaNKVMxsFanR25iNo_THGV=vdyaMT6_qy9A@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Wed, 2025-09-10 at 11:10 -0400, Marek Ol=C5=A1=C3=A1k wrote:
> I added the comment into Mesa that 0x3fff00 is the limit. I did
> research on that bug separately from PAL, but I don't remember the
> details.
>=20
> There is no performance to gain here. It's only about consistency and
> clear communication to the=C2=A0public what the recommended SDMA
> programming is.
>=20
> Marek

Hi Christian & Marek,

I'd be happy to submit a new patch series if we can agree on what the
limits are for each SDMA version and how to get the best performance
from it.

I trust Marek's word that he did his research when he came up with
0x3fff00 so I don't understand the pushback here.

(1) According to a conversation between Marek and myself, the most
optimal way to program the SDMA would be to use 256-byte-aligned copy
packets. Christian, do you agree with this? If yes, I can write a patch
for that. If not, let me know what you would prefer.

(2) I'd like us to come to an agreement on the maximum amount of bytes
copied per SDMA packet, and align the kernel code with Mesa. At the
moment, the maximum limit is different for every SDMA version between
the kernel and Mesa, which makes the whole topic super confusing.

Please keep in mind that if there is any chance that the current limit
is indeed incorrect (as it sounds like it is), we risk "random" SDMA
hangs on users' machines.

Thanks & best regards,
Timur




>=20
> On Wed, Sep 10, 2025 at 10:57=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> > On 10.09.25 16:52, Marek Ol=C5=A1=C3=A1k wrote:
> > > It's probably better to use=C2=A00x3fff00 to match Mesa and PAL. Ther=
e
> > > is no benefit in using a different limit,=C2=A0not even a perf
> > > benefit, and it's better to be consistent with all UMDs.
> >=20
> > Unification with Mesa is certainly a valid argument, but just using
> > an approach because PAL does it has proven to be troublesome
> > before.
> >=20
> > If we are interested in best performance we should actually round
> > down the value to the next multiple of PAGE_SIZE.
> >=20
> > Christian.
> >=20
> > >=20
> > > Marek
> > >=20
> > > On Wed, Sep 10, 2025 at 7:54=E2=80=AFAM Christian K=C3=B6nig
> > > <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
> > > wrote:
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0On 10.09.25 11:34, Timur Krist=C3=B3f wrote:
> > > =C2=A0 =C2=A0 =C2=A0> On Wed, 2025-09-10 at 10:34 +0200, Christian K=
=C3=B6nig wrote:
> > > =C2=A0 =C2=A0 =C2=A0>> On 09.09.25 18:56, Timur Krist=C3=B3f wrote:
> > > =C2=A0 =C2=A0 =C2=A0>>>> Even when we apply it I think we should drop=
 that, the
> > > value the
> > > =C2=A0 =C2=A0 =C2=A0>>>> kernel uses is correct.
> > > =C2=A0 =C2=A0 =C2=A0>>>
> > > =C2=A0 =C2=A0 =C2=A0>>> Hi Christian,
> > > =C2=A0 =C2=A0 =C2=A0>>>
> > > =C2=A0 =C2=A0 =C2=A0>>> The kernel and Mesa disagree on the limits fo=
r almost
> > > all SDMA
> > > =C2=A0 =C2=A0 =C2=A0>>> versions, so it would be nice to actually und=
erstand
> > > what the
> > > =C2=A0 =C2=A0 =C2=A0>>> limits of
> > > =C2=A0 =C2=A0 =C2=A0>>> the SDMA HW are and use the same limit in the=
 kernel and
> > > Mesa, or
> > > =C2=A0 =C2=A0 =C2=A0>>> if
> > > =C2=A0 =C2=A0 =C2=A0>>> that isn't viable, let's document why the dif=
ferent
> > > limits make
> > > =C2=A0 =C2=A0 =C2=A0>>> sense.
> > > =C2=A0 =C2=A0 =C2=A0>>>
> > > =C2=A0 =C2=A0 =C2=A0>>> I'm adding Marek to CC, he wrote the comment =
that I
> > > referenced
> > > =C2=A0 =C2=A0 =C2=A0>>> here.
> > > =C2=A0 =C2=A0 =C2=A0>>> As far as I understand from my conversation w=
ith Marek,
> > > the kernel
> > > =C2=A0 =C2=A0 =C2=A0>>> is
> > > =C2=A0 =C2=A0 =C2=A0>>> actually wrong.
> > > =C2=A0 =C2=A0 =C2=A0>>>
> > > =C2=A0 =C2=A0 =C2=A0>>> If the limits depend on alignment, then we sh=
ould either
> > > set a
> > > =C2=A0 =C2=A0 =C2=A0>>> limit
> > > =C2=A0 =C2=A0 =C2=A0>>> that is always safe, or make sure SDMA copies=
 in the
> > > kernel are
> > > =C2=A0 =C2=A0 =C2=A0>>> always
> > > =C2=A0 =C2=A0 =C2=A0>>> aligned and add assertions about it.
> > > =C2=A0 =C2=A0 =C2=A0>>
> > > =C2=A0 =C2=A0 =C2=A0>> That's already done. See the size restrictions=
 applied to
> > > BOs and the
> > > =C2=A0 =C2=A0 =C2=A0>> callers of amdgpu_copy_buffer().
> > > =C2=A0 =C2=A0 =C2=A0>
> > > =C2=A0 =C2=A0 =C2=A0> Based on the code comments I cited, as far as I
> > > understand, the issue
> > > =C2=A0 =C2=A0 =C2=A0> is with copying the last 256 bytes of 2^22-1. D=
o I
> > > understood your
> > > =C2=A0 =C2=A0 =C2=A0> response correctly that you are saying that the=
 kernel
> > > isn't affected
> > > =C2=A0 =C2=A0 =C2=A0> by this issue because it always copies things t=
hat are 256
> > > byte
> > > =C2=A0 =C2=A0 =C2=A0> aligned?
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0Yes, see the kernel always works with at least PA=
GE_SIZE
> > > buffers (between 4k and 64k depending on CPU architecture). You
> > > never get anything smaller than that.
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0The only exception is the debugger interface, but=
 that
> > > always copies < PAGE_SIZE, so the SDMA limits are irrelevant.
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0> I checked the callers of amdgpu_copy_buffer and=
 can't find
> > > what you are
> > > =C2=A0 =C2=A0 =C2=A0> referring to. However, assuming that all caller=
s use
> > > amdgpu_copy_buffer
> > > =C2=A0 =C2=A0 =C2=A0> on 256 byte aligned addresses, there is still a=
n issue
> > > with large BOs:
> > > =C2=A0 =C2=A0 =C2=A0>
> > > =C2=A0 =C2=A0 =C2=A0> When the kernel copies a BO that is larger than=
 0x3fffe0
> > > bytes then it
> > > =C2=A0 =C2=A0 =C2=A0> needs to emit multiple SDMA copy packets, and t=
he copy
> > > done by the
> > > =C2=A0 =C2=A0 =C2=A0> second packet (and other subsequent packets) wo=
n't be 256
> > > byte aligned.
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0I've just double checked the documentation and fo=
r SI it
> > > clearly states that the limit is 0x3fffe0. Documentation for
> > > later HW says 2^22 - 1 - start_addr[4:2] (which is 0x1f in the
> > > worst case so you end up with 0x3fffe0 again).
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0For backward, tiled and windowed copies a 256byte=
 bounce
> > > buffer is used instead of the 32byte buffer for the linear copy.
> > > So the limit is then 0x3fff00.
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0Looks like that buffer is also used for byte alig=
ned copies
> > > and that limit applies there as well.
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0>>
> > > =C2=A0 =C2=A0 =C2=A0>> We could add another warning to amdgpu_copy_bu=
ffer(), but
> > > that is
> > > =C2=A0 =C2=A0 =C2=A0>> just the backend function.
> > > =C2=A0 =C2=A0 =C2=A0>>
> > > =C2=A0 =C2=A0 =C2=A0>>> Looking at the implementation of
> > > =C2=A0 =C2=A0 =C2=A0>>> amdgpu_copy_buffer in the kernel, I see that =
it relies
> > > on
> > > =C2=A0 =C2=A0 =C2=A0>>> copy_max_bytes and doesn't take alignment int=
o account,
> > > so with the
> > > =C2=A0 =C2=A0 =C2=A0>>> current limit it could issue subsequent copie=
s that
> > > aren't 256 byte
> > > =C2=A0 =C2=A0 =C2=A0>>> aligned.
> > > =C2=A0 =C2=A0 =C2=A0>>
> > > =C2=A0 =C2=A0 =C2=A0>> "Due to HW limitation, the maximum count may n=
ot be 2^n-
> > > 1, can only
> > > =C2=A0 =C2=A0 =C2=A0>> be 2^n - 1 - start_addr[4:2]"
> > > =C2=A0 =C2=A0 =C2=A0>>
> > > =C2=A0 =C2=A0 =C2=A0>> Well according to this comments the size restr=
iction is
> > > 32 bytes (256
> > > =C2=A0 =C2=A0 =C2=A0>> bits!) and not 256 bytes.
> > > =C2=A0 =C2=A0 =C2=A0>>
> > > =C2=A0 =C2=A0 =C2=A0>> Were do you actually get the 256 bytes restric=
tion from?
> > > =C2=A0 =C2=A0 =C2=A0>
> > > =C2=A0 =C2=A0 =C2=A0> The comments I cited above are from the followi=
ng sources:
> > > =C2=A0 =C2=A0 =C2=A0>
> > > =C2=A0 =C2=A0 =C2=A0> PAL uses 1<<22-256 =3D 0x3fff00 here:
> > > =C2=A0 =C2=A0 =C2=A0>
> > > https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3=
da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308
> > > <https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d48
> > > 6a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#
> > > L308>
> > > =C2=A0 =C2=A0 =C2=A0>
> > > =C2=A0 =C2=A0 =C2=A0> Mesa also uses 0x3fff00 here:
> > > =C2=A0 =C2=A0 =C2=A0>
> > > https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224c112=
ee2d48e511ae078f8c2/src/amd/common/sid.h#L390
> > > <https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd3622
> > > 4c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390>
> > > =C2=A0 =C2=A0 =C2=A0>
> > > =C2=A0 =C2=A0 =C2=A0> The limit in Mesa was added by this commit:
> > > =C2=A0 =C2=A0 =C2=A0>
> > > https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222=
411bc0d41c095004232ed
> > > <https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be
> > > 50222411bc0d41c095004232ed>
> > > =C2=A0 =C2=A0 =C2=A0> According to the commit message, Dave added thi=
s limit
> > > when hitting an
> > > =C2=A0 =C2=A0 =C2=A0> issue trying to use SDMA with buffers that are =
larger than
> > > this.
> > > =C2=A0 =C2=A0 =C2=A0>
> > > =C2=A0 =C2=A0 =C2=A0> For SDMA v5.2 and newer, a larger limit was add=
ed by Marek
> > > later:
> > > =C2=A0 =C2=A0 =C2=A0>
> > > https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38=
c04660cc4b3f8abbde259
> > > <https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666f
> > > cbe38c04660cc4b3f8abbde259>
> > > =C2=A0 =C2=A0 =C2=A0> Which confirms the same issue copying the last =
256 bytes
> > > on these
> > > =C2=A0 =C2=A0 =C2=A0> versions, although in this case the kernel isn'=
t
> > > technically wrong
> > > =C2=A0 =C2=A0 =C2=A0> because it uses a smaller overall maximum.
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0Yeah, I mean that totally makes sense. When you w=
ant allow
> > > byte aligned copies as well then you have to use 0x3fff00 as
> > > maximum.
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0The PAL code even has extra checks to speed up co=
pies where
> > > src and dst are byte aligned, but size isn't:
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 if (IsPow2Aligned(srcGpuAddr, sizeo=
f(uint32)) &&
> > > =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 IsPow2Aligned(dstGpuA=
ddr, sizeof(uint32)) &&
> > > =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*pBytesCopied >=3D s=
izeof(uint32)))
> > > =C2=A0 =C2=A0 =C2=A0....
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0So it totally makes sense to use the lower limit =
in Mesa but
> > > not for the kernel.
> > >=20
> > > =C2=A0 =C2=A0 =C2=A0Regards,
> > > =C2=A0 =C2=A0 =C2=A0Christian.
> > >=20
> >=20

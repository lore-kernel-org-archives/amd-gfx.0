Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FE9C3DA7F
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Aug 2024 05:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D8110E02C;
	Sun,  4 Aug 2024 05:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="myIDYVaa";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D78C10E02C
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Aug 2024 05:29:25 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5af51684d52so11068152a12.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 Aug 2024 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722749363; x=1723354163; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gz63Qvl3LqGGLwhdejHGGYUorKoOsN4841wbemeoNns=;
 b=myIDYVaaHEuQl7PrnsbcsGGPupsxg2XyLf9Z66rCXF4+RqQsAegO2FFYI0yD7mbFri
 BZMnU6nROgORydqYe95au8/dYNqAul9t9OBJmGYvizBjTK/EBpWrUodclfb7QyjioLJn
 P3870fvFE6gjdtQHY8FjGeT20c0Up5eGyOQt6JDW5QmvBn58i9f7Wkpop7SYDrVHuGvA
 NS1QturB9B9j1vCR65K6rQgk66di2oa/LepL12yyShAyLcXVeGiodmZsX2FCDjAyCijU
 GwXVa/wyeiJrdiUApIibnse0c8GLiNL0EbrtEwayeqIlCLz1NqvLkMUhTii0hvIKbH66
 NSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722749363; x=1723354163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gz63Qvl3LqGGLwhdejHGGYUorKoOsN4841wbemeoNns=;
 b=dssbx5iOkoyVfn0U2aiEvQ1p2hF6Q4QzgOamL7Pylsx2Zw7ve1/DxHxm8DLUoUqOTl
 cfHKYZiVsF32Ks9ivQhFBeENqGp3IWhV/1Rr7HvVYYvUVFD5Vwt63HEef1OYW8IH33F4
 SPLuV3zlDsZdSnqca4Bd4uIiQhTV7LSeZoZ/Vex7ocNuhKX+ajo9oxhQlLqcaOzzbEV+
 uwsYpSVAs2SyUujCkKsNiX/Zf1Tf9WEhqNS8AyMSCoVzzCSdweokGY60TAHRSaryjrQR
 Hrwf9kPm6cGGJbuJC1oOs9fciooSbZO2TcN8jLjgCD05aQWl0gkxyf1MJ3VsLFNCS/7g
 h2Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU6ALmUZLfmCyKCfwXBgNcU5J4RgLi5q52mH2oG5NNE6AWWLYmh4sYeFxSKJfGckj2h1Tk5pH+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzulLK/ITXzdRtyQA432VVf0XV0XsAisOo867DmkSLikfd1Gbho
 Ea8CBeZSXOkoWnvNFAls8TKuPpb5tI81BtZHqeuyd3yy9F8EG63LrokwaNXM6z/ZlbUkkFi9TGZ
 7B3tREDXjLezU4z63XpdlDmlCtRw=
X-Google-Smtp-Source: AGHT+IEIUONtrJahPjPZfFEWkk7+lXW0GqBJSRQRmgjEacgAdlXG7uZ8o+lQL852+SkHZIRH6XcjUw4RbnrGrm+8DXk=
X-Received: by 2002:a17:906:6a0b:b0:a7a:a892:8e11 with SMTP id
 a640c23a62f3a-a7dc4fca327mr520712066b.32.1722749363341; Sat, 03 Aug 2024
 22:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
 <28927b0d-f97f-451b-af03-943f8c85f92d@amd.com>
 <CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com>
 <18c7c805-d2ec-4448-bd25-cdb106aeac7e@amd.com>
 <CAAxE2A7XBQfUnYhSg2RS7TP_i6cv775RW0ocdgAyc-F0dsSqmQ@mail.gmail.com>
 <e9dac87c-5df7-47ec-8f95-a10792252385@amd.com>
In-Reply-To: <e9dac87c-5df7-47ec-8f95-a10792252385@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sun, 4 Aug 2024 01:28:46 -0400
Message-ID: <CAAxE2A4XVU7m270FHHz89wsiVh_0fN1qLtto46izbhCH7CYQ2g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
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

On Fri, Aug 2, 2024 at 6:10=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wro=
te:
>
>
>
> On 8/2/2024 12:25 AM, Marek Ol=C5=A1=C3=A1k wrote:
> > On Thu, Aug 1, 2024, 03:37 Christian K=C3=B6nig <christian.koenig@amd.c=
om
> > <mailto:christian.koenig@amd.com>> wrote:
> >
> >     __
> >     Am 01.08.24 um 08:53 schrieb Marek Ol=C5=A1=C3=A1k:
> >>     On Thu, Aug 1, 2024, 00:28 Khatri, Sunil <sukhatri@amd.com
> >>     <mailto:sukhatri@amd.com>> wrote:
> >>
> >>
> >>         On 8/1/2024 8:49 AM, Marek Ol=C5=A1=C3=A1k wrote:
> >>         >> +       /* Header is at index 0, followed by num_nops - 1
> >>         NOP packet's */
> >>         >> +       for (i =3D 1; i < num_nop; i++)
> >>         >> +               amdgpu_ring_write(ring, ring->funcs->nop);
> >>         > This loop should be removed. It's unnecessary CPU overhead
> >>         and we
> >>         > should never get more than 0x3fff NOPs (maybe use BUG_ON).
> >>         Leaving the
> >>         > whole packet body uninitialized is the fastest option.
> >>         That was the original intent to just move the WPTR for the no
> >>         of nops
> >>         and tried too. Based on Christian inputs we should not let the
> >>         nops packet
> >>
> >>         as garbage or whatever was there originally as a threat/safety
> >>         measure.
> >>
> >>
> >>     It doesn't help safety. It can only be read by the GPU with
> >>     kernel-level permissions.
> >>
> >>     Initializing the packet body is useless and adds CPU overhead,
> >>     especially with the 256 NOPs or so that we use for no reason.
> >
> >     Not filling the remaining ring buffers with NOPs is a pretty clear
> >     NAK from my side. Leaving garbage in the ring buffer is not even
> >     remotely defensive.
> >
> >
> > What are you defending against? You know the ring is kernel-owned
> > memory, right?
> >
>
> Aside from that, the true hardware behavior is that CP still fetches the
> words and discards them. It's not the same mentioned in the description.
> So the only optimization it allows is to move the pointer without
> filling/caring about the contents as hardware also doesn't care about
> them. The notion of filling those unused region is exactly opposite of
> the intention. If that's the case, nothing is gained and just drop these
> patches.

It's correct that it doesn't reduce fetching, but this optimization is
not about fetching. It's about reducing the number of instructions
that the firmware must execute. Single dword NOPs are quite expensive
for their size.

Marek

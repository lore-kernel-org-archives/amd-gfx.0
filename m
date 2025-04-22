Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9627C369D7
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 15:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8BB10E0F3;
	Tue, 22 Apr 2025 15:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cuaxjfPW";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0827810E0F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 15:19:51 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ff6b9a7f91so638117a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745335191; x=1745939991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uMY90s96CX8FW4G2MpncIiWcywN0j5QCZ/qMym475cI=;
 b=cuaxjfPWt6Kq4XpR5+UYCi0xdsxTr51WMRsCersp7Rb/DKl2fMvdwEtJycJl8jgh27
 47BBl/LTB+mLEiVc6huDa+hh9v3G+fu2kkTNszELSdi9hH48O0HtV49Eu9d45CSr7D8Q
 Aj20cXJClQavFJ3dfvUrCUXdTnBOW4TChq/nZCVcYjEMohkl0WNQSuW2AsWOdHe0sp7J
 Vs6gbgZKBvB7tYJ+Cmxd2mm8WH/8ea6os4s9ZzuoKSu9hipJQ7bAbTDD+VQdP0NzVkzn
 2Ly1d5Iif+WWmLJC7ld7WX+Isrh2T+eck/0KDciQsXR7j3pTa+Fr7pj50q10i3Uoy7RQ
 hUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745335191; x=1745939991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMY90s96CX8FW4G2MpncIiWcywN0j5QCZ/qMym475cI=;
 b=G3TPpJRbc+AAiao0ao6kar0ipIG/B0hOfpKGbRAqTpn8tLIjGiKw4zrQ5Q41LcBOX6
 2SpfjOcG/4akYmuXqtYLbS5DgBsQPVN5DIElSHaXoWwgTByuYqXRRaHGpw/rvl5iHGib
 XtmafmDi7fMDu9kzNnJ3U3mqT03dXCVMSXjIvI9HU2tSAgEaiVdvnT1CFL7STA6yQUGs
 rC8jfIqFnjE9WteCTp8X8ZjSFu9kCsGa8LI5fZYfgOeR6M9HBTnWJoSoHH1b7Dj05eUu
 wY0cSeomeLctOjzhAkOvBZDaJiD6ePzjJJ+lHtGkYg+HzbRYlCg8tCXgyvrcmBEgKn5u
 4rQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRle3KC5G7PbY5yKifwR6luRRKnYOolK2lV4oy26cIzRy2kOZo68JWbF5sJatBGJJGlMcFsWTy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwELZ2GSLMOVe1xT3d3kijOtM27yDh/yNBjC+hEqoztVhg/8rIJ
 3d6nr49kvOvQ1ZS90j9Mg+74ioPvc39X4gzbZ6pVSHTVqQKNBuJVuH4Mj3ymctjTxFTAA9m0X80
 4TNMJkna4d8Y1/7Txv8vkr9j4x92E7w==
X-Gm-Gg: ASbGncvRn/KWNMdKHx7bSshytKeooXzP6WQB8dnzOasWUSmH2aDEBafwFYJ5aGTwM6i
 ZRA8pplcyW7ImuuqWEGyspYPPCUBni6iqacDFcME48BXheQxgTldK3PfaKHIf/Do6XIX1Rc9hjK
 7Myt7uMP0rNYFq88avlTv71g==
X-Google-Smtp-Source: AGHT+IEFLPXqesVOVM5l2qC3GeeZr8lBS4d3MhPPRdpV/BwyzsfNlHNn+1ODdmr+Od8zwqzw3QZW0q20WQq7/qbodJo=
X-Received: by 2002:a17:90b:3e85:b0:306:b6ae:4d7a with SMTP id
 98e67ed59e1d1-3087bccb2c1mr8568844a91.3.1745335191260; Tue, 22 Apr 2025
 08:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250421222427.392362-1-siqueira@igalia.com>
 <CADnq5_NUzggmAmf3nSpOp0r3gnSLWiDM0rc6Cy2Y5yXFvkSXuw@mail.gmail.com>
 <p5o5jovbtbilyb32skmtp7a53o2fylyhk6x5onb2zsd6kgwqrl@usvdp4fzuul3>
In-Reply-To: <p5o5jovbtbilyb32skmtp7a53o2fylyhk6x5onb2zsd6kgwqrl@usvdp4fzuul3>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 11:19:39 -0400
X-Gm-Features: ATxdqUG538BMB8Zj_cEZ0d2-xOq0RYAC3LcKR98bdQYesI4vLTyhj04ny2KtPQA
Message-ID: <CADnq5_ODXY_1MoPZuKXgCAAxmP2QNsc00+x=W6_aaO=5yShwsA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Add documentation to some parts of the
 AMDGPU ring and wb
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Tue, Apr 22, 2025 at 9:59=E2=80=AFAM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 04/22, Alex Deucher wrote:
> > On Mon, Apr 21, 2025 at 6:24=E2=80=AFPM Rodrigo Siqueira <siqueira@igal=
ia.com> wrote:
> > >
> > > Add some random documentation associated with the ring buffer
> > > manipulations and writeback.
> >
> > I think this will result in documentation warnings if not all of the
> > elements in the structure are documented?  If so, maybe it would be

I just tried this with `make htmldocs` and there was no warning, so
maybe it's not an issue.

>
> This warning will likely be triggered only per struct, right? For the
> case of the struct amdgpu_wb I can try to complete all the missing
> fields for the next version. Regarding the writeback struct, I'm only
> familiar with the display writeback where DCN writes the same data from
> scanout in a memory buffer (at a scanout time). Does this writeback
> behave similarly to the one from DCN?

In this case the name of the data structure came from the initial use
case.  It is really just a tiny sub-allocator when you need few bytes
of GPU accessible memory.  We originally used it for the write back
mechanism supported by various engines on the GPU.  The writeback
mechanism is basically a way for the engine to shadow certain state to
memory.  E.g., the engine may store its ring buffer read pointer in a
register, but it can shadow this value to memory for easier access by
the CPU.  In addition to easier CPU access, the driver would use these
shadowed values to avoid register access all together, (e.g., if the
block is power gated, reading the register may be problematic).

>
> > better to make then as regular comments rather than kerneldoc.
> >
> > Alex
> >
> > >
> > > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 28 +++++++++++++++++-
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 37 ++++++++++++++++++++++=
++
> > >  2 files changed, 64 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu.h
> > > index cc26cf1bd843..6d2ae8d027e5 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > @@ -522,9 +522,35 @@ int amdgpu_file_to_fpriv(struct file *filp, stru=
ct amdgpu_fpriv **fpriv);
> > >
> > >  struct amdgpu_wb {
> > >         struct amdgpu_bo        *wb_obj;
> > > +
> > > +       /**
> > > +        * @wb:
> > > +        *
> > > +        * Pointer to the first writeback slot. In terms of CPU addre=
ss
> > > +        * this value can be accessed directly by using the offset as=
 an index.
> > > +        * For the GPU address, it is necessary to use gpu_addr and t=
he offset.
> > > +        */
> > >         volatile uint32_t       *wb;
> > > +
> > > +       /**
> > > +        * @gpu_addr:
> > > +        *
> > > +        * Writeback base address in the GPU.
> > > +        */
> > >         uint64_t                gpu_addr;
> > > -       u32                     num_wb; /* Number of wb slots actuall=
y reserved for amdgpu. */
> > > +
> > > +       /**
> > > +        * @num_wb:
> > > +        *
> > > +        * Number of writeback slots reserved for amdgpu.
> > > +        */
> > > +       u32                     num_wb;
> > > +
> > > +       /**
> > > +        * @used:
> > > +        *
> > > +        * Track the writeback slot already used.
> > > +        */
> > >         unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS=
_PER_LONG)];
> > >         spinlock_t              lock;
> > >  };
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.h
> > > index ec4de8df34e7..20805dacd66c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > @@ -241,6 +241,9 @@ struct amdgpu_ring_funcs {
> > >         bool (*is_guilty)(struct amdgpu_ring *ring);
> > >  };
> > >
> > > +/**
> > > + * amdgpu_ring - Holds ring information
> > > + */
> > >  struct amdgpu_ring {
> > >         struct amdgpu_device            *adev;
> > >         const struct amdgpu_ring_funcs  *funcs;
> > > @@ -255,10 +258,44 @@ struct amdgpu_ring {
> > >         u64                     wptr;
> > >         u64                     wptr_old;
> > >         unsigned                ring_size;
> > > +
> > > +       /**
> > > +        * @max_dw:
> > > +        *
> > > +        * Maximum number of DWords for ring allocation. This informa=
tion is
> > > +        * provided at the ring initialization time, and each IP bloc=
k can
> > > +        * specify a specific value.
> > > +        */
> > >         unsigned                max_dw;
> > > +
> > > +       /**
> > > +        * @count_dw:
> > > +        *
> > > +        * Count DWords: this value starts with the maximum amount of=
 DWords
> > > +        * supported by the ring. This value is updated based on the =
ring
> > > +        * manipulation.
> > > +        */
> > >         int                     count_dw;
> > >         uint64_t                gpu_addr;
> > > +
> > > +       /**
> > > +        * @ptr_mask:
> > > +        *
> > > +        * Some IPs provide support for 64-bit pointers and others fo=
r 32-bit
> > > +        * only; this behavior is component-specific and defined by t=
he field
> > > +        * support_64bit_ptr. If the IP block supports 64-bits, the m=
ask
> > > +        * 0xffffffffffffffff is set; otherwise, this value assumes b=
uf_mask.
> > > +        * Notice that this field is used to keep wptr under a valid =
range.
> > > +        */
> > >         uint64_t                ptr_mask;
> > > +
> > > +       /**
> > > +        * @buf_mask:
> > > +        *
> > > +        * Buffer mask is a value used to keep wptr count under its
> > > +        * thresholding. Buffer mask initialized during the ring buff=
er
> > > +        * initialization time, and it is defined as (ring_size / 4) =
-1.
> > > +        */
> > >         uint32_t                buf_mask;
> > >         u32                     idx;
> > >         u32                     xcc_id;
>
> Since we are here, what is this XCC and XCP? I guess those are focused
> on datacenter GPUs, right? Also, what do those acronyms stand by?

XCC =3D Accelerator Core Complex.  Similar to a CPU Core Complex on CPU.
XCP =3D Accelerator Core Partition.  A subset of the GPU cores that can
be used independently from the rest.

Alex

>
> Thanks
>
> > > --
> > > 2.49.0
> > >
>
> --
> Rodrigo Siqueira

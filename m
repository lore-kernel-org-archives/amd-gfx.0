Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085D2D78770
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 15:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01A910F033;
	Fri, 19 Dec 2025 15:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EaFT/eED";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF9710F031
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 15:37:29 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7ab689d3fa0so172203b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766158649; x=1766763449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4UYd76Qj6t3g9FGq/esGhQi7AJBVwXvUmMBaKMXH9U=;
 b=EaFT/eEDPUN3gXcmm0xK0hpRL70xAQnaPBeIg4CMYmweBhLTevrNDZpm7b5jGBPG9z
 reAuDwguXze4JhAMOeb38r0q/0sGPcRwe0pHpvOHckXyNOfLcmnfw27m8SrcIKWhVtz8
 VWRv0eZhuYBJVU2XUk3FkM2IXddhlLV5E7fhh8UUvnYW3ge/C6pOJ1qVmtzwdx64dQJg
 cdvNXV1X1MXSh7vGrANm44lO3EO9xqlQpfsXpVzYJiwyd/5JdFZKZnxN715wL1UVSxy3
 VJ6vtKeaxzA+3cpGRZYP1mtlPEWiMg7b6dbk/FqYtTwXurTP036cKt50d4h12YsLg6A0
 Z1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766158649; x=1766763449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G4UYd76Qj6t3g9FGq/esGhQi7AJBVwXvUmMBaKMXH9U=;
 b=nf8ic+7Dzfp7O0gygW6tkkmdSI9phGGG8e3XO8VHJa2BRVkTwI4IGVklVUoUbRh2UP
 g4bObNTohnA225XB967hRaRI+KNOeUb6Sn1sd1O8DA4pCKQhW0FOWVHSAvTnV0GeYad9
 Sc5Xx+RlxR2dLi+GkXN71rOvOD1aQoxraHwBOD8nd4FhcWKazAm93I+0K1Rj74dGyWb2
 /PXhcOQqcN/VvSEwtW84sX2F74ahYWGVfNV3TA/R45mahLwzqSBsai1BT2bAxVCzZZq1
 UXDTeqwEsRhbFyoF5Nf2lJgvaDZCT3TIM+Uz90/DWsDUwY4aEtzdAL0oPzTcRDBsGarz
 FKzg==
X-Gm-Message-State: AOJu0YwIEVDgg9n7zWfJdCyFfO6YU4G+o5ScqSFz7V/QBmPXJMnS3W9E
 c/Cn4oqddWjT8tzLOpE8HbCOUjJZAaN9r/Xml8h0IilbvoHjM4FtbLCNJw4lORiGD16HDaS+HpF
 XZ48wJ/KlNBHZnnf4/5yymdHajfcsnS4=
X-Gm-Gg: AY/fxX7cX52Z9yYMBTOA2iO257TFT9EU+fk2gnkCI8ZPT2fuJ3euNWWn2r/AF8cH2IP
 40e1Tp9FrnsV89sjeJ5dZ/w9eH6PV04plquXjfw2XNpl8wutc/Tp9EPGqCmfcxqUxuAUCzqZNsI
 k/XgNtuHhugi9WLwJLvase8pDb2OYuggR7gmH+RC5Pj5enk87rK94dzJUefEA0NGiCovlkNc11K
 /D8geHqw5w5ppSlGh9w+9DKxsFX0wULjhtG5+y5DnvwL/qnYLP17v7WsP2sC7IgtEDjCl8V
X-Google-Smtp-Source: AGHT+IFsuN5Dp7qQXOspnVxuHnuCMVItVT7zFrGyZBarFN45KysVceNtB0pFCpoDJ8CwjhSlxPlcmlGPr3heOjITrsI=
X-Received: by 2002:a05:7022:6199:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-121721ad61fmr2311911c88.1.1766158648298; Fri, 19 Dec 2025
 07:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20251218224141.5841-1-alexander.deucher@amd.com>
 <20251218224141.5841-6-alexander.deucher@amd.com>
 <3069977.btlEUcBR6m@timur-max>
In-Reply-To: <3069977.btlEUcBR6m@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Dec 2025 10:37:16 -0500
X-Gm-Features: AQt7F2pvfdYyvvAwiNb5uy1LLo-z1MdQsvdHDrqPixdbWPttbOPNZNl4ALMEOWI
Message-ID: <CADnq5_OwQpWwMPywzApHMe-y2TS68217bTh3afwgjPYoOf9jtQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/amdgpu/gfx9: rework pipeline sync packet sequence
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

On Thu, Dec 18, 2025 at 9:36=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On 2025. december 18., cs=C3=BCt=C3=B6rt=C3=B6k 16:41:40 k=C3=B6z=C3=A9ps=
=C5=91 =C3=A1llamokbeli z=C3=B3naid=C5=91 Alex
> Deucher wrote:
> > Replace WAIT_REG_MEM with EVENT_WRITE flushes for all
> > shader types and PFP_SYNC_ME.  That should accomplish
> > the same thing and avoid having to wait on a fence
> > preventing any issues with pipeline syncs during
> > queue resets.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 32 ++++++++++++++++++---------
> >  1 file changed, 21 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index 7b012ca1153ea..d9dee3c11a=
05d
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -5572,15 +5572,26 @@ static void gfx_v9_0_ring_emit_fence(struct
> > amdgpu_ring *ring, u64 addr, amdgpu_ring_write(ring, 0);
> >  }
> >
> > -static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
> > +static void gfx_v9_0_ring_emit_event_write(struct amdgpu_ring *ring,
> > +                                        uint32_t event_type,
> > +                                        uint32_t
> event_index)
> >  {
> > -     int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
> > -     uint32_t seq =3D ring->fence_drv.sync_seq;
> > -     uint64_t addr =3D ring->fence_drv.gpu_addr;
> > +     amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
> > +     amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
> > +                       EVENT_INDEX(event_index));
> > +}
> >
> > -     gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
> > -                           lower_32_bits(addr),
> upper_32_bits(addr),
> > -                           seq, 0xffffffff, 4);
> > +static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
> > +{
> > +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) {
> > +             gfx_v9_0_ring_emit_event_write(ring, VS_PARTIAL_FLUSH,
> 4);
>
> Is VS_PARTIAL_FLUSH necessary when we already have PS_PARTIAL_FLUSH?
> When we wait for all PS to finish, wouldn't that imply that all VS had al=
ready
> finished as well?

I'm not sure.  The CP docs recommend all 3 if you want to wait for the
engine to idle.

>
> > +             gfx_v9_0_ring_emit_event_write(ring, PS_PARTIAL_FLUSH,
> 4);
> > +             gfx_v9_0_ring_emit_event_write(ring, CS_PARTIAL_FLUSH,
> 4);
> > +             amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME,
> 0));
> > +             amdgpu_ring_write(ring, 0x0);
>
> The above sequence just waits for all shaders to finish, but as far as I
> understand it doesn't wait for memory writes and cache flushes. Please co=
rrect
> me if I'm wrong about this. For that, I think we do need an ACQUIRE_MEM
> packet. (And, if the ACQUIRE_MEM is done on the PFP then we won't need th=
e
> PFP_SYNC_ME.)

There is already a RELEASE_MEM (the fence from the previous job) prior
to this packet that would have flushed the caches.  We just want to
block the PFP from further fetching until that is complete.  In the
good case, the RELEASE_MEM would have handled pipeline idling and
cache flushes so these would be effectively noops and in the reset
case, we don't care because that bad job is gone anyway.  I guess
probably all we really need is the PFP_SYNC_ME.

Alex

>
> > +     } else {
> > +             gfx_v9_0_ring_emit_event_write(ring, CS_PARTIAL_FLUSH,
> 4);
> > +     }
> >  }
> >
> >  static void gfx_v9_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
> > @@ -7404,7 +7415,7 @@ static const struct amdgpu_ring_funcs
> > gfx_v9_0_ring_funcs_gfx =3D { .set_wptr =3D gfx_v9_0_ring_set_wptr_gfx,
> >       .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
> >               5 +  /* COND_EXEC */
> > -             7 +  /* PIPELINE_SYNC */
> > +             8 +  /* PIPELINE_SYNC */
> >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> >               2 + /* VM_FLUSH */
> > @@ -7460,7 +7471,7 @@ static const struct amdgpu_ring_funcs
> > gfx_v9_0_sw_ring_funcs_gfx =3D { .set_wptr =3D amdgpu_sw_ring_set_wptr_=
gfx,
> >       .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
> >               5 +  /* COND_EXEC */
> > -             7 +  /* PIPELINE_SYNC */
> > +             8 +  /* PIPELINE_SYNC */
> >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> >               2 + /* VM_FLUSH */
> > @@ -7521,7 +7532,7 @@ static const struct amdgpu_ring_funcs
> > gfx_v9_0_ring_funcs_compute =3D { 20 + /* gfx_v9_0_ring_emit_gds_switch=
 */
> >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> >               5 + /* hdp invalidate */
> > -             7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> > +             2 + /* gfx_v9_0_ring_emit_pipeline_sync */
> >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> >               8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user
> fence, vm fence */
> > @@ -7564,7 +7575,6 @@ static const struct amdgpu_ring_funcs
> > gfx_v9_0_ring_funcs_kiq =3D { 20 + /* gfx_v9_0_ring_emit_gds_switch */
> >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> >               5 + /* hdp invalidate */
> > -             7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> >               8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user
> fence, vm fence */
>
>
>
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0137C30658
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 16:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A256B10E643;
	Tue,  2 Jul 2024 16:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iyvKYdrM";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3B610E66B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 16:06:29 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a724958f118so536252366b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jul 2024 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719936387; x=1720541187; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02lKlz8Adxp/KZLVEKHcJpJv9mrLlHP5Cy7kX8H+KsQ=;
 b=iyvKYdrMmucSNCFK43efXvesENikha+//TSGksON/GgalQ3eSMAZzBPeimcrX/Qj6E
 S7rs47MiAbKxTGJ/s3DAffE71GbuG7nqCV0pM+ap8VXxKxsokh3ur2ZWak6LetlyZhye
 qbUlED/va3cFh9GCviRPJmYImd/uKSrSru9j/Raqjhh3hozUvQ7sB+8QRkgYm5fu6O0n
 /oxwncMSe5Zx86zCskF3xK0uXjfEurF18wzsLbQfkzN5Zq+u11x71vwfvnjJi3pRHz3h
 w7IvHrRjVsXGCj3EAID9/rfVkpgzDWJTxqTcS2EggH5Ivvb6FoVVtsIQnz2/xnMmnfx7
 Y7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719936387; x=1720541187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02lKlz8Adxp/KZLVEKHcJpJv9mrLlHP5Cy7kX8H+KsQ=;
 b=w3Zr2e896GQilWkmWOTUJf5HZ/Fe+Xv1j4vf1Vj+p4ZUs9Xhs6TSKOIVyv2NECATpJ
 /yWLT6drrX/9YXg2YJQym2TC80KicAIaZZ5rFkYkOXrE6LVEeALdGo77lwqUgEJOPSUW
 /bYus+JqK+v5ufXaYjif2LmteDYMUzZAVOLfAe+15Ur5YbsmBrWsWzq50+NBpK6Kq202
 +g0uH7v0yNzxvML2Das6/qWWWwTU1WfILsecuSd0mseL/hEC6I8SlscwXzSk4qAvwojP
 KzZBDeNymV+w8/zAUfz2H7jLilMWktlMh2SX5QDIH2uSlOAo3AJCR+bny27uOg13IgJ+
 eXfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPvcel4+Eb7CUCNsJ34C2L5Fjf4a3fqmC9gmU/0eSgE9U/ouji3MSXzTsWZn4hYQ+Y3t/QSPoop0MTXKERh9ZKb8uEzyD8M3qZhHl6Aw==
X-Gm-Message-State: AOJu0YyhwDSep65TdSPAgJVxbbif7zzjdBPEOvkGdRzdSk062Fd8toe0
 21nUkUq+efvlWAqvHof6JwZO9Cf8J20NhBbRn569J1SN3j5rzlEPkHedFEU7aE8vXDBEIrVQ1Up
 dieAdgG+ZgpDA0PSAnKAmFV5qrQc=
X-Google-Smtp-Source: AGHT+IHweTbsmYAD1mUWwhweul1OJE3chaNbvDsRLr7YUjCrOLPuPZt4ceLbUtbsZoETiGo6UImHf7JLr0/Gc9hW2iI=
X-Received: by 2002:a17:907:6d11:b0:a72:5b3b:4d62 with SMTP id
 a640c23a62f3a-a751443c609mr701939966b.4.1719936387008; Tue, 02 Jul 2024
 09:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240626022742.1956-1-Frank.Min@amd.com>
 <SA3PR12MB7902BE546DCDACE2F5DAAF33E9D62@SA3PR12MB7902.namprd12.prod.outlook.com>
 <SA3PR12MB79028EFDCBFD7191E72E2CFAE9D32@SA3PR12MB7902.namprd12.prod.outlook.com>
 <CAAxE2A6Z31AV7mPxQdNZ-2ygm+wES3-NhPQqhZTxG8wns7R48w@mail.gmail.com>
In-Reply-To: <CAAxE2A6Z31AV7mPxQdNZ-2ygm+wES3-NhPQqhZTxG8wns7R48w@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 2 Jul 2024 12:05:50 -0400
Message-ID: <CAAxE2A4ah-FsCA+HzAre+D7fRzC80+gXSMshmYP-K5zbZmz7nA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: restore dcc bo tilling configs while moving
To: "Min, Frank" <Frank.Min@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

I think the change should fix invalid values passed from userspace.

max_com =3D=3D 3 should be clamped to 2.
data_format =3D=3D 0 || data_format > 24 should do 2 things: set
data_format to 10, set num_format to 0.

Marek

On Tue, Jul 2, 2024 at 9:43=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.=
com> wrote:
>
> Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>
> On Sun, Jun 30, 2024 at 11:35=E2=80=AFPM Min, Frank <Frank.Min@amd.com> w=
rote:
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > From: Frank Min <Frank.Min@amd.com>
> >
> > While moving buffer which as dcc tiling config, it is needed to restore=
 its original dcc tiling.
> >
> > 1. extend copy flag to cover tiling bits
> >
> > 2. add logic to restore original dcc tiling config
> >
> > Signed-off-by: Frank Min <Frank.Min@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++++---  driver=
s/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 11 +++++++++++  drivers/gpu/drm/amd/amd=
gpu/sdma_v7_0.c  | 10 ++++++++--
> >  3 files changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 9a92dd3c9fb8..dd4aed47af1e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -308,7 +308,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device=
 *adev,
> >
> >         mutex_lock(&adev->mman.gtt_window_lock);
> >         while (src_mm.remaining) {
> > -               uint64_t from, to, cur_size;
> > +               uint64_t from, to, cur_size, tiling_flags;
> > +               uint32_t num_type, data_format, max_com;
> >                 struct dma_fence *next;
> >
> >                 /* Never copy more than 256MiB at once to avoid a timeo=
ut */ @@ -329,10 +330,20 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_de=
vice *adev,
> >                 abo_dst =3D ttm_to_amdgpu_bo(dst->bo);
> >                 if (tmz)
> >                         copy_flags |=3D AMDGPU_COPY_FLAGS_TMZ;
> > -               if (abo_src->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> > +               if ((abo_src->flags & AMDGPU_GEM_CREATE_GFX12_DCC) &&
> > +                   (abo_src->tbo.resource->mem_type =3D=3D TTM_PL_VRAM=
))
> >                         copy_flags |=3D AMDGPU_COPY_FLAGS_READ_DECOMPRE=
SSED;
> > -               if (abo_dst->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> > +               if ((abo_dst->flags & AMDGPU_GEM_CREATE_GFX12_DCC) &&
> > +                   (dst->mem->mem_type =3D=3D TTM_PL_VRAM)) {
> >                         copy_flags |=3D AMDGPU_COPY_FLAGS_WRITE_COMPRES=
SED;
> > +                       amdgpu_bo_get_tiling_flags(abo_dst, &tiling_fla=
gs);
> > +                       max_com =3D AMDGPU_TILING_GET(tiling_flags, GFX=
12_DCC_MAX_COMPRESSED_BLOCK);
> > +                       num_type =3D AMDGPU_TILING_GET(tiling_flags, GF=
X12_DCC_NUMBER_TYPE);
> > +                       data_format =3D AMDGPU_TILING_GET(tiling_flags,=
 GFX12_DCC_DATA_FORMAT);
> > +                       copy_flags |=3D (AMDGPU_COPY_FLAGS_SET(MAX_COMP=
RESSED, max_com) |
> > +                                      AMDGPU_COPY_FLAGS_SET(NUMBER_TYP=
E, num_type) |
> > +                                      AMDGPU_COPY_FLAGS_SET(DATA_FORMA=
T, data_format));
> > +               }
> >
> >                 r =3D amdgpu_copy_buffer(ring, from, to, cur_size, resv=
,
> >                                        &next, false, true, copy_flags);=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ttm.h
> > index 7c903a6c9ddb..8d34e8588dc2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > @@ -114,6 +114,17 @@ struct amdgpu_copy_mem {
> >  #define AMDGPU_COPY_FLAGS_TMZ          (1 << 0)
> >  #define AMDGPU_COPY_FLAGS_READ_DECOMPRESSED    (1 << 1)
> >  #define AMDGPU_COPY_FLAGS_WRITE_COMPRESSED     (1 << 2)
> > +#define AMDGPU_COPY_FLAGS_MAX_COMPRESSED_SHIFT         3
> > +#define AMDGPU_COPY_FLAGS_MAX_COMPRESSED_MASK          0x03
> > +#define AMDGPU_COPY_FLAGS_NUMBER_TYPE_SHIFT            5
> > +#define AMDGPU_COPY_FLAGS_NUMBER_TYPE_MASK             0x07
> > +#define AMDGPU_COPY_FLAGS_DATA_FORMAT_SHIFT            8
> > +#define AMDGPU_COPY_FLAGS_DATA_FORMAT_MASK             0x3f
> > +
> > +#define AMDGPU_COPY_FLAGS_SET(field, value) \
> > +       (((__u32)(value) & AMDGPU_COPY_FLAGS_##field##_MASK) <<
> > +AMDGPU_COPY_FLAGS_##field##_SHIFT)
> > +#define AMDGPU_COPY_FLAGS_GET(value, field) \
> > +       (((__u32)(value) >> AMDGPU_COPY_FLAGS_##field##_SHIFT) &
> > +AMDGPU_COPY_FLAGS_##field##_MASK)
> >
> >  int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)=
;  void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev); diff --git a/drive=
rs/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > index 96514fd77e35..41b5e45697dc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > @@ -1566,6 +1566,12 @@ static void sdma_v7_0_emit_copy_buffer(struct am=
dgpu_ib *ib,
> >                                        uint32_t byte_count,
> >                                        uint32_t copy_flags)
> >  {
> > +       uint32_t num_type, data_format, max_com;
> > +
> > +       max_com =3D AMDGPU_COPY_FLAGS_GET(copy_flags, MAX_COMPRESSED);
> > +       data_format =3D AMDGPU_COPY_FLAGS_GET(copy_flags, DATA_FORMAT);
> > +       num_type =3D AMDGPU_COPY_FLAGS_GET(copy_flags, NUMBER_TYPE);
> > +
> >         ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDM=
A_OP_COPY) |
> >                 SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINE=
AR) |
> >                 SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_CO=
PY_FLAGS_TMZ) ? 1 : 0) | @@ -1580,10 +1586,10 @@ static void sdma_v7_0_emit=
_copy_buffer(struct amdgpu_ib *ib,
> >         ib->ptr[ib->length_dw++] =3D upper_32_bits(dst_offset);
> >
> >         if ((copy_flags & (AMDGPU_COPY_FLAGS_READ_DECOMPRESSED | AMDGPU=
_COPY_FLAGS_WRITE_COMPRESSED)))
> > -               ib->ptr[ib->length_dw++] =3D SDMA_DCC_DATA_FORMAT(4) | =
SDMA_DCC_NUM_TYPE(4) |
> > +               ib->ptr[ib->length_dw++] =3D SDMA_DCC_DATA_FORMAT(data_=
format) |
> > +SDMA_DCC_NUM_TYPE(num_type) |
> >                         ((copy_flags & AMDGPU_COPY_FLAGS_READ_DECOMPRES=
SED) ? SDMA_DCC_READ_CM(2) : 0) |
> >                         ((copy_flags & AMDGPU_COPY_FLAGS_WRITE_COMPRESS=
ED) ? SDMA_DCC_WRITE_CM(1) : 0) |
> > -                       SDMA_DCC_MAX_COM(1) | SDMA_DCC_MAX_UCOM(1);
> > +                       SDMA_DCC_MAX_COM(max_com) | SDMA_DCC_MAX_UCOM(1=
);
> >  }
> >
> >  /**
> > --
> > 2.34.1
> >

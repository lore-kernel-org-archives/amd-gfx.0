Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44406C3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 13:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF1A10E261;
	Tue,  2 Jul 2024 13:44:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ePxvWgrD";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D79B710E283
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 13:44:12 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-58b966b4166so865710a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jul 2024 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719927851; x=1720532651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4Tt5Mj8cEpgZXQCM0NoZTGzvuOT8KCXNTZjvq+zWBM=;
 b=ePxvWgrDcf0LuM4JinYIkA2255uTiyYpkyWrTi4lkv+J2Hpq8EvLaEq+cebnPUD7qg
 rjOKH5t4t2n3h7g3Qn8E8qbrMGgNRaS1wxDrsBNcWFsiW3okxWmMFko8AiINuquvn/N+
 Xpel9DRGZr35mLhPPdeEmG7anIdAy9pRT4DXZRkBjSXNbI1BoSaIr4ZXGP+bZs26owW0
 qOTXgjiNNCn+BbCy78Yfw7Jh3yUm7STnE8Cizbv6NkDny63oeD3CcWsA0/RAC0AXXGdD
 hxKHM5ZLHasLRE73SaV62uWmiQ8mPAAtWrPa1gcxij1ZhlLzEqz57kGy33C2nigADQBc
 lukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927851; x=1720532651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4Tt5Mj8cEpgZXQCM0NoZTGzvuOT8KCXNTZjvq+zWBM=;
 b=HfERB703PWeTusGb1c2d3b6r9qi/X9Hr7XS57CXEeAhrUX957UmLJawVc6iOSCpZ2H
 OY4/dQl0pqCo2AdQaP4KFd0ymCpSTfMFt8W0M1Rz78KIlkmiJQfrDdKT5oUQFN3aLvn8
 BPV8Ud/rhWP7oT9hf+NCYgwUtUKqYED2TlzWtzeeCocngqQdxZveAiJRy5458Lar+UWP
 91OZ7+oE7Rob+82kDHFA6t4LIZjKRULe7mG5PtgYH0YL7yazc9D9f2pSKoHgbNEYodU+
 gzv9GQGzmhrzL0vGObgcb4dfUtJxQfubyASBBnPLBxwvtqRHfP34JzZ/ZhnNd/CSpiIK
 mfJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJaE7iaizNJ1sfSCRV+asUFzXZEdhjU2mdIUYSkriblH3q1lf3lEXoi3tlBN89zrE/hV2dPKK9jdvrEbkZ+PeTVQHhOOD3fXgODCOLyw==
X-Gm-Message-State: AOJu0YzcoHrgifY1p9p3IUCRKW5hMK1Vx3W6O5QGNnzTf/UhCQuD3Vi2
 WHzdQrFNDffHRKNfkFzUHcCSrtRfndbUfVx0d9QLzKfYS9LEsDXJNXYWzqPSZTrGK0kt+phL/qn
 930o8GhKitL/Ft6YzK1wKmVUOZQk=
X-Google-Smtp-Source: AGHT+IHjWhocMjF8RcHi6tiytCPWSgMDqbuYqeGaKCV7dAdHH9T56NL8uW1nQQrrS2yxA0alvb/SbgiFUpJWIf+Qnd0=
X-Received: by 2002:a17:906:d930:b0:a72:6849:cb0f with SMTP id
 a640c23a62f3a-a751447bafbmr546331966b.62.1719927850958; Tue, 02 Jul 2024
 06:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240626022742.1956-1-Frank.Min@amd.com>
 <SA3PR12MB7902BE546DCDACE2F5DAAF33E9D62@SA3PR12MB7902.namprd12.prod.outlook.com>
 <SA3PR12MB79028EFDCBFD7191E72E2CFAE9D32@SA3PR12MB7902.namprd12.prod.outlook.com>
In-Reply-To: <SA3PR12MB79028EFDCBFD7191E72E2CFAE9D32@SA3PR12MB7902.namprd12.prod.outlook.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 2 Jul 2024 09:43:34 -0400
Message-ID: <CAAxE2A6Z31AV7mPxQdNZ-2ygm+wES3-NhPQqhZTxG8wns7R48w@mail.gmail.com>
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

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

On Sun, Jun 30, 2024 at 11:35=E2=80=AFPM Min, Frank <Frank.Min@amd.com> wro=
te:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> From: Frank Min <Frank.Min@amd.com>
>
> While moving buffer which as dcc tiling config, it is needed to restore i=
ts original dcc tiling.
>
> 1. extend copy flag to cover tiling bits
>
> 2. add logic to restore original dcc tiling config
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++++---  drivers/=
gpu/drm/amd/amdgpu/amdgpu_ttm.h | 11 +++++++++++  drivers/gpu/drm/amd/amdgp=
u/sdma_v7_0.c  | 10 ++++++++--
>  3 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 9a92dd3c9fb8..dd4aed47af1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -308,7 +308,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *=
adev,
>
>         mutex_lock(&adev->mman.gtt_window_lock);
>         while (src_mm.remaining) {
> -               uint64_t from, to, cur_size;
> +               uint64_t from, to, cur_size, tiling_flags;
> +               uint32_t num_type, data_format, max_com;
>                 struct dma_fence *next;
>
>                 /* Never copy more than 256MiB at once to avoid a timeout=
 */ @@ -329,10 +330,20 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_devi=
ce *adev,
>                 abo_dst =3D ttm_to_amdgpu_bo(dst->bo);
>                 if (tmz)
>                         copy_flags |=3D AMDGPU_COPY_FLAGS_TMZ;
> -               if (abo_src->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> +               if ((abo_src->flags & AMDGPU_GEM_CREATE_GFX12_DCC) &&
> +                   (abo_src->tbo.resource->mem_type =3D=3D TTM_PL_VRAM))
>                         copy_flags |=3D AMDGPU_COPY_FLAGS_READ_DECOMPRESS=
ED;
> -               if (abo_dst->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> +               if ((abo_dst->flags & AMDGPU_GEM_CREATE_GFX12_DCC) &&
> +                   (dst->mem->mem_type =3D=3D TTM_PL_VRAM)) {
>                         copy_flags |=3D AMDGPU_COPY_FLAGS_WRITE_COMPRESSE=
D;
> +                       amdgpu_bo_get_tiling_flags(abo_dst, &tiling_flags=
);
> +                       max_com =3D AMDGPU_TILING_GET(tiling_flags, GFX12=
_DCC_MAX_COMPRESSED_BLOCK);
> +                       num_type =3D AMDGPU_TILING_GET(tiling_flags, GFX1=
2_DCC_NUMBER_TYPE);
> +                       data_format =3D AMDGPU_TILING_GET(tiling_flags, G=
FX12_DCC_DATA_FORMAT);
> +                       copy_flags |=3D (AMDGPU_COPY_FLAGS_SET(MAX_COMPRE=
SSED, max_com) |
> +                                      AMDGPU_COPY_FLAGS_SET(NUMBER_TYPE,=
 num_type) |
> +                                      AMDGPU_COPY_FLAGS_SET(DATA_FORMAT,=
 data_format));
> +               }
>
>                 r =3D amdgpu_copy_buffer(ring, from, to, cur_size, resv,
>                                        &next, false, true, copy_flags); d=
iff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ttm.h
> index 7c903a6c9ddb..8d34e8588dc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -114,6 +114,17 @@ struct amdgpu_copy_mem {
>  #define AMDGPU_COPY_FLAGS_TMZ          (1 << 0)
>  #define AMDGPU_COPY_FLAGS_READ_DECOMPRESSED    (1 << 1)
>  #define AMDGPU_COPY_FLAGS_WRITE_COMPRESSED     (1 << 2)
> +#define AMDGPU_COPY_FLAGS_MAX_COMPRESSED_SHIFT         3
> +#define AMDGPU_COPY_FLAGS_MAX_COMPRESSED_MASK          0x03
> +#define AMDGPU_COPY_FLAGS_NUMBER_TYPE_SHIFT            5
> +#define AMDGPU_COPY_FLAGS_NUMBER_TYPE_MASK             0x07
> +#define AMDGPU_COPY_FLAGS_DATA_FORMAT_SHIFT            8
> +#define AMDGPU_COPY_FLAGS_DATA_FORMAT_MASK             0x3f
> +
> +#define AMDGPU_COPY_FLAGS_SET(field, value) \
> +       (((__u32)(value) & AMDGPU_COPY_FLAGS_##field##_MASK) <<
> +AMDGPU_COPY_FLAGS_##field##_SHIFT)
> +#define AMDGPU_COPY_FLAGS_GET(value, field) \
> +       (((__u32)(value) >> AMDGPU_COPY_FLAGS_##field##_SHIFT) &
> +AMDGPU_COPY_FLAGS_##field##_MASK)
>
>  int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size); =
 void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev); diff --git a/drivers=
/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 96514fd77e35..41b5e45697dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1566,6 +1566,12 @@ static void sdma_v7_0_emit_copy_buffer(struct amdg=
pu_ib *ib,
>                                        uint32_t byte_count,
>                                        uint32_t copy_flags)
>  {
> +       uint32_t num_type, data_format, max_com;
> +
> +       max_com =3D AMDGPU_COPY_FLAGS_GET(copy_flags, MAX_COMPRESSED);
> +       data_format =3D AMDGPU_COPY_FLAGS_GET(copy_flags, DATA_FORMAT);
> +       num_type =3D AMDGPU_COPY_FLAGS_GET(copy_flags, NUMBER_TYPE);
> +
>         ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_=
OP_COPY) |
>                 SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR=
) |
>                 SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY=
_FLAGS_TMZ) ? 1 : 0) | @@ -1580,10 +1586,10 @@ static void sdma_v7_0_emit_c=
opy_buffer(struct amdgpu_ib *ib,
>         ib->ptr[ib->length_dw++] =3D upper_32_bits(dst_offset);
>
>         if ((copy_flags & (AMDGPU_COPY_FLAGS_READ_DECOMPRESSED | AMDGPU_C=
OPY_FLAGS_WRITE_COMPRESSED)))
> -               ib->ptr[ib->length_dw++] =3D SDMA_DCC_DATA_FORMAT(4) | SD=
MA_DCC_NUM_TYPE(4) |
> +               ib->ptr[ib->length_dw++] =3D SDMA_DCC_DATA_FORMAT(data_fo=
rmat) |
> +SDMA_DCC_NUM_TYPE(num_type) |
>                         ((copy_flags & AMDGPU_COPY_FLAGS_READ_DECOMPRESSE=
D) ? SDMA_DCC_READ_CM(2) : 0) |
>                         ((copy_flags & AMDGPU_COPY_FLAGS_WRITE_COMPRESSED=
) ? SDMA_DCC_WRITE_CM(1) : 0) |
> -                       SDMA_DCC_MAX_COM(1) | SDMA_DCC_MAX_UCOM(1);
> +                       SDMA_DCC_MAX_COM(max_com) | SDMA_DCC_MAX_UCOM(1);
>  }
>
>  /**
> --
> 2.34.1
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7031CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 14:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D06E10EB1F;
	Fri, 22 Aug 2025 14:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hLbGl+FI";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13DA10EB1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 14:30:25 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-24457f44927so3165995ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755873025; x=1756477825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rg2GcDSQ8WUW92+166MeMoRe2xJgMQjd2UP22uNxX08=;
 b=hLbGl+FIb6qaJucLh3mtJWvpCx8hXgnpqqauh90mLuCWCSZocfgqotLD12TwUXKi3S
 vsDG8ziPIn7y8YCBwAO03u893NKR2IhA3vnQFZ++dQRyxWZ59YxOI9GRuzOkgkqJz+Dz
 VXb/IalWA54QCCdkINNt6BhfIiiIepb732pJOcg1f49+PhqDGIQAhg2XBu2VUOUdeu0w
 3rMx9hWgWZAlbzkw+U2wUzeFrhGjFzm30gmGdtV/Zxz38NXjJI4Na8nqOO/JIWwhY6On
 IBOK3LB0Cvrs5/WXnXD+QFeb4/sNI6hItM6CUoIAi9Y+4Apmxq4Ov351IzUzuavJcYpL
 OXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755873025; x=1756477825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rg2GcDSQ8WUW92+166MeMoRe2xJgMQjd2UP22uNxX08=;
 b=wIecSkw8rWsgOBIV7naiy67+oHv9zrDD+SlbjBeqjiwQicRSjTiHOu6ZWtY5eGHT5R
 VGfJVZQZmesUfsf00n7aRpjaLGN6qnIgY3oRRnck4vEOwiV54I3+AvzCrUhioWRG6WmJ
 A0NnvLEVDMltUidgLsu3WxY7OHzcZ0BqxNv2O+N8MmZe3MXgSbbaazlxVvTDDIFzGCsc
 1SHgiNF4+ELgsmX2Q1MkGDpgLUpUsUU6enZbELPelzrfLNDID6X9isy5QpbpbetYElfO
 bTmUoRokQ9bP/KNwUwavEquJXoXkW3iXYTK9FnP8K2vsKHVwziHlJiZQpHPXXZ0XlzOa
 E4+g==
X-Gm-Message-State: AOJu0YyVRwzP3HNqvpa5RQacBLfuDqPAhNf/IxuRWfBCrZIsF2FcnTdU
 xEVjNqCQPVCAHNq2Vml52TSvUHp5OOitYIyn/kPkhw3tC25wlw4DlYzFMLNM25BLWExyPlTK+Hp
 mEJ4kGziaAgDRCKo34dm8eNDdu97CkTI=
X-Gm-Gg: ASbGnctxmNMHMuo9usnVpOGK/RvDaa1ir29CupjHiWuUE9ZVawsspcKUAlNdCByJNXa
 Ktv6OzPYj2cbSaDXtU87OjSJK+N/mkrlWbbADwS34SlQeHA3DRaEBOOTGIeXxBelUVeZxm9OKrA
 i2x2ZP3dkCdfXAg6gprEhpBlqtwUHKxfVMezlSxXE0I7GRmF7UTVJstg5olgwrniycbskgoh5WA
 NSwJ/0=
X-Google-Smtp-Source: AGHT+IHn5GrJY6I76ac80mYzt2Wu3FoeG79nSlszuDi8GFBuzoW/Thtock1V6NploLvKHQSWGbC1mhLS8J19AFQr5+A=
X-Received: by 2002:a17:902:d48b:b0:246:5253:6dfc with SMTP id
 d9443c01a7336-24652537015mr8930295ad.7.1755873025269; Fri, 22 Aug 2025
 07:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250821152033.790477-1-shaoyun.liu@amd.com>
In-Reply-To: <20250821152033.790477-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Aug 2025 10:30:13 -0400
X-Gm-Features: Ac12FXyi7mdRlkTjAVPgtnGfy-UqEeEWI_mI1fZc_ZLWJSr1r1KSMScGb2MFXI4
Message-ID: <CADnq5_NNtJkXSzt7zAveYfs=E4pQo=T4mgOJ5-VHSek0R6HCqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
To: Shaoyun Liu <shaoyun.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Aug 21, 2025 at 11:28=E2=80=AFAM Shaoyun Liu <shaoyun.liu@amd.com> =
wrote:
>
> From MES version 0x81, it provide the new API INV_TLBS that support
> invalidate tlbs with PASID.
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 27 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 20 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 43 +++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index c0d2c195fe2e..46235b8726f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -280,6 +280,30 @@ struct mes_reset_queue_input {
>         bool                               is_kq;
>  };
>
> +enum amdgpu_mes_hub_id {
> +       AMDGPU_MES_GC_HUB0 =3D 0,
> +       AMDGPU_MES_GC_HUB1 =3D 1,
> +       AMDGPU_MES_GC_HUB2 =3D 2,
> +       AMDGPU_MES_GC_HUB3 =3D 3,
> +       AMDGPU_MES_GC_HUB4 =3D 4,
> +       AMDGPU_MES_GC_HUB5 =3D 5,
> +       AMDGPU_MES_GC_HUB6 =3D 6,
> +       AMDGPU_MES_GC_HUB7 =3D 7,
> +       AMDGPU_MES_MM_HUB00 =3D 8,
> +       AMDGPU_MES_MM_HUB01 =3D 9,
> +       AMDGPU_MES_MM_HUB02=3D 10,
> +       AMDGPU_MES_MM_HUB03 =3D 11,
> +       AMDGPU_MES_MM_HUB10 =3D 12,
> +       AMDGPU_MES_MM_HUB11 =3D 13,
> +};

If these are the same as the hub definitions in amdgpu_vm.h you can
just use those directly and skip these.

> +
> +struct mes_inv_tlbs_pasid_input {
> +       uint32_t        xcc_id;
> +       uint16_t        pasid;
> +       uint8_t         hub_id;
> +       uint8_t         flush_type;
> +};
> +
>  enum mes_misc_opcode {
>         MES_MISC_OP_WRITE_REG,
>         MES_MISC_OP_READ_REG,
> @@ -367,6 +391,9 @@ struct amdgpu_mes_funcs {
>
>         int (*reset_hw_queue)(struct amdgpu_mes *mes,
>                               struct mes_reset_queue_input *input);
> +
> +       int (*invalidate_tlbs_pasid)(struct amdgpu_mes *mes,
> +                             struct mes_inv_tlbs_pasid_input *input);
>  };
>
>  #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index feb92e107af8..b5be6c7838aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -339,6 +339,26 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amd=
gpu_device *adev,
>         uint16_t queried;
>         int vmid, i;
>
> +       if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE]=
.sched.ready &&
> +           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x81=
) {
> +               struct mes_inv_tlbs_pasid_input input =3D {0};
> +               input.pasid =3D pasid;
> +               input.flush_type =3D flush_type;
> +               input.hub_id =3D AMDGPU_GFXHUB(0);
> +               /* MES will invalidate all gc_hub for the device from mas=
ter */
> +               adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input=
);
> +               if (all_hub) {
> +                       /* Only need to invalidate mm_hub now */
> +                       for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX=
_VMHUBS) {
> +                               if (i < AMDGPU_MMHUB0_START)
> +                                       continue;

I think you can drop the loop here and just have:
input.hub_id =3D AMDGPU_MMHUB(0);
adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
in the all_hub case since gfx12 only supports one mmhub as well.

> +                               input.hub_id =3D i;
> +                               adev->mes.funcs->invalidate_tlbs_pasid(&a=
dev->mes, &input);
> +                       }
> +               }
> +               return;
> +       }
> +
>         for (vmid =3D 1; vmid < 16; vmid++) {
>                 bool valid;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 6b222630f3fa..6740383f7721 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -108,6 +108,7 @@ static const char *mes_v12_0_opcodes[] =3D {
>         "SET_SE_MODE",
>         "SET_GANG_SUBMIT",
>         "SET_HW_RSRC_1",
> +       "INVALIDATE_TLBS",
>  };
>
>  static const char *mes_v12_0_misc_opcodes[] =3D {
> @@ -879,6 +880,47 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_me=
s *mes,
>                         offsetof(union MESAPI__RESET, api_status));
>  }
>
> +static int mes_v12_inv_tlb_convert_hub_id(enum amdgpu_mes_hub_id id)
> +{
> +       int mes_hub_id =3D id;
> +       /*
> +        * MES doesn't support invalidate gc_hub on slave xcc individuall=
y
> +        * master xcc will invalidate all gc_hub for the partition
> +        */
> +       if (id =3D=3D 0)
> +               return 0;
> +       if (id < AMDGPU_MMHUB0_START)
> +               return -EINVAL;
> +
> +       mes_hub_id -=3D AMDGPU_MMHUB0_START - 1;
> +       /* gfx12 only support maximum one mmhub */
> +       return (mes_hub_id > 1) ? -EINVAL: mes_hub_id;

It would be cleaner to do something like this:

if (AMDGPU_IS_GFXHUB(id))
    return 0;
else if (AMDGPU_IS_MMHUB0(id))
    return 1;
else
    return -EINVAL;

> +}

add a new line here.

Alex

> +static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
> +                                   struct mes_inv_tlbs_pasid_input *inpu=
t)
> +{
> +       union MESAPI__INV_TLBS mes_inv_tlbs;
> +
> +       memset(&mes_inv_tlbs, 0, sizeof(mes_inv_tlbs));
> +
> +       mes_inv_tlbs.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_inv_tlbs.header.opcode =3D MES_SCH_API_INV_TLBS;
> +       mes_inv_tlbs.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_inv_tlbs.invalidate_tlbs.inv_sel =3D 0;
> +       mes_inv_tlbs.invalidate_tlbs.flush_type =3D input->flush_type;
> +       mes_inv_tlbs.invalidate_tlbs.inv_sel_id =3D input->pasid;
> +
> +       /*convert amdgpu_mes_hub_id to mes expected hub_id */
> +       mes_inv_tlbs.invalidate_tlbs.hub_id =3D mes_v12_inv_tlb_convert_h=
ub_id(input->hub_id);
> +       if (mes_inv_tlbs.invalidate_tlbs.hub_id < 0)
> +               return -EINVAL;
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_K=
IQ_PIPE,
> +                       &mes_inv_tlbs, sizeof(mes_inv_tlbs),
> +                       offsetof(union MESAPI__INV_TLBS, api_status));
> +
> +}
> +
>  static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
>         .add_hw_queue =3D mes_v12_0_add_hw_queue,
>         .remove_hw_queue =3D mes_v12_0_remove_hw_queue,
> @@ -888,6 +930,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =
=3D {
>         .resume_gang =3D mes_v12_0_resume_gang,
>         .misc_op =3D mes_v12_0_misc_op,
>         .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
> +       .invalidate_tlbs_pasid =3D mes_v12_0_inv_tlbs_pasid,
>  };
>
>  static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
> --
> 2.34.1
>

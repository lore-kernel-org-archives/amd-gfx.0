Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9607CA0EEB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 15:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804D810EB48;
	Fri, 22 Aug 2025 15:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J2z0fWoa";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FF910EB48
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 15:12:41 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-244581eab34so4281145ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755875560; x=1756480360; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpsX0PGd0T1a1+a++5mhrdOULUeXvI0DhFzwCflk2ww=;
 b=J2z0fWoaJWaZ96XZ7FDv16VZ5d1aWd8VCZ3rgPShQ/AGkXx1z4NZVdC4hBcHZl6FTC
 9izkCgV7QCQ8rp+vjS24gzZAW9R7bGr4w//KaETDZ2FopuFCKX6V/9oMNQYphZnqFD0h
 l/wqN8W3KyTJ/rfjvYa2t6bAxvBAeAeIhTCKn3enAYW0f7ET5uUmOtmR6/2KQrKdGEwE
 66G3SiPrFtlWrN2bARpmyWgKWqFe8aHLeJUNeImb8hMzise0bs3mulH+j6xH3d8OOLZH
 jivwoasqDe3N2+kFKTASucCf37bop4JAB6KMmQ5z8h2L2OFT3HwgAFv8HnfoSzHJQ5wY
 s0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755875560; x=1756480360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bpsX0PGd0T1a1+a++5mhrdOULUeXvI0DhFzwCflk2ww=;
 b=BnCc+hn+QK2qCLqTXYZS/QT5PMe7P/wBxgGkkwl3zM/eo2c3fJFqDa+U1kLQa/W2sU
 5cILcqGFHOCznEgi219kB2CQfUGsDOyuOjtPU1L3ahSNht/VxPl89SdZrCrrXbnmHKn1
 7U8lzbhQn3DbZIoUOUz2F4sDOcS5kEpZnqb6/dh2+hSHJlo7AZzZ7m0nJFiwz8lxHyZA
 psdnt9Eao9BZh9WT2Cob/eYFiEMs1KuQxWnLkRIOQJ+gHIII44bldvU9YwrCGGxYdQUB
 IwHs1pXVzdePKz1SJtJvWwSD15HgTQBJJlMO9plUaxYG6nln16QP+HNKnNYjtqU7Sd6R
 Gm4g==
X-Gm-Message-State: AOJu0Yx7dEGrgMz+vv6e/2c9AhHijb+yHIyGg+fPrngjuJ03/v/nJCoH
 xFVv2pobwTz6eqZ/oDsqDhqiKQCxOAZ6tArwQ9ysWcF1CXPb03VaKEKTLrNQqtkgCXDNWfsebqM
 351qQ7XUEPYEfwldIwWdhz6gzQGzOCJd5ZQ==
X-Gm-Gg: ASbGncv2rf1X5DFj879KkbbqQlN1E3WZeED8mAbspWeuK6kCSWkQ5/cdHTmgHun361d
 awhwKG3ru9wl0ydalsSpGVVTihFcEvEQiD1RnPz7NuzuTM1EqpE9aaTrIOfs0xFdPg0MoWOe3Zw
 3tQJttw91rSAWs339MOxJAEYD+P1u1d3OnUbcdBOzfWfjhKPn9jn5KZOP/+iyOdNSve3oWWj8HW
 +vBV20=
X-Google-Smtp-Source: AGHT+IG4M4g1F45Bi1LYqI0Pbq1Sb9QCn/Wr10mdoMf5Y5IFX+BLyIzxQDMtA/kW4JAQLTtE1zGc1kA9O3O1IqVG5VM=
X-Received: by 2002:a17:903:2448:b0:240:63bd:2701 with SMTP id
 d9443c01a7336-2462ef0831fmr25725395ad.6.1755875560313; Fri, 22 Aug 2025
 08:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250822150211.796535-1-shaoyun.liu@amd.com>
In-Reply-To: <20250822150211.796535-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Aug 2025 11:12:28 -0400
X-Gm-Features: Ac12FXxxquMrrqBLOSNA63GZsX_bgEnNF5OZ5c-aWBdUF-KD21XRDyxbIHEssG4
Message-ID: <CADnq5_NCyhGohTG-Vfp=p8ALc+1+W7UM7ajCgehv4XQArkSniQ@mail.gmail.com>
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

On Fri, Aug 22, 2025 at 11:02=E2=80=AFAM Shaoyun Liu <shaoyun.liu@amd.com> =
wrote:
>
> From MES version 0x81, it provide the new API INV_TLBS that support
> invalidate tlbs with PASID.
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 10 ++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 16 +++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 43 +++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index c0d2c195fe2e..489a4a0f0610 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -280,6 +280,13 @@ struct mes_reset_queue_input {
>         bool                               is_kq;
>  };
>
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
> @@ -367,6 +374,9 @@ struct amdgpu_mes_funcs {
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
> index feb92e107af8..eed62e9a9b96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -339,6 +339,22 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amd=
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
> +                       /* Only need to invalidate mm_hub now, gfx12 only=
 support one mmhub */
> +                       input.hub_id =3D AMDGPU_MMHUB(0);
> +                       adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes=
, &input);
> +               }
> +               return;
> +       }
> +
>         for (vmid =3D 1; vmid < 16; vmid++) {
>                 bool valid;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 6b222630f3fa..d0b5deed245d 100644
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

Leftover unused variable.  with that dropped, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +       /*
> +        * MES doesn't support invalidate gc_hub on slave xcc individuall=
y
> +        * master xcc will invalidate all gc_hub for the partition
> +        */
> +       if (AMDGPU_IS_GFXHUB(id))
> +               return 0;
> +       else if (AMDGPU_IS_MMHUB0(id))
> +               return 1;
> +       else
> +               return -EINVAL;
> +
> +}
> +
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

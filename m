Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD9DCA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 19:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E6F10E029;
	Wed, 20 Aug 2025 19:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZEaBoMBM";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45EA10E029
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 19:57:17 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2447d607b70so317025ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 12:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755719837; x=1756324637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pe3gnWtS/PrDLupSzMxk/pC1mKHfl2eew8gqjMnIEco=;
 b=ZEaBoMBMLUknolskNFS723dIZZ5U20SA2CVTjGsTYdials2Ng+dxULD58Xu2RRuL0f
 N6Mc+czebxuAOcBVwe6zXxNr7nu2X/kgOkKxHUzYqkYSqx5f1NCv0l46iqs+mzcSyusQ
 nmTDwWbwPs3nbHzMUUEyHeQiDD8lkNtNdXu6mJMa0/TzzMQOjilWwi/iH7FDX4lAQ2j2
 dM43//EVEww0XBbnixNLLskjSOgwkByqyb+BpXoBvxgGH9d1zg07jhdKxCf2PxOadAM2
 Q+cmU7sLClThmZrAizVIpRbJqciBfantnf2jYWN1kUO7ubK3pAfPBl79GvIClHHIZDwH
 hXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755719837; x=1756324637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pe3gnWtS/PrDLupSzMxk/pC1mKHfl2eew8gqjMnIEco=;
 b=sfDyxMTj+uBowyDNWOYNDHC0unTlJbBeObTsOg3pNTZ8q4kTEAfBGQwCQ70pA7EXMn
 VNjvIzVEvudXdDT1Rr7pcFklG5ogzyczqyI4K6dg5NrUWxNI1nkZ7TBxfK8JcdKPEgyq
 jtfHxsrSlhGiRdCv+kyXMZrH4WTFuPMcE3Xdd4TkmK3NTvOlJyZrnPkygPVqSb1kw4Rf
 Vd3JxzGR9ZT+zsYvHnlC9ZcZ46uKwJu5jj9SoO6PqPd13aeqCFsNHIFQx5drU4oedqyr
 yFHNp/rUHy81QkLOSZC/6h6x/3dhbR1hrUxyUvHJUGFYNma3NVtJg9QUTu/ta9mxFiWd
 blQg==
X-Gm-Message-State: AOJu0YzI+mb30JeJpblCS5mWKUX8Ckl800+e7e2siJ9gc6wLq6plaBpK
 0r4DDTADnwwYQX8rWIjWyx6SI8j6WALGwde6PbIq0+nR0EJdMgQ11T+wpcunLafh9jByPNmwzEV
 9/kgoPJ7Yh5N6MbByus+vB6/Dr8O1L6awZtc2
X-Gm-Gg: ASbGnctl7hhrCo2T6+9TWexpyPJemBaOFOB1/aclD9UiuhCwTIzaItpGHviDg3p9Xwk
 dJWCmu+k9xPfvPjAlfQqjDGoT6zXnvzeUJXnJ1yIZ13kMZGJfoLEYG5DgK3FwgmpzrFnxuonqty
 vQP+L4R0Hd21VZKBucWfNOQRSQ8acFHzQ8jRMnb5Wqb6doqFemfKxIQSQYIR40LuQHbVS70HdPC
 xt0RugBc17jgjJhxA==
X-Google-Smtp-Source: AGHT+IH4ri/m3Pvw5q6kETZRGghWU6AYmhNwKnOjIUp+CB2XCjuqKFgEqasWriOIiirvdv9IG1c8hlVmLFHHDHhc6n0=
X-Received: by 2002:a17:903:2450:b0:240:8fd6:f798 with SMTP id
 d9443c01a7336-245febf32c3mr196335ad.4.1755719837149; Wed, 20 Aug 2025
 12:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250820184725.432071-1-shaoyun.liu@amd.com>
In-Reply-To: <20250820184725.432071-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 15:57:05 -0400
X-Gm-Features: Ac12FXwpTqccQ2HGDqJJvdnohWvCxZ-JyN-J6BgCGh0h4NOmRIFmSg5by6QvZqw
Message-ID: <CADnq5_Mysyg77K9rGx2Himz+oixP1oUniR22CHa7-NmrEksM2g@mail.gmail.com>
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

On Wed, Aug 20, 2025 at 2:47=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> w=
rote:
>
> From MES version 0x81, it provide the new API INV_TLBS that support
> invalidate tlbs with PASID.
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 25 +++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index c0d2c195fe2e..1b6e7b4fde36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -280,6 +280,19 @@ struct mes_reset_queue_input {
>         bool                               is_kq;
>  };
>
> +enum amdgpu_mes_hub_id {
> +       AMDGPU_MES_GC_HUB =3D 0,
> +       AMDGPU_MES_MM_HUB0 =3D 1,
> +       AMDGPU_MES_MM_HUB1 =3D 2,
> +};
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
> @@ -367,6 +380,9 @@ struct amdgpu_mes_funcs {
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
> index feb92e107af8..ef58a849d67d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -339,6 +339,28 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amd=
gpu_device *adev,
>         uint16_t queried;
>         int vmid, i;
>
> +       if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE]=
.sched.ready &&
> +           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x81=
) {
> +
> +               struct mes_inv_tlbs_pasid_input input =3D {0};
> +               input.pasid =3D pasid;
> +               input.flush_type =3D flush_type;
> +               if (all_hub) {
> +                       for_each_set_bit(i, adev->vmhubs_mask,
> +                                        AMDGPU_MAX_VMHUBS) {
> +                               /*
> +                                * For gfx12, the index i from vmhubs_mas=
k matchs AMDGPU_MES_HUB_ID,
> +                                * Need to convert them if they are not m=
atch in future asic
> +                                */

Are you sure about this?  From above:

> +       AMDGPU_MES_GC_HUB =3D 0,
> +       AMDGPU_MES_MM_HUB0 =3D 1,
> +       AMDGPU_MES_MM_HUB1 =3D 2,

And then in amdgpu_vm.h:

/*
 * max number of VMHUB
 * layout: max 8 GFXHUB + 4 MMHUB0 + 1 MMHUB1
 */
#define AMDGPU_MAX_VMHUBS                       13
#define AMDGPU_GFXHUB_START                     0
#define AMDGPU_MMHUB0_START                     8
#define AMDGPU_MMHUB1_START                     12
#define AMDGPU_GFXHUB(x)                        (AMDGPU_GFXHUB_START + (x))
#define AMDGPU_MMHUB0(x)                        (AMDGPU_MMHUB0_START + (x))
#define AMDGPU_MMHUB1(x)                        (AMDGPU_MMHUB1_START + (x))

Alex

> +                               input.hub_id =3D i;
> +                               adev->mes.funcs->invalidate_tlbs_pasid(&a=
dev->mes, &input);
> +                       }
> +               } else {
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
> index 6b222630f3fa..bcaaccf28765 100644
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
> @@ -879,6 +880,29 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_me=
s *mes,
>                         offsetof(union MESAPI__RESET, api_status));
>  }
>
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
> +       /*The AMDGPU_MES_HUB_ID from input matchs mes expection on gfx12*=
/
> +       mes_inv_tlbs.invalidate_tlbs.hub_id =3D (uint32_t)input->hub_id;
> +
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
> @@ -888,6 +912,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =
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

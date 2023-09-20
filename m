Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94425C00E86
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 15:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7236B10E487;
	Wed, 20 Sep 2023 15:21:56 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6D310E487
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 15:21:55 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1d63d38c74fso4153038fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695223314; x=1695828114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwYg5UAIHEOnLcHxcpRRk7mrqbB6JEO5lwLnCovB6nI=;
 b=I7zNDWFQXc+ombLwQA5vY+yOCnWUFokNdtmU/aqFmoOjY5WJU8gGx9+JzLvSiNIkVM
 mY5wtZvxEXN9Wy6XvPSWHGDV3XBxxiHJjcM3d6xKovKhvE4rJMevchsESusm26lvqFVl
 8Czm4nImQiHU8r5OCuDyhsS4JXJzB+xaWUk+pnaKwltItRMDIlkdxHBaIpri2ONH64d1
 k7OLOUnCL0XjHK5Qqrsvgd76J3JgFHzCRbf98uLm5XDu6yr2k1CYncFmufbQ6OWbPJW+
 4IrYFGhJ4pOwSFvAVIzIljkjbRIIyZH9Ejj58AdMqOAZmSyaV718ittFO9B1vNpUish/
 yuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695223314; x=1695828114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwYg5UAIHEOnLcHxcpRRk7mrqbB6JEO5lwLnCovB6nI=;
 b=LvG8chI5duN01RWnkHXwDvWIyP1w7jm8K5+GrBj9oVvVLV9FuYT7q8fBJAA+575/5R
 gIk8goUZLr6qZLf/e9G4/0ygc/qCYHuxsK/UOU13h5BnFhCWCroJmzShN9D3L1xqLMun
 vb3k2y8dGhFL1nw3m6lzufNSHbriUHkvzxeShofOan89Ng+mNdzMbFAB1aRKvrB4Yo8i
 CCV+N9CFw/dbGIs/LiTlRiXGHeDvSV7fUuNsd1ZPmszHipwC0MjpCxEnr6mOKEFQVhE+
 vwEN0HLo5C9TzwFJrzZDyuaLTBZI9SI1LbJPKhyJKkFlEo4yYkfdhNTrwZScJsPiNcn8
 hsmA==
X-Gm-Message-State: AOJu0YySdIeVY+NMb0V7sbB4CjnFUrtSDD066BayU2XV4oUe3G29V471
 IA7j0ex0jU/pMK+RjANWaUpWcL+wUZHlGw5AqHLBsDl/
X-Google-Smtp-Source: AGHT+IH1MsVpUz5l5uZxq690AxqlDObDNC7cKLCrQJzeZl3GJhPxHMTNq7InBdfBrL+JVudT5xhuPh8fSmOXvKuJHJ8=
X-Received: by 2002:a05:6871:151:b0:1c8:bbd0:2fd1 with SMTP id
 z17-20020a056871015100b001c8bbd02fd1mr2892938oab.41.1695223314219; Wed, 20
 Sep 2023 08:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-6-shashank.sharma@amd.com>
In-Reply-To: <20230908160446.2188-6-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Sep 2023 11:21:43 -0400
Message-ID: <CADnq5_MiNtSswTycxUQu0MfbD80LNg1M0=NCJ_1Br2Ek=ir-ig@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] drm/amdgpu: create context space for usermode queue
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 8, 2023 at 12:45=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> The FW expects us to allocate at least one page as context
> space to process gang, process, GDS and FW  related work.
> This patch creates a joint object for the same, and calculates
> GPU space offsets of these spaces.
>
> V1: Addressed review comments on RFC patch:
>     Alex: Make this function IP specific
>
> V2: Addressed review comments from Christian
>     - Allocate only one object for total FW space, and calculate
>       offsets for each of these objects.
>
> V3: Integration with doorbell manager
>
> V4: Review comments:
>     - Remove shadow from FW space list from cover letter (Alex)
>     - Alignment of macro (Luben)
>
> V5: Merged patches 5 and 6 into this single patch
>     Addressed review comments:
>     - Use lower_32_bits instead of mask (Christian)
>     - gfx_v11_0 instead of gfx_v11 in function names (Alex)
>     - Shadow and GDS objects are now coming from userspace (Christian,
>       Alex)
>
> V6:
>     - Add a comment to replace amdgpu_bo_create_kernel() with
>       amdgpu_bo_create() during fw_ctx object creation (Christian).
>     - Move proc_ctx_gpu_addr, gang_ctx_gpu_addr and fw_ctx_gpu_addr out
>       of generic queue structure and make it gen11 specific (Alex).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 61 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>  2 files changed, 62 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 6760abda08df..8ffb5dee72a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -61,6 +61,9 @@
>  #define regCGTT_WD_CLK_CTRL_BASE_IDX   1
>  #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1  0x4e7e
>  #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX 1
> +#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
> +#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
> +#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
>
>  MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
> @@ -6424,6 +6427,56 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_=
block =3D
>         .funcs =3D &gfx_v11_0_ip_funcs,
>  };
>
> +static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq_mgr *u=
q_mgr,
> +                                             struct amdgpu_usermode_queu=
e *queue)
> +{
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +
> +       amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
> +}
> +
> +static int gfx_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_=
mgr,
> +                                           struct amdgpu_usermode_queue =
*queue,
> +                                           struct drm_amdgpu_userq_mqd_g=
fx_v11_0 *mqd_user)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       struct v11_gfx_mqd *mqd =3D queue->mqd.cpu_ptr;
> +       uint64_t fw_ctx_gpu_addr;
> +       int r, size;
> +
> +       /*
> +        * The FW expects at least one page space allocated for
> +        * process ctx, gang ctx and fw ctx each. Create an object
> +        * for the same.
> +        */
> +       size =3D AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
> +              AMDGPU_USERQ_GANG_CTX_SZ;
> +       r =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_GTT,
> +                                   &ctx->obj,
> +                                   &ctx->gpu_addr,
> +                                   &ctx->cpu_ptr);
> +       if (r) {
> +               DRM_ERROR("Failed to allocate ctx space bo for userqueue,=
 err:%d\n", r);
> +               return r;
> +       }
> +
> +       fw_ctx_gpu_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ +
> +                         AMDGPU_USERQ_GANG_CTX_SZ;
> +       mqd->fw_work_area_base_lo =3D lower_32_bits(fw_ctx_gpu_addr);
> +       mqd->fw_work_area_base_lo =3D upper_32_bits(fw_ctx_gpu_addr);
> +
> +       /* Shadow and GDS objects come directly from userspace */
> +       mqd->shadow_base_lo =3D lower_32_bits(mqd_user->shadow_va);
> +       mqd->shadow_base_hi =3D upper_32_bits(mqd_user->shadow_va);
> +
> +       mqd->gds_bkup_base_lo =3D lower_32_bits(mqd_user->gds_va);
> +       mqd->gds_bkup_base_hi =3D upper_32_bits(mqd_user->gds_va);
> +
> +       return 0;
> +}
> +
>  static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>                                       struct drm_amdgpu_userq_in *args_in=
,
>                                       struct amdgpu_usermode_queue *queue=
)
> @@ -6480,6 +6533,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgp=
u_userq_mgr *uq_mgr,
>                 goto free_mqd;
>         }
>
> +       /* Create BO for FW operations */
> +       r =3D gfx_v11_0_userq_create_ctx_space(uq_mgr, queue, &mqd_user);
> +       if (r) {
> +               DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> +               goto free_mqd;
> +       }
> +
>         return 0;
>
>  free_mqd:
> @@ -6492,6 +6552,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr=
 *uq_mgr, struct amdgpu_userm
>  {
>         struct amdgpu_userq_obj *mqd =3D &queue->mqd;
>
> +       gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>         amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>  }
>
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index 240f92796f00..34e20daa06c8 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
>         struct amdgpu_userq_mgr *userq_mgr;
>         struct amdgpu_vm        *vm;
>         struct amdgpu_userq_obj mqd;
> +       struct amdgpu_userq_obj fw_obj;

Since this is gfx 11 specific, I feel like this would be better stored
in some gfx 11 structure rather than the generic user queue structure.
Maybe a driver private pointer here would make more sense, then each
IP can hang whatever structure they want here for IP specific
metadata.

Alex


>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.42.0
>

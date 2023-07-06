Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EB4EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 16:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA0810E41A;
	Thu,  6 Jul 2023 16:44:53 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F6710E41A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 16:44:52 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1b0605d4d11so875797fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688661891; x=1691253891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qJdhGsblGteDPYwy6f7GgraKs3svIqvFCo6Sg9bgog=;
 b=ls+R7VyCCSO5w+rolgfDxEzi8lFG+SYq0UxfRrNAJbkyC084OvFkyc+Ey2Qy6j54zg
 75sEiM95z3ILQ5HunNDMB+bHlIsDSrtqZXOTtxoWUJ3TVU5WdbuearAkFWRQcYPjAvnc
 rWYoPjaY9Y2W7kU7uM6CAWdeuJAgnx16jRS2j57+wwhtuPxcPtDlXKRsV0WWofdqlRWY
 3nDrgFkmOaPXk2slUSfsOehXqV8HHu6jywJhh2q9zPQVvWQpzdiB8SNvIaxWNBxsS/SX
 eYB5y8b7g14sz+oBWhytgUQ1/nROkS22MHYdrh8VncFxrpJe8iFsrrh2zHoUoV/+K4VP
 DEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688661891; x=1691253891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qJdhGsblGteDPYwy6f7GgraKs3svIqvFCo6Sg9bgog=;
 b=C/G/4nnKUadYqbZsTxV62LPMGahWH//ZKXI6ydNzVGXgmdlD1D5Scw7lxz37Aiuxly
 zTEVrcnAyJFBOncKJqSfMCyjyM76vCXua9Llz5wvw+eDkqObFbb663Vu24KGt+cnkvNj
 9D6c5vG80/pRbazKS17qAjYJubbw/6CDQEK4QXtYgxsGIzGkFFLvAoRmXsoHiDTSP22Y
 aFvFieYQcjlu/EbgE14Ers3BbDdcLZEEmAy2AX3cLwnj9Sb8QHrpSzurn+MNseCcl60T
 6H5j3KyJ9uBZboIBqAbVqMfq10RCFn3bMJ0U9j7PMU91/E4ayPeoDmjINL8cyZDC77fk
 jwgg==
X-Gm-Message-State: ABy/qLZXWB8Epm+L6/UBsJpt2ovtZ5KL7CvQAf+7sdq0kO7RqMIsZJyv
 7pLvlpv9E1YzIFMtAXffU9o1y8qYgZrTXnRD/Lq0Aa3g
X-Google-Smtp-Source: APBJJlGoq47Bcgj1rhZNtwoIWOBuT/r7/xq6tb9UIecGw0/EQIvkQra/Oyf0/N3+kebdLLwqoRUO7KvoXsWGMmDqJVI=
X-Received: by 2002:a05:6870:b50d:b0:1b4:4a5d:c069 with SMTP id
 v13-20020a056870b50d00b001b44a5dc069mr93714oap.10.1688661891025; Thu, 06 Jul
 2023 09:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-6-shashank.sharma@amd.com>
In-Reply-To: <20230706123602.2331-6-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 12:44:40 -0400
Message-ID: <CADnq5_MNwY6MSaP1+J7hBSvFW_EfcJyqa1fAXeXfs6feTVC4Yg@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] drm/amdgpu: create context space for usermode
 queue
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

On Thu, Jul 6, 2023 at 8:36=E2=80=AFAM Shashank Sharma <shashank.sharma@amd=
.com> wrote:
>
> The FW expects us to allocate at least one page as context
> space to process gang, process, GDS and FW  related work.
> This patch creates a joint object for the same, and calculates
> GPU space offsets for each of these spaces.
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 62 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  4 ++
>  2 files changed, 66 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index e76e1b86b434..7d3b19e08bbb 100644
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
> @@ -6488,6 +6491,57 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_=
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
> +       queue->proc_ctx_gpu_addr =3D ctx->gpu_addr;
> +       queue->gang_ctx_gpu_addr =3D queue->proc_ctx_gpu_addr + AMDGPU_US=
ERQ_PROC_CTX_SZ;
> +       queue->fw_ctx_gpu_addr =3D queue->gang_ctx_gpu_addr + AMDGPU_USER=
Q_GANG_CTX_SZ;
> +
> +       mqd->fw_work_area_base_lo =3D lower_32_bits(queue->fw_ctx_gpu_add=
r);
> +       mqd->fw_work_area_base_lo =3D upper_32_bits(queue->fw_ctx_gpu_add=
r);
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
> @@ -6540,6 +6594,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgp=
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
> @@ -6552,6 +6613,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr=
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
> index 240f92796f00..a5cdb319193d 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -40,10 +40,14 @@ struct amdgpu_usermode_queue {
>         uint64_t                doorbell_handle;
>         uint64_t                doorbell_index;
>         uint64_t                flags;
> +       uint64_t                proc_ctx_gpu_addr;
> +       uint64_t                gang_ctx_gpu_addr;
> +       uint64_t                fw_ctx_gpu_addr;

Is there a way we could store these in some gfx11 structure?  These
are specific to gfx11 and other IPs may have other metadata buffers
they need to allocate.  maybe subclass a gfx11 userq structure or add
a priv ptr off of the the userq structure so IPs can add their
implementation details there.

Alex


Alex

>         struct amdgpu_mqd_prop  *userq_prop;
>         struct amdgpu_userq_mgr *userq_mgr;
>         struct amdgpu_vm        *vm;
>         struct amdgpu_userq_obj mqd;
> +       struct amdgpu_userq_obj fw_obj;
>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.40.1
>

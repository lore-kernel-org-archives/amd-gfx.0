Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE08C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 21:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D53910E61D;
	Fri, 19 May 2023 21:21:35 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3BB10E61D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 21:21:31 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-55517975c5fso100588eaf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684531291; x=1687123291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYFaFceC3ck4gKkyjiR9EGdm9TCNo5DoD3LfonpWhmo=;
 b=pkMxKO9/U6Hyo2TA8nVkrTcfqpMRuqWXduR4T0tV2XIbTxMlG1EsqIpWNgC/fl+03L
 XRZDIV5ZKBwiNOwIfw94Rze+aFlYDoC7OMHyRs8me0tehWJ4BHsexfDjYNZxAJj7CNCf
 woJXV7N+C2+9JBeRETqSeiOaQW5CyxK1yNmZ6p+qjC9hlcHKbLlFtkGvvyK/tAPB3QVs
 IOgEqCvRi0aCVsQqzp0/Ea5zr93Te/+zeaaXaALSUWmdyQhfipleMjvTc9IROnqVyVkZ
 NNJVpToetQg/9qIWmFopa4YsYAXujhzjDM+RbzR0d4acqtp5ezLKHqaZUNCpJcgNWZ7D
 7/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684531291; x=1687123291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYFaFceC3ck4gKkyjiR9EGdm9TCNo5DoD3LfonpWhmo=;
 b=dVdItdWK2iBar/S9+B1dijehqkBrBWoWri9z6zIA5xqrbMIQVCsPyttgZcuppmtXEL
 IOk98aMGE5wLyPwOOqm5CPcpPLBXuwSmW9r6gbRejwInRi+V75bcSdCJ2kV+1u/jyX+T
 z+xz5HtraehHZRduHlQ9Q04bvjxi3MmJj+ziauuF4DT/ijSSmuBvP8tU9VFuT9hBvw6r
 C6n1hyM8hvPXOBPTgNvBGhiOkdmMQ64E8E8coPIO+ghaVJZ0MnhWMWeTpJjxSIiJ1DF6
 sM2COWbpAQocFxKhz/IvBdz8nowZz15ceM87AIr01O2/YgI3KOMdDuXJvCCwf8Ware1D
 KYYQ==
X-Gm-Message-State: AC+VfDx/ITA8SkGOlD68DTPOZ8sJRqWmNtEw0cqepPyfc86Wh7moiyML
 sMV2lR6bXWgm2sA1g2ag7UZfwIERkKZ9I7WzxNE=
X-Google-Smtp-Source: ACHHUZ7mYSrh/kYTBddwcptJkdLEv9wTX/OyxMwhqwfom0Qbb8vhhTqpdEBeThOV76EF2r2mmRohul3W3XNARyv6fwk=
X-Received: by 2002:aca:1b11:0:b0:392:1035:b8c3 with SMTP id
 b17-20020aca1b11000000b003921035b8c3mr1586341oib.1.1684531290744; Fri, 19 May
 2023 14:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-6-shashank.sharma@amd.com>
In-Reply-To: <20230424173836.1441-6-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 17:21:19 -0400
Message-ID: <CADnq5_Pza5G2w5ECAFNzS=fQDpgmZcgyrYaEpoOjCnWwUKwouA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] drm/amdgpu: create context space for usermode
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
Cc: pierre-eric.pelloux-prayer@amd.com, arvind.yadav@amd.com,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 24, 2023 at 1:39=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
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
> V4: Review comments:
>     - Remove shadow from FW space list from cover letter (Alex)
>     - Alignment of macro (Luben)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 ++++++++++++++++++-
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  6 ++
>  2 files changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 9f7b14966ac8..f6b33faea86f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -53,6 +53,11 @@
>  #define GFX11_NUM_GFX_RINGS            1
>  #define GFX11_MEC_HPD_SIZE     2048
>
> +#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
> +#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
> +#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
> +#define AMDGPU_USERQ_GDS_CTX_SZ    PAGE_SIZE
> +
>  #define RLCG_UCODE_LOADING_START_ADDRESS       0x00002000L
>  #define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1       0x1388
>
> @@ -6406,6 +6411,44 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_=
block =3D
>         .funcs =3D &gfx_v11_0_ip_funcs,
>  };
>
> +static int gfx_v11_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mg=
r,
> +                                         struct amdgpu_usermode_queue *q=
ueue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_userq_ctx_space *ctx =3D &queue->fw_space;
> +       int r, size;
> +
> +       /*
> +        * The FW expects at least one page space allocated for
> +        * process ctx, gang ctx, gds ctx, fw ctx each.
> +        */
> +       size =3D AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
> +              AMDGPU_USERQ_GANG_CTX_SZ + AMDGPU_USERQ_GDS_CTX_SZ;
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
> +       queue->gds_ctx_gpu_addr =3D queue->fw_ctx_gpu_addr + AMDGPU_USERQ=
_FW_CTX_SZ;
> +       return 0;
> +}

Please use gfx_v11_0_ naming for consistency.

Alex

> +
> +static void gfx_v11_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_=
mgr,
> +                                           struct amdgpu_usermode_queue =
*queue)
> +{
> +       struct amdgpu_userq_ctx_space *ctx =3D &queue->fw_space;
> +
> +       amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
> +}
> +
>  static int
>  gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_=
usermode_queue *queue)
>  {
> @@ -6426,10 +6469,16 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr =
*uq_mgr, struct amdgpu_usermode
>         }
>
>         memset(mqd->cpu_ptr, 0, size);
> +       r =3D gfx_v11_userq_create_ctx_space(uq_mgr, queue);
> +       if (r) {
> +               DRM_ERROR("Failed to create CTX space for userqueue (%d)\=
n", r);
> +               goto free_mqd;
> +       }
> +
>         r =3D amdgpu_bo_reserve(mqd->obj, false);
>         if (unlikely(r !=3D 0)) {
>                 DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> -               goto free_mqd;
> +               goto free_ctx;
>         }
>
>         queue->userq_prop.use_doorbell =3D true;
> @@ -6438,12 +6487,15 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr =
*uq_mgr, struct amdgpu_usermode
>         amdgpu_bo_unreserve(mqd->obj);
>         if (r) {
>                 DRM_ERROR("Failed to init MQD for queue\n");
> -               goto free_mqd;
> +               goto free_ctx;
>         }
>
>         DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>         return 0;
>
> +free_ctx:
> +       gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
> +
>  free_mqd:
>         amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>         return r;
> @@ -6454,6 +6506,7 @@ gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *=
uq_mgr, struct amdgpu_usermod
>  {
>         struct amdgpu_userq_ctx_space *mqd =3D &queue->mqd;
>
> +       gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>         amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>  }
>
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index e7da27918bd2..11e8ad649f6e 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -38,11 +38,17 @@ struct amdgpu_usermode_queue {
>         int                     queue_id;
>         int                     queue_type;
>         uint64_t                doorbell_handle;
> +       uint64_t                proc_ctx_gpu_addr;
> +       uint64_t                gang_ctx_gpu_addr;
> +       uint64_t                gds_ctx_gpu_addr;
> +       uint64_t                fw_ctx_gpu_addr;
> +       uint64_t                shadow_ctx_gpu_addr;
>         uint64_t                flags;
>         struct amdgpu_mqd_prop  userq_prop;
>         struct amdgpu_userq_mgr *userq_mgr;
>         struct amdgpu_vm        *vm;
>         struct amdgpu_userq_ctx_space mqd;
> +       struct amdgpu_userq_ctx_space fw_space;
>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.40.0
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3826AC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 21:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C5E10E2F3;
	Thu, 30 Mar 2023 21:24:15 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC6410E2F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 21:24:12 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id bl22so1301120oib.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680211451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXgsX//B5vTqGAa46GCIBw3bnjH1UnUfvp5sw4H+saw=;
 b=FWE3YmtEjxuk3ugTUJg3UYabuDsoLfndHz1tsOkmwrPH6tWZ0dhrOaAaTcyWy5MfYU
 Xa03hpwZyxm1vRhYw33JIOwCgWOpDB7sQIa+148Tv3ke2OOl5E6PWOfYTAKjJk1Al6Gr
 FV6W7sO73hIxOekTQ5LADl0LGFGxrSRFvXyeozvk0+g+2IZDiXyzxt2YtbJIffeM0cK3
 OAaGKGcJAwBRKAEdubr3QIkaMSRPtbccFOMf4hRTaNq34+1Tu0S5iuKgVMeSmvg7lfWF
 ZkNjww6Q5WHrUm6Es0fBd93zEM4jXxoytPFeeXp4lFKmjFT/jBzrdMQUTx9IP5HG+c7J
 N83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680211451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXgsX//B5vTqGAa46GCIBw3bnjH1UnUfvp5sw4H+saw=;
 b=Mc48IN207ACorVtzuyBYB2W6ZcYCp9C5AD5a6Dr5SSH859x+ufnUfu8dH65xwDFqzl
 +eZC0PkWaEHQO5WwSMhyeRbtCRuihKIYm/SRiW/XvTMch60jbdmISv4AvKoLDUgYsRSD
 amNL8hp63c+KsI/q85KRcnar0MR9ZTsdUfmM1xCzM3BoPqsQKR8Ca4nvZ6tr6XAENVDe
 wApAw7Uu/udkk/Clru5tO8gESC+hwR/f+hnwVEmFPPr9fhiEHgV6tJbn7gX/JlfAksPR
 Z1myxM+E+268LpMnjW2kN8vDmEyXZTaGKYTGPcuXXvKxXsmy+VynvJ73Q9ViGbggEWqk
 CzKQ==
X-Gm-Message-State: AAQBX9eot+7zROPRC2vGT5jzfnq0B/7wrhwiLgqxNlBFETqkg62RZHps
 CYQ3SPawnJsUQ+juXAk8vQt+KN2QF/7k50MEoXk=
X-Google-Smtp-Source: AKy350auMKHVMceqZj5DOfU5a1AsmIY1ovtno3Cwl39Kotgd2V4ZA/I/BrisswD+HK8R4FvFOMJtUiTWzeGdSPXKyL0=
X-Received: by 2002:a05:6808:2810:b0:389:8025:aae8 with SMTP id
 et16-20020a056808281000b003898025aae8mr835796oib.3.1680211451264; Thu, 30 Mar
 2023 14:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-6-shashank.sharma@amd.com>
In-Reply-To: <20230329160445.1300-6-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 17:23:59 -0400
Message-ID: <CADnq5_OiD5W5w7ZBBhrrGEU8wUvAoavYT2yk1amCYnNRXgA=dQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] drm/amdgpu: create context space for usermode queue
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 12:05=E2=80=AFPM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> The FW expects us to allocate atleast one page as context space to
> process gang, process, shadow, GDS and FW  related work. This patch
> creates a joint object for the same, and calculates GPU space offsets
> for each of these spaces.

The shadow bo, at least, should come from user space since userspace
will want to mess with it to optimize it's register handling at least
for gfx.  The gds and csa could also come from userspace.  That would
simplify things.  The UMD would just specify them in the MQD
descriptor for GFX in the IOCTL.  We could allocate them in the
kernel, but then we'd need to make sure they were mapped into the
GPUVM space for the UMD,  That could get pretty big if they have a lot
of queues.

Alex

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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  1 +
>  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 60 ++++++++++++++++++-
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
>  3 files changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index 052c2c1e8aed..5672efcbcffc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -71,6 +71,7 @@ static int amdgpu_userqueue_create(struct drm_file *fil=
p, union drm_amdgpu_userq
>      queue->userq_prop.queue_size =3D mqd_in->queue_size;
>
>      queue->doorbell_handle =3D mqd_in->doorbell_handle;
> +    queue->shadow_ctx_gpu_addr =3D mqd_in->shadow_va;
>      queue->queue_type =3D mqd_in->ip_type;
>      queue->flags =3D mqd_in->flags;
>      queue->vm =3D &fpriv->vm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> index 12e1a785b65a..52de96727f98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> @@ -23,6 +23,51 @@
>  #include "amdgpu.h"
>  #include "amdgpu_userqueue.h"
>
> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
> +
> +static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr=
 *uq_mgr,
> +                                                 struct amdgpu_usermode_=
queue *queue)
> +{
> +    struct amdgpu_device *adev =3D uq_mgr->adev;
> +    struct amdgpu_userq_ctx_space *ctx =3D &queue->fw_space;
> +    int r, size;
> +
> +    /*
> +     * The FW expects atleast one page space allocated for
> +     * process ctx, gang ctx, gds ctx, fw ctx and shadow ctx each.
> +     */
> +    size =3D AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ +
> +           AMDGPU_USERQ_FW_CTX_SZ + AMDGPU_USERQ_GDS_CTX_SZ;
> +    r =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_GTT,
> +                                &ctx->obj,
> +                                &ctx->gpu_addr,
> +                                &ctx->cpu_ptr);
> +    if (r) {
> +        DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d=
\n", r);
> +        return r;
> +    }
> +
> +    queue->proc_ctx_gpu_addr =3D ctx->gpu_addr;
> +    queue->gang_ctx_gpu_addr =3D queue->proc_ctx_gpu_addr + AMDGPU_USERQ=
_PROC_CTX_SZ;
> +    queue->fw_ctx_gpu_addr =3D queue->gang_ctx_gpu_addr + AMDGPU_USERQ_G=
ANG_CTX_SZ;
> +    queue->gds_ctx_gpu_addr =3D queue->fw_ctx_gpu_addr + AMDGPU_USERQ_FW=
_CTX_SZ;
> +    return 0;
> +}
> +
> +static void amdgpu_userq_gfx_v11_destroy_ctx_space(struct amdgpu_userq_m=
gr *uq_mgr,
> +                                                   struct amdgpu_usermod=
e_queue *queue)
> +{
> +    struct amdgpu_userq_ctx_space *ctx =3D &queue->fw_space;
> +
> +    amdgpu_bo_free_kernel(&ctx->obj,
> +                          &ctx->gpu_addr,
> +                          &ctx->cpu_ptr);
> +}
> +
>  static int
>  amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct =
amdgpu_usermode_queue *queue)
>  {
> @@ -43,10 +88,17 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr, struct amdgpu_u
>      }
>
>      memset(mqd->cpu_ptr, 0, size);
> +
> +    r =3D amdgpu_userq_gfx_v11_create_ctx_space(uq_mgr, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to create CTX space for userqueue (%d)\n", r);
> +        goto free_mqd;
> +    }
> +
>      r =3D amdgpu_bo_reserve(mqd->obj, false);
>      if (unlikely(r !=3D 0)) {
>          DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> -        goto free_mqd;
> +        goto free_ctx;
>      }
>
>      queue->userq_prop.use_doorbell =3D true;
> @@ -55,12 +107,15 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr, struct amdgpu_u
>      amdgpu_bo_unreserve(mqd->obj);
>      if (r) {
>          DRM_ERROR("Failed to init MQD for queue\n");
> -        goto free_mqd;
> +        goto free_ctx;
>      }
>
>      DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>      return 0;
>
> +free_ctx:
> +    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
> +
>  free_mqd:
>      amdgpu_bo_free_kernel(&mqd->obj,
>                            &mqd->gpu_addr,
> @@ -73,6 +128,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_m=
gr *uq_mgr, struct amdgpu_
>  {
>      struct amdgpu_userq_ctx_space *mqd =3D &queue->mqd;
>
> +    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>      amdgpu_bo_free_kernel(&mqd->obj,
>                            &mqd->gpu_addr,
>                            &mqd->cpu_ptr);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index 2911c88d0fed..8b62ef77cd26 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -38,10 +38,17 @@ struct amdgpu_usermode_queue {
>         int queue_type;
>         uint64_t flags;
>         uint64_t doorbell_handle;
> +       uint64_t proc_ctx_gpu_addr;
> +       uint64_t gang_ctx_gpu_addr;
> +       uint64_t gds_ctx_gpu_addr;
> +       uint64_t fw_ctx_gpu_addr;
> +       uint64_t shadow_ctx_gpu_addr;
> +
>         struct amdgpu_vm *vm;
>         struct amdgpu_userq_mgr *userq_mgr;
>         struct amdgpu_mqd_prop userq_prop;
>         struct amdgpu_userq_ctx_space mqd;
> +       struct amdgpu_userq_ctx_space fw_space;
>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.40.0
>

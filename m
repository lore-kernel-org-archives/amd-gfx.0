Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C85FC7EE23
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 21:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C31E10E61E;
	Fri, 19 May 2023 21:23:15 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D4410E61E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 21:23:12 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-54f5fdaa693so846007eaf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 14:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684531391; x=1687123391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyDctQ7/G5TSsYoRM3BnceqaDCCnTJQUrOFokbPPxKM=;
 b=OBWwRy0RgB1kw1q/HtfBx5zPTauxFwc2SjwccbiQ/x1Brz2FfppL7EYCMMs+DDjfsL
 goktQoncXTJSBAMgYMFIC5KREHfkcpuUSkc1RmPGNywZGzbqoronqcVmbrob1ikqsuWk
 CRxTVAGzpQH1zhjma8mrU/G9hCrmNiimkwL4WWomR4eZ0RYioNyKqe3N+iJnqo0LBeRL
 NJu09Sc9YxIode5eq1GQrjxVqTIJ61XSeL9LGO3fSqePqxvlJomi7pVkWsf++bn7K5Xc
 fxD7Uo8n0i/0RvOSFrknYMg/mTWyy0u6i1BNTldjHYuFipd+cido31uIt3hjedNYOovJ
 2LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684531391; x=1687123391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyDctQ7/G5TSsYoRM3BnceqaDCCnTJQUrOFokbPPxKM=;
 b=FSQkDJUWfg7NVx5GBFvoB60aWlZny90ikWzQJUcpvNfHDKhE4wQEMP0TZKcEJh7hxM
 t/4KiwG+Cn9qBvmHeqVWv00VWjzwKaKY5137QeWh7RH0fMxTmdtlL2jgJcjagg2WyYaX
 VPMgiUwNeyxUrPl6na+4aPD7QdpsSkxY3WgR1G2AoU2YTUfpdZVtAVRAl4zLTJ+mWzpn
 o+p0YqORSSF0cCbFKKj9lYC9dX/fdRRZcvkxSeEOAUEjukBKRE9KTBj5HO318f5XAQgE
 0pGfW4IU8zWT+PW/THbpntL/rQRGoAQkiaLyZeh6RG48U+/Dacvo8D8/3dxn4y9n3oUa
 DxNQ==
X-Gm-Message-State: AC+VfDz6xyMIMJW9fFcyf7lBjb1b8xH3x3TptzOC4A84r82vZmRX2HZ9
 Eg8ijuXjfkRmOEVAC3zzzB5/uMajIBJbbRkuIZjPPdSfEXg=
X-Google-Smtp-Source: ACHHUZ73NLKCQAakSCQyCTHycAQIQEHszkpQOo2INHM912Egh1NIYxxedPOyNGsNZqIBMpGPTW2oCoX7KjlqZmZhOfo=
X-Received: by 2002:aca:d757:0:b0:394:3d94:b165 with SMTP id
 o84-20020acad757000000b003943d94b165mr3360088oig.19.1684531391022; Fri, 19
 May 2023 14:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-8-shashank.sharma@amd.com>
In-Reply-To: <20230424173836.1441-8-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 17:22:59 -0400
Message-ID: <CADnq5_OEBcYbks-fTq88+1CKxpfLwWG8gkjHSHO1DE3PLcV3jA@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] drm/amdgpu: map usermode queue into MES
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
> This patch adds new functions to map/unmap a usermode queue into
> the FW, using the MES ring. As soon as this mapping is done, the
> queue would  be considered ready to accept the workload.
>
> V1: Addressed review comments from Alex on the RFC patch series
>     - Map/Unmap should be IP specific.
> V2:
>     Addressed review comments from Christian:
>     - Fix the wptr_mc_addr calculation (moved into another patch)
>     Addressed review comments from Alex:
>     - Do not add fptrs for map/unmap
>
> V3: Integration with doorbell manager
> V4: Rebase
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 67 ++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 86de35292f69..7a45d68091ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -31,6 +31,7 @@
>  #include "amdgpu_smu.h"
>  #include "amdgpu_atomfirmware.h"
>  #include "amdgpu_userqueue.h"
> +#include "amdgpu_mes.h"
>  #include "imu_v11_0.h"
>  #include "soc21.h"
>  #include "nvd.h"
> @@ -6411,6 +6412,64 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_=
block =3D
>         .funcs =3D &gfx_v11_0_ip_funcs,
>  };
>
> +static int gfx_v11_userq_map(struct amdgpu_userq_mgr *uq_mgr,
> +                            struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_add_queue_input queue_input;
> +       int r;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> +
> +       queue_input.process_va_start =3D 0;
> +       queue_input.process_va_end =3D (adev->vm_manager.max_pfn - 1) << =
AMDGPU_GPU_PAGE_SHIFT;
> +       queue_input.process_quantum =3D 100000; /* 10ms */
> +       queue_input.gang_quantum =3D 10000; /* 1ms */
> +       queue_input.paging =3D false;
> +
> +       queue_input.gang_context_addr =3D queue->gang_ctx_gpu_addr;
> +       queue_input.process_context_addr =3D queue->proc_ctx_gpu_addr;
> +       queue_input.inprocess_gang_priority =3D AMDGPU_MES_PRIORITY_LEVEL=
_NORMAL;
> +       queue_input.gang_global_priority_level =3D AMDGPU_MES_PRIORITY_LE=
VEL_NORMAL;
> +
> +       queue_input.process_id =3D queue->vm->pasid;
> +       queue_input.queue_type =3D queue->queue_type;
> +       queue_input.mqd_addr =3D queue->mqd.gpu_addr;
> +       queue_input.wptr_addr =3D queue->userq_prop.wptr_gpu_addr;
> +       queue_input.queue_size =3D queue->userq_prop.queue_size >> 2;
> +       queue_input.doorbell_offset =3D queue->userq_prop.doorbell_index;
> +       queue_input.page_table_base_addr =3D amdgpu_gmc_pd_addr(queue->vm=
->root.bo);
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r) {
> +               DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
> +               return r;
> +       }
> +
> +       DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_i=
d);
> +       return 0;
> +}
> +
> +static void gfx_v11_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +                               struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_remove_queue_input queue_input;
> +       int r;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> +       queue_input.doorbell_offset =3D queue->userq_prop.doorbell_index;
> +       queue_input.gang_context_addr =3D queue->gang_ctx_gpu_addr;
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r)
> +               DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
> +}

gfx_v11_0_ for consistency.

Alex

> +
>  static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>                                         struct amdgpu_usermode_queue *que=
ue)
>  {
> @@ -6507,6 +6566,13 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *=
uq_mgr, struct amdgpu_usermode
>
>         gfx_v11_userq_set_ctx_space(uq_mgr, queue);
>         amdgpu_bo_unreserve(mqd->obj);
> +
> +       /* Map the queue in HW using MES ring */
> +       r =3D gfx_v11_userq_map(uq_mgr, queue);
> +       if (r) {
> +               DRM_ERROR("Failed to map userqueue (%d)\n", r);
> +               goto free_ctx;
> +       }
>         DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>         return 0;
>
> @@ -6523,6 +6589,7 @@ gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *=
uq_mgr, struct amdgpu_usermod
>  {
>         struct amdgpu_userq_ctx_space *mqd =3D &queue->mqd;
>
> +       gfx_v11_userq_unmap(uq_mgr, queue);
>         gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>         amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>  }
> --
> 2.40.0
>

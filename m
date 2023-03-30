Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA42C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 20:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55FEF10E2D9;
	Thu, 30 Mar 2023 20:59:06 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051CD10E2D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 20:59:05 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 i4-20020a056820138400b0053e3ccf739cso2304998oow.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680209944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPOJvPXzs92IW4QJUC6XqOFN4DpGhRxImUxro6tsezw=;
 b=fqe8cOZda3AOJujq4mTSrBw1rdX+5V9YojO0+tT+LrU54MwbQpeBlEQkjc7aevxEVH
 Yw8VY6hmydAIAEoqAyqtNjx8Jh0daGYE8ZC7BrQm/wG37RFGVGXIeGqwZpxdAn4M7QhS
 ytOxrmAjxr6XSW2jCEUwyRFiK5+S/UGaKPG1zBT0QzqFBT3KIfsaBphJto0vqPggr9tF
 BZJFgwAhWvgy/aPD5zi3TbVezZJZUNCVS02DYrYxqH1JzFQLFJHCnNE13r2eRoVwUREY
 XtnfCUT/nFrZdAueqpx0jpaH/2/R7Qj3nmDrY8ZpnxcVIZPBgij5dbHznh1N9nXRgA+C
 3DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680209944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPOJvPXzs92IW4QJUC6XqOFN4DpGhRxImUxro6tsezw=;
 b=nOO1WMuL/j+UCRb9PRzYT0gwYnezLeOF8bjee1clTv3izBqzjQuoJp6ioxQUphBQOZ
 xJfToLw006snKyTlrAgxFm0qGdAIlTEvfHCzx0NE1Wq1XifzCap7vtJUXeiuV/AilzFB
 VgHsJxnALKchOoMWL/co/8bu8eGUJHF/NM0pSVej5KJCobENo57K19Rb7SzoYFPgxjGW
 IIpXHlLbiyH3Qr/DsNgUI5F8ZywNukrLppSNxb15HNoBG8w9MiNEqu6XWvu8xxZH34SA
 uAsmMdrD5M4L1iXezov7Iiq+OvXCHQOtt5hxigv9WZ+VMs5fYaElEetv+BKJ+ZZb3++g
 frWA==
X-Gm-Message-State: AO0yUKXfgbKg0bBK4HRToa04hj3L9Af4sYBBy1u2+Gi0JOjfEWZqsRX2
 UCjyp+RwSxIGt7zTZNAOnUlBEBeRa67LsFrOTf89nYK2
X-Google-Smtp-Source: AK7set+PWyaeNo57R48i/sdtaNQkUpSEmB3yScIJB+u9nLBShhFRSWbOzooKD8wdGRbpdQSIF2XtauhFPd/1Sg6k9cE=
X-Received: by 2002:a4a:e291:0:b0:525:1c3a:f785 with SMTP id
 k17-20020a4ae291000000b005251c3af785mr7028524oot.0.1680209944192; Thu, 30 Mar
 2023 13:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-16-shashank.sharma@amd.com>
In-Reply-To: <20230329154753.1261-16-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 16:58:52 -0400
Message-ID: <CADnq5_M7xn3kkKhBv4xVRQjteuaHufXOYSEpf=rY7DybyEpojw@mail.gmail.com>
Subject: Re: [PATCH 15/16] drm/amdgpu: use doorbell mgr for MES kernel
 doorbells
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 11:48=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> This patch:
> - adds a doorbell object in MES structure, to manage the MES
>   doorbell requirements in kernel.
> - Removes the doorbell management code, and its variables from
>   the doorbell_init function, it will be done in doorbell manager
>   now.
> - creates doorbell pages for MES kernel level needs (doorbells
>   for MES self tests)
> - current MES code was allocating MES doorbells in MES process context,
>   but those were rung using kernel doorbell calls. This patch allocates
>   MES kernel doorbells instead for this in add_hw_queue.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 105 ++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |   5 +-
>  2 files changed, 56 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 0c546245793b..423cd642647c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -65,91 +65,89 @@ unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar=
(
>                 doorbell_id * 2);
>  }
>
> -static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
> +static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
>                                          struct amdgpu_mes_process *proce=
ss,
>                                          int ip_type, uint64_t *doorbell_=
index)
>  {
>         unsigned int offset, found;
> +       struct amdgpu_doorbell_obj *doorbells =3D &adev->mes.kernel_doorb=
ells;
>
> -       if (ip_type =3D=3D AMDGPU_RING_TYPE_SDMA) {
> +       if (ip_type =3D=3D AMDGPU_RING_TYPE_SDMA)
>                 offset =3D adev->doorbell_index.sdma_engine[0];
> -               found =3D find_next_zero_bit(process->doorbell_bitmap,
> -                                          AMDGPU_MES_MAX_NUM_OF_QUEUES_P=
ER_PROCESS,
> -                                          offset);
> -       } else {
> -               found =3D find_first_zero_bit(process->doorbell_bitmap,
> -                                           AMDGPU_MES_MAX_NUM_OF_QUEUES_=
PER_PROCESS);
> -       }
> +       else
> +               offset =3D 0;
>
> +       found =3D find_next_zero_bit(doorbells->doorbell_bitmap,
> +                                  AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCE=
SS,
> +                                  offset);
>         if (found >=3D AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS) {
>                 DRM_WARN("No doorbell available\n");
>                 return -ENOSPC;
>         }
>
> -       set_bit(found, process->doorbell_bitmap);
> +       set_bit(found, doorbells->doorbell_bitmap);
>
> -       *doorbell_index =3D amdgpu_mes_get_doorbell_dw_offset_in_bar(adev=
,
> -                               process->doorbell_index, found);
> +       *doorbell_index =3D amdgpu_doorbell_index_on_bar(adev, doorbells-=
>bo, found);
>
>         return 0;
>  }
>
> -static void amdgpu_mes_queue_doorbell_free(struct amdgpu_device *adev,
> +static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
>                                            struct amdgpu_mes_process *pro=
cess,
>                                            uint32_t doorbell_index)
>  {
>         unsigned int old, doorbell_id;
> +       struct amdgpu_doorbell_obj *doorbells =3D &adev->mes.kernel_doorb=
ells;
>
> -       doorbell_id =3D doorbell_index -
> -               (process->doorbell_index *
> -                amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32);
> +       /* Find the relative index of the doorbell in this object */
> +       doorbell_id =3D doorbell_index - doorbells->start;
>         doorbell_id /=3D 2;
>
> -       old =3D test_and_clear_bit(doorbell_id, process->doorbell_bitmap)=
;
> +       old =3D test_and_clear_bit(doorbell_id, doorbells->doorbell_bitma=
p);
>         WARN_ON(!old);
>  }
>
>  static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
>  {
> -       size_t doorbell_start_offset;
> -       size_t doorbell_aperture_size;
> -       size_t doorbell_process_limit;
> -       size_t aggregated_doorbell_start;
> -       int i;
> -
> -       aggregated_doorbell_start =3D (adev->doorbell_index.max_assignmen=
t + 1) * sizeof(u32);
> -       aggregated_doorbell_start =3D
> -               roundup(aggregated_doorbell_start, PAGE_SIZE);
> -
> -       doorbell_start_offset =3D aggregated_doorbell_start + PAGE_SIZE;
> -       doorbell_start_offset =3D
> -               roundup(doorbell_start_offset,
> -                       amdgpu_mes_doorbell_process_slice(adev));
> -
> -       doorbell_aperture_size =3D adev->doorbell.size;
> -       doorbell_aperture_size =3D
> -                       rounddown(doorbell_aperture_size,
> -                                 amdgpu_mes_doorbell_process_slice(adev)=
);
> -
> -       if (doorbell_aperture_size > doorbell_start_offset)
> -               doorbell_process_limit =3D
> -                       (doorbell_aperture_size - doorbell_start_offset) =
/
> -                       amdgpu_mes_doorbell_process_slice(adev);
> -       else
> -               return -ENOSPC;
> +       int i, r;
> +       u32 agg_db_start_index, nbits;
> +       struct amdgpu_doorbell_obj *mes_doorbells =3D &adev->mes.kernel_d=
oorbells;
>
> -       adev->mes.doorbell_id_offset =3D doorbell_start_offset / sizeof(u=
32);
> -       adev->mes.max_doorbell_slices =3D doorbell_process_limit;
> +               /* Allocated one page doorbells for MES kernel usages */
> +       mes_doorbells->size =3D PAGE_SIZE;
>
> -       /* allocate Qword range for aggregated doorbell */
> -       for (i =3D 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++)
> -               adev->mes.aggregated_doorbells[i] =3D
> -                       aggregated_doorbell_start / sizeof(u32) + i * 2;
> +       nbits =3D DIV_ROUND_UP(mes_doorbells->size, sizeof(u32));
> +       mes_doorbells->doorbell_bitmap =3D bitmap_zalloc(nbits, GFP_KERNE=
L);
> +       if (!mes_doorbells->doorbell_bitmap) {
> +               DRM_ERROR("Failed to allocate MES doorbell bitmap\n");
> +               return -ENOMEM;
> +       }
> +
> +       r =3D amdgpu_doorbell_alloc_page(adev, mes_doorbells);

Rather than allocating a separate page here, just allocate two pages
in the earlier patch where you allocate the KGD doorbell and then just
use the second page here.

Alex

> +       if (r) {
> +               DRM_ERROR("Failed to create MES doorbell object\n, err=3D=
%d", r);
> +               bitmap_free(mes_doorbells->doorbell_bitmap);
> +               return r;
> +       }
> +
> +       /* Get the absolute doorbell index for aggregated doobells */
> +       agg_db_start_index =3D mes_doorbells->start;
> +       for (i =3D 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++) {
> +               adev->mes.aggregated_doorbells[i] =3D agg_db_start_index =
+ i;
> +               set_bit(agg_db_start_index + i, mes_doorbells->doorbell_b=
itmap);
> +       }
>
> -       DRM_INFO("max_doorbell_slices=3D%zu\n", doorbell_process_limit);
>         return 0;
>  }
>
> +static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_doorbell_obj *mes_doorbells =3D &adev->mes.kernel_d=
oorbells;
> +
> +       bitmap_free(mes_doorbells->doorbell_bitmap);
> +       amdgpu_doorbell_free_page(adev, mes_doorbells);
> +}
> +
>  int amdgpu_mes_init(struct amdgpu_device *adev)
>  {
>         int i, r;
> @@ -248,6 +246,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>         amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
>         amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
>         amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
> +       amdgpu_mes_doorbell_free(adev);
>
>         idr_destroy(&adev->mes.pasid_idr);
>         idr_destroy(&adev->mes.gang_id_idr);
> @@ -677,7 +676,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *ade=
v, int gang_id,
>         *queue_id =3D queue->queue_id =3D r;
>
>         /* allocate a doorbell index for the queue */
> -       r =3D amdgpu_mes_queue_doorbell_get(adev, gang->process,
> +       r =3D amdgpu_mes_kernel_doorbell_get(adev, gang->process,
>                                           qprops->queue_type,
>                                           &qprops->doorbell_off);
>         if (r)
> @@ -735,7 +734,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *ade=
v, int gang_id,
>         return 0;
>
>  clean_up_doorbell:
> -       amdgpu_mes_queue_doorbell_free(adev, gang->process,
> +       amdgpu_mes_kernel_doorbell_free(adev, gang->process,
>                                        qprops->doorbell_off);
>  clean_up_queue_id:
>         spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
> @@ -790,7 +789,7 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *=
adev, int queue_id)
>                           queue_id);
>
>         list_del(&queue->list);
> -       amdgpu_mes_queue_doorbell_free(adev, gang->process,
> +       amdgpu_mes_kernel_doorbell_free(adev, gang->process,
>                                        queue->doorbell_off);
>         amdgpu_mes_unlock(&adev->mes);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 97c05d08a551..e7e9dfe44c99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -27,6 +27,7 @@
>  #include "amdgpu_irq.h"
>  #include "kgd_kfd_interface.h"
>  #include "amdgpu_gfx.h"
> +#include "amdgpu_doorbell.h"
>  #include <linux/sched/mm.h>
>
>  #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
> @@ -76,7 +77,6 @@ struct amdgpu_mes {
>         uint32_t                        kiq_version;
>
>         uint32_t                        total_max_queue;
> -       uint32_t                        doorbell_id_offset;
>         uint32_t                        max_doorbell_slices;
>
>         uint64_t                        default_process_quantum;
> @@ -128,6 +128,9 @@ struct amdgpu_mes {
>         int                             (*kiq_hw_init)(struct amdgpu_devi=
ce *adev);
>         int                             (*kiq_hw_fini)(struct amdgpu_devi=
ce *adev);
>
> +       /* MES Kernel doorbells */
> +       struct amdgpu_doorbell_obj      kernel_doorbells;
> +
>         /* ip specific functions */
>         const struct amdgpu_mes_funcs   *funcs;
>  };
> --
> 2.40.0
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A190C83F12
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 22:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6443510E367;
	Mon, 28 Aug 2023 22:47:49 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E773210E367
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 22:47:47 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5734b893a11so2125040eaf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693262867; x=1693867667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDSF55kN6ZZZ45j6OR57/tPM8V/639a3P5Zv663JDMA=;
 b=hSrAUf6Yqjjg99vGsRfUfPKw3YTc8TZvbYOUDcJ8VL4r8/rtDwZBfdlkxA4f0+ePnp
 KWg+ohWfKqf/37j7dXy9HVCk6klLhnejVusfcAmhBPGs22qlc12dE11vq9OJ4GLIppEG
 bvWQJ5ig0sEoXGg2/uYwGEVZODwVsZTKKGcBFHn9US0V4Ft+kPoWUsmzk8HAsCC/TfPl
 VDM6QXXdJ0jwxngOlqjzseTS/Nb3T6NqciSumzIlHBPAvmD9qRzipDmoi7qVLZSyA1AH
 Ko+MCOcg5aW/B+rh2Cz1EyLAhOJErWm87CpgZKs2wpwWUU/UDIF3os1QYA8dz0qaLjEh
 3bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693262867; x=1693867667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDSF55kN6ZZZ45j6OR57/tPM8V/639a3P5Zv663JDMA=;
 b=hHZ6sCrjpKisBsOmxsKWwjYYGoGPbSQ8LOsDYomZOiEI+mtOivpICZiRH5/QcRtwzN
 URX4MLiyDdLo7QQHNpacr2XysNeskyVZvQGC1x4cDFpyH8jP7vyRFgu3mptnCacqqSN2
 tUIDaQXZ+QT0n3jgcIm4CA/j0Xz1v6eWcfeFWKy4smk+35FIj9qCuMT8qHRdxs8LEs8C
 XOjrTyQALKuL5CYWBFcrg5V+QNOlSOJMBAvDXaNU79DngBKfPuac/HQVSKWslJ6J+BeY
 yhuEGrx1KXFfI2B7Ix8Z1LJXyfz8uH5jwi1ut78hQcQX+Hxu+E65qRfCif27VFO0jRqT
 /zHg==
X-Gm-Message-State: AOJu0YxU9A2+Jq6UbrJ1RbrdkG96sdszf1U2nmrrmEj+usu3I+caiwxI
 0vgzThIx+qAe81mvvw7UZ1Doj5gDli+lecnhwCo=
X-Google-Smtp-Source: AGHT+IGo5Gj4ch+LVvJl0A6yHQeDuPqleii7LIUkxoiu3DKYd4LUIuyGkExYUKyF3i8t4LxuEUTS4VxJ90NRypfUwQU=
X-Received: by 2002:a4a:dfc5:0:b0:56c:7120:835f with SMTP id
 p5-20020a4adfc5000000b0056c7120835fmr14372582ood.5.1693262866929; Mon, 28 Aug
 2023 15:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230825191411.3276216-1-David.Francis@amd.com>
In-Reply-To: <20230825191411.3276216-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Aug 2023 18:47:35 -0400
Message-ID: <CADnq5_Prfxt1LXjAOO9zOrpgR9AMikWzp-NdwtHUVhsqLvmMoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Checkpoint and restore queues on GFX11
To: David Francis <David.Francis@amd.com>
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
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Aug 25, 2023 at 4:10=E2=80=AFPM David Francis <David.Francis@amd.co=
m> wrote:
>
> The code in kfd_mqd_manager_v11.c to support criu dump and
> restore of queue state was missing.
>
> Added it; should be equivalent to kfd_mqd_manager_v10.c.
>
> CC: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 2319467d2d95..2a79d37da95d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -321,6 +321,43 @@ static int get_wave_state(struct mqd_manager *mm, vo=
id *mqd,
>         return 0;
>  }
>
> +static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_=
dst, void *ctl_stack_dst)
> +{
> +       struct v11_compute_mqd *m;
> +
> +       m =3D get_mqd(mqd);
> +
> +       memcpy(mqd_dst, m, sizeof(struct v11_compute_mqd));
> +}
> +
> +static void restore_mqd(struct mqd_manager *mm, void **mqd,
> +                       struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_a=
ddr,
> +                       struct queue_properties *qp,
> +                       const void *mqd_src,
> +                       const void *ctl_stack_src, const u32 ctl_stack_si=
ze)
> +{
> +       uint64_t addr;
> +       struct v11_compute_mqd *m;
> +
> +       m =3D (struct v11_compute_mqd *) mqd_mem_obj->cpu_ptr;
> +       addr =3D mqd_mem_obj->gpu_addr;
> +
> +       memcpy(m, mqd_src, sizeof(*m));
> +
> +       *mqd =3D m;
> +       if (gart_addr)
> +               *gart_addr =3D addr;
> +
> +       m->cp_hqd_pq_doorbell_control =3D
> +               qp->doorbell_off <<
> +                       CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIF=
T;
> +       pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
> +                       m->cp_hqd_pq_doorbell_control);
> +
> +       qp->is_active =3D 0;
> +}
> +
> +
>  static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
>                         struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_a=
ddr,
>                         struct queue_properties *q)
> @@ -457,6 +494,8 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD=
_TYPE type,
>                 mqd->is_occupied =3D kfd_is_occupied_cp;
>                 mqd->mqd_size =3D sizeof(struct v11_compute_mqd);
>                 mqd->get_wave_state =3D get_wave_state;
> +               mqd->checkpoint_mqd =3D checkpoint_mqd;
> +               mqd->restore_mqd =3D restore_mqd;
>  #if defined(CONFIG_DEBUG_FS)
>                 mqd->debugfs_show_mqd =3D debugfs_show_mqd;
>  #endif
> @@ -500,6 +539,8 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD=
_TYPE type,
>                 mqd->update_mqd =3D update_mqd_sdma;
>                 mqd->destroy_mqd =3D kfd_destroy_mqd_sdma;
>                 mqd->is_occupied =3D kfd_is_occupied_sdma;
> +               mqd->checkpoint_mqd =3D checkpoint_mqd;
> +               mqd->restore_mqd =3D restore_mqd;
>                 mqd->mqd_size =3D sizeof(struct v11_sdma_mqd);
>  #if defined(CONFIG_DEBUG_FS)
>                 mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdma;
> --
> 2.34.1
>

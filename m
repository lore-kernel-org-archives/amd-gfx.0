Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EC5C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 12:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB51510E111;
	Wed, 17 May 2023 12:11:34 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3039F10E111
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 12:11:33 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-54fd1a3b821so267559eaf.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684325492; x=1686917492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3om6D2OXy6Z6SX/URbUSi4bXcsxpe+m243Rq1Fgqz8=;
 b=mEoLSx8JLFA+U/60wlEyf+k386iUQY4FlyX1gLOLGpT6nVIgkUJOSvdpZPQRFUhh6w
 Wbp/XAS/b48oUaE/wjHN2BuWoC4pGQZKPyS1jtqCRb/j38FelzIo86Fld6Rfp4Rj/wOq
 Kb/XAS4emYenwoQsAp9926mFImS4VXVjI0Q1vRn1dEjCFiEplRUkfR6AHuKr9pRXkwO1
 lPKK5ulT9sU1KENnK0HT3p4m6Dz4wJmebBDb3Xpi+FqKyYFffZlRkATcjR6LrIf/2xdu
 KQqaFPocLEuW+v4+Lac7XE7RkQGekCa9dscblI35XVHoF6YjTMp6KyEZDY5MZpmWk4uH
 lT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684325492; x=1686917492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3om6D2OXy6Z6SX/URbUSi4bXcsxpe+m243Rq1Fgqz8=;
 b=D2XAUopFnhB1aQBASp0b9K3RvdZ+WwRC8fkcoYJDay8ZAx9SyQmmSaEjxPuSoVUa8S
 Pvw9hQ4FUA6geQNq2hpyejWP+OJccHDgD84ncTWb8H2HU9FUfwG8wNhSyXXmNW1wtc95
 Mv/96AERRK2wrJh46qTBVmvL90nzutT5Md5ta/TsnXq6lutfMsia2k7m7wADfK/VJsx4
 pUzvvibJx4JQPzONFTiRWd73YEmlJxTgBohKn+pWLVj1BHIXGzl7fofZFvEEZftII8Sp
 vBJGRfyWQ1e1RAvrIevdEVS+H1xFtOOcI4VCrXvdwU+MawuEn5kB6q4piRS/aiFpdZpn
 Sf4Q==
X-Gm-Message-State: AC+VfDwU/LuPRBzgJ59Rt8r5cBxOwKnjgk68LINMjlS0jBPrcAXt5SWK
 unhoh3ne59GChlNZbaf6uUQVhdsy/xB9Z75NSes=
X-Google-Smtp-Source: ACHHUZ73j5CUj8WWy4mecKST3t7Tb8JL9ywtwuJzzp1x8uuah92uydOKVgNK4M7KaS9wG5ELlNOV621UX23lfIWi37o=
X-Received: by 2002:a05:6808:4f:b0:389:7c1e:3b83 with SMTP id
 v15-20020a056808004f00b003897c1e3b83mr14417028oic.32.1684325491882; Wed, 17
 May 2023 05:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230517094442.1395378-1-Jack.Xiao@amd.com>
In-Reply-To: <20230517094442.1395378-1-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 May 2023 08:11:20 -0400
Message-ID: <CADnq5_PPijdHQGpXeSOjXeUW-HFbQ1GuUPYC9dnCNTPMOuJVZw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix S3 issue if MQD in VRAM
To: Jack Xiao <Jack.Xiao@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for fixing this up.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, May 17, 2023 at 5:45=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote=
:
>
> 1. Need flush HDP for MQD putting in vram
> 2. Zero out mes MQD
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 3 +++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 3 +++
>  3 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 8883d5ee13cb..f2d0b1d55d77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -593,6 +593,8 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev,=
 int xcc_id)
>
>         DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring=
->pipe,
>                                                         kiq_ring->queue);
> +       amdgpu_device_flush_hdp(adev, NULL);
> +
>         spin_lock(&kiq->ring_lock);
>         r =3D amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
>                                         adev->gfx.num_compute_rings +
> @@ -630,6 +632,8 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev,=
 int xcc_id)
>         if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
>                 return -EINVAL;
>
> +       amdgpu_device_flush_hdp(adev, NULL);
> +
>         spin_lock(&kiq->ring_lock);
>         /* No need to map kcq on the slave */
>         if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v10_1.c
> index f1a6abdad21b..88262f10ef7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -632,6 +632,8 @@ static int mes_v10_1_mqd_init(struct amdgpu_ring *rin=
g)
>         uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
>         uint32_t tmp;
>
> +       memset(mqd, 0, sizeof(*mqd));
> +
>         mqd->header =3D 0xC0310800;
>         mqd->compute_pipelinestat_enable =3D 0x00000001;
>         mqd->compute_static_thread_mgmt_se0 =3D 0xffffffff;
> @@ -728,6 +730,7 @@ static int mes_v10_1_mqd_init(struct amdgpu_ring *rin=
g)
>         /* offset: 184 - this is used for CP_HQD_GFX_CONTROL */
>         mqd->cp_hqd_suspend_cntl_stack_offset =3D tmp;
>
> +       amdgpu_device_flush_hdp(ring->adev, NULL);
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 9791f3581786..9a48328c6572 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -704,6 +704,8 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *rin=
g)
>         uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
>         uint32_t tmp;
>
> +       memset(mqd, 0, sizeof(*mqd));
> +
>         mqd->header =3D 0xC0310800;
>         mqd->compute_pipelinestat_enable =3D 0x00000001;
>         mqd->compute_static_thread_mgmt_se0 =3D 0xffffffff;
> @@ -797,6 +799,7 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *rin=
g)
>         mqd->cp_hqd_iq_timer =3D regCP_HQD_IQ_TIMER_DEFAULT;
>         mqd->cp_hqd_quantum =3D regCP_HQD_QUANTUM_DEFAULT;
>
> +       amdgpu_device_flush_hdp(ring->adev, NULL);
>         return 0;
>  }
>
> --
> 2.37.3
>

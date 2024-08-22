Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49273C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 13:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F6510EA9A;
	Thu, 22 Aug 2024 13:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hLESzapn";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C793410EA9A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 13:27:35 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-20212f701c9so433215ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724333255; x=1724938055; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4L2bZQ2VjmrO1AwOQrUkDYcj/RmQwdeI49O8FJP18FM=;
 b=hLESzapn8uQzZqYOUXUYfkX750Ax9ovbTSFQ4pCbRPO/gS4/KlVJrzTFTnfkTcaa3K
 T3l6a0QRQk7HYVDECzEbNIDIrujoh4K8mEjyxhDFhLkJ1NyyTu6mXylI9ThG38USfH/x
 e7BmQ2vc7ETWKgY7xD+rdTCHhkW7f5S5u+O02mf4654HdMEBsrvrMT1cSI6kp9rdv2eE
 r1RVf6GM9W+PMLcNcmSFGFWrv9iKEJ7lBokMYc6d3mgAHBTug64nhB0TSEnGbcZDM9GA
 EKNh3pCxcgsh7awc8/O/jxo6CZNf/+Te92sn3U3G22mn7ymxorxiCixwXlas0MLDW2v3
 VedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724333255; x=1724938055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4L2bZQ2VjmrO1AwOQrUkDYcj/RmQwdeI49O8FJP18FM=;
 b=TQsfTskwlPaXzXxfIDnE1JfFvoPfErmpVa+C3XW+Y5eCC/IQiv8E3iI+wXT9N0eWy6
 fJUxEnq8uZaWQdGd5Zz0PeIFkJMxKM606+ub3Fxs28S0LGr/2VXi35W5IOLaauUxXHi0
 4WVmQvnS5zyUEEw5oJ7Oz2Qx0S8elWmZARLfPYsBeERZLPjjN4aH3p359pk25ys4k8kV
 N9ByOa9MLsgBAMSME4+aaiyU8gFarPiHSIwM+7vYlpz+oUm0FBMU0qfOI5R/xzwcuuOP
 3rwTpK6RdSpsF1jN4SsTdVptM+YNyeFZWmIhsnzBzs6GBxABl2zP+sJles4Zo7G3yeD1
 rNWQ==
X-Gm-Message-State: AOJu0Yw241qZ2k9IhQkEMt5T57tx5pTEbkyp30KMOPbtwAsi1JG7hkj9
 9RcLjs96X10agF7YKSkOF3ic7sT3K0cB924Cy9LV8Dp7jEXRHEqNaEa3cdSh9P7PC6+AKR3Dwz4
 0XVSXZD3/cAMMcaMAJvcgsiet3K6wPIWc
X-Google-Smtp-Source: AGHT+IGx9yYITdi4YZVCcogjl4qBVvp3/iMfq7pJyV17eFp58D8Z+/01K93SiJnLP4g76isGBXT1Xhz8ybfMPulwq+0=
X-Received: by 2002:a17:902:c947:b0:1fc:5cc8:bb1b with SMTP id
 d9443c01a7336-2036808e83dmr35276605ad.7.1724333254977; Thu, 22 Aug 2024
 06:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240822102830.2277414-1-Jack.Xiao@amd.com>
In-Reply-To: <20240822102830.2277414-1-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Aug 2024 09:27:23 -0400
Message-ID: <CADnq5_OfaepuNfUR9L675mG_yOf1oo_J0GaoDyFFNG5Onjnqyg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: add mes mapping legacy queue switch
To: Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 amworsley@gmail.com, marek.olsak@amd.com
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

On Thu, Aug 22, 2024 at 6:55=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote=
:
>
> For mes11 old firmware has issue to map legacy queue,
> add a flag to switch mes to map legacy queue.
>

Reported-by: Andrew Worsley <amworsley@gmail.com>
Link: https://lists.freedesktop.org/archives/amd-gfx/2024-August/112773.htm=
l

> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 49 +++++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  9 +++--
>  4 files changed, 43 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 9be8cafdcecc..3ff39d3ec317 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -657,7 +657,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev,=
 int xcc_id)
>         uint64_t queue_mask =3D 0;
>         int r, i, j;
>
> -       if (adev->enable_mes)
> +       if (adev->mes.enable_legacy_queue_map)
>                 return amdgpu_gfx_mes_enable_kcq(adev, xcc_id);
>
>         if (!kiq->pmf || !kiq->pmf->kiq_map_queues || !kiq->pmf->kiq_set_=
resources)
> @@ -719,7 +719,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev,=
 int xcc_id)
>
>         amdgpu_device_flush_hdp(adev, NULL);
>
> -       if (adev->enable_mes) {
> +       if (adev->mes.enable_legacy_queue_map) {
>                 for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                         j =3D i + xcc_id * adev->gfx.num_gfx_rings;
>                         r =3D amdgpu_mes_map_legacy_queue(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 548e724e3a75..a509dbed858e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -75,6 +75,7 @@ struct amdgpu_mes {
>
>         uint32_t                        sched_version;
>         uint32_t                        kiq_version;
> +       bool                            enable_legacy_queue_map;
>
>         uint32_t                        total_max_queue;
>         uint32_t                        max_doorbell_slices;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index c0340ee3dec0..dfe51e41504a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -726,6 +726,28 @@ static void mes_v11_0_free_ucode_buffers(struct amdg=
pu_device *adev,
>                               (void **)&adev->mes.ucode_fw_ptr[pipe]);
>  }
>
> +static void mes_v11_0_get_fw_version(struct amdgpu_device *adev)
> +{
> +       int pipe;
> +
> +       /* get MES scheduler/KIQ versions */
> +       mutex_lock(&adev->srbm_mutex);
> +
> +       for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
> +               soc21_grbm_select(adev, 3, pipe, 0, 0);
> +
> +               if (pipe =3D=3D AMDGPU_MES_SCHED_PIPE)
> +                       adev->mes.sched_version =3D
> +                               RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
> +               else if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE && adev->enable_=
mes_kiq)
> +                       adev->mes.kiq_version =3D
> +                               RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
> +       }
> +
> +       soc21_grbm_select(adev, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +}

I think we can also get this from the firmware binary?  Either way the patc=
h is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +
>  static void mes_v11_0_enable(struct amdgpu_device *adev, bool enable)
>  {
>         uint64_t ucode_addr;
> @@ -1095,18 +1117,6 @@ static int mes_v11_0_queue_init(struct amdgpu_devi=
ce *adev,
>                 mes_v11_0_queue_init_register(ring);
>         }
>
> -       /* get MES scheduler/KIQ versions */
> -       mutex_lock(&adev->srbm_mutex);
> -       soc21_grbm_select(adev, 3, pipe, 0, 0);
> -
> -       if (pipe =3D=3D AMDGPU_MES_SCHED_PIPE)
> -               adev->mes.sched_version =3D RREG32_SOC15(GC, 0, regCP_MES=
_GP3_LO);
> -       else if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
> -               adev->mes.kiq_version =3D RREG32_SOC15(GC, 0, regCP_MES_G=
P3_LO);
> -
> -       soc21_grbm_select(adev, 0, 0, 0, 0);
> -       mutex_unlock(&adev->srbm_mutex);
> -
>         return 0;
>  }
>
> @@ -1353,15 +1363,24 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_de=
vice *adev)
>
>         mes_v11_0_enable(adev, true);
>
> +       mes_v11_0_get_fw_version(adev);
> +
>         mes_v11_0_kiq_setting(&adev->gfx.kiq[0].ring);
>
>         r =3D mes_v11_0_queue_init(adev, AMDGPU_MES_KIQ_PIPE);
>         if (r)
>                 goto failure;
>
> -       r =3D mes_v11_0_hw_init(adev);
> -       if (r)
> -               goto failure;
> +       if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x47=
)
> +               adev->mes.enable_legacy_queue_map =3D true;
> +       else
> +               adev->mes.enable_legacy_queue_map =3D false;
> +
> +       if (adev->mes.enable_legacy_queue_map) {
> +               r =3D mes_v11_0_hw_init(adev);
> +               if (r)
> +                       goto failure;
> +       }
>
>         return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 0f1702a78170..f0d58295d31d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -1300,6 +1300,7 @@ static int mes_v12_0_sw_init(void *handle)
>         adev->mes.funcs =3D &mes_v12_0_funcs;
>         adev->mes.kiq_hw_init =3D &mes_v12_0_kiq_hw_init;
>         adev->mes.kiq_hw_fini =3D &mes_v12_0_kiq_hw_fini;
> +       adev->mes.enable_legacy_queue_map =3D true;
>
>         adev->mes.event_log_size =3D AMDGPU_MES_LOG_BUFFER_SIZE;
>
> @@ -1456,9 +1457,11 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_dev=
ice *adev)
>                 mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_KIQ_P=
IPE);
>         }
>
> -       r =3D mes_v12_0_hw_init(adev);
> -       if (r)
> -               goto failure;
> +       if (adev->mes.enable_legacy_queue_map) {
> +               r =3D mes_v12_0_hw_init(adev);
> +               if (r)
> +                       goto failure;
> +       }
>
>         return r;
>
> --
> 2.41.0
>

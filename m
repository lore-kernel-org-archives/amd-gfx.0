Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A22C54798
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 16:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E3210EC5D;
	Fri, 23 Feb 2024 16:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQf0b+HF";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6E810EC60
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 16:30:55 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-29938dcb711so829705a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 08:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708705854; x=1709310654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGR232ZcqwuvuLAysDmaVRfgXH1M1DRNmBVmHlknB+I=;
 b=QQf0b+HF9DEvcfXIdVEFyIYBDpsmVuS7fTZhdTEh2ylPu8wa/9jkt/JrLcO4ExxQ9R
 hf9dgjEj2D4J78AGRDzFX4oIwsvcIOyb9VlK1Kb+wYCVpYsamcpYFRiKgQjLJsX30g+Q
 mXirt8Jfgw+5iGJC+JFggGqTyVN05QnYn7AZTMOlge1wPzuFbSNqi9uaQLNADIuNz+NO
 nFm8ymmJiLHn1kFZblail9xQWr5coLEj0LwkwJCbzPsS/BDW9Zno3Fwk0CMhxrKLYh23
 kdseCHhIc4jBsSAtqHTiOGBjD7jTkVDtmqnvonFFcEQtuTyp2A7TPXbZbsVHLNdTkhZa
 bTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705854; x=1709310654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGR232ZcqwuvuLAysDmaVRfgXH1M1DRNmBVmHlknB+I=;
 b=AcE8/FFqkJ3O/dwW+NZmKaWbaJyMWTxZjm9MEXdtC+saJbQgtE77uN07ht3w2eaH/N
 bliAjRoE/8BDrb+K9Tb3pOOr61a1hMtNIXDJ9UPbGnaNwnRHsW5Cup1gM8Ovh3Vo7b/X
 bz0S2YIfBL2gy3sAGFJ9dnWfADU6nCNCldkSDJUbb/ecKNrXAjuhhnb0lTzlSwIMir2V
 Xk3FleyRgCl4uQj7l00oIbCsiUy7ghZvCpi+wFJ55w+mpv0cRpo60RWgCZhGKU1Zfa0K
 NzVSnQlYcsG5UkXenH2x+IUwUNTAZKgJ+b9OZX+FomPmvWj2xLsYnYazGn4a7sZkfRBw
 /zZg==
X-Gm-Message-State: AOJu0YzZ+Wo5EHyfnA3mg74isVpEPzsm2v1ZwnfJb5NvPQNVOCn8s7h9
 YysknsxheeF9eQFaTzyql/JYoLAl3w+uNbkVYuMQnAAPIxNytf5BnnZAQRJkJVQaBWIDns2eVXv
 Lb1PiMrGq4c/t7xhUyMYNWq6KOfI=
X-Google-Smtp-Source: AGHT+IEGNz4vs2IQ3WT0A3xXOscaEezFEeTaZUnJn1lRM2MdL7dO5yEYJYg7ekj4sT6qOHBGNqACP4+01YqCuRGrmeY=
X-Received: by 2002:a17:90a:5107:b0:299:5913:db15 with SMTP id
 t7-20020a17090a510700b002995913db15mr295360pjh.29.1708705854401; Fri, 23 Feb
 2024 08:30:54 -0800 (PST)
MIME-Version: 1.0
References: <20240223094132.880396-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20240223094132.880396-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Feb 2024 11:30:43 -0500
Message-ID: <CADnq5_MLkUTnLE=eFFSEV5gEq0gd3GobB5Pwsf5dJfG0MPOEgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable ring_muxer if mcbp is off
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Fri, Feb 23, 2024 at 4:48=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Using the ring_muxer without preemption adds overhead for no
> reason since mcbp cannot be triggered.
>
> Moving back to a single queue in this case also helps when
> high priority app are used: in this case the gpu_scheduler
> priority handling will work as expected - much better than
> ring_muxer with its 2 independant schedulers competing for
> the same hardware queue.
>
> This change requires moving amdgpu_device_set_mcbp above
> amdgpu_device_ip_early_init because we use adev->gfx.mcbp.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 21 ++++++++++++---------
>  2 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index d534e192e260..40516d24026c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4054,13 +4054,13 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
>                 return r;
>         }
>
> +       amdgpu_device_set_mcbp(adev);
> +
>         /* early init functions */
>         r =3D amdgpu_device_ip_early_init(adev);
>         if (r)
>                 return r;
>
> -       amdgpu_device_set_mcbp(adev);
> -
>         /* Get rid of things like offb */
>         r =3D drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev=
, &amdgpu_kms_driver);
>         if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 169d45268ef6..f682f830f7f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2080,7 +2080,7 @@ static int gfx_v9_0_sw_init(void *handle)
>                 ring->doorbell_index =3D adev->doorbell_index.gfx_ring0 <=
< 1;
>
>                 /* disable scheduler on the real ring */
> -               ring->no_scheduler =3D true;
> +               ring->no_scheduler =3D adev->gfx.mcbp;
>                 ring->vm_hub =3D AMDGPU_GFXHUB(0);
>                 r =3D amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_i=
rq,
>                                      AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> @@ -2090,7 +2090,7 @@ static int gfx_v9_0_sw_init(void *handle)
>         }
>
>         /* set up the software rings */
> -       if (adev->gfx.num_gfx_rings) {
> +       if (adev->gfx.mcbp && adev->gfx.num_gfx_rings) {
>                 for (i =3D 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
>                         ring =3D &adev->gfx.sw_gfx_ring[i];
>                         ring->ring_obj =3D NULL;
> @@ -2181,7 +2181,7 @@ static int gfx_v9_0_sw_fini(void *handle)
>         int i;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -       if (adev->gfx.num_gfx_rings) {
> +       if (adev->gfx.mcbp && adev->gfx.num_gfx_rings) {
>                 for (i =3D 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
>                         amdgpu_ring_fini(&adev->gfx.sw_gfx_ring[i]);
>                 amdgpu_ring_mux_fini(&adev->gfx.muxer);
> @@ -5910,11 +5910,14 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device =
*adev,
>
>         switch (me_id) {
>         case 0:
> -               if (adev->gfx.num_gfx_rings &&
> -                   !amdgpu_mcbp_handle_trailing_fence_irq(&adev->gfx.mux=
er)) {
> -                       /* Fence signals are handled on the software ring=
s*/
> -                       for (i =3D 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
> -                               amdgpu_fence_process(&adev->gfx.sw_gfx_ri=
ng[i]);
> +               if (adev->gfx.num_gfx_rings) {
> +                       if (!adev->gfx.mcbp) {
> +                               amdgpu_fence_process(&adev->gfx.gfx_ring[=
0]);
> +                       } else if (!amdgpu_mcbp_handle_trailing_fence_irq=
(&adev->gfx.muxer)) {
> +                               /* Fence signals are handled on the softw=
are rings*/
> +                               for (i =3D 0; i < GFX9_NUM_SW_GFX_RINGS; =
i++)
> +                                       amdgpu_fence_process(&adev->gfx.s=
w_gfx_ring[i]);
> +                       }
>                 }
>                 break;
>         case 1:
> @@ -7051,7 +7054,7 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_d=
evice *adev)
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>                 adev->gfx.gfx_ring[i].funcs =3D &gfx_v9_0_ring_funcs_gfx;
>
> -       if (adev->gfx.num_gfx_rings) {
> +       if (adev->gfx.mcbp && adev->gfx.num_gfx_rings) {
>                 for (i =3D 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
>                         adev->gfx.sw_gfx_ring[i].funcs =3D &gfx_v9_0_sw_r=
ing_funcs_gfx;
>         }
> --
> 2.40.1
>

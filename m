Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC7DC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 16:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E538910E9F9;
	Wed, 24 Jan 2024 16:00:16 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3ACC10E9F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 16:00:15 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-21432e87455so2101362fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 08:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706111955; x=1706716755; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdpQGunml0yvqF4VCAMbuIR9lIGAUmFXtZFN02yLoog=;
 b=ZOSd3mZ2GS64zC12iNQSiEZRoabEKZPG7MRgeJeNjmsvIcHMqnZjrEPx8azeBNCgew
 /wyNiCUCdVC2znWXciEP6WDmdoI7TdKu4gKDesC5TD585H70GX/jppoBZRKudn4Tcw1L
 2akSYXBe3S+f/luCu4hoLN5Y3y55oMNkR5ZOslwz+DODWCuMMATOOSDzlNvVZ+b0poo2
 WpG4QC8kI9a763Ec3giCpyRlDUesgqkcSCtjNtwQK7kvoXEgqFX4hxdpZVMniz+hcM6L
 C2c3jlfzo0tTZXy/MKv6h8zI6E3H3TSPlrlwQ9oxDT78Q7ISBI38CxYoEybLpM7YADL5
 Ec0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706111955; x=1706716755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdpQGunml0yvqF4VCAMbuIR9lIGAUmFXtZFN02yLoog=;
 b=qM4itVVBS8nKhHnLATuWi+/4MbDI6pFNNf2UDPXs2p7c0fx7sAIiUGdtiX+x3o3t0F
 Vn970pEyTjSwVJTqJPvq2j1vh0dXyXk9smz1hzNtoty5e9Z86yV3AWQVpcTHpzPjgyIi
 zrCiuilxeasT6oKcjO85CRSaB440otXrg5wuqGyAVLmlJi3tJAlDI0kdTXy5A2W70Dy3
 lOYwDBRTFhJg740iqUHdEXoLCaT1OKz3lFkv/D3H/HX160ssR0cHURwsd7bmE/BUUVne
 y8IqNSdXees6MWEcOZMOvhXq9P6Bnsje56YKspgBcwnpXLeJQCfXS6UDtELqwmj1683L
 DUiw==
X-Gm-Message-State: AOJu0YyU1m8Qt5R2Mq5v+9YJ7z2W/pZ6flDYNSR4TZAezE5THoGHDgq3
 RPkChQFABwRWSDPtJdMG8zJy6FzHrxpavKeS8EQIWXbldimvEWtKhx/j7bXIl+WPmdS1PZqPMa3
 5BE+k9s1b7Zr4HZY+KIWjFIJbxHG7Abea
X-Google-Smtp-Source: AGHT+IF+J7YFQxgveBzGOLXCIIMVdAS0KzFiJMfQCUCYw5J13Gk01C79lqkcCw3M+danuQ6HwIpKZGd/8/XZI2uQfQ4=
X-Received: by 2002:a05:6870:4152:b0:205:fe77:4f71 with SMTP id
 r18-20020a056870415200b00205fe774f71mr3437249oad.15.1706111955149; Wed, 24
 Jan 2024 07:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20240124065932.892944-1-Prike.Liang@amd.com>
In-Reply-To: <20240124065932.892944-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jan 2024 10:59:03 -0500
Message-ID: <CADnq5_PJyh50wpHQuU_UFYvpnnp8PsteAJ7ymazFHMWD92cyDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for PM
 abort case
To: Prike Liang <Prike.Liang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Deepak.Sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 24, 2024 at 2:12=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> In the PM abort cases, the gfx power rail doesn't turn off so
> some GFXDEC registers/CSB can't reset to default vaule. In order
> to avoid unexpected problem now need skip to program GFXDEC registers
> and bypass issue CSB packet for PM abort case.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++++
>  3 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index c5f3859fd682..26d983eb831b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1079,6 +1079,7 @@ struct amdgpu_device {
>         bool                            in_s3;
>         bool                            in_s4;
>         bool                            in_s0ix;
> +       bool                            pm_complete;
>
>         enum pp_mp1_state               mp1_state;
>         struct amdgpu_doorbell_index doorbell_index;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 475bd59c9ac2..a01f9b0c2f30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2486,6 +2486,7 @@ static int amdgpu_pmops_suspend_noirq(struct device=
 *dev)
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>
> +       adev->pm_complete =3D true;

This needs to be cleared somewhere on resume.

>         if (amdgpu_acpi_should_gpu_reset(adev))
>                 return amdgpu_asic_reset(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 57808be6e3ec..3bf51f18e13c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3034,6 +3034,10 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_dev=
ice *adev)
>
>         gfx_v9_0_cp_gfx_enable(adev, true);
>
> +       if (adev->in_suspend && !adev->pm_complete) {
> +               DRM_INFO(" will skip the csb ring write\n");
> +               return 0;
> +       }

We probably want a similar fix for other gfx generations as well.

Alex

>         r =3D amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3=
);
>         if (r) {
>                 DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
> --
> 2.34.1
>

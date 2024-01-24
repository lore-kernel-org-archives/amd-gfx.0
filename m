Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2F8C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 16:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E48AE10E190;
	Wed, 24 Jan 2024 16:07:46 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E8EE10E190
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 16:07:42 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-59505514213so2453905eaf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 08:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706112402; x=1706717202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RZsnqLm3pSskFLCbA7Nvw3Kmy0QBlWkSKaHgyt8JY0=;
 b=RZKi7QR+UqIrIAMIMN67fbCJv4+RnbJuj6iT158IUJSWpDCWqO2QjIAg3FZXmWH7qM
 yKvDq7LWbUjTIueaRl1HPZxrhCkQjIxcFesgg+y0qzdICdw+TXVSRuUYvAS44336trVT
 pjPYruOJHYd+p5oZYtONJJVnIAOcIihDsFtcLhpWK9i343Qdulzr9rBbmVExwKTAmVvr
 9uvtHPg+2jKJvxcpECqUqCPST16q+UbcTzRtbmdqWdl2/Krf2QT9JrHgAN7WsTdJN9zp
 2ro/8aKdBjjbFhgieS5HEd/6FCUCBHio2cR6Z2mhYxbPxEo+y95yANl7PA/M32Q+uMGP
 Lt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706112402; x=1706717202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/RZsnqLm3pSskFLCbA7Nvw3Kmy0QBlWkSKaHgyt8JY0=;
 b=WhF3R6bzbPjxbKp54FWCP7PSS7gT2kDS0kf03ji/uUi0L4yhlfkuGh8RMU9plPV3tt
 7nbG735vf7zpYDrS+nKhqDmHZfPmSKUeTBi58x1g12/u9judtW/bNzluvR7LvfrE2ZJz
 /vZ7Pw/IEMDXv+SSDw1aRVis19xczaiZHeyH87q+86cWLQ9dW+TjWqOPF8rf2X72SKAy
 DV//zvQCqMZWcxw0KrUJjDUhfryzijQAQDJoLpk0112pHwW0nRTNZ8+AJGofMSePLRS5
 Uxz2181SulYkGuvUC8AP2LD/nzK4zU2UHu8y7YpY6ZyehWGK9elBp/3t/Qz2VGjHVCWo
 PV3Q==
X-Gm-Message-State: AOJu0YyeG1zyawlGmpIQMS3F+awSSQhZGpXJXqCW4nBqTm4h2dVkE5gK
 S1Y0H1S1bJk7qZEbu4YQPRXut02USrG3llDP7a63XiFznqUZZ+8bKFoWZkNMeTiUwitEVAI+to1
 kDHZ+FcWxxlXfwscx4XTzQuz5X9w=
X-Google-Smtp-Source: AGHT+IGp9Be9WUgeqn8MQ3NCVbPTI+/DW0oy8O3JhA2Me8uyUS5e/xlKzmJ2d5Ee2dRDnxnu3DyBI50DpeEj9yWuaI0=
X-Received: by 2002:a05:6870:20d:b0:210:98d0:d5b0 with SMTP id
 j13-20020a056870020d00b0021098d0d5b0mr571973oad.22.1706112402127; Wed, 24 Jan
 2024 08:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20240124065932.892944-1-Prike.Liang@amd.com>
 <20240124065932.892944-2-Prike.Liang@amd.com>
In-Reply-To: <20240124065932.892944-2-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jan 2024 11:06:30 -0500
Message-ID: <CADnq5_NnJeVALgswRm4f17XMZ_e5a_nd4D_q2vrXyRTvCuKx8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
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

On Wed, Jan 24, 2024 at 2:17=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> In the pm abort case the gfx power rail not turn off from FCH side and
> this will lead to the gfx reinitialized failed base on the unknown gfx
> HW status, so let's reset the gpu to a known good power state.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/soc15.c      | 7 ++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 9153f69bad7f..14b66c49a536 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2935,6 +2935,11 @@ static int psp_resume(void *handle)
>
>         dev_info(adev->dev, "PSP is resuming...\n");
>
> +       if(amdgpu_asic_need_reset_on_init(adev)) {
> +               DRM_INFO("PM abort case and let's reset asic \n");
> +               amdgpu_asic_reset(adev);
> +       }
> +

Seems like it would be better to put this in the resume callback.

>         if (psp->mem_train_ctx.enable_mem_training) {
>                 ret =3D psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
>                 if (ret) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index 15033efec2ba..6ec4f6958c4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -804,9 +804,15 @@ static bool soc15_need_reset_on_init(struct amdgpu_d=
evice *adev)
>         if (adev->asic_type =3D=3D CHIP_RENOIR)
>                 return true;
>
> +       sol_reg =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);

Is this register consistent for all soc15 chips?

Alex

> +
>         /* Just return false for soc15 GPUs.  Reset does not seem to
>          * be necessary.
>          */
> +       if (adev->in_suspend && !adev->pm_complete &&
> +                       sol_reg)
> +               return true;
> +
>         if (!amdgpu_passthrough(adev))
>                 return false;
>
> @@ -816,7 +822,6 @@ static bool soc15_need_reset_on_init(struct amdgpu_de=
vice *adev)
>         /* Check sOS sign of life register to confirm sys driver and sOS
>          * are already been loaded.
>          */
> -       sol_reg =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
>         if (sol_reg)
>                 return true;
>> --
> 2.34.1
>

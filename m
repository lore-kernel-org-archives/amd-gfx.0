Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E79CC47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 15:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D5B10F916;
	Thu, 25 Jan 2024 15:24:29 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1F110F91B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 15:24:27 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-3bdd7fae400so612347b6e.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 07:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706196207; x=1706801007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOn+GpI4MnEHhc/aYC6CuFdZoUYUZDmd+P4Cjq1ctrI=;
 b=g/1suPekpNLKXbMX4MChE1T2FNEjZgxdEZQPE+GwIggZeytEQoxOMX19NfR9o2k3nE
 l8Dxz6lNjxG9kDFYQ44eH8PBqUv89qaoE/dVwXQoy18bb55nv/IdKa3tU/KzONKPeKzI
 A+tL0Ahr0p5Gx/HtTfSucA1cMeDhFosBQB6uBi5bxxBPJG9z2c+OcDRR18GtIRpB00Mi
 0RXj7MzoaLuwDnScwtuZ8SMAhQwtyfoYObyAIIfmU0YzPLXw3wiWCRfRVveg+DNKsaCB
 6yEQT2s4QVzf/pMlTCBSb3nRDIDGJiJLoD2+O+GpGn9s5KNJM0Yo5AdCXvPPxE1+aAxE
 79YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706196207; x=1706801007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOn+GpI4MnEHhc/aYC6CuFdZoUYUZDmd+P4Cjq1ctrI=;
 b=ix5CxhO48npPKOgvcIHW7WzlevZ/KUW85fw3hbqYd63am9kDwMllQKGVQbKNh4Yqg/
 o9ln/i4IFpNtCO8QSZ8NI7BzemRLbMIryKQnNebUaO4G/SzXay7HAqpEOhNhXRSRQ7h4
 cvB6e8FpwIosCSbx60FsJ/cAWNZNIUwyiNvuX+mFOhtxNgQ9YvjpXwtaJESyJexJQs7+
 8NbpeYPlt47iXJaMOX+lnO8yL86jFvP5X6FfJWwI/Si3JDs4cvmXMIHtVEAI1Kf2Gr6w
 iSMi/ks/6io20fBd+VnMjI2GjR1POu/8fk81OU1J4hq+5Fd65uy2yN42Tl3fEcLLSTZS
 cXFQ==
X-Gm-Message-State: AOJu0Yx17Tr8DRcpuJZTNzff/BEWdzmniQ5v2akFcA/q77og6N3DFCw7
 H8x9k3IC9nyYbQPMgE3yWm2FyDjzBypivKJKPrkd63lWaryJ2JxEPdP7DaySDG05vKSygLADLeO
 PQjo5K4lNhDlg7zpzgepNTNHsCXk=
X-Google-Smtp-Source: AGHT+IEU6jr9Grw24VCy0H/wLXGt+XT3FQdQ7u3Le0lUaokGZRWHZUbcT71dudnBT6skysdTBzOrs6/He76w+exTek8=
X-Received: by 2002:a05:6870:a448:b0:206:6db:dff9 with SMTP id
 n8-20020a056870a44800b0020606dbdff9mr896198oal.58.1706196207000; Thu, 25 Jan
 2024 07:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20240125032255.898308-1-Prike.Liang@amd.com>
In-Reply-To: <20240125032255.898308-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jan 2024 10:23:15 -0500
Message-ID: <CADnq5_MocSPhyKyS2MFGbH920HE-Sme3fg3aAcbOFevvRrTNpw@mail.gmail.com>
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

On Wed, Jan 24, 2024 at 10:46=E2=80=AFPM Prike Liang <Prike.Liang@amd.com> =
wrote:
>
> In the PM abort cases, the gfx power rail doesn't turn off so
> some GFXDEC registers/CSB can't reset to default vaule. In order
> to avoid unexpected problem now need skip to program GFXDEC registers
> and bypass issue CSB packet for PM abort case.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 6 ++++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index c5f3859fd682..9e9e3385b5d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1079,6 +1079,8 @@ struct amdgpu_device {
>         bool                            in_s3;
>         bool                            in_s4;
>         bool                            in_s0ix;
> +       /* indicate amdgpu suspension status */
> +       bool                            pm_complete;

Maybe rename this suspend_complete to better specify that it only
applies on the suspend side.

Alex

>
>         enum pp_mp1_state               mp1_state;
>         struct amdgpu_doorbell_index doorbell_index;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 475bd59c9ac2..9cb8f7fe55cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2472,6 +2472,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>
> +       adev->pm_complete =3D false;
>         if (amdgpu_acpi_is_s0ix_active(adev))
>                 adev->in_s0ix =3D true;
>         else if (amdgpu_acpi_is_s3_active(adev))
> @@ -2486,6 +2487,7 @@ static int amdgpu_pmops_suspend_noirq(struct device=
 *dev)
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>
> +       adev->pm_complete =3D true;
>         if (amdgpu_acpi_should_gpu_reset(adev))
>                 return amdgpu_asic_reset(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 57808be6e3ec..0abdc85eda77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3034,6 +3034,12 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_dev=
ice *adev)
>
>         gfx_v9_0_cp_gfx_enable(adev, true);
>
> +       /* TODO: double confirm whether need to reinitialize gfxedc and s=
ubmit csb packet
> +        * on the other gfx generations for the pm suspend abort case. */
> +       if (adev->in_suspend && !adev->pm_complete) {
> +               DRM_INFO(" will skip the csb ring write\n");
> +               return 0;
> +       }
>         r =3D amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3=
);
>         if (r) {
>                 DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
> --
> 2.34.1
>

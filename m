Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CAFCCF9FE
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 14:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070C510E1F5;
	Mon,  3 Nov 2025 14:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lchlkaIx";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4007310E1F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 14:18:47 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-340ad724ea4so412505a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 06:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762179527; x=1762784327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PX6CozsDs0ld19VEC3zWEODOVO7vCfYGOnETrT0jl9w=;
 b=lchlkaIxthTKX76fUpRqlr4riA6WtrBdxHOu+/QAqFggcJqxXijmsPLOd44pXIM8uP
 hZX70jPJ8tDnwzJsq+XsgztiIePfBZGZEGWLahfWOfc73nqwRY9lhgRGA67zx+wbGKHJ
 hTahqSNDZNSLdlaOBYR6+3md6UGB11hYNTjRUMziquqSdA9bgyWmIQCZjjgwqIn/wLPX
 KGUwgthlKzzFJrUI59LHrTCICT4ahO0LeVVVFB4mPtK7kXGZ5LGLg13uaCETarlMyuIp
 F+eyrkymWh57N8m6TGTe/iSiatq4EfOSTCfaLhyDaQQ2+80ZZJG8L3CA/OHDs2RLtKLZ
 FcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762179527; x=1762784327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PX6CozsDs0ld19VEC3zWEODOVO7vCfYGOnETrT0jl9w=;
 b=HTRYq2KW0Wdqhs9KpKc7zcrvoYJZCuFdAwA1CjjTXWDei401PtHw0+6mgiG0/9URcj
 AoVluW5Bc9fifnFTwGl7Ax36q0SpyvIsaRdnWuA05hgASmEJBEarkvd1jwyq7e33/JOL
 +7unwdEsLDjomRuDCUdFaIGgUxqVGUH5hQp3YNQu65Om5bH8xSEifFfugm503TBypm2m
 64p8/YZ70avOeBKoaszn9XGRUUS/ZCzYjMRX0WlJw/7a5qikiqfTiVOxptu/et4AogU4
 AbwrIJUyhi+gE8lwuVg/JmC7lqggtoLJ6kiVCRyzv+jEtXqQLy2RKZ89Rw7+fOPFoO8F
 HS6g==
X-Gm-Message-State: AOJu0YyhpcFOFMZ7x69rBHUJCUfBYeVXy8G4GTRotv+UIZU0K7oK+zpU
 MGLJr7TIsepRySmVuGvzvsLuvpTMN3FALRG1HayaOVKpMhdO6KJmPYO57HX1g5+xYG4PPvfNPDN
 8WAq/Nsw4by4tKVgMVaTrWJ9Fwsenh14=
X-Gm-Gg: ASbGncvgs7OBfYk5/ouwmH7+8U2xQ98MbbRrhvIr7U/Vxm9IA82L+x6TmkBngMQLZER
 Y/SUBE5jJcfAbSkLaYma0/jVnaR6vEtV60aNcTDv8IHp2XoB45P4+FlBW2nEXS5f2nqom086gcl
 fmBdqJR+tqfjXUC0BfwBkA5JvrX4F+2h0TpX31J2nB8m6IYdyY0BdePbcJ6bBQ0n5q0u/j0Ovcz
 DFUMqMSglGLln1pYx9WV7suiZ3PGu671AvdmSHAqwEmma9OUzCiaWPAgu3S
X-Google-Smtp-Source: AGHT+IFMlj4XEKOKFoHIsAGCQXln8tbjDQ0N9QtELLlfQX2/8Rk/cVnH7ctsM7NK3/AFQZxWqR68pkq6vrxpYpIKtd4=
X-Received: by 2002:a17:902:e74c:b0:258:a3a1:9aa5 with SMTP id
 d9443c01a7336-29519983b30mr92313455ad.0.1762179526634; Mon, 03 Nov 2025
 06:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20251103113635.733891-1-lijo.lazar@amd.com>
In-Reply-To: <20251103113635.733891-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Nov 2025 09:18:34 -0500
X-Gm-Features: AWmQ_bmqgd38Pu3pDL28bNM6Z97i07yrdenMDU-Ur8yn-_ve3y9c36fRzcEGCD4
Message-ID: <CADnq5_P1C-oWXT=x2vJbn54cXHGrvFSQV1pFTrVgp7=dqPvdXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix wait after reset sequence in S3
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Mon, Nov 3, 2025 at 6:46=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> For a mode-1 reset done at the end of S3 on PSPv11 dGPUs, only check if
> TOS is unloaded.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4649
> Fixes : 440cec4ca1c2 ("drm/amdgpu: Wait for bootloader after PSPv11 reset=
")
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 26 ++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index cee90f9e58a9..3f42cf7c6193 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2627,9 +2627,14 @@ static int amdgpu_pmops_suspend_noirq(struct devic=
e *dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> +       int r;
>
> -       if (amdgpu_acpi_should_gpu_reset(adev))
> -               return amdgpu_asic_reset(adev);
> +       if (amdgpu_acpi_should_gpu_reset(adev)) {
> +               amdgpu_device_lock_reset_domain(adev->reset_domain);
> +               r =3D amdgpu_asic_reset(adev);
> +               amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +               return r;
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v11_0.c
> index 64b240b51f1a..a9be7a505026 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -142,13 +142,37 @@ static int psp_v11_0_init_microcode(struct psp_cont=
ext *psp)
>         return err;
>  }
>
> -static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
> +static int psp_v11_wait_for_tos_unload(struct psp_context *psp)
>  {
>         struct amdgpu_device *adev =3D psp->adev;
> +       uint32_t sol_reg1, sol_reg2;
> +       int retry_loop;
>
> +       /* Wait for the TOS to be unloaded */
> +       for (retry_loop =3D 0; retry_loop < 20; retry_loop++) {
> +               sol_reg1 =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> +               usleep_range(1000, 2000);
> +               sol_reg2 =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> +               if (sol_reg1 =3D=3D sol_reg2)
> +                       return 0;
> +       }
> +       dev_err(adev->dev, "TOS unload failed, C2PMSG_33: %x C2PMSG_81: %=
x",
> +               RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_33),
> +               RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81));
> +
> +       return -ETIME;
> +}
> +
> +static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
> +{
> +       struct amdgpu_device *adev =3D psp->adev;
>         int ret;
>         int retry_loop;
>
> +       /* For a reset done at the end of S3, only wait for TOS to be unl=
oaded */
> +       if (adev->in_s3 && !(adev->flags & AMD_IS_APU) && amdgpu_in_reset=
(adev))
> +               return psp_v11_wait_for_tos_unload(psp);
> +
>         for (retry_loop =3D 0; retry_loop < 20; retry_loop++) {
>                 /* Wait for bootloader to signify that is
>                     ready having bit 31 of C2PMSG_35 set to 1 */
> --
> 2.49.0
>

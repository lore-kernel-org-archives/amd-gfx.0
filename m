Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C355C001E0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 17:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9013910E5D1;
	Thu, 27 Jul 2023 17:25:00 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDDB10E5DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 17:24:57 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5661eb57452so833291eaf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690478697; x=1691083497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AxUnbT7mewNo7c0XRWo5phd1ijrbn57yGuhGh5ylSg=;
 b=UeFUsTSFOzyuLXKPAjc3mPifaFqV+WgsQlfD2W/35t0rMXkOW88edUMkoCoU4gH9Ab
 W4tLOXGVZPaxS8a8gbW5wUAHUY1c++64FHucLz4nT4wxmSN5XWm+yLNpMu93+Lk/CvES
 X01NxvGmvhngMuzR8mMv2v44KlnJBFU2hXUC/XW9HoseKnml1bKK0hmm8JNuPYhVk978
 fzN5ijsQYEPMuT0PggwqQhFYoG1R1G3L4PDnfv5i6yHl9AX6UB05c6QgF+icr+bv/gQl
 XB/45JqYYhGK6fnf3dDUC8Y9zpIvsv7KeFwlybb80+4sm5zuyHF8C+sbEwWKNIm2TMaM
 XjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690478697; x=1691083497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1AxUnbT7mewNo7c0XRWo5phd1ijrbn57yGuhGh5ylSg=;
 b=UOAe7+UAxaXnM/EuWyhmp3NJlPFsI1AQJaYOVcAOxN4upP++6uWw+iKzJgZiwbm6jh
 dXdz85iOyxBVah/KRsMt0ajId4cSU/ndbj7hFnfwO+agZHubUl2vnxhlJKAH6vlis6rH
 M6jrpiUJhJyvNu5HIpe8v5xGO1sMvK/D00iSTu+GqBSClK8WiNu8GAqwUJWNZPKDGiry
 Jc6meWWoS67AAcvpyCth/q+kycnJ15zE7mtR2XC1u7xwG0Z4NniddIpXgjUIB17Tebg9
 H5F6IyNE2LONbOfX8G3xPvyOyO5lG5JUyxj3IJdan6D3LJBiUVm7VCtOPNcw1dceFL43
 Rr7w==
X-Gm-Message-State: ABy/qLajZDXlKsoYYbzMDcZBh5rchlLsHjmW6QHALrykl6AuCTKjVEXv
 ic25MARlaFDzK+Pi+6pkeO1Qw+yLnzIV0GYJP70=
X-Google-Smtp-Source: APBJJlGQ1CtJJxYVQGZIYlTOPjaKe/dphK91/uGhtljIWCGsLcm3k2ps85Ty7aouLKgXM6jqvpbBEtQnMVeX7Vq9OFI=
X-Received: by 2002:a4a:3557:0:b0:566:f51f:bbd3 with SMTP id
 w23-20020a4a3557000000b00566f51fbbd3mr159232oog.2.1690478697002; Thu, 27 Jul
 2023 10:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230727170514.9183-1-mario.limonciello@amd.com>
In-Reply-To: <20230727170514.9183-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Jul 2023 13:24:45 -0400
Message-ID: <CADnq5_MsB6_oBQxmok7i3-Vw2mf+ck=X4k93zUsLfi_1grAhPw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Disable S/G for APUs when 64GB or more host
 memory
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: roman.li@amd.com, amd-gfx@lists.freedesktop.org, Hamza.Mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 27, 2023 at 1:06=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Users report a white flickering screen on multiple systems that
> is tied to having 64GB or more memory.  When S/G is enabled pages
> will get pinned to both VRAM carve out and system RAM leading to
> this.
>
> Until it can be fixed properly, disable S/G when 64GB of memory or
> more is detected.  This will force pages to be pinned into VRAM.
> This should fix white screen flickers but if VRAM pressure is
> encountered may lead to black screens.  It's a trade-off for now.
>
> Fixes: 81d0bcf990093 ("drm/amdgpu: make display pinning more flexible (v2=
)")
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: <stable@vger.kernel.org> # 6.1.y: bf0207e172703 ("drm/amdgpu: add S/G=
 display parameter")
> Cc: <stable@vger.kernel.org> # 6.4.y
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2735
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 +++++++++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +----
>  3 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 93d0f4c7b560e..2e3c7c15cb8e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1313,6 +1313,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>  void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
>  int amdgpu_device_pci_reset(struct amdgpu_device *adev);
>  bool amdgpu_device_need_post(struct amdgpu_device *adev);
> +bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
>  bool amdgpu_device_pcie_dynamic_switching_supported(void);
>  bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
>  bool amdgpu_device_aspm_support_quirk(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index dc0e5227119b1..a4e36b178d86c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1296,6 +1296,31 @@ bool amdgpu_device_need_post(struct amdgpu_device =
*adev)
>         return true;
>  }
>
> +/*
> + * On APUs with >=3D 64GB white flickering has been observed w/ SG enabl=
ed.
> + * Disable S/G on such systems until we have a proper fix.
> + * https://gitlab.freedesktop.org/drm/amd/-/issues/2354
> + * https://gitlab.freedesktop.org/drm/amd/-/issues/2735
> + */
> +bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
> +{
> +       switch (amdgpu_sg_display) {
> +       case -1:
> +               break;
> +       case 0:
> +               return false;
> +       case 1:
> +               return true;
> +       default:
> +               return false;
> +       }
> +       if (totalram_pages() << (PAGE_SHIFT - 10) >=3D 64000000) {
> +               DRM_WARN("Disabling S/G due to >=3D64GB RAM\n");
> +               return false;
> +       }
> +       return true;
> +}
> +
>  /*
>   * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dyn=
amic
>   * speed switching. Until we have confirmation from Intel that a specifi=
c host
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 77d970a2ee693..f81c6c249c02a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1639,12 +1639,8 @@ static int amdgpu_dm_init(struct amdgpu_device *ad=
ev)
>                 }
>                 break;
>         }
> -       if (init_data.flags.gpu_vm_support &&
> -           (amdgpu_sg_display =3D=3D 0))
> -               init_data.flags.gpu_vm_support =3D false;
> -
>         if (init_data.flags.gpu_vm_support)
> -               adev->mode_info.gpu_vm_support =3D true;
> +               init_data.flags.gpu_vm_support =3D amdgpu_sg_display_supp=
orted(adev);
>

You miss updating adev->mode_info.gpu_vm_support here.

Alex

>         if (amdgpu_dc_feature_mask & DC_FBC_MASK)
>                 init_data.flags.fbc_support =3D true;
> --
> 2.25.1
>

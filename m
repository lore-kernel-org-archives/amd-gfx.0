Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C714CC4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 21:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF5D10E440;
	Mon,  6 Nov 2023 21:40:21 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D17210E440
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 21:40:19 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1f03fdfcfacso2949443fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Nov 2023 13:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699306819; x=1699911619; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAbQVm3zJ4UqsbrmZsxrr43vEClld4C/EEamWDlJsuU=;
 b=DJgT8PeYYdF0igBpTTj28yJBOMMKFxgTc9S4vVlONDIOa2tk/mZHN603jKXgpD5DTG
 MqDGVKWgAgItYqmlbSl3GEwYFIjb+1F//m7+ulUPKh+PTmxTTkqPXH/2XCklEaO70b0D
 YSdz1lGWXpHdTTJnUAxgS20xmWoje6hzObi9Hz1dwEzenralFtN0bIhYudYbD494LX5x
 lqGmnxeCqqhBc2OXNMUKmSOyIggRjxqYtxIoDkvFWpP/dzI3U7gdp1bgUl2PkD61WM9B
 vmM6YA46ewuGHoTsNP9zd8+eDpSzR5/xiQ1UcCV+4is8xMS1S9Miw3H0GB4B6nVkhjbk
 PmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699306819; x=1699911619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAbQVm3zJ4UqsbrmZsxrr43vEClld4C/EEamWDlJsuU=;
 b=d3IVhWG3w/ybMvP3fEPmeSS6YEdtCq3HXhn7qqt96VEUT9J18teO1HVvcZ9ONeTbun
 i8385zr2VVIzDFXHqSnjz6mDnxTC7pxaZ1DFzXlQ4VzFp0AMnWIEjcMCYue9T8IApySq
 XQuxfP+Z+Hi/zfzUJxNylJpqp8TUIwQ6j7vGcFyoOILdPaf7fz4r00FlFPY6STvDlR84
 EWMyitvA7CuNSu7BdVIkkaG/3kTJlBZgxosWDz0jkC81E/uOHqksJ5lVdNzwZYQDC6G+
 yfea+oNDpNJBBAVgx2lrGzYKhP5MxRk9DxD13tIGHtKKtsUulhhKp/ckM+JO5B9h6G5h
 FEtQ==
X-Gm-Message-State: AOJu0Yyb72EYEZ0wwk5Bcr3BX16gC6fDXtG7yZOSMMXQmdfCeHCjNYoL
 HTFcqYcFX9kUdg2d78dXzGxcwVMuqJls1llk+811HEYB
X-Google-Smtp-Source: AGHT+IEXIPr5IkWW/bCPyFI1cC0gy5VbbEcdQCyHKUda7FkSJSuvM548nensOcxMWPHB0zxJetiK6eyTd9XE59HbEEo=
X-Received: by 2002:a05:6871:4505:b0:19f:aee0:e169 with SMTP id
 nj5-20020a056871450500b0019faee0e169mr1122125oab.30.1699306818785; Mon, 06
 Nov 2023 13:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20231106193010.2093-1-mario.limonciello@amd.com>
In-Reply-To: <20231106193010.2093-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Nov 2023 16:40:07 -0500
Message-ID: <CADnq5_P4bnESWVAs4LMmDoF-MJeJVQobFJ7aRU3R-Z9t1aDxxw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Exclude dGPUs in eGPU enclosures from DPM quirks
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 6, 2023 at 3:07=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> DPM should be enabled on dGPUs that are used in eGPU enclosures
> regardless of the host support.

Are you sure?  Seems like this would be dependent on whether the eGPU
bridge supports dynamic switching or not.

Alex

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e2199d8fd30e..29d5820e912b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1466,11 +1466,15 @@ bool amdgpu_device_seamless_boot_supported(struct=
 amdgpu_device *adev)
>   * https://edc.intel.com/content/www/us/en/design/products/platforms/det=
ails/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/=
005/pci-express-support/
>   * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
>   */
> -static bool amdgpu_device_pcie_dynamic_switching_supported(void)
> +static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu=
_device *adev)
>  {
>  #if IS_ENABLED(CONFIG_X86)
>         struct cpuinfo_x86 *c =3D &cpu_data(0);
>
> +       /* don't worry about external dGPUs */
> +       if (dev_is_removable(adev->dev))
> +               return true;
> +
>         if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
>                 return false;
>  #endif
> @@ -2310,7 +2314,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>                 adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
>         if (amdgpu_sriov_vf(adev) && adev->asic_type =3D=3D CHIP_SIENNA_C=
ICHLID)
>                 adev->pm.pp_feature &=3D ~PP_OVERDRIVE_MASK;
> -       if (!amdgpu_device_pcie_dynamic_switching_supported())
> +       if (!amdgpu_device_pcie_dynamic_switching_supported(adev))
>                 adev->pm.pp_feature &=3D ~PP_PCIE_DPM_MASK;
>
>         total =3D true;
> --
> 2.34.1
>

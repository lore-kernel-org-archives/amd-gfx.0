Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0290BC3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 15:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37FE10E297;
	Thu,  3 Apr 2025 15:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jOM9Z/ek";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A44310E2BC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 15:48:43 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-30363975406so171058a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Apr 2025 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743695322; x=1744300122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V23suTCPv14itRvWPkYOs8Nuk94Gdlahr98awHVPMnY=;
 b=jOM9Z/ekwk62rGecz/CO7ghWw2PokvjnXsj74CoFhxbuk+xBYVmKe+HF/GVEL6VYBR
 INJNzx90eXALTXeToHnc42j2OYRiuU9r9lF4JGgFSqeO0NjTCDzAapfY4Tk8AsVcXT8e
 /lf+m6ge4737OGIJLyQcLYcnv3SpVgsLUkQ+3SSGySX6woJ2XK4Ky0gwDUX5sEX9U4/z
 u+hpQZsP8+b1A5vU5emuy6O54yo3pTBuzXMu7nxFABy7s/tD+WQ1xhlZy3Vv0eeZ7uBb
 fmYBhILZXy4a9aaWno1IeVJwM6bfKFsWtM+h1mUMtjVMrZbpGdsAbeg7UlhOupKe9qru
 EuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743695322; x=1744300122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V23suTCPv14itRvWPkYOs8Nuk94Gdlahr98awHVPMnY=;
 b=vIDngMjr1X7I9w7HmzxJLGRMoMD/3uBaWXa170WwZPmfpqigNC70BuvYANnlEZZsrW
 yhe7zJgitXRf8wosX32ujxdXKwfAnvdkOd4YdHNdvXDXFMjGyWLrqBX4PrKOqVPBZkq1
 I+mEwfuZZFHzeCKcurpoGNDBwALu6Jgwvmn31c9Qerf1V4ZMitYo+NFmY2Safzml2R0L
 s2xZHp0FXjTCH6qVwGpJNWMwIWnuNSyj4tgGbqt32cf3VNuzcgvcARySLpiCllqBwIBW
 Kcc1Ee3vm1KXFEvIXQyJw66ZhBoMy+5vAun5oNRyqZFvTvJ8Okbh8VuuqO91j1piyZwU
 jFsg==
X-Gm-Message-State: AOJu0Yx1u88watcl23gub8EIBI+qYpkygHr0cggyMi+6JtBh0jAW2RpR
 YM7YGXnG4GCDfKIymuRHSImOiI1UtwDxs94pc4qxL9xWrl1/i0Yp+AdS6bgD3aCsZFmMmQR2vKX
 o9j47BJojF3P0vdaZgERd6BoTkO8=
X-Gm-Gg: ASbGnctlybCjc7Nez5im8wvVLUTn69u5tuajRwRVBHrSPc3GtyHTtJpZty2mQqSLTea
 n6AfQvHmqrWLZR4lBIRMm6lRN1Nr/tglfLbHgkPolHNVYnpUDoSODPaQGyiEryiVDDxqw73U8HR
 ff5leoxsL4xsht0TccTt9nYQb1QA==
X-Google-Smtp-Source: AGHT+IGQEhssxOaznC8drviRViH5HlQTwVBElnJxgv1WdG8NuX6BUJgMXDiDQ7PeOtA9ZaSQx207OKFaJ2tTWzOxdUE=
X-Received: by 2002:a17:90b:3a88:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-306a496b929mr17091a91.7.1743695322500; Thu, 03 Apr 2025
 08:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250403031148.1266785-1-superm1@kernel.org>
In-Reply-To: <20250403031148.1266785-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Apr 2025 11:48:31 -0400
X-Gm-Features: AQ5f1JrTtbkTgW4qB1rZA0kq_DvMn_uWeowGgWal34bZVd09TcK3e9WtzqIPxqI
Message-ID: <CADnq5_Nz76WBm8wsU8k4LUpXrjKk6AbJfYV0CpaV3sXAJ2McEQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Add pre-zen AMD hardware to PCIe dynamic
 switching exclusions
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Wed, Apr 2, 2025 at 11:12=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> AMD RX580 when added AMD Phenom 2 has problems with overheating. This is =
due to

I don't think this is entirely accurate.  I think the GPU gets hot
because the device hangs due to a problem with changing the PCIe
clocks.

> changes with PCIe dynamic switching introduced by commit 466a7d115326e
> ("drm/amd: Use the first non-dGPU PCI device for BW limits").
>
> To avoid risks of other issues with old hardware require at least Zen har=
dware
> for AMD side to enable PCIe dynamic switching.

I'm pretty sure PCIe reclocking worked on pre-Zen hardware.  We've
supported this on our GPUs going back at least 15 or more years.  I
suspect the actual problem is that some links may not reliably train
at the full bandwidth on some motherboards.  Forcing a higher link
speed may cause problems.  Maybe it would be better to limit the max
PCIe link rate to whatever the link is currently trained to.  IIRC,
PCIe links will train at the fastest link possible by default.  The
previous behavior was to limit the max clock to the slowest link in
the topology to save power, but then we changed it to use the fastest
link possible based on the PCIe link caps.  Perhaps limiting it to the
fastest currently trained link rate would be better.

Alex

>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4098
> Fixes: 466a7d115326e ("drm/amd: Use the first non-dGPU PCI device for BW =
limits")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Cover more hardware
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a30111d2c3ea0..caa44ee788c8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1854,6 +1854,9 @@ bool amdgpu_device_seamless_boot_supported(struct a=
mdgpu_device *adev)
>   *
>   * https://edc.intel.com/content/www/us/en/design/products/platforms/det=
ails/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/=
005/pci-express-support/
>   * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
> + *
> + * AMD Phenom II X6 1090T has a similar issue
> + * https://gitlab.freedesktop.org/drm/amd/-/issues/4098
>   */
>  static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu=
_device *adev)
>  {
> @@ -1866,6 +1869,8 @@ static bool amdgpu_device_pcie_dynamic_switching_su=
pported(struct amdgpu_device
>
>         if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
>                 return false;
> +       if (c->x86_vendor =3D=3D X86_VENDOR_AMD && !cpu_feature_enabled(X=
86_FEATURE_ZEN))
> +               return false;
>  #endif
>         return true;
>  }
> --
> 2.43.0
>

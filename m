Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB23C44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C984C10E40B;
	Mon, 13 Jul 2026 18:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YmcOgP62";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0589F10E40B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:33:25 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cc827a68fbso9651055ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 11:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783967604; cv=none;
 d=google.com; s=arc-20260327;
 b=iSvuG/SNuxQP6qNWJkhVO+rT0Gbqr8tDTU8Zefedd1CPR9Lr6+vtqg00u9uGZzy/RY
 DgjtrNE3BUVCoyVOCj9B6Hbq5xu3L7ZV4U1F1ZLZG/pgWF1dLJkXyBV1Xk87m1GiqVPJ
 8LzLHuW/+DbxZvgDCo7x8/KYuqdFltukeMxoqtvSL8yPjsiZDJlYIbfgCT44skkl/ftB
 QcGJgXSAn2bar0hAMJ+tPIBJsOgPqRLyix6/HLp6mXqkwlX/5puy8c74B+01+BgOztZ5
 nxHrMLAlHDAm4/9Mg2wcPqAeXGCWIch5umPnorfMjVU2KuY7AdC9NFBdvDy1kziITmlX
 lF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cGmCiBlaSELFoPdzH4UZt3xo0WPFnSE+PTX5QPBRd6c=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=ATRcdmkxSQPFazlvRTRwwh4L5tlU6WC8xjxAsxxKxvG7MnW7jtaA1MNezTT1gmvAOr
 tg7rd9r/gQsxdl51Pxj7/3/BSBRSk72o2CrafH1lexLAuI/LZs2MQguQhPLgIFmdR45n
 4VI/hM+XbBuMeTUiodLZXBUlIAablJn1n0wlz5SDmxUAT28itApv0iNtpzmYwg5WqUvI
 u5K1zM6X/JZC2GFCbSdjJ13htCi9lNgFcF64YYR7tLzKOpFWfY6MfB+3oXLFye6JLfLh
 6n7BZhdnOxNNS6Bz6zRgtuyNTfM4wVItNHelgay+rChfzM4OdmfsF1+eDg66pylGNcnv
 KxCA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783967604; x=1784572404; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cGmCiBlaSELFoPdzH4UZt3xo0WPFnSE+PTX5QPBRd6c=;
 b=YmcOgP62yTe8tx5jgRfQjvtk/7ha4xwCEo5StpA7szxacc3AM77amnFunGcH7QkxaH
 9f9S7vYiSbjsGU/DpF7dciEYELL2uxpOiAJvGBFZ4vwbVTTO1WrSPwW322/mJ6UJOuYG
 85+48KBygEYYStgW360Io6RXqsTqnaf0/lAbOUAPk3xE4oQDGYpwW8CbPGgoYVB8++YT
 dFhzRHNKbmjeAMvBKYDlcyoiKV10e2X6HnItdftJw3DnsIy4lfNya7GRoXgHbFDb2hgj
 N9fZSvn+RVIYpYBbkoWtRWRSJh9aBhkLe6a6KUaiyxBGIv+AP8WCShbctWgWj60vT4vX
 NP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967604; x=1784572404;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cGmCiBlaSELFoPdzH4UZt3xo0WPFnSE+PTX5QPBRd6c=;
 b=JVh53zKEGv4rXm0HxWWvTpzUp2PNi9nBHE2E7VuQgs2tvoi4aI+wGk97Hc6Y1qCwHB
 9i77ToB5ZmX9GstU2z4RuBBYPbLEVhGaZ9z190XNhHgCJm+hfYSNFzuL5ko35IX1Bk51
 JpNUa1SNkl/5VtL1idwCL4dldldS5Rw+Q7SbIrGwzRKmG6u66ZbpZWkVxVQpFavCEXd2
 JdDCXGDZ7u9x18SqF9/r+494xmh5Kgwwk0qEbkj6mgx2DI52ttJh+9Q63h3vPvPfra3L
 hgLAt50hfHRB4W/llq7Xt4Ur1fyJgWvfANI6jNjG+K1Z8KKRW8/s6zZBh6jrKT5eIqlv
 YrsQ==
X-Gm-Message-State: AOJu0YykbfVK8O2LegpJiYdGWLz/smU+8adfe3Bmi+calBaRWPYPuQsH
 9iallapXi2tPRLJdlrM4o0dWGXFNTtaccwJnTZlECsPFT6hQmiZUAhZxRZlpsvrKDUUk4vHnyUW
 24nkxVfAOEN6pexU/l4TDQtfTn4NFtO8=
X-Gm-Gg: AfdE7ckmOWv/s3CrPwB9fkX30xco7O7vc5B+N0Ffjv+1p1NaAr1cb9v6WKaEza7qPyU
 OEgOwMzgzDRcgo/2chqMnlEX4p/t0Hkj4ULZmlNcxK1RZlFOLzoodJy5xEqyVGGUukSjTbujZAI
 DHOhLqh1/yJvojacZbBRI1ZxaUvLxwrjRzu1vn4GgwyugXeoEg8ic0TrMVpesJlNpFqZPwBzGi4
 AOVsE+Kk1lz5rsoxixmm1/eeWmLT1mT3TBGxU8+uIdywsc5gxTfco6FcOVX1vX+lih4uT08LH5O
 DKTZnLyk/XucNja0pj78WiW+ybLuazq0LyxNIEEMqex597JFkWJdWAhmBjt2c40hM+mLCw==
X-Received: by 2002:a17:902:fc86:b0:2ca:d803:5c8f with SMTP id
 d9443c01a7336-2ce9e59ed95mr82735565ad.1.1783967604468; Mon, 13 Jul 2026
 11:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260713172431.1599801-1-mario.limonciello@amd.com>
In-Reply-To: <20260713172431.1599801-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 14:33:12 -0400
X-Gm-Features: AVVi8CdVoFL8WJsBt4nGbrBP_ruPvaaKGygbKZBJ33JvaZIlkI2ClViR4SFukLU
Message-ID: <CADnq5_O6MSH0WFK1f011mJ+8DKsX7arGSbS+fFPmhkBmeEu7cg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Move dynamic PCIe switching quirks to
 X86_MATCH_* macros
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Jul 13, 2026 at 2:04=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Use the X86_MATCH_VENDOR_FAM() and X86_MATCH_VENDOR_FAM_MODEL() macros
> to make the quirks for dynamic speed switching more scalable.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++++++++----------
>  1 file changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a4c8702fbf5a7..128a285e2bf4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1304,37 +1304,44 @@ bool amdgpu_device_seamless_boot_supported(struct=
 amdgpu_device *adev)
>         return amdgpu_ip_version(adev, DCE_HWIP, 0) >=3D IP_VERSION(3, 0,=
 0);
>  }
>
> -/*
> - * Intel hosts such as Rocket Lake, Alder Lake, Raptor Lake and Sapphire=
 Rapids
> - * don't support dynamic speed switching. Until we have confirmation fro=
m Intel
> - * that a specific host supports it, it's safer that we keep it disabled=
 for all.
> - *
> - * https://edc.intel.com/content/www/us/en/design/products/platforms/det=
ails/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/=
005/pci-express-support/
> - * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
> - */
> -static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu=
_device *adev)
> -{
>  #if IS_ENABLED(CONFIG_X86)
> -       struct cpuinfo_x86 *c =3D &cpu_data(0);
> +static const struct x86_cpu_id amdgpu_pcie_dynamic_switching_quirks[] =
=3D {
> +       /*
> +        * Intel hosts such as Rocket Lake, Alder Lake, Raptor Lake and S=
apphire Rapids
> +        * don't support dynamic speed switching. Until we have confirmat=
ion from Intel
> +        * that a specific host supports it, it's safer that we keep it d=
isabled for all.
> +        *
> +        * https://edc.intel.com/content/www/us/en/design/products/platfo=
rms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-=
1-of-2/005/pci-express-support/
> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
> +        */
> +       X86_MATCH_VENDOR_FAM(INTEL, X86_FAMILY_ANY, NULL),
> +       /*
> +        * AMD Ryzen Pinnacle Ridge (Zen+, family 0x17 model 0x08) CPUs d=
on't
> +        * support PCIe dynamic speed switching.
> +        * https://gitlab.freedesktop.org/drm/amd/-/work_items/5436
> +        */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x08, NULL),
> +       {}
> +};
>
> +static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu=
_device *adev)
> +{
>         /* eGPU change speeds based on USB4 fabric conditions */
>         if (dev_is_removable(adev->dev))
>                 return true;
>
> -       if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
> +       /* Hosts have problems with dynamic speed switching */
> +       if (x86_match_cpu(amdgpu_pcie_dynamic_switching_quirks))
>                 return false;
>
> -       /*
> -        * AMD Ryzen Pinnacle Ridge (Zen+, family 0x17 model 0x08) CPUs d=
on't
> -        * support PCIe dynamic speed switching.
> -        * https://gitlab.freedesktop.org/drm/amd/-/work_items/5436
> -        */
> -       if (c->x86_vendor =3D=3D X86_VENDOR_AMD && c->x86 =3D=3D 0x17 &&
> -           c->x86_model =3D=3D 0x08)
> -               return false;
> -#endif
>         return true;
>  }
> +#else
> +static inline bool amdgpu_device_pcie_dynamic_switching_supported(struct=
 amdgpu_device *adev)
> +{
> +       return true;
> +}
> +#endif
>
>  static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
>  {
> --
> 2.43.0
>

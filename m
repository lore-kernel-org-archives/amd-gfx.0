Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63EEC4167D
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 15:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2FC10E537;
	Tue, 31 Oct 2023 15:43:40 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1693A10E537
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 15:43:38 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ce344fa7e4so3795853a34.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698767017; x=1699371817; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVytfTqDUnq3eoq8Cx6VjJ1UUzli8ZsnkRjBUBtFcgw=;
 b=hoEKCwbU4SErFpTv4pyDTS4G9PXHX+npQgg1hCoGo4I+b0xc9QNuxhpeC6kl4ouG86
 rEJYqhD6knTqOumhq3BOAjsK2wAcFB8AD3rRji813QmzFxZ/BCz5AQpcuOy2yjjiT+x2
 dOmJP9ZKC8cBflvEw+Yxev+qE5H0gyrLHrjgyczP3IWl72KM52tj32SMl8MaIOa1xArK
 BKUKAJd47x2STle6TkX2I9U6+oh1Hnv8iatHOxHaTZtmXWxD1IrGY3zXmB+FF0oJEwC8
 Ddse4wotp/pfHshKBxbY36ApYCXESl8eQPeVt9BawfkGybRfnkpYiUmIUoe+/es65qFn
 krvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698767017; x=1699371817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVytfTqDUnq3eoq8Cx6VjJ1UUzli8ZsnkRjBUBtFcgw=;
 b=miJRrbW+8DvmxQuXqXUsxayHYWjiGSfmlQcJ5XL4Lmv96/W535IyyWHf1LhqJ0aUEa
 /3tJaVOh3swCxglL3OukVKaIhbpaRD5WGP/q66ap2AwLbKN2oiJqw1ZFsDAW9eCasAch
 D+ynlJJUbztiaHCtP2XaFBohlMdEmd2F1JG+YXRc2b8uwLOf7mhTeeroxllELydO5z6V
 YUOdZM/me23y+9fJ0APC0fzTWA9/eDMeV4T2XhEaUJHfOj5IDZImJWNuk0PW4nIP7fIm
 bjpd1n+Y4RKgiH6UhlGNgNFzX9D1teGAseCMpjirwW8FvcpJU8oiWag0Itdk1yo/BmSL
 HV9g==
X-Gm-Message-State: AOJu0YwxIpMbRyPFC2bZFS75+mT21FMI+Fw4kSdluoei+4husswOsaBn
 X6FZpjAIa+ADQYEouI1EzV0LvszLgxXwaPokuvVIFaJe
X-Google-Smtp-Source: AGHT+IFJ0JlsLNag1K8ufIqhwzvt0KyHEuC/hD5Le1aIxZcKFLAAAgnDuw2+2eG4lj/9CHPJMjyFjZpmdglqyJYj/Ag=
X-Received: by 2002:a05:6870:6b91:b0:1d5:91d6:65f3 with SMTP id
 ms17-20020a0568706b9100b001d591d665f3mr15330173oab.7.1698767016889; Tue, 31
 Oct 2023 08:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231027154225.1662448-1-alexander.deucher@amd.com>
In-Reply-To: <20231027154225.1662448-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Oct 2023 11:43:25 -0400
Message-ID: <CADnq5_My9PuGnR8LBkU1tuYD_38c-rL_2U0HrZCiD4Y2dzLcNw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: don't use ATRM for external devices
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series?

Alex

On Sat, Oct 28, 2023 at 2:32=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> The ATRM ACPI method is for fetching the dGPU vbios rom
> image on laptops and all-in-one systems.  It should not be
> used for external add in cards.  If the dGPU is thunderbolt
> connected, don't try ATRM.
>
> v2: pci_is_thunderbolt_attached only works for Intel.  Use
>     pdev->external_facing instead.
> v3: dev_is_removable() seems to be what we want
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 38ccec913f00..f3a09ecb7699 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -29,6 +29,7 @@
>  #include "amdgpu.h"
>  #include "atom.h"
>
> +#include <linux/device.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> @@ -287,6 +288,10 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_devic=
e *adev)
>         if (adev->flags & AMD_IS_APU)
>                 return false;
>
> +       /* ATRM is for on-platform devices only */
> +       if (dev_is_removable(&adev->pdev->dev))
> +               return false;
> +
>         while ((pdev =3D pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev))=
 !=3D NULL) {
>                 dhandle =3D ACPI_HANDLE(&pdev->dev);
>                 if (!dhandle)
> --
> 2.41.0
>

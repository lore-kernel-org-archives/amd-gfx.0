Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7A1CCD18D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 19:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06ADD10EB07;
	Thu,  9 Oct 2025 19:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c5Y0+rMY";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFE310EB07
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 19:31:31 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-269ba651d06so2071735ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760038291; x=1760643091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ECpg+fsuBzWTnXHRm2lODvL2z8nV9ilFIbyhshCdIs=;
 b=c5Y0+rMYi1+obi6P1WgQznkES/h/8taaAHIZn/lphZMViCRYGBg+4YHj/1AzjzDy8Y
 UNin3QM6e/6wqK9RL4flL+4996fQhMrzF+T5XvUT7YARJpFV5sWvHHORMM2VJFh6hB4k
 To+cVHgxdM3bZ2YzEzs7xL1h5l5mrhkGBAsyz2BEPSPszQKhWs/36cPr2rDbcXxzGL2q
 mzVeBKK2enKVWRoss5QCl+P5GOjYCA4VT6mA6WWm/+ojX51zkhgusQljeZQ2mYmK8pt/
 ZHNg0Un4ar1uQ4CdjzkCWBQK/PFPswRVaJD+kuEqBoPWRD/zrwLfdl15izitTKtXWgHq
 rJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760038291; x=1760643091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ECpg+fsuBzWTnXHRm2lODvL2z8nV9ilFIbyhshCdIs=;
 b=SQhwD+v7jMpvP8fhE+g47uVnkbGS2rYbIYmOYk79zJYyidVmG8aMFngI/rLTU5/MUJ
 0XmBhTcNYfiBMbYbq8B0cFIFhzMFQu0gy6ZFp+ufrfvNATD0BhPlpZ/2fA4L9UN7JXzf
 g2QbUDjOvBlvbaTrmhx8XyDIWVYXhkBjjEf/XBNLeD7HEgV81GcegTvhDbmDSaXBn9HI
 Wy2zXM+ryqCIPIdMRTKJZim5YcEZs2I8yMhPL5+AEm6foceOqL29FBGUJG9mTLqB5bU6
 7HyLbzKTdFWPI9SCMxnxulfeyGV2wZbNJ1ElYiw5Nc8QX8GgZqAtboPEndJkiIBjf/R0
 VQFw==
X-Gm-Message-State: AOJu0Ywh74Qw8E12IJRy1WigjLndg2QvnthPxHxABgL/p0xxLK1qHV2T
 2h1It0wa5ncXYhW09p0zynCj8B/XRV/jSisRwLHmEgxaPilNipiOZnH8Kz4jBKywQjHSaG51nGq
 JpfKZfZkoAL5lGpHDTCOQszZyfuooT0IqSIvB
X-Gm-Gg: ASbGncsqIHZahSsO5mBo43eVKB52BaHLCY/ufBn6tG8UsgsEwMvpUk+xd7r1hnMZOtI
 +7SIZItT6vtRuSeYuWwcTEJH1z/Zg/jTmPZOCBqYdTJgSQSsYrz1/ovD3ssjZF1eHONWUurXEb0
 wAVsdSnIwWQ3QFxv1MEgRPnvXmJDxh1nzO+Xvt3bkJXiPcWHTJYmQAcBZ4iDK4Jb8blDxaDbCO3
 beAAnvup7s6L7WI8aa/v9CX2YyMAZa9/N8CfUuFZw==
X-Google-Smtp-Source: AGHT+IGJIiIoSNptqKmeIzRWvAc5kxdeyjHiJl8fjLOgor9W0qhvbZ6+reHPCi23bZJRAG91QslItOQRIdg5kHksozw=
X-Received: by 2002:a17:902:d2c9:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-2902724dcb1mr61930985ad.0.1760038290689; Thu, 09 Oct 2025
 12:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250926182614.26629-1-timur.kristof@gmail.com>
 <20250926182614.26629-3-timur.kristof@gmail.com>
In-Reply-To: <20250926182614.26629-3-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 15:31:19 -0400
X-Gm-Features: AS18NWDcXGDPffmWXiCSFCttrdNACxRw-0U4N92a49ehofYueEsUVGGSX2hDql4
Message-ID: <CADnq5_OFUfarp56bVxVaUguDMmO-ojn--aBbffd9hjhb4+0bLA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amd: Disable ASPM on SI
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 alex.hung@amd.com, harry.wentland@amd.com, siqueira@igalia.com, 
 christian.koenig@amd.com
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

On Fri, Sep 26, 2025 at 2:44=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Enabling ASPM causes randoms hangs on Tahiti and Oland on Zen4.
> It's unclear if this is a platform-specific or GPU-specific issue.
> Disable ASPM on SI for the time being.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Will pick up patches 1 and 2 today.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a77000c2e0bb..279b6912be2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1882,6 +1882,13 @@ static bool amdgpu_device_pcie_dynamic_switching_s=
upported(struct amdgpu_device
>
>  static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
>  {
> +       /* Enabling ASPM causes randoms hangs on Tahiti and Oland on Zen4=
.
> +        * It's unclear if this is a platform-specific or GPU-specific is=
sue.
> +        * Disable ASPM on SI for the time being.
> +        */
> +       if (adev->family =3D=3D AMDGPU_FAMILY_SI)
> +               return true;
> +
>  #if IS_ENABLED(CONFIG_X86)
>         struct cpuinfo_x86 *c =3D &cpu_data(0);
>
> --
> 2.51.0
>

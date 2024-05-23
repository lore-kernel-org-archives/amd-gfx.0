Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F5DC25B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 18:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E596E10E19B;
	Thu, 23 May 2024 18:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UlkhWaKb";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A94A10E19B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 18:44:45 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2bf5797973fso216737a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716489884; x=1717094684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lI7et7BOzOJPy7QX3kAMn1R+bR7p6sixu7dr4q3eD4M=;
 b=UlkhWaKbTHqRUp4M9+UPVZULbLQgN/7QbG2CXL32WctXH3IdlhvW4PSAOA2Q347IIp
 LXIfh2aDHIKdn9QKLhDHch220GVIBZSnDAShlCTJFPER4Uf9zLwp98TvIDW13dUUNtYA
 +LzxZaekcNhPFmGh9RDs0IMH25a2QBCC/32IQbFA1vxhBQpw4zzcTEAyuWEWiwHDT/wW
 tjhNqGjli+ofissLAK2Ox+v/YvqbzxiYVOu8pw7Tu5pryL/i+lAsKFYSBuNqd1jve7q7
 MRCZn+J51c8dnPCkdU+tDG1FzKwdfedDQrJVlvCsFd0O/4GYIej7x1xoV77owOvEbw/w
 GrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716489884; x=1717094684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lI7et7BOzOJPy7QX3kAMn1R+bR7p6sixu7dr4q3eD4M=;
 b=rYoenXhUL8uXPKSNEOTOx3+2aga1uPQfX1bJEUDTKmFR4CaiF2qBrOQezF43DHQlCd
 CdUg4drqkAi7aYCmKpuxeXMH6jlFSwbyt3g86zKUYyhdTlpA2TeJhq2mcMNQq2wLPC6H
 FrFTW8JKHqdZHwYFTkPRXCNKFOHwtlq5HioENBZhcsQmSKTM06iIHD6qC0bAwvOvtG7t
 QiJ+mCHlBfS4Mo7g1wzlr52iE+vQOHpwNOuXGovwRp1tFWvQynfGijWjLAzUvJwLzYau
 Eb1+BcSuxOF6cRi5PAG7IAI63eWsedhPmbWwFyGl6caFUQzVsfJCQVf4dhL/Ame9MCAt
 v/2g==
X-Gm-Message-State: AOJu0Yz4cV5P7gfnW6hW7eWy2d+RuSa6s2qSwTRVTb2BIi8JpcGbQibz
 dPcsa5C1J2zhAfNJYLf6uveOYuM2zJjsKhoB8M5uCrT/i0p3z6PG3vSJIYrItD6Q+hGwG8+7Boj
 DRRilwokq2c6+nCvUF48w0FL08AHOlg==
X-Google-Smtp-Source: AGHT+IEbFbnI2/yiaOrxPvBV9nv0IC3q6n+hqA7ixGp5qWyH6eznJrxi61h4cH8lf83m2O34ooXk9ysfhsdrzonFTK0=
X-Received: by 2002:a17:90b:3005:b0:2b1:9fa4:16fd with SMTP id
 98e67ed59e1d1-2bf5e84acadmr10170a91.4.1716489884619; Thu, 23 May 2024
 11:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240516150512.2260787-1-alexander.deucher@amd.com>
In-Reply-To: <20240516150512.2260787-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 May 2024 14:44:32 -0400
Message-ID: <CADnq5_Pf0e6+yK2iMmUjU-wTG+03+W+RBMB7tQ4MQMFGZM_9eA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adjust logic in
 amdgpu_device_partner_bandwidth()
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Thu, May 16, 2024 at 11:42=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Use current speed/width on devices which don't support
> dynamic PCIe switching.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3289
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e72e774d17e6a..f0011dac589d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5946,13 +5946,18 @@ static void amdgpu_device_partner_bandwidth(struc=
t amdgpu_device *adev,
>         *speed =3D PCI_SPEED_UNKNOWN;
>         *width =3D PCIE_LNK_WIDTH_UNKNOWN;
>
> -       while ((parent =3D pci_upstream_bridge(parent))) {
> -               /* skip upstream/downstream switches internal to dGPU*/
> -               if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI)
> -                       continue;
> -               *speed =3D pcie_get_speed_cap(parent);
> -               *width =3D pcie_get_width_cap(parent);
> -               break;
> +       if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
> +               while ((parent =3D pci_upstream_bridge(parent))) {
> +                       /* skip upstream/downstream switches internal to =
dGPU*/
> +                       if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI)
> +                               continue;
> +                       *speed =3D pcie_get_speed_cap(parent);
> +                       *width =3D pcie_get_width_cap(parent);
> +                       break;
> +               }
> +       } else {
> +               /* use the current speeds rather than max if switching is=
 not supported */
> +               pcie_bandwidth_available(adev->pdev, NULL, speed, width);
>         }
>  }
>
> --
> 2.45.0
>

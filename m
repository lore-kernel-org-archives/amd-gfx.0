Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAE8CD4847
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 17:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6441F10E6A2;
	Fri, 22 Sep 2023 17:21:45 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E710D10E6A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 17:21:42 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ab7fb1172cso1356505b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695403302; x=1696008102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17du8x9KmUfmf5dAtnJX7ZOfa+LHmYI0TiNlgyX+qQM=;
 b=RKYbRv/1z0oHIQWZWRyOVZkPyKttYc6sA0Y+d0LhqnXV/ACxRMWhuaJHtvQmFczUfU
 EJDGClUHu2lhYOvKtZVwawdmJEB/sox+7uT861WJ0okJLcawj/2uCoJ3Y0rd2mMHbARI
 z/hACyiw+sCk7rPX65dGAFjsPH2zNIoxxHnFgKZmd3/d6Uc/P67vE3875PlJb/UdlrLj
 2Clqo6E7O3sM/popHeI+3QMWB8URKlXZgISomaJv1JAeu7pNGOo2YLc5fdf91srynQWt
 Ra4c9C5Z0OHVzj7BYaJNpoe4w5U//o36o5meCJp7TY+qgqczRoi6wK7ofDQF/M2x6ti4
 2G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695403302; x=1696008102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17du8x9KmUfmf5dAtnJX7ZOfa+LHmYI0TiNlgyX+qQM=;
 b=c34yj05EjrCvQuw5SMaOj1OA2Z8stJIZeSHBva4S9USPnFcTu6mEykQLeqPDpImuZ5
 lBgY/Wd2JLAr2LZGoU4Kj5yjuruvyjDnCcmXBHEcCw000zaSqHqA5E3dBdm9LByYcxfG
 E/V14dPUL8kF3BoVazSGiF68T9quElIDfbD4wRHSCaWxakQYG6RvA/SbCyFq1rUzoTqi
 WPMYJI/ylb8mPs/KoR9fPc1zq7uzyT+Jm4pmKtunBId1wfuKvc6KpZNnlG99m7RilRds
 Gl3BZjUsIPrcBBOiDCFcON5FI0LF5BJmi1pQ3Gjwtc08WxRF1o3ELsgS4Q4Ws77J8OxF
 MIXA==
X-Gm-Message-State: AOJu0Yw1bhfT2cMXMpHfcj0T6KKElFSaS4tBxFQVlEQ/SWulIezLEtE7
 LOvE9gE0hJiE+1X7V3G9haIO/Z2XE+O7hxUiT7I=
X-Google-Smtp-Source: AGHT+IFt3OVnKC528MBihw58mzplV/GGMkCknMcNVPNvbB9SxoIlui6DyxNzURZzYrRo+9bYrRs8v9DXq0UkoZLAvXA=
X-Received: by 2002:a05:6870:2314:b0:1d5:a4bd:6028 with SMTP id
 w20-20020a056870231400b001d5a4bd6028mr131925oao.8.1695403301944; Fri, 22 Sep
 2023 10:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230922052753.1922483-1-kevinyang.wang@amd.com>
In-Reply-To: <20230922052753.1922483-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Sep 2023 13:21:30 -0400
Message-ID: <CADnq5_MsiOwF6bgQcvuEsTu=CGY80hJ9PXMsfak6K8t02G95=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix memory leak in
 amdgpu_fru_get_product_info()
To: Yang Wang <kevinyang.wang@amd.com>
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
Cc: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 22, 2023 at 2:06=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> fix a memory leak that occurs when csum is 0,
> the origin function will return directly and forgets to free 'pia' resour=
ce.
>
> Fixes: 0dbf2c562625 ("drm/amdgpu: Interpret IPMI data for product informa=
tion (v2)")
>
> CC: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 401651f28ba2..50b6eb447726 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -111,7 +111,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  {
>         unsigned char buf[8], *pia;
>         u32 addr, fru_addr;
> -       int size, len;
> +       int size, len, ret =3D 0;
>         u8 csum;
>
>         if (!is_fru_eeprom_supported(adev, &fru_addr))
> @@ -171,16 +171,17 @@ int amdgpu_fru_get_product_info(struct amdgpu_devic=
e *adev)
>         /* Read the whole PIA. */
>         len =3D amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia=
, size);
>         if (len !=3D size) {
> -               kfree(pia);
>                 DRM_ERROR("Couldn't read the Product Info Area: %d", len)=
;
> -               return len < 0 ? len : -EIO;
> +               ret =3D len < 0 ? len : -EIO;
> +               goto Out;
>         }
>
>         for (csum =3D 0; size > 0; size--)
>                 csum +=3D pia[size - 1];
>         if (csum) {
>                 DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum)=
;
> -               return -EIO;
> +               ret =3D -EIO;
> +               goto Out;
>         }
>
>         /* Now extract useful information from the PIA.
> @@ -220,7 +221,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>         adev->serial[sizeof(adev->serial) - 1] =3D '\0';
>  Out:
>         kfree(pia);
> -       return 0;
> +       return ret;
>  }
>
>  /**
> --
> 2.34.1
>

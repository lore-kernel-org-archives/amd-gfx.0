Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5F6CD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 19:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F0310E640;
	Mon, 15 Jun 2026 19:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FEOV3EqH";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613FF10E62F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 19:50:20 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-304dd3bb7a6so381329eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 12:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781553020; cv=none;
 d=google.com; s=arc-20240605;
 b=UJ+eDj5STUiHg5tcvBNZDco+7ahbxTib7LBtAxScSkLc9BflLXshXERbjdtyoWXVxj
 HiIGmw8IApjuQhlrPls5oIvCrgUtcacCwjpw8UBQCYKTI0wnJbllEfJaZ8Dx99n+M4f+
 VJzMCpT9nhNIWYTdpq/Gl66Izjs2FNOdyS2ubvpfaI2K9H1hlEUB1+X44ArLzlOcKuDq
 HmGwLR7H1K0r5wJnfDXe2wC+Jer8RgdlKPF81YHLt/WPtNrYQvfHKIhRxWh9hi6uQh/i
 7qBSswkcbMHgaMInMf5DIGIHQGIQwkGX+VBmNUHMFyQkNRNd9GIZCzX9YDNKBm3hGRXV
 frfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aIL3y5hO7RkcUbnywiTaMMFfNgYvzKV9Qga1n905E08=;
 fh=W7Gj99rVFcodb0HTSvL4DqrguJnlpSMVUyswAMaAekI=;
 b=HjVqJwWUkVOrNDnIiGvzTH7xEkU5f3uZNAuWOyPVA76VU0M07ziLvlME0SbCNSqTD1
 x/L4OxvDoBgo7ojsuBtOpj4HbGrHRAHP4MfX4PxW2r5JubHpI83A5jAtfbYg+ooTBmvs
 R5AT3WlZ2Fta1FYGudLG64/TFLsmYXVPn7EUoI19HkI+hxHsHlrYhutVt23AqkoQBCoW
 cTM4oRmp+ayb2ep124iIi58hBjlvVAGULmSBP5WZW8JiL4QacOpX0IV20CPlPUmfZjFQ
 sPI8WSggsl+TRM7XFmdcUMYdDcYtB7Feg4MM2KyDIadX7+pMYfwwkEgHZnhuRJdwF9tz
 IzjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781553020; x=1782157820; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIL3y5hO7RkcUbnywiTaMMFfNgYvzKV9Qga1n905E08=;
 b=FEOV3EqHG7+UIXvt2ELT+kCsaX3o4g5ZybQhNSV3/F5mjfTBwsZA5oz5N8oVDrJFLG
 f0uqSrOsxKZ3Zy+kREy7iFvIrNw8y7dxEXCH/tm6pD0v1C/OhHEVs76/C3GSp4+tUPZc
 Jo9rYmUahGXP0hhIjVzgzlCBwAxvDQpjkX2IK/r11WgF69D77kH1NYnNUOdw6BZjbJ8N
 2AmZc9vAAPIiXwr1bbZuEEW/sDHrlb6kcNwKccZWOgtz3gTfqIO8Ddo7aJlmZhX8OI1L
 TEFLr/tjkYCcFbdjxKesWit/F53ETJVwoba2mymcXuTnO336THqJH/zhqkd9ZWzQDYy5
 bs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781553020; x=1782157820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aIL3y5hO7RkcUbnywiTaMMFfNgYvzKV9Qga1n905E08=;
 b=PTl6lmeznIvwDV29+msB+qrx22jhOkzTsC6x9R6vuQ2S60tw7MlzRHL26y799ZxqgY
 34iWYH37QJYcVxsIEYacd8QUVS1D+PX6pJiWqLcCRmChKJoRm1PqA5ZFH+zTELvgmoQn
 rYN1LJaojmvGqcxCrrqFeUFxiFwef/kqx+Tv8wt0nxp6KzCCfFgNlt32WHzcTz2d2zGc
 pQgEcCTXc0PNJfXuItDX615Nx8gi8mfR4Ri7diN67xmh8NUxt/MKsx67ADu1dHCVEhLP
 BQ8PhBRVmg/zO6SrvT2AMCo/einCbGhpr8cjzAzZg+xqnutkunLTOc1HcCtSDwxJ3mfl
 2oXg==
X-Gm-Message-State: AOJu0YxDz2RYKi4Z6yEc6G75e90XAxuY29cpTNPCWYEh68e374Li1CfM
 6PqBATvuD8z1WdZ5p+SlQr9KVNLoNDR6KMo6qI8uIj5gLzSTF0w+XtmxmUX5P64PM9nBEwZkalh
 Jb/cRXACnKd1f0i7ce9GIgsncfPQzl8U=
X-Gm-Gg: Acq92OGaGLYJ/P/5y4cZkj964Fl++jCXNWshyVOnJhyPkDriVOucxlVkaZ86llBU9Gw
 V+h/kYIj+iMRc7tbil0efP29vaazbzqIKtXdRHTjRlaP4/Acm03S5iBiF/c0Ste08zZjGDREkLI
 SRCEr6z8WCBvxSWPxxlDu2CEv1YpdA3cmPVv0kSA3HQqiTkoqqMo1B4JEHB2XW/HD/O8i1PV3FK
 PrJ/KBqu8TwmKMcNRumIsqzpmCOSmaBsVP0y6jYtXSkk6YlmJ0xTXTdniVzDSKSIymo4fh/AJe4
 r9q548SLKmhvNbtz/q8icVRN/LTBs0Xs2NPX5rkaRSIC9XvXhIm33/BuT6FKd9gMMcf3zg==
X-Received: by 2002:a05:7022:38f:b0:138:49ea:f49a with SMTP id
 a92af1059eb24-1384bb97122mr3275632c88.5.1781553019513; Mon, 15 Jun 2026
 12:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260615193518.3989770-1-ruijing.dong@amd.com>
In-Reply-To: <20260615193518.3989770-1-ruijing.dong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 15:50:07 -0400
X-Gm-Features: AVVi8CeXCIlP5MqiDB8LBMSpwcKxhmctJmcHXcdRWJ0BXgiG2FIcaMqRM9fyNdM
Message-ID: <CADnq5_MLbkFff-8xAE1d5BxSFyhSg--x-dpQqMA=sTb2VUQJ0g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add UMSCH HW IP
To: Ruijing Dong <ruijing.dong@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Christian.Koenig@amd.com, Pratik.Vishwakarma@amd.com, leo.liu@amd.com, 
 boyuan.zhang@amd.com
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

On Mon, Jun 15, 2026 at 3:44=E2=80=AFPM Ruijing Dong <ruijing.dong@amd.com>=
 wrote:
>
> This part enumerates a UMSCH block under hardware id (22) at version
> 2.2.0 rather than under VCN. Add the UMSCH hardware id, an IP enum
> slot, and the discovery name/map entries so it is recognized.
>
> The multimedia IP setup assumed VCN/VCE/UVD was always present; handle
> the case where it is absent so init does not fail with -EINVAL.
>
> Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
> Assisted-by: Claude:claude-opus-4-8 checkpatch

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c    | 9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h           | 1 +
>  drivers/gpu/drm/amd/include/soc15_hw_ip.h        | 1 +
>  4 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 322c55aaf15f..ba2f15d12751 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -63,6 +63,7 @@ const char *hw_ip_names[MAX_HWIP] =3D {
>         [VCN1_HWIP]             =3D "VCN1",
>         [VCE_HWIP]              =3D "VCE",
>         [VPE_HWIP]              =3D "VPE",
> +       [UMSCH_HWIP]            =3D "UMSCH",
>         [DF_HWIP]               =3D "DF",
>         [DCE_HWIP]              =3D "DCE",
>         [OSSSYS_HWIP]           =3D "OSSSYS",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 2cfcfa29204a..430f68181005 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -226,6 +226,7 @@ static const char *hw_id_names[HW_ID_MAX] =3D {
>         [XGBE_HWID]             =3D "XGBE",
>         [MP0_HWID]              =3D "MP0",
>         [VPE_HWID]              =3D "VPE",
> +       [UMSCH_HWID]            =3D "UMSCH",
>         [ATU_HWID]              =3D "ATU",
>         [AIGC_HWID]             =3D "AIGC",
>  };
> @@ -258,6 +259,7 @@ static int hw_id_map[MAX_HWIP] =3D {
>         [DCI_HWIP]      =3D DCI_HWID,
>         [PCIE_HWIP]     =3D PCIE_HWID,
>         [VPE_HWIP]      =3D VPE_HWID,
> +       [UMSCH_HWIP]    =3D UMSCH_HWID,
>         [ISP_HWIP]      =3D ISP_HWID,
>         [ATU_HWIP]      =3D ATU_HWID,
>  };
> @@ -2631,7 +2633,12 @@ static int amdgpu_discovery_set_mm_ip_blocks(struc=
t amdgpu_device *adev)
>                         return -EINVAL;
>                 }
>         } else {
> -               switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
> +               int vcn_version =3D amdgpu_ip_version(adev, UVD_HWIP, 0);
> +
> +               /* no VCN/JPEG discovered; nothing to add */
> +               if (!vcn_version)
> +                       return 0;
> +               switch (vcn_version) {
>                 case IP_VERSION(1, 0, 0):
>                 case IP_VERSION(1, 0, 1):
>                         amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_blo=
ck);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ip.h
> index 1d0df6d93957..590ad82f115e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> @@ -68,6 +68,7 @@ enum amd_hw_ip_block_type {
>         ISP_HWIP,
>         ATU_HWIP,
>         AIGC_HWIP,
> +       UMSCH_HWIP,
>         MAX_HWIP
>  };
>
> diff --git a/drivers/gpu/drm/amd/include/soc15_hw_ip.h b/drivers/gpu/drm/=
amd/include/soc15_hw_ip.h
> index a20e59584dde..60f588dd0130 100644
> --- a/drivers/gpu/drm/amd/include/soc15_hw_ip.h
> +++ b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
> @@ -44,6 +44,7 @@
>  #define SDPMUX_HWID                                       19
>  #define NTB_HWID                                          20
>  #define VPE_HWID                                          21
> +#define UMSCH_HWID                                        22
>  #define IOHC_HWID                                         24
>  #define L2IMU_HWID                                        28
>  #define VCE_HWID                                          32
> --
> 2.49.0.593.gd86a19f485
>

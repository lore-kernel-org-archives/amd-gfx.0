Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DB6C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9098710E0F0;
	Fri,  7 Mar 2025 15:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OaWSXo1U";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A173E10E0F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:47:53 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ff7cf59a8fso257843a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 07:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741362473; x=1741967273; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5G6ttQyPF9THDFM112iou8afR2x4ABLFsyIEFDXK3U=;
 b=OaWSXo1UVflCqnJ0AgtrVeOjqpsbyo4D9gEnEaBTHa5mKdCt1ikQVPzkMmHpm8inAj
 vgKwYQVnb6ffA6rt9F5LY6eLSxt+2sTA6lePok7cGgeo4vR8NEEzRT07UwNF6PSGbXlN
 bkeiMqbZm7C3s3vxptq8+7ziEjHXjKI1NY/gT/xDgoG+x2Z7kE4oMOyQHF+kjxzLb59V
 G1OcV1+W919TdIzxwOtCaAB1Pc5qTup198BoWqjZbafhhloI2ZdAbkfZq5Ref8PH9zyd
 4Hr9e1w0BpR6h5dccHttOs56X76pFRenJt+pt4qdCC6Mi81QyG9cD43RAEyF4GeKXZu3
 z0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741362473; x=1741967273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5G6ttQyPF9THDFM112iou8afR2x4ABLFsyIEFDXK3U=;
 b=CJEEbqudIn7lJRWDAQcDDv2/NYiy/Qi8qgGoAOt0I34A8LePKJJU3Rdp+s8uL2k5wr
 xVx/jCIIgPfp3WiUa6gp8AEwjG7+gzUMKsf/x3FcsVGtfXTdWjt0Oel6AUbawQRxPoVD
 Dw8cDLHWfQxFFEL9KNgtja6rJMXWD0SgvkwBBJO3doxus6PYquwuoaW7/9+bZI5G6C7j
 w+wVg9oP75odXu5IQsuD2wt/Bbznh8Kv/5EncP8U7NfpyMsTitZK8f/QwDBb4LMhNMgu
 WmGkGbB+GZH3JSy+OwOgGwqQCt1aDQ4Wvk4PrchwlQckxPY1Ejqgub2i6wFqqgSDB2Vn
 6NWA==
X-Gm-Message-State: AOJu0Yx3R2cJj9FRluMVpAJRLn5uXWVssIsTd0hMlBcgFvzjNoqCmLkd
 WqmL86EquaMm4BOiMpa7Z9+M4EcQxhVpTx9RxQo3xIv4L8mlA23uJSrdHGcwjDzhytgQcTOVrO8
 Iagn44hMdR0dia3lO8p7eR8fKuuk=
X-Gm-Gg: ASbGncuv+xA2FEI236/2X1O2OSNh/trUdYKvNA5kB4ayTLs7pVKGWN+uq8HygPy+Tzx
 p23C+MOQGMzxE+bP7CX8Hk+m5lSaYYLapCY/PrwVRw2mWHLFkd0Rnu9PVv2oQ/SwwlnNHD4TGCw
 w385JyKMpO55s5U7vJVUbLJJUsGA==
X-Google-Smtp-Source: AGHT+IFdJCLGzKd4TJIsso8wpkpgShiL+/GzObaZFSgxEksfUXCpBxcBElt/y3EEOahBhZfu11cGGiQh9L+9tFoqE8A=
X-Received: by 2002:a17:90b:3811:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-2ff8f8e6532mr61184a91.4.1741362473079; Fri, 07 Mar 2025
 07:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20250306204945.2256-1-mario.limonciello@amd.com>
In-Reply-To: <20250306204945.2256-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Mar 2025 10:47:40 -0500
X-Gm-Features: AQ5f1JohU1VbatsGFKrwr2eWmoIG8Yv936N86flNR8XXQ-l5wA8YHr9-xo2l-SY
Message-ID: <CADnq5_PAHpv=KipPP31nn1dx3fC1z4theh4v9rhFTDVnzxb8Kw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd: Fail initialization earlier when DC is
 disabled
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

On Thu, Mar 6, 2025 at 3:51=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Modern APU and dGPU require DC support to be able to light up the
> display.  If DC support has been disabled either by kernel config
> or by kernel command line the screen will visibly freeze when the
> driver finishes early init.
>
> As it's known before early init is done whether DC support is required
> detect this during discovery and bail if DC support was disabled
> for any reason.  This will ensure that the existing framebuffer
> provided by efifb or simpledrm keeps working.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Use amdgpu_device_asic_has_dc_support() instead to cover virtual
>    displays and bringup
> v2:
>  * Update commit message justification
>  * Add correct "default" handling
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 49 ++++++++++++++-----
>  1 file changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index a4258127083d0..ddd10e6345601 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2134,15 +2134,14 @@ static void amdgpu_discovery_set_sriov_display(st=
ruct amdgpu_device *adev)
>
>  static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *=
adev)
>  {
> +       bool asic_support;
> +
>         if (adev->enable_virtual_display) {
>                 amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
>                 return 0;
>         }

I think this will break for chips with harvested DCN blocks.  I think
you need to return early here in that case.  E.g.,

if (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
    return 0;

Alex

>
> -       if (!amdgpu_device_has_dc_support(adev))
> -               return 0;
> -
> -#if defined(CONFIG_DRM_AMD_DC)
> +       asic_support =3D amdgpu_device_asic_has_dc_support(adev->asic_typ=
e);
>         if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>                 switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>                 case IP_VERSION(1, 0, 0):
> @@ -2166,39 +2165,63 @@ static int amdgpu_discovery_set_display_ip_blocks=
(struct amdgpu_device *adev)
>                 case IP_VERSION(3, 5, 1):
>                 case IP_VERSION(3, 6, 0):
>                 case IP_VERSION(4, 1, 0):
> +                       if (!asic_support) {
> +                               dev_err(adev->dev,
> +                                       "DC support is required for dm ip=
 block(DCE_HWIP:0x%x)\n",
> +                                       amdgpu_ip_version(adev, DCE_HWIP,=
 0));
> +                               return -EINVAL;
> +                       }
> +
>                         /* TODO: Fix IP version. DC code expects version =
4.0.1 */
>                         if (adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERS=
ION(4, 1, 0))
>                                 adev->ip_versions[DCE_HWIP][0] =3D IP_VER=
SION(4, 0, 1);
>
> +#if defined(CONFIG_DRM_AMD_DC)
>                         if (amdgpu_sriov_vf(adev))
>                                 amdgpu_discovery_set_sriov_display(adev);
>                         else
>                                 amdgpu_device_ip_block_add(adev, &dm_ip_b=
lock);
>                         break;
> +#endif
>                 default:
> -                       dev_err(adev->dev,
> -                               "Failed to add dm ip block(DCE_HWIP:0x%x)=
\n",
> -                               amdgpu_ip_version(adev, DCE_HWIP, 0));
> -                       return -EINVAL;
> +                       if (asic_support) {
> +                               dev_err(adev->dev,
> +                                       "Failed to add dm ip block(DCE_HW=
IP:0x%x)\n",
> +                                       amdgpu_ip_version(adev, DCE_HWIP,=
 0));
> +                               return -EINVAL;
> +                       }
> +                       return 0;
>                 }
>         } else if (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
>                 switch (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
>                 case IP_VERSION(12, 0, 0):
>                 case IP_VERSION(12, 0, 1):
>                 case IP_VERSION(12, 1, 0):
> +
> +                       if (!asic_support) {
> +                               dev_err(adev->dev,
> +                                       "DC support is required for dm ip=
 block(DCI_HWIP:0x%x)\n",
> +                                       amdgpu_ip_version(adev, DCI_HWIP,=
 0));
> +                               return -EINVAL;
> +                       }
> +
> +#if defined(CONFIG_DRM_AMD_DC)
>                         if (amdgpu_sriov_vf(adev))
>                                 amdgpu_discovery_set_sriov_display(adev);
>                         else
>                                 amdgpu_device_ip_block_add(adev, &dm_ip_b=
lock);
>                         break;
> +#endif
>                 default:
> -                       dev_err(adev->dev,
> -                               "Failed to add dm ip block(DCI_HWIP:0x%x)=
\n",
> -                               amdgpu_ip_version(adev, DCI_HWIP, 0));
> -                       return -EINVAL;
> +                       if (asic_support) {
> +                               dev_err(adev->dev,
> +                                       "Failed to add dm ip block(DCI_HW=
IP:0x%x)\n",
> +                                       amdgpu_ip_version(adev, DCI_HWIP,=
 0));
> +                               return -EINVAL;
> +                       }
> +                       return 0;
>                 }
>         }
> -#endif
>         return 0;
>  }
>
> --
> 2.43.0
>

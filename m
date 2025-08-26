Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91582CA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 13:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D3510E279;
	Tue, 26 Aug 2025 13:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zv73E0Yh";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0CE10E279
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 13:49:34 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-246190697f4so5943675ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756216174; x=1756820974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfzMrn3lqaYPupVHJxSGQ899PzrRPNIa6y+/VZEbYIY=;
 b=Zv73E0YhnnPgZ6DZ/Jt0DeJhQwzWFFdKtLgV4s/aI3i5GSEW2jVwN9Xqlf97CcVNir
 qF6z6WlkvfXDkEjVeqSskG6KK9LwltJDe+//Rk7IFi+tb5XPhBCKKNs3SlVWJ6Kmv8Vf
 ZHceC2JhWd0hI6Z+1b6JX7x1Zfkae7LDRji+QTLZ0tMftyD8zyZtk2aEBmItTgg5FEU3
 eRwaXKNaPVoVLXgxG6tfM4mPm3y8TzcksXbzwfT/auYJmxVIzdOP1XQC0sTlQ5bfEipb
 IIEZJRyjZtzpxtbnZopQjeRcHhcD8n5EgXBP8ozDSbGZYzAsiitmqQJlVn6xEBecwUOT
 xv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756216174; x=1756820974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfzMrn3lqaYPupVHJxSGQ899PzrRPNIa6y+/VZEbYIY=;
 b=EZydvYpqC5Ce3X1/1SgUbt15YWBf9vMhfTH4Tlx8rHlNOalD71+ONNjzFhSqqCMa4p
 NHbSNFogDNdbAfZigDEeUXUjG4rmlI+OxK96sA5ZP4PQeKOE9e869clu6CkvppAQ3G0B
 xybj6i+6CO66ooJIQSXmNiB4WZpp2llDA3DC9TFwwhRIEu+HGgzO5/qOj3XjmU+O352y
 bkwG+3/RF2BqtuNKRa3RXnQoipM+8pcGxVSTb0a9CJ1oBKCs8+G1BewBA663in92xwjm
 4AVkpduZbPo75td3Q1fG2AYHHSBrXdN0yK8BE2y3SrMDVjkjC9Gfoi0BC7/TwZo2fC4y
 XhTw==
X-Gm-Message-State: AOJu0YzqRnw+4sofS7kh9K7aQfeu22HrLbwjApW71SQWkZ45e1rhWXOm
 JVO8+RoYEBOtCXsNdLVepyiTJtsXZNV9djBHyCp4F3bJ6JtEHR7aEsc268YJWaK9MoSkh4sxBqY
 rN5l0YXlAKRazDw8WcSamDQ/Ols/9ynB1FGIi
X-Gm-Gg: ASbGncuORPi0ch11P3RvT23/YfJNQG1SAysYK73Co6JYrTsDxKWX+VoNWc2pQAT0eTx
 PEAzFq78sN5hn+uUzo8G/pyjCtcdU0AUA+nj3Uy1HElogGtgKIgv2z91ee0zPWOJuOr8eXcmoQ4
 8hZIix/x7+plM67iJEk8FcNa9ni69IYhhHh4MRC65ru4domU28kIrT64BUBFUlutSfdZiQTiUou
 GomRvk=
X-Google-Smtp-Source: AGHT+IGQRmdOc7cIkjPfnqolji5Gc/ZfQ0CQvLQgwdCCE+hU87bcxDluStBtAyMsL7OM/A4YNpnIl75vkrSGPKicOWM=
X-Received: by 2002:a17:902:d506:b0:246:b1cf:fec2 with SMTP id
 d9443c01a7336-246b1d002d1mr65981745ad.4.1756216174084; Tue, 26 Aug 2025
 06:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250826060245.334880-1-kevinyang.wang@amd.com>
 <20250826060245.334880-2-kevinyang.wang@amd.com>
In-Reply-To: <20250826060245.334880-2-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 09:49:22 -0400
X-Gm-Features: Ac12FXw7xfCyok7o8r0TvZ4AMkUDyWdoOG9GowBVbTEbWT5pZaBzwnc7ULKGr3c
Message-ID: <CADnq5_OT1dE1zUgjAuQijEOtWeOhvVOf3gDQ7Ys8qADN=dxsfA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: unified amdgpu ip block name
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Asad Kamal <asad.kamal@amd.com>
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

On Tue, Aug 26, 2025 at 2:03=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> 1. Unified amdgpu ip block name print with format
>    {ip_type}_v{major}_{minor}_{rev}
>
> 2. Avoid IP block name conflicts for SMU/PSP ip block

What is the conflict?

>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Reviewed-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 35 ++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e117494e8054..5754b1fe77be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2447,6 +2447,33 @@ int amdgpu_device_ip_block_version_cmp(struct amdg=
pu_device *adev,
>         return 1;
>  }
>
> +static const char *ip_block_names[] =3D {
> +       [AMD_IP_BLOCK_TYPE_COMMON] =3D  "common",
> +       [AMD_IP_BLOCK_TYPE_GMC] =3D "gmc",
> +       [AMD_IP_BLOCK_TYPE_IH] =3D "ih",
> +       [AMD_IP_BLOCK_TYPE_SMC] =3D "smu",
> +       [AMD_IP_BLOCK_TYPE_PSP] =3D "psp",
> +       [AMD_IP_BLOCK_TYPE_DCE] =3D "dce",
> +       [AMD_IP_BLOCK_TYPE_GFX] =3D "gfx",
> +       [AMD_IP_BLOCK_TYPE_SDMA] =3D "sdma",
> +       [AMD_IP_BLOCK_TYPE_UVD] =3D "uvd",
> +       [AMD_IP_BLOCK_TYPE_VCE] =3D "vce",
> +       [AMD_IP_BLOCK_TYPE_ACP] =3D "acp",
> +       [AMD_IP_BLOCK_TYPE_VCN] =3D "vcn",
> +       [AMD_IP_BLOCK_TYPE_MES] =3D "mes",
> +       [AMD_IP_BLOCK_TYPE_JPEG] =3D "jpeg",
> +       [AMD_IP_BLOCK_TYPE_VPE] =3D "vpe",
> +       [AMD_IP_BLOCK_TYPE_UMSCH_MM] =3D "umsch_mm",
> +       [AMD_IP_BLOCK_TYPE_ISP] =3D "isp",
> +};
> +
> +static const char *ip_block_name(struct amdgpu_device *adev, enum amd_ip=
_block_type type)
> +{
> +       int idx =3D (int)type;
> +
> +       return idx < ARRAY_SIZE(ip_block_names) ? ip_block_names[idx] : "=
unknown";
> +}
> +
>  /**
>   * amdgpu_device_ip_block_add
>   *
> @@ -2475,8 +2502,12 @@ int amdgpu_device_ip_block_add(struct amdgpu_devic=
e *adev,
>                 break;
>         }
>
> -       dev_info(adev->dev, "detected ip block number %d <%s>\n",
> -                adev->num_ip_blocks, ip_block_version->funcs->name);

Can we keep ip_block_version->funcs->name?  There is useful
information encoded in that.  E.g. dm vs dce_v6_0 depending on whether
DC is enabled or not or powerplay vs swsmu for SMU.

Alex

> +       dev_info(adev->dev, "detected ip block number %d <%s_v%d_%d_%d>\n=
",
> +                adev->num_ip_blocks,
> +                ip_block_name(adev, ip_block_version->type),
> +                ip_block_version->major,
> +                ip_block_version->minor,
> +                ip_block_version->rev);
>
>         adev->ip_blocks[adev->num_ip_blocks].adev =3D adev;
>
> --
> 2.34.1
>

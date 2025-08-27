Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4015CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 14:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4320D10E004;
	Wed, 27 Aug 2025 14:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWJCcnSO";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86DEE10E004
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 14:35:22 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b475b63ab66so1445587a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756305322; x=1756910122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWltCP20/ecCLkSErVu/KDpjjKaMUiPaKQI3denZ4kc=;
 b=MWJCcnSOTMlLh7E7Xrw9vshmXglg6M1lMUa8ovR89rvGDej1vOzS2Sc9PUzYUSICzA
 R+qa3RvZBvCbRC4A/vuGL8Yuk0AhRMRUsGfs0DsZ5LMw1k8nrIYz0avPu9dpRduY0uyQ
 7wT8cI3JLJ+E6y6XiwsJwsHwPukU/SlYBApWkOC88ayx5zYVofeW9CPa1DRQu3HpGHaZ
 8gtBQp499buS1E/ZIAX+sfH76UizameMuE9Cyezovhu+USTCLFu1Or4k4f2HafuMR4S0
 D/9FO3GH7k0iFk3TMFQG2SuTXMvr/udHvD8SYqcSEJ86QScKwpqKaW/XY9FbvlrV6PNK
 e3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756305322; x=1756910122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWltCP20/ecCLkSErVu/KDpjjKaMUiPaKQI3denZ4kc=;
 b=fc/rEvLqV/uN3r0FlrMJR0MRpvwCuiPwlCrRZ056JDQ+Ww7zJOUBST9YjMEX9PcITa
 bCyCKsuTUr+NSiU8XfoVfhwI3IpkHQVTBrPLMvBIUTsBWUXpRAiq/Wr7dXX6A57aybMe
 F7w5gY5b5YCC4gLyIBJUKJ+hsajLvvzcHEW45SCUiBw9U9Hp7kre0SDCFnMO8AdE/NRy
 FQys8r3fbCu8Sy5WqKL/Efbvrfdua3hgGvxXQfHMImFavE1eEEKzMvtWbnn9wP02OQoi
 +woXsqF8fjdxVU6+v3Lnsmy0FZ+85IkwxzRzSbw8v9axlZSu2p6ocyqxRIKzs2qaB48G
 da+Q==
X-Gm-Message-State: AOJu0YxnENumI6B5sRbsTf0uGLq06eD8Yi5cgS1zxpIXWhXowSv7Q5hQ
 Qh0cYMn+v1Gxl4qvJDvIY4dVUh6z90dA7B8FOYBapBUjHieJpkktp7Id08nEocqU3c0L25nbb5k
 DVcbHFgQdn3s8JbcPI17MDmxTlOqORrke3w==
X-Gm-Gg: ASbGncuyuAq0XDLo/8MCiy/JwutocHSl0uogv+5Yuqaa1C29jKh3YtfGdpSeFtnghng
 27F8zir6rbq5GH9Pn/0UBXcggjUu1e/2T464BXoS7he7Fy0daLEct9M1yaE4iY/Xhn04cJv1JPb
 XMlKjgZM16pnDWR7SH1ubPAXtURnmU0SI1rydq/bGyRYQT6OS/G91isP1RBr1rGi161kqHC0V7p
 NCNtYCNoESGk3IVgA==
X-Google-Smtp-Source: AGHT+IGSBWjo7FAuhaBGLcv0sNmVNDKdMICdZIW2DofSNco78MKWlu0J52kqo/45l+zytP1cIYCjxsyFcIcnZFqUKOM=
X-Received: by 2002:a17:902:e54c:b0:246:50c0:aea6 with SMTP id
 d9443c01a7336-24650c0b0f5mr140596675ad.7.1756305321632; Wed, 27 Aug 2025
 07:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250827141933.626717-1-kevinyang.wang@amd.com>
In-Reply-To: <20250827141933.626717-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 10:35:09 -0400
X-Gm-Features: Ac12FXz9YSikl2XQFvxlzHFmBldeIOzj1cfNi3Y4QZI28SMQmQftihXoPuM4kXo
Message-ID: <CADnq5_NhvCga5DWh=uwa5PSqCP-3ax5Wf-ssweJhAA484OMq5g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: unified amdgpu ip block name
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Asad Kamal <asad.kamal@amd.com>
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

On Wed, Aug 27, 2025 at 10:19=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com>=
 wrote:
>
> v1:
> 1. Unified amdgpu ip block name print with format
>    "{ip_type}_v{major}_{minor}_{rev}"
>
> 2. Avoid IP block name conflicts for SMU/PSP ip block
>
> v2:
> Update IP block print format to keep legacy IP block name (Alex)
> "{ip_type}_v{major}_{minor}_{rev} ({funcs->name})"
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e117494e8054..d869226b2fa9 100644
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
> @@ -2475,8 +2502,13 @@ int amdgpu_device_ip_block_add(struct amdgpu_devic=
e *adev,
>                 break;
>         }
>
> -       dev_info(adev->dev, "detected ip block number %d <%s>\n",
> -                adev->num_ip_blocks, ip_block_version->funcs->name);
> +       dev_info(adev->dev, "detected ip block number %d <%s_v%d_%d_%d> (=
%s)\n",
> +                adev->num_ip_blocks,
> +                ip_block_name(adev, ip_block_version->type),
> +                ip_block_version->major,
> +                ip_block_version->minor,
> +                ip_block_version->rev,
> +                ip_block_version->funcs->name);
>
>         adev->ip_blocks[adev->num_ip_blocks].adev =3D adev;
>
> --
> 2.34.1
>

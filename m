Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7EFC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 14:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B8210E62C;
	Thu, 20 Mar 2025 14:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V/1tqbp5";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C685510E62C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 14:38:16 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff53b26af2so231989a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742481496; x=1743086296; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nho15U+6MmX5ZWstAn9ze7/zS49F28mUUF923x9Sioo=;
 b=V/1tqbp5XvhvhmzmUdIiEBmXodLncYkwM469H6492QVhvrR/G2qkhIfDB5SMKA6vux
 bSK7vrDnwqNflt2ykXoRQoX5eJWstzyiS60Dye+wz40VDUXTp+MA9Egk1LdhCzeoHA3H
 aWGXHs0hxETD2HADHMpSjzAtZXfdKFsdUpLO3neMW79yOZA4SFn1yF/NfNIjdj87m+xC
 MI8d4+TQPiIt2eWBh0aSodY4HkgwNqGPaAm5IDtO32l4DQjiYsft7Hi8ewR/U/GzHhKU
 Gl1jZKgLuw8IWru7oYQ9iTOTEBySZNDP0PexbFOddPkIa/S49jtKzTUlXRMBHTS/CY+U
 yvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742481496; x=1743086296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nho15U+6MmX5ZWstAn9ze7/zS49F28mUUF923x9Sioo=;
 b=Sq1mtfJpcRR+lIu9C2JpBpkoBevL8m+FUbbeGOxKEV1FFsjfpTIG7pn8SItOHEx/c3
 HHWhCeDn97xu6Qfo7g1WFMPYK08/2AK8Zf+rvw+9fu6UWCDOvJ5nWWYue2H57T6fYJKC
 bJaRh6UsedbcIQuN1KzHVsVq2+bRwXI4PkjwVLelvQPvgMIozoKKfhXezoIpmcT0t/9r
 kKmTN4eNkqeaN89+yEbx4UfAq7r7zWgv4PPs42Wn1IpSMn593kNAtwktGHUIAmfch3zV
 SdHLWl24iwvBiiji4V50fz2QAbu+WdVwQIPav5Ri9lfd2IsyF4CfNtTsIOFJ2Bz80TsE
 iblg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX70xWb0WWZl9+0ZlTetFPmCZE3ZgzKWJu/dVE+do9PwWi/dBrl8MJjzfyMkIbJDocYuACbE3fV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyI9NrtJ1Lt6PWnAwO+XXnU/SO6FaMQQ1BxvCzCnPpLsL6rpXjv
 hdAUfgJQxOHIIkz4BouBP718PqCU0h6D9oY1aWhTZtWRnpSo77bjinD8BSUnjNW6E0s7b2VUTRY
 siJ+7jKWx2M/lQ7D7Bfbc4ojygfQksg==
X-Gm-Gg: ASbGncuIQ5YSgKYXYY2P+hs7k6txE2JfzFqxp3R/Zt0+T5qIb7GrPaUD5aGrKwCac5x
 uOdm2c82ilPgPCvJTxQJhR7Jh/df252TXk0QGEyt3M6NKopE2wYtSVwqQtd2IQ0Ajx2VyB3sbLQ
 KesU3coq0/032IDJUvoXh8girRwA==
X-Google-Smtp-Source: AGHT+IG3D3trMXQTOWfVfyomd8O3sUTxXaH1+532AKdT71VnR1TqzG+hEB77j4wRZlSotV5nWl5JpcBOY+qDstfBRKA=
X-Received: by 2002:a17:90b:3841:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-301bfbd3372mr3654962a91.2.1742481496055; Thu, 20 Mar 2025
 07:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250320040936.2361475-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250320040936.2361475-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Mar 2025 10:38:03 -0400
X-Gm-Features: AQ5f1Jq-ZCExkjSaX6kQwW5SdDHuLMuXx2gvYPTm0PHenTSfQQ8dMl4tacTjoqc
Message-ID: <CADnq5_NggjZK-6iUFGkZW1-t4B6_op9wH07=o-ob+WZLJTnnPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx11: Add Cleaner Shader Support for GFX11.5
 GPUs
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Mario Sopena-Novales <mario.novales@amd.com>
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

On Thu, Mar 20, 2025 at 12:25=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Enable the cleaner shader for GFX11.5.0/11.5.1 GPUs to provide data
> isolation between GPU workloads. The cleaner shader is responsible for
> clearing the Local Data Store (LDS), Vector General Purpose Registers
> (VGPRs), and Scalar General Purpose Registers (SGPRs), which helps
> prevent data leakage and ensures accurate computation results.
>
> This update extends cleaner shader support to GFX11.5.0/11.5.1 GPUs,
> previously available for GFX11.0.3. It enhances security by clearing GPU
> memory between processes and maintains a consistent GPU state across KGD
> and KFD workloads.
>
> Cc: Mario Sopena-Novales <mario.novales@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 8261308fc1f2..e0a9b10d645c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1632,6 +1632,20 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         }
>                 }
>                 break;
> +       case IP_VERSION(11, 5, 0):
> +       case IP_VERSION(11, 5, 1):
> +               adev->gfx.cleaner_shader_ptr =3D gfx_11_0_3_cleaner_shade=
r_hex;
> +               adev->gfx.cleaner_shader_size =3D sizeof(gfx_11_0_3_clean=
er_shader_hex);
> +               if (adev->gfx.mec_fw_version >=3D 26 &&
> +                   adev->mes.fw_version[0] >=3D 114) {
> +                       adev->gfx.enable_cleaner_shader =3D true;
> +                       r =3D amdgpu_gfx_cleaner_shader_sw_init(adev, ade=
v->gfx.cleaner_shader_size);
> +                       if (r) {
> +                               adev->gfx.enable_cleaner_shader =3D false=
;
> +                               dev_err(adev->dev, "Failed to initialize =
cleaner shader\n");
> +                       }
> +               }
> +               break;
>         default:
>                 adev->gfx.enable_cleaner_shader =3D false;
>                 break;
> --
> 2.34.1
>

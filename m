Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7557C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 15:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7248E10E13D;
	Wed, 26 Mar 2025 15:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hbWk+UYP";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1300F10E6F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 15:19:26 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ff7255b8c6so1398681a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743002365; x=1743607165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+I5QzTwavmu60O35L81Gg6jDONV1cIRY2d0p9wVAvw=;
 b=hbWk+UYPg4zZxy6DjPIuCgOKSp14UEw4HvgoFJrkUTRtKwuGvQG0qrqmjFGJXVX9yX
 C+z7CgRZzEIw7wyL1tyjkdgjuOCd6xYBNpG8Sxp2kenvd3s/HhJDFRUwfYhi31BbKAat
 DJJVKf5bOI5+WIQh3lUwekVh35pb4UkvYU0u8LhrpeRGinC2Skj43BhggGxXn7s9mfRA
 cmA1e1c8yG32mVF2oGBY3Yx2cezAIHVYVxi4rZXR1kTvC9Ibb/hp4fOv73pk1N+88r5K
 LN/jc4FCWtVrhwSvGQvwWmpa7pKPEO5UL0LyxSn62PxNtxlPqJW4GHoq8LiIVf99lycJ
 vc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002365; x=1743607165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+I5QzTwavmu60O35L81Gg6jDONV1cIRY2d0p9wVAvw=;
 b=J5vo9nhTilKGSskwgPryH9JRuXKNO4orycZKIJJKpzDUIO+FgvbbK3Q3nyhXFqf0mZ
 RCfhFcuoL/I9XT//bUO8pyERqxB4IpeHzVLtXdMgNxcmiaZpfV+xXAgS1ukBMrsgcKKv
 RwkxFd5YUU9sK1k6cQLlFzeLbh+q1dv9EMa+YRThQBmaFIEKmG2Vhg0ZiEk3O6sWG/Rz
 Yjkeq6gRJA/dcPr1aiqnzComh2mXUFNWlFA2ksBd5nuLBJIbsFOWTAcbFoOdToXPMxEW
 iuyJnD0keW+THX/F+vlQvWL7NcJnLiGvbUfaO9YQCOBWQe8BVEGQhZMcoocMjPUT7Ni7
 W2Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAt2WvgC3S/V0SOvrOb6/UTnyj4Z0UiBr5jEJ5h9AfftBsgUtiYLLfQqlw1MRlpd3WzxnXMJgZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/AvU5mzTX8jR0kmzHMIOw9BWyvUv93v8hcEryp1qWgAR3xCpp
 tS1xCAQMZV94ea6zAnNHqv5vAop1vBs89TwfEA7Cg6XyoMG0aTnycoa6D7VSX68oI8+T9ekUQxN
 bGTnXZSv8r9w5oSTu/8T1GtYJMOgEFQ==
X-Gm-Gg: ASbGncvxscDiUI6vnmuy8jnZpLFMlQtvqESf90fn1uj4iMRNpBmQtEVXXbHXlQEjQbf
 /ffrnZwtCLcwMDguoEgyoCTldYkV72NLo3ucelPdD6lJnmhxD29/l94u54nw7768fBl4JGm4RAS
 T63RYntKQVxHgd6yk3LAxbYQ0jyw==
X-Google-Smtp-Source: AGHT+IF+A5795ohco+yf+ZIhzm54U92Bz50kv9W2gZcFN+ERTxI5h3qcDGsxdA1xmW0VoRVMwgXYOINfzc29vh+QMqM=
X-Received: by 2002:a17:90b:1d04:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-303a9172daemr18493a91.3.1743002365402; Wed, 26 Mar 2025
 08:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250326075344.2656188-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250326075344.2656188-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Mar 2025 11:19:13 -0400
X-Gm-Features: AQ5f1JrPt7KXQ8pIjBgG8taFOLlztMbH1_wSzE9SlE8DUJvj_sC81l3Zey3b3PY
Message-ID: <CADnq5_MrhQa1s8q=iRkMN_XmsCa_N2tihFaRqYmsDCQDVDBFJg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Add Cleaner Shader Support for
 GFX10.3.x GPUs
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

On Wed, Mar 26, 2025 at 4:02=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Enable the cleaner shader for other GFX10.3.x series of GPUs to provide
> data isolation between GPU workloads. The cleaner shader is responsible
> for clearing the Local Data Store (LDS), Vector General Purpose
> Registers (VGPRs), and Scalar General Purpose Registers (SGPRs), which
> helps prevent data leakage and ensures accurate computation results.
>
> This update extends cleaner shader support to GFX10.3.x GPUs, previously
> available for GFX10.3.0. It enhances security by clearing GPU memory
> between processes and maintains a consistent GPU state across KGD and
> KFD workloads.
>
> Cc: Mario Sopena-Novales <mario.novales@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 30 ++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 6d514efb0a6d..1010d78e4628 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4810,7 +4810,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 }
>                 break;
>         case IP_VERSION(10, 3, 0):
> +       case IP_VERSION(10, 3, 1):
>         case IP_VERSION(10, 3, 2):
> +       case IP_VERSION(10, 3, 3):
>         case IP_VERSION(10, 3, 4):
>         case IP_VERSION(10, 3, 5):
>                 adev->gfx.cleaner_shader_ptr =3D gfx_10_3_0_cleaner_shade=
r_hex;
> @@ -4826,6 +4828,34 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         }
>                 }
>                 break;
> +       case IP_VERSION(10, 3, 6):
> +               adev->gfx.cleaner_shader_ptr =3D gfx_10_3_0_cleaner_shade=
r_hex;
> +               adev->gfx.cleaner_shader_size =3D sizeof(gfx_10_3_0_clean=
er_shader_hex);
> +               if (adev->gfx.me_fw_version >=3D 14 &&
> +                   adev->gfx.pfp_fw_version >=3D 17 &&
> +                   adev->gfx.mec_fw_version >=3D 24) {
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
> +       case IP_VERSION(10, 3, 7):
> +               adev->gfx.cleaner_shader_ptr =3D gfx_10_3_0_cleaner_shade=
r_hex;
> +               adev->gfx.cleaner_shader_size =3D sizeof(gfx_10_3_0_clean=
er_shader_hex);
> +               if (adev->gfx.me_fw_version >=3D 4 &&
> +                   adev->gfx.pfp_fw_version >=3D 9 &&
> +                   adev->gfx.mec_fw_version >=3D 12) {
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

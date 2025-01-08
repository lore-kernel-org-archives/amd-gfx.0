Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65320E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 18:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E84310E0A7;
	Wed,  8 Jan 2025 18:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O0NiXnu0";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE1010E07F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 18:00:38 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-71e111248a2so1511a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2025 10:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736359178; x=1736963978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjQMC5LGQZZmvVKwj0vj+M3Xt4aWxoBIy70XTqexMiQ=;
 b=O0NiXnu0YrrMWtiUQYz9bSQ/2Ve3FNlHBy5MC6BwOJhOGZT/zR7uIED3ok/jaEKbqL
 qe0i2ylAdNWC84vwYSXaCiCbQ4WdzmPDKFHdyB+zS6AxvEvCNN4DvxpQGCFsUDdP8JoX
 JcHcM+8c+tG/B9sN0wuA+FEryOIX4x2OGutVxLf032RULKxSzcUrAHDQ3O3GwltsjRxf
 bKYAv5BmVlojNY+DY8f0CI9Van7vKMB4/SHPMwNLifC7u/xYIhtlCqUL5pzcAwBr4Jha
 sccBmqDJ8xTjZJKAYWUXuuhGNK61WhkiNu3o/kyTyvW1OYhrBfuiF8juyP+k5kF1Q71c
 BFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736359178; x=1736963978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CjQMC5LGQZZmvVKwj0vj+M3Xt4aWxoBIy70XTqexMiQ=;
 b=D0mY+U1/Q+fvtzPiJgGiu8tVRdZETheD6tXRfKx64qQiltnt8MXWawFBeWo+Soi89h
 ya8BA+KdppHp9sqwxvdEMKO6EeTon54pGksCETJQSZJlvdQOJiVAQrBLCc12k5NdTHQ/
 F2ASI7ibhktLrbsMM3DYiqMavscmZQB3WqfyTcQKxAvHdaPrluyDC+ZOHn1fGPXz2ich
 KTWBYpHKa9Uw8WR5J4I0i/CvGyAbxbzW/RR8AkFj4uXxtszrL8HwmO2h/egyjv7LwSRc
 JC8yNVg8QpDVsaPkOqaP5LfquLglhjPVyegqp6JMk+iyFqVsLQEoEpvnTwL+2eAgEEip
 bTpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWL1xoehmBQy440ois7E3xRqLEnL+2S5MYtS6i+2ZRlbp8YCwv17eIFR2ZRvMwTUU1p6+Fxd29@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqKnbARyvKQN8zHDL43DpS7gvay5cdDrgxm/wArkI3VVWQ91J2
 WVDQ7UNe4C8TSm4EjOR9gEWPwagQLZgL20WFZkQBVD9wcQeZQiuZ/VaEa5wewl3B2hJd2DI5g9P
 MF97T6qWy4Sk3j2713vvEyyWO9HjuxQ==
X-Gm-Gg: ASbGnct8kGUACgFnAB3fidXaz1e7fplJ3V+HJk9v8XddCGkHrJ8qcYBycKpwQe9uNGJ
 APqZ2ZTqK2TkeTPutyd5Xr37Lgkr2LVejyIH1bg==
X-Google-Smtp-Source: AGHT+IGagO4uiFnpL/oakOpsXeapQbBkOZctUJfF+1VztIg+pRsT2n5loYAVe2P+LD/hL5TZ7widVPeytGAu+wAG+Wk=
X-Received: by 2002:a17:90a:f945:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2f548eb3faamr1947641a91.3.1736357899327; Wed, 08 Jan 2025
 09:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20250104084047.3669928-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250104084047.3669928-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2025 12:38:07 -0500
X-Gm-Features: AbW1kvbNykHz2kFoKbqRYBDgTb2Lyh91Fr_NWytRiJelLbH9J5trVOvaZAhNdeI
Message-ID: <CADnq5_Mc5624SJKfgtg90R8CPDqfLB_rpzCa29bobuCEbbe4Dw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/gfx10: Enable cleaner shader for
 GFX10.3.2/10.3.4/10.3.5 GPUs
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Sat, Jan 4, 2025 at 3:52=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Enable the cleaner shader for GFX10.3.2/10.3.4/10.3.5 GPUs to provide
> data isolation between GPU workloads. The cleaner shader is responsible
> for clearing the Local Data Store (LDS), Vector General Purpose
> Registers (VGPRs), and Scalar General Purpose Registers (SGPRs), which
> helps prevent data leakage and ensures accurate computation results.
>
> This update extends cleaner shader support to GFX10.3.2/10.3.4/10.3.5
> GPUs, previously available for GFX10.3.0. It enhances security by
> clearing GPU memory between processes and maintains a consistent GPU
> state across KGD and KFD workloads.

Are the minimum firmware versions the same for these chips as well?
If not, we'll need to add firmware version checks for them as well.
If they are the same, then the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2: Updated commit message
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 88393c2c08e4..5ba263fe5512 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4740,6 +4740,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         }
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(10, 3, 0):
> +       case IP_VERSION(10, 3, 2):
> +       case IP_VERSION(10, 3, 4):
> +       case IP_VERSION(10, 3, 5):
>                 adev->gfx.cleaner_shader_ptr =3D gfx_10_3_0_cleaner_shade=
r_hex;
>                 adev->gfx.cleaner_shader_size =3D sizeof(gfx_10_3_0_clean=
er_shader_hex);
>                 if (adev->gfx.me_fw_version >=3D 64 &&
> --
> 2.34.1
>

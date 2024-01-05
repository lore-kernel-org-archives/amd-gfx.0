Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8080C4707B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 14:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2664C10E60C;
	Fri,  5 Jan 2024 14:03:27 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5191310E60C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 14:03:25 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2043e721daaso828811fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jan 2024 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704463404; x=1705068204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqFVbw3UvCwOX5Q0rIFwo6dKWGtTRCJdKqlheelUTCY=;
 b=X+RfXhSPXPiKfafNG5tJdB/VrXDwvecqcAmVOMnNaxrPTiHcjGegUj3pnen0QuDhWF
 vL6IaQcR5J43yoB8L86l2mWXMBcJTp/SSn/9/x5dkKL7N92G1y4zlzuzeqiVSZu9j1nq
 2Rh1sQobpqtC6pagPKHIpvXRh39znjmtTnE3t7OM/3ZwbKMCVn3hXbAMEB+mEK6+S1Ed
 KZkOo+ZGj8b8A1NjTU7OsxVnI+pNDzdnSQpCyAT9Erzt9KEiyv8Lb9L4HnKc5x3frMn/
 w3Sv35GVtJGPxqFnJvj0X5gNDUbB5lCuynJgJF3mY/66zZkG+Y+G05XZFfAUDRYd0xyE
 P5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704463404; x=1705068204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqFVbw3UvCwOX5Q0rIFwo6dKWGtTRCJdKqlheelUTCY=;
 b=uHPxTObxyzkrhBhbot2ZZIEpRp0E+JnCueOaKIj47h+zYX1rc49AlCfJMidEfzDy9S
 QpW/nFHNaJULQLFtx2jh8bipoOB6A2zQZ8mD2aXNd+gxScAE+72ninWl3VMXy18NW42i
 8E74tDQ8wh34WyyjWo8Ff38EJVBv9yhIPPqIcQ9BIPaDEQoEnhIqWDgv+FcEcpAwtmI5
 GrYSrLyma8vBtWM11vb+Rq7NKqfcqfHKRTOJn5+sWhih2D8xReWAgP7taBZm2F2nTSvG
 wT/HNFfU9HzaQMQ9y3Lm9nzFLw4U8L2HnJbzBI3EJdBMHtVh/xsK7U4kTELyp1kCUYh2
 NVAA==
X-Gm-Message-State: AOJu0YwHlJ//lN1Pi3zRShGm2e3bboOwj4iPB2mYZdTKEbH+lEzOjuU+
 W0wC+vdzm10Sryw1jgMfcbE+RMLd/KOHTZUKKrI=
X-Google-Smtp-Source: AGHT+IEEJweQmwKEQ9LcgarSmuLFykytG5OKkjDKcmg+Pw1Viwu3F+IGU+KpjCdWhuWn41IKaL6MFwrsOfhVzSsh4L8=
X-Received: by 2002:a05:6870:d8e:b0:204:4a24:3a69 with SMTP id
 mj14-20020a0568700d8e00b002044a243a69mr2218717oab.69.1704463404486; Fri, 05
 Jan 2024 06:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20231213212558.1965046-1-alexander.deucher@amd.com>
 <20231213212558.1965046-2-alexander.deucher@amd.com>
In-Reply-To: <20231213212558.1965046-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jan 2024 09:03:13 -0500
Message-ID: <CADnq5_MxCTbLR9uFjitu_O8Y1UwnPcvJ5T6P5BgFbUL+JUtAkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/atom: make amdgpu_atomfirmware_allocate_fb
 parsing consistent
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?

Alex

On Thu, Dec 14, 2023 at 7:55=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> For 2.1, ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION is SR-IOV only.
> For 2.2, return usage_bytes properly for the non-SR-IOV case.
>
> Fixes: 4864f2ee9ee2 ("drm/amdgpu: add vram reservation based on vram_usag=
ebyfirmware_v2_2")
> Link: https://bugzilla.opensuse.org/show_bug.cgi?id=3D1215802
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 55 ++++++++++---------
>  1 file changed, 30 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index d8393e3f2778..b1c1fafa2d8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -115,18 +115,21 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(str=
uct amdgpu_device *adev,
>                           fw_size,
>                           drv_size);
>
> -       if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) =3D=3D
> -               (u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> -               ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
> -               /* Firmware request VRAM reservation for SR-IOV */
> -               adev->mman.fw_vram_usage_start_offset =3D (start_addr &
> -                       (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -               adev->mman.fw_vram_usage_size =3D fw_size << 10;
> -               /* Use the default scratch size */
> -               *usage_bytes =3D 0;
> +       if (amdgpu_sriov_vf(adev)) {
> +               if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) =3D=3D
> +                   (u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> +                         ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
> +                       /* Firmware request VRAM reservation for SR-IOV *=
/
> +                       adev->mman.fw_vram_usage_start_offset =3D (start_=
addr &
> +                                                                (~ATOM_V=
RAM_OPERATION_FLAGS_MASK)) << 10;
> +                       adev->mman.fw_vram_usage_size =3D fw_size << 10;
> +                       /* Use the default scratch size */
> +                       *usage_bytes =3D 0;
> +               }
>         } else {
>                 *usage_bytes =3D drv_size << 10;
>         }
> +
>         return 0;
>  }
>
> @@ -147,25 +150,27 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(str=
uct amdgpu_device *adev,
>                           drv_start_addr,
>                           drv_size);
>
> -       if (amdgpu_sriov_vf(adev) &&
> -           ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
> -               ATOM_VRAM_OPERATION_FLAGS_SHIFT)) =3D=3D 0)) {
> -               /* Firmware request VRAM reservation for SR-IOV */
> -               adev->mman.fw_vram_usage_start_offset =3D (fw_start_addr =
&
> -                       (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -               adev->mman.fw_vram_usage_size =3D fw_size << 10;
> -       }
> +       if (amdgpu_sriov_vf(adev)) {
> +               if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATIO=
N <<
> +                                     ATOM_VRAM_OPERATION_FLAGS_SHIFT)) =
=3D=3D 0) {
> +                       /* Firmware request VRAM reservation for SR-IOV *=
/
> +                       adev->mman.fw_vram_usage_start_offset =3D (fw_sta=
rt_addr &
> +                                                                (~ATOM_V=
RAM_OPERATION_FLAGS_MASK)) << 10;
> +                       adev->mman.fw_vram_usage_size =3D fw_size << 10;
> +               }
>
> -       if (amdgpu_sriov_vf(adev) &&
> -           ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
> -               ATOM_VRAM_OPERATION_FLAGS_SHIFT)) =3D=3D 0)) {
> -               /* driver request VRAM reservation for SR-IOV */
> -               adev->mman.drv_vram_usage_start_offset =3D (drv_start_add=
r &
> -                       (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -               adev->mman.drv_vram_usage_size =3D drv_size << 10;
> +               if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATI=
ON <<
> +                                      ATOM_VRAM_OPERATION_FLAGS_SHIFT)) =
=3D=3D 0) {
> +                       /* driver request VRAM reservation for SR-IOV */
> +                       adev->mman.drv_vram_usage_start_offset =3D (drv_s=
tart_addr &
> +                                                                 (~ATOM_=
VRAM_OPERATION_FLAGS_MASK)) << 10;
> +                       adev->mman.drv_vram_usage_size =3D drv_size << 10=
;
> +               }
> +               *usage_bytes =3D 0;
> +       } else {
> +               *usage_bytes =3D drv_size << 10;
>         }
>
> -       *usage_bytes =3D 0;
>         return 0;
>  }
>
> --
> 2.42.0
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11DFC369A6
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 14:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D1910E29A;
	Thu, 10 Apr 2025 14:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cc3b9rq5";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511E310E29A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 14:19:56 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-af5f28ecbcaso144208a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744294795; x=1744899595; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdsWp165z7lRxVd/RBacHtk1A6svmKMciFrMICaaBto=;
 b=Cc3b9rq5Nn6GOoEomfbjVwLUYe/O00bsXt6d5wm4f/pjCRthI1UCjvSjkF+AuDkYMN
 lJFga3cws9V4pFOOgEPc0HnEIxfn/cuG0CWk+xbc6cJNpHv4pm7kqkshQbVfGRqPNI4I
 3r8hecpc/bKwBVh3toRjAf3sNIPaYvcizwuo8ySOZcLALHTQANqKaojFU6C2lXJZazWc
 5kQ3t59v4zIQEmazI4vw2CkLanwHpoDofEFpanFrEKoajVuhY174blHRTl0jDD241/Jb
 ons/UvSTPSENQclvWtsLlij31FIynX0GwFFi4fGvTDZiyFSs6EdlXPxSYaNLqMj8NqV6
 2M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744294795; x=1744899595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdsWp165z7lRxVd/RBacHtk1A6svmKMciFrMICaaBto=;
 b=KBOLmWT8cVmEoiH/gcL4A4oiTwoyG0uuRc/HQQtDkSn482PyZRGcYzgRgWcEUM9ory
 18Ik0fe5Ie+Wo4g2H1Ey74juHLJ8VduX5rUbJN9BolL6C/QloTTIezJdMZhVPKnj98rD
 ZEp/lbfu6FITzgdmIro66ZdFL0kC3FqXZxkiE8SINCY2ILHcPqJ83N5x32sBrpCUH65G
 wwvIxzgkuEu9LMA1UTekjyKXZDVW0SsxvhHADUDhQ7idEpy0UqwIpoanPwuyI8jCrYDz
 h8UBOHIb22RtGIkZSsFFZyqJ3EpX24Dyi2JgZ3O8Hck69d4AKUd9pC/Ag3ItVJlh+Ggh
 m22w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVilQaQVGfKPmINOSn//vHuq9fMSalFabPl96GfViGX5474qgOVX6y2M3pl6BY6GrJTNCvt/RBF@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzl84YmU/9EYrCxWQ2RthqCrn8JjDhPzGWw52NzoMmUbaG7yLW2
 F01kTi3GNwkDFA/Y/YjBwbABYj8hVn8Gyh38pUhkkY7eJCJHtNG6MxHqZJUuDvDB4XrSvqu9l3s
 h0PfcNy6qlYFDXzXpneRSVUatdNV6Fg==
X-Gm-Gg: ASbGncvQErBkUXB7CAHNe18cDbaYI9qeHUN8B32JFbHys82hoKJ6d9uN44s5PSM2lDw
 GNhB+J6Moq3YqBNTCosxOjlsyNpmmZHMr75kjfsPNZPoYLxLOv6N2M4om646g7Ju7IVXMotik8o
 fHRPQHmZ9PANzlokejwh/stQ==
X-Google-Smtp-Source: AGHT+IFTrxYU+fC7n3T532ZFvUr50bN6uX/W9Qv4t0thaWs5rgVjj5KAOS+vHwB6saKUo7UJ5uilNh6x9uMEeJFHcJc=
X-Received: by 2002:a17:90b:3a87:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-306dbb66b3fmr3762388a91.2.1744294795557; Thu, 10 Apr 2025
 07:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250410141014.3295627-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250410141014.3295627-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Apr 2025 10:19:42 -0400
X-Gm-Features: ATxdqUEsuQW1MKBdQUydi48byg65s89lcYIbSVI5WXKFII42oOO5sep5AluAj0k
Message-ID: <CADnq5_MbtEkiK06UmswOOY==kBnhazhAsevdB4MYzzV4UDFxYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx11: Add Cleaner Shader Support for
 GFX11.5.2/11.5.3 GPUs
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

On Thu, Apr 10, 2025 at 10:18=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Enable the cleaner shader for additional GFX11.5.2/11.5.3 series GPUs to
> ensure data isolation among GPU tasks. The cleaner shader is tasked with
> clearing the Local Data Store (LDS), Vector General Purpose Registers
> (VGPRs), and Scalar General Purpose Registers (SGPRs), which helps avoid
> data leakage and guarantees the accuracy of computational results.
>
> This update extends cleaner shader support to GFX11.5.2/11.5.3 GPUs,
> previously available for GFX11.0.3. It enhances security by clearing GPU
> memory between processes and maintains a consistent GPU state across KGD
> and KFD workloads.
>
> Cc: Mario Sopena-Novales <mario.novales@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 91d29f482c3c..06ad10d06ca1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1688,6 +1688,34 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         }
>                 }
>                 break;
> +       case IP_VERSION(11, 5, 2):
> +               adev->gfx.cleaner_shader_ptr =3D gfx_11_0_3_cleaner_shade=
r_hex;
> +               adev->gfx.cleaner_shader_size =3D sizeof(gfx_11_0_3_clean=
er_shader_hex);
> +               if (adev->gfx.me_fw_version  >=3D 12 &&
> +                   adev->gfx.pfp_fw_version >=3D 15 &&
> +                   adev->gfx.mec_fw_version >=3D 15) {
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
> +       case IP_VERSION(11, 5, 3):
> +               adev->gfx.cleaner_shader_ptr =3D gfx_11_0_3_cleaner_shade=
r_hex;
> +               adev->gfx.cleaner_shader_size =3D sizeof(gfx_11_0_3_clean=
er_shader_hex);
> +               if (adev->gfx.me_fw_version  >=3D 7 &&
> +                   adev->gfx.pfp_fw_version >=3D 8 &&
> +                   adev->gfx.mec_fw_version >=3D 8) {
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

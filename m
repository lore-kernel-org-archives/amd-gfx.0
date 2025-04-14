Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6948C369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 15:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5597010E60E;
	Mon, 14 Apr 2025 15:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hrrEJw2Z";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA0AE10E60E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 15:29:42 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b078bb16607so90068a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744644582; x=1745249382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=it4/os1qCZoV4+EhIz0jCc3CEK9X4DjJLPYHGB2ZI7g=;
 b=hrrEJw2ZPn7j8y8C6kosOQLSKB5AngOhir88XyGT/PmvzInTzko1LOkWyBNfwOTSIO
 ajvzxr+WX2qnSo1A1OBUgHg8yEXTC3v9OxMmhBE8a8zjUsRgINXGNhQnZjFA0XZZ+IoW
 z2J9MLrZP3bU2d9dIgyOh3F9mgBtTKOSltObrj3X67Q0NFat6O/e3D9YxCz5NV3GFp3k
 PJo1HNGfJQKsaRp9Vn3HmRk5VkBTsTg6IxNdS+UZrq9P8EAteCPlkpymX+2GoTZu50nQ
 NB2YiWqym/N0OMvOikChs4XJpqelrvNh3yTTUwRUny39VA85WSUXTUX5gzaFpiZAlRr/
 eKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644582; x=1745249382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=it4/os1qCZoV4+EhIz0jCc3CEK9X4DjJLPYHGB2ZI7g=;
 b=If+2E0b085orzuJ7Dseu0BB03tyKqKrghODmt/6Kt01aCUYNPrf4QPWQjxL+XxHP5z
 ssAsGMdLlmP90k+bajNzVDXLZiX8th7mr1aM90Tcp2qcLZ+RCc7AhMdnZNeIEUDMCwMK
 qZtvU+wCfhWPxHvVE4JA8fwr0rVTQ6ph/nWDB0OJIySceSyBOQTg7+i+iIy54K/K8eWz
 bMm1nSTb8yw9S64U4GdpMIUOZJCPE23NMpNOcKCUyxeyPl/rA1YPr7fSj+lIkxCE3IPS
 in9ctabab+FD+AsYcIoSEHpx9UV3WxIcBhbGTRTzq/P1w/WuPMj27AUYBOSrNAk2ODJr
 Jmmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK5Bh1Nf0K4pYa0hmMRS4T+Og/eGnuEkV9USO/y3aR9FZaOx8dZZPdfthWDQGM4otcRMpREF4T@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhXeEQYmVThNT8MgmTWwQbIiO+yb30Zn+PXs/aPal5r6nKynHm
 bh3+Zuw/F/7EpTEGVmhtc4Yt8Y2ia0Xh4EYcI2C3+RE5ehKmVY4KVTEDZMtIiHnfn2eaa2HvamF
 QujwDXBNxv8xcUg1l3sKwAGxmjQFImQ==
X-Gm-Gg: ASbGncu3rsc/ZjxfCIJfwPOAF3IHc+lnYjuy13CkR4f0lroZZUfEBSReay3j/96RO/h
 8/quLyEEk6f+nOYJLFV54274ZVt80oE9hJ1OzRYXlPftStBlPlRk75MvNXZ29F8o57ZO97KAdsd
 2YtSuR4cPW6kvmdt86mpP+nw==
X-Google-Smtp-Source: AGHT+IHDVQQhYcOBAAabRema4vxVlpAXoiws80ipqANva2ykSALtR1u7epXewhPp/zprT7rc1r7NGM0bN1KkE0US9Sw=
X-Received: by 2002:a17:90b:4b01:b0:2ff:6bcf:5411 with SMTP id
 98e67ed59e1d1-30823628775mr9002816a91.1.1744644581506; Mon, 14 Apr 2025
 08:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
 <4d804b27-c89c-4503-8d36-2e9a35a483e1@amd.com>
In-Reply-To: <4d804b27-c89c-4503-8d36-2e9a35a483e1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Apr 2025 11:29:29 -0400
X-Gm-Features: ATxdqUGm6_J6ry2S1kDBbuj8XJcMBj4WSbm24kLKJ0pFOBhB7jbn6tmIidgJGoI
Message-ID: <CADnq5_N3f1PvDMXsEq9M3ZG1Zwahb6PKCUd3-mk455=w97wKzg@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu/gfx11: properly reference EOP interrupts
 for userqs
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Apr 14, 2025 at 5:44=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
> This is how i see the future of this code and we can do based on it now i=
tself.
> disable_kq =3D 0, Use kernel queues.
> disable_kq =3D 1, Use User queues.

disable_kq =3D 0 means allow kernel queues and user queues.  disable_kq
=3D1 means disable kernel queues.  I think we'd want to allow both at
least on current chips.  I think if we want a general knob for kernel
and user queues, we should do something like:
userq:
-1 auto (whatever we want the default to be per IP)
0 disable user queues (kernel queues only where supported)
1 enable user queues (user queues and kernel queues)
2 enable user queues only (disable kernel queues)

>
> In case of kernel queues we should not be even calling gfx_v11_0_set_user=
q_eop_interrupts at all. Instead its better if we add a this check "if (ade=
v->userq_funcs[AMDGPU_HW_IP_GFX])" before calling the gfx_v11_0_set_userq_e=
op_interrupts. I am assuming there wont be any mixed use of kernel|user que=
ues together. Let me know if you think otherwise. Regards Sunil Khatri

We should only be calling it if user queues are enabled.  I think
there will definitely be mixed user and kernel queues on current
hardware as we ramp up on user queues.

Alex

>
> On 4/13/2025 9:36 PM, Alex Deucher wrote:
>
> Regardless of whether we disable kernel queues, we need
> to take an extra reference to the pipe interrupts for
> user queues to make sure they stay enabled in case we
> disable them for kernel queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 7274334ecd6fa..40d3c05326c02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>  static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev=
,
>        bool enable)
>  {
> - if (adev->gfx.disable_kq) {
> - unsigned int irq_type;
> - int m, p, r;
> + unsigned int irq_type;
> + int m, p, r;
>
> + if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
>   for (m =3D 0; m < adev->gfx.me.num_me; m++) {
>   for (p =3D 0; p < adev->gfx.me.num_pipe_per_me; p++) {
>   irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> @@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struc=
t amdgpu_device *adev,
>   return r;
>   }
>   }
> + }
>
> + if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
>   for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
>   for (p =3D 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
>   irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> @@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struc=
t amdgpu_device *adev,
>   }
>   }
>   }
> +
>   return 0;
>  }
>

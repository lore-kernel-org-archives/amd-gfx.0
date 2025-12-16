Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752ADD609C2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 16:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0858010E75A;
	Tue, 16 Dec 2025 16:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eNibU5K7";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504DE10E718
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:30:26 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7f6bc8a4787so275538b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 08:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765902626; x=1766507426; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foqN7it9WHkxYZc5wNmZZCqDK03qf2k0OMwiDUUsdS0=;
 b=eNibU5K72+uMwPnFoSAcGciulYxJ2PKTp9bTBJLXb7eFEcJNDyXqFKjsjlXIIx4IEL
 xCJmEutoFPbslMM38GnStsQzlcC2hQtqIasdrGxAGPZ9OqJcBR1MCj0LDewUMBGGH3RU
 LxI7zvatStL7cR/mL1UVzOgwM/cJd2hhhYYUZIEncnr8DpE2K/KtcNbUaWItYYWuXZof
 96fnD4kjM+HgDKU6euk69LgJq5ipVjXtB0ekfasB1BBexm9p99sgRLOXym+lzTh3ABY4
 JED4PHdPLsSX//3mzXMkyKYYADsfRNFqKw2rHsqwjl1ak+eyVu2kOcQkMPh944EmKcRy
 29wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765902626; x=1766507426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=foqN7it9WHkxYZc5wNmZZCqDK03qf2k0OMwiDUUsdS0=;
 b=mjonSQy1hOzSaqtRUdj3w0ZOq4cWQi/9dJUk82DposAU0AzVlf57T4P9ZVOImXz0tU
 gIYarA3TpVCnVPGeThCebNd0tm1N7aSlY1MWBKzOU7RIox8r2inEQqidZ0hbRJb+4UVm
 NJqYNcCvphw1W4hY2f+nOCjJFGAYXmeJvfg6dDXOzkIoeXwyEm3VlcZQ9Z96LlJicplT
 1sDMesZrlrmjwhtaO2zGcSbtB2bK0Shf2YvDDebicyfu/UnB22SVsqzUrGUxq4djjrTa
 lzPgr5jFpig66CQqRsotRKPY1x3U+bRAuVMEfCdn9Xd9DN4K5YOtEK1aHL/WTnRn06JL
 cw1g==
X-Gm-Message-State: AOJu0Ywhbp0o0MgM7IIGotktiRjGDZiO11pwHCPbUbUpeurn8UKds+as
 Lfv4apnTTLzukRz7+5IIRPEENTb7NvqQy0rPGl+rl/BEK24Hr6shMwYNre4nYHg2QXsKHMqkl9k
 FWEu+13jZy/tTAECt15rlgALvZYFE4g0=
X-Gm-Gg: AY/fxX4ZYgoKa9Rz/+Y7z3t4dzrcjEuNKq/vcHe34msmKrAzibXbzN35KW085ga5NmZ
 doEPI3+bXR0ZHpnUbo2L8+luNBizFQu0KfkDoMG/8iqoLMKa5+Zz1PXJgUdm5EkBiqu1SgUbUSQ
 p0+Gpqd+glxIav17osOV9VJ8ro1RQ3xJbWNDwy42YisDK/AsxpXBQphVMnRu0iTlfu6OFY/mxse
 B6/Yj6gTnenPEJE1rIcPjpJoeejRC1BFvGzsnfaxejwiGDwxSgp0bhuDsy5B6Lo8he93ifa
X-Google-Smtp-Source: AGHT+IH7S/QDuCIR0SoS4X5YbvtR+v9Y/k9Y/CZFP86ME4X0NpkFQzk/XzFOhdYUWpQZet/fPjuz1jBg20CyFZukj5s=
X-Received: by 2002:a05:7022:248a:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-11f34c07337mr6440302c88.3.1765902625715; Tue, 16 Dec 2025
 08:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-10-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-10-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 11:30:14 -0500
X-Gm-Features: AQt7F2rVQAv-_beHigzfCtq2nmNQVZ-s6gsBHvUUmuNHLCxmog7hqOlD4aVUGEM
Message-ID: <CADnq5_MSYtLWFZXwhAkZ=X=WkjkserJEfF7DCgF8MsyDT3Q1sg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/10] drm/amdgpu: Add ioctl support for cwsr params
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Wed, Dec 3, 2025 at 8:05=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add cwsr parameters to userqueue ioctl. User should pass the GPU virtual
> address for save/restore buffer, and size allocated. They are supported
> only for user compute queues.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++----
>  include/uapi/drm/amdgpu_drm.h              | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 0ac87618a86a..8865a266d25a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -322,16 +322,21 @@ static int mes_userq_mqd_create(struct amdgpu_userm=
ode_queue *queue,
>
>                 if (amdgpu_cwsr_is_enabled(adev)) {
>                         cwsr_params.ctx_save_area_address =3D
> -                               userq_props->ctx_save_area_addr;
> -                       cwsr_params.cwsr_sz =3D userq_props->ctx_save_are=
a_size;
> -                       cwsr_params.ctl_stack_sz =3D userq_props->ctl_sta=
ck_size;
> -
> +                               compute_mqd->ctx_save_area_addr;
> +                       cwsr_params.cwsr_sz =3D compute_mqd->ctx_save_are=
a_size;
> +                       cwsr_params.ctl_stack_sz =3D compute_mqd->ctl_sta=
ck_size;
>                         r =3D amdgpu_userq_input_cwsr_params_validate(
>                                 queue, &cwsr_params);
>                         if (r) {
>                                 kfree(compute_mqd);
>                                 goto free_mqd;
>                         }
> +                       userq_props->ctx_save_area_addr =3D
> +                               compute_mqd->ctx_save_area_addr;
> +                       userq_props->ctx_save_area_size =3D
> +                               compute_mqd->ctx_save_area_size;
> +                       userq_props->ctl_stack_size =3D
> +                               compute_mqd->ctl_stack_size;
>                 }
>
>                 kfree(compute_mqd);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 2bb9daafb560..1a27e218d4ea 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -464,6 +464,22 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
>          * to get the size.
>          */
>         __u64   eop_va;
> +       /**
> +        * @ctx_save_area_addr: Virtual address of the GPU memory for sav=
e/restore buffer.
> +        * This must be a from a separate GPU object, and use AMDGPU_INFO=
 IOCTL

"be from"

Does it actually need to be a separate buffer?  May also want a
comment that this address covers both the ctx save area and the ctl
stack.

> +        * to get the size.
> +        */
> +       __u64 ctx_save_area_addr;

ctx_save_area_va for consistently.


> +       /**
> +        * @ctx_save_area_size:  Total size allocated for save/restore bu=
ffer.
> +        * Use AMDGPU_INFO IOCTL to get the size.
> +        */
> +       __u32 ctx_save_area_size;
> +       /**
> +        * @ctl_stack_size: Size of control stack region in the save/rest=
ore buffer.
> +        * Use AMDGPU_INFO IOCTL to get the size.
> +        */

Specify that these are in bytes.

Alex

> +       __u32 ctl_stack_size;
>  };
>
>  /* userq signal/wait ioctl */
> --
> 2.49.0
>

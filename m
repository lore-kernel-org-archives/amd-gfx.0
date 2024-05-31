Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C387C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 13:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96EE010E179;
	Fri, 31 May 2024 13:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NA5iwfFv";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7650010E179
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 13:51:48 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-1f4a52b9413so17121385ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717163508; x=1717768308; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxCiFJnFHZ3smgKyqZ0O3pNrkuNx41KW3yjuZtgcyVM=;
 b=NA5iwfFvvvKZoJRhpR1xBC90IKDK8TJUjm7RX5TreLJ6vYPi3WuY9skwQYm00I/MVH
 gQvpCuj/n2RzhNdLnxJTQT6jtz8FUWuAX+m5zIWHYiuF7eMCZcrsXa5MVkvWzqqny8zt
 W+pxRIypshRet/kc1DhsUcOZ/MBgydSN6OG/MSzstUcPyMwrppJrxw9iHyv82nWe6E+a
 NOoHbdnlEI+Ibhr8ACFwbvrbchvROOHziLOi3o1ERIy3BR1gInPrd7pdisYpOumYcNGm
 rDfCl4/2j4+1svra7EfKbOIwJL3KjcnI4VsM6lDSLt4WfWtjegaU/+lWuSwnhkcjk1p3
 x6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717163508; x=1717768308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxCiFJnFHZ3smgKyqZ0O3pNrkuNx41KW3yjuZtgcyVM=;
 b=OAMFQ6ICc3sm7xme9Qhmk0/jO2CDgSIDK8FkmUt9+lx8SGoON+YjyChH7jC8a5qEYk
 ElH0C618nNd52vK/Kh/FUrWhUA8OArNDZFKPoa/qwuu2yspATrKLvf3EAxx3Fg5QjYZI
 BrfIq6xzfOfaML1RqWVlSivHFvXfNa/SS3y5ZD52uPHapQ71h04uIK/9vhol1958jrQE
 j+YDFGkJmegReAFHOKEptV8tpBpdp+ctKGDxyjUFpMKUSzU8I1JNWW9i8S2YNvDqdIq/
 vxcr6Gfv25iigYvrpOjZhGu46+mL+rsyE8iD3yrXu6MiW7vxZhHkILOl0XxHjdHYnern
 Y88g==
X-Gm-Message-State: AOJu0YxqKAhpCnCTQvQeFAvYO7Mrobxe01LURRSx1lIGodWdLDpqqgLy
 ubq4TjfjiepYyzh7UROMGpB9lYjod/WAQTKLQAd/3e0EOqv/vpWToZH0UdJwabwqlDGoaHwiAcd
 KrxdTVbpVxlb6q95owh+Y+aqTtUn/Hw==
X-Google-Smtp-Source: AGHT+IHGqlicKN4uL4btk9Ptn3u0SA/UOMUFbDIoFb/sFxteFZ3gZI4Uzjh0bZOz0Dz2cvuAge+4DzQg/hzC/6FdOF8=
X-Received: by 2002:a17:903:22c1:b0:1f6:1778:7f1b with SMTP id
 d9443c01a7336-1f636fd9d3dmr19219965ad.1.1717163507727; Fri, 31 May 2024
 06:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240531102447.168073-1-lincao12@amd.com>
In-Reply-To: <20240531102447.168073-1-lincao12@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 May 2024 09:51:36 -0400
Message-ID: <CADnq5_PUROn+em6N7hn=HC2YMf3h8X8HPaRCBx3fXXrVQX8UfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix failure mapping legacy queue when FLR
To: "Lin.Cao" <lincao12@amd.com>
Cc: amd-gfx@lists.freedesktop.org, jingwen.chen2@amd.com, horace.chen@amd.com, 
 jack.xiao@amd.com
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

On Fri, May 31, 2024 at 6:32=E2=80=AFAM Lin.Cao <lincao12@amd.com> wrote:
>
> Flag "mes.ring.shced.ready" will be set as true after mes hw init and set
> as false when mes hw fini to avoid duplicate initialization. But hw fini
> will not be called when function level reset, which will cause mes hw
> init be skipped during FLR, which will leads to mapping legacy queue
> fail. Set this flag as false when post reset will fix this issue.
>
> Signed-off-by: Lin.Cao <lincao12@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index a72683f83390..b56d243c53ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -822,6 +822,8 @@ void amdgpu_virt_post_reset(struct amdgpu_device *ade=
v)
>                  */
>                 adev->gfx.is_poweron =3D false;
>         }
> +
> +       adev->mes.ring.sched.ready =3D false;
>  }
>
>  bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t=
 ucode_id)
> --
> 2.25.1
>

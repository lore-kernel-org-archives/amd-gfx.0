Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081FEE9E311
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 15:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943D010E620;
	Wed, 11 Feb 2026 15:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YzvUyh+E";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AEF410E0EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 15:43:33 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2ba76e80509so231361eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 07:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770824612; cv=none;
 d=google.com; s=arc-20240605;
 b=Sn0Fx6EIBMJaKwGHh72g7c+A2VyXnPfVcMSLqOy/dhrU3QExc0TVE0N/N2VxpuVvVQ
 kfl2FNgbfawKwmen7aBPStA1w/5ORK694mOW0ATyYWUVRFWJOMqQOI4akAomXbqAUGsB
 xMuw4bwEGXILbl2tIBH4czUxSSfP5A/JABuegmczPFQcjI/PfbByekyeoxWBd0NLYwbI
 cR+ZMLB46SC5IAo6M+jBgeXr/hJdhKtKdAvE3ApdDwPbJF2l3vFv8OFIE1YUDN45I2MM
 3UAUa280NnH0PYoi4t1Y1e4PjgpmZ+2H06f2TvGCD/VrHhWusrfPfGf/OJXI8z69chjT
 O1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3YfL/taw8FIILCU1q64IJOSrsf5MoExy0tmWuvSt7uw=;
 fh=Kdtp7Fl9UWjGovUCqtwrSsp93hLyXOAmjIeeifAsv9s=;
 b=I/4a2jfl7DAyydzjDjNNY5HQsWlCFvaxDJZzDHye+niCGr5GItJJwKypb/6oxdVNez
 oxmt49gS3iGBZz84+i1lOsSM5UkfRJRircDDR0KxpXKEZf3VcwDgfPledQWmJacoxopV
 o3+M1nKdfwHEoTfKj82HlhFeKIqdTRfMqfgwyGaZttIzw9vfEs4kuLNIWtC9LBTFbEOI
 bmObDEumk8EJONFapX0ASbbwYrVIzX3hylNCjTMMyEgyajeGB/BH9ULpfz7czv2Wf/Ai
 V92m9FwwbDOxMTDBXV7IkWJt4H2r54toSbqHCPpTIPVI7XzCBkQ+GKGSj81dZqdv5Hni
 aT3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770824612; x=1771429412; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YfL/taw8FIILCU1q64IJOSrsf5MoExy0tmWuvSt7uw=;
 b=YzvUyh+EeTzaBM765G/BO+l02PQ7yzf9yH2Ws8wcesTAi5OZxk4CIGoe9clYqr8qwW
 jIvWeX6Hmmc+d2h66pvuhNHhzjT4cVDtSv359spBghItw5VSmABtr4DIP1xdnqFWk2BA
 uXMqvFOajaf+Puv0P8MUdkxZfwGt3vKc/jZuhu5akSApmhq0LO2htuQaImeYPsMb1bcU
 Y13ZUWbFafV/Riqmpt+bcPmNBWkAwgsXZBAo8UDPAf4627PSmn2pkKOyqIAqnFYPS2Vm
 TbX2ttJYXdXO9xij7Lx5+Gymjz2T+coSlzNa9OboNnBspjdARmLVUMjXGBxWxilibbnv
 PyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770824612; x=1771429412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3YfL/taw8FIILCU1q64IJOSrsf5MoExy0tmWuvSt7uw=;
 b=Smus25g0UWedcJYFDvYX+9KPZniF9ghf7cO2E7oa0aSM0p3TWmP8FA0fT72IbKSx8A
 Pz88xXEfJaVyJ0bvEOfHsOIzNx+2oGJm5W8XrKpUL5vkdbO9aEM4oGYUmHSAM2WTL/Sh
 xZGFXAdh9ejXR7aAwfZ2Hrc6Kviebgasiq3W7O03ivwUpc7mECBGRdxTtfrDAe08vAcC
 jSNRVpPxIG2XOb+XuTmj1Ktt0XWSnWG7LlYorUGY5YWe0aCsn2o5dI6q62g4iH4ikkUt
 K6wa8pZqlIBId5u3dre5PRGaHp9oRUtpOuMH/XbX3k8YvweiJmM7tx+lCjqdNbNHKa28
 bV2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkugWdIDVBMZP26EcUB+7+2CaGMuIVrb/DHRqtZir7/GCd622I8j1hkR7X7a1hnd6JqqgEco7y@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzk2DN4ZJEZ/BFHNwL6n/fNnfnI3H3pz8qjv/D4AvWZV/k8RNmb
 z9wA8UD/suSRKtyL232OHmDZHPJWSVKqwfj5PPNA7qVad6S5oQpYj57vnGaTUPRMZCrGVp1WwXC
 zcidhYHRKSmYd8ANOmkWyPqoex5LRvx8=
X-Gm-Gg: AZuq6aId6UXH4ku0OlTP6tv3M0de1TN2Je0o2oC40ql2INLFzSgrUKpDZQjFxdJesNk
 qoNmS6FFWXXntEvD5wNWJaVu2t9ZNU8tl9vECWjvjHv+lT/wihnthkJDt8Om19wqa/5NdX+u1Ib
 dE/iALBQvyexSoalMuXay34dugZk4INWYe8d/waYpW1GGtvOTH3kcw68XGaIa3tA8PafhNkc5Mp
 OiQLK/XHj7PvPt+INuy8YVKrOncmLF70Dqz5hBYlOW6a7uZfWDhP25tQmHInviIXr2ABPQeF9rV
 cUOF4cjtLfNwDaL4i2o=
X-Received: by 2002:a05:7300:fd15:b0:2b0:4f9a:724b with SMTP id
 5a478bee46e88-2ba9e17ca9emr453439eec.6.1770824612356; Wed, 11 Feb 2026
 07:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20260211123640.14782-1-christian.koenig@amd.com>
In-Reply-To: <20260211123640.14782-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Feb 2026 10:43:21 -0500
X-Gm-Features: AZwV_Qh4pSXyCvp2QM_6gRRKgDGHCy1tMkOjOmQUjc5ImKjTNl0khimSSOZM6Go
Message-ID: <CADnq5_NRoj20iG1++oCyKjDGd6dn4TVxAz1nctvRuW13EZJ3iA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix 4-level paging if GMC supports 57-bit VA
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
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

On Wed, Feb 11, 2026 at 8:32=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> It turned that using 4 level page tables on GMC generations which support
> 57bit VAs actually doesn't work at all.
>
> Background is that the GMC actually can't switch between 4 and 5 levels,
> but rather just uses a subset of address space when less than 5 levels ar=
e
> selected.
>
> Philip already removed the automatically switch to 4levels, now fix it as
> well should it be enabled by module parameters.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index e8e8bfa098c3..3b9ca5667de4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -33,9 +33,9 @@
>  #include "amdgpu_ras.h"
>
>  /* VA hole for 48bit and 57bit addresses */
> -#define AMDGPU_GMC_HOLE_START  (adev->vm_manager.root_level =3D=3D AMDGP=
U_VM_PDB3 ?\
> +#define AMDGPU_GMC_HOLE_START  (adev->vm_manager.max_level =3D=3D 5 ?\
>                                 0x0100000000000000ULL : 0x000080000000000=
0ULL)
> -#define AMDGPU_GMC_HOLE_END    (adev->vm_manager.root_level =3D=3D AMDGP=
U_VM_PDB3 ?\
> +#define AMDGPU_GMC_HOLE_END    (adev->vm_manager.max_level =3D=3D 5 ?\
>                                 0xff00000000000000ULL : 0xffff80000000000=
0ULL)
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index dfad7d11826c..c6fd3a091613 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2409,6 +2409,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *ad=
ev, uint32_t min_vm_size,
>         }
>
>         adev->vm_manager.max_pfn =3D (uint64_t)vm_size << 18;
> +       adev->vm_manager.max_level =3D max_level;
>
>         tmp =3D roundup_pow_of_two(adev->vm_manager.max_pfn);
>         if (amdgpu_vm_block_size !=3D -1)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 139642eacdd0..806d62ed61ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -456,6 +456,7 @@ struct amdgpu_vm_manager {
>         bool                                    concurrent_flush;
>
>         uint64_t                                max_pfn;
> +       uint32_t                                max_level;
>         uint32_t                                num_level;
>         uint32_t                                block_size;
>         uint32_t                                fragment_size;
> --
> 2.43.0
>

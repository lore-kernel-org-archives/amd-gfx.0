Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E81ED1488B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA07310E748;
	Thu,  8 Jan 2026 14:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ALInsh8T";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90A010E748
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:20:01 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-122008e73c7so55297c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Jan 2026 06:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767882001; x=1768486801; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eAd4ghll7e2jNzWxtenCsnsi4i0Z55la3TZZpNIUBw=;
 b=ALInsh8T1vOHearSeLY5khBVkGTPDVYnI84DTYyPRqreasMb+ZMwnv4WCr5NwybIm6
 Vj7+FXUkCVHhOkZDVHYl5GDs1nlT7izwCRwgZTsTqCM39VISJgknADJXyFW8WvuNbNUU
 WZ67mkXd/yI7QibDksBEtnUzD5MeUqod8QzBA8dwHHZNqC/P3GxxDYPyPRqG5Pi+1y4s
 g7GoFnHkJvN3++DNwXHFcWmfDorXlBgqvPtODXc+naGU8jn1UIcIJXKxxR1AGrtUFecZ
 8QddZTScCXl+1UZ+puLh81WynHI1vtw46akg1kssmJqBCfgWgz73rf30ZlYjIsFfcs/h
 CSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882001; x=1768486801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3eAd4ghll7e2jNzWxtenCsnsi4i0Z55la3TZZpNIUBw=;
 b=qN5DrL3Cen98IgcxZs4WohUYHIW37kE1O/hbsDNtx/UkLRIWct8CM8WeC6vr9195Tt
 cqtZQo8ADoMyrtIza2wysH1h6iE69X/Ag2lW4Hk6fTi0lJZu+tg+M4zqXIMzKLz7DHhM
 2fBCRD5hTo2VDXW/K2xzEf6+sJIdbegybBVE79h7kigUxvkR8ZRHrAAnkliDxu5H40qY
 sou2786mvFPMxvC58vUiolZGr9KQK3hI7xseQrUhcPlbU5I4xMzlUyNEoquiHaSBRM2X
 cfJZCTnV00YXWRObeuWBEJgLZwY605cAS/PHUUwCpZtaU9FmUVtdbSUzEQ+IQ8GkovxU
 sa2A==
X-Gm-Message-State: AOJu0YzAJTffYSPDK/5qnSY2/CJqpFWyJ0gJDWm2aAF6/y0u9IEI/S0M
 U//vBzwSKIfCrZ2B3qxn8SL+tvdoNb28Fv2rqJSvYNCTFzn0cgoM853RlBrp1RdY57TmlzolDLd
 SzSoShi3solDm3KgjpxxLi1zjrsCdq8w=
X-Gm-Gg: AY/fxX4vqCdk30JN8b+Q4QkM5IBbP4V48N9vV59UALp514/Y5oMRRI44y1Ntfa/4SF9
 yM9AXYzsLrgMn0lmIQLvh7r+6nAhXAjqZd5BH8l2ZtwRw6Ib28yPtVuNZIlXAkW70eEtsY9s7eN
 r1NJVRXm2l7DVLfxE0yBTn2U0sJGqUq4/b36oePwfaf+2kZ4gx1d3vEpf1aFqKvVhW+YhCf0nwZ
 jgvezTs9BmvPRVlDDAumSu3lBDH394w0vZnwgaISv1Fpw1yL4zeE1eEM0yrgN3Kb3A4LfmFg+G8
 u+MV/Sg=
X-Google-Smtp-Source: AGHT+IHj77/SOCvzdphxAOrvfBnz2RhneTETZysNW5m7NXPcPsiQQAIi41tSLcQvV53YltkMyAwvsYVGfzce0WVAVwA=
X-Received: by 2002:a05:7022:3d12:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-121f8b77078mr2676216c88.4.1767882001235; Thu, 08 Jan 2026
 06:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20260107162820.707582-1-xiaogang.chen@amd.com>
In-Reply-To: <20260107162820.707582-1-xiaogang.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Jan 2026 09:19:48 -0500
X-Gm-Features: AQt7F2qWzhk4TcXzNZ6XS5vhEHHtS67QIOqrIv6H3_HdbP3ILOGK1Wa_EbD7Huc
Message-ID: <CADnq5_OPqRz5bBjDnEoQbVZwW8uMQk0LFTq0wfXBjsm7H61hkw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use correct address to setup gart page table
 for vram access
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, Jan 7, 2026 at 11:37=E2=80=AFAM Xiaogang.Chen <xiaogang.chen@amd.co=
m> wrote:
>
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Fixes: 68a5940841684 (drm/amdgpu/gart: Add helper to bind VRAM pages (v2)=
")
>
> Use dst input parameter to setup gart page table entries instead of using=
 fixed
> location.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gart.c
> index 16c3b78e50cb..68d8d0702b45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -396,7 +396,7 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device =
*adev, uint64_t pa,
>                 return;
>
>         for (i =3D 0; i < num_pages; ++i) {
> -               amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
> +               amdgpu_gmc_set_pte_pde(adev, (dst ? dst : adev->gart.ptr)=
,

I think you can just use dst directly here.  All of the callers set
this.  Either way, please update the documentation above the function
to reflect the desired behavior.

Alex

>                         start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, fl=
ags);
>         }
>
> --
> 2.34.1
>

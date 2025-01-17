Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2125EC02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 14:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C869910E309;
	Fri, 17 Jan 2025 14:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D9FAsxEo";
	dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1297310E309
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 14:02:19 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f74e6c6cbcso450913a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 06:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737122538; x=1737727338; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8k7CfajODKStQGaV7pgGNQlKHVi6C7uzB78CwwGIORs=;
 b=D9FAsxEorP+57UxQ9llIJyM2zOxHWVmwBVHIy2jMDLq8jUse0ln5Xg+GTQosq0Ib7Y
 mSRsxgEjDi8Z/f4ebc6hrXROmY2q2+Chm5g1N2MBTZ1ldtyVocZQzJekFFjXqH+tEkRV
 SA8dSYvorA+LORKQBhjYCau9DvEOi34Kp+tVP5gGaGaArw3a6RaKrJWDowRBmGowUpj6
 BxRbBgM/jVUtQcO44IGRW7H2bdIY7SPLaucStDWXqURLEJ4MDtLwzbwIsad7moWIjK6M
 ShlvR1GkGyzdA7HQVX1BFx3KR4KrDHjqLLVIlyG6u1LWueeiFLmzPIYorZwx7MQa3TG2
 i3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737122538; x=1737727338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8k7CfajODKStQGaV7pgGNQlKHVi6C7uzB78CwwGIORs=;
 b=KtxaQOkJw2fj5K/W+t7rcRgle5ZX0NHjtPeOHsUXkr/ce7+9WrJaTXpw9olA9dyCFc
 DHea04+PS8F9HljNflfDGAOyllrfy/G9MgOLQd93swUX5wxcQxDw4lwCbrlp6atOWMUJ
 Q0AJ0Px7u68Grb2bZ4KhWtTeLSnAoc6F4nl7JLa/RT5T4DJmhoNAmabLXO+yK7zHwTsC
 IP0pzIKast45AnqsLiOO4+ULxke5aMPNcLCGjbfL4ojwnBwL+ttbkWj+97xkSwZ9u7p6
 8xgzIE/rkSpLpCXHadtSY/JZtwEvADPQsLVJanPr5W8uF+7JhPUYszj08+Og869XMFiE
 8p0A==
X-Gm-Message-State: AOJu0Yw72hNJi4Wni/iNa8/KR3LhpkFZ1BO8DDoDuT3QX/DRU0A+RICY
 US5EoOEMx7vTYaHxJkSys1UgtC6wJWa3FKd6SKopjGWkFRhM4VpkYE1U/xF19pTgMmpLmet11Tx
 p1OTlEICcFCr3lnxkWnKqzDp+N5OBaA==
X-Gm-Gg: ASbGncsGmKrk9deHzxTdrWJndE2OcO2wPZw06Q6uemavaVZ1CZcyeY6npksLdF/lOxC
 FmfliNpSXUUsTMRfpsxqeHXHL4GWynmzsMUq++A==
X-Google-Smtp-Source: AGHT+IHUHDLj8jxYdg19Nd4NBPCEWdKJuc4vpoNOAhBJZz800c/vTv4F+VuOU5tqo3lr3Jw6X0i2GhnPm+511WhvaFc=
X-Received: by 2002:a17:90b:3bcb:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2f782c82684mr1536974a91.1.1737122538445; Fri, 17 Jan 2025
 06:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20250114100603.20997-1-lincao12@amd.com>
In-Reply-To: <20250114100603.20997-1-lincao12@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Jan 2025 09:02:05 -0500
X-Gm-Features: AbW1kvZi26BP_jJTRP0mtH2Zc6ow1fdf6EtSSQ2nOOTuZ44GUPAgRjzIOF-KiXM
Message-ID: <CADnq5_OApad4PHJ4afBJ2AbaKxzhWQz+xRu1SbfFnPqGNqAczA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix ring timeout issue in gfx10 sr-iov
 environment
To: "Lin.Cao" <lincao12@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Deucher Alexander <Alexander.Deucher@amd.com>
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

On Tue, Jan 14, 2025 at 5:32=E2=80=AFAM Lin.Cao <lincao12@amd.com> wrote:
>
> 'commit 6e66dc05b54f ("drm/amdgpu: set the VM pointer to NULL in
> amdgpu_job_prepare")' set job->vm as NULL if there is no fence. It will
> cause emit switch buffer be skippen if job->vm set as NULL.
>
> Check job rather than vm could solve this problem.
>
> Signed-off-by: Lin.Cao <lincao12@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index e0bc37557d2c..2ea98ec60220 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -297,7 +297,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>         amdgpu_ring_patch_cond_exec(ring, cond_exec);
>
>         ring->current_ctx =3D fence_ctx;
> -       if (vm && ring->funcs->emit_switch_buffer)
> +       if (job && ring->funcs->emit_switch_buffer)
>                 amdgpu_ring_emit_switch_buffer(ring);
>
>         if (ring->funcs->emit_wave_limit &&
> --
> 2.46.1
>

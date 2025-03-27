Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048A8C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 15:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A487810E904;
	Thu, 27 Mar 2025 15:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XGd8at9p";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16A910E902
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 15:16:03 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ff53b26af2so255606a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743088563; x=1743693363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAy1DZKO5nbf6a9fwpIee3sq/gWQpWsafyuSOEKtu54=;
 b=XGd8at9pWEhXHsAOnO4ris4qzDejOVaBbwrqC2DRqfarKwofQwYIpJn80y6sgHe1lV
 QEulddMM8YFlXNYOlkWXUaJ+yGk7gDc3ThK80lmWX318oUHbxHvp4t0Y8vsrTA1dhXwx
 2zACE3FHr3gRL2BZChVpUSFOMKS/0VwqpuaPU9SExfFeHo225iDRn4U3rsS7+ZSpUP+s
 DBP1jLzelLT1AXSVZS69KikFE6r+yx/f8e/CGbvrUUvMzBWKP1R95A6yOdB20VqZgQTh
 zxNoBJRsWm39tLmzkhy3/KgV2qIBV6qcpx866/tpM7mTmTErZ22zVrPDvhTru+sJ2hPB
 MBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743088563; x=1743693363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAy1DZKO5nbf6a9fwpIee3sq/gWQpWsafyuSOEKtu54=;
 b=cG1VeloPULPADbFnguf5RWKHI7iMAn1quNBzLfenJp6wR0cQAzo57CC5GS4rLf8/s9
 MHhPN/JEHwrEvypsW0N99RrapTakiRADgk0Bxby+s1yaP5xvvDWZIBgMlUUrEK31xdrU
 RF4JGymN7dFyalIezsAVUdKLnewbl6A7C+z9kvyfTM62YVKQ7xW8j3ZrripgI9z2Lxrk
 BIflYDWr/rdUsPAnDTJ2BQhJTaeekbPP1p/ZPjq7rSzhG9q7+kejimTT91r0zfXngCdx
 BQPco9U3+uR9/ynVjlm9sWMy1O7iN48Fwdahm3AUQpn9cKziqhOcxm0fvmv3zCLf7nbs
 27Qw==
X-Gm-Message-State: AOJu0YxavjSJfMvC8zDijSaIGEiyVBQ80RmQgFR2Bqchxu2amUQOjfYg
 w0vWtBbt7ODR0+OYs/QocXDde5wvjKLnBY7xOpy39kxw0U8zFUoW1DMmTZkM7lvT+CBGYyiumng
 XJiv2JPG1NB1GavJ+kNcLBFx5jME=
X-Gm-Gg: ASbGncvETP74X6LyAqznIS67+4PYuq9Hl3MxTaLHFk8N2mNMT2B3811AEaq1YfiO6H9
 d+UQcrskDV8M8rt2r/dYcnY9BPWLe3CqmQZyj9wT3KTfv3IjL3REsOITHPgHkf9idM5dQHrS4AY
 NWVt5UkPMp/u7Gj0fzRqgidQ/Svw==
X-Google-Smtp-Source: AGHT+IFhjSZ+HHGb0m5KJ6F5Jn+C8GcQm2Vqzyzp/CglVYPGiU9eIgtAe7IQ18ojaZHzvgAQKBLOWL33vFQ7uNVYdrk=
X-Received: by 2002:a17:90b:1e06:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-303b27141d1mr1874884a91.4.1743088563241; Thu, 27 Mar 2025
 08:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250327142928.2193-1-christian.koenig@amd.com>
In-Reply-To: <20250327142928.2193-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Mar 2025 11:15:51 -0400
X-Gm-Features: AQ5f1JrPNllJ8YYmVvbiFjZyEeHtGT0rvOyLTl0gEeIZ38MYz0QdoDAykA6SzII
Message-ID: <CADnq5_O-q+Zx56yrj6W0PPcWDLCQop3hxmPuFoviUUe8ptT8HQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: immediately use GTT for new allocations
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Thu, Mar 27, 2025 at 10:29=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Only use GTT as a fallback if we already have a backing store. This
> prevents evictions when an application constantly allocates and frees new
> memory.
>
> Partially fixes
> https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2833985.
>

Fixes: 216c1282dde3 ("drm/amdgpu: use GTT only as fallback for VRAM|GTT")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index d09db052e282..d90e9daf5a50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -163,8 +163,8 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo=
 *abo, u32 domain)
>                  * When GTT is just an alternative to VRAM make sure that=
 we
>                  * only use it as fallback and still try to fill up VRAM =
first.
>                  */
> -               if (domain & abo->preferred_domains & AMDGPU_GEM_DOMAIN_V=
RAM &&
> -                   !(adev->flags & AMD_IS_APU))
> +               if (abo->tbo.resource && !(adev->flags & AMD_IS_APU) &&
> +                   domain & abo->preferred_domains & AMDGPU_GEM_DOMAIN_V=
RAM)
>                         places[c].flags |=3D TTM_PL_FLAG_FALLBACK;
>                 c++;
>         }
> --
> 2.34.1
>

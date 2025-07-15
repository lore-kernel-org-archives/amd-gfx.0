Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41398C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 16:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B631C10E624;
	Tue, 15 Jul 2025 16:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wq6rfaEC";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D8B10E613
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 16:12:12 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-313756c602fso1007273a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752595932; x=1753200732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmSHRhyLgHkLMiYS7ldbkOb+5yZuc0HB02U/iEDn7cc=;
 b=Wq6rfaECyo4ohOmO4GarXyRvLC4w1DHxf1iRiMyhK1hXQEUAMmonga5GI1OMgO/V0K
 zs6B+OE5BZj+B/kPxmhzwfVWUYn2JsFpYwmmJI9sa3FaSKZCAMhZqaC2jm4F+2kx2DCi
 bjV5vWrTX3k+KUgjOTaUBzJtGbbtHqQATFJgPSswbPJwsanwcOiDD9f0GoHqh+VkTmx3
 3GCbviSBr8CyaiD4n5kKZebWJFNUb7noivEOO78joPUkOZt2Ra0Rbp/SFMEHXfdT6/mT
 toQUVFN6BbMP3ytupCDnRIHAI58s9D9Gw3BZVZ5Ow9alBywWR9ifq0NMDQ0WIpoB8VT0
 UxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752595932; x=1753200732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmSHRhyLgHkLMiYS7ldbkOb+5yZuc0HB02U/iEDn7cc=;
 b=fKcD9B5MvlpceBkAO6TC7+HpKMchkSTgmjkOueq4/876gLsg8R3X0seYwFVVKqqXPK
 wKXO7INPqYPfXe9rmsQARCLGTIHkxS/LKTvTWkGp6984XFDnFq9MT2FsaeqK3UUlkNF9
 jokWQ88KIYspDg0SCrDJEP0djFUMdchx85cRR4ATICkSzzaj271oPuhqKaxd5VjC49em
 pZODnb3zW1fGNFbgvveOojhLM+5uwQrOQ9Nh+XYhBqxKDqiTjr6/5nSpBswL6VyskyrT
 NI81p/ljkRz5pQdexZlGT9Tm3nVbjHibmA1fQTX1Ou658W8bYCQTzhq2rx5RZkB9A7nA
 F4Sw==
X-Gm-Message-State: AOJu0YwHqNxM1T4FH6G2wcnYbm7dZCQK23AN8DWBVXpqCrOTSfMoXS0Y
 ErMOnfrdikSgErfTrV4sz2LdhQbA/NwjBw0ujQUW2H0G0Z30Hu7Gd8eVusgTuCEHZOvYC7VMrWZ
 hh127k0LDOf+OIMR/8oBqmLo1c7OWTJ4=
X-Gm-Gg: ASbGncs7dJp9FaVnwxcQjZspnN47TE1nYjK/jmCcLZBWzBfwclftVTAfJcVJk1/N+Nk
 NM7h+/r4hIiG0hniVKhFYPQn4TCRIv3D9LDkcKMwMuPBq7waTbtYJI4TSi9KCMbTDpPn1gHGgj1
 bm0dRlfIfHBoJxoTNk5cFDAnrQycqGzRT0bNqDTb6aAS72Gnr+ImzDXEEuUJAog5MO3cSYoQc97
 DCBLy/z
X-Google-Smtp-Source: AGHT+IEIQYJMT0wlpC2ykXiqe9sAbo6PuVyYFTXLF8K0SzQu1+P4RY9vY5KRxPviDsfLZTWatjah2wfu0swd4JHsBLc=
X-Received: by 2002:a17:90b:2543:b0:311:fde5:c4ae with SMTP id
 98e67ed59e1d1-31c94d4496fmr1408043a91.6.1752595932111; Tue, 15 Jul 2025
 09:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-11-alexander.deucher@amd.com>
In-Reply-To: <20250711224024.410506-11-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jul 2025 12:12:00 -0400
X-Gm-Features: Ac12FXyH5Jl84mTOjH0xa9eoHOeN1BBgf-nZeC5qaIc9Il0ZL1yalLqM_iI_aUY
Message-ID: <CADnq5_P1syhswwZ8KOJkGeL=as4jDESOaxD2=jWn=zb-Dx9TxQ@mail.gmail.com>
Subject: Re: [PATCH 10/33] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on
 kcq reset
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, sasundar@amd.com
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

Ping?

Alex

On Fri, Jul 11, 2025 at 6:48=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Re-emit the unprocessed state after resetting the queue.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index e2ff4b373a319..d80f1fb261d1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3569,7 +3569,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring =
*ring,
>         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>                 return -EINVAL;
>
> -       drm_sched_wqueue_stop(&ring->sched);
> +       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>
>         spin_lock_irqsave(&kiq->ring_lock, flags);
>
> @@ -3626,12 +3626,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring=
 *ring,
>                 return r;
>         }
>
> -       r =3D amdgpu_ring_test_ring(ring);
> -       if (r)
> -               return r;
> -       amdgpu_fence_driver_force_completion(ring);
> -       drm_sched_wqueue_start(&ring->sched);
> -       return 0;
> +       return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
>  enum amdgpu_gfx_cp_ras_mem_id {
> --
> 2.50.0
>

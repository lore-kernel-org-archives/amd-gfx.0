Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB6ECCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 14:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C68110EA7E;
	Thu,  9 Oct 2025 14:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mI0bfzEI";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4125810EA78
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 14:28:40 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-32ecc50f573so224573a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760020120; x=1760624920; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jARUO9LjW4eYOVa88azlH1VaScNLfIf9ju3EmhA2UXE=;
 b=mI0bfzEIUoxqBHgalh/16rppyw6a/tnV4V6vOi9grYMUfQPKfOMux9XwHblMgeYE/f
 3f67wLPxK43PELVXCd7qZVe9Tif48YfW1HiNz35IOqh1YPG5acDRS2qwm9Hlf5B+YOwC
 QXRnlsd/8xiA+Q5T6RKuJ82844vDte+YG44tXuXU9TgndhjJ1W3cOZnwrg5dSHEbo8bh
 qnhri1nx9/MrN7qGcM8FJmmHiptEfPd7taGfGssBap7bzHDVzf/MmAYBia/1LMMaLoyL
 v7fA48w+eExC9eV91498+s15RSys10FX4F7ua/aM71eiq5Z9Ii20Hlj1R61tHRshgvu9
 d53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020120; x=1760624920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jARUO9LjW4eYOVa88azlH1VaScNLfIf9ju3EmhA2UXE=;
 b=gFpkhU47Go3sO2O9zdy6oAZapPEQXmu7/LjmhnRNCgws+pfaLWhMuKD9v2x74JPmZr
 IKjau/aa7ZQFg9GMarTMph0KBAY6R58u9xn7m3gx4wcZrCicZX3bEvLuYB13hbgB8xPV
 bCriOCcQNYxvC3jBM4adqnS5sMtgKozQOUFdb9qGAcbGbnWyBaBt9WJdcwZirLwqzamO
 IP8q2iJx2w+Bb5pPkokezt73Qdgts97fVNwX1L+SOVQRWI0WZTa/xpfFLKVG+/nBcKqr
 8863hV05DnPW7D8upp/GrwJPYG0c6QKOLRoPAIYNWSZX8Zq27zEHyuITaUhP+KX6Vhjl
 GwWw==
X-Gm-Message-State: AOJu0YzzJI/ueVcZmssHJnZeAQN5KuxhWwYZTdFYZOdPtT2QhnCSJB9W
 exjQCRrT6uF/tzykzF4UepE2eSgvjMZs8bWVJY4i6dbJwkwrXJwkzRX+cpc6oVuVCDJaQR89aUV
 V8Xd35k/aF7wb6wkLlG/xEeeC6e9X63gI1g==
X-Gm-Gg: ASbGnct3ZenfCvLbCJcssAbHYRbFNGCxq4XjzDhjcNEzKiAN19wmu+gcYyrNaEkkpV3
 2aPjLteG74ywkfT632S0AZvabPcgc2wpRb7vEXnqlidwnnv4eW/olVN1Apj2ZyDStnaY/smSKfB
 aoz/nNfYzlYkibxVqiGAm8Nr/DLEhgXYsKgN98M/3L6oL6Q9/DB3IDPMF/nmOxkgz3co+nUvcZD
 mRnuCrszlRjRosTbTWt7/D9xeU+3H4=
X-Google-Smtp-Source: AGHT+IGcXCauLAeaSZWsY+KywDM+xK1QIl8gYnqIMbEFihRBgbZCF6iZqlPErZrD50lHq3IGhdkcsG77e4dfTjMNkDw=
X-Received: by 2002:a17:903:2302:b0:27e:d4fa:cd23 with SMTP id
 d9443c01a7336-290273f347cmr55025105ad.5.1760020119685; Thu, 09 Oct 2025
 07:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250922213305.3661288-1-alexander.deucher@amd.com>
In-Reply-To: <20250922213305.3661288-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 10:28:27 -0400
X-Gm-Features: AS18NWDC_alSp4xyXU99RSWPsCyoC0bjWW7LsuDJtUGq2IN21kuEu0YpgIXvR1k
Message-ID: <CADnq5_M0XrfEyZjPL8QY5E5-LS=9tLp8h7U2tEPFcMhUs-gsbg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: handle wrap around in reemit handling
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
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

Ping on this series.

Alex

On Mon, Sep 22, 2025 at 5:33=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Compare the sequence numbers directly.
>
> Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fenc=
e")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index fd8cca241da62..e270df30c2790 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -790,14 +790,19 @@ void amdgpu_ring_backup_unprocessed_commands(struct=
 amdgpu_ring *ring,
>         struct dma_fence *unprocessed;
>         struct dma_fence __rcu **ptr;
>         struct amdgpu_fence *fence;
> -       u64 wptr, i, seqno;
> +       u64 wptr;
> +       u32 seq, last_seq;
>
> -       seqno =3D amdgpu_fence_read(ring);
> +       last_seq =3D amdgpu_fence_read(ring) & ring->fence_drv.num_fences=
_mask;
> +       seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mas=
k;
>         wptr =3D ring->fence_drv.signalled_wptr;
>         ring->ring_backup_entries_to_copy =3D 0;
>
> -       for (i =3D seqno + 1; i <=3D ring->fence_drv.sync_seq; ++i) {
> -               ptr =3D &ring->fence_drv.fences[i & ring->fence_drv.num_f=
ences_mask];
> +       do {
> +               last_seq++;
> +               last_seq &=3D ring->fence_drv.num_fences_mask;
> +
> +               ptr =3D &ring->fence_drv.fences[last_seq];
>                 rcu_read_lock();
>                 unprocessed =3D rcu_dereference(*ptr);
>
> @@ -813,7 +818,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct a=
mdgpu_ring *ring,
>                         wptr =3D fence->wptr;
>                 }
>                 rcu_read_unlock();
> -       }
> +       } while (last_seq !=3D seq);
>  }
>
>  /*
> --
> 2.51.0
>

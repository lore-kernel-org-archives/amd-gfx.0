Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA3EE66882
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 19:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06BF10F09B;
	Fri, 19 Dec 2025 19:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UcBPyIu2";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A451910F09B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 19:36:55 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7b90db89b09so247170b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 11:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766173015; x=1766777815; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wwjkMlKkkY7wnNlsYNjQi6FWSQxSMFxVsNeYBJTU4w=;
 b=UcBPyIu2kpD40kygceylrW04N5j13T1fxfB6+qlbrD06OWIKrM2KoTQSc/HqHFEkEe
 smRGVSYOnGhBZVIKtl/KRas1J07yfr2HMyorcAMh4DycX4dOmx8NrSdA5JYIroOqfX6o
 FKSSHAtdSOvP/H0HXiZgWOxW1Zv3p9t5zFrSQR6KXnvOZHEEb6WE53pPyNtJcnwmW1u8
 BAhDy8qNSrRcyQWXBonr5Z+fg1TGy2VONP1r3LCh9T1/ydLsZWCs+VL9J36q1JeDEEmP
 kECBih7WP+1028wh+VO4Lt9ckhNgObzk3ntS2zpCNpFOn5U6x0lKYgpDcXqfXp6srTbm
 U/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766173015; x=1766777815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+wwjkMlKkkY7wnNlsYNjQi6FWSQxSMFxVsNeYBJTU4w=;
 b=Fd+QprfWqAEFKD/W0BrhhCrXBmw6tUhGyYdV7g9603DifwT8qrbHgjSaY0lPx/tZgw
 i1Yh2n+zep1lPv7MNyJPYSo+cFDvRlcjSbpCCl+renByHlL4fKH+CKw6Ruds4NOy/9St
 jf4BogdwkdEbPP2+Z2RCsA13UqLxmUB0Cj7tW+dEwN9Uk5JKvPyEw9rGBykWT9Ctda8I
 y3DgsJ3qNWzZeJge6+jrsVG10v1w1xGW+VAFfrwHdGdDceThKSjUJ2sZlXxn3oSuAyPU
 JRklkwY22TXZzso34eapB/ciGhnBBywnUWMuA1T1u1GlHdgxtGqYHjW8sCHcAQLHLKER
 d3aQ==
X-Gm-Message-State: AOJu0YybHYFtUAEFOOkvOcR849UcUpr3appoCbyaQGzfWTxsLxELBKkF
 2lGlzj2Up+HEpQQBOqDkg6mxPLjfrFJwpo3yX5NOgOxGaAttNDoQUqxCKFyu/3P19he/VB8PzHL
 7p3tEmaKe+7KzCiONgH1d3V6j5qhg4b0=
X-Gm-Gg: AY/fxX7XTIoMdlfMiHTXe1qecQCPPVfTRllxPg6PWphpK6B1Xec39N26Nqj3sMCFOIs
 qYkNeYqqlbgA9jTJVLzb6wPxfaAUR21ae9l2oxOGg+SSIepwbSME1VgfalZr7RMVw4cYKTNdKXb
 W63+gcA4H/Zvk3wKr4EVe7ewN3UAFUqQFboGq7ZTiiHqGK92egrXCuNahwhurit52MSteeQEfca
 S0Qylf15vt5tN2nvXqT7dw+eJ6xkt45zh/VAvTWzTEYPCKVQa9VP7w2Pu3HpWGt8vuYH6zV
X-Google-Smtp-Source: AGHT+IHxig4a/uU5GZQUNMEmt9jDjEB/KJqtU8RQ/Va/uSu4SxXWBk+MQ5nKjMtzGENlTxkcuoR47WpRUnG3u6FdM/4=
X-Received: by 2002:a05:7022:688c:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-121722b0402mr2686701c88.2.1766173015025; Fri, 19 Dec 2025
 11:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20251219182201.5722-1-alexander.deucher@amd.com>
 <20251219182201.5722-3-alexander.deucher@amd.com>
In-Reply-To: <20251219182201.5722-3-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Dec 2025 14:36:43 -0500
X-Gm-Features: AQt7F2r6cpjYs33JInC-hjf4QCChyYylL8TlVt0g3V6sinx7RzNCqc7fOreOugQ
Message-ID: <CADnq5_P1vi0gZ_vS4a+xnwPu==3zTLwF-OXZHxfDpMrwQqpWrg@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: mark fences with errors before ring reset
To: Alex Deucher <alexander.deucher@amd.com>
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

On Fri, Dec 19, 2025 at 1:31=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Mark fences with errors before we reset the rings as
> we may end up signalling fences as part of the reset
> sequence.  The error needs to be set before the fence
> is signalled.  On GC10 and newer, this isn't a problem
> since we don't signal any fences.  On GC9, we need to
> signal the fence after the reset to unblock the recovery
> sequence.

This patch is no longer necessary and can be dropped.

Alex

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 600e6bb98af7a..5defdebd7091e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -872,6 +872,10 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ri=
ng *ring,
>         drm_sched_wqueue_stop(&ring->sched);
>         /* back up the non-guilty commands */
>         amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
> +       /* signal the guilty fence and set an error on all fences from th=
e context */
> +       if (guilty_fence)
> +               amdgpu_fence_driver_guilty_force_completion(guilty_fence)=
;
> +
>  }
>
>  int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> @@ -885,9 +889,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *=
ring,
>         if (r)
>                 return r;
>
> -       /* signal the guilty fence and set an error on all fences from th=
e context */
> -       if (guilty_fence)
> -               amdgpu_fence_driver_guilty_force_completion(guilty_fence)=
;
>         /* Re-emit the non-guilty commands */
>         if (ring->ring_backup_entries_to_copy) {
>                 amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_=
to_copy);
> --
> 2.52.0
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD6DC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0BF610EC2B;
	Fri, 11 Apr 2025 16:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kMReSQSt";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D7810EC2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:46:18 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-224104a9230so2937865ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744389978; x=1744994778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBC/jT/ztVR//sGaj/A/XVR6liVO/X34sbVfD0ExkFI=;
 b=kMReSQStlqYME5BorZYL/p1Gd5m/lJ6XPc6uiWdHHS5/Dcgd1V0J/8RNpy0wAFBWHp
 Z8YYXzgUvNQQq5Jcg4cLRWnljaEGjyJUcPtcVMaesIN3D2FLobIfxrFLPHt2enP4JL+W
 fRKxeZrRu4Tpd2T4kTmLoiUwgjKtd9qWP3DcfR0hNzQJ19jPkGKRImLFm1M+SMccXWz4
 zoVQHst84ZSmr3iwhBNAkl0Zl4ok3uh5BmTeSNaN/oMoZG7BgyZtTSdF4LT5n7VJbqwR
 9yeUEECAzPVVBrwC/QjvE5Qx3uTP3QojpP1M29yRUFlgTRYT7i/DN1ha1/4oKiQ7isVU
 0Ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744389978; x=1744994778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBC/jT/ztVR//sGaj/A/XVR6liVO/X34sbVfD0ExkFI=;
 b=RhF8NyOD5t6CVbbdc+pzBcK3+MIupt9gt/n+QgsYteaqofdrN9ikcjYvgkOxBqjiUH
 wfjxdAj3VsAGaw7OGyiPYvaVWDGQjwJyf3UHzK90TgipGcSTJ6e16/6e/6HECoUTDiDX
 s3xsVaQWPVv6YArkvrY99RE8zHIFxTDjSMPzGMfHNcY9f1+jFhVisVC7ZorS1J9vuoyF
 EUE4dzxiVLXU6w0aEs9mpSFSbR08g3+gixgyJTAhyydwW3rrjm4npVBtObJvBcyxM3yB
 loRRxjxVD5+ocqAqRnUUPRMoeL9ptoqOG49Vx4coZvDb0XhipgZ0SnWnoTMk6PePQKk7
 6nLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6Q7V2xWpWEyh+S65GUJ4Yj0laqpo9dteKKiD3HxOcZhO3FmVPFiklaIz1MryNGCuYRqiOknxC@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyh/w0Lp+IMR7ygloMorrfknieR47q45yxyREO8QZT3bKhKSboZ
 SxPEyNywPuSt9DI4iGP3fICyeW2jvV6H3spL+KTKtoO4NIZ/awoYJq4rz3bzcBy8T5hceeEPqxw
 YuvAc94HlIMWYO4mH5oL1WND5rerkW763
X-Gm-Gg: ASbGnctFXvmg9EQ1j8Mr3hJeWoAHMTSGzMaB77ZmvplOOEIPqCUDmI+pq2Peufz/P8U
 Di37mfpoadpIf9Ut7RrQMA6uqRejWrX6p2I/fuK2RjJdFHzZfWy8P7FuRm09nVZ2HjGPq/IzFBb
 FG4VL3fUaj3tgMlCpXd0T0Bw==
X-Google-Smtp-Source: AGHT+IGZVOpQdJkGqBNwJsGJ8nvRNjpHGn50FjWWMqrsQYXktrXwwT6QZysHYBnkBT/A8l0UzgZTNLauWyPXYnon9kw=
X-Received: by 2002:a17:902:d2d1:b0:223:659d:ac66 with SMTP id
 d9443c01a7336-22bea50da65mr18122785ad.12.1744389978248; Fri, 11 Apr 2025
 09:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250411161943.3323364-1-srinivasan.shanmugam@amd.com>
 <20250411161943.3323364-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250411161943.3323364-3-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 12:46:06 -0400
X-Gm-Features: ATxdqUEYMu66eQF3SjPNZ5Jeb_1OWi--etutiF9UThK7rLPQSQp3qxMlX4W_bzY
Message-ID: <CADnq5_Pj4Cwy23aYg1MwDq++g5KwKjFKJ_2vzcGw7m6=r9vKiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Enhance Cleaner Shader Handling in GFX
 v9.0 Architecture
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Apr 11, 2025 at 12:37=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit modifies the gfx_v9_0_ring_emit_cleaner_shader function
> to use a switch statement for cleaner shader emission based on the
> specific GFX IP version.
>
> The function now distinguishes between different IP versions, using
> PACKET3_RUN_CLEANER_SHADER_9_0 for the versions 9.0.1, 9.1.0,
> 9.2.1, 9.2.2, 9.3.0, and 9.4.0, while retaining
> PACKET3_RUN_CLEANER_SHADER for version 9.4.2.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index e62c77b3934a..bfe66a0e0e71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7387,8 +7387,27 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block =
*ip_block)
>
>  static void gfx_v9_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
>  {
> +       struct amdgpu_device *adev =3D ring->adev;
> +       unsigned int ip_version =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> +
>         /* Emit the cleaner shader */
> -       amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
> +       switch (ip_version) {
> +       case IP_VERSION(9, 0, 1):
> +       case IP_VERSION(9, 1, 0):
> +       case IP_VERSION(9, 2, 1):
> +       case IP_VERSION(9, 2, 2):
> +       case IP_VERSION(9, 3, 0):
> +       case IP_VERSION(9, 4, 0):
> +               amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADE=
R_9_0, 0));
> +               break;
> +       case IP_VERSION(9, 4, 2):
> +               amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADE=
R, 0));
> +               break;
> +       default:
> +               dev_err(adev->dev, "Unknown IP version for Cleaner Shader=
: %u\n", ip_version);
> +               break;
> +       }
> +

I think this can be simplified to:

if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2)
    amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
else
    amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER_9_0, 0));

Alex

>         amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zer=
o */
>  }
>
> --
> 2.34.1
>

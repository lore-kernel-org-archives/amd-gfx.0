Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA885E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 20:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE4410EC8D;
	Wed,  8 Jan 2025 20:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TL7TJzzE";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E28D610EC98
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 20:41:38 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2162b5d2e1fso295275ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2025 12:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736368838; x=1736973638; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgtZvJQCmtK63EYbR3EWjYEzvt9O2eTLYQBudm+MZu8=;
 b=TL7TJzzE9wUQCF7Sur0XNCdv62ki2RU0tnuyocaN6hFH9S0aQ9KEr+d8nKG06YcZXO
 naULJ2Bnc0UyDlGAdjAztEqYZlBAoYNeOt5t1Hnzh9KBEVF+VGE2ogjJ+GTZuscZ3kvs
 MNe3e2SfIqhQaOl1FhFKvZZEJdW1Itque22UiDw01y9gfb/LItoG1fCxNjE6tyEb791+
 30Z3NEG49fGNxQT/o1TzKtuQd30WsPYBgq0dQ4uCNrTy+lhbFSmVxBBUFj/bt392YOwd
 fiOrXN7d6ar6CivK5wV8Vh5OMSL+kdZG8+UJ9XaTeGXAK2USRhpY4SyEmgDduCWGJHez
 txkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736368838; x=1736973638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgtZvJQCmtK63EYbR3EWjYEzvt9O2eTLYQBudm+MZu8=;
 b=axE2SDP6q041AAwkv5ZDKkD96rgikFiZ+d7KN8eXpt4NCrRT89Ed/V1rurq8KMxwFI
 0IDqkWSzz2bRB80ODbrNwQmOacVobeyQw5Uo5liAboxIx/JFz0FpzyUr3nEY5WS5BSiO
 6UMuQaxruyOaYPZxQLHkOpK9bSnnqBm/rEB4+z0Cb/y9tSwULnmkKwmhxn0irtsurCOc
 9c7ljQCfy19TdGCyYWZGXwK+R34rPl3o6yKS/GYdFMsyoxnnjpgu8McWld2eScWv0609
 RiniR1K9Pp4ytQe6frqFdMv17SewtuRkUWKoW+LUfcsUn2HjqN32whfxhFH6uqKYiLMX
 vHfA==
X-Gm-Message-State: AOJu0Yyk//881zvIT+YK01Tt8Ey4Ueq+TywCb34DmOMdEN675iq+S0zN
 cQPj4ies10xywTQrmT0AOdsLkwUerCojYx1L0FIvXmfEZLIsFtXhKj3xognSew5CmBKWWnp4tqf
 Lk3/bK0TEYhastj3b3fni/yfCwGpkYQ==
X-Gm-Gg: ASbGncuWTrzUbmvIF0lkBFQ6wiAZ16hquq2TXAwsOreB79jGsUIdfH3f01St10eCbpS
 wgqFGB6y5lD+D+2t+kX465QWS8lzYJZUU8XSe8A==
X-Google-Smtp-Source: AGHT+IGaDt/hSckT/5W2ceVJvCEkTl6TYJLXqhNPtkwriy9fq5REBS1EI2fqA/0N+6sC0IynPBC8GWZ+nXCJZnGeraE=
X-Received: by 2002:a17:90b:2b8f:b0:2ee:713d:f536 with SMTP id
 98e67ed59e1d1-2f5490dc3b4mr2354422a91.7.1736368366064; Wed, 08 Jan 2025
 12:32:46 -0800 (PST)
MIME-Version: 1.0
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
In-Reply-To: <20250108200121.2808908-1-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2025 15:32:34 -0500
X-Gm-Features: AbW1kvY2dJ9bOJ_Ttu0klWpMUOsvFWk1EeZzFe-xr35XelKyKeGp-SES1WisEDo
Message-ID: <CADnq5_Op2NoQ5UCjuuenNLtFo9qAMvteHxgo1Mu-otqgtP90Ag@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
To: Jonathan Kim <jonathan.kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harish.Kasiviswanathan@amd.com
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

On Wed, Jan 8, 2025 at 3:27=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.com> =
wrote:
>
> Per queue reset should be bypassed when gpu recovery is disabled
> with module parameter.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Maybe add a fixes tag?

With that,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index cc66ebb7bae1..441568163e20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1131,6 +1131,9 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_d=
evice *adev,
>         uint32_t low, high;
>         uint64_t queue_addr =3D 0;
>
> +       if (!amdgpu_gpu_recovery)
> +               return 0;
> +
>         kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>         amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>
> @@ -1179,6 +1182,9 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device =
*adev,
>         uint32_t low, high, pipe_reset_data =3D 0;
>         uint64_t queue_addr =3D 0;
>
> +       if (!amdgpu_gpu_recovery)
> +               return 0;
> +
>         kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>         amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>
> --
> 2.34.1
>

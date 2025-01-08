Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EE5E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3714710E8BF;
	Wed,  8 Jan 2025 14:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dQKjt02u";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4FE10E8BF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:24:50 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2f440e152fdso3549261a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2025 06:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736346230; x=1736951030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXIC4KguKe0gvpaadlLFYN9IQUwfUkABz3fSyZkxN5A=;
 b=dQKjt02u3tP1acEgoE9kziZocNJU1c3yJ/D7c9nxz7wqjczFLnQ3/k9ysSfjYXJmNO
 RJstAvfSOfg8CuVDNM0S/7k/1zrGKK2QXEKIRyniUIwaTSGzQH2rK0kEFfKakZh3Htyd
 b1HWt0OoLYDcN09+M3kWRS4kdEW5grMISn69we/e7NKxMqw+O8qh5YNhbvJiAGqDLyeg
 rDdQF04BsKAVg7cUspr4sWAQef5WtE5YnZ9Jp4AkbNEL0ABIR+lsfDMyTsU2E3qhORDQ
 CxZjD7fsDsR/q9Coukb58igYN2sw63MyCnPoFdFyRt1zNgJDH8qOmAP0mvOUY5Sm/pqx
 Kwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736346230; x=1736951030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXIC4KguKe0gvpaadlLFYN9IQUwfUkABz3fSyZkxN5A=;
 b=vkoH/Hh4eamOnLNTXEI66bWqNDOB//gQdCfN3NCHv5FXjT5P6zN64cBDCq/XQV7bI6
 eoBjGTe7LBfBiNkYa6UHmPQqdNP/6aGCY4EzSEf1Jj1g0vIhui5eGuDo9Sb+TgzltO1p
 Qi9B5Vb36MPdE8GF+25JAOAB+5UwHzQvZvK8yrQHP3XYZef9Xmj021eRwRY0z0hOsaAl
 +GFZ9HYLfdjE91Mv/Za9gG7wsEiN4QMNsd6zT7cqNFXuUrk1VNZKO6uRUbLZcyF34D3Q
 CpKlOlmgjkufr6OvxUoargG3H8giyjCzgWbiC/nOpMRroJLAY3LczASbZN8o7u9IaQ2w
 T+FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkeVULbcPvrM126iG9xzA7LB6lyqlkTPgFGkWMvTKimZEyXz24AxnwLhOHofXqPvsPaH8Y5v4D@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzd8sI/FCj/DwSsCScp5qpGCnpmkztWO/vHefHmf+uR3c0gsJjB
 lJCgWVoA9muBn4g7VhA2Kv+ndkDRYjgn6IGFv9diwdQriaM+JIZ/E1yjqJvlQCskqKtiS4X+F3U
 5GxY6PaARoLVkP7dEPDHQcCoP/+ZkjA==
X-Gm-Gg: ASbGncskruuv6BHXPV2FvGseziZ/WrpWK/VXNFBCwlyQ1QsjWxVIDyZYSoc8TTkGANn
 tBmb5ndD8xb/k0nSrtbaRqRkGON0Hmj/wA7BaNA==
X-Google-Smtp-Source: AGHT+IEJd9hecPvudfaKF+RPSK8tLEs3ufpS2Ou8c+fwVbtNGqYEdZCbOa3eCGZPenvQ2QPmBHLQQlVksN2a9r6/KAo=
X-Received: by 2002:a17:90b:2c8c:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2f548f05913mr1768892a91.1.1736346229995; Wed, 08 Jan 2025
 06:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20250108093237.81961-1-christian.koenig@amd.com>
In-Reply-To: <20250108093237.81961-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2025 09:23:37 -0500
X-Gm-Features: AbW1kvY9h4CGR9JJi9B8Y2p2oPeYFNL54CbmMbt-w3XyyqMRTXBn5CC3TXkRAKc
Message-ID: <CADnq5_Nyyctnq-Ts5gnm4wqadRF3ZjcLEkdM24bDsh=t8NAT1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always sync the GFX pipe on ctx switch
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org
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

On Wed, Jan 8, 2025 at 4:52=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That is needed to enforce isolation between contexts.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index d751995dc131..e0bc37557d2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -191,8 +191,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>         need_ctx_switch =3D ring->current_ctx !=3D fence_ctx;
>         if (ring->funcs->emit_pipeline_sync && job &&
>             ((tmp =3D amdgpu_sync_get_fence(&job->explicit_sync)) ||
> -            (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
> -            amdgpu_vm_need_pipeline_sync(ring, job))) {
> +            need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job)))=
 {
> +
>                 need_pipe_sync =3D true;
>
>                 if (tmp)
> --
> 2.34.1
>

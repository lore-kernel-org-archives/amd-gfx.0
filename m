Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2230ECD4F4A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 00:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0E110E62C;
	Thu,  5 Sep 2024 00:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FzE0iq98";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0A110E62C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 00:37:23 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-206af242bdcso225395ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Sep 2024 17:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725496643; x=1726101443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7cQfi2QspjfXD4J0kvDyYbIhf3oQqw3W3d5DMMpz/w=;
 b=FzE0iq98O3cGCASZAlSfuJmtFWtqIaVQHQ/5h+tw+Td+e1XIMcJmolFABmznvM92L6
 7QRm8QPcXDeuLrIm5fFRd0fhcEk3iJjFMH252sCLPwSYUMceqQpLfFDuGNuUtysgpWwS
 GSmWoheiCHU3P3NafWeMptWqkY7p57cS2lR8Hr/V/9yttMmNL0uYOZ3RCjDhOrp5GoE7
 eKF8NLzuDkNcb4+eVTWm92nAUJeIIWFy8yNJXowc4q6vWtxhtcXY4jBJQAlPsdcWL7xs
 ZtLGWBEfFvHrHDdX2+J54zZI/5hwnohC+xYlKqb47QlQ1HxoouQJBiLFXMRIYXac/CSI
 93nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725496643; x=1726101443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A7cQfi2QspjfXD4J0kvDyYbIhf3oQqw3W3d5DMMpz/w=;
 b=j/wDybunMF+G9ObfDFtVWuAFCUUk6mp1eKvG5kMuTE+rTi5OuqNwOBG27WnDWsw1xj
 s/Wci0f5lNfiw/AaEo2+9q1vBsGqEQ0IM3hF86zc8Lpn8SWV88aDHy5sSXMu8Qd+o8VI
 9LpEdXnC6Piitsj5u97jfAh4QbCko/H7ZM9Uf4UJB+kRUWBky6XDhhqhbU0e/ZJYEeQ6
 5wZQwtksrQcJgNN2RiepwVwuGIuE8Co/wteFmFZlxiBx+C1VkekV25OhuX/wWHqaN/tk
 UwIouON74OID4Z58/vGXx4ABmOtrbd2AY8qB83xmsB/Q5XFj3aiZohpgnZ0zhDu73mlT
 dnOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhRKdXr9PUFt8HQaoiNmakDJbSZTZCXzaXqZwtzCSHL1IA1t+lsrljYrMQQssaeRDrifP1Y/4G@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzauDQOR6SoG8PWAeiN0BYxJyF3IVAQCdfTbCAqqywL64g1D3ie
 6JdHbwHKzdgC9ELZMNNoQ7vmJKLnE5DomXK3Ipjnj1aLgm+H0swme0JcXn3uvzck/EUrft5Yc8k
 LF87jpaNjHmIRvEHrpSxJW5weCMyvLK1H680=
X-Google-Smtp-Source: AGHT+IEJL6TqSbFEDS7OnO1n4YWyEfTjx0btzYfh93LL1pWXjjJb0i3NUtXkzAAk58mAoF31mrQnK2JcjUtBS1Hbx+E=
X-Received: by 2002:a17:902:e549:b0:205:8948:3578 with SMTP id
 d9443c01a7336-20589483694mr57351305ad.2.1725496642514; Wed, 04 Sep 2024
 17:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
 <20240904132729.1948224-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240904132729.1948224-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Sep 2024 20:37:11 -0400
Message-ID: <CADnq5_NF64K3Sih7c_N7TqpF8d5M2m7pfPFTDKKqFVwJUHuq4g@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/gfx9: Refactor cleaner shader
 initialization for GFX9
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

On Wed, Sep 4, 2024 at 9:53=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit modifies the initialization only if the cleaner shader
> object has been allocated. This is done by adding checks for
> adev->gfx.cleaner_shader_obj before calling
> amdgpu_gfx_cleaner_shader_init
>
> The changes are made in the gfx_v9_0_hw_init functions These functions
> are responsible for initializing software components of the GFX v9.0.
>
> This change prevents unnecessary function calls and makes the control
> flow of the program clearer. It also ensures that the cleaner shader is
> only initialized when it has been properly allocated.
>
> Fixes: 776ad43d4170 ("drm/amdgpu/gfx9: Implement cleaner shader support f=
or GFX9 hardware")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 23f0573ae47b..d6d07cfd279e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3975,8 +3975,8 @@ static int gfx_v9_0_hw_init(void *handle)
>         int r;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -       amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_siz=
e,
> -                                      adev->gfx.cleaner_shader_ptr);
> +       if (adev->gfx.cleaner_shader_obj)

Is this check actually needed?  I think amdgpu_bo_free_kernel() can
deal with a NULL pointer.

Alex

Alex

> +               amdgpu_gfx_cleaner_shader_init(adev);
>
>         if (!amdgpu_sriov_vf(adev))
>                 gfx_v9_0_init_golden_registers(adev);
> --
> 2.34.1
>

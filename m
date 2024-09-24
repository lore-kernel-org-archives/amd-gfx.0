Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F297CF9C6F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 14:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C733310E1DF;
	Tue, 24 Sep 2024 14:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bu+P0Aks";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AEA910E1DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 14:06:52 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-7db74e00741so428076a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727186812; x=1727791612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7DQXqzF8NlJW1m3H6lEcIv7ngP9HFgvlcQesou28G4=;
 b=bu+P0Akspx4yElkomX50tkxLOfA4IfU6SxkxYVX1fSlGav4eF1LI6imr9eW1NEsSZ8
 gA/5mmPvZcQN8SjKzH6NEYbIUvxBRmZADQ28JFMpLNZng60XSeXYJtPzBcMfXMJfqqtO
 zDArjJIIFVzxomUqouHnPIvPBXNgjOdUqz0BcHwhzsz+jBrS5OfiL1DUF2sdGXQMaySm
 4y1s0Tzj8hX7IdB6aI4UAOvB7dLmihKTU6iESCZj5SZnVZ0LN2S+SVOcLG3F3EgE+6A/
 n/D+7AKCnnIEdtrp56f0Fq/K4SQ9zZbp29mYymCqTuBMuE5USQl14KdafltM6a/g4/If
 vWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727186812; x=1727791612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7DQXqzF8NlJW1m3H6lEcIv7ngP9HFgvlcQesou28G4=;
 b=ZnK4EvBN6PiSi8zqql0Rtxwr3lSbe/xZ0uawWknH01qIxfGf+QYJ4eUrU5PabuV2iq
 U8Ng4yS2NhFXhrOP0z7EK3dgnVwFYRr8BLhtGR7yeFHI7T7qznuEhWeChp6kfk2yUya8
 pBA0SYv7DLJnx8cyTwIx3CPVyzR2WRZqmzLItbnAYnDtQ2XjLtwsMAjb3JvnoIFfn8eb
 Rt/h0njh6LbvXuvD0S9LMlWsu/jjE/tL++hbi35MU9NcL6YatVyCr6l6qrov/+BnYCbL
 ByJU/5GDYVaW+e08i9FCfMH87k8QaQAYziic3vs1DivJlmbfSGYtKfaPXWH7LIb6wdRo
 i7OQ==
X-Gm-Message-State: AOJu0YwcmT28hCdBHysIGBu/K9QgV+HOw6D1JX1MZsfJcRQR8VF6KG6x
 daJrydH/UuWrmgHgLx+oXyNcLC3flThevQURk2amvtqy98XMFbICDZLMcaArUJNIzF30iEuVDaf
 jedwhmDMpL9P0qO+u97X4uVq+dH8=
X-Google-Smtp-Source: AGHT+IFRbUFtCPZ4GkTdRqVutkAtHfVq3vu8ArRXxuH9lxg4IZyIdp60PL5Fs4JnOYK4r/9xR08CsZkHz+phz169Zq0=
X-Received: by 2002:a17:90b:2cce:b0:2d8:be3b:4785 with SMTP id
 98e67ed59e1d1-2dd7f6d6ac1mr7421513a91.6.1727186812094; Tue, 24 Sep 2024
 07:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240923081931.2126969-1-yifan1.zhang@amd.com>
In-Reply-To: <20240923081931.2126969-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 10:06:39 -0400
Message-ID: <CADnq5_Nm_OdBNbDR+J_w4v2yK4_yH5GxVdRwinJsgZBys69Lgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB
 limitation removed
To: Yifan Zhang <yifan1.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip.Yang@amd.com, Felix.Kuehling@amd.com
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

On Mon, Sep 23, 2024 at 4:28=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> Make vram alloc loop simpler after 2GB limitation removed.

Can you provide more context?  What 2GB limitation are you referring to?

Alex

>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 7d26a962f811..3d129fd61fa7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -455,7 +455,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_ma=
nager *man,
>         struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(tbo);
>         u64 vis_usage =3D 0, max_bytes, min_block_size;
>         struct amdgpu_vram_mgr_resource *vres;
> -       u64 size, remaining_size, lpfn, fpfn;
> +       u64 size, lpfn, fpfn;
>         unsigned int adjust_dcc_size =3D 0;
>         struct drm_buddy *mm =3D &mgr->mm;
>         struct drm_buddy_block *block;
> @@ -516,25 +516,23 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_=
manager *man,
>             adev->gmc.gmc_funcs->get_dcc_alignment)
>                 adjust_dcc_size =3D amdgpu_gmc_get_dcc_alignment(adev);
>
> -       remaining_size =3D (u64)vres->base.size;
> +       size =3D (u64)vres->base.size;
>         if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_dcc_s=
ize) {
>                 unsigned int dcc_size;
>
>                 dcc_size =3D roundup_pow_of_two(vres->base.size + adjust_=
dcc_size);
> -               remaining_size =3D (u64)dcc_size;
> +               size =3D (u64)dcc_size;
>
>                 vres->flags |=3D DRM_BUDDY_TRIM_DISABLE;
>         }
>
>         mutex_lock(&mgr->lock);
> -       while (remaining_size) {
> +       while (true) {
>                 if (tbo->page_alignment)
>                         min_block_size =3D (u64)tbo->page_alignment << PA=
GE_SHIFT;
>                 else
>                         min_block_size =3D mgr->default_page_size;
>
> -               size =3D remaining_size;
> -
>                 if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adju=
st_dcc_size)
>                         min_block_size =3D size;
>                 else if ((size >=3D (u64)pages_per_block << PAGE_SHIFT) &=
&
> @@ -562,10 +560,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_m=
anager *man,
>                 if (unlikely(r))
>                         goto error_free_blocks;
>
> -               if (size > remaining_size)
> -                       remaining_size =3D 0;
> -               else
> -                       remaining_size -=3D size;
> +               break;
>         }
>         mutex_unlock(&mgr->lock);
>
> --
> 2.43.0
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE932CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 20:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E2A10E8FA;
	Thu, 18 Sep 2025 20:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BaDcXvnM";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF51910E8FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 20:52:55 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-32da2bd7044so200419a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758228775; x=1758833575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8g1pL9AUUC8P/PFn+EXnHKvKiZ1cnYcbKqw+0fVegmk=;
 b=BaDcXvnMb6+WnOyipynUrq6BxL61TU8E+ApIfEQApEx5YQP5fFRXvErdCJRchOWKde
 2BpU6hV3kLQogp0LlIDYMnVe1pFYb0zvHIdXLt918EE7SeYkpJnhymj3MDYwZAmNL5UV
 MP4XcxSQNFrfNQ/9Q4vYUUeNru+w6MzwqaSF4K2Cs9kniNCsUZq1lCgSTWVqLAFB9KG4
 9ZkcUjjLxY6xHuBgayQUKnDqC//kfFehUQtmvVDLrIOMFabWuGc6S40vsIa+DzNGBUcr
 zcQY/X1WodYNAtfZOiZQ9+xBBf4QJCRjO3pH4gqrFDBWMhsNkDeH/RBlvfxrYtiPgxOU
 ARyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758228775; x=1758833575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8g1pL9AUUC8P/PFn+EXnHKvKiZ1cnYcbKqw+0fVegmk=;
 b=OGTn1k1HF9w0REu6f61p01JhRAyAWb2XyzOwXQwU79oDHkLEAT4X4y4TdnXzglDYZV
 e3qwFK0xFhroEWxzIRMl2rkpMrfZcvj/bisE+qSmwg6hfcdxlj6XU26PdALN3ohpr0xq
 8AqXFoSl80gYRQLtGKW6j4VsvARVojnXUJiHrynEivXDUjKIR1BlLKiHXg/PGgSKI+No
 3R+c5Mx/RCfnev/jqdzllo51UerHfC1mjIKVU62UDBhONW00SpcVxO5mS0NjgYCKbymX
 z2b7Ez9SVIu0R3VF4UOf3efiQLJJX9rw/mlJvUq1NEfS3ZhZ1RVizCnD8j4h1M5YKcBm
 B+KA==
X-Gm-Message-State: AOJu0YwRDF71swAxtem9D/rtKdfj+jV2hOovgGAcWGYezyWzcFmX2FKF
 Vd+WxlRad4U0YCtikrFMARlgdQaxHPTy/TXI5mKMBn+IH2BYVAUB/tDftiUyHAZb0VfR91ivNBa
 piiChGj9ePDPtPFGMyQOks0aUQDPP1MqFDQ==
X-Gm-Gg: ASbGncvT0QMx+1oUoC8CEJtbovlV3rAWlNgffuthDdD+D0jzCZwgKLD8ZsX8FEeo9FG
 YcsJbvlM4mN/OMIoWbimJniC4d7oLTggC+uNd+inWYF7i8hzmFHsJ1hvNbfyFElC8eStFwSjrHL
 vui3vre36ucJTQBZfF0OZuSf4WQ+hXHuDswkH1mPwcrn9c4OBqoPoV228FHt6i064wqM4L7Hstb
 iV3/ocSDZv/MMTN8DCB5mOBIA==
X-Google-Smtp-Source: AGHT+IFPep3/PAzjT9VTDe2hYMKHQBleyySKjukwHkdSxm1pJYt2JkablR7oBZNyfNfGvn1W8EDTutJv17TFd6nqd9w=
X-Received: by 2002:a17:90b:1b49:b0:32e:8c14:5cfb with SMTP id
 98e67ed59e1d1-33097ff4c25mr478049a91.1.1758228775225; Thu, 18 Sep 2025
 13:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
 <20250918081815.2755437-8-Prike.Liang@amd.com>
In-Reply-To: <20250918081815.2755437-8-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 16:52:43 -0400
X-Gm-Features: AS18NWBfeje0ThhXSKAmHuMa36LtEuDI4YOiMk_USOJBjkPimc50Ar5iIkT6OCc
Message-ID: <CADnq5_NrPoKtcW5nmrzjwfhCzakpP-RqirQxysLjO1oa905pcw@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] drm/amdgpu: keeping waiting userq fence
 infinitely
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Thu, Sep 18, 2025 at 5:14=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Keeping waiting the userq fence infinitely untill
> hang detection, and then suspend the hang queue and
> set the fence error.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 3c8f05a9e82d..5c918faca776 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -193,7 +193,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_m=
gr,
>         return r;
>  }
>
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_usermode_queue *queue)
>  {
> @@ -201,11 +201,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_user=
q_mgr *uq_mgr,
>         int ret;
>
>         if (f && !dma_fence_is_signaled(f)) {
> -               ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(=
100));
> -               if (ret <=3D 0)
> +               ret =3D dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIME=
OUT);
> +               if (ret <=3D 0) {
>                         drm_file_err(uq_mgr->file, "Timed out waiting for=
 fence=3D%llu:%llu\n",
>                                      f->context, f->seqno);
> +                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                       return -ETIME;
> +               }
>         }
> +
> +       return ret;
>  }
>
>  static void
> --
> 2.34.1
>

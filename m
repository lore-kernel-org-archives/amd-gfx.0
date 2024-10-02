Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0ECCF6D3B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 16:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C54110E629;
	Wed,  2 Oct 2024 16:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PGSylA6q";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C11C10E629
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 16:43:33 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2e0752be2d1so5246a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727887412; x=1728492212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuUUxYD2g/UbKzfvB0bqOGy/GFaZMmMgwGDuFmr7Qw8=;
 b=PGSylA6qs23R6O2gz377cnbsxM4UXMv+g09eha2mCx9XFEhdw6zUxiEjf0a9CuOPrP
 AD/+QDTCdIFBrRCP08QL9A5XtsaM9Us8OThmkckALDgehhFuAG20dXt5mnjPq5Y02PD5
 BPPg4mL/hYcxMmthx5ExbbHrEqM39RKBOZXbN3qQdjZqePaxxBdgFQ1MTh4B2d+4i56F
 W3DRLw3BpgVYDUkeySWSyuXi020sG0GyPnq7+r24/tejywdYjSMf3fyDwISH7M61KOLS
 ic+M5WPWavRN+ypmpecrzaA+zUsfJWDFNOyH7SIIYx7FeI3xYCZb+aFW7/exnNn70X5L
 jABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727887412; x=1728492212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HuUUxYD2g/UbKzfvB0bqOGy/GFaZMmMgwGDuFmr7Qw8=;
 b=X1w/8VcVSnrthxD/JFS1JtFmFuLyb9rOBuAFgGUVKZdtWk0dAXn/QSXqCyUokwRDBE
 FVu5CA6IChkF2nXpjzQ+qUAyCdV/NZIEt5jIIfRYPaPaJVebvl5mO+xt4XM/G53qY4qv
 2dCiMDRr3Mxb4uNcXr2thodf7qdPK42vjAe/8bLXI+1UyPpExm/e3sGoE+Nw1wKVpHy9
 LmtmT0MQGl1qD8tMsyabl1K17iDYORba4FA5DPp9bIVVttbmqU6YgbiNjso70rg0erps
 uPlAZJ4nx/wJD30LmRXedE0J2u7W0Vtt5P2jHD4TZYrur8G+WpzU/5CjpPjipT1J/bkT
 /dNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqkQc6sxQjK77b0FWOPt/SO1r6gJTlRNxXj9QbVbtv4TBMQt8OfX3+ZI7tukTYUCAqnzU3W/mg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzae88Vy5tq9d6G4YZeNBQ8KngN58PxP+DPJsumvJkjyLBmK3H1
 VGhyFI6J9fc+L8vZCZwI0uYcwKzPbYhLaZJl/XOhtzNyPg5ipgXH2IKFvrRity3Bhg8oLdn2MeM
 n7O4R0131Njcg6os5DzZrWXU08xLMUl1w
X-Google-Smtp-Source: AGHT+IHdek+5VwEKU0urfG4zQ2srmzFOJCP24w1Z/e7LtN19si/0mSaHJcrEgvHLk0ODpxi9U6AhccQx/zU4hEx8aiU=
X-Received: by 2002:a17:90a:8f03:b0:2dd:5137:a9ca with SMTP id
 98e67ed59e1d1-2e1849d79f4mr1876476a91.8.1727887412517; Wed, 02 Oct 2024
 09:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
 <20241002043936.2960921-4-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241002043936.2960921-4-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Oct 2024 12:43:21 -0400
Message-ID: <CADnq5_NHWgBLgrSB3xt7FQ7fNf--zE9NWK=oyft6Lbg792nVZg@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu/gfx11: Apply Isolation Enforcement to GFX
 & Compute rings
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

On Wed, Oct 2, 2024 at 12:41=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit applies isolation enforcement to the GFX and Compute rings
> in the gfx_v11_0 module.
>
> The commit sets `amdgpu_gfx_enforce_isolation_ring_begin_use` and
> `amdgpu_gfx_enforce_isolation_ring_end_use` as the functions to be
> called when a ring begins and ends its use, respectively.
>
> `amdgpu_gfx_enforce_isolation_ring_begin_use` is called when a ring
> begins its use. This function cancels any scheduled
> `enforce_isolation_work` and, if necessary, signals the Kernel Fusion
> Driver (KFD) to stop the runqueue.
>
> `amdgpu_gfx_enforce_isolation_ring_end_use` is called when a ring ends
> its use. This function schedules `enforce_isolation_work` to be run
> after a delay.
>
> These functions are part of the Enforce Isolation Handler, which
> enforces shader isolation on AMD GPUs to prevent data leakage between
> different processes.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 745996ed2380..f938919cb098 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6874,6 +6874,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_gfx =3D {
>         .emit_mem_sync =3D gfx_v11_0_emit_mem_sync,
>         .reset =3D gfx_v11_0_reset_kgq,
>         .emit_cleaner_shader =3D gfx_v11_0_ring_emit_cleaner_shader,
> +       .begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
> +       .end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute =3D {
> @@ -6914,6 +6916,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_compute =3D {
>         .emit_mem_sync =3D gfx_v11_0_emit_mem_sync,
>         .reset =3D gfx_v11_0_reset_kcq,
>         .emit_cleaner_shader =3D gfx_v11_0_ring_emit_cleaner_shader,
> +       .begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
> +       .end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq =3D {
> --
> 2.34.1
>

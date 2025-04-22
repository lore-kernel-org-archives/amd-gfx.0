Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34200C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 20:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F5A10E3AD;
	Tue, 22 Apr 2025 20:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jz/eaKt/";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A724010E3AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 20:43:16 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-30363975406so686547a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745354596; x=1745959396; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTlImnC1F95Pseriw1ifyTC89Z4nvhNKRq8zYU5UvXc=;
 b=jz/eaKt/Pn6jCep2L9C85as6991Lvi44tSIab+59zrxTWGuwX/z97wxRWtUvXO5i2x
 VD+3sL0njdn8pLuQ+d69ujZGJKwCTJXZF4SI6HxetUzSEAH5LYouMftjuhzFVZMq1mV0
 64VpnOzd0i2g73cibVbjcOEUyO9Q9H7I90/GOAcpZhTsuQXaQE51LofIDZBUmrRNu70x
 gP7Ow/k5PgL0cJdW7jA+EyZqmJTUTdcJDYyc/sgUE1Or02+IC9MdiXUvizVsnh32Oa/y
 TmvQI4T5GEucieOIr5Rb5H1nq9hD7E7SVyMUNUY9qqhJ799Nfl6E+Juy9dw38oBzfBUx
 7QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745354596; x=1745959396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTlImnC1F95Pseriw1ifyTC89Z4nvhNKRq8zYU5UvXc=;
 b=nmh1x3c5ddYjlqFTbKUQFDoYtxG4r22pBYUxTZTQIFBNWGc0CZQt0ubwGp9xsXqjyK
 Oe2rUpQwv3b+VsZyY7W+wAtvvmXYAUSaeEbWBcXGSJhdZiSVv/ke3eykib7DiLGLHvxL
 H8JgfFKyuMLcmjxEJM3rtzprMpu/ArsDSkHj8VFX81uzaHnn3VVGE3Ku4SgkzXk40tXp
 josQotXIbFf9FGQo2i/PZ9pb8MroIc7wnv1l1JfQHBh3pH8uuxYtx9qprfRAsaevz468
 bWUJNQOJs2ZoC1/cDUFefywqJgrn4AonTjkyTMllP6aNQ6Et93JAWvjd6z0A2jmxJ+z6
 68Lg==
X-Gm-Message-State: AOJu0YwCKpyKJj949oA7Vn632FM+43lnfS8EARo6lJEqvCQeLeqkIKm0
 iHq9F6e61Wp3qFg4b6h65eEvALMRkdkk+mWHETMh1hldOQ1V0utrVQarauaJPRsIQof3JDB8FoT
 LysXookifiduRCpRBMhTUz64UgLB7UQ==
X-Gm-Gg: ASbGncvFnFXQui1kgl1D7I/2AxTiMyYX3nHcuZE9ooYeeDXuXQffbAZhPW4bsIZCU9h
 dqRynWPj2DFYiK7Q88USYKpcv2NHMgT7D3V/99uaS6LyE3yzWpKwMIyABG4w4xNIcCD5EJpZ5kS
 hVh6sVJQMr/SMS6HJ8+lsbyQ==
X-Google-Smtp-Source: AGHT+IFcVabgbblpTy8M45Wzwb5bYXu62BXK12ZfSB+zUNKaOzZO7K9lyW1mEJAgbLrdkXWpmukP+CYsrSkW8Q0E8oE=
X-Received: by 2002:a17:90b:1d0b:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-3087be020admr8955827a91.7.1745354595938; Tue, 22 Apr 2025
 13:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250422201104.639320-1-Amber.Lin@amd.com>
In-Reply-To: <20250422201104.639320-1-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 16:43:04 -0400
X-Gm-Features: ATxdqUGWlgKg678ac4s89XZoMcyOO9y8G_WdtUp5wC3pyRBeEUA1tcZaqZBLr3Q
Message-ID: <CADnq5_MrHhPUCbsHYUhEkFhGT37n1hmgFuEpdfiMJgVfUJD8mw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Set SDMA_RLCx_IB_CNTL/SWITCH_INSIDE_IB
To: Amber Lin <Amber.Lin@amd.com>
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

On Tue, Apr 22, 2025 at 4:39=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> When submitting MQD to CP, set SDMA_RLCx_IB_CNTL/SWITCH_INSIDE_IB bit so
> it'll allow SDMA preemption if there is a massive command buffer of
> long-running SDMA commands.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 80320a6c8854..116932a20b3f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -495,6 +495,10 @@ static void update_mqd_sdma(struct mqd_manager *mm, =
void *mqd,
>         m->sdma_engine_id =3D q->sdma_engine_id;
>         m->sdma_queue_id =3D q->sdma_queue_id;
>         m->sdmax_rlcx_dummy_reg =3D SDMA_RLC_DUMMY_DEFAULT;
> +       /* Allow context switch so we don't cross-process starve with a m=
assive
> +        * command buffer of long-running SDMA commands
> +        */
> +       m->sdmax_rlcx_ib_cntl |=3D SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MA=
SK;
>
>         q->is_active =3D QUEUE_IS_ACTIVE(*q);
>  }
> --
> 2.34.1
>

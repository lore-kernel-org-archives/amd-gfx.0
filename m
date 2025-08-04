Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD10C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E95A10E58C;
	Mon,  4 Aug 2025 15:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GE21Myxl";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BE510E58E
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:21:05 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b3f2f8469b7so464801a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754320865; x=1754925665; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhwYFnkLI+C2OORRE2EoEdcjCJEPI5tdEv4OIDNlwZc=;
 b=GE21MyxlVRj8NS41qlW4HzfMfpPqzN6syjoYAuKiewiAh+olt4QvvEN1wdSKAJP2ji
 JAi5W+BXrldhZSrmqmSCy0J/noWHFEkutUqv03dHWta7XY6tjlE2Xby9+b5UkF51iInc
 xAEeSKgKtZpeOSGMxUFyo8KDmieySOWypJ0hXMGK1s8RMWf5m6Nc7CCGgIRtlQr60Tju
 pTZfHYLZE6pQSBcv/Wy4SeDfIfT5bKS0gbDQFLU152zNmMWwtDCVTJXRCjc0q52LS+mU
 +WNFoxdrkSqRHjP8qvz+2m2zPWpL2Oo2ZrK0snv4hD9F/U3hbVQghFJJ4D+F3wM51Bp/
 Kqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754320865; x=1754925665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhwYFnkLI+C2OORRE2EoEdcjCJEPI5tdEv4OIDNlwZc=;
 b=su9aLPRZAOQVqONAfvSa7/z1VUDoLOkn+zzZR4Nkk7e5sCs9XDYE27R9EjgoQXN0LO
 UuUW1CXmFUkh0ifZasmU9vNyQRLwtujgu9USWZF7AfASq/xusaLArjHdJOeFBSdey/WK
 aGjLMjuTmDIsbrbpazKfu7zmSG0P62N8dZe4sLmqMqQprRHkIx5ykHejv7lzoYC98Dhx
 y0Ca7796d7xzHUj/ei9kxCx8aBDDtIVcfWKjXYmdYeLy1+Fvsov+sVHaidaKB00ghjph
 EqZM4iP2AUDGC0Qyf3Cy47w7vKq+qpJ4/iwIgnH66Viy7S4cGMvtp14nEN5/PqnMrBKF
 XIOw==
X-Gm-Message-State: AOJu0YyrLGAj9R6R81jcoTnNRONSsGVnZbzvgzYCZPVk9krs/td2Lg6z
 T3qnGd4VEv4Qbrde5/XAXqsZoEo8JQqWqew0EJ8czR/WKxSxKRDYgVYGV4TxrbcIY+UAWy9WpNz
 v2DaRrckqSx+YQHpmS633BnX+yu6Ottg=
X-Gm-Gg: ASbGncueeGImN3HOtK3nnIfOr8ndDBLzGJWO9QvwH6JuWCpt0KUcKHpVpmsveYGpa/s
 BZecZ+J7tz1P4iyrxXP5DVRuYF403kaV7arRyyrDB7hwQYBB6STwHSmjblcffu0nO7d9ePDiLZH
 S03wEAYf+8FcJUKQyZUU58oC08Oo7ymOzJucYCODtlJ+bRBDJyglTpHV+Qj1G376l9fekUYFb0v
 oVJQov7
X-Google-Smtp-Source: AGHT+IEWRCMj4oH/i6QBOuwIZB0PzHMKIVA0G7Z2UpLGakz2mqtvOwMWcRrMcnKDRW1L4fXMzeAMwW+AEkHgwYJcQRs=
X-Received: by 2002:a17:90b:1804:b0:31f:55a7:6504 with SMTP id
 98e67ed59e1d1-321162c71c9mr6372347a91.5.1754320864574; Mon, 04 Aug 2025
 08:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-2-timur.kristof@gmail.com>
In-Reply-To: <20250804134154.95875-2-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:20:53 -0400
X-Gm-Features: Ac12FXykWuRDbeO_XgDPR7QTq1drc3SALID9ol4cDsWjT7DEIYt4Sml9RN38abQ
Message-ID: <CADnq5_O5F5UAC17CE4mwOx_5pbTKzv73Yuj=-_cA06G3hQeQJQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: Power up UVD 3 for FW validation
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Christian Koenig <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>
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

On Mon, Aug 4, 2025 at 9:58=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> Unlike later versions, UVD 3 has firmware validation.
> For this to work, the UVD should be powered up correctly.
>
> When DPM is enabled and the display clock is off,
> the SMU may choose a power state which doesn't power
> the UVD, which can result in failure to initialize UVD.

+ Christian, Leo

That doesn't seem right to me.  IIRC, the driver always set the UVD
PLL directly on SI and I don't think SI supported any kind of UVD
power gating. I guess it's probably some sort of subtle sequencing
difference between radeon and amdgpu.  Unless Christian or Leo have
any ideas, I think the patch is probably fine.

Alex

>
> Fixes: b38f3e80ecec ("drm amdgpu: SI UVD v3_1 (v2)")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v3_1.c
> index 5dbaebb592b3..9ad06c1e150d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -633,6 +633,12 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *=
ip_block)
>         int r;
>
>         uvd_v3_1_mc_resume(adev);
> +       uvd_v3_1_enable_mgcg(adev, true);
> +
> +       if (adev->pm.dpm_enabled)
> +               amdgpu_dpm_enable_uvd(adev, true);
> +       else
> +               amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
>
>         r =3D uvd_v3_1_fw_validate(adev);
>         if (r) {
> @@ -640,9 +646,6 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *i=
p_block)
>                 return r;
>         }
>
> -       uvd_v3_1_enable_mgcg(adev, true);
> -       amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
> -
>         uvd_v3_1_start(adev);
>
>         r =3D amdgpu_ring_test_helper(ring);
> --
> 2.50.1
>

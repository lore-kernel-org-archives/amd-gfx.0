Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B5CCA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 15:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06B710E46A;
	Mon, 18 Aug 2025 15:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gw9ky8mM";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE51610E46A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 15:12:26 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-244581eab34so6675345ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755529946; x=1756134746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TaIdqLWY4uvnIsfVfVUA/b9+36jN6iclxytoYTyE68=;
 b=gw9ky8mM6hUOucpJ+Ut4qVxjIRJ86nWUf/dAhcCUJU+I40OnNPk159Q6WdjI1DDSnJ
 FpQKGPpO9XUoGOTW69UqCmTfauHFuITMPNSkIfThYbm4ZemApaFoIJIDKtyBWC1IOV3N
 op2k3U628va8g90lZ3br5S4l3TAuqBQqHvH/6lApFjT7ZKHJIM88CTA16G4Bo0jLozjV
 Kw6eQYLeWbnqUmMNnzaxYJsV6MslYUxKAQaM9/U4GUFHfkrhkLqwoLSq68EcsMaTJ0GK
 xB5m4A4WLQuENfObNfkVCmT37ct86LOPZ61WCIwaD3uprQalaQDMPC8iPyeHVwbbqpGP
 17UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755529946; x=1756134746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TaIdqLWY4uvnIsfVfVUA/b9+36jN6iclxytoYTyE68=;
 b=LosLAJE+cz6i0GCVQHLnBYOhGKyyHfd12yLhyGOQcep9nl6xaHjdg1huZ94XNDNKt0
 AEDn0Bg95YB6BWr6p2QDZ5KpPfIz6e58w48c9fSLb/40/M4VVGKjaPrs0pfSj0Ztcf7M
 5EnlerZmpi5E+69Oonjcbwp16BDljq8+o1YQAR3Jw/lqi6QP6GF9FYVp/3v0kOtCqov/
 fJWgupmL+G7/pqXwX0Pr5vNvUn16jxkUkftJf2pGVq3OPtVVlynrC8RaHUwZ/vjsuIvw
 KGzjc/YvuPs4Ep5zk46p74bxiu54M59aPPG47q6xGIEQsaJtpT1XAF0jbyogCbpBsEhm
 dAqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV87aoW2FTPBUD2XO9uOermFLHo1yijM5wGqx1LRc66gRf++Hg6scV3ZuAIig+sTTCj7/WZtewh@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywgy9U5lbix4doL2UuO7qdY0giT129dZeBZAyDLCzprkQbHhK6l
 cLN4FVK93kG//XGHi9Eg19Zui6QxpEPIDa1FDKZ4E8QNcinpWIQVYftsi3AOHlelLIg8useRaVB
 vmSZvIBQeFknoNmtDyqTFfU0Fl+QIi0A=
X-Gm-Gg: ASbGncuM8e5JQtIXq/zm160WVbAUvRIDbacMpaJgCvaWHl8znQFMg51TyXFaNoNnL3a
 Eqr5Qungv/BUBS2usQsVKds/lytPZm168fuzb4PQAtWMWi6k9CClwUz5+8f4J/KfdWa21tlbXAO
 PyXlrxmNJEqCDC0j4YhPb+gslJHdTDCcpLejGDo6he9mBwKSjGPLo6VKMCaNhGtNs+GtjSYBRFI
 7k+trr0IefGzBmAExycV3g4mFap
X-Google-Smtp-Source: AGHT+IFcmPBVUjHPMULQ0KJNSygTOADBuixP3rA7RoN4xjp+abtVTQ6VrT1tWnhvb722L2i+USm7sR379RfSjJVjEv4=
X-Received: by 2002:a17:902:f541:b0:240:9ab5:4cae with SMTP id
 d9443c01a7336-2446d5d6193mr75431925ad.1.1755529946358; Mon, 18 Aug 2025
 08:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250816162806.1301791-1-siqueira@igalia.com>
 <20250816162806.1301791-4-siqueira@igalia.com>
In-Reply-To: <20250816162806.1301791-4-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 11:12:14 -0400
X-Gm-Features: Ac12FXyS9_oqvRjg-Wc5XGntDtD-b27Y0cKgOg9nWo1pWsiRQNEDOoJNHhDQ0zM
Message-ID: <CADnq5_NjHx0te+umOUo=t5c-79yjDVrRQjkFiLsAX6RppepSEA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/vcn: Ensure that sysfs reset run in the
 fini
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Sat, Aug 16, 2025 at 12:28=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.=
com> wrote:
>
> The function amdgpu_vcn_sysfs_reset_mask_fini() in the
> vcn_v5_0_1_sw_fini() is invoked at the end of the function, after
> amdgpu_vcn_sw_fini(). This can be a problem if amdgpu_vcn_sw_fini()
> returns early, since the VCN reset sysfs interface will not be removed.
> This commit addresses the issue by moving
> amdgpu_vcn_sysfs_reset_mask_fini() above amdgpu_vcn_sw_fini(), aligning
> the fini code with vcn_v4_0_3_sw_fini().
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_1.c
> index 7cb21e2b4eb0..3b7372861032 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -245,14 +245,14 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>                         return r;
>         }
>
> +       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
>                 r =3D amdgpu_vcn_sw_fini(adev, i);

This function always returns success.  I'd suggested changing it to a
void and dropping the early return.

Alex

>                 if (r)
>                         return r;
>         }
>
> -       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> -
>         return 0;
>  }
>
> --
> 2.47.2
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CD1C71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 14:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB6210E1EF;
	Wed, 18 Jun 2025 14:18:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBF0xML4";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C631310E1EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 14:18:18 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-313fab41fd5so886249a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750256298; x=1750861098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDKrFfoJJDjceBBR7frHRGMzMsBsxvJCWnlynxKnqYg=;
 b=IBF0xML4BWE6vJZFtM/Ucml2w1wxvWYqEg4/rgZdq0+N31JaDJRJDukME2+3NeNcFU
 /WZOGj5qcvAK27Om/sKD+dDoPsjyHMDAK24pvzc9YkSZpSSmitDdEKF+AFvAujG1Y+zN
 FZK/697bTvs7sInXp8odCy10FWoApFAiFsRkS49i/pX+LPH0CTSpUZY7RUEHnCOBiroQ
 SebS4PpdvUOZPrPWU8ZMSFEvhSu7qS9PslV0eTfGvpYvSYmKZO/imLVtRvmATxYVuobj
 TGs6IoVd1wJzgjghAu4v7fECKFoeljONg/aG3sp3GtM2Y95sjnzB3F3zPtgRqm8kcJOY
 7CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256298; x=1750861098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDKrFfoJJDjceBBR7frHRGMzMsBsxvJCWnlynxKnqYg=;
 b=oC0/kkOd26tkhKqVg6ntBBCORHXP4EQmq5CDO0Ejvs0v3B8qfc69E+doLMLvhJYTgl
 ewbTPeAKBpn5A5Uhks0D2vliUeuYkPdxNx3UbzoVFNDmRjptPkYbwz8a8hTbUzs4W+DR
 Wb8bfOKAVXwvlDmslgqlMNxJFc2h4N4cZ8o08s3V8OlTUNwJwk8dWKnN/EuvdAPU9gdH
 /EPGDmE1eV51PKhIjDFmgP6C6aE9FUPINFMe02ts7sLUr9+CprGKiJ0/xA3n57qRfbUq
 psiuHvQOecMCmNZ3kNTfK23FHwCXTS4cMqWpdd31aTzJkOS46gJaNipTQ/mG7ZAzF4dO
 xUlQ==
X-Gm-Message-State: AOJu0YxrsxlDScUdZS5HUxOzNfzoHce1O2nZ52/PHT518VPb1dO78rVi
 1r1gJeWz4tY08ZLMQ98pCufgl00+/bZUUbjP432LKHGKAZQqFOFwsvuX/xrzS1LJItLNduVIuZ7
 VmgRO/mm431jjKgEi6j7rlcDKoos5kNJnxQ==
X-Gm-Gg: ASbGncubMngFxetlg4IvuSIdQ2U/BsdTAL3eLtYuSIwYooyKPCzBKK5HFsK+9tCEb3I
 jmEPf8pkPEtWz48UKkmw/IyA5Yg2ltLPS0kIc6g72Qv5K5huW5zLtbqsEOb3HbWi0bSZO/BAb6i
 n489AKxXDbUVrBoKkQB+7vosoXJNbFEjoVhMRX0j6y51b+
X-Google-Smtp-Source: AGHT+IHx7qbEV4yuwpWza3/T09hGCkdBg4kRgHFE5wJeeTP9IfItg8qNQ3JBAvVSJtoUZlnOAkmy6nS8FEwaleBhwVQ=
X-Received: by 2002:a17:90b:1fcd:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-313f1d533d2mr9775681a91.3.1750256298137; Wed, 18 Jun 2025
 07:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250617163534.68610-1-alexander.deucher@amd.com>
In-Reply-To: <20250617163534.68610-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Jun 2025 10:18:06 -0400
X-Gm-Features: AX0GCFusRZVLhLS1kjDe3sz4MKVm3c-quAex2D0ia0XdFLwPBBEJZD1GMnu-O8U
Message-ID: <CADnq5_Pw6Mik2Ewn_FjHk3DvnKvtGOCe5t21F9q4d7iBdrr8NQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: add compatibility checks for
 set_hw_resource_1
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun Liu <shaoyun.liu@amd.com>
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

Ping?

On Tue, Jun 17, 2025 at 12:47=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Seems some older MES firmware versions do not properly support
> this packet.  Add back some the compatibility checks.
>
> v2: switch to fw version check (Shaoyun)
>
> Fixes: f81cd793119e ("drm/amd/amdgpu: Fix MES init sequence")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4295
> Cc: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 10 ++++++----
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c |  3 ++-
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index c9eba537de094..28eb846280dd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1630,10 +1630,12 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         if (r)
>                 goto failure;
>
> -       r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
> -       if (r) {
> -               DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=3D%d\n"=
, r);
> -               goto failure;
> +       if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x50=
) {
> +               r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
> +               if (r) {
> +                       DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=
=3D%d\n", r);
> +                       goto failure;
> +               }
>         }
>
>         r =3D mes_v11_0_query_sched_status(&adev->mes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 68bef36aae3b8..4b78e05a4615e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -1736,7 +1736,8 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>         if (r)
>                 goto failure;
>
> -       mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
> +       if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x4b=
)
> +               mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED=
_PIPE);
>
>         mes_v12_0_init_aggregated_doorbell(&adev->mes);
>
> --
> 2.49.0
>

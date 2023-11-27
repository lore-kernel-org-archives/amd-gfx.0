Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2948EC4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 18:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37C710E3BF;
	Mon, 27 Nov 2023 18:26:34 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C6810E3BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 18:26:32 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1f060e059a3so2746438fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 10:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701109592; x=1701714392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plwh0z68EP2ibkNA9d0nsdnBLQSJZk2+HGFawsIq924=;
 b=lATO/N7ENq8GUdbEDAA6GBdk5g6HDRPddE+Fu46deYTZbMvDCUOQYP3shVAw+ZEq4m
 Jt7wXPiQM1rNJjoiRsh/Xk4VJlLIZ6zKz8BRxjaWwMA4PJ3NlX4eITQ1u1vVwrDNps14
 Q8HzKuqSAmxWXoZNBzQYpDtw4R9e8B+b1ZoAiVkxwbk6f2Nphu60gU3J0eTwOUFQliJy
 tjQDRGxBflL0f1AylyRdq6zs47lkO0JGmjdqA0zFfgt4i/RduRjj7F99c0UUJ0e/T1Cx
 gwht1VwOiP2dUyELkrVrzQg50rF1Rr2q4luy2/1y/EeGbq4vNPVHuDDDBoOJtUfaU8Sj
 6FQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701109592; x=1701714392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plwh0z68EP2ibkNA9d0nsdnBLQSJZk2+HGFawsIq924=;
 b=Xu2+h7/LtBfO/No8T4wWrgNo7BrzpRxB+hFnf0v3D7G4LsWAVP+zzG4nx4xhFXuoVM
 AkN1V1QC5c7kLPMRIyckQVBSOfmwjTmAWbP1D9crJUcT4dOhdCiZND1fIBgDWbmPpag8
 dqEDgwdlGnlbGPDiUUVNqsaoMX4ZZHAVLwrOQrERDT51TN5LaKrVgvRi9u4aLZWcKWBa
 /XW6qpJqeUX2mRoZ1IUG2yv1LB7+7sFLvyqkI3ysjyknC6x4WAHVdDJfnUQ2YyeFS73C
 dU0AZfMJQzqDknzQytJa23mSHQZN1DAvkrqJ9P9OkRfgD+ZVKvOLv9Z7qRByW0ftvg2d
 YrKQ==
X-Gm-Message-State: AOJu0YwRqyv5RS1G7H5REqBFnHHZjRh5pTUwcXtd7JQxOQ9jd5+du+EN
 lTOQ9rTyR8ozHEEVcqLmLsnK759hZy9N+0E/5UsjWEfv
X-Google-Smtp-Source: AGHT+IFJ5Kse/vHapA+Xgn0/SNZcpCiudweYVjy2aeDN23eHapY+KfzNq3vwyYU0aAAF8q1LIdptzpG4v/m+qCeU8GM=
X-Received: by 2002:a05:6870:5ba3:b0:1fa:3be6:3b2a with SMTP id
 em35-20020a0568705ba300b001fa3be63b2amr7135860oab.30.1701109591972; Mon, 27
 Nov 2023 10:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20231121150556.84900-1-alexander.deucher@amd.com>
In-Reply-To: <20231121150556.84900-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Nov 2023 13:26:21 -0500
Message-ID: <CADnq5_OVyZfPu7DUJGP23Mxvk22RBXSmJxFCFAu9=EKKtnrMXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: check if AGP is disabled in
 amdgpu_gmc_agp_addr()
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 22, 2023 at 2:32=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Return AMDGPU_BO_INVALID_OFFSET if the AGP aperture is disabled.
> There is no reason to check further if the aperture is disabled.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Ping?

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 5f71414190e9..0f85f906791b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -181,6 +181,9 @@ uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object=
 *bo)
>  {
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
>
> +       if (!adev->gmc.agp_size)
> +               return AMDGPU_BO_INVALID_OFFSET;
> +
>         if (bo->ttm->num_pages !=3D 1 || bo->ttm->caching =3D=3D ttm_cach=
ed)
>                 return AMDGPU_BO_INVALID_OFFSET;
>
> --
> 2.42.0
>

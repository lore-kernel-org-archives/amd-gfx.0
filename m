Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD77C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Dec 2021 13:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9085910E376;
	Thu, 30 Dec 2021 13:59:12 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899F210E376
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Dec 2021 13:59:11 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id j185so39944902oif.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Dec 2021 05:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MUjPeo9N/1c9jHoSKmTm+wDTo1zoLpobgzvrej9MI1I=;
 b=RF3ymsGKBDDqIw072tPuc7I/8GwHsrttyADooVec3iRSWT5JqxLdJffiIeYA6lv5S2
 ltWfQ62b0Y9muHIdUoUmrph+WEiLbc+AEsUGZg4jLprxGfo2fIwlIhxCgEch8EV8/9Uv
 Lx+bxHJtQSNUO+N4qvN4x4Us2etvg4goi+6qqFpxeqV0FgMCutK3HTYmIaHmJf+3l/OZ
 Sup/T9TIqZML4/Wk+Tbmk7PJ5THX69umMpOkT5MITg3a3wjX9E7DkIi8JeV6/f2kAZJR
 cHQ4My1zxIKNmw99IfJ2ShF5uWZb98gDi/Y6JECVSf7GK+1grciTqlzih5kmnBA4U6MU
 UL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MUjPeo9N/1c9jHoSKmTm+wDTo1zoLpobgzvrej9MI1I=;
 b=ngGLgkoyw2Uc62LPn1oWrAs6iHsyzn0Yw9wt6YlJKIWhcuqzXc03Ol7bHrliOBqb8+
 dr0T+zK+nES35xj+q8I+peF7A3jnWUfwO2w1wPbW7DLKm7JRdSS9Y5AtY7AVUe6c5FRa
 Cm3Ay6fY4jugHT5YCtsXLPyJwVLaF2AJzOiC6h2j4Jk4ZeJisOsyFe9UpUrcLeP64ejS
 SbWIvErlM4szwLV98hvc4YZ6s3XWqlSs/ohrhDC/RY+8VosFhkFXX/Nom6WkjMKyVymN
 7LfxXz/laBrpX+PE3ZPDvto02M11uRuzKIszbULhRVfjGemJTgGPvEfKlttPsDepSRj+
 kNuQ==
X-Gm-Message-State: AOAM533UigcbCMrdaYiz+3ciTnqSs2osSnRlCeCK672IDekD4bxPyiZm
 RbdNNJNrTjrKDeYU0v234Ru8vRxq7xCfKJ6foOlRFabI
X-Google-Smtp-Source: ABdhPJxRICo6y8YOpR4Z6Lw/vxJwMKcoFRsGmD02ttHtjfDlyyY7AwxtHRstCfZspZJesmDBOXfh5chONPEXJq3J9SA=
X-Received: by 2002:a05:6808:4c3:: with SMTP id
 a3mr22693532oie.123.1640872750912; 
 Thu, 30 Dec 2021 05:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20211230100114.2171135-1-evan.quan@amd.com>
In-Reply-To: <20211230100114.2171135-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Dec 2021 08:59:00 -0500
Message-ID: <CADnq5_PYW=1fYgrvsh+kLT7CLaLQfke46fH1iKqBO44K3btjGA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: keep the BACO feature enabled for suspend
To: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Dec 30, 2021 at 5:01 AM Evan Quan <evan.quan@amd.com> wrote:
>
> To pair with the workaround which always reset the ASIC in suspend.
> Otherwise, the reset which relies on BACO will fail.
>
> Fixes: 50583690930d ("drm/amdgpu: always reset the asic in suspend (v2)")
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I39ed072af16e34ef1e1c16b50ace6d46fbc388b9
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 4d867778a65c..7628be2f2301 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1308,10 +1308,16 @@ static int smu_disable_dpms(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
>         int ret = 0;
> +       /*
> +        * TODO: (adev->in_suspend && !adev->in_s0ix) is added to pair
> +        * the workaround which always reset the asic in suspend.
> +        * It's likely that workaround will be dropped in the future.
> +        * Then the change here should be dropped together.
> +        */
>         bool use_baco = !smu->is_apu &&
>                 ((amdgpu_in_reset(adev) &&
>                   (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> -                ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
> +                ((adev->in_runpm || adev->in_s4 || (adev->in_suspend && !adev->in_s0ix)) && amdgpu_asic_supports_baco(adev)));
>
>         /*
>          * For custom pptable uploading, skip the DPM features
> --
> 2.29.0
>

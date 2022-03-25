Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB00DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 15:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4895F10EA17;
	Fri, 25 Mar 2022 15:07:55 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2599210EA17
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 15:07:53 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-de48295467so8409555fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KfZdmPfA/537M1sofksTUA3jzMD9Ur6vTeH/OnUTPA4=;
 b=hYLj6a1lizUM2pN4IBJz18TOMHmisJ2jCQHVcsG3pG1MppsRaCcWyyXBjvq6CIkYTj
 wGHYrtCsxITGMC9eYvKkfFaW5/QDwRmAzhEsstp4tHet0UUCp4t46WuvhOT1CPqPcKAE
 9R68iZoh1MiNP4YYrsGWBBkmT9cgtO7nTgavAR5NryXI47k+wxEKN9JJqsnEhwdPNpkS
 g5RhjaXuUa+fc+fHJWKmtkS/4OhLsV0KnoM/QgbdHPO0Unkzm5bTGitfY/658HjgUNNw
 9ND3AMiVupLRmMr260pHWW8O1ZzUS340kgjfcRU2GLL8Z8b/Ff/80hYsfVF8I/3B44xe
 qAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KfZdmPfA/537M1sofksTUA3jzMD9Ur6vTeH/OnUTPA4=;
 b=RHfVbBHgDGzm3k8SuDAkPYnokh3Of7+F+3b0kmuncMV82blJiVBWd0ddpxE4gocZJ8
 5djJVDJyFwJp0NjQZyFsaD0KvHvw+KTyQMgtXkXFZph78B7s0Mzyz8mCgFRijiRgNJXf
 Y9OHMrn6mulz++OKjgb2L9IZRED/ieaW8q8iYccRzXus4YXrP7vyU83KSgTqpJYlUZuk
 8jq+OS/qlSuYp9Lin5aaJ3sHoH5FnEQIsyoV+VcZ+yqaqa/CHmUuVEGZTb6SjwC+uApk
 GTyFdXuPTFEw2fH0RwdLm1lakFvvnk/ajd8RTEB4nmw6L5WkSrzjWjdCugEvswv2YXvz
 d1nQ==
X-Gm-Message-State: AOAM5318ouHccwxWe4sxmL4JQ6zZM06m8BzAb6hoK4BOmAi9pW9MeD2a
 isALdtezYfEcGGIUBnJWlbO8sekabCFqKODrnwo=
X-Google-Smtp-Source: ABdhPJy1zCp+Q/idrE3zYP3VH3dsYMF1D1iJ/7T4gGieMCuIOoFmhxbYgWmwg5EAGGlfCc+hk/HoRj/HUqpC5BKLfU8=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr3057082oaa.200.1648220872376; Fri, 25
 Mar 2022 08:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220325142849.2541-1-Marko.Zekovic@amd.com>
In-Reply-To: <20220325142849.2541-1-Marko.Zekovic@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Mar 2022 11:07:41 -0400
Message-ID: <CADnq5_OW6yw0AOKx1yU3dRjihG0a7ssVTf-tNPhvwBBob825+w@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/pm: Enable sysfs node for pp_dpm_vclk for NAVI12
To: Marko Zekovic <Marko.Zekovic@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 25, 2022 at 10:29 AM Marko Zekovic <Marko.Zekovic@amd.com> wrote:
>
> SMI clock measure API is failing, because sysfs node
> for pp_dpm_vclk is not existing
> Bug:
> https://ontrack-internal.amd.com/browse/SWDEV-327254

Please drop internal bug tickets.  With that fixed, assuming vclk dpm
node is actually supported on navi12,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Marko Zekovic <Marko.Zekovic@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5cd67ddf84956..095cf57d73de4 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1999,7 +1999,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>                 if (asic_type < CHIP_VEGA12)
>                         *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
> -               if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
> +               if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID || asic_type == CHIP_NAVI12))
>                         *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>                 if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
> --
> 2.24.1.windows.2
>

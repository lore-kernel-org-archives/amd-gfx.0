Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E4BC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 14:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE837AF83;
	Mon,  6 Dec 2021 14:37:14 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D331B7AF85
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 14:37:12 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 r10-20020a056830080a00b0055c8fd2cebdso13810617ots.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Dec 2021 06:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n784m6kSx/lD+9lLxwAHdhWO3wsLcYMlng56Qvr566g=;
 b=a5baalJLkcpNC38PM1oeEYxnlMjej0cWBd1Rlg/zvqNdbW3IOAXRCZBqTQLgI0WJmv
 oainHznjc1mZAt1eOyAQKqtMCf0nLeNyy5DxXj7sJxjreqHgctQutQ/1cRj06gDBcqSm
 0EqVrlJEJwrBhaM3Zu2/Lg28g/p1qSn+3tlGzGojjWfzTg/ZPMOdE5XLlUYokblv1U5z
 Zn6TDzwPibRzrBzxlDFuyGLp47lfG2GkzrfatkIi7Q2PDwO1URSAlBqShh5DM8CrDUkE
 ozBdphY1jU/9v5qu6qgU4K48yxcXz9HpbwbwsbsXgICRjZ37cI6nZK5u8xnfOAWd78uA
 Oxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n784m6kSx/lD+9lLxwAHdhWO3wsLcYMlng56Qvr566g=;
 b=Ng70Yd+q2pop5JS5GZggKi9n4LSm0TjgRGooAs/4UG0USo5EUsAE5MTiU3sJORuWzc
 kzsJEidIZcsr5O9wneN9kymyARadbWQbp/ERFTCZfvHlAGhw9sb6GNaRrfxSEdsF6Rd/
 XLNgPj+DMtwDE8eaWu6FaAeEZ9yX5FO7m3QctaakverRNsKdGh3DGsWOH5qJlUVT2AIs
 DAKiZLOAni/6k1foS+ZaTAjbCXC6QCyF0endSIqnRwjhZBrcy0SSfvp2jFUT34s3Mdqc
 JrIglbVhONaHdpcEitsnWlZ7Wjwhjg4zO1qz6yVpvZYtNRodCsa+VShEb681GtBF1h/G
 vsXA==
X-Gm-Message-State: AOAM531dYYOVU9yA0aknWgrcVrUBn89Vm5bq0uZrRc7pC1DyhuBm9dvi
 nRl23cDRm017zGDBgInrlLzDTonJ7vIum2LTz+I=
X-Google-Smtp-Source: ABdhPJxJSWKuBeP7N97tFcPpxmGYrZjWhFXl3uvlG6YiY+YhExQgjfhPS+UO8jjHIauwK13dvfHDa7kevsplObmocIg=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr30866913ota.200.1638801432059; 
 Mon, 06 Dec 2021 06:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20211204110226.15556-1-Le.Ma@amd.com>
In-Reply-To: <20211204110226.15556-1-Le.Ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Dec 2021 09:37:01 -0500
Message-ID: <CADnq5_PwTd0rjk-2kebEih0yWtDO+EreNd3aDO4y-Us=PR0_QQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: correct register access for
 RLC_JUMP_TABLE_RESTORE
To: Le Ma <Le.Ma@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 6, 2021 at 5:23 AM Le Ma <Le.Ma@amd.com> wrote:
>
> From: Le Ma <le.ma@amd.com>
>
> should count on GC IP base address
>
> Signed-off-by: Le Ma <le.ma@amd.com>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b305fd39874f..edb3e3b08eed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3070,8 +3070,8 @@ static void gfx_v9_0_init_pg(struct amdgpu_device *adev)
>                               AMD_PG_SUPPORT_CP |
>                               AMD_PG_SUPPORT_GDS |
>                               AMD_PG_SUPPORT_RLC_SMU_HS)) {
> -               WREG32(mmRLC_JUMP_TABLE_RESTORE,
> -                      adev->gfx.rlc.cp_table_gpu_addr >> 8);
> +               WREG32_SOC15(GC, 0, mmRLC_JUMP_TABLE_RESTORE,
> +                            adev->gfx.rlc.cp_table_gpu_addr >> 8);
>                 gfx_v9_0_init_gfx_power_gating(adev);
>         }
>  }
> --
> 2.17.1
>

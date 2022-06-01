Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A278BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 18:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4290B10F348;
	Wed,  1 Jun 2022 18:46:59 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B8E10F348
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 18:46:57 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id s188so3806390oie.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f7ePlvGaUoiv82uA9fpuHBehewbB/3wH4W+yDdmOpHA=;
 b=DDVRbcMFzfyNGPLs5L/1lRUcvNJSv6thmJC587vtTCPHFlkW2aVM0mpp4WEBDguSor
 a33xCjJgUrldnEEVH0ZWoyIs6kTck0Z+p8e9Y3LApZkiqeaxBeLOzJj1F8XE1fY1fIOM
 coymLeDr+CC/J0z9ydQ3MePb1YsessvsfZY/QRP6fknIar/KV55K6Es3SqfrIY3KMTPC
 ca6cOTwiZIG0LYaGXqm4Km+tN5PGvBcdG+niEDJ8RT0/jU4zlUyc3kNScQ/QYIAqgsY5
 U217iUx0KatCO+p0L+5nZ96G2vNb2iisnYYL8yXNy8RFAhBcYribTh4GLeDmkdsIjnBx
 9irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f7ePlvGaUoiv82uA9fpuHBehewbB/3wH4W+yDdmOpHA=;
 b=v7VEh4v/MHmJJLacgWlncV8q/EuHLfNMmzHl6Jr/4nAe25UrmOOPYg1XNW3zFSepmf
 EDgYwobrFyODp/SH8ZSysO3cgGmR1dDOPM3ke5eytWKxx3sOS0KL+JEFMp9fJ3B6JVOB
 Der+aJfdoQ5CESAXEnQzadKKwOfoHogIs36Q8ftC8J0DssdyVdR97Ni6ZLScMDXqi5Qc
 xhXV6jRsDGHyOse1CwJv5xOsWu2CnpOTnpmNxFEqUVRlqpvy0dBVBIOTQkjRCahAR/Fa
 1BwtFD4L8A+31yuHJm0eLk9dvpq4nCJlDQExD5OHKKI7+Ud/ykbm6Lapr2fLZCNS7HvW
 4QVQ==
X-Gm-Message-State: AOAM530FsTS3IgEYDMIFwYgq7SbOThj1SdzjmAjnHjGIPY3np72JORuJ
 i5+lODxcbi72RmKpC5SyqVg8XpiGiBSRSXe1mFI=
X-Google-Smtp-Source: ABdhPJxjJHA+rxXyWyFeIboan8p/bOHZySJWVhCoyvwvl+KpJjRB1JzNsA5WJWYD+2Wou4pggWMJfWMjaBJcVfa1O2s=
X-Received: by 2002:a05:6808:15a7:b0:32b:aeac:84d0 with SMTP id
 t39-20020a05680815a700b0032baeac84d0mr500009oiw.253.1654109216989; Wed, 01
 Jun 2022 11:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <YpStoW0tbsYOg5Jx@kili>
In-Reply-To: <YpStoW0tbsYOg5Jx@kili>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jun 2022 14:46:45 -0400
Message-ID: <CADnq5_O41CK=0+OHfXQt2iUxzhQu4nE1K=+J3OXOnTtVot1ijA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: delete duplicate condition in
 gfx_v11_0_soft_reset()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mike Lothian <mike@fireburn.co.uk>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, May 30, 2022 at 7:42 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We know that "grbm_soft_reset" is true because we're already inside an
> if (grbm_soft_reset) condition.  No need to test again.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 8c0a3fc7aaa6..4bca63a346b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4780,19 +4780,17 @@ static int gfx_v11_0_soft_reset(void *handle)
>                 /* Disable MEC parsing/prefetching */
>                 gfx_v11_0_cp_compute_enable(adev, false);
>
> -               if (grbm_soft_reset) {
> -                       tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> -                       tmp |= grbm_soft_reset;
> -                       dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
> -                       WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> -                       tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> -
> -                       udelay(50);
> -
> -                       tmp &= ~grbm_soft_reset;
> -                       WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> -                       tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> -               }
> +               tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> +               tmp |= grbm_soft_reset;
> +               dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
> +               WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> +               tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> +
> +               udelay(50);
> +
> +               tmp &= ~grbm_soft_reset;
> +               WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> +               tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
>
>                 /* Wait a little for things to settle down */
>                 udelay(50);
> --
> 2.35.1
>

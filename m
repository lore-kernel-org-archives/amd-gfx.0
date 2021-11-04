Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438F0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 13:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC292604DC
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 13:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC292604DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9604E6E511;
	Thu,  4 Nov 2021 13:38:46 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EDF16E511
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 13:38:45 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id x70so9292159oix.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Nov 2021 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+yoCyobt8BBEdgGEJ9GaUAJjzdr6MUG/8uf2lfL/cDc=;
 b=kzKlop4NHmmsEWpFpgdVa0qd9MjWu8ADwcQ/cab6KEL+ZRk0yfmg1OtvdQDtAcQRl9
 9Chfsd66WFs6RVtE+OeoXyDFMsqWRnh5OyFw1vmANHsxV9f/llz5I99vt6oXNxhYlGHW
 U7RPGuj8aDYrmKNX/Hp63oWTBic+jK2yNj+D2M2Qyf/R9oDnRRZuZa8s27zHvmhdCHit
 CDAF296RFKyLLIj3qD8+zIexiaPkGZlbtTDqYtRng0U+zwVVXl0mwco1YVI0kJh2SQuV
 Yh4OYHtbVXD+qaQzTODyau2a/4bfyP/MQFcIq4zbvgQrl5GfyXckUpq4sDM+/e5mXXFS
 2u4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+yoCyobt8BBEdgGEJ9GaUAJjzdr6MUG/8uf2lfL/cDc=;
 b=1zXAHu/YQZL3q+/1P4NEzV5yQLVtsem+CCaqKYt8/DrijKf1tlNVONYFhfFQor/vFX
 hk3JPE/FsWKCEdeppIyBIsN0rDIjTmOIUZwLviRzhbLx1FJdx+qcZSp438AYlwGhPbUN
 PehujDmpY/hw62ufoHpiqt34fei9UBYuU6h9sxABuiExCGV9ZSNSDO9tIP1oIE40cv4Z
 HCWycm8yF2HwmcYXOMb+DHWO0Zhql6jEEkNQNXie01nzPVp1i8EgS34oea6MeHs2mPHQ
 aZOY+VQ11qbtovFQRKi+L/gdCBX3zvxWGged+sj0vFGXykDJAgcXL/wg5dXhVbqa9FFG
 iU9A==
X-Gm-Message-State: AOAM531nJwGGvlICNSf5a4yjQw3RIU3pAungkBwWY8kS7fszX1CJ2zZm
 HnKqwTTqnvb/qMv4aX2Qf7ij5N0jSdUtI0PU1nc=
X-Google-Smtp-Source: ABdhPJxkZ18TGZhREo//NK1EUD1vh3ipgXGM1RABrEW5H3Buez0KVxpn7dvyc14sxiXIGpiCdipcvdKEoR60pY6uknc=
X-Received: by 2002:a05:6808:23cb:: with SMTP id
 bq11mr16627262oib.123.1636033124831; 
 Thu, 04 Nov 2021 06:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211104082024.467476-1-evan.quan@amd.com>
In-Reply-To: <20211104082024.467476-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Nov 2021 09:38:33 -0400
Message-ID: <CADnq5_PfC4GrheN+dSsSzWuq7M3roTT5g7n26BZqbZ7jzq7xjw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix uvd crash on Polaris12 during driver
 unloading
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 4, 2021 at 4:20 AM Evan Quan <evan.quan@amd.com> wrote:
>
> There was a change(below) target for such issue:
> cdccf1ffe1a3 drm/amdgpu: Fix crash on device remove/driver unload

proper formatting for a patch reference:
cdccf1ffe1a3 ("drm/amdgpu: Fix crash on device remove/driver unload")

> But the fix for VI ASICs was missing there. This is a supplement for
> that.
>

Fixes: cdccf1ffe1a3 ("drm/amdgpu: Fix crash on device remove/driver unload")

> Signed-off-by: Evan Quan <evan.quan@amd.com>

With the above comments addressed,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: Iedc25e2f572f04772511d56781b01b481e22fd00
> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index d5d023a24269..2d558c2f417d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -534,6 +534,19 @@ static int uvd_v6_0_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> +       cancel_delayed_work_sync(&adev->uvd.idle_work);
> +
> +       if (RREG32(mmUVD_STATUS) != 0)
> +               uvd_v6_0_stop(adev);
> +
> +       return 0;
> +}
> +
> +static int uvd_v6_0_suspend(void *handle)
> +{
> +       int r;
> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
>         /*
>          * Proper cleanups before halting the HW engine:
>          *   - cancel the delayed idle work
> @@ -558,17 +571,6 @@ static int uvd_v6_0_hw_fini(void *handle)
>                                                        AMD_CG_STATE_GATE);
>         }
>
> -       if (RREG32(mmUVD_STATUS) != 0)
> -               uvd_v6_0_stop(adev);
> -
> -       return 0;
> -}
> -
> -static int uvd_v6_0_suspend(void *handle)
> -{
> -       int r;
> -       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
>         r = uvd_v6_0_hw_fini(adev);
>         if (r)
>                 return r;
> --
> 2.29.0
>

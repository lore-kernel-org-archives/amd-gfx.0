Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4699BC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 20:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CFF61490
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 20:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CFF61490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 688BF6E512;
	Mon, 10 May 2021 20:20:48 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708A46E512
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 20:20:47 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id u16so16968588oiu.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lsjjCuNlhxUPvodnJZVPI6Dom6DIlgaRGNGL3HrLyXI=;
 b=MLcdiCFYDQxGXVd9Kh8Co5O/SEBf1LO7jk5x73WEaXbdvqxwxWc7KUb9WRJxN6TaUv
 oeDXbxQUaL5O5efYC0pnu8lGQedvu+8mtHeyshMlLP8ZIimI9aJppRtEWMEatx2R833Q
 AUFLw+twL0e3gB0rcwbOdJfAy47Esb1nTjSvit3Nx0l/IBDhh+4dEZyuQ3lEvB2kzH+D
 aMR1xvIfOZedtQ2UgZNQodx2IUSYmlOKCvFDEJZcPDS0cFsqeXfSGOIEozCEMEHGAp4V
 7pq1X7EzAw4sJ6vIKIru3HyO1Zvm+mArobNR/+ynsflUI94mcJ4Dw5S0K5Na/bMwVfkZ
 84mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lsjjCuNlhxUPvodnJZVPI6Dom6DIlgaRGNGL3HrLyXI=;
 b=ow2LWpvycPbSOuFT5y3Oj2pHzBqk8Pb85IcRafCoBsheBKZBuG00Q9Hz+4VUk1Rl5C
 Gog/a3dwE3xZVR4VvIfDvrLiK/JyLkcxdYY+MVDe2U986wRDOmMozU8QA5k26xxAY94x
 TCSezuyaFx3CyQUrpWZ6BMdtSPLXx4smXiONEJlf+sHa5vmIfykr6L1oGKuLaYFig/5R
 1BREqzj/r1BrPGlAHa8HX/NJWOz6AqG3aYd0w4ulOPho6vkR+M0mou/l40We5/K0xyXX
 v0eUzsnF8JyTFhnbjrrUJkJJ0+YYPMv9Phuvak4VgQi1mVA6m+K1DtvqLEJ3jup61iMC
 tARQ==
X-Gm-Message-State: AOAM532QNq4EJNwgdoT/EgSJGfDFv4TPmeXN/dtJJECWVTUj5z334SRW
 Ddp3swo6Ryu9QbtTmaa8Wf+Xwt/Im3JJ+sFSTd4=
X-Google-Smtp-Source: ABdhPJzVfEbjqgFzUHovCOguRAPpwW6pEnkKxdd0KC2FGCE5E+eo8/eRrQMpAn0jw63MsK2CTd85z8RZEOeMSbqd7oM=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr19130840oig.120.1620678046817; 
 Mon, 10 May 2021 13:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210510095601.2091-1-Yuliang.Shi@amd.com>
In-Reply-To: <20210510095601.2091-1-Yuliang.Shi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 May 2021 16:20:36 -0400
Message-ID: <CADnq5_Nd=LqMU0rDz-7XSymvOkTniPTn3mY=3FT7HWcA3RTsXw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: avoid undefined return value
To: Leslie Shi <Yuliang.Shi@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Chen,
 Guchun" <guchun.chen@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 10, 2021 at 5:56 AM Leslie Shi <Yuliang.Shi@amd.com> wrote:
>
> Fixes: a7c22df2fd07 ("drm/amdgpu: clean up non-DC suspend/resume handling")
>
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>

I think this was already fixed in:
commit e64a779ad509391dcdb3d0d4014d81e6db2ac001
Author: Victor Zhao <Victor.Zhao@amd.com>
Date:   Tue Apr 27 17:52:56 2021 +0800

    drm/amdgpu: fix r initial values

    Sriov gets suspend of IP block <dce_virtual> failed as return
    value was not initialized.

    v2: return 0 directly to align original code semantic before this
    was broken out into a separate helper function instead of setting
    initial values

    Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
    Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 7d4af8fc7e97..f3b2762f6f53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1554,7 +1554,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
>         struct drm_crtc *crtc;
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
> -       int r;
> +       int r = 0;
>
>         /* turn off display hw */
>         drm_modeset_lock_all(dev);
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

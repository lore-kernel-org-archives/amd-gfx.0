Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EB5C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Dec 2021 04:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDCE10E3E6;
	Fri, 24 Dec 2021 04:15:46 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1596710E3E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Dec 2021 04:15:45 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 y13-20020a4a624d000000b002daae38b0b5so2350718oog.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 20:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=puDOER5xDGushgFBqyN2Z5bVlBOOLLi04Ae6GAP8LD4=;
 b=T5HAHfDd55aX7VMnzA3pEsejFjtIVWv6cOqBBuYtXKeHaWHne3mtPaqNs1mScf3HYD
 GyFMvXQ/rglMOBVCzqW4gYfcHslr2/Z2sm0BpZ9sJrEagATSoPjbm3s8e+J5/dNF24ev
 Gj2LdOA3DNZke9cpl/TBsMMqUFJoycqDggmaznKkqSgT4KDCAQpyC64Jjg/bo5HrKy51
 4tAbMTA77mV79mG5pqwnaixfKRxpvBS6Q1dT5qNXn0oT2bG34i5PTMb0kXrDURRTU14h
 Qb9WSAlR1EK04aJ3OporA+O08tlU+nX8kST9lcTclQ9yViaHMxDYckEFJ49QQKHQfPPt
 8ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=puDOER5xDGushgFBqyN2Z5bVlBOOLLi04Ae6GAP8LD4=;
 b=Bqv+vFGKBQz9ryIB+jVg9Kcblyk0xwiajCBCp4GLHlHBqiqaYxRKB68LP5EdkAH5dw
 Mdz2meA5LAzonkrCrdujrHt93nymFLHMuvO926PBJ69dsAhg9t0zdvTRAO7NTERZf74f
 /zevBoagzEp+oosjX9eoXXA4K92fPkKK/6qUPmUBGxRrgr0gFwnQMTVcGFHY/JkAHMsr
 4ho0AStq85S+CWIfeALMWhpaEJe54MoSdzpvdALsZv8KeETLHfOfrIOMhZXYxvbf+mi0
 bjR/TOZgo7bRvca/NaNZVjpyPdtN/j7Zt9oA1mshlZZLMkU6BvUMlhWcM/dWN3PdHZ2z
 KMSg==
X-Gm-Message-State: AOAM533y16zdx4AiHTPyGMCxSS2svCU3FCutmVpoDdzGi/pdFopBsEa7
 fL1GEO392ULI4hBSPyY2JlE67vsogR0TepjGv7Y=
X-Google-Smtp-Source: ABdhPJwHrX5dSjZja1LU9DX1REdfariE8MQCMJN6xXOs2U/qtel8L237gd9uscy1Osivk+i35rZgIJC6xMoptcEhljc=
X-Received: by 2002:a4a:8701:: with SMTP id z1mr3185741ooh.68.1640319344197;
 Thu, 23 Dec 2021 20:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20211224031644.2555373-1-evan.quan@amd.com>
In-Reply-To: <20211224031644.2555373-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Dec 2021 23:15:33 -0500
Message-ID: <CADnq5_PJJPuotwLysuGHpo5+sU2_=-arJyXWGrcQN2fxeR63RQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: put SMU into proper state on runpm suspending
 for BOCO capable platform
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

On Thu, Dec 23, 2021 at 10:17 PM Evan Quan <evan.quan@amd.com> wrote:
>
> By setting mp1_state as PP_MP1_STATE_UNLOAD, MP1 will do some proper cleanups and
> put itself into a state ready for PNP(which fits the scenario BOCO stands for).
> That can address some random resuming failure observed on BOCO capable platforms.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I9804c4f04b6d2ef737b076cabf85d2880179efe2

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e431c7f10755..ad8370b41e74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2235,12 +2235,27 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>         if (amdgpu_device_supports_px(drm_dev))
>                 drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>
> +       /*
> +        * By setting mp1_state as PP_MP1_STATE_UNLOAD, MP1 will do some
> +        * proper cleanups and put itself into a state ready for PNP. That
> +        * can address some random resuming failure observed on BOCO capable
> +        * platforms.
> +        * TODO: this may be also needed for PX capable platform.
> +        */
> +       if (amdgpu_device_supports_boco(drm_dev))
> +               adev->mp1_state = PP_MP1_STATE_UNLOAD;
> +
>         ret = amdgpu_device_suspend(drm_dev, false);
>         if (ret) {
>                 adev->in_runpm = false;
> +               if (amdgpu_device_supports_boco(drm_dev))
> +                       adev->mp1_state = PP_MP1_STATE_NONE;
>                 return ret;
>         }
>
> +       if (amdgpu_device_supports_boco(drm_dev))
> +               adev->mp1_state = PP_MP1_STATE_NONE;
> +
>         if (amdgpu_device_supports_px(drm_dev)) {
>                 /* Only need to handle PCI state in the driver for ATPX
>                  * PCI core handles it for _PR3.
> --
> 2.29.0
>

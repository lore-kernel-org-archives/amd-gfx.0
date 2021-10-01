Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB17C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 19:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9563B619EE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 19:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9563B619EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88CA06F3AD;
	Fri,  1 Oct 2021 19:56:54 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6D86E54C
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 19:56:52 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id r1so10058739qta.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Oct 2021 12:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=p/SxJUcNym+yBrhUDQeZfHj2BoORrf39gDk0QlHHVIY=;
 b=S6OtJWXqysXiGnrZA+nmOy1sN3JZerOMISuTAQY+fuca9Fzt4GojpBT101Sc7tnwFu
 604HBOn1qwcUqkjG1mYhCeth8vBI7yweHThqSYHRXS3az4ip3jeC4W28hQtWYq5h24d3
 0Ki2l4zfDW7y1KoEus/tZaN16Z8QhWtqYGtVHYx78oavL9b+u4QplWkWNCz1BGAAWmw3
 XLm0IdPserS8hU8Nv2ixslYS2qvyvumNXMdT+P9oEb2y4Sv1whi4+xj1TtJvVPZ/uNeq
 GoWotKN5RtkJtiBQaKL9ddqAM1YEMmSGbd0+ThRnKSE/61Lf74FXVgwBYzVech52wFed
 dvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=p/SxJUcNym+yBrhUDQeZfHj2BoORrf39gDk0QlHHVIY=;
 b=4tYQ5PMBQQJzmnxywKowJea+lNGQ+WNSzRcqLdPPHxUyTjOiD/NJ7vPDQaKd/pqd6x
 JD2HOSmRgbK5f2NG7djjJKE0WKCnnlWD6E+R0jMOrjeUijXBYpIjUkdhcHfn6IqZc2Mj
 Ra2cb71dUWnkAW/lkCBkTKS2VeymAn4ERDfC40Zs3OomZdZgKkFPE1OIYj9Ny9TW2lU2
 l/4Lm6Sn8WHmURe33VsdzNHiR16qWPEMdfwFHGhLvv/JS5z4uCF4JR595Kba0O+XZFfC
 C4pZdpeW+9w12CLmRCk1xqq/qApN12t+P7xwHA9ZU9uoufv+E73Dz/cyfwbdC+aqD0DD
 VLRA==
X-Gm-Message-State: AOAM531hhtINIwTTzThc0KT/vit+M9sZkdyP1KLVI6HzQEVaz4BFYycc
 9+CUOmX69E4lu4ldRiwtcIk9VA==
X-Google-Smtp-Source: ABdhPJxrVccyTYRwdk6z2yk7egQNKJbDPNZpw3JQMtglBuU4wtwZ0NSNIag9g5DzPsr6KhUfUZT0dw==
X-Received: by 2002:a05:622a:1111:: with SMTP id
 e17mr14878148qty.185.1633118211758; 
 Fri, 01 Oct 2021 12:56:51 -0700 (PDT)
Received: from localhost ([167.100.64.199])
 by smtp.gmail.com with ESMTPSA id v8sm4581090qta.21.2021.10.01.12.56.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Oct 2021 12:56:51 -0700 (PDT)
Date: Fri, 1 Oct 2021 15:56:50 -0400
From: Sean Paul <sean@poorly.run>
To: Mark Yacoub <markyacoub@chromium.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 seanpaul@chromium.org, Rodrigo.Siqueira@amd.com,
 anson.jacob@amd.com, Mark Yacoub <markyacoub@google.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/2] amd/amdgpu_dm: Verify Gamma and Degamma LUT sizes
 using DRM Core check
Message-ID: <20211001195650.GX2515@art_vandelay>
References: <20210929194012.3433306-1-markyacoub@chromium.org>
 <20210929194012.3433306-2-markyacoub@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929194012.3433306-2-markyacoub@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Wed, Sep 29, 2021 at 03:39:26PM -0400, Mark Yacoub wrote:
> From: Mark Yacoub <markyacoub@google.com>
> 
> [Why]
> drm_atomic_helper_check_crtc now verifies both legacy and non-legacy LUT
> sizes. There is no need to check it within amdgpu_dm_atomic_check.
> 
> [How]
> Remove the local call to verify LUT sizes and use DRM Core function
> instead.
> 
> Tested on ChromeOS Zork.
> 
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 07adac1a8c42b..96a1d006b777e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10683,6 +10683,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  		}
>  	}
>  #endif
> +	ret = drm_atomic_helper_check_crtc(state);
> +	if (ret)
> +		return ret;
> +
>  	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>  		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>  
> @@ -10692,10 +10696,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  			dm_old_crtc_state->dsc_force_changed == false)
>  			continue;
>  
> -		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);

From a quick glance, I think you can now delete this function. It's called from
amdgpu_dm_update_crtc_color_mgmt() which is part of the commit, so the lut sizes
should have already been checked.

If the call from amdgpu_dm_update_crtc_color_mgmt() is not possible to remove,
you could replace it with a call to the new helper function. And if _that_ is
not possible, please make amdgpu_dm_verify_lut_sizes() static :-)

Sean

> -		if (ret)
> -			goto fail;
> -
>  		if (!new_crtc_state->enable)
>  			continue;
>  
> -- 
> 2.33.0.685.g46640cef36-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

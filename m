Return-Path: <SRS0=CorL=O4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCDEC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 13:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3F760F6B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 13:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC3F760F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC446F509;
	Fri,  8 Oct 2021 13:51:16 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96AA36F509
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Oct 2021 13:51:15 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 u5-20020a4ab5c5000000b002b6a2a05065so1819186ooo.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Oct 2021 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ID9/4fjSNKENXeRI4yqxSqayd2q6+CVALcSb1We7cYk=;
 b=VCUtOe3fr7YXZ1HdqAkDnHGdihUW7B4KVW0nS8Xaj73AkDvxrtUryfXrbwKOtBQX5s
 Jd2/Z1gcVJVDuX8znVkZONtjS/5M7wkbJ7K8L34UTIj4TOc7VxyqKRl1Q8bmUB7JjpQR
 2l1hnoo6mAp0y4d6ZsHja3W/E+IKmki/QALVIGH3PeZ8iRaDdkNw5SGWh9IPeKnsXy5h
 jH0wzQUhJ1TZ9iJ2ztG/NI8ijW6aTouHcqRBQ1R4gxk+FGojDF4TXXrj7d5q2i2/ERjs
 HOnXrvdNM59mrx5Rx6YJCMIroBXhNR6WCSjTXA11PquD6kVsBg9dWQx21myGEslgdcGb
 LXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ID9/4fjSNKENXeRI4yqxSqayd2q6+CVALcSb1We7cYk=;
 b=raQwYM7LGQ7YhuNkF+h2MX6JzuQfRZscw1hntQfKvXYxf0vfTbpkRmFsAMDSjd+qoR
 Y3IbcGBa9JuWS4v06CgMbuk09wmoKbSMyH6J3EqPyQ1QkDKrT0ArQPn9MZTy58paptlO
 KPi/fQ5/7hc8kYpq8zia6UyljpN/53SBG8CBpfPywYTJM/C8onrOhjTqO+GOxDgPea1r
 D+vUkUePZwfFGHGyz5Zg5LbH2uX2A+D9KJ/QshZC4dHTpAaQIAatjC+l/xMU/y/rUUDQ
 tL+9Yp5OAzqVHGi0lEZNiUd1q0xO3JmzkBGWyBr4Pj9l/7XW+A/FBBECzGk/hRUEDbwg
 ocYQ==
X-Gm-Message-State: AOAM5335atIkLI+EVME4/UWNgKTLsLu9x6pybE6laWVNuVu32KfHBUWd
 0dv4HjMdTHA0lMNOprkvS1/ZVRGJ1EodaREz8jI=
X-Google-Smtp-Source: ABdhPJzn8Ro9UotjBMsjMod4Tzl1mFlMhyno0aOn+8AwxX1HWclNSLay3yQ69IM1Vx2xKwFLEi6PrAac2J6wdSX1hxE=
X-Received: by 2002:a4a:bb98:: with SMTP id h24mr7968381oop.23.1633701074797; 
 Fri, 08 Oct 2021 06:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211008133940.1251892-1-Wayne.Lin@amd.com>
In-Reply-To: <20211008133940.1251892-1-Wayne.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Oct 2021 09:51:03 -0400
Message-ID: <CADnq5_NGeW8szLtCr_FwRZqPKVA96BmR-5=j+=1R+vKeZRSR3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix Werror when building
To: Wayne Lin <Wayne.Lin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, 
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Shih,
 Jude" <jude.shih@amd.com>, 
 Mike Lothian <mike@fireburn.co.uk>, Jimmy Kizito <Jimmy.Kizito@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Oct 8, 2021 at 9:39 AM Wayne Lin <Wayne.Lin@amd.com> wrote:
>
> [Why & How]
> Got Werror when building with Clang-13:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:195:2:
> error: variable 'ts' is used uninitialized whenever switch default is
> taken [-Werror,-Wsometimes-uninitialized]
>
>         default:
>
>         ^~~~~~~
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:200:9:
> note: uninitialized use occurs here
>
>         return ts;
>
>                ^~
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:180:2:
> note: variable 'ts' is declared here
>
>         enum dpia_set_config_ts ts;
>
>         ^
>
> 1 error generated.
>
> Fix it.
>
> Reported-by: Mike Lothian <mike@fireburn.co.uk>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> index 6936b9d549e5..64d2461953c4 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> @@ -193,6 +193,7 @@ static enum dpia_set_config_ts convert_trng_ptn_to_trng_stg(enum dc_dp_training_
>                 ts = DPIA_TS_TPS4;
>                 break;
>         default:
> +               ts = DPIA_TS_DPRX_DONE;
>                 ASSERT(false); /* TPS not supported by helper function. */
>                 break;
>         }
> --
> 2.25.1
>

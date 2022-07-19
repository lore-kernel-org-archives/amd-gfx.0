Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37561C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 13:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8957014B444;
	Tue, 19 Jul 2022 13:37:16 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1D814B412
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 13:37:14 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id r6so19621531edd.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 06:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nKnEiOZZqnM4f6yM4rz+qggRH5Q0Y5xVqfpqLz+n5vY=;
 b=IT/WRMJCBH4rXlsX4ybqkbskcGA8xCsjaE0aZqsyR2NAFp0ogcYTExu5c9m9o5pX/G
 D2VqywJWoT4dognlu9pyASG0YbjTMqs1N7OVPzZzlXsBFYFlncTy7HzccEvQ1aBBBPOq
 8uZkEw3AKMCwD0V0eJqhRU7Q2T+pWdty3E0M7HKjH4n5xyAU6Etq8tOXbVHbHg26X22Q
 4DyCDij2+XkmszNqvs3YETdpzSGVvCZpTHW3E89acC0QRNoGXjpf9EhAGY4HT1iVegbl
 /ScNAX3vPA9dQOPhyo874dQttElx+48Fi3sXJ2547RsB/I8Ic5IPZ/mKtcQ2+zyOf5x+
 C8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nKnEiOZZqnM4f6yM4rz+qggRH5Q0Y5xVqfpqLz+n5vY=;
 b=UBU24WBfR8Bu71Qp5CE5QvydCTq01njXO7pEeHKpKN37utDy5/Qkzm6pEtRSl7qhXP
 yjlTiINEqS4l+4QRHK0AFVTbrZ+dXkq3G3AzlskMXyWgdE8u//TQB3IYoMbfAgPwdxXK
 6nuu7YxEcleog2F+e0WeA7yIbJN9pPbByP7qtrssqbnD1c/6NlwVG06NHbtW2Znz/YDR
 j2cmiwJmTiZ0j0iiWYHBcU1aOfU4clmgSczSaNph2sg5C9/XCvzef9pwh6SIDEyctSBN
 og1PKrttVCgF4X6Q9zdOIGYFMT5egQuVNUhzG9JnMzxoAn1TLiCV0lo8DDkOFNZz9Fia
 PWNw==
X-Gm-Message-State: AJIora/AzJuXPcHMxcI0WM/dD0hhA2kmjcoFR7812ExoATefX4M9Tqv5
 jIGZdnmZ/liBRyxJOqPL+rgV3ehV7O9v3Ql1kMVflJGB
X-Google-Smtp-Source: AGRyM1uHkny5sUKalpe/oBpFieCGOoLEwpswrO9hqEY/fDhwVtZqVKpkAGjCqJbY7sb1rObtYxog0lXs4bzYq4gJrMs=
X-Received: by 2002:a05:6402:274c:b0:43a:9204:95fb with SMTP id
 z12-20020a056402274c00b0043a920495fbmr44790755edd.259.1658237833340; Tue, 19
 Jul 2022 06:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220719131736.133958-1-kenneth.feng@amd.com>
In-Reply-To: <20220719131736.133958-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Jul 2022 09:37:01 -0400
Message-ID: <CADnq5_Nabyv3sHbC4ENEwe3vyD0UjhciK7kVBFCh5gz3SwDqSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: enable gfx ulv and gpo on smu_v13_0_7
To: Kenneth Feng <kenneth.feng@amd.com>
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

On Tue, Jul 19, 2022 at 9:17 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> enable gfx ulv and gpo on smu_v13_0_7
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 6f0548714566..16eea2de8a2d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -251,6 +251,7 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
>         if (adev->pm.pp_feature & PP_SCLK_DPM_MASK) {
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_IMU_BIT);
> +               *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_POWER_OPTIMIZER_BIT);
>         }
>
>         if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> @@ -271,6 +272,9 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
>         if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
>
> +       if (adev->pm.pp_feature & PP_ULV_MASK)
> +               *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_ULV_BIT);
> +
>         *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
>         *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT);
>         *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MM_DPM_BIT);
> --
> 2.25.1
>

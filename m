Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F1BC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 04:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454F764E89
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 04:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454F764E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC966E479;
	Thu,  4 Mar 2021 04:12:11 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F4D89BEC
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 04:12:10 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id x20so28635794oie.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Mar 2021 20:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QA2tum6QX5mZb2bCXbT+bFgZBR2utgfKyXArfeGcTeU=;
 b=DccG6o3g98iuC/IfePFRA6kKGmC40ks2HjHOkjiZ9+MJlNVVjg1rijOtauoaUVNcsy
 X53SDvdunE+ouZDuH7wgVb5S15eevu3V82p/CC0pD9QfyvWyqsJh5Y2gKXe5+p7Kp7EF
 MWkjH03fwIh0oJTdYB6Ld2P4C5XhLJyOmLp+eQ/+ZKufnsG7I+2GXhZU2XU3y0ic58Kr
 1q33wmkVWQ6Ri5bRVFJndHuGU2lkwCcBNMbiu1yCll4YV/W1WmXYm3ES68vC6v0W7XQb
 kzfiQUBVAtlm1nO3701jXr/IbMTVEdcSZDukwr+AK1dtXDkj/bb5+FZv0P1b1BrIegzx
 FnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QA2tum6QX5mZb2bCXbT+bFgZBR2utgfKyXArfeGcTeU=;
 b=WAaWEfU3oAt5Kn+uqr18iQMKXp6eE0UAB69NySwWeDt0EOxRyFwLxifF1Wb6w9Uix5
 I5ptyi02LPZhZieeambmkeBsxToyYyl7YRTZZ7rtCEIyxEulqTW1J9wfcNKZzLPswECM
 DA71QQ2o07CYypDtqSpRBWH93+U0EEUHTvn7kuCv/8tVCl1UzQDIZ8JJ9Bt9GOcyqek6
 xWZp7f0PosH8k+ACGCQ3m4MuGxoBDXMDP8AAvbC5oN63RPavHZCD+jYaKxsKTlcOmXTp
 cF5OgL7BL6d/6BorCvY3WFbSf0LbwmD+4jo3N2Ew1CtyYwQE7z20gIKI7aXa/M+Sr7eO
 ghsw==
X-Gm-Message-State: AOAM532G6daqz23wAJa2MrckYFUXIjB8zI9AX7S90kA/mvzZCBw5hELH
 6UrmOE0cdmIRAUjIebeR5ylfoLt6VF2mjyxw9LA=
X-Google-Smtp-Source: ABdhPJwXz33gZQn1PMcXcgMFHPaaNCE8F3KPBKBiTsN4hw68v+Qi/T4f6Q+CdefgMan8lBF+1ysPQHK6dtjWH6t5RBI=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr1621279oiw.123.1614831130132; 
 Wed, 03 Mar 2021 20:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20210304035824.37796-1-Feifei.Xu@amd.com>
In-Reply-To: <20210304035824.37796-1-Feifei.Xu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Mar 2021 23:11:59 -0500
Message-ID: <CADnq5_Njn_yvVasKGcQi61rZbi1cxv-G46iTCH0xojkfH4gFeA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
To: Feifei Xu <Feifei.Xu@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 3, 2021 at 10:58 PM Feifei Xu <Feifei.Xu@amd.com> wrote:
>
> SDMA 4_x asics share the same MGCG/MGLS setting.
>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 3bede8a70d7e..f46169c048fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2271,21 +2271,11 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       switch (adev->asic_type) {
> -       case CHIP_VEGA10:
> -       case CHIP_VEGA12:
> -       case CHIP_VEGA20:
> -       case CHIP_RAVEN:
> -       case CHIP_ARCTURUS:
> -       case CHIP_RENOIR:
> -       case CHIP_ALDEBARAN:
> +       if (adev->asic_type >= CHIP_VEGA10){

Need a space between ) and {.  That said, do we even need to check the
asic type here at all?  I think this applies to all chips that have
sdma4.

Alex

>                 sdma_v4_0_update_medium_grain_clock_gating(adev,
>                                 state == AMD_CG_STATE_GATE);
>                 sdma_v4_0_update_medium_grain_light_sleep(adev,
>                                 state == AMD_CG_STATE_GATE);
> -               break;
> -       default:
> -               break;
>         }
>         return 0;
>  }
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

Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90495C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 14:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294F660F41
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 14:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 294F660F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D0589E65;
	Tue, 10 Aug 2021 14:13:37 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA5589E2A;
 Tue, 10 Aug 2021 14:13:35 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 61-20020a9d0d430000b02903eabfc221a9so22170334oti.0; 
 Tue, 10 Aug 2021 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WBj9jDzdrpkQARXB3cjFr72FO41wqr8C2m6gqeyQkOM=;
 b=G5H3i1qJW9zU2sRnzNTDSWEAviRi5xYzX3sXOLng8kmOXC8SlYtH/pO83+FQFamtev
 mQWemttbtv/NZqWhr57X2ZML7YQStNfVc35CW862oeR7Zj6FXZkLLMr3LFMXIQx1uYQB
 ApIWDHC5af8fq77CUZyP2c+10o3dADueNjrProCLo1N1WCW8J+1G3ReM/5PT1frtnOY/
 QQJuE66EI6nDjs9A1rk8H5Y2iJMIKvqip2p1YdBzEZxdvBRU1hSocjOFfs21Hd+9XBiZ
 xF01NEYDgwJipsvicygnP92Cu8zA4UUtPcE0A/HCSUN4lIktwTT+R+8CJl6p0R2EHOEs
 SB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WBj9jDzdrpkQARXB3cjFr72FO41wqr8C2m6gqeyQkOM=;
 b=TgFGbiUYxZEBBJoUDMOnx3akul+FIHa2UrcuTNh8zErH6D5604G//XfviovXlthwjS
 IwN6/rOdSQcFFGUAXtRpnNSNGYcozM9y+nVl36cBKRNmn562f9Gy3mJRYSANo3dk9sdA
 fGer1/gYVeZ3g0jTK3iZsOjFBll1SVplG4lSzmptrPFsf+t75KUHyAZn2/v0cdMDRR0S
 nGlO8p9XcGZQI67O51x+0NMJikoSusEsHrtE4YgBauzOmrlG3em6fwOaZDskWnyaH84A
 psYFbfz7M7OfeCrmIxZCQjZvu9NoxfQWjd0PNeBd35CLH1TRv3r1WIujOJMvnt9hGO3O
 VTeg==
X-Gm-Message-State: AOAM530CxC/deqBemgqw1FOFLi6zo/sF5TJBJRD8EQg8syaPHXV4lNR8
 LNacKwsowDNl7/+1TxsE0PCWKobB4LqH/K6hCQSz57xT
X-Google-Smtp-Source: ABdhPJw8TFkDGPU6iSWLNfA+6DeUCxWqVIOLSY1qvG9Gk5q54+qoCpUI8ReRElJ32Ux40vKe6zWz3g6RHiRmbJ20X/0=
X-Received: by 2002:a05:6830:1e78:: with SMTP id
 m24mr15296402otr.23.1628604815033; 
 Tue, 10 Aug 2021 07:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210810012304.28068-1-zhaoxiao@uniontech.com>
In-Reply-To: <20210810012304.28068-1-zhaoxiao@uniontech.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Aug 2021 10:13:24 -0400
Message-ID: <CADnq5_M1pon2TxnjU8pLfjGdo9w1iuc6KX6ff2a+7B4cTza79w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove variable backlight
To: zhaoxiao <zhaoxiao@uniontech.com>
Cc: Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, 
 "Wentland, Harry" <harry.wentland@amd.com>,
 "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 xinhui pan <Xinhui.Pan@amd.com>, Nirmoy Das <nirmoy.das@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
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

On Mon, Aug 9, 2021 at 9:24 PM zhaoxiao <zhaoxiao@uniontech.com> wrote:
>
> The variable backlight is being initialized with a value that
> is never read, it is being re-assigned immediately afterwards.

I don't think this comment really matches the code.  I think you can drop it.

Alex

> Clean up the code by removing the need for variable backlight.
>
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_abm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> index 874b132fe1d7..0808433185f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> @@ -177,23 +177,21 @@ static void dce_abm_init(struct abm *abm, uint32_t backlight)
>  static unsigned int dce_abm_get_current_backlight(struct abm *abm)
>  {
>         struct dce_abm *abm_dce = TO_DCE_ABM(abm);
> -       unsigned int backlight = REG_READ(BL1_PWM_CURRENT_ABM_LEVEL);
>
>         /* return backlight in hardware format which is unsigned 17 bits, with
>          * 1 bit integer and 16 bit fractional
>          */
> -       return backlight;
> +       return REG_READ(BL1_PWM_CURRENT_ABM_LEVEL);
>  }
>
>  static unsigned int dce_abm_get_target_backlight(struct abm *abm)
>  {
>         struct dce_abm *abm_dce = TO_DCE_ABM(abm);
> -       unsigned int backlight = REG_READ(BL1_PWM_TARGET_ABM_LEVEL);
>
>         /* return backlight in hardware format which is unsigned 17 bits, with
>          * 1 bit integer and 16 bit fractional
>          */
> -       return backlight;
> +       return REG_READ(BL1_PWM_TARGET_ABM_LEVEL);
>  }
>
>  static bool dce_abm_set_level(struct abm *abm, uint32_t level)
> --
> 2.20.1
>
>
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD49BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 15:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9B310E390;
	Tue, 25 Jan 2022 15:58:28 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D69710E390
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 15:58:26 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 10-20020a9d030a000000b0059f164f4a86so9376566otv.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 07:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EmGKz/gOwmTRCq4XmkTYXBBpXy0A8DKdLocqLEsX5iw=;
 b=aVsKrlX2JEK9wwCgd4LTkahEHEWgdGzlGP2+MiyKSRsIj4LMNeezAnrqhHutWiQV06
 zpsTxrZbfRbBINkEH167TdFRI4/3pdQylvZUMHBOqXT70+CWbAwbJPo2S9tbli7NvBz9
 QL2K4w+TkyWm5MP530C3r6XChp1eFGFJQUEycct/bOwLL+ISp/Ddx03ICiFJHvvY/wxJ
 avqLRAKRHuh69agcqniyKbMlg4DI4cuiae8huAeiTmdBFbwpQwWAiOatneiGvxucR87q
 8oUFu4qJB0USrvGnLUbJq4EAlQw0XLThKTNYA/2LKDNbVRI/IVAVvlhP8G2mZM+DlGcX
 fELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EmGKz/gOwmTRCq4XmkTYXBBpXy0A8DKdLocqLEsX5iw=;
 b=sU8LfSR4MLElovXZhb8Zu7kRGbf5njVSSqsYIVBoWRnq5bEWUh6ActbzmXQ7xdWfgm
 H5sW/ni/GclQY+vapUKnwiWY3n6bC44nV19ttkfEn5YInmSOMCUvdoyCqHUphTMaBDz6
 5mQJQgXXFIWr8lv6/K/314Lqbxi/TOGifdcobgMxAPbOhmPrN49KbQmU6IXR4M9yrK5H
 wc0NvL1oy9jFrfMsQRH04+6PNaW8DGhgwX+HgT76fiiiqCinEEKmJwVNA0CVvGoWnPOO
 wp0ROiunDDQbW/+xRdzkMdSNQ4akspHeK593CwqwPHSRqwd88Q25pXAYePpC1GI6kq+U
 36hA==
X-Gm-Message-State: AOAM531KWbk8FZk3V/TBNjvLp0bx9y3RTeOgvkficzDpn2o5DSphhSL9
 CrfNcJZYE5PfbjwR9GabHuMG3fEsqnum9A8OKiSO8lN+
X-Google-Smtp-Source: ABdhPJx1Z4TG8PVo30PcZsvQLqv+JJYR0eemE/3oqVQdzcqsuj0Wi2mnwp+I59p34mdpZopqEK4zAsQatwWKnbkiQ8Q=
X-Received: by 2002:a9d:6c0d:: with SMTP id f13mr3577916otq.299.1643126305973; 
 Tue, 25 Jan 2022 07:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20220125090013.102080-1-evan.quan@amd.com>
In-Reply-To: <20220125090013.102080-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jan 2022 10:58:15 -0500
Message-ID: <CADnq5_M-KLrvRmvQ4R-gesSJMYQbAUidBOAXSN_unAsjRsAThg@mail.gmail.com>
Subject: Re: [PATCH V2 1/7] drm/amd/pm: correct the way for retrieving enabled
 ppfeatures on Renoir
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jan 25, 2022 at 4:00 AM Evan Quan <evan.quan@amd.com> wrote:
>
> As other dGPU asics, Renoir should use smu_cmn_get_enabled_mask() for
> that job.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I9e845ba84dd45d0826506de44ef4760fa851a516
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index fcead7c6ca7e..c3c679bf9d9f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -710,7 +710,8 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
>         size_t size = 0;
>         int ret = 0, i;
>
> -       if (!smu->is_apu) {
> +       if (!smu->is_apu ||
> +           (smu->adev->asic_type == CHIP_RENOIR)) {
>                 ret = smu_cmn_get_enabled_mask(smu,
>                                                 feature_mask,
>                                                 2);
> --
> 2.29.0
>

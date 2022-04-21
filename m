Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECABC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 14:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3300F10E455;
	Thu, 21 Apr 2022 14:18:57 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E62010E455;
 Thu, 21 Apr 2022 14:18:56 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-d39f741ba0so5488351fac.13; 
 Thu, 21 Apr 2022 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k6DcgaBgifbl98HwTQyTz4opgdKW16OPxOhCg6ox3bw=;
 b=akZH1M9X1Mq0wvuSic/T+8WK0gaoybBnq14OO+c+2tuwmuNrFE/Tz1feJvZ4HpbwtI
 NZ49Dc9Owb5RUujQIA47u/DGtnwCpY/5weTW/7vDTtfD3g+GENCOi/neHowgA7im+dTh
 w7pTm5p5Iy+pIjTHy4XRTiP1Adthk4fO2oGUL5K9CNtmt/1k43Eke5y0ZvlacYlP95lP
 EWnK6lnz/IP8J0Gp3g2S1B7QjrptJgveyM/mzQSQ3EOV4piUVeYgYjSgMLPca87vwUMI
 4sSBwGpSAb80sXMEMvjVideV7RceGWxOy8SutDao5yiyVAFTNPwqxERvGnOt3kakP/kG
 z3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k6DcgaBgifbl98HwTQyTz4opgdKW16OPxOhCg6ox3bw=;
 b=6O896UGBHcr3ifKWoMr5YFZBgH82fK1BPMc0O0ShwJb6XgWwid1XnWZsMUN1w/QisN
 j0DHoigSmccS0N9xR3gCfdah0sAC9MRBXLLJ6QHkWQnO6BFNad4oa2mDWUA+U8McQp7a
 ZonmJ6Ta18ymF4Li5nK+lNX6b8n+GzUMXmk/tX/qUudxUTnYO5/hEKUpdg0Rrtjv6coz
 ACCLjNppzJvD6X4gcFNr5S29GarmHSlYpDrRiyofdZP5k0a7F/AWRLIWtXppxHB0mMny
 sQBsN+csnbq2XUyIWw75OjgXzTLF3mIHZUK8KApeQ+rwhfZ+JVP4a8EUKjM86uIDbgOk
 1png==
X-Gm-Message-State: AOAM532U9CR7sSuPLfAwZsLCTIyXSfTRt/AfqeZ+f4Yfp9Y42kw3hwn/
 mBbwwb9ZwY3FBVSbEWgUm+QIk2m8k7K+ODrgo4I=
X-Google-Smtp-Source: ABdhPJzuZENytfXhDw4gnAPlJURyrJyYpEVhxUavxnPVMpQVwHQL3dxxaZOzCAfQotdDEP6MCIiiT4dbinmfyqR2jCA=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr4071428oap.253.1650550735602; Thu, 21
 Apr 2022 07:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <1650536939-13778-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1650536939-13778-1-git-send-email-baihaowen@meizu.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Apr 2022 10:18:44 -0400
Message-ID: <CADnq5_Of9Z0LV4DFhGcsoeXHdKGXTekntXePufNeZ+LGJ13XxA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove useless code
To: Haowen Bai <baihaowen@meizu.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Apr 21, 2022 at 6:29 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> aux_rep only memset but no use at all, so we drop it.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> index 8e814000db62..29e20d92b0bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -565,13 +565,11 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
>         struct ddc *ddc_pin = ddc->ddc_pin;
>         struct dce_aux *aux_engine;
>         struct aux_request_transaction_data aux_req;
> -       struct aux_reply_transaction_data aux_rep;
>         uint8_t returned_bytes = 0;
>         int res = -1;
>         uint32_t status;
>
>         memset(&aux_req, 0, sizeof(aux_req));
> -       memset(&aux_rep, 0, sizeof(aux_rep));
>
>         aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
>         if (!acquire(aux_engine, ddc_pin)) {
> --
> 2.7.4
>

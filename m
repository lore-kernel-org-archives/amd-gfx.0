Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B20C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 14:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52F610E02B;
	Thu, 17 Mar 2022 14:26:23 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC62E10E02B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 14:25:45 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id bi12so11124437ejb.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vckV0ZlF5pMU5EOclP3oYh1APp1+Oy/OTUafdY9W0U0=;
 b=ElG57lX2M22jXW1614RoNU9sFuWlREI++GMdCXHsLsj2BBm34g8Dijq+uyt4VMOqPS
 jIPyiECtHE23o92fQCogKBNeqrdHbXvRmY7juhlGVe2IR9Qpd0vHZRYO41F+cmJpF8vS
 20z9bui8gwU5XmpwKvriWPh70C8sd47qi3nHdOW5EjNMkAOnWhaobCfkxCQhLmw417Gr
 q11yrzxYQBTuNOUk2uVPIu0O8TPpbJRF4UtW3eiWLPSLJvbiPdQjc54izEJOQIa447t6
 SvFmt9LbwzLzyGLpFVXMyoC/Irh7j2MAxnVx9inhaG07T9OG4Q6jwSD1lKI1+Q5sooPQ
 jWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vckV0ZlF5pMU5EOclP3oYh1APp1+Oy/OTUafdY9W0U0=;
 b=fgGsP/lht25DWcZIqGbz1qg9vDdjEER6Q2FmVRh8m/dwUlet9MmKx2QhmJLo/fBq0P
 ppU6mWo0twvme+vfzJy+mjhIzDPIvBMVc2J4PB1oG5VtQWo1zHNJRinYJnbnyRwF92/0
 bXYI0zCSj5oH4nj2eIejF5N9lU776ouZWiumaUdhvpZETajx3brA8G2HhOMCfawX/e+A
 4Y4AVtUqO3cFUAfog0Qvcdng5kl30I/YWsrJs3z5jTmecfPnBo12KmrizhECaxyV70cx
 RV+UFJdO1442gs/X4TGkXOT/KWZl0nJyeiD+5woFHmrF2edrFP1Autj5+/Jee7PPplK5
 dxJA==
X-Gm-Message-State: AOAM533UG4gOFyYsDOwmEwJyFRB4wGP4NUiki33/nHWoVn+0FTZ6v/ZG
 PADV+jmcFsZtgZllc6ZP28XmjC8RW0hwuKcsx6Xqkw==
X-Google-Smtp-Source: ABdhPJwhCmmWamgxlR0O80jFQK/ZX8dRZaDWA+kvJU61ovH/1XbdFamrkCJOVBITnnHIsWStuCBud4PeQx2hX8JZYtY=
X-Received: by 2002:a17:906:d554:b0:6df:a6f8:799a with SMTP id
 cr20-20020a170906d55400b006dfa6f8799amr1274844ejc.492.1647527136467; Thu, 17
 Mar 2022 07:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220317140115.541007-1-shraash@google.com>
In-Reply-To: <20220317140115.541007-1-shraash@google.com>
From: Guenter Roeck <groeck@google.com>
Date: Thu, 17 Mar 2022 07:25:25 -0700
Message-ID: <CABXOdTdGbSDuUepv_MRLYqAfRxB6UPQKP4QGSTmWRUSH3dg6AQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fixed the unused-but-set-variable warning
To: Aashish Sharma <shraash@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 17 Mar 2022 14:26:21 +0000
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
Cc: Anson Jacob <Anson.Jacob@amd.com>, Jake Wang <haonan.wang2@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guenter Roeck <groeck@chromium.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 17, 2022 at 7:01 AM Aashish Sharma <shraash@google.com> wrote:
>
> Fixed this kernel test robot warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:12:
> warning: variable 'temp' set but not used [-Wunused-but-set-variable]
>
> Replaced the assignment to the unused temp variable with READ_ONCE()
> macro to flush the writes.
>
> Signed-off-by: Aashish Sharma <shraash@google.com>
> ---
>  drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index 873ecd04e01d..b7981a781701 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -2913,13 +2913,12 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
>         uint32_t wptr = rb->wrpt;
>
>         while (rptr != wptr) {
> -               uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
> +               uint64_t *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);

also drop the volatile in the typecast

>                 //uint64_t volatile *p = (uint64_t volatile *)data;

The above commented out code serves no purpose and should be removed as well.

Thanks,
Guenter

> -               uint64_t temp;
>                 uint8_t i;
>
>                 for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
> -                       temp = *data++;
> +                       (void)READ_ONCE(*data++);
>
>                 rptr += DMUB_RB_CMD_SIZE;
>                 if (rptr >= rb->capacity)
> --
> 2.35.1.723.g4982287a31-goog
>

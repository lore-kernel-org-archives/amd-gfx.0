Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F33C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 15:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA4410F607;
	Fri,  1 Apr 2022 15:28:44 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD01310E8AD;
 Fri,  1 Apr 2022 15:28:43 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 x8-20020a9d6288000000b005b22c373759so2345007otk.8; 
 Fri, 01 Apr 2022 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S2r7fRVo+SDwb9PoKS073Z4FNCpCz2xt1aUwpzgKYYE=;
 b=VQkzFQjH3jayS+KzQ35Yjy19gVTMDC5MhpUMAlAUbqNS+gkHfNtDagx0QxnpcMYPhP
 awCo+eQfv8LItW6p3o+iwtP1cspQrIlzDrS/CRxlfuXBbKHZlB2r9kJOd0h+LutBBaBI
 b3Av0UGhC/799+BGbTKFSReDC74hMAsPCwO49FGRMrUWoe8oAzaoQgM5IHpIX/wS/T8D
 UxhTxkpMvYMvpCTHEcn0MxF7JGSQOrGl0BAmMLFKC3QV5lxKETY+WRAjpccWUxWjTk7V
 hLEa/phzaj9Gb6PF7/RIquxPgKMyhNMfcioLDM2ZvRI64N78vfJCBMpXkI5CUorvReW0
 OhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S2r7fRVo+SDwb9PoKS073Z4FNCpCz2xt1aUwpzgKYYE=;
 b=eaRbofcjig/X7HJ5fRjn/LpASneFVUgWjYqSCph3fSgJsCbjFWUGVVQjPsF8F0gzHB
 EImFCTcmY46rM1dlatc4/3N872pHBsbd3ZQUhfER2iCnDcSzWCH+ue7rTleEaYh3V9KZ
 GzfN4HXnnasi8jewsHvJkbborKgA3b1Mqb9D8iCWvcsOXxGLIHbdNyXZoD8lGPUwjXDz
 jLuGSOjeOxzhjzbhAEKuW+Cw0O1wWCuTGnuQh1UOFrglWpFDDt50CSk8BxXVjfPVQ1hg
 zm4lSNMxnVxEuyt/7HoT6HqtFpWmUh0dYF3TDibk6pfH1XT+odeseVoE+fT2I0Ch6ZY3
 38zw==
X-Gm-Message-State: AOAM531waD+aZQcCyWXz7+ybEAjoKtRDNAZPqcqyOaCeYTO3wjVEjVyv
 tmu0XybyIf4LgHehrS6WKE4KS0XQHGnktNNE67g=
X-Google-Smtp-Source: ABdhPJwWFucrD+Zmo2lOnzUOch/2fcBZJtQUF7mE2PyRD9jYXcM1O9tSChQwAW+/Cg6rugZ9hNTsc1NFq0pmQoySsKQ=
X-Received: by 2002:a05:6830:1552:b0:5cd:bc6e:62b1 with SMTP id
 l18-20020a056830155200b005cdbc6e62b1mr7783681otp.357.1648826922905; Fri, 01
 Apr 2022 08:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220324134031.2648315-1-shraash@google.com>
In-Reply-To: <20220324134031.2648315-1-shraash@google.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Apr 2022 11:28:31 -0400
Message-ID: <CADnq5_NTkB3xrZnT44pCBXercCT7225V2Ui5XTKsY4H45EcXrA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix unused-but-set-variable warning
To: Aashish Sharma <shraash@google.com>
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
Cc: Anson Jacob <Anson.Jacob@amd.com>, kernel test robot <lkp@intel.com>,
 Jake Wang <haonan.wang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guenter Roeck <groeck@chromium.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Mar 24, 2022 at 9:46 AM Aashish Sharma <shraash@google.com> wrote:
>
> Fix the kernel test robot warning below:
>
> drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:12:
> warning: variable 'temp' set but not used [-Wunused-but-set-variable]
>
> Replaced the assignment to the unused temp variable with READ_ONCE()
> macro to flush the writes. READ_ONCE() helps avoid the use of
> volatile and makes it obvious from the code that the read here is
> intentional. Also verified on x86 that the generated code is exactly the
> same as before.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Aashish Sharma <shraash@google.com>
> ---
> v2: Removed unnecessary volatile qualifier in the typecast and an unnecessary comment. Also reworded the commit message.
> ---
>  drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index 873ecd04e01d..a58f460f431d 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -2913,13 +2913,11 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
>         uint32_t wptr = rb->wrpt;
>
>         while (rptr != wptr) {
> -               uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
> -               //uint64_t volatile *p = (uint64_t volatile *)data;
> -               uint64_t temp;
> +               uint64_t *data = (uint64_t *)((uint8_t *)(rb->base_address) + rptr);
>                 uint8_t i;
>
>                 for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
> -                       temp = *data++;
> +                       (void)READ_ONCE(*data++);
>
>                 rptr += DMUB_RB_CMD_SIZE;
>                 if (rptr >= rb->capacity)
> --
> 2.35.1.894.gb6a874cedc-goog
>

Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC85C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F712071A
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmopI/9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F712071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E1389CC4;
	Tue, 31 Mar 2020 14:38:02 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D733C898EE;
 Tue, 31 Mar 2020 14:38:00 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id a25so26344660wrd.0;
 Tue, 31 Mar 2020 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JADBVi0J5qz93W24U2adaMbSQmHxVLtGj9kUvlZL2mw=;
 b=XmopI/9Zqw6A9PeSefGPxVNIf13LCLwxUSam19fXeD6vfy791BKxHimSDr32VJzf/8
 rKgighSLhiTQU1LCvs2ivINb6lMYeUcFcAxS2ynCRIpkG6svgzKb50yvqoDL/o4d6ooI
 y/5yE4Xc955YWoBlO7roQssDgYkuuHfEHz+6DtKQTD9rXkAnu3nUJNASV+a3Qdy9gil5
 XWBD2lPkz/6fhe8yQ5uWBSVzXYqFgZuQhvONxqSF1/oTqlWq++gZXoUP5jw8yqBaDIX+
 0vTQ4f9KXxNICfpP0ytUZ9wlg9iBXEfPa7ae7lTRW+92ZgeyJ/slLwmkmNLQJ4zwZY21
 6k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JADBVi0J5qz93W24U2adaMbSQmHxVLtGj9kUvlZL2mw=;
 b=KI0wd/1cDZIvObA4YPHTBhke9W7PBf0DaSiRDy8fXkCBYm0UJCh9dLxj1jHjfPIqfZ
 HG7JoEvW2kbHmaNkBNQs+eU5e/Uvu7RuOBpX5TQyVChswANaYlRHLkKSWsAda134A8Ez
 59x+FZWeZfp11hDMY4M2W77BtITbld6mUz8FfZ/UVIIX6tOaDby6029W0bvpvObeqMO3
 5tEGJIzam54zM7ee4wJ154nzOWGTUi3u6gyRjbhSyohpuBFfyUifF17rzuzVmWqSjokJ
 kZlcS7baW0AbVh7zQFEPyJ8aDhkbp1w+4UFArUHyr61Gy8VD6s61BE79oajmV6y4WoWW
 zrgA==
X-Gm-Message-State: ANhLgQ0Abi3lp6pLEJH0eWG8KoPo+XDocP4HQZ8nSj2fKt6Cx6x5hoVp
 3DvZ4j6y0ewuPe6HHahPOcHvbx8PacJxeY+orCg=
X-Google-Smtp-Source: ADFU+vtePjXgkDVvMEpbaF955pZevqw5shIxAyv4Oc72hqk5QsXUDeMDs3KNVqrgcy6TGXOdcybhz8cwW/YAwLtQn34=
X-Received: by 2002:adf:f50d:: with SMTP id q13mr21374343wro.374.1585665479545; 
 Tue, 31 Mar 2020 07:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200330221614.7661-1-natechancellor@gmail.com>
In-Reply-To: <20200330221614.7661-1-natechancellor@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2020 10:37:48 -0400
Message-ID: <CADnq5_NQKDHmaVsyEMFcwEcGbo9QCHoC5cZ_3DOO8wNY2e_LDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix 64-bit division error on 32-bit
 platforms in mod_freesync_build_vrr_params
To: Nathan Chancellor <natechancellor@gmail.com>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 31, 2020 at 3:38 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building arm32 allyesconfig,
>
> ld.lld: error: undefined symbol: __aeabi_uldivmod
> >>> referenced by freesync.c
> >>>               gpu/drm/amd/display/modules/freesync/freesync.o:(mod_freesync_build_vrr_params) in archive drivers/built-in.a
> >>> did you mean: __aeabi_uidivmod
> >>> defined in: arch/arm/lib/lib.a(lib1funcs.o)
>
> Use div_u64 in the two locations that do 64-bit divisior, which both
> have a u64 dividend and u32 divisor.
>
> Fixes: 349a370781de ("drm/amd/display: LFC not working on 2.0x range monitors")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 8911f01671aa..c33454a9e0b4 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -761,10 +761,10 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
>
>         // If a monitor reports exactly max refresh of 2x of min, enforce it on nominal
>         rounded_nominal_in_uhz =
> -                       ((nominal_field_rate_in_uhz + 50000) / 100000) * 100000;
> +                       div_u64(nominal_field_rate_in_uhz + 50000, 100000) * 100000;
>         if (in_config->max_refresh_in_uhz == (2 * in_config->min_refresh_in_uhz) &&
>                 in_config->max_refresh_in_uhz == rounded_nominal_in_uhz)
> -               min_refresh_in_uhz = nominal_field_rate_in_uhz / 2;
> +               min_refresh_in_uhz = div_u64(nominal_field_rate_in_uhz, 2);
>
>         if (!vrr_settings_require_update(core_freesync,
>                         in_config, (unsigned int)min_refresh_in_uhz, (unsigned int)max_refresh_in_uhz,
> --
> 2.26.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

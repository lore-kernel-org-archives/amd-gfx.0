Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1B2C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE1D18B9C6;
	Tue, 12 Jul 2022 15:28:11 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7801412BEA7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:28:09 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id g1so10554897edb.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UURgQD77qCgTERk8UkXhUAI5fSrxbFDlFwZPz5eMT0I=;
 b=KlskaAz/kU4GKebQmpB72P6Ew7DS7Gp4aIjfsOi/Q8aVTVU4too1zGrfjCXVOlyapL
 l3YPPaFXKmQjuyAOR5grhd90iHstpUIqrPeqq/17SgDux9RfbvKqL7/X+jPpi5477lzL
 LebFpl6aF86EggnPpod2YID+fAIsRN50r5aqhwEF9dNQHOqFpoopywFT5owEQVHjsj5l
 LmzahFbR+WpmEHkJ9Z0v0nQooWUnMHzaWsBI96YMSBjeZ0FLYTd8eBQjBE8GXxZ9WPi1
 s/7yMUgIA0TODKIc4qCO/Z4AawarvL5Q2w0RsFVX+5gJ1QIm6gShW95CwaTAoKGBdtCl
 pHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UURgQD77qCgTERk8UkXhUAI5fSrxbFDlFwZPz5eMT0I=;
 b=RgvDjAEScZVSfLlbGiATdCBFwvt+g1S5j+/N/ceUYCBGMhO98VaANv9z7uG61Lbe9p
 FXbFvdNlIgOxOfEAcECcgRfFWlxrJI202ycMv++5Ay/hxs9+jIkHJ6UsH6hXskRaqV+9
 WWYvNtQsaJK/apI5ZmDpXYC38VXR39A9CBMtBU5Jm/ds/qTuWVXfLGH2VtksMTOkBKKy
 XmUoLp5LunwuANyXy76/RoT827KrcEEB7gClDxUBCbZYmV7Gp2FqacumA5oJ61hc5dGB
 XyxUID4cVwQ9gupgXoRODrR0wRIodMUCmtQeoCGl5eH5EqVKXXOrZH02p9TziqClIoNh
 tliA==
X-Gm-Message-State: AJIora/wVwsSjql3lHV3ArkwAASx/FAL+d8MAheHauIx0tM3hNHaCLTF
 udWJC8lW0sjxA7sBS9D4kkJSInR3vNfkbGdgkoUh/Ynd
X-Google-Smtp-Source: AGRyM1tJUgXjSeHeeFMOXPhCYCHXBc3/8qDF6vr1x3U7kfGG95FKfAU72ojPqJzGAqFV/inHDzxnCUM1u8Lq4huMf4s=
X-Received: by 2002:aa7:cd64:0:b0:43a:4d43:7077 with SMTP id
 ca4-20020aa7cd64000000b0043a4d437077mr33070427edb.302.1657639688047; Tue, 12
 Jul 2022 08:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220709023125.75039-1-mr.b34r@kolabnow.com>
 <5fe781cf-8731-1e1c-3c2c-b8957770276c@gmail.com>
 <cd39e86c11dda19046388ca62bed3e3b@kolabnow.com>
In-Reply-To: <cd39e86c11dda19046388ca62bed3e3b@kolabnow.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jul 2022 11:27:56 -0400
Message-ID: <CADnq5_Mzk1Cyw6DEWFbBtoRa+T+P4SMYmkDmSwAoxgwqVoZpKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Prevent divide by zero
To: "Mr. B34r" <mr.b34r@kolabnow.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Mon, Jul 11, 2022 at 9:06 PM Mr. B34r <mr.b34r@kolabnow.com> wrote:
>
>  From: Yefim Barashkin <mr.b34r@kolabnow.com>
>
> divide error: 0000 [#1] SMP PTI
> CPU: 3 PID: 78925 Comm: tee Not tainted 5.15.50-1-lts #1
> Hardware name: MSI MS-7A59/Z270 SLI PLUS (MS-7A59), BIOS 1.90 01/30/2018
> RIP: 0010:smu_v11_0_set_fan_speed_rpm+0x11/0x110 [amdgpu]
>
> Speed is user-configurable through a file.
> I accidentally set it to zero, and the driver crashed.
>
> Signed-off-by: Yefim Barashkin <mr.b34r@kolabnow.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 5f8809f6990d..69cebdb58c04 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1236,6 +1236,10 @@ int smu_v11_0_set_fan_speed_rpm(struct
> smu_context *smu,
>       * - For some Sienna Cichlid SKU, the fan speed cannot be set
>       *   lower than 500 RPM.
>       */
> +
> +   if (speed == 0)
> +       return -EINVAL;
> +
>      tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
>      WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
>               REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
> --
> 2.36.1

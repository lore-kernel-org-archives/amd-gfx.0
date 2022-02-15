Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0141FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 14:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD7610E5AC;
	Tue, 15 Feb 2022 14:09:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FCF10E416
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 08:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644914919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cAghCw6nMXIP8DbPC2ZTmMjVdzgtfdV0Q4rDuIo9NkY=;
 b=DSqmbLSAwCAJVngxiscPK3AI83fBvtKyU1g0AilU1+5l1HWqSms+MFHSUGa0sZO/SfGwjz
 MTARKord6OnXu1SikYooOuoDXp45WeVwP+NSyH7Y/dELylzZWdS76PxZnMHKfa6/B5mtm0
 Kk9NNo2FFnT7z/6lrYWi3bCEQd9gsF4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-IbLILVvXNYOUBiRKynogrQ-1; Tue, 15 Feb 2022 03:48:36 -0500
X-MC-Unique: IbLILVvXNYOUBiRKynogrQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 f6-20020a17090a654600b001b9e4758439so2947904pjs.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 00:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cAghCw6nMXIP8DbPC2ZTmMjVdzgtfdV0Q4rDuIo9NkY=;
 b=BY9pcFiZ4JGUtVlqgg6NKLkn6Un7GGlBTM0qRQ3jMRS4G2GvScnnLPdHjt7GuywLXN
 ++4+B0g0ASfQzdWwSYmtC2F4MGMPzKVKZ8743IFZ8wobK+GqGJ4ngY+o1Nxj8r7K8m/l
 WuJacLnosW2T2xcqT0hemva/Yu25xELdS47PTqtqYVjeH4vhQTWjv7wBAvj5g8zV5fRb
 HkW+yiQbHae8dxrkNPNc8yHVVCQxjx0cctHkhHmg8F/+EwJ63+wCTeqdnz2s7GDOINgC
 006NpoABbkdJSo4bztOz9peuzU7PCYrA8Kao72xCzjQTbz+XP05EdyY9C46yaI3Ju0Z3
 NL/g==
X-Gm-Message-State: AOAM5333RQBkhnEhaVEOzipG/UYgJZBl20/4SRDVZysKL5XQftBnRgH1
 7TLR022jKFVauFeTsertEdq760Qt7735t9NmBF4hg9q1/Km+1B2aOZYe2KseaIVothpAlIlu4cs
 ZA1HEU6YTi7fKxzmHMe7EiUfprmriiGksalWMrhtE8A==
X-Received: by 2002:a63:2bc5:: with SMTP id r188mr2644600pgr.363.1644914915604; 
 Tue, 15 Feb 2022 00:48:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNykZwzg4bf+5n8EbXDkY7JRsdOTnLNDPgNJlOcTDejNQ8sWs8DiYpM4W3ztHYleOanIdgFMhO3Rj6Rj63QAs=
X-Received: by 2002:a63:2bc5:: with SMTP id r188mr2644575pgr.363.1644914915393; 
 Tue, 15 Feb 2022 00:48:35 -0800 (PST)
MIME-Version: 1.0
References: <1644890154-64915-1-git-send-email-wangqing@vivo.com>
 <1644890154-64915-7-git-send-email-wangqing@vivo.com>
In-Reply-To: <1644890154-64915-7-git-send-email-wangqing@vivo.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 15 Feb 2022 09:48:24 +0100
Message-ID: <CAO-hwJLwomyHyjza8x3cEhR97HkK7Z7yPWVXwA4-1jmM=WKqeQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/13] input: serio: use time_is_before_jiffies()
 instead of open coding it
To: Qing Wang <wangqing@vivo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=btissoir@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 15 Feb 2022 14:09:09 +0000
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
 Michael Turquette <mturquette@baylibre.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
 dm-devel@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-clk@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
 amd-gfx@lists.freedesktop.org,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 xen-devel@lists.xenproject.org, linux-media@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 intel-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, linux-block@vger.kernel.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Stephen Boyd <sboyd@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 lkml <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 15, 2022 at 2:57 AM Qing Wang <wangqing@vivo.com> wrote:
>
> From: Wang Qing <wangqing@vivo.com>
>
> Use the helper function time_is_{before,after}_jiffies() to improve
> code readability.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/serio/ps2-gpio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
> index 8970b49..7834296
> --- a/drivers/input/serio/ps2-gpio.c
> +++ b/drivers/input/serio/ps2-gpio.c
> @@ -136,7 +136,7 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
>         if (old_jiffies == 0)
>                 old_jiffies = jiffies;
>
> -       if ((jiffies - old_jiffies) > usecs_to_jiffies(100)) {
> +       if (time_is_before_jiffies(old_jiffies + usecs_to_jiffies(100))) {
>                 dev_err(drvdata->dev,
>                         "RX: timeout, probably we missed an interrupt\n");
>                 goto err;
> @@ -237,7 +237,7 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
>         if (old_jiffies == 0)
>                 old_jiffies = jiffies;
>
> -       if ((jiffies - old_jiffies) > usecs_to_jiffies(100)) {
> +       if (time_is_before_jiffies(old_jiffies + usecs_to_jiffies(100))) {
>                 dev_err(drvdata->dev,
>                         "TX: timeout, probably we missed an interrupt\n");
>                 goto err;
> --
> 2.7.4
>


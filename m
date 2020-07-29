Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D773BC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 22:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB35D2082E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 22:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s40JiM4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB35D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF55F6E162;
	Wed, 29 Jul 2020 22:00:17 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D05F89ECD;
 Wed, 29 Jul 2020 22:00:16 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id g10so3017197wmc.1;
 Wed, 29 Jul 2020 15:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qI9wSg2asXOQShlsyDaWSUNkhHbRsckiehfdXNqAvjs=;
 b=s40JiM4PNMIQ3UMvDc9YaIViGY5tOJcYGc+8Xwzxz90Bi+5k5TEsMXRH0TIk+FoihL
 SLwtXNJmL2FxIVPXFnmFBxhaBDb78/Ojaavp7t5t5viVYOy6rf6FiAXFB4626ZgqT0+J
 QlxSky5YFXC+fkgVkNDMuNjFTGM7xskQfoBT2mj288QBz5a5aDXPmNkt1iaoAZjxvoXW
 ajrKTzDhDRsVv2KG+oAhZcbupRk54a5wtz4DmOhj6GdgOxJjVJfnDObWcYZecYrkFKdm
 SMBjVzwBmrPq8b4n9LEyNnmAuYkjTjsbNKn92cO4ps6HU1OdDTI0ujJPTNvLi4BqWX1C
 /wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qI9wSg2asXOQShlsyDaWSUNkhHbRsckiehfdXNqAvjs=;
 b=pZfU1tLi/ogzdm5pu6e2A8dgld/7f9uHCMkfoW+O8j+Fwr0cwImCEWZ5Bv5173nx+8
 kjrC9bbvGN6WOI1q6wGkLCi13vCkxnd93bZd8VSN3I9X9FymwwPT2PK7fIyG39gD4GvG
 qayu2DD8fRsxHf2d34t1hj7puzrTEM8rvVRmYR9N5OYzVjjwHaF0oTmg1Ph3BMKLogkv
 iC9Rc/sXwL3Qs0TZymhwTwUo5fjlo7XEi0TsA3GYWyZybf9/s9koeCT+SuANgRkdxL6N
 ZWInuOaif496XUL8jPzbnMLVT9alNosyYeaVcm7cEff3BkUqQHdAS7FLnBb1EVBIfGjv
 Ay9w==
X-Gm-Message-State: AOAM533cgjXzwShhW+7knGD/E31J6R6WEzDYV1CvtEubQ2u3zUYt05eM
 iKIgbajbWEVhkfyu+EicsTHKYAnyzV4tLohwOOw=
X-Google-Smtp-Source: ABdhPJwEvMI7MQ5NEzBqAR8lfhwJBcIJvQe1V7YS+Wrq1KVyRTHsjdl1/t7122nOVAY8jH3mBHGBexurk/WDw9IkX6E=
X-Received: by 2002:a1c:2:: with SMTP id 2mr10810523wma.79.1596060014118; Wed,
 29 Jul 2020 15:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <1596011641-9136-1-git-send-email-liheng40@huawei.com>
In-Reply-To: <1596011641-9136-1-git-send-email-liheng40@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jul 2020 18:00:03 -0400
Message-ID: <CADnq5_P7VBe5e1U_e=bfbnhNZg+6matA8urRKUx77bTUPCp+qw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/powerplay: Remove unneeded cast from memory
 allocation
To: Li Heng <liheng40@huawei.com>
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
Cc: Dave Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Jul 29, 2020 at 9:11 AM Li Heng <liheng40@huawei.com> wrote:
>
> Remove casting the values returned by memory allocation function.
>
> Coccinelle emits WARNING:
>
> ./drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c:893:37-46: WARNING: casting value returned by memory allocation function to (PPTable_t *) is useless.
>
> Signed-off-by: Li Heng <liheng40@huawei.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c
> index 7a7f15d..f56a3cb 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c
> @@ -890,7 +890,7 @@ static int init_powerplay_table_information(
>                                 power_saving_clock_count);
>         }
>
> -       pptable_information->smc_pptable = (PPTable_t *)kmalloc(sizeof(PPTable_t), GFP_KERNEL);
> +       pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
>         if (pptable_information->smc_pptable == NULL)
>                 return -ENOMEM;
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC2C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 21:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69812206DC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 21:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EspnXNBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69812206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73726EB34;
	Wed, 16 Sep 2020 21:34:22 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590406EB34
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 21:34:21 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id m6so8409706wrn.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RxKic27vJ7o/BAEwCCnDRqJOzkS7akETC/NcmatczUQ=;
 b=EspnXNBH5AQQouYHV3JL+uL/7lRzXjssYBAtml3yh7qPS4sZR89uS/zuq+1og5l76C
 dFoWFkL3pK7OK+hmPGgbm0AAm+SWOfuJ4XVuA2qiSajke75rX8CmkKEjGXG9g48/b+u0
 I2e+wIZjKP8uKqzW4ZLKlbbrtxF4FajpMRgu1ay8pLKHakkOEdtL3yriE5VapoZghctK
 84Wwe7vhwG4Fdd3YL5hQXIzYFGTJzQW2skv2ACpB1drrI3Cp3pFoIDkYREKqmAYdQxbF
 qYJxhugHdPlcBx6TPAMSmASxhdZqKVXF+9Bu0mkv0ZiX7CdWAFzs0H5qVZSKdJwzIIRm
 pKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RxKic27vJ7o/BAEwCCnDRqJOzkS7akETC/NcmatczUQ=;
 b=D/ALToawGNPZYU0hNBCyUxn5zF6xijgNghGUiNJZgUfkcXhua/Ctos6zIuCsZi1j1D
 Vbp0/xt8QQZN0oVHoaFYv5LsfsG3sqxcyylmInED3/gHONa1PEiVG2qVNl8x19fiJG6U
 GqRurRrRN05wu1+6HYoACmfxyplmfdUJbkz+ngM9yupoUYEtJ9RAvcN59pdiskFzzTqe
 NX2VnU6hfnhpflbjMN1naKyULFKpHG6XOoYUfVfAXpZBngY1wsSIIfZCN2ejO7wEP5hU
 uwEv8DmiVs2ieadZzW4o34JrAibvq27392Vv8tWa1m25gc5PRsZnxRWVV2mEknazgCg5
 /C4g==
X-Gm-Message-State: AOAM530ZHqFFSj07osplpyj8y7DQ0wKX98X3GMGVaQmSFh9N2TWWZrvd
 U8u2kUdCsBqNH7BrocYfH0LpcZRwBZEkY278ySo=
X-Google-Smtp-Source: ABdhPJxruHMYBY5yVInIbs0eBF+rZZXwFHGQIRrOpMiNckmkvSWWinPgBcTo6wr3YvxfAHGImV1N0aeDhmXe4EH9BCo=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr29819853wru.374.1600292060036; 
 Wed, 16 Sep 2020 14:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
 <20200916193635.5169-5-qingqing.zhuo@amd.com>
In-Reply-To: <20200916193635.5169-5-qingqing.zhuo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2020 17:34:09 -0400
Message-ID: <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
Subject: Re: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
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
Cc: Eryk Brol <Eryk.Brol@amd.com>, "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 jinlong zhang <jinlong.zhang@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 16, 2020 at 3:42 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
>
> From: jinlong zhang <jinlong.zhang@amd.com>
>
> [why]
> while read edid return defer, then it enter to msleep,
> but it actually took more time during msleep,
> this will cause remaining edid read fail.
>
> [how]
> Replacing msleep with udelay, it will not take any extra time, edid return pass finally.

How long of a delay are we talking about here?  Some platforms don't
support long udelays and someone will send a patch to change this to
msleep.

Alex

>
> Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> index 743042d5905a..cdcad82765e0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -653,7 +653,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
>                                         if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
>                                                 (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
>                                                 if (payload->defer_delay > 0)
> -                                                       msleep(payload->defer_delay);
> +                                                       udelay(payload->defer_delay * 1000);
>                                         }
>                                 }
>                                 break;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D258FC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 15:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A168020721
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 15:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5AbIZXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A168020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619F989DB4;
	Fri, 10 Jan 2020 15:01:51 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D0089DB4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 15:01:50 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 20so2308196wmj.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 07:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=LmvavgXej8T7NaHU4jcU1tuu022oNdkEplcTNsASbUc=;
 b=p5AbIZXZ1qvefVoDLtH7CX7puxx46wJvmKLT4PCOr64EqmI/jUcV5Ndulyr6e5OHBi
 npAT36FEML9Azw65j5AbXR66q/+ZLbAqlApBabt9y7o06YsZOZGS24BVfi+k9NJfjBv6
 A2k5XSvkVnSRgAtuQ3cnmVHh/m9tH/cajBPQE4NjtxMm+tLlinLjVrqguUheqMSPkYMa
 u0Lq5G663kHZvk/Xy8XUKvxDGPk712r3hQxnk2ArCw6gvIb+9aN//5Uo0uUx1Res4Q77
 wGYd05pPKQoGL00pPIEkBJp2y19GSsrpEC8pqj04CLMaWfuMeZPtU7moJKELuz+H9QlN
 qY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=LmvavgXej8T7NaHU4jcU1tuu022oNdkEplcTNsASbUc=;
 b=beIIzgbDwFPLdu4H7KBlc5rUrossIsBfNggUQ3NjT5+iQr6CH3FpgMt5YlZIXs2XHF
 nCI43iwXC+QGZFyx0AX2LXTBIyUQb9ap7NJJ65IizhvCV66NhRRz2O/3UJ/VcsNxqmRp
 y6YeMpNrdCykearTf2HSOUe5l5FH6Xf0dWQGBCJwI8/ldMvlA3zdAqFXfiTfSTMq8wes
 551ZE67P9U64MH94DWr+HfsU/i5EWpCj4c91bI5vBdND7lxzNMbfvIgR0y+hfv5L/w9f
 R2BxelsAAgNbO7KqwOF33iuMvg4po6POXCQK2qcvfi/bAAwh6H4lga7J5XjN7B9q49DM
 2s/g==
X-Gm-Message-State: APjAAAX6N5sW+EiaIk9CVe4wDWpJRxRxSwEa7Mc+X1omw/Zwo6cS67lm
 91Qh+s/te+O5+tihWR8yXro=
X-Google-Smtp-Source: APXvYqyQAve35X3IkvlkWU0m1OpYwTjYQNmgLJyBsMXhePR6MuS5TlC/iMqQDigU07QHffAsapTKuQ==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr4901051wmf.113.1578668508902; 
 Fri, 10 Jan 2020 07:01:48 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s1sm2446559wmc.23.2020.01.10.07.01.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jan 2020 07:01:48 -0800 (PST)
Subject: Re: [PATCH 39/43] drm/amd/display: Use udelay to avoid context switch
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
 <20200110144655.55845-40-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e5846131-ed59-2790-30c1-c44b19ad8914@gmail.com>
Date: Fri, 10 Jan 2020 16:01:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200110144655.55845-40-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Martin Tsai <martin.tsai@amd.com>, Bhawanpreet.Lakha@amd.com,
 Harry Wentland <harry.wentland@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.01.20 um 15:46 schrieb Rodrigo Siqueira:
> From: Martin Tsai <martin.tsai@amd.com>
>
> [why]
> The rapid msleep operation causes the white line garbage when
> DAL check flip pending status in SetVidPnSourceVisibility.
> To execute this msleep will induce context switch, and longer
> delay could cause worse garbage situation.
>
> [how]
> To replace msleep with udelay.
>
> Signed-off-by: Martin Tsai <martin.tsai@amd.com>
> Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
> Acked-by: Harry Wentland <harry.wentland@amd.com>
> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index 89920924a154..0dc652e76848 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -1642,9 +1642,9 @@ void dcn20_program_front_end_for_ctx(
>   			struct hubp *hubp = pipe->plane_res.hubp;
>   			int j = 0;
>   
> -			for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS
> +			for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS*1000
>   					&& hubp->funcs->hubp_is_flip_pending(hubp); j++)
> -				msleep(1);
> +				udelay(1);

Why not using mdelay() here?

Christian.

>   		}
>   	}
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AEBC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 07:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7830620639
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 07:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFddHV8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7830620639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D106E2D7;
	Fri, 14 Aug 2020 07:16:59 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B6136E2D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 07:16:58 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id l23so6078310edv.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 00:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=vBtzPQuBaKHGDwEfVejUl3pxXJ+EaE60/nhdYDJhWvA=;
 b=pFddHV8MN9kMCg6vp79alfqzcrE4Wc02ADeRcf/K4yYc+waUekQS5Y/AM5DPfi/itI
 WZSJZ9h/cCW+YuGlW94WZ30EdanJm4Yex0SozJnWxJvq5jStQVl0xecPa2DWOQ5Hg/rh
 7AZzyrZp/1I2B7KoQdCNYJJ8tv84eOx4NpvwcD6PVhoDaEUBgB37biyzPAgcbrSk2hKF
 uTe+Zkig2Buvrt19BTb8tckToZsenrLZRr0rJ707mokplDkdGenLLM36mwa0K/dpHD87
 Qhur24J4nZOaBA4RD21JiMEHxglmJzSo0nP5eNzKOMe7dX4BofbJwhDpqBBwr0Zf0rb+
 dSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=vBtzPQuBaKHGDwEfVejUl3pxXJ+EaE60/nhdYDJhWvA=;
 b=b2H+yk2zUxUt30uEAeYRzUxc1adfsS9ewu8QFrjXsyAagcX0WrfJcNOOGPHjnaXvra
 8Znh9sHWiNmErAuMPuMKqiPVycxcSGkL20J6SaVMwdnfJzoeWK+bgR50I2Nq+yKMgE9r
 ae6pLRCwb/xezBIZr/Odyy59OZkOi+s9p31OUENMbClM8Kew3kcmcC+/TpU4EbYt9Wqh
 5VBBxDBxXqaRO1F/phAA4oLGU0Aq+nMna8O7jXh4QvH3x2ZGABWmfG2gBMfYHfUNQg10
 YJWsa0pOU12BNn425ObX35mMJRdjxxhIuZYzVGjVFfB2ylUDX/2bpoJsb90Su50xsy6N
 2R8w==
X-Gm-Message-State: AOAM5308j/pMDGPX7F3mA2l/vxCzmDUwLf+qq4hriEo9A/louIMR0jPK
 vdsyy2AL+Veq8DVEC/dtmJiyEUinEFg=
X-Google-Smtp-Source: ABdhPJwD80DGC94o+KefqPX7Q+PEFK/IdZk9LoEJ2w9w2MKfPCHT13vYUsn0fXeA5QLRum9TVEi4ag==
X-Received: by 2002:aa7:df0c:: with SMTP id c12mr964525edy.60.1597389416537;
 Fri, 14 Aug 2020 00:16:56 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id ss20sm6159853ejb.118.2020.08.14.00.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 00:16:56 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/jpeg: remove redundant check when it returns
To: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200813194047.13162-1-leo.liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e8b70792-c72f-fb7b-d27d-51cdef72f1db@gmail.com>
Date: Fri, 14 Aug 2020 09:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813194047.13162-1-leo.liu@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.08.20 um 21:40 schrieb Leo Liu:
> Fix warning from kernel test robot
>
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index c41e5590a701..f4ba423af051 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -465,8 +465,6 @@ static int jpeg_v3_0_wait_for_idle(void *handle)
>   	ret = SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
>   		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>   		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
> -	if (ret)
> -		return ret;
>   
>   	return ret;

You will probably get the next warning from the test robot with that 
because it can be simplified to "return SOC15_"...

Maybe even the local variable ret can be dropped, depending on what else 
it is used for in the function.

Christian.

>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

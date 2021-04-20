Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B0C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 06:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D50610CC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 06:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D50610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA47789FED;
	Tue, 20 Apr 2021 06:39:32 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1201289C9D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 06:39:31 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id h8so3486362edb.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 23:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=bP3mLmOH3dFDeDYEza/DfVoAuYeDk4+wzXBQd0c5dQA=;
 b=qYH0V7hqhLTgWbPAh7SxqicxMri/fDZSkM0BnQVklT84u0gVcKRaUdqPuube9JNLOX
 K8rPKaGct54TjmTkr4YDT6QmhNZbMGXJBRPlqmUEK/Ip+Jl/y6ItYyagD8c2LPf/n0lS
 /zcA9w3VmSwp47XPsfQnDc9tqR7ByZRDu86HVEwDK+5o3HMJPDcuNJmcxGY1PS3roLoW
 o0XvSbc2bE+oJrl5A/G3+zO8ZOxZNypD/GpnQVdflomjmdrSv6a+nbge4TFHmc6p7CV7
 J0Z5hmf6Cbmupx/JjrPhAFj9/5SxOi3UAAsx4NHpYEJM4+bHEubJotCYvLyGRv+0/yam
 otJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bP3mLmOH3dFDeDYEza/DfVoAuYeDk4+wzXBQd0c5dQA=;
 b=efYcWemjFOoZEPpVraAi/P7+OC7nY8KQK1ZW7r1yvKSSfrKIC7agWkMoXsQYBXnFsE
 +AO1hsxCq8cKhJDaRZppwSfiSyCls/wq+686+c7xijNd1Kh5pqhZ5H9RCGJBhZQaJsN4
 lsI/TO380svM26a/wODTJICrVfsrUneveQV1x7u+7DpopN/AwvyXBa6Oickm2bGaBtnF
 314rzHB/T+ibD7RUYPpcbxFpc9Kra+DC3FOv6DorwHr+wtQou4TClcbIp9NomGPdJ4sd
 Ga0u+6eWjUICxgQo5DK6MatX8M+1dS0/GwH97/Ew8jt3wqJIXupm69b9DrZiKLd3rX6+
 rNaw==
X-Gm-Message-State: AOAM530IF5Z6JlTConf81uFc25ljrTsxsd2YnmFVcsg1IsKHzUiA/NLn
 9Km9/YriT9XpK9lw/6927Eo=
X-Google-Smtp-Source: ABdhPJxppVbPzSQrDDDZCO1w6uodnSlXIyRoYFPK+6RKB1AGt6aXB0p7pH/dZZX7WF4dIpGW5Hpwcw==
X-Received: by 2002:a05:6402:199:: with SMTP id
 r25mr22037948edv.128.1618900769760; 
 Mon, 19 Apr 2021 23:39:29 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3caf:a441:2498:1468?
 ([2a02:908:1252:fb60:3caf:a441:2498:1468])
 by smtp.gmail.com with ESMTPSA id g10sm16100468edf.82.2021.04.19.23.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Apr 2021 23:39:29 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add mem sync flag for SDMA IB test
To: Jinzhou Su <Jinzhou.Su@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210420022340.365464-1-Jinzhou.Su@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a5be6441-625f-3605-0ed7-c2cec03c9a18@gmail.com>
Date: Tue, 20 Apr 2021 08:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420022340.365464-1-Jinzhou.Su@amd.com>
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
Cc: ray.huang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.04.21 um 04:23 schrieb Jinzhou Su:
> The buffer for SDMA IB test is allocated by sa bo
> which may be used by other purpose. Better to flush
> the cache before commit the IB.

Good point, but shouldn't we do this for a lot of other cases as well?

I think the only place where we should not set the flag is in the CS IOCTL.

Regards,
Christian.

>
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index b1ad9e52b234..da67f440b102 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1000,6 +1000,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
>   	ib.length_dw = 8;
>   
> +	ib.flags = AMDGPU_IB_FLAG_EMIT_MEM_SYNC;
>   	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
>   	if (r)
>   		goto err1;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EACC433E9
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 09:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A5964E66
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 09:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A5964E66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157826E844;
	Mon,  8 Feb 2021 09:28:24 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFEA36E844
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 09:28:22 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id s5so17229665edw.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Feb 2021 01:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RqpqlhipveqcBiuMXtJzDT48U2k7wTtAD8aQNtWdrwE=;
 b=X0KKH00iQbfHWQytCenR88DRrmlAuKGMVBkDs93scQcTYYmFqC3TzDg7Mqcx+q7hIS
 kS8UjhjzXy45qYjv+jcw5wGqWlpeyobgyb212WNNopLjMPfF5UeE8Y6x5voFRntWKgyD
 1yKD7zUoKv9h5ITRW/oDPZnsuVVLqBYJpwSZscXfbKqUBFl15/bei3KVDyQnkk7Pulti
 pLff7ySUHjEGC++p0ve0RLTGCnR0hUIqIXdj/Y7F6GB3wTR6LKS1LAg7S8OHrsrmjsL1
 5lj+twjNSTz6/sDkVuy3BjpihmEZBW7QQCBc9HyltHbGXJ5G04vN7CADkSSiqhpwtYhG
 5kqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=RqpqlhipveqcBiuMXtJzDT48U2k7wTtAD8aQNtWdrwE=;
 b=AI7LY5MvnMSM/E82Y87/hpyO3ZWfCKnMXSRikHnsirMXFzQl3GMrscDYuQIF83+pGw
 AaGxk8NjBpUDhH/p29uxUbeX36EM0ZBTXQY0xlYLWl9OGmaJWTtRG3iAVR5+c/+l5xPN
 EPr6+nkpF44jNZFpfDOloVk+KGsrv8RxnAO5XPQIVIf5PIM5HSpImZ++eq5WFJWU/S5v
 hWnoebdut3nnKEE3Jyfd1VrG3fN59dM5IQAecNskVBs5rlY3D9b9IMYr7K+I1t47VcqS
 hGEXDgYvT/3AO4xybr/chQkQwYFkEYbjwWVvIMQuez/3tNkfWGjwclFy5RfEMh55A4Fc
 QVPQ==
X-Gm-Message-State: AOAM530nDHxJ8RdYFSOMAQsXH07Aaq9nZTr4+udLLwLIJEkbbd0WdrRm
 R0ogwmxuZ+5vHT9P11irN6w=
X-Google-Smtp-Source: ABdhPJzyS6sE4rFi1s0iafXFTBP2KPqV9BT77bxoRa3rEO1vXovMf5UufbCGjm/1m5VkONRTxv8ASQ==
X-Received: by 2002:a05:6402:2547:: with SMTP id
 l7mr15778939edb.157.1612776501570; 
 Mon, 08 Feb 2021 01:28:21 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a15sm7491189edv.95.2021.02.08.01.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 01:28:21 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: extend MAX_KIQ_REG_TRY to 1000
To: Jiawei Gu <Jiawei.Gu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210208054555.23421-1-Jiawei.Gu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <13337a59-f698-a91b-5662-1673e14a3cd7@gmail.com>
Date: Mon, 8 Feb 2021 10:28:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210208054555.23421-1-Jiawei.Gu@amd.com>
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
Cc: emily.deng@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.02.21 um 06:45 schrieb Jiawei Gu:
> Extend retry times of KIQ to avoid starvation situation caused by
> long time full access of GPU by other VFs.

In what units is that? We also need the KIQ during interrupt handling 
and that looks like *way* to big for that.

Christian.

>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 639db32c1383..e0c797a5f739 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -288,7 +288,7 @@ enum amdgpu_kiq_irq {
>   
>   #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
>   #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
> -#define MAX_KIQ_REG_TRY 80 /* 20 -> 80 */
> +#define MAX_KIQ_REG_TRY 1000
>   
>   int amdgpu_device_ip_set_clockgating_state(void *dev,
>   					   enum amd_ip_block_type block_type,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

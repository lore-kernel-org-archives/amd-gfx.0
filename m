Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0F6C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 09:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A6802072B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 09:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt9WnkWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6802072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB4C6E2A5;
	Wed, 18 Dec 2019 09:56:41 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B240A6E2A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 09:56:39 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id q10so1529745wrm.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 01:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XXOWwgWPraFKwdEGL/gM6LhhvXbrnGcdQMSxJGE/2Bw=;
 b=kt9WnkWTo8/ZbNzuVdZfjR3444crZNnL2e013ZVlBVzxSP8+wveWLkIe/TBH5PJxli
 L9hsEgWnZ4T73eyHBZ99G4B7pMVldIwhVippDI95cac6VKs4UcYNjJbtBBsmOFme1KT5
 kn6F9JuO0mvMlgcYc8kgfH0px4Rabo/tFmgHunrg19WC5Du9MJiVLyIqg1aP7yTIOGRO
 VNz0Q/qeM95IMBtG6gG2yaO/bN8/3yE7ZT9uGuVGB8VwIeidj//427l/IK2YhKoX44jH
 GVEDHmuQ0nrDcL07sMov6D4z0LpbK1BxX77/R8gY5S5cAcRJo7yLkWuKat2hqViOxUOU
 PFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XXOWwgWPraFKwdEGL/gM6LhhvXbrnGcdQMSxJGE/2Bw=;
 b=BUgVBRycvREfpbb9Gu0tRvKOaOo4fPYWoapJfVOWSL12q3xIvI3q7uol1cFsI6rXKf
 xv+RqRkF9JYaOjFmpCoBEpGkwTK78B1jbhAuhWFjG7CpDLT+oCm/kRltBlm4UEej4Cga
 wi+NpkUTvdaruZIiJlEBRbpHKUKfcfUWjqX3LLRA0MW2zzOt+vJt1ojxHBYsy58UMkYE
 98tvpZqITKVqzuGik4EBWPrgc7lQSMILxRjkQTVlr3DgirYxnn25IulZV2LVXBVt38Vu
 XSaQkPLChg6igJ4xzEepaDx61o1xy+eAYrjTV3dItoCnshKecEL5KEhfullRJnTNj9jb
 GkbA==
X-Gm-Message-State: APjAAAXMi1vUFQxCns9jFwhzYkLUAPzBWnPYy6135QhDUcModb5mlaWk
 ZZcXOa6UXjjij1bosewWX8Id58OB
X-Google-Smtp-Source: APXvYqybl3UT/BBoLcSu9pj9TkMpl5uZkg62vxO4Pf4TSXFx9JsT+7upAaPtNIj6s+mNga1l/TczPA==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr1774854wrm.210.1576662998227; 
 Wed, 18 Dec 2019 01:56:38 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id x18sm1958031wrr.75.2019.12.18.01.56.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 01:56:37 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: correctly report gpu recover status
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191218032534.28482-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5ae5f01d-e7cd-d6b4-2433-90c03809e1b3@gmail.com>
Date: Wed, 18 Dec 2019 10:56:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218032534.28482-1-evan.quan@amd.com>
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

Am 18.12.19 um 04:25 schrieb Evan Quan:
> Knowing whether gpu recovery was performed successfully or not
> is important for our BACO development.
>
> Change-Id: I0e3ca4dcb65a053eb26bc55ad7431e4a42e160de
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index e9efee04ca23..5dff5c0dd882 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -743,9 +743,7 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
>   	struct amdgpu_device *adev = dev->dev_private;
>   
>   	seq_printf(m, "gpu recover\n");
> -	amdgpu_device_gpu_recover(adev, NULL);
> -
> -	return 0;
> +	return amdgpu_device_gpu_recover(adev, NULL);

NAK, what we could do here is the following:

r = amdgpu_device_gpu_recover(....);
seq_printf(m, "gpu recover %d\n", r);

But returning the error code from the GPU recovery to userspace doesn't 
make to much sense.

Christian.

>   }
>   
>   static const struct drm_info_list amdgpu_debugfs_fence_list[] = {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

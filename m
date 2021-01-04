Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBAAC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C7F2068D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C7F2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E80E89EA9;
	Mon,  4 Jan 2021 17:47:24 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8770689EA9
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 17:47:23 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id b9so37956185ejy.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Jan 2021 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=flBhyOyhrH9xCepSc4nNnjAY1UAnKviJExzkFVHFLrM=;
 b=YPZe6deCUaR7lZpC64S66Rx5sDSgIZDi1pABgt2hBr8tjS/YicZ2v2Sj93FpBF/iu6
 e+WNYFQInWYrTOXFgr+y8+eG4E+ZI0kp9gRaCCfwLB4fDdDNoV9Z9vqevWY1E2LZs763
 v1gT49UfZ9pwmT6RN+zX1sazapOJf9CbDJc4A5D6tHS5uUCZONZtkPyx70dk3Z3M3Hpb
 WgvZWVY2cL/tvcTYxkvOmH0g/wG3TZU4agyk3Kix6lV0Lj1c/Ig80H9s+4hFfyrkerFj
 natartWDQhb4+MM1SLrwdT3BkWM4pysLd/N96kR4SwbZOvtqiel01BJ0atoFBfrnDOEM
 CPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=flBhyOyhrH9xCepSc4nNnjAY1UAnKviJExzkFVHFLrM=;
 b=Mtk9bPhmS98rXrjvOy9mBRMuZ4TjN+LZc68QhnuXZ/lSPxDJn//KD8cAST0wbt+Xgd
 v5h8kw0NEOuwJlh0JvMbgxF1o7UcM+vHylh0TaP0a5yJQUH1vd3OVs0p8lqz6jDhIn3T
 GXgno6H6nw86FpU9nVPgcAEK69Qidrkcjdqa8VayVD0aunbKhgiI4PY2DVpHrtBQ7J4V
 59lH0BDwipITPBKZRyGFbCccFFugvtLPtr9zaR/UDkxrZ5XiLYvv+PWZfpf144AQBdop
 vW+4sSrhMfgpTqZyLc044XrjmkHi/u04lefO9pHKdoLOlnWcUgc+TF+0cLbj4Aggya0F
 k6jQ==
X-Gm-Message-State: AOAM530iXoO42qzQTek5AVP1BvrizoGZUX0VjPZkGOglW7zN0P2uvpff
 cwshrcaAFtCfFsY/ORtT1qo=
X-Google-Smtp-Source: ABdhPJzoNRsdAktGRiEgyIX8vQxcGUQZqQKieKEf2id8ZRx4EBSvCfBAAWqo2dtjVBszMkGrFX8mWQ==
X-Received: by 2002:a17:906:edc2:: with SMTP id
 sb2mr55470817ejb.159.1609782442275; 
 Mon, 04 Jan 2021 09:47:22 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id gl23sm18932339ejb.87.2021.01.04.09.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jan 2021 09:47:21 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: check the result of copy_from_user in secure
 display debugfs
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210104174349.609143-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <995d51e6-274e-ab2f-3da4-a8dc476fc19a@gmail.com>
Date: Mon, 4 Jan 2021 18:47:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104174349.609143-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.01.21 um 18:43 schrieb Alex Deucher:
> Make sure the copy succeeded.  Also fixes a warning.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 455978781380..1f98ce4e56f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -101,7 +101,9 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>   		return -EINVAL;
>   
>   	memset(str,  0, sizeof(str));
> -	copy_from_user(str, buf, size);
> +	ret = copy_from_user(str, buf, size);
> +	if (ret >= size)
> +		return -EINVAL;

IIRC copy_from_user return the number of bytes which couldn't be copied.

E.g. theta should be if (ret) return -EFAULT.

Christian.

>   
>   	ret = pm_runtime_get_sync(dev->dev);
>   	if (ret < 0) {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837FAC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9B660FF1
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9B660FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A707A6EA7C;
	Thu, 22 Apr 2021 12:49:53 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC366EA7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 12:49:52 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id u17so68638311ejk.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2WeibtfZJkAM25qyr/yyXnweu+ZHnak57pk09WqPzqE=;
 b=gOxHBXKyhoawnkOW265lb7zMD5TsvNo0og6awAxKs9Sqzwtk3xgAruvdulA5OB+h/x
 QCMBMDSVRYX9BXU5eDYDMSvN2QLb0XsyyxrLRw27zCOPWUP/3DiunP4beHo6ZStULmey
 1c3TD3Woix3J1otqc5J7g2d+ut4BpCpz05ppekmaPXxBchQOAG/XVC3xrrU6U7oUmP3e
 fCqImJhhEQFuSSQ6Sp5Rnigs2QbyLmEt2e4/oALFziJAkXUSjKDO5eeHdW0V2n2iUEBe
 02OC/aINOzAUJgI26dN/x5PI0MwQBfbyrHz7uVC8nWj8KO+GOXHKjqtO7Joe4TueBGEd
 6Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2WeibtfZJkAM25qyr/yyXnweu+ZHnak57pk09WqPzqE=;
 b=O/7ven8Al1hnAtrGRzUmTfGzy5nvWJjQTxFQQMsmL866w6ooE67MHZCPF5NAeHvyX8
 pU1nazrSyse6U0HW6f/2y6sXHMsF50CrnW7WeDMUhTM3nFDBQR4ozXwN8GZvaGk4UuIJ
 p8x0k0ZOgwB15iauEI+mGnR9OalaoqXnoq9oBaaxhVnjn4TLhasgAxIUK3a0q5RbQdpI
 h6vMD757ysXweauhwwe7iMGnN5l1eUrcSNAoBJ1a07RQvLCVlqb5y5SGp3UqApAozjxo
 IxnT3bGKzmb0VemtVyfzYvt/c4fZ63Mpf5yBN/GVEQFe1Mfu+yoJ0lsFzFwzDqcqmr7w
 2fYA==
X-Gm-Message-State: AOAM530YgPf6dK5FTEQawqqjx53OIIvhhdSTe9Lik5xYjtjO5N3PqsH6
 mOcgFeC2XYffqV1ggueA4puSeqcOOAo=
X-Google-Smtp-Source: ABdhPJyftyxArc5PS/vYyLNbidRTMMn4b5iWshWWs7Yu7DFPjyv2q5GMqrt05DQ1EfC+ZLG7vcrk+Q==
X-Received: by 2002:a17:906:5fce:: with SMTP id
 k14mr3295144ejv.9.1619095791214; 
 Thu, 22 Apr 2021 05:49:51 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:2fbd:d2a4:da7e:4526?
 ([2a02:908:1252:fb60:2fbd:d2a4:da7e:4526])
 by smtp.gmail.com with ESMTPSA id b8sm1830851ejc.29.2021.04.22.05.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Apr 2021 05:49:50 -0700 (PDT)
Subject: Re: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_create()
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210422123545.2389-1-nirmoy.das@amd.com>
 <20210422123545.2389-4-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a9719a1a-9289-4409-437b-d7ca510fe063@gmail.com>
Date: Thu, 22 Apr 2021 14:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210422123545.2389-4-nirmoy.das@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 22.04.21 um 14:35 schrieb Nirmoy Das:
> Remove shadow bo related code as vm code is creating shadow bo
> using proper API.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++--------------------
>   1 file changed, 2 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 9cdeb20fb6cd..4256cbfec5eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -661,10 +661,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
>    * @bp: parameters to be used for the buffer object
>    * @bo_ptr: pointer to the buffer object pointer
>    *
> - * Creates an &amdgpu_bo buffer object; and if requested, also creates a
> - * shadow object.
> - * Shadow object is used to backup the original buffer object, and is always
> - * in GTT.
> + * Creates an &amdgpu_bo buffer object.
>    *
>    * Returns:
>    * 0 for success or a negative error code on failure.
> @@ -673,30 +670,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   		     struct amdgpu_bo_param *bp,
>   		     struct amdgpu_bo **bo_ptr)
>   {
> -	u64 flags = bp->flags;
> -	int r;
> -
> -	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
> -
> -	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
> -	if (r)
> -		return r;
> -
> -	if ((flags & AMDGPU_GEM_CREATE_SHADOW) && !(adev->flags & AMD_IS_APU)) {
> -		if (!bp->resv)
> -			WARN_ON(dma_resv_lock((*bo_ptr)->tbo.base.resv,
> -							NULL));
> -
> -		r = amdgpu_bo_create_shadow(adev, bp->size, *bo_ptr);
> -
> -		if (!bp->resv)
> -			dma_resv_unlock((*bo_ptr)->tbo.base.resv);
> -
> -		if (r)
> -			amdgpu_bo_unref(bo_ptr);
> -	}
> -
> -	return r;
> +	return  amdgpu_bo_do_create(adev, bp, bo_ptr);

You can just rename amdgpu_bo_do_create() into amdgpu_bo_create() now 
and drop the wrapper as far as I can see.

Christian.

>   }
>   
>   /**

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

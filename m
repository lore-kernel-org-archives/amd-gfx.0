Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C8EC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 15:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4832E61492
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 15:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4832E61492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA396E4A2;
	Mon, 28 Jun 2021 15:24:17 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB926E49D;
 Mon, 28 Jun 2021 15:24:15 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id m14so26510789edp.9;
 Mon, 28 Jun 2021 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=0LCVnEUyZC8u6yOvz6qXUXn2QdP+8Q1Q9z+2JP0JGTs=;
 b=dyCRjuzq/VZcMN4nrzOQIFRNg+prWtPH5e38wGOHqSJ6IueKTDIbpHXHH2mIqh3VwI
 gm30J8QP4XBpCaY9IqkaM/t9o0XdMvuY9jOca8ZSHq5FsmukLZeNhFs1c4HFXmT/n1xb
 +VHBXKDrsuO8OfHMjgVisu0DMqYJ+1Dly0CENXGZu030mD7Al9z6z3sbPpj/D4HNhVMM
 ayCluRXw+9A1KKy4DRFcSYOZOHa6vcFw/LarlVD/Tb0oMMeUsncufriV3VDjSxMS+UWg
 Uh11K1aJk6sVH/sE2dTpnj18Qy5fqhgosRbJ4FP3NmiAJ2gdU9stUbNHyGssYp5dE7vG
 eGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=0LCVnEUyZC8u6yOvz6qXUXn2QdP+8Q1Q9z+2JP0JGTs=;
 b=Lo3jlT54IcWqjz6fQuvCytXhPd+rPZiEAXitWBBoYbkZCo4x/sOI5+VnUAFPv1mdQ6
 1JDEdk4Uu6XEd01cIddipUh6GLsCDb9ziPgBJrvNSwUFuHpeun9AyPDYiqMQKsNLT1Tq
 yoxFr9KJ8pdUxEGQ2p8P6nM6tw1W1hZEghcIgwwC2nZWyZ/foSIRfW4ATu7CdJN3H63Z
 xpOcMWfv1oV1QCc0aFA0btEx+FY8oCfrMMq8P7n48BA3uFy8BHwPwSwZU49Mpd82slSi
 7I0eh0RnTWSJ2mqDo5gdNQNRlyqIfNfbQqJbzDP8AhVX6wgl5M3c/Oa/8rH9niJmvD5r
 lXsA==
X-Gm-Message-State: AOAM533pLUQP0mOkaoMm0WcLdqrObA4/8N2eA3um/ePUmJXELn8HROWr
 cwJSfffNicdTKh8KQ9feCjs8p8OLdzg=
X-Google-Smtp-Source: ABdhPJxhRGk1DmD/KCMuAj6u6fHMksSa4KlGvbpmDD73g10MeSNBNT71TNGttHRSTiLPWL5ndlXvIw==
X-Received: by 2002:aa7:da02:: with SMTP id r2mr14736444eds.350.1624893853792; 
 Mon, 28 Jun 2021 08:24:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:9e19:5c9b:7f42:aee2?
 ([2a02:908:1252:fb60:9e19:5c9b:7f42:aee2])
 by smtp.gmail.com with ESMTPSA id k21sm9587163edo.41.2021.06.28.08.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jun 2021 08:24:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: return early for preempt type BOs
To: Nirmoy Das <nirmoy.das@amd.com>, dri-devel@lists.freedesktop.org
References: <20210625172804.3193-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fd8b70cd-dca9-ffe8-cfb0-c7a8859b16f0@gmail.com>
Date: Mon, 28 Jun 2021 17:24:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625172804.3193-1-nirmoy.das@amd.com>
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
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 25.06.21 um 19:28 schrieb Nirmoy Das:
> Return early for AMDGPU_PL_PREEMPT BOs so that we don't pass
> wrong pointer to amdgpu_gtt_mgr_has_gart_addr() which assumes
> ttm_resource argument to be TTM_PL_TT type BO's.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b46726e47bce..3df06772a425 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -926,6 +926,11 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>   	    bo_mem->mem_type == AMDGPU_PL_OA)
>   		return -EINVAL;
>   
> +	if (bo_mem->mem_type == AMDGPU_PL_PREEMPT) {

Probably better to merge that into the if below.

E.g. if bo_mem->mem_type != TTM_PL_TT || .....

Christian.

> +		gtt->offset = AMDGPU_BO_INVALID_OFFSET;
> +		return 0;
> +	}
> +
>   	if (!amdgpu_gtt_mgr_has_gart_addr(bo_mem)) {
>   		gtt->offset = AMDGPU_BO_INVALID_OFFSET;
>   		return 0;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

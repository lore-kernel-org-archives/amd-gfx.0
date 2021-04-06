Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D067FC433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 12:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3226124C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 12:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3226124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032A789C52;
	Tue,  6 Apr 2021 12:43:47 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB63C89C52
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 12:43:45 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id u5so21715164ejn.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Apr 2021 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=tRR7tHKzBeVZUQ/+KQ8pXh4IwiwdDSrI2rC44zXWE20=;
 b=gN2hVLqcF26V0dNe9DTDC5sqRFDiHmtCNuYDbdBznrAYl4zmoZ9AllgnQ6QlmXWChl
 xKvZcRD9P+c0OmIhi7bBXRZrLQ1ou33mtrtThg0gk+wu1rIpUYVVE+pcuQz/N4kRHzKJ
 JempvZGjpewM6NHTWgqvNf2MJW4skwCTb+AseEhTxOD/XoW/M05zHEgeTjIUTisMFQul
 4Rqaes0d+W3hlJh6o1VOJjEYNolp9FloUdV6SrImhoLWHZ5M0qmvLyE+6sI0D/viW/ZI
 TUoZf5CE5q2qXHo4LtLV+kyVsV3qkhuZmhUt7bvIGkSf+dhIpHLosgO5GAvdGxX+AcuN
 bJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tRR7tHKzBeVZUQ/+KQ8pXh4IwiwdDSrI2rC44zXWE20=;
 b=dlpCjIxUpQ49zUT+i9CjJxZZeq3g/5gKJxkc11pA+kTZLK1/sMSZdrNg0uPUwY7oEg
 LMkp2fzvHnDHkIsyccmoRFFENO1dLrbQerohpXHn0wmMssIfuqJ4hbutoC6lIt8znKgf
 4lFYxOvqxMr6LgtiBBkH8QMMDE2GQzu3Ud/GuZ//7Ad5qDeIoDZx4m2NgcMUhTGpvOBl
 JepIhHuzJ873wd+juAwcfKkNxJzHICSlzyio/ErvhuwUs96gvCqEfp9vXYJsqLqUrjSV
 Ea7nE/CsyDQ4nVVLXiaeev1kZ4mlMqG03rKYSmArGVTdfC2hkAktvmUWGwVcKLVIqdsE
 kPlA==
X-Gm-Message-State: AOAM533Zi5ptpxNbniEHwazkTxQzpp6CSdqu5XQd0pnB4QMJldOQ16mF
 viGu9wmxjSA2RCnsE7jsaRUpKCLjuUE=
X-Google-Smtp-Source: ABdhPJxG6QDIi9udm2efydZ5fnlghviwq7UmBnYiCcJgsNXCLva4/jLM4qS1yg8aj5SQPBAVCK158g==
X-Received: by 2002:a17:907:1b19:: with SMTP id
 mp25mr11181159ejc.154.1617713024596; 
 Tue, 06 Apr 2021 05:43:44 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:b166:1569:a6c7:85bf?
 ([2a02:908:1252:fb60:b166:1569:a6c7:85bf])
 by smtp.gmail.com with ESMTPSA id q2sm11003657eje.24.2021.04.06.05.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Apr 2021 05:43:44 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: Cancel the hrtimer in sw_fini
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210406122111.23989-1-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6cb64f06-34ef-1336-efa8-58708dc90e20@gmail.com>
Date: Tue, 6 Apr 2021 14:43:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210406122111.23989-1-Roy.Sun@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.04.21 um 14:21 schrieb Roy Sun:
> Move the process of cancelling hrtimer to sw_fini

They why you want to do this is missing here.

Apart from that looks a bit odd to cancel the timer this late.

>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> index 5c11144da051..33324427b555 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -421,6 +421,11 @@ static int dce_virtual_sw_init(void *handle)
>   static int dce_virtual_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	int i = 0;

BTW: Please don't initialize variables which don't need to be initialized.

Regards,
Christian.

> +
> +	for (i = 0; i < adev->mode_info.num_crtc; i++)
> +		if (adev->mode_info.crtcs[i])
> +			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
>   
>   	kfree(adev->mode_info.bios_hardcoded_edid);
>   
> @@ -480,13 +485,6 @@ static int dce_virtual_hw_init(void *handle)
>   
>   static int dce_virtual_hw_fini(void *handle)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	int i = 0;
> -
> -	for (i = 0; i<adev->mode_info.num_crtc; i++)
> -		if (adev->mode_info.crtcs[i])
> -			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
> -
>   	return 0;
>   }
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

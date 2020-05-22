Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32925C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 10:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027702072C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 10:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmYlQJ7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027702072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B946E9BA;
	Fri, 22 May 2020 10:25:54 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2EF16E9BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 10:25:53 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id l21so12407449eji.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aBOWTPtnc0ReaFHmEMLVuOTOnQtKiaLHCOv35hRAifo=;
 b=mmYlQJ7bDWVTj9dARBZLAstm9getbp5koX5yYZFDbEPeQ0C2TrBB2ys5zxokBfUb+o
 slqTisr1ZC0GRqC+XcWXJxUKW7RaF1Lg4ezZbpppbtNiWT87qNRRL2NXLfTg6Bsg6MMN
 53sdkvyEWqH0eXMN3tB1HEoOsY2gvkWVTHhrnAPglvatmAQQQKt4llqIBd4+Kj4wOrPh
 8jXH/m9GXNnXWvaIpcfv30JxD5Ab7P6zM2+0FeHKHEBctqT3Y5Jh3O2M024yJkBqEJn/
 Y4bc1D378sBf638x9XTHRHW16lWPPwAQbUCcxZCNFbcICtW8jBOeAe0fUv0AUBcj/8xK
 L/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=aBOWTPtnc0ReaFHmEMLVuOTOnQtKiaLHCOv35hRAifo=;
 b=O3tyZOvOSfa+cJjhGJU57CAo6CQxfW0/Rd8civaA//Pq+uJvMv55hm/PJRn5bit6zd
 tiCI6gKRYHqzMCxfuOTHeQqnzsxI+8YfXP7k4r/MFe3HjJPrj7CTCKefHy0xn9nu2+aL
 GlNSl7QrVXvc9rNk8gPO0AYqVvUQLaHy96IXGw5fOlz8WYuXkzgM55MqDpmpk6/K8xYv
 eVEGvNV1HdmI/313DXV05pnyLDpb22NC3NFUWhswMUhiRgY9xi4oI8T1/T54fmwG1qC0
 Av8lN+2f6rWiME5eXxZNgimSlLEhGb0ifUz7wHXRvwCLq5vr48qIxMaIAd6aFXktLzcV
 /Qeg==
X-Gm-Message-State: AOAM531s+lQ9oWTnSMDkgjabWX+nGdrJXj+th+JHL2dZTp0kFnUX6CQ5
 ghJre7t3CXMW0ECkI/qziKg=
X-Google-Smtp-Source: ABdhPJyCsUciFuDdWTxHo40IBw6ozvG6CUcCSwl43nWGAdXpEEFJl87DmeN6kz5aoYxJ+tV6GxDr8g==
X-Received: by 2002:a17:907:447c:: with SMTP id
 oo20mr7249392ejb.385.1590143152299; 
 Fri, 22 May 2020 03:25:52 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id mf18sm7534735ejb.16.2020.05.22.03.25.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 May 2020 03:25:51 -0700 (PDT)
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: off by one in
 amdgpu_device_attr_create_groups() error handling"
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200521202308.1996496-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a6e85019-8c0c-fab5-2ebe-431662c9b646@gmail.com>
Date: Fri, 22 May 2020 12:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200521202308.1996496-1-alexander.deucher@amd.com>
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

Well what exactly is going wrong here?

At least this one looks correct to me, and if it blocks the revert we 
should probably squash it in there as well.

Christian.

Am 21.05.20 um 22:23 schrieb Alex Deucher:
> This reverts commit b41d9df2b680b96913cc3ccf929252e2dce71b24.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 2fc51f815eaa..72bbb8175b22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -1843,8 +1843,9 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
>   	return 0;
>   
>   failed:
> -	while (i--)
> +	for (; i > 0; i--) {
>   		amdgpu_device_attr_remove(adev, &attrs[i]);
> +	}
>   
>   	return ret;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC4C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 08:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB2C21D7A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 08:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB2C21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51FF6E17C;
	Mon, 18 Jan 2021 08:49:02 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BAC66E17C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 08:49:01 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id g12so22521727ejf.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=tsguF2I4Zr+y2yx8obQm+kyJq0F6TVvfPoqWfxl/zmc=;
 b=O+CobQDqjBQ6vTyxfPU4qgbBqqpTICYApP25aRlp73KlKMkFBB1uZV1TRpJOf/rgBQ
 927MmR8GjD+9NuzYqli0ImpDXT18au4BS2B59bFkUKVdJ+iuHPoiDojudJFBcoqoctzV
 CDYYAmAE4c+Wsk1umHa3faRCvHcPMmQCOzgcmjsX4NEeBh9Z0FGyhutkkgXgYsJ5Goc/
 whbEgyH1XdOio8u84CT9aSOd8512tDiTc7W0gRzuO5+LT4OC0KoKKQHu7b7JtMlPHuhE
 LAa2sFaNEk952KbwTaxXY6mQCXXf3Ajni5bxqrjY/Wzt57eNCAS1KQ8XC8cB0Vf8noVy
 0mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tsguF2I4Zr+y2yx8obQm+kyJq0F6TVvfPoqWfxl/zmc=;
 b=UAcu2mjoTXmejH4PA+cxZYvRXG0PwtEQQ8wC5ssizG5Ysln9pLOh1ExailMLxxq2Pw
 UolSPs5mrg6TMGCjaUImYFNhaOSmU5d3kc8Q1h6/ockoPiUh2cCDsVP4caWo1n1heLEN
 BPTaIe1mvBZMHhS9pjDX0RhCIM4D+Xr6eloxLPl5EDSXlePbo6NxICHGfUs9m6b+yrih
 XCHw2lD3Uob1hQj//uu3GfahQd8+uYpUb5BWXGEKOKrRtDKiqnWuVKHTXwEFlcgLYIXi
 X3+SatQKkfJPIz+d4YGvreXvNLxU0bbNzDOyrOVeOC5RTEFRpNgDPaCpByrGGf3xphnM
 KDew==
X-Gm-Message-State: AOAM533VKfLmFm7hvGT6rUYT+bZ5sLA22RYfCzPfItIb7e9ecQYQYpWB
 bHema5NmvlCtL/E2iDiLWQVzjuHzYHE=
X-Google-Smtp-Source: ABdhPJyxXj+63b+mYskXbc9M1q/wkh+XQUM+tyhSfW3buJSBN4lhrmQP8sd02pW9SKQZKHltgtswMA==
X-Received: by 2002:a17:906:ae9b:: with SMTP id
 md27mr7922260ejb.357.1610959739948; 
 Mon, 18 Jan 2021 00:48:59 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id w11sm8790630edj.8.2021.01.18.00.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jan 2021 00:48:59 -0800 (PST)
Subject: Re: [PATCH] drm/amd/amdgpu: remove redundant flush_delayed_work
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210118024714.2730735-1-Jingwen.Chen2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b2c99226-0698-5ca6-11e8-e4bbf2674cd0@gmail.com>
Date: Mon, 18 Jan 2021 09:48:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118024714.2730735-1-Jingwen.Chen2@amd.com>
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

Am 18.01.21 um 03:47 schrieb Jingwen Chen:
> When using cancel_delayed_work_sync, there's no need
> to flush_delayed_work first. This sequence can lead to
> a redundant loop of work executing.

Well the difference is that cancel_delayed_work_sync() cancels the work 
when it is not running yet and waits for the work to finish if it is 
already running.

flush_delayed_work() always waits for the work to finish.

You need to remove the cancel_delayed_work_sync not the flush if you 
want to keep the functionality the same.

Regards,
Christian.

>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 3e212862cf5d..c649944e49da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -569,7 +569,6 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
>   {
>   	if (adev->virt.vf2pf_update_interval_ms != 0) {
>   		DRM_INFO("clean up the vf2pf work item\n");
> -		flush_delayed_work(&adev->virt.vf2pf_work);
>   		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
>   		adev->virt.vf2pf_update_interval_ms = 0;
>   	}

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

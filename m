Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5A3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 07:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F458B719;
	Tue,  7 Dec 2021 07:03:32 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD908B719
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 07:03:31 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 az34-20020a05600c602200b0033bf8662572so1513894wmb.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Dec 2021 23:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=jc50AAudrPbsVP5lXBCignDc9PL4cYiveAI75iPqLmA=;
 b=cYTMEMiK+hptu6gVOR+vd/4RDfc5Xgh4C3Z6ireizPoHXd1b5W/TQ0v79CXTBmEbdb
 tyw9HUK/okh5dKjdovr4j3yhp6FCDV/Tmt2onUt6ahmAEYTPVL5PIuLN9JDP5a9FgXxC
 PqbCn6/t3Vz46cX0nHowy8xcALG//YbGpc5oQ4+3XHO0gsa7zncyHJn3VRUyGkIt7vwQ
 Mhg/gBmwDEXsAeptkg5QNVn8TQocLlrMVtGp+7uaKdlbf3113vEFWN77+PKZdOWuJrtf
 KmcQP1SrjKZdInuZcJl0ITQ0jZcnjYwsSCZR247lOlp3q2K4Rele4CrfsFqfMeQuCA+e
 tkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jc50AAudrPbsVP5lXBCignDc9PL4cYiveAI75iPqLmA=;
 b=V/nhK14PNyhNgXalhEPe0saCkA2O77maLu/zgyURS0Ril+Gpl8cXPsYrU7TPGmbX/1
 Kz/2HZiV984SAZ9Vl2bb14vnSxFgCkQ9nfZ5yZmwF4IWoN8ghj+fSu8poV5MCiGWQ/49
 xpbj54B3y0rk+g7NQpWrsumW3lKYO6FE58HCxvoE/7f/2bPaORHggEnNyfs33UGCMG4s
 QnAcjQZGmE+ydsoR42q48fsowEDS7FLNB3+F+TumbTXOq/Y7pbA4ii8/bvqqnEguGE35
 DS8awE89iWT1MHSXaeBuGvtJWBFBHp3ZL9svdyO8yNEdYpOPWCraABj94dya7LCRo14b
 fRnw==
X-Gm-Message-State: AOAM532GoZO+yUPLWHjJRpQETmGbC4QcgAELZiyGyiew1w+zJhYzCyEm
 HuX1MAOk3KNW5AIssjBbCJSvIFhZfFU=
X-Google-Smtp-Source: ABdhPJyxyxfnRCVl4J/gSnW491WPAewhuQpgKLO3sDkGJ+Jck/BArkO9uUJIrpdLeu5KcWMhoNq/+Q==
X-Received: by 2002:a7b:cbc3:: with SMTP id n3mr4688862wmi.90.1638860610293;
 Mon, 06 Dec 2021 23:03:30 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id y6sm13932514wrh.18.2021.12.06.23.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Dec 2021 23:03:29 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20211206084551.92502-1-christian.koenig@amd.com>
 <DM6PR12MB26194050848510738D3DF81CE46E9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <462b2fbf-2d14-cc49-1b48-56b80b68b3ba@gmail.com>
Date: Tue, 7 Dec 2021 08:03:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB26194050848510738D3DF81CE46E9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

You are looking at outdated code, that stuff is gone by now. 
amd-staging-drm-next probably needs a rebase.

And this code was what the check was initially good for. Just skipping 
the PM stuff as well on A+A was unintentionally.

Regards,
Christian.

Am 07.12.21 um 02:58 schrieb Quan, Evan:
> [AMD Official Use Only]
>
> It seems more jobs(below) other than bumping the runpm counter are performed.
> Are they desired also?
>
> 	r = __dma_resv_make_exclusive(bo->tbo.base.resv);
> 	if (r)
> 		goto out;
>
> 	bo->prime_shared_count++;
>
> BR
> Evan
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Christian König
>> Sent: Monday, December 6, 2021 4:46 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
>>
>> The runtime PM get was incorrectly added after the check.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index ae6ab93c868b..4896c876ffec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -61,9 +61,6 @@ static int amdgpu_dma_buf_attach(struct dma_buf
>> *dmabuf,
>>   	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, true)
>> < 0)
>>   		attach->peer2peer = false;
>>
>> -	if (attach->dev->driver == adev->dev->driver)
>> -		return 0;
>> -
>>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>   	if (r < 0)
>>   		goto out;
>> --
>> 2.25.1


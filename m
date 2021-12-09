Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64EEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB1F10E4E8;
	Thu,  9 Dec 2021 16:54:16 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890E689FFD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 15:34:27 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id y196so4512096wmc.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Dec 2021 07:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=oFUACwJAEQX/b/pecCnUXpaf05PdPoB5KEOHQymJ0ao=;
 b=WE4Bm5jYoMJ6wnjiAOUt67L/wJXxevMGoFKKbTorfJIDJWi1KmF4omW8ldRX8rKb5C
 Z0qHy4v9KsV1kx3A29Rn+ir49fbJwiOwwYD963RB9RXt3Y5UhB2likwpoqR5XkxyPl8a
 1YPMIzSLTNhQIR0qYMYnXyI4/63d6Mwi7btNNbQEwymI5+qWQyXJGOAMPTIJemmrgcLR
 Xgy7nPgO26VZQNLgpvZchMi5O72HNwD5sCOgkn2smTwCVWmhuHTH+DSolL+EXWr+Ajp3
 5ST8y7f+SKTgbzDNbmIeiwGXH2595vl66W+zwPBX0ZKqs0UjkpzbryGfYp62FcxxbfrB
 DpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oFUACwJAEQX/b/pecCnUXpaf05PdPoB5KEOHQymJ0ao=;
 b=oV6wo1Fcv5+0QND7sOG7Sjy9h7MBsIAHYxI3wOPNSH4kLZ7keo9zFfY/t/HbH4P+1U
 28hzfR4PROb6GEytQ3wmVjWeRZvzDUemKjpcdEnsGNXkqrBDNSRRJRciP/nsHkBAd8zU
 UpJXMJJTVX1kamgNWa0FSS895HkPAN0ymoeRG1Q1yHFn3E7TlywvVE6Wh7l6c92glplE
 HDRk7btbQ+W/mv7KvyhwNHM5cT/CyJYBOTdEgJdkR42LwoXoB5V1OLmqPXoBFCpYsw2j
 E8gKNWVxi8/Ky9By22Yb7iHXoN60fs2UGmds/i9NZnlTJUVEzRAnswOTBAC2X3eFQ0Kp
 5Ftg==
X-Gm-Message-State: AOAM532+IF99PIlE3/wmZskVGI64SW4KPMDEjWgCL92ri+F72+q4CuMi
 25Qmeh708WUA9Xlfb16q0d87ctJ3kHs=
X-Google-Smtp-Source: ABdhPJw+Uk0nz9XgqvM6VKw4vYfTpgvv0qIy7ZKRoYt6IpiAlDZ8WVG1IfhsSwPVQINrN0OgwpPRpg==
X-Received: by 2002:a1c:43c1:: with SMTP id q184mr8140221wma.153.1639064065808; 
 Thu, 09 Dec 2021 07:34:25 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:76cf:54fe:ebe4:b83c?
 ([2a02:908:1252:fb60:76cf:54fe:ebe4:b83c])
 by smtp.gmail.com with ESMTPSA id k37sm129005wms.21.2021.12.09.07.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 07:34:25 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20211206084551.92502-1-christian.koenig@amd.com>
 <DM6PR12MB26194050848510738D3DF81CE46E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <462b2fbf-2d14-cc49-1b48-56b80b68b3ba@gmail.com>
 <DM6PR12MB261917D411F14C76089BA492E46E9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d0f0e37a-9dbe-c3ff-2123-b358a3c7ab04@gmail.com>
Date: Thu, 9 Dec 2021 16:34:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB261917D411F14C76089BA492E46E9@DM6PR12MB2619.namprd12.prod.outlook.com>
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

Am 07.12.21 um 08:40 schrieb Quan, Evan:
> [AMD Official Use Only]
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, December 7, 2021 3:03 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
>>
>> You are looking at outdated code, that stuff is gone by now.
>> amd-staging-drm-next probably needs a rebase.
> Yep, I can see it in the vanilla kernel.
> The patch is acked-by: Evan Quan <evan.quan@amd.com>

Thanks.

Alex any objections that I push this to drm-misc-next? It was found 
while working on changes already upstream in that function and would 
conflict if we push it through amd-staging-drm-next.

Regards,
Christian.

>
> BR
> Evan
>> And this code was what the check was initially good for. Just skipping the PM
>> stuff as well on A+A was unintentionally.
>>
>> Regards,
>> Christian.
>>
>> Am 07.12.21 um 02:58 schrieb Quan, Evan:
>>> [AMD Official Use Only]
>>>
>>> It seems more jobs(below) other than bumping the runpm counter are
>> performed.
>>> Are they desired also?
>>>
>>> 	r = __dma_resv_make_exclusive(bo->tbo.base.resv);
>>> 	if (r)
>>> 		goto out;
>>>
>>> 	bo->prime_shared_count++;
>>>
>>> BR
>>> Evan
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Christian König
>>>> Sent: Monday, December 6, 2021 4:46 PM
>>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org
>>>> Subject: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
>>>>
>>>> The runtime PM get was incorrectly added after the check.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 3 ---
>>>>    1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> index ae6ab93c868b..4896c876ffec 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> @@ -61,9 +61,6 @@ static int amdgpu_dma_buf_attach(struct dma_buf
>>>> *dmabuf,
>>>>    	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, true)
>> <
>>>> 0)
>>>>    		attach->peer2peer = false;
>>>>
>>>> -	if (attach->dev->driver == adev->dev->driver)
>>>> -		return 0;
>>>> -
>>>>    	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>>    	if (r < 0)
>>>>    		goto out;
>>>> --
>>>> 2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD76C25B0C
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 19:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2721123AB;
	Mon,  8 Aug 2022 19:47:20 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3AE610E508
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 19:47:09 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id i14so18470530ejg.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Aug 2022 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=PIsy2JQkobdV1kOnqq+luasb6dz/mAyRIGxMQZ5Yhjo=;
 b=gLLXHK/nOofg5jMyEuXJnQQxprWiR2LaXTqvwJLJlEBxVkOgGOjPnO0HZ4WuNyai8v
 2BYn1+j2TTychBLkCrkIVYKX8tG6c4PQwGi5/HrlCj/XRJm4Z2+oNGAz7yuA6R2F6T4b
 w6CCNHgDhYawmHYfrnPtzNvzm3VdPdeXR2v3A7waI4O6h5vCw9OEOLvBm5SLYFOCTBOU
 UJFtTVfBSpg5/kMVNDzTzo33t4ybZYDb2GGucgM55iZhuhIf3kp+VFiNZlpP2SWCbf7V
 6jvuERK/1P7peA18ZsEtI2Q+mp4+gZ5QomDbOUU9qTIXxb7xeSjw6R2HViFYdOaVIDmF
 t9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=PIsy2JQkobdV1kOnqq+luasb6dz/mAyRIGxMQZ5Yhjo=;
 b=StdxqD5rQ59F1D0tGBdxyVvp8TIZgETemW1lUgUacAHKyUgYQ7QELmHxyC7RrCSsX+
 KvRHpjcB7+2l1SvNw/T7OcSGYoKHFOyE7eZp9EjvveArznTJCjD65B9N8dg3J7bADX7Z
 fTl4wQpdpXokcpC9Di9IQQ+62/4yGB9YiCy31GoR1lx4lc2C/FzJfFiPjgtYkMAMxlmg
 CxoO3pTuPCVhneK4JyE0Xa2Dj4lDbGAjcAZ+s0dRZiqS1i9JckBhtlPZ62USmxojkQIA
 aPNLpixc1/5l5hsEDoVAa/jIwM/YDca8u4ptN1wqQVrceLYI3EvqdPlut7s1vsriFPTL
 Garg==
X-Gm-Message-State: ACgBeo38Dpld2Ie5yjm/MVU3UjZ6niN3Rm3pAXiHuGdCSFXbkwHkinO/
 HR8985Safemh8Y6ikhVAzneC6YAL8UQ=
X-Google-Smtp-Source: AA6agR48adPwil7jGbxC0Xu07nwWOkwGZYJHmNBwWp28KDU6mlvsv7QvAObReg3kRkMkQFv5HR3dTQ==
X-Received: by 2002:a17:907:3daa:b0:730:a788:a6e4 with SMTP id
 he42-20020a1709073daa00b00730a788a6e4mr14936810ejc.77.1659988028321; 
 Mon, 08 Aug 2022 12:47:08 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:f491:48ac:1e6b:30be?
 ([2a02:908:1256:79a0:f491:48ac:1e6b:30be])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a17090694c400b007313a25e56esm222934ejy.29.2022.08.08.12.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Aug 2022 12:47:07 -0700 (PDT)
Message-ID: <d992d717-6cb5-f5b4-4196-b6d30d654e0f@gmail.com>
Date: Mon, 8 Aug 2022 21:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Enable translate_further to extend UTCL2 reach
Content-Language: en-US
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220804160158.937021-1-Joseph.Greathouse@amd.com>
 <7390b455-bd16-c1df-25fa-a1b1e3554a0b@amd.com>
 <DM5PR12MB1308BA3B96EA1B4C0642910A85639@DM5PR12MB1308.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM5PR12MB1308BA3B96EA1B4C0642910A85639@DM5PR12MB1308.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I can't 100% judge if the IP version check is sufficient or not, so keep 
an eye open for regression reports when this goes upstream.

Apart from that Acked-by: Christian König <christian.koenig@amd.com> as 
well.

Christian.

Am 08.08.22 um 15:12 schrieb Russell, Kent:
> [AMD Official Use Only - General]
>
> You can throw an Acked-by Kent Russell <kent.russell@amd.com> as well . Not sure if there's someone who wants to provide a more concrete RB.
>
>   Kent
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, August 4, 2022 2:54 PM
>> To: Greathouse, Joseph <Joseph.Greathouse@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Russell, Kent <Kent.Russell@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Enable translate_further to extend UTCL2
>> reach
>>
>> On 2022-08-04 12:01, Joseph Greathouse wrote:
>>> Enable translate_further on Arcturus and Aldebaran server chips
>>> in order to increase the UTCL2 reach from 8 GiB to 64 GiB,
>>> which is more in line with the amount of framebuffer DRAM in
>>> the devices.
>>>
>>> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 22761a3bb818..ab89d91975ab 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1624,12 +1624,15 @@ static int gmc_v9_0_sw_init(void *handle)
>>>    			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 47);
>>>    		else
>>>    			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
>>> +		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
>>> +			adev->gmc.translate_further = adev-
>>> vm_manager.num_level > 1;
>>>    		break;
>>>    	case IP_VERSION(9, 4, 1):
>>>    		adev->num_vmhubs = 3;
>>>
>>>    		/* Keep the vm size same with Vega20 */
>>>    		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
>>> +		adev->gmc.translate_further = adev->vm_manager.num_level >
>> 1;
>>>    		break;
>>>    	default:
>>>    		break;


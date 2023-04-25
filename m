Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCFDC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 08:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC82310E009;
	Tue, 25 Apr 2023 08:53:57 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4220F10E009
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 08:53:56 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-94f910ea993so817296066b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682412834; x=1685004834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mcKXHP47/wU/dndybJ3k0tsxmgzX98j/sz2X3+FrKRU=;
 b=bwqHweGalA+AJq8A4jmuCpPSW0CIwULq7aMPli8s9gMp2QWH6sHWhzv/I9WE5suTQd
 SODx4vN2hl2k53QQY6V2OckBRVKPeqh3nUFyy2REQLi7Be5zyn97TBhcBcEFeenjN+Vy
 KlgjO1C2xYRKATMZGfEyWOoO/dUygxE17I/2kMjVAFe0Kc5a/4/4e5ZTzHamtVw9sX8d
 zuYt8Sp4eXOlckIpRdZnb2Vig0YUGNkmXcB/wvV4yCFPig3EUSOqx6ysaRfabwxt2E88
 riD52j8zeYsYpWiOhRYn5ZCSe1PfX0IHNTt8FJrzXPzfeRmDzZ3z66ZU/EqOHhNZBkeh
 qYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682412834; x=1685004834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mcKXHP47/wU/dndybJ3k0tsxmgzX98j/sz2X3+FrKRU=;
 b=iXfMeQI2j/bpRiMpKjqsGNF329UQt7OH+9OFgUcWHcCYjh0H9HIKUDM5w9b3PKkKGU
 fq2tFkXzOCum/GC0YiDc7A38v4S2l3Ezc1HIp/N4bxvkcwDGIrcF3RQB/vQBsq/hhYVX
 Veuz90a97IksL3oW9WjuJR+gYkVp6bC4PYT78n8RNnZJyIG9W/evO+Am9PBFax2XJDAR
 KcW9v9KfjSZ8oD+tr9FwG3Ux56ULwLIJrQkfw6Ugx59oWT+UtLpNKngjR4CwJgBOAcPn
 zSKZpQifKjMKVt0DTkhg/pwCcYcuoj3HkzijYSzD/wsUmQsfbmd/eAksn20lPs6pUqF7
 1Zjw==
X-Gm-Message-State: AAQBX9fGJ9WIsWAx+pHkzKn1mdCpE4/7dkDVQeJE2hmxNb7hLW7OxBCF
 qkVVSXpWotvqoXT8laRJUfc=
X-Google-Smtp-Source: AKy350Zvlf8IyiwDQgA8vT7abibiHQYYuqxL2z99Od5D2GyP46zVwow0+0ifWpjwVqJ/+Xl3WyYg3Q==
X-Received: by 2002:a17:907:2d92:b0:94a:5361:d447 with SMTP id
 gt18-20020a1709072d9200b0094a5361d447mr11486514ejc.73.1682412833906; 
 Tue, 25 Apr 2023 01:53:53 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:4e90:bf2f:bdfc:65d?
 ([2a02:908:1256:79a0:4e90:bf2f:bdfc:65d])
 by smtp.gmail.com with ESMTPSA id
 ec17-20020a170906b6d100b0094f6bf5ac9asm6473312ejb.22.2023.04.25.01.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Apr 2023 01:53:53 -0700 (PDT)
Message-ID: <67efa777-b4b2-ce72-3003-b4a00c1bcfc3@gmail.com>
Date: Tue, 25 Apr 2023 10:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Content-Language: en-US
To: "Xiao, Shane" <shane.xiao@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230418065443.878721-1-shane.xiao@amd.com>
 <9885713a-b424-dddc-f891-ed7d622c5b91@gmail.com>
 <DM4PR12MB5261E710B9A6F7BA6BF52F009D679@DM4PR12MB5261.namprd12.prod.outlook.com>
 <DM4PR12MB52615C85D3EA998E157686AD9D679@DM4PR12MB5261.namprd12.prod.outlook.com>
 <ac04f565-8336-fff6-e93b-a3021613558e@amd.com>
 <CADnq5_MFCad6wRFV=tQ6w+QFDsjbQB614dE=-6Hx+9qf++aSUw@mail.gmail.com>
 <BL1PR12MB52378B1F4549126C771815E7F0649@BL1PR12MB5237.namprd12.prod.outlook.com>
 <DM4PR12MB526168C8C138DC23FC68D8DD9D649@DM4PR12MB5261.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB526168C8C138DC23FC68D8DD9D649@DM4PR12MB5261.namprd12.prod.outlook.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Hou,
 Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 25.04.23 um 05:29 schrieb Xiao, Shane:
> [AMD Official Use Only - General]
>
>
>
>> -----Original Message-----
>> From: Liu, Aaron <Aaron.Liu@amd.com>
>> Sent: Tuesday, April 25, 2023 9:14 AM
>> To: Alex Deucher <alexdeucher@gmail.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Cc: Xiao, Shane <shane.xiao@amd.com>; Christian König
>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org;
>> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Hou,
>> Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
>> successfully
>>
>> [AMD Official Use Only - General]
>>
>>> -----Original Message-----
>>> From: Alex Deucher <alexdeucher@gmail.com>
>>> Sent: Tuesday, April 25, 2023 4:20 AM
>>> To: Koenig, Christian <Christian.Koenig@amd.com>
>>> Cc: Xiao, Shane <shane.xiao@amd.com>; Christian König
>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org;
>>> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>>> <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
>>> Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Liu, Aaron
>>> <Aaron.Liu@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: Enable doorbell selfring if resize
>>> BAR successfully
>>>
>>> On Mon, Apr 24, 2023 at 3:11 PM Christian König
>>> <christian.koenig@amd.com>
>>> wrote:
>>>> Am 24.04.23 um 16:06 schrieb Xiao, Shane:
>>>>> [AMD Official Use Only - General]
>>>>>> -----Original Message-----
>>>>>> From: Xiao, Shane
>>>>>> Sent: Monday, April 24, 2023 6:31 PM
>>>>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; amd-
>>>>>> gfx@lists.freedesktop.org; Deucher, Alexander
>>>>>> <Alexander.Deucher@amd.com>; Zhang, Hawking
>>>>>> <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>>>>>> Cc: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Liu, Aaron
>>>>>> <Aaron.Liu@amd.com>
>>>>>> Subject: RE: [PATCH] drm/amdgpu: Enable doorbell selfring if
>>>>>> resize BAR successfully
>>>>>>
>>>>>> [AMD Official Use Only - General]
>>>>>>> -----Original Message-----
>>>>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>>>>> Sent: Monday, April 24, 2023 5:07 PM
>>>>>>> To: Xiao, Shane <shane.xiao@amd.com>;
>>>>>>> amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>>>>>> <Alexander.Deucher@amd.com>; Zhang, Hawking
>>>>>>> <Hawking.Zhang@amd.com>; Kuehling, Felix
>>>>>>> <Felix.Kuehling@amd.com>
>>>>>>> Cc: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Liu, Aaron
>>>>>>> <Aaron.Liu@amd.com>
>>>>>>> Subject: Re: [PATCH] drm/amdgpu: Enable doorbell selfring if
>>>>>>> resize BAR successfully
>>>>>>>
>>>>>>> Am 18.04.23 um 08:54 schrieb Shane Xiao:
>>>>>>>> [Why]
>>>>>>>> The selfring doorbell aperture will change when we resize FB
>>>>>>>> BAR successfully during gmc sw init, we should reorder the
>>>>>>>> sequence of enabling doorbell selfring aperture.
>>>>>>> That's a good catch.
>>>>>>>
>>>>>>>> [How]
>>>>>>>> Move enable_doorbell_selfring_aperture from *_common_hw_init to
>>>>>>>> *_common_late_init.
>>>>>>> But that sounds like a bad idea. Instead the full call to
>>>>>>> nv_enable_doorbell_aperture() should be moved around.
>>>>>> Hi Christian,
>>>>>>
>>>>>> Yes,  I get your idea. But as far as I can understand that, the
>>>>>> gfx hw init will use doorbell.
>>>>>> If so, we cannot enable doorbell after gfx hw init.
>>>>> We have come up with two ways to resolve the issue.
>>>>>
>>>>> 1) Separate enable_doorbell_aperture and
>>>>> enable_doorbell_selfring_aperture. However,  the
>>> enable_doorbell_selfring_aperture should be moved in
>>> *_common_ip_funcs-
>>>> late_init.
>>>>
>>>> I'm not an expert for this part of the driver, but of hand that
>>>> sounds like the right way of doing it.
>>>>
>>>> Alex any objections?
>>> Yeah, seems reasonable.
>>>
>>> Alex
>>>
>> enable_doorbell_aperture and enable_doorbell_selfring_aperture should be in
>> common_*_init instead of gmc_hw_init.
>> The order of execution of Shane's 1st way is :
>> 1) common_sw_init
>> 2) common_hw_init  -> enable_doorbell_aperture
>> 3) gmc_sw_init -> amdgpu_device_resize_fb_bar                  ///This relies
>> gmc.real_vram_size to determine resize_fb_bar, so moving
>> amdgpu_device_resize_fb_bar to common_sw_init  is not a good idea.
>> 4) gmc_hw_init
>> 5) common_late_init -> enable_doorbell_selfring_aperture
>>
>> The 1st way looks good to me and reviewed-by me.
> Hi Alex & Christian,
>
> Since this patch has already implemented it in this way, is there any other comments on this patch body?
> Or can I add you R-B or Acked-by on this patch?

At least remove the functions 
soc15_enable_doorbell_aperture()/nv_enable_doorbell_aperture()/soc21_enable_doorbell_aperture() 
and open code the respective calls.

Those don't make sense any more since we don't have a central point when 
the apertures are enabled/disabled.

Regards,
Christian.

>
> Best Regards,
> Shane
>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> 2) The full call can be moved to gmc hw init.  But it seems
>>>>> strange to move
>>> nbio configuration into gmc hw init.
>>>>> If neither of the above methods is suitable, could you please give
>>>>> us some
>>> advice on this issue?
>>>>> Best Regards,
>>>>> Shane
>>>>>
>>>>>> Best Regards,
>>>>>> Shane
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> This fixes the potential issue that GPU ring its own doorbell
>>>>>>>> when this device is in translated mode with iommu is on.
>>>>>>>>
>>>>>>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>>>>>>> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
>>>>>>>> Tested-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/nv.c    | 4 +++-
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/soc15.c | 4 +++-
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
>>>>>>>>     3 files changed, 9 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/nv.c index
>>>>>>>> 47420b403871..f4c85634a4c8
>>>>>>>> 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>>>>> @@ -535,7 +535,8 @@ static void
>>>>>>>> nv_enable_doorbell_aperture(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>>                                             bool enable)
>>>>>>>>     {
>>>>>>>>             adev->nbio.funcs->enable_doorbell_aperture(adev,
>>>>>>>> enable);
>>>>>>>> -  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>>>>>>> enable);
>>>>>>>> +  if (!enable)
>>>>>>>> +
>>>>>>>> + adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>>>>>> false);
>>>>>>>>     }
>>>>>>>>
>>>>>>>>     const struct amdgpu_ip_block_version nv_common_ip_block = @@
>>>>>>>> -999,6
>>>>>>>> +1000,7 @@ static int nv_common_late_init(void *handle)
>>>>>>>>                     }
>>>>>>>>             }
>>>>>>>>
>>>>>>>> +  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>>>>>>> + true);
>>>>>>>>             return 0;
>>>>>>>>     }
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>>>> index bc5dd80f10c1..0202de79a389 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>>>> @@ -623,7 +623,8 @@ static void
>>>>>>>> soc15_enable_doorbell_aperture(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>>                                                bool enable)
>>>>>>>>     {
>>>>>>>>             adev->nbio.funcs->enable_doorbell_aperture(adev,
>>>>>>>> enable);
>>>>>>>> -  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>>>>>>> enable);
>>>>>>>> +  if (!enable)
>>>>>>>> +
>>>>>>>> + adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>>>>>> false);
>>>>>>>>     }
>>>>>>>>
>>>>>>>>     const struct amdgpu_ip_block_version vega10_common_ip_block
>>>>>>>> = @@
>>>>>>>> -1125,6 +1126,7 @@ static int soc15_common_late_init(void *handle)
>>>>>>>>             if (amdgpu_sriov_vf(adev))
>>>>>>>>                     xgpu_ai_mailbox_get_irq(adev);
>>>>>>>>
>>>>>>>> +  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>>>>>>> + true);
>>>>>>>>             return 0;
>>>>>>>>     }
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>>>> index 514bfc705d5a..cd4619085d67 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>>>> @@ -454,7 +454,8 @@ static void
>>>>>>>> soc21_enable_doorbell_aperture(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>>                                             bool enable)
>>>>>>>>     {
>>>>>>>>             adev->nbio.funcs->enable_doorbell_aperture(adev,
>>>>>>>> enable);
>>>>>>>> -  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>>>>>>> enable);
>>>>>>>> +  if (!enable)
>>>>>>>> +
>>>>>>>> + adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>>>>>> false);
>>>>>>>>     }
>>>>>>>>
>>>>>>>>     const struct amdgpu_ip_block_version soc21_common_ip_block =
>>>>>>>> @@
>>>>>>>> -764,6 +765,7 @@ static int soc21_common_late_init(void *handle)
>>>>>>>>                             amdgpu_irq_get(adev, &adev-
>>>>>>>> nbio.ras_err_event_athub_irq, 0);
>>>>>>>>             }
>>>>>>>>
>>>>>>>> +  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
>>>>>>>> + true);
>>>>>>>>             return 0;
>>>>>>>>     }
>>>>>>>>


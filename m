Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1696AC47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 17:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E85310E049;
	Tue, 16 Jan 2024 17:35:23 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B385110E049
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 17:35:22 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-5e784ce9bb8so79713357b3.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 09:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705426462; x=1706031262; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBAJhANhlCQ9kLEvJxw4RtrIvI1XTKVDeHB3Hy12FUI=;
 b=FCNOTBERhBTwc2bsiqLeQB2GDtwqQtNODXdgN2DHZozQuep2wkKtM/9f3/RmOw4+pM
 wjpCd+ha/CGb9ahnrx9aqQmrpL4QbT4Sr5zssy2Fzo9H1ydnUosk6Se9NkCd9rxWrzQ8
 hpjOPjZpq25CyuoNTK5qWuGRRH0USprHsg4r9eLwB0ui98CTrJaKnSoAERT14t4nNpA8
 tndTaSZjk/H92gpyAEMljRO61ME1Oob4HE66q+Bd4wXyA1spfNReVXajNUNjmz7bHE5v
 TVlMF7WfuTOl6XufKQHpFrv6cVgsAx71eAYlW46QPiWHoiv8XuEuvcpq6aUHhU6EtVVE
 Xw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705426462; x=1706031262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBAJhANhlCQ9kLEvJxw4RtrIvI1XTKVDeHB3Hy12FUI=;
 b=CmPIISxrVxYcH+AUVJNvyx4ovUP93hGKJIDnqh+Zukx+AkJgFCCxSVqa+0zV41qjEr
 Q8Mpwpbs4kFweaHyORQWI2sYyNbU0+zo2ASED70+cYeV0b+c4tHIKyWtelnnppYtdEyW
 sBde7TpmW63v53js5c1LvwRoNg3YN5zO85N8VJHjyAB3LstftCvOqkmfobP/RdibMMjk
 07i1kiWTCDI1wv2y2KSPXOgJM8CpHggBuw3l6MLpOV/LjRREeayIsV13H1k3y9vm5mLb
 eqoGiJHTyOGASh/UtTGS0ZRH/a+2R1TM4dnwj3mu/egDkU9zpQKV01vkP9EZwLKCC1+4
 5A+g==
X-Gm-Message-State: AOJu0YygbfCfhiG0hpMOHkU0g8yI1Dc6TD5TRTh6z6lOHldgo7ue0MF2
 r9WLg9l5XanN1XYiRpZZ7bNx0Mm70zT8Ug==
X-Google-Smtp-Source: AGHT+IE4KUlJ50PMPEW3WdNHyAqHs3YhP1shRBZyO8xn+En4+g/VjfZBD/m4iUgE0lFkMM1WkuHwdQ==
X-Received: by 2002:a05:690c:d0e:b0:5fb:8329:c50d with SMTP id
 cn14-20020a05690c0d0e00b005fb8329c50dmr4278174ywb.50.1705426461856; 
 Tue, 16 Jan 2024 09:34:21 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 fv8-20020a05690c370800b005ec2d763ae4sm4890311ywb.68.2024.01.16.09.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 09:34:21 -0800 (PST)
Message-ID: <bf23d5ed-9a6b-43e7-84ee-8cbfd0d60f18@froggi.es>
Date: Tue, 16 Jan 2024 17:34:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
 <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
 <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
 <51b9ffc3-9ab3-4a06-9307-6b2a343f6bc6@gmx.de>
 <CAP+8YyGg91f_z2ktrd7HQMtOSHn34F-8x7O2iRv=TTrXo2NNoA@mail.gmail.com>
 <81a82ffc-c2e6-4ce6-9cc0-4f01dc8b9891@froggi.es>
 <bff749b8-5531-46bd-8e21-97d094e6b4c2@amd.com>
 <9e6fec7b-3786-4221-8024-6b949efd08e7@froggi.es>
 <bfe79411-7f77-48ab-8cfd-4727704739e8@amd.com>
 <3e284517-0372-4c75-9902-7039c09b73e9@froggi.es>
 <baa54077-cf89-4fb7-b505-a41716e66a23@gmail.com>
 <CAAxE2A5v_RkZ9ex4=7jiBSKVb22_1FAj0AANBcmKtETt5c3gVA@mail.gmail.com>
 <de47a17b-3d19-4c74-b77a-e08b0e94cc69@gmail.com>
 <2a9a1a92-a074-456e-8190-3ba0a30d3f30@froggi.es>
 <f6409b43-88f7-4a44-a007-d6686cf11a50@froggi.es>
 <4bfbb2e3-962f-4a74-ba52-0277205c6bfd@froggi.es>
 <75737c81-a470-4bcd-bf98-d2b4e37aa095@froggi.es>
 <b48e84b0-8e7a-4290-aa33-e4c01e9f9809@amd.com>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <b48e84b0-8e7a-4290-aa33-e4c01e9f9809@amd.com>
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
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 amd-gfx@lists.freedesktop.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/16/24 15:05, Christian König wrote:
> Am 16.01.24 um 14:48 schrieb Joshua Ashton:
>>
>> [SNIP]
>>>>>> Going to adjust the implementation accordingly.
>>>>>
>>>>> Awesome, please CC me know when you have something.
> 
> Sure, going to keep that in mind.
> 
>>>>>
>>>>> In the short-term I have changed if (r && r != -ENODATA) to if (r) 
>>>>> and that seems to work nicely for me.
>>>>
>>>> One problem with solely relying on the CS submission return value 
>>>> from userspace is cancelled syncobj waits.
>>>>
>>>> For example, if we have an application with one thread that makes a 
>>>> submission, and then kicks off a vkWaitSemaphores to wait on a 
>>>> semaphore on another thread and that submission hangs, the syncobj 
>>>> relating to the vkWaitSemaphores should be signalled which is fine, 
>>>> but we need to return VK_ERROR_DEVICE_LOST if the context loss 
>>>> resulted in the signal for the VkSemaphore.
>>>>
>>>> The way this was previously integrated was with the query thing, 
>>>> which as we have established does not provide correct information 
>>>> regarding soft recovery at the moment.
>>>>
>>>> Unless you have an alternative for us to get some error out of the 
>>>> syncobj (eg. -ENODATA), then right now we still require the query.
>>>>
>>>> I think fixing the -ENODATA reporting back for submit is a good 
>>>> step, but I believe we still need the query to report the same 
>>>> information as we would have gotten from that here.
> 
> Yeah, exactly that was one of the reasons why the guilty handling 
> approach didn't solved the problem sufficiently.
> 
> If I remember correctly at least for the syncobj used on Android you can 
> actually query the result of the execution after waiting for them to 
> signal.
> 
> So not only the issuer of a submission can get the result, but also 
> everybody waiting for the result. In other words Wayland, X, etc... can 
> implement graceful handling should an application send them nonsense.

That would be great. Right now the vkQueueSubmit for a hanging 
application ends up going through as the Wayland commit has been made, 
and the fence gets signalled.

This means we can get an image that is complete garbage from a hung app 
-- no DCC retile occured for it, which is pretty funny as the scanout 
image looks garbage, but it displays whatever it last was in composite. xD

Getting the fence error on the compositor side would be great to 
disregard such images.

We could also do more useful device loss handling with that on the 
driver side.

Thanks!
- Joshie 🐸✨

> 
> I don't think we ever implemented something similar for drm_syncobj and 
> we might need error forwarding in the dma_fence_chain container, but 
> stuff like that is trivial to implement should the requirement for this 
> ever come up.
> 
>>>
>>> Hmmm, actually the spec states that VK_SUCCESS is valid in this 
>>> situation:
>>>
>>> Commands that wait indefinitely for device execution (namely 
>>> vkDeviceWaitIdle, vkQueueWaitIdle, vkWaitForFences with a maximum 
>>> timeout, and vkGetQueryPoolResults with the VK_QUERY_RESULT_WAIT_BIT 
>>> bit set in flags) must return in finite time even in the case of a 
>>> lost device, and return either VK_SUCCESS or VK_ERROR_DEVICE_LOST.
>>>
>>> ...
>>>
>>>
>>> Once a device is lost, command execution may fail, and certain 
>>> commands that return a VkResult may return VK_ERROR_DEVICE_LOST.
>>
>> I guess for now disregard last email regarding us potentially needing 
>> the query, it does seem that returning SUCCESS is completely valid.
> 
> Well how you interpret the information the kernel gives you in userspace 
> is your thing. But we should at least make sure that the general 
> approach inside the kernel has a design which can handle those 
> requirements.
> 
> Christian.
> 
>>
>> - Joshie 🐸✨
>>
>>>
>>> - Joshie 🐸✨
>>>
>>>>
>>>> Thanks
>>>>
>>>> - Joshie 🐸✨
>>>>
>>>>>
>>>>> - Joshie 🐸✨
>>>>>
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Marek
>>>>>>
>>>>>
> 


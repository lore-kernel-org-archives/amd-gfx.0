Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C155AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 11:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C0610E4BF;
	Fri, 13 May 2022 11:26:49 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677BA10E4BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 11:26:48 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id dk23so15625931ejb.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=inm3jATAwBtYPTh2pvfqU7aldZTyMtZ88HHGjp/cU6I=;
 b=B4lZ/bjoI45XWJ05mZysvW5VFjKtvdq5g4bDDN9cS9fTo1qs+m2rYduFSg25akvtRk
 Jkpc9TKKlpaymG2XQmULs9k749nI0mov+y8hCp2HGAhKKwaQEwWvg3WMv+RY94XMAU73
 LghDPwcA6Q7J/ROTj0FQnaOK6QTrZYZqkR+H7H4+pOchA3ni4u5HBm0LuPD4t1+MNJpD
 Gwf7MutnaJzwqOEY/cBnFlPX73/cro+mxvwf6R4/TadaIFbQxTEzrXfyZn8tuMObCD+r
 8yWWHx3LSa6jj+IprFfpKsySU5tCCcxcWx1VJPvJSfgR+4qmV1wW4SFrP5U7wIvwVQtl
 t4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=inm3jATAwBtYPTh2pvfqU7aldZTyMtZ88HHGjp/cU6I=;
 b=qXLWz93gmcojdt2gnRQiY0XpxFWN04SevZkUDM1Hx1ZOf3QLHHTaZGw4QV6LLJzPdg
 OUKBbDEO+6dr4AcVY6qnmDiXBJhL8NatxK6Ja4nWlQbam8m/ckeWcSazjpRBBMncblGk
 IV+3TPgzaWCDgU6+GAnGnugXC75XfpG3xYSePKRIbrjOKy9Z4bSF2wmbTV7GZ161Dx9N
 P3L9G5xTHIKbL7Jr5WNFMc0XsgYG8Pm8L0Iqst7acDCLbtuxbUQLufOKGFo+xMYeH/Lf
 Pmn0O0fX9pypGsWBax8FEJL6EGjaZSNr7EHmGD1oD/KCWvVAXYG0FPUx35epRZRHSITW
 fBQg==
X-Gm-Message-State: AOAM531PzERn+Z4+1LXkYbH1puYn0eVj0sXA7Y2gJZthSBqFAm9+5TRJ
 jsw871E8G6B1LXaS0mUd37pEkbe5l1g=
X-Google-Smtp-Source: ABdhPJxX4ESm3C4uZfrXTYUR1yZp92v6pLqihhvhcvu6aEQRuQpUbFMILE0HGVqOoUQNNEP+OteacQ==
X-Received: by 2002:a17:906:99c2:b0:6f4:a99c:8dfc with SMTP id
 s2-20020a17090699c200b006f4a99c8dfcmr4174244ejn.386.1652441206933; 
 Fri, 13 May 2022 04:26:46 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:4107:8049:874f:2444?
 ([2a02:908:1256:79a0:4107:8049:874f:2444])
 by smtp.gmail.com with ESMTPSA id
 my43-20020a1709065a6b00b006f3ef214db8sm682425ejc.30.2022.05.13.04.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 May 2022 04:26:46 -0700 (PDT)
Message-ID: <12f757f0-29f5-858e-4723-0babb4b6f335@gmail.com>
Date: Fri, 13 May 2022 13:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
Content-Language: en-US
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <CAAxE2A4Bny50ywdTXi0MBV_Pb-onx0yVhPOsb2Lk9XtbJ1R4rQ@mail.gmail.com>
 <CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com>
 <d4f8f7fc-e3dc-fcf8-0543-62039c7460d3@gmail.com>
 <CAAxE2A60-rNUGB3PNL7kq6pJBWf7V-6cAE0Hx6zH31ad7z_1gA@mail.gmail.com>
 <CAAxE2A6BaiGfXXGnmCH9Zk36oWuOwk_84QBYbZ97QhyZQfwBKQ@mail.gmail.com>
 <CAAxE2A6wiL5fnegVo+tMsHBNb+HC3Nw=cmR4MdNVqLpEQYH1ug@mail.gmail.com>
 <11d9492c-f727-f149-d473-9cda4bab2760@gmail.com>
 <CAAxE2A5jc0FhpnM2tBskS2puKY-jidC_xdMTZhQ5p9U31O_0KA@mail.gmail.com>
 <62165c7c-892a-5b35-79dd-b90414ccb5cd@damsy.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <62165c7c-892a-5b35-79dd-b90414ccb5cd@damsy.net>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Exactly that's what we can't do.

See the kernel must always be able to move things to GTT or discard. So 
when you want to guarantee that something is in VRAM you must at the 
same time say you can discard it if it can't.

Christian.

Am 13.05.22 um 10:43 schrieb Pierre-Eric Pelloux-Prayer:
> Hi Marek, Christian,
>
> If the main feature for Mesa of AMDGPU_GEM_CREATE_DISCARDABLE is 
> getting the best placement, maybe we should have 2 separate flags:
>   * AMDGPU_GEM_CREATE_DISCARDABLE: indicates to the kernel that it can 
> discards the content on eviction instead of preserving it
>   * AMDGPU_GEM_CREATE_FORCE_BEST_PLACEMENT (or 
> AMDGPU_GEM_CREATE_NO_GTT_FALLBACK ? or AMDGPU_CREATE_GEM_AVOID_GTT?): 
> tells the kernel that this bo really needs to be in VRAM
>
>
> Pierre-Eric
>
> On 13/05/2022 00:17, Marek Olšák wrote:
>> Would it be better to set the VM_ALWAYS_VALID flag to have a greater 
>> guarantee that the best placement will be chosen?
>>
>> See, the main feature is getting the best placement, not being 
>> discardable. The best placement is a hw design requirement due to 
>> using memory for uses that are expected to have performance similar 
>> to onchip SRAMs. We need to make sure the best placement is 
>> guaranteed if it's VRAM.
>>
>> Marek
>>
>> On Thu., May 12, 2022, 03:26 Christian König, 
>> <ckoenig.leichtzumerken@gmail.com 
>> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>
>>     Am 12.05.22 um 00:06 schrieb Marek Olšák:
>>>     3rd question: Is it worth using this on APUs?
>>
>>     It makes memory management somewhat easier when we are really OOM.
>>
>>     E.g. it should also work for GTT allocations and when the core 
>> kernel says "Hey please free something up or I will start the 
>> OOM-killer" it's something we can easily throw away.
>>
>>     Not sure how many of those buffers we have, but marking 
>> everything which is temporary with that flag is probably a good idea.
>>
>>>
>>>     Thanks,
>>>     Marek
>>>
>>>     On Wed, May 11, 2022 at 5:58 PM Marek Olšák <maraeo@gmail.com 
>>> <mailto:maraeo@gmail.com>> wrote:
>>>
>>>         Will the kernel keep all discardable buffers in VRAM if VRAM 
>>> is not overcommitted by discardable buffers, or will other buffers 
>>> also affect the placement of discardable buffers?
>>>
>>
>>     Regarding the eviction pressure the buffers will be handled like 
>> any other buffer, but instead of preserving the content it is just 
>> discarded on eviction.
>>
>>>
>>>         Do evictions deallocate the buffer, or do they keep an 
>>> allocation in GTT and only the copy is skipped?
>>>
>>
>>     It really deallocates the backing store of the buffer, just keeps 
>> a dummy page array around where all entries are NULL.
>>
>>     There is a patch set on the mailing list to make this a little 
>> bit more efficient, but even using the dummy page array should only 
>> have a few bytes overhead.
>>
>>     Regards,
>>     Christian.
>>
>>>
>>>         Thanks,
>>>         Marek
>>>
>>>         On Wed, May 11, 2022 at 3:08 AM Marek Olšák 
>>> <maraeo@gmail.com <mailto:maraeo@gmail.com>> wrote:
>>>
>>>             OK that sounds good.
>>>
>>>             Marek
>>>
>>>             On Wed, May 11, 2022 at 2:04 AM Christian König 
>>> <ckoenig.leichtzumerken@gmail.com 
>>> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>>
>>>                 Hi Marek,
>>>
>>>                 Am 10.05.22 um 22:43 schrieb Marek Olšák:
>>>>                 A better flag name would be:
>>>>                 AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD
>>>
>>>                 A bit long for my taste and I think the best 
>>> placement is just a side effect.
>>>
>>>>
>>>>                 Marek
>>>>
>>>>                 On Tue, May 10, 2022 at 4:13 PM Marek Olšák 
>>>> <maraeo@gmail.com <mailto:maraeo@gmail.com>> wrote:
>>>>
>>>>                     Does this really guarantee VRAM placement? The 
>>>> code doesn't say anything about that.
>>>>
>>>
>>>                 Yes, see the code here:
>>>
>>>>
>>>>                         diff --git 
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>                         index 8b7ee1142d9a..1944ef37a61e 100644
>>>>                         --- 
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>                         +++ 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>                         @@ -567,6 +567,7 @@ int 
>>>> amdgpu_bo_create(struct amdgpu_device *adev,
>>>>                                         bp->domain;
>>>>                                 bo->allowed_domains = 
>>>> bo->preferred_domains;
>>>>                                 if (bp->type != ttm_bo_type_kernel &&
>>>>                         +           !(bp->flags & 
>>>> AMDGPU_GEM_CREATE_DISCARDABLE) &&
>>>>                                     bo->allowed_domains == 
>>>> AMDGPU_GEM_DOMAIN_VRAM)
>>>> bo->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
>>>>
>>>
>>>                 The only case where this could be circumvented is 
>>> when you try to allocate more than physically available on an APU.
>>>
>>>                 E.g. you only have something like 32 MiB VRAM and 
>>> request 64 MiB, then the GEM code will catch the error and fallback 
>>> to GTT (IIRC).
>>>
>>>                 Regards,
>>>                 Christian.
>>>
>>


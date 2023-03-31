Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2D0C76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 06:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C03410F0F7;
	Fri, 31 Mar 2023 06:39:25 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B90510F0F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 06:39:24 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id ew6so85659767edb.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 23:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680244762;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l7is+T05lwqpsZesXTKNlIfJyUXb7KBMVsJ3ThsSqQs=;
 b=aKuL+G+OdtpeNOWEZgcwM1S17VSqV34Azs4re5yXYXc2D+N6wzY6r7ojM0lpvJROW6
 4pGIQur6HSXPqSGvCYkZlmU/n2ury3pVGJVi+6kz0yErb1YwxYaOGQutj9FGTZt3pToR
 Qu8xqiKd2HpfGGfTqXLyZZe/qlXbkjnHf+r5KwPJrbrodljl9Y8vcSFWhJRjlzCMb3w5
 0kw/5JwwZ8mQzEKAbamKQHmS6a9UyM4flp6CtC9sdxNfgWWT4aPCGHPaWJcCGZrThnGn
 6wCgAdbCvjZay5Mon3E/vbdOYZGObJmh9EVKaMEc2e6lv6M6bbEtKOOqQqkbdGs0kRCy
 IKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680244762;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l7is+T05lwqpsZesXTKNlIfJyUXb7KBMVsJ3ThsSqQs=;
 b=3cARidFHLEtGvpoQubJeAKw6PTDAogFTbD2OGkWGawWr6MDOdiQNUkg5Yr9cpaLwYZ
 GKLRsdtxNs4S1tn4wEJ0R4MyBI9OOFJaOY3Zom1qUWigSiRn9PMNvPCOxZ5vJ42cC4lb
 Q0OKA1QWMrHKrJ0m/hq9I7/KqmekAdRBsiHEx/11QzYB4OWhQE+RPcLjCdIfZB9PsLcp
 o1HkqYoZQ77b/VBDJwnhBWCR75R9HEMneusL7NPTsFMi3i7T2zvFSRVWCvpBrXZPM/NM
 7iXlW32CHuhKKjJkPZz79Z5z+X902/26gSJNip0nLiCcjCNrfdQLxni/sx7fwT+GH86O
 GRew==
X-Gm-Message-State: AAQBX9cun+j0rCsLyh4Hc6F/dM/cmsQ8LOhGxtb64c170EmtQTEr9/YJ
 dR55c+ovQkKw6QRWcd08Bcrl3W4857h12g==
X-Google-Smtp-Source: AKy350atWCnAwlGkXj7/QkZqUtcC5+4X0348hL1CsTPMXxDEQYsTW/Zey1yhgXUXwtvendku3N9+jA==
X-Received: by 2002:a17:906:31cb:b0:92c:a80e:225f with SMTP id
 f11-20020a17090631cb00b0092ca80e225fmr29178305ejf.52.1680244762665; 
 Thu, 30 Mar 2023 23:39:22 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a170906525200b0093f322187f0sm622686ejm.189.2023.03.30.23.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Mar 2023 23:39:22 -0700 (PDT)
Message-ID: <f5874f59-c388-9c51-5996-bdb9d168e791@gmail.com>
Date: Fri, 31 Mar 2023 08:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
 <aff27f2a-a878-be69-fb06-74f2063997f9@amd.com>
 <SN1PR12MB2445C6C12FC1824D4A14124DF58E9@SN1PR12MB2445.namprd12.prod.outlook.com>
 <ed7db628-3749-d109-73b3-aac9f04baf62@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ed7db628-3749-d109-73b3-aac9f04baf62@amd.com>
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Luben,

sorry, looks like I haven't seen your reply in my inbox at the time I've 
wrote my reply.

That seems to happen quite often with freedesktop.org list recently and 
I'm wondering if there's something wrong with my setup or the list server.

Christian.

Am 30.03.23 um 14:27 schrieb Luben Tuikov:
> Hi Alan,
>
> I'll comment in the other thread, as it seems Christian commented directly to your
> patch the day after my comment, rather than following up with my email sent the previous
> day and we now have two divergent threads where you post two identical comments, and it shouldn't
> be like that--we should have one thread only.
>
> Regards,
> Luben
>
> On 2023-03-30 04:59, Liu, HaoPing (Alan) wrote:
>> [AMD Official Use Only - General]
>>
>>
>> Hi, Luben
>>
>>   
>>
>> Thanks for the review. Please see inline.
>>
>>   
>>
>> Best Regards,
>>
>> Alan
>>
>>   
>>
>> -----Original Message-----
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Tuesday, March 28, 2023 3:00 AM
>> To: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
>>
>>   
>>
>> Hi,
>>
>>   
>>
>> That's a good fix. Some questions and comments below:
>>
>>   
>>
>> On 2023-03-27 11:20, Alan Liu wrote:
>>
>>> [Why]
>>> After gpu-reset, sometimes the driver would fail to enable vblank irq,
>>> causing flip_done timed out and the desktop freezed.
>>> During gpu-reset, we will disable and enable vblank irq in
>>> dm_suspend() and dm_resume(). Later on in
>>> amdgpu_irq_gpu_reset_resume_helper(), we will check irqs' refcount and decide to enable or disable the irqs again.
>>> However, we have 2 sets of API for controling vblank irq, one is
>>> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
>>> its own refcount and flag to store the state of vblank irq, and they
>>> are not synchronized.
>>   
>>
>> Is it possible to reconcile controlling VBlank IRQ to a single refcount?
>>
>>   
>>
>> In struct drm_vblank_crtc, we have “enabled” and “refcount” to store vblank irq state, and in struct amdgpu_irq_src we have “enabled_types” as the refcount for each irq in dm layer.
>>
>> To reconcile vblank irq to a single refcount, my idea is to remove enabled and refcount from struct drm_vblank_crtc, and add a callback function like vblank_irq_enabled() to drm_crtc_funcs.
>>
>> Drm layer can use this function to check the state or refcount of vblank irq from dm layer. But it may be dangerous because it is a change to drm layer. Do you have any comments?
>>
>>   
>>
>>> In drm we use the first API to control vblank irq but in
>>> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
>>> The failure happens when vblank irq was enabled by dm_vblank_get()
>>> before gpu-reset, we have vblank->enabled true. However, during
>>> gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
>>> checked from
>>> amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq
>>> again. After gpu-reset, if there is a cursor plane commit, the driver
>>> will try to enable vblank irq by calling drm_vblank_enable(), but the
>>> vblank->enabled is still true, so it fails to turn on vblank irq and
>>> causes flip_done can't be completed in vblank irq handler and desktop
>>> become freezed.
>>> [How]
>>> Combining the 2 vblank control APIs by letting drm's API finally calls
>>> amdgpu_irq's API, so the irq's refcount and state of both APIs can be
>>> synchronized. Also add a check to prevent refcount from being less
>>> then
>>> 0 in amdgpu_irq_put().
>>> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com <mailto:HaoPing.Liu@amd.com>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14
>>> ++++++++++----
>>>    2 files changed, 13 insertions(+), 4 deletions(-)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> index a6aef488a822..1b66003657e2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>>>              if (!src->enabled_types || !src->funcs->set)
>>>                             return -EINVAL;
>>>   
>>> +         if (!amdgpu_irq_enabled(adev, src, type))
>>> +                       return 0;
>>> +
>>>              if (atomic_dec_and_test(&src->enabled_types[type]))
>>>                             return amdgpu_irq_update(adev, src, type);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> index dc4f37240beb..e04f846b0b19 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> @@ -146,7 +146,7 @@ static void vblank_control_worker(struct
>>> work_struct *work)
>>>   
>>>   static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>>> {
>>> -          enum dc_irq_source irq_source;
>>> +         int irq_type;
>>>              struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>>>              struct amdgpu_device *adev = drm_to_adev(crtc->dev);
>>>              struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
>>> @@ -169,10 +169,16 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>>>              if (rc)
>>>                             return rc;
>>>   
>>> -          irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
>>> +         irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
>>> +acrtc->crtc_id);
>>> +
>>> +         if (enable)
>>> +                       rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
>>> +
>>> +         else
>>   
>>
>> There's an unnecessary empty line before the "else". It's a good idea to run patches through scripts/checkpatch.pl.
>>
>>   
>>
>> Thanks, will use the tool next time.
>>
>>   
>>
>>> +                       rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
>>>   
>>> -          if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>>> -                        return -EBUSY;
>>> +         if (rc)
>>> +                       return rc;
>>>   
>>>    skip:
>>>              if (amdgpu_in_reset(adev))
>>   
>>
>> --
>>
>> Regards,
>>
>> Luben
>>
>>   
>>


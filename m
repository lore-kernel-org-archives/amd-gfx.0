Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51641CA0EC3
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 09:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5EA710E3CA;
	Tue, 12 Sep 2023 09:01:13 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C793910E3CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 09:01:10 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31ae6bf91a9so5389714f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694509269; x=1695114069; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0i/t28w0M0/X8O2//uPsgOaMqvurUAc+fHm5DCtae4E=;
 b=DUaMSaY28asOXXPwqIhwugCfYMwZYF4k4bqczOiJHbt/81yyexBa6FBgu5XM0fGbPw
 /zQSnt5U37/9BNwYG53nCp6lrhJI5S+32RpfqikqOaUs/yDTahZrbKmSyyDzgg9QPAT+
 nW/xuxOuaAG222jjsPKSMOd8kFZ4S4biFBxVJKQfwEk71BwukVxwvfcrGM4/p6qI4+Jf
 OmysJMeeeM0vPKov1lkSh0J0Z2dilyut3Asnyf2N3r1Cbu9TQXYAwUMmxw212C90itj5
 i6SFxv/gxW+jBHAAf08Od+MULWMtNeuEdak7TjqPhoLmLVF9NS0K6iT5B7BBu1hKdnRW
 mUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694509269; x=1695114069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0i/t28w0M0/X8O2//uPsgOaMqvurUAc+fHm5DCtae4E=;
 b=osI5rdKknpCKWZUVnivCDdAJbCzqKpYiM76UBnOtXqajfuIJSVIawp8TPwPgY322AS
 6/gSRkxC5bFhJdRm57tyYO+6lMxc5uzIpwc07ArIIvuF5PKQkV7LVo2kuKcLt2QDBMjr
 H5JJTFkjT4vEEHBkpVXAoOYpEa2VXOv5BiTgAkQUxFlcHdMhWwzWaUtubftnKHaiMOSB
 +IFFGLQawHFNHmfp2uITLP++pZ78/xXGgZ1sQzMw/TTZb7lB/TeN/7RMCIjoETqjuj2q
 B/BDRhaPvAgc9ZH24DVZ0v9a8ihK6lCgcul7ZwX6Fl+FQg0OupWUTAIEtSZUF6vC/V9Y
 G5Gw==
X-Gm-Message-State: AOJu0YwqzGwKqyrIjZn0fe8wmX7WL9hCMnM3zOoyNPziJgJV+6fNbNUH
 4gN8IXxdj6Dq1fL1QdcoJwM=
X-Google-Smtp-Source: AGHT+IF4PF2qonTLWtRqk7seqYqyXuTWaAuf5L75D54LHKK2oEgwTaaExVK8rS+TYrt0xkw0woD3ZA==
X-Received: by 2002:adf:f9d0:0:b0:31a:dc58:cdd9 with SMTP id
 w16-20020adff9d0000000b0031adc58cdd9mr9354234wrr.60.1694509269097; 
 Tue, 12 Sep 2023 02:01:09 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c025100b00402c0a8a084sm15483943wmj.17.2023.09.12.02.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 02:01:08 -0700 (PDT)
Message-ID: <55b144a2-ce60-4f37-e5d8-a25c3b5e21ef@gmail.com>
Date: Tue, 12 Sep 2023 11:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdgpu: Ignore first evction failure during suspend
Content-Language: en-US
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230908033952.41872-1-xinhui.pan@amd.com>
 <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
 <DM4PR12MB5165CCF46CDD5781D41920EE87F1A@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB5165CCF46CDD5781D41920EE87F1A@DM4PR12MB5165.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Fan, Shikang" <Shikang.Fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When amdgpu_device_suspend() is called processes should be frozen 
already. In other words KFD queues etc... should already be idle.

So when the eviction fails here we missed something previously and that 
in turn can cause tons amount of problems.

So ignoring those errors is most likely not a good idea at all.

Regards,
Christian.

Am 12.09.23 um 02:21 schrieb Pan, Xinhui:
> [AMD Official Use Only - General]
>
> Oh yep, Pinned BO is moved to other LRU list, So eviction fails because of other reason.
> I will change the comments in the patch.
> The problem is eviction fails as many reasons, say, BO is locked.
> ASAIK, kfd will stop the queues and flush some evict/restore work in its suspend callback. SO the first eviction before kfd callback likely fails.
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Friday, September 8, 2023 2:49 PM
> To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Fan, Shikang <Shikang.Fan@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Ignore first evction failure during suspend
>
> Am 08.09.23 um 05:39 schrieb xinhui pan:
>> Some BOs might be pinned. So the first eviction's failure will abort
>> the suspend sequence. These pinned BOs will be unpined afterwards
>> during suspend.
> That doesn't make much sense since pinned BOs don't cause eviction failure here.
>
> What exactly is the error code you see?
>
> Christian.
>
>> Actaully it has evicted most BOs, so that should stil work fine in
>> sriov full access mode.
>>
>> Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra evict_resource call
>> during device_suspend.")
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 5c0e2b766026..39af526cdbbe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4148,10 +4148,11 @@ int amdgpu_device_suspend(struct drm_device
>> *dev, bool fbcon)
>>
>>        adev->in_suspend = true;
>>
>> -     /* Evict the majority of BOs before grabbing the full access */
>> -     r = amdgpu_device_evict_resources(adev);
>> -     if (r)
>> -             return r;
>> +     /* Try to evict the majority of BOs before grabbing the full access
>> +      * Ignore the ret val at first place as we will unpin some BOs if any
>> +      * afterwards.
>> +      */
>> +     (void)amdgpu_device_evict_resources(adev);
>>
>>        if (amdgpu_sriov_vf(adev)) {
>>                amdgpu_virt_fini_data_exchange(adev);


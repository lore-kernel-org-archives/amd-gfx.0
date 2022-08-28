Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740ADECAAD2
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Aug 2022 15:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508E010EF9B;
	Sun, 28 Aug 2022 15:28:17 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE5310EF9C
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Aug 2022 15:28:13 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 d12-20020a05600c34cc00b003a83d20812fso1635404wmq.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Aug 2022 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=b8PCkcBHt9jgp/LDwNiZzoQ3BSFXrWdesc5eDFpefoA=;
 b=m6MU1c4MJbrvPLkXV734ABjlm5AODVXaoAZ9JAPXu9pho4dyJb6FF7ij/FP/ZcoKt6
 K/AK4p4MGJiU3dcdP2ea4AqSXjJptb36plmpSS0knRvnX+ed9PCt+cntl91JhRWNScHi
 1rIjkMGXos7sFFy/0sK9+nC9ITAF5SBOBG8y4vEftc8Fu5Llm7BDUoQHMih6bHgD9eQw
 IteCgcHi7ljN2M3XxpRnLtfblxWhnvB/M5pA0uuLQnRUHI17flTLW7xhO/zO8cwiHlC2
 DeBZA8kXQX/Ea7rtgsoFKBeE6D3YWs7errU5dkkGXOaEmEOB7CR2d76wNNg4zL9k5KAl
 m9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=b8PCkcBHt9jgp/LDwNiZzoQ3BSFXrWdesc5eDFpefoA=;
 b=DGUDjSUBXyWv6awbjcBB4StiW9b4YR0h7yM5PT4Az5kjk3PGlCKS3ZTpX+jVfgnd1w
 25d1fo3XPcu/Dg7g6Fg7vUCML1aKJrk2m+5gVLrI3231BlP3kgvHyQSznSk2Q/sD15qN
 o+mFkh37Roi8+UZe5iquugy0rYwUo0/4sIB3C5Xr0mMqubDsl5duFtZl9gL09mGfoXkM
 RIqQan6Sus7sVtIP9t6gqyoUwb9itf0XxplVhsTu9POA2oy8w7LznE1CQybZHLvkrhHk
 uG6YtcyiuQcJW6oy6DH3XUUOi+i576UJh03QjK2cufwC1S1q58vqGVcY16V6WoI4Axiy
 RqEg==
X-Gm-Message-State: ACgBeo12joutRk4C6ergqRaxRB5vrvyddtQ3vtq6PxynnEmHuREyDP6V
 VNctZZcebaU3InRBCbvt/18=
X-Google-Smtp-Source: AA6agR51lROaTHtk0Kau+vaWlU6PVoAPWcglCq0cD7uoI31tfgTnGQ9rHeDh/DTVCLCR7ee1edicgg==
X-Received: by 2002:a05:600c:3844:b0:3a6:19a:d980 with SMTP id
 s4-20020a05600c384400b003a6019ad980mr4731585wmr.65.1661700491738; 
 Sun, 28 Aug 2022 08:28:11 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:7613:2618:4d4a:14cf?
 ([2a02:908:1256:79a0:7613:2618:4d4a:14cf])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a1c5444000000b003a63a3b55c3sm6952145wmi.14.2022.08.28.08.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Aug 2022 08:28:10 -0700 (PDT)
Message-ID: <877fa64a-10ad-9ff2-11f3-9a47174552b6@gmail.com>
Date: Sun, 28 Aug 2022 17:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: ensure no PCIe peer access for CPU XGMI
 iolinks
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220826154752.10984-1-alex.sierra@amd.com>
 <ca7c6e23-2a1a-2bed-7ae8-6a5092cb083d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ca7c6e23-2a1a-2bed-7ae8-6a5092cb083d@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.08.22 um 23:49 schrieb Felix Kuehling:
> On 2022-08-26 11:47, Alex Sierra wrote:
>> [Why] Devices with CPU XGMI iolink do not support PCIe peer access.
>>
>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index ce7d117efdb5..1ff66718639d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5538,7 +5538,8 @@ bool amdgpu_device_is_peer_accessible(struct 
>> amdgpu_device *adev,
>>       return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
>>           adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
>>           !(adev->gmc.aper_base & address_mask ||
>> -          aper_limit & address_mask));
>> +          aper_limit & address_mask) &&
>> +        !adev->gmc.xgmi.connected_to_cpu);
>
> Maybe it would be more readable if you added this to the 
> initialization of p2p_access. In that case you can also save yourself 
> the call to pci_p2pdma_distance_many and all the aperture checks. Like 
> this:
>
>     bool p2p_access = !adev->gmc.xgmi.connected_to_cpu &&
>         !(pci_p2pdma_distance_many(adev->pdev, &peer_adev->dev, 1, 
> true) < 0);

Yeah, agree. Static checks should come first.

But another question: When we have an XGMI link to the CPU all local 
memory is directly accessible, isn't it?

So the PCIe root complex should be able to allow PCIe device to access 
our local memory, even with snooping.

Or do I miss something here?

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>   #else
>>       return false;
>>   #endif


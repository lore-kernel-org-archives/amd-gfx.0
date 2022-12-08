Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05289C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 11:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3780610E1D3;
	Thu,  8 Dec 2022 11:26:22 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8556210E1D3
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 11:26:19 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id kw15so3078698ejc.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Dec 2022 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IGoYA4rJmtnt7dwu3LSi7hrfdD1qgoDNhyKsRwxPt+E=;
 b=F77G/7E+CzmzDm3CSMTjjGJVtYLUCN/U8U8h0MeS5zqsx3dY3QE/S7aDTT/ErUIdN/
 AqP0eASJgvLuw8l/tfG+Cq5MLdoh7k+Fpd4TrPTCV46c0GRs8iEG8ZjDlhF3JWqUNKh/
 EghL7vxKFTlEJarDES0ZU2//5sXoAghDBrpMjGXLWJkKpMj14PV4J2OpXzvoA/YvUa7V
 IH/XbFq2VD3C9O5W3W+ABxYup7gvTjXDYwbYFgoXL7c1b3yYXlpda3+H+N9Bvvdd9x0b
 N21VtHwKp77VqMz5G8311FEiJZTt1Mb8erBuJCRhPDvmW4hR7QuVbn/USv9ASjiNt2WJ
 yF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IGoYA4rJmtnt7dwu3LSi7hrfdD1qgoDNhyKsRwxPt+E=;
 b=dY5VOO49TXu+wggoEnBO1SFPx3KOXddmbBqKGX7Z7B6ExICaOftOUS/w/x+JqFz06E
 NnVxa0RCd4k+07DwMh+iMUrPBb1Pxu2QGs6Y53eoWFLBsKtZeSg/QqhcWlbokzh3GLsK
 7P4x2Y++rYtce0rdxR04mBZOEt2lF8yI5DcgpXCrxjWiEsXcTM3aqrbcRt742+8trog/
 L+4PBkk8EevzQH44CVZDFocoSKvJhhk1956qk5xaWf4Nfo0r71373IfNM21eVPauevlu
 2rXieEsX91QJ5JQyiwF5PnbWwU5fXltsrDZVR5FFz87GIQU87RL/+S26D7o+dr/SZ659
 oTmw==
X-Gm-Message-State: ANoB5plzAbWAlcSRq5FK3h9iyoXiz8X7K8/E9JRlpyJUhbwdN8Y/rS/c
 UvqfEKqyoU5N7xr+A2xRTnc=
X-Google-Smtp-Source: AA0mqf531bJIHm1wJfZ6uodFc1njX89Q3j4nKaDuLyypDKt9xZR6ephX0IaNObyE213NOFddc8ZUvg==
X-Received: by 2002:a17:906:35d1:b0:7c0:aa96:e934 with SMTP id
 p17-20020a17090635d100b007c0aa96e934mr27013536ejb.309.1670498777883; 
 Thu, 08 Dec 2022 03:26:17 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:172d:b6f5:d270:8dd2?
 ([2a02:908:1256:79a0:172d:b6f5:d270:8dd2])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170906314a00b007bfc5cbaee8sm9700436eje.17.2022.12.08.03.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Dec 2022 03:26:17 -0800 (PST)
Message-ID: <bb18135e-002b-e6a5-0c31-636810f914e9@gmail.com>
Date: Thu, 8 Dec 2022 12:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Add an extra evict_resource call during
 device_suspend.
Content-Language: en-US
To: "Fan, Shikang" <Shikang.Fan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221208092545.4792-1-shikang.fan@amd.com>
 <9d88a136-bd7e-3af2-acc7-c19521556a2d@gmail.com>
 <MW2PR12MB2586FE60C8A0247C1EAC68DEEB1D9@MW2PR12MB2586.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MW2PR12MB2586FE60C8A0247C1EAC68DEEB1D9@MW2PR12MB2586.namprd12.prod.outlook.com>
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

Hi Shikang,

good point.

The double checking this the second eviction was removed by Nirmoy 
because we didn't needed it any more. The GART table and fw images are 
now just uploaded to VRAM again after resume. I didn't had that info in 
my mind any more, so sorry my fault :)

Adding and extra eviction before grabbing full access makes sense 
because we can then move the majority of the buffers out of VRAM without 
worrying about any timeouts.

What's left are the display BOs which can only be evicted after phase1 
is completed (because that turn of the display engine). But we should 
still do this before phase2 because we want to use the hw accelerated 
DMA for this.

Otherwise we will run into trouble because a) CPU accesses are not 
always possible and b) take way more time than doing it with the DMA.

I suggest to just add the extra eviction with a comment above like /* 
Evict the majority of BOs before grabbing the full access */.

Regards,
Christian.

Am 08.12.22 um 10:58 schrieb Fan, Shikang:
> [AMD Official Use Only - General]
>
> Hi Christian,
> http://gerrit-git.amd.com/c/brahma/ec/linux/+/620522 In this patch I saw that there was originally two evict in the suspend and this patch the second one (the one after ip_suspend2) were removed. I am a little bit confused on this, should I just keep the way it is and just add an extra evict in the beginning?
>
> Thanks,
> Shikang.
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Thursday, December 8, 2022 5:30 PM
> To: Fan, Shikang <Shikang.Fan@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Add an extra evict_resource call during device_suspend.
>
> Am 08.12.22 um 10:25 schrieb Shikang Fan:
>> - evict_resource is taking too long causing sriov full access mode timeout.
>>     So, add an extra evict_resource in the beginning as an early evict.
>> - Move the original evict_resource after ip_suspend2.
>>
>> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++----
>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 818fa72c670d..8b7db87cffd9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4111,6 +4111,10 @@ int amdgpu_device_suspend(struct drm_device
>> *dev, bool fbcon)
>>    
>>    	adev->in_suspend = true;
>>    
>> +	r = amdgpu_device_evict_resources(adev);
>> +	if (r)
>> +		return r;
>> +
>>    	if (amdgpu_sriov_vf(adev)) {
>>    		amdgpu_virt_fini_data_exchange(adev);
>>    		r = amdgpu_virt_request_full_gpu(adev, false); @@ -4135,14
>> +4139,14 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>>    	if (!adev->in_s0ix)
>>    		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>>    
>> -	r = amdgpu_device_evict_resources(adev);
>> -	if (r)
>> -		return r;
>> -
>>    	amdgpu_fence_driver_hw_fini(adev);
>>    
>>    	amdgpu_device_ip_suspend_phase2(adev);
>>    
>> +	r = amdgpu_device_evict_resources(adev);
>> +	if (r)
>> +		return r;
>> +
> As noted internally please keep this evict resources call where it was.
>
> It makes sense to evict the BOs which were previously pinned by display with the SDMA engine.
>
> Only the final eviction of BOs for fw etc.. should be done with the CPU.
>
> I suggest to also add a comment to each call explaining why we need it.
>
> Regards,
> Christian.
>
>>    	if (amdgpu_sriov_vf(adev))
>>    		amdgpu_virt_release_full_gpu(adev, false);
>>    


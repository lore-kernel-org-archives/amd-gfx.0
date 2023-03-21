Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E3AC6FD20
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 18:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545FC10E12F;
	Tue, 21 Mar 2023 18:52:43 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0AB310E12F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 18:52:41 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id m2so14762523wrh.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679424760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SVe30CNmwxZygCTEfv/jO2zTTbtL7l89qR3/E0vtZ0I=;
 b=chkPqNdpGcGG5pSb+Hl9r3vWkf/bthL7P2xNCHzkvs2bpnvHc+QSrcv1CFmT23xLyq
 FoUbCuJTihWWc20qCo0yjV5IiDrtZb4z54tY2UYW/dIsS8xgTj4GifABnsgaLBj3n8NN
 ncmiwibNWGgRfzosRNsGP2CWGhh6SPusgkNKb+JW3wyr4YyPOKrQQhKry/99lSDiHMOi
 QoLg1f3TxeH0II4CIxhsg+UqNJtMz2q3+wsSNuDm39czJ+Ql8FhBSWPivgrD08gZYtp6
 /IpnTSwvP9BmBCp2CCP9lYY2/9jWym42qY/8fR4HXYAH+1rAPFF9pW8ig9M+GmArSgTy
 nIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679424760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SVe30CNmwxZygCTEfv/jO2zTTbtL7l89qR3/E0vtZ0I=;
 b=vM8y67FlWFlPHfgaFJtVgZQ/2rtnQzMSmyu1hSt39B+Iwjpc1yKFR9A5mvEpAokNGP
 WnBTJo/43WRDvvqU5qauRByTmCbzMjQzavayq04Wu0En1hWq2hQDli+ZMLHqcwbXKrGw
 UmfGBp4TnS17Tm5kbrb2lFspXqFSzmPwut9RIHrB+abhp0XAYJ7rXodSj82A0x1V/oPg
 lwoXtsdqmxGhaEAQ0BF1Rel5/21cHxQz7cMLymtwkffs+1MWmkB6bvEV6RQD82p4o6fk
 T17kdOCFE/dUFZiILGq8FxCgLNr7hFAEoLss6q+py8SrgN166vIs6ch9ncV75Kllrxw9
 oKSA==
X-Gm-Message-State: AO0yUKVqRAFCYlsSfet23UYXtKFCtbhUkzP0Dvsk9dgFlH+4kvJLphqX
 rgOlj5ufo/74K2h0I4QKB9A=
X-Google-Smtp-Source: AK7set8b3dx/5NBGDfAcO01ECGaTw1BtF6H+7qG8b/2bnpJYjMcpR1XPNqYrst68jAD19fI6SYveMQ==
X-Received: by 2002:a5d:5042:0:b0:2da:1ac3:adfc with SMTP id
 h2-20020a5d5042000000b002da1ac3adfcmr360524wrt.60.1679424759812; 
 Tue, 21 Mar 2023 11:52:39 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:67fe:537e:316f:d8a?
 ([2a02:908:1256:79a0:67fe:537e:316f:d8a])
 by smtp.gmail.com with ESMTPSA id
 e23-20020a5d5957000000b002cfefa50a8esm11889568wri.98.2023.03.21.11.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Mar 2023 11:52:39 -0700 (PDT)
Message-ID: <5c9b1fc6-d404-a5ef-b89d-c02de7603644@gmail.com>
Date: Tue, 21 Mar 2023 19:52:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: add print for iommu translation mode
Content-Language: en-US
To: "Sider, Graham" <Graham.Sider@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230317194757.1336098-1-Graham.Sider@amd.com>
 <0509601d-8d7c-26e2-26c9-8f4757a92ca2@amd.com>
 <DM5PR12MB1308BF656CB0C75BA0B9CED885BD9@DM5PR12MB1308.namprd12.prod.outlook.com>
 <DM6PR12MB30674A9D4B81185DA913A2278ABD9@DM6PR12MB3067.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM6PR12MB30674A9D4B81185DA913A2278ABD9@DM6PR12MB3067.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.03.23 um 21:04 schrieb Sider, Graham:
> [AMD Official Use Only - General]
>
>
>
>> -----Original Message-----
>> From: Russell, Kent <Kent.Russell@amd.com>
>> Sent: Friday, March 17, 2023 3:58 PM
>> To: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Sider, Graham
>> <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: add print for iommu translation mode
>>
>> [AMD Official Use Only - General]
>>
>>
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Hamza Mahfooz
>>> Sent: Friday, March 17, 2023 3:58 PM
>>> To: Sider, Graham <Graham.Sider@amd.com>;
>>> amd-gfx@lists.freedesktop.org
>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: add print for iommu translation mode
>>>
>>>
>>> On 3/17/23 15:47, Graham Sider wrote:
>>>> Add log to display whether RAM is direct vs DMA mapped.
>>>>
>>>> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
>>> If this information is only useful for debugging purposes, please use
>>> drm_dbg() instead of pr_info().
> It's useful for more than just debug I would say. Just a quick way to grep whether IOMMU is off/pt vs device isolation mode.

Mhm, shouldn't the IOMMU code note that as well?

Christian.

>
> Graham
>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 8bba5e6872a1..8797a9523244 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3528,8 +3528,12 @@ static void
>>> amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
>>>>    	struct iommu_domain *domain;
>>>>
>>>>    	domain = iommu_get_domain_for_dev(adev->dev);
>>>> -	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
>>>> +	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY) {
>>>> +		pr_info("RAM is direct mapped to GPU (not traslated by
>> traslated -> translated
>>
> Thanks, my keyboard keeps skipping the on the 'n' key lately :( time for a clean.
>
> Graham
>
>>   Kent
>>> IOMMU)\n");
>>>>    		adev->ram_is_direct_mapped = true;
>>>> +	} else {
>>>> +		pr_info("RAM is DMA mapped to GPU (translated by
>>> IOMMU)\n");
>>>> +	}
>>>>    }
>>>>
>>>>    static const struct attribute *amdgpu_dev_attributes[] = {
>>> --
>>> Hamza


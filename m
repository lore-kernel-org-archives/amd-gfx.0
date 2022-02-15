Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8CCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 14:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4AA310E54E;
	Tue, 15 Feb 2022 14:37:06 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DE910E54E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 14:37:05 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id w10so13730272edd.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 06:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=HkzTCKvbs4IpEvSH56mgdkMT1XKCCf/ghpP1a0yoDTg=;
 b=U8kPOOhcoBAiXkdw/wzuDpngCMhSdFUpcppT8CthssWb8l5cs4BvKpREn/vebxuanp
 XfMzTPDb/EoXwblRit3setfvDPmi/blM3id4w/0+6eQ7DMWBCQITgRLWeE4Zv2/+8Q0d
 uskTaK1f9gemt37pNoPyA/CvxWm6e9EkC3soCuhhYZLrjDBRxfUwB7/DLgvv9VMKaWyv
 GNeKK8EMc7SEF/YP+Xw9dts73Qbek/EEwLOkoyQzvhIHOlpT9zik5cjFIaNufcgWYUaC
 KRQR55/snP6++kF/6BkCvZ0Epf8NCKFhmwLwWZ+8GFH6caUwxGZRfTRpOrsjyood19y7
 NJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HkzTCKvbs4IpEvSH56mgdkMT1XKCCf/ghpP1a0yoDTg=;
 b=JUEuUKN13OUjNJczDxUHN9ptUHN+OpMyYCijMrXpnI8Y/J27Xl8P2BxN3raCx8oMaG
 Ukr2nbun13E7siwrMGK91pmx55PUVmPDN+xqsDuoQCQSS0gEo82r5skVSI9UklSSZ625
 n4vNqNTn/30QKqNKi5Hi5nh73NZNtF0AxABx903SFE9Z7UzZ8VcG2vl3vOUqYivNkT2a
 UGYuiv2oIehVITD7K4vHeFX+wbkEFGPeRT1MHskLqiXc89tT+8cA14AeMYwPUP2A8afN
 bABAf6yILh+0GbnwTq5dJzLVOz+m0SiksfV7OIjFWVZAJKp0utL765tKEdPMxkkssEHx
 cfpA==
X-Gm-Message-State: AOAM533vIXvwBNlw0xkO8QCQpyPgaYl5pmvm+LLwXvGl17ZDJQ8ffly8
 RjXJ0KLflT88GQDihzepDxE=
X-Google-Smtp-Source: ABdhPJzqAcs/WaMcZ35BoA2iDCH+pHTzaUp73RxB2gYZTheAalz+I+0k50beCAEW/EOK2UZoECd9Bg==
X-Received: by 2002:a05:6402:348c:: with SMTP id
 v12mr4219052edc.384.1644935823767; 
 Tue, 15 Feb 2022 06:37:03 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:1771:accb:e45c:a51b?
 ([2a02:908:1252:fb60:1771:accb:e45c:a51b])
 by smtp.gmail.com with ESMTPSA id r17sm3782298edd.64.2022.02.15.06.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 06:37:03 -0800 (PST)
Message-ID: <699b8634-ab4d-db1b-8226-743956c3be41@gmail.com>
Date: Tue, 15 Feb 2022 15:37:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220214231857.5129-1-luben.tuikov@amd.com>
 <20220214232154.6421-1-luben.tuikov@amd.com>
 <a0bd54e0-142c-a8e9-964f-25560e35177c@gmail.com>
 <62f50472-fdf3-86d0-edc0-69c56e9de24b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <62f50472-fdf3-86d0-edc0-69c56e9de24b@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 15.02.22 um 15:33 schrieb Luben Tuikov:
> On 2022-02-15 09:25, Christian König wrote:
>> Am 15.02.22 um 00:21 schrieb Luben Tuikov:
>>> Add the "harvest" field to the IP attributes in
>>> the IP discovery sysfs visualization, as this
>>> field is present in the binary data.
>>>
>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> index c8dbdb78988ce0..0496d369504641 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> @@ -393,6 +393,7 @@ struct ip_hw_instance {
>>>    	int hw_id;
>>>    	u8  num_instance;
>>>    	u8  major, minor, revision;
>>> +	u8  harvest;
>> Should we maybe use bool here instead?
>>
>> Apart from that looks good to me.
> Thanks Christian.
>
> I don't mind using bool here.
>
> I saw the field in the binary data is 4 bits and represented that.
>
> Is the field actually bool in the IP binary data?

I'm not sure either.

I would have expected it to be a single bit flag in the binary, but 
4bits sounds like it serves some more purpose.

Probably best to stick to u8 for now in this case.

Regards,
Christian.

> I can change the patch and resubmit.
>
> Regards,
> Luben
>
>> Regards,
>> Christian.
>>
>>>    
>>>    	int num_base_addresses;
>>>    	u32 base_addr[];
>>> @@ -440,6 +441,11 @@ static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>>    	return sysfs_emit(buf, "%d\n", ip_hw_instance->revision);
>>>    }
>>>    
>>> +static ssize_t harvest_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>> +{
>>> +	return sysfs_emit(buf, "0x%01X\n", ip_hw_instance->harvest);
>>> +}
>>> +
>>>    static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>>    {
>>>    	return sysfs_emit(buf, "%d\n", ip_hw_instance->num_base_addresses);
>>> @@ -471,6 +477,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] = {
>>>    	__ATTR_RO(major),
>>>    	__ATTR_RO(minor),
>>>    	__ATTR_RO(revision),
>>> +	__ATTR_RO(harvest),
>>>    	__ATTR_RO(num_base_addresses),
>>>    	__ATTR_RO(base_addr),
>>>    };
>>> @@ -708,6 +715,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>>>    			ip_hw_instance->major = ip->major;
>>>    			ip_hw_instance->minor = ip->minor;
>>>    			ip_hw_instance->revision = ip->revision;
>>> +			ip_hw_instance->harvest = ip->harvest;
>>>    			ip_hw_instance->num_base_addresses = ip->num_base_address;
>>>    
>>>    			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
>>>
>>> base-commit: d8604f1d237a145db48bae4ea60b85a5875df307
> Regards,


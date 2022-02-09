Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DF4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 08:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367C510E59A;
	Wed,  9 Feb 2022 08:51:32 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 000C110E59A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 08:51:30 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id f17so2801635wrx.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Feb 2022 00:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=L4p4mNdlHkZdnI3jg3HE31kstXWWzI9gaefBIe+5co4=;
 b=GN2kruB/uG3yKxMzWN9GWJ476mLzL8jgQ3Nl/REdrLq5bRnV/LjQdk+HV1mqMXlF6m
 FwnEx38IfxOY/fyC5iqrGMfs0OZwMyGsyw7/EDgHkszcvPyxv4og2sCSbw/TGtlaECHE
 FL3fXcnNilPqlgnf77CqEbJKr9My6gx+/5YzzN8ICyUOTDZCT3UwUR5Lk4sHxeWREbtL
 ZNuAm+XB68bMutK+iguE/VZCq7SqDkdcsavPYZzhtU33anW4qGnLxrbpna/weEUD4aXU
 2oEZpoTJKkh0UVADiD+OoZmvUAs2Kd8g2CubJV3nCeAII4EHhCDgtPn1/v4sH9TD066R
 rIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=L4p4mNdlHkZdnI3jg3HE31kstXWWzI9gaefBIe+5co4=;
 b=cZ+U6Bz5vOI15KdopLCrrUeVmpom2g5tU52S5D5y8ipYPMAJmOMw/fGa3mahRTvU2y
 y+e8FkaMUETyPE5AyNVM+UE3HEnkQclCby2AdRlzQGQXpMhwQ07v+JzB0HeQR7CwpUYq
 9ekk2Wdlyx51wKT1gMnwCJfpJBD5Zw8Hb0TvVS9ovHrsRS7cWEDvOqMtMPIKMA/JPcuc
 Gg2/JbrUDiiAbheDbwIfKJBjdrvVEy5n/0MRpjK1MjCzvnU1UBo0rMaYg/DCdEuRUNzC
 Y2R7mESvQzSuztXUwxn4Z9AkwZD9ExupaSeo4y6AQuEAjJ8s928MJXFFvjOOFDvETwQ4
 OkxQ==
X-Gm-Message-State: AOAM533ETXa884X+xYZKW+RstH8x6jHyyIes00bWAp2o/7rahTZpe5nE
 dR/8/dWtVE64LKZ0kITeSLk=
X-Google-Smtp-Source: ABdhPJymi9WzsBQz76E3rfyXU9u+APnbGxqFvqzraO/2TPfp9hh1weXvNqvtCV7harVGdXPiETV/TQ==
X-Received: by 2002:adf:f18f:: with SMTP id h15mr445298wro.513.1644396689488; 
 Wed, 09 Feb 2022 00:51:29 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:5f8a:b8f9:e10:2aaa?
 ([2a02:908:1252:fb60:5f8a:b8f9:e10:2aaa])
 by smtp.gmail.com with ESMTPSA id y3sm16512478wry.109.2022.02.09.00.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Feb 2022 00:51:29 -0800 (PST)
Message-ID: <84b638db-8101-7acc-c5c3-77961ef892e5@gmail.com>
Date: Wed, 9 Feb 2022 09:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add sysfs files for XGMI segment size and
 physical node id
Content-Language: en-US
To: "StDenis, Tom" <Tom.StDenis@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
References: <20220126115917.60308-1-christian.koenig@amd.com>
 <20220126115917.60308-2-christian.koenig@amd.com>
 <fbf698cf-594a-2980-814f-dc66e576ad62@amd.com>
 <DM6PR12MB3547491395B2ABB676CC9000F7209@DM6PR12MB3547.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM6PR12MB3547491395B2ABB676CC9000F7209@DM6PR12MB3547.namprd12.prod.outlook.com>
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can anybody give me a Tested-by for this set?

I would really like to push it, but it would be nice to have at least 
somebody with access to an xgmi system tries it first.

Christian.

Am 26.01.22 um 13:57 schrieb StDenis, Tom:
> [AMD Official Use Only]
>
> Sadly I don't control any XGMI hosts to try it out.  So if they pick it up in their builds I can but otherwise we'll have to wait.
>
> Tom
>
> ________________________________________
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Wednesday, January 26, 2022 07:55
> To: Christian König; StDenis, Tom
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 2/2] drm/amdgpu: add sysfs files for XGMI segment size and physical node id
>
> This seems reasonable. Hope it works out for umr.
>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>
> Regards,
> Luben
>
> On 2022-01-26 06:59, Christian König wrote:
>> umr needs that to correctly calculate the VRAM base address
>> inside the MC address space.
>>
>> Only compile tested!
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 34 ++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> index 68509f619ba3..21a5d07a1abf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> @@ -252,6 +252,26 @@ static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
>>
>>   }
>>
>> +static ssize_t amdgpu_xgmi_show_node_segment_size(struct device *dev,
>> +                                               struct device_attribute *attr,
>> +                                               char *buf)
>> +{
>> +     struct drm_device *ddev = dev_get_drvdata(dev);
>> +     struct amdgpu_device *adev = drm_to_adev(ddev);
>> +
>> +     return sysfs_emit(buf, "%llu\n", adev->gmc.xgmi.node_segment_size);
>> +}
>> +
>> +static ssize_t amdgpu_xgmi_show_physical_node_id(struct device *dev,
>> +                                              struct device_attribute *attr,
>> +                                              char *buf)
>> +{
>> +     struct drm_device *ddev = dev_get_drvdata(dev);
>> +     struct amdgpu_device *adev = drm_to_adev(ddev);
>> +
>> +     return sysfs_emit(buf, "%u\n", adev->gmc.xgmi.physical_node_id);
>> +}
>> +
>>   #define AMDGPU_XGMI_SET_FICAA(o)     ((o) | 0x456801)
>>   static ssize_t amdgpu_xgmi_show_error(struct device *dev,
>>                                      struct device_attribute *attr,
>> @@ -287,6 +307,10 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
>>
>>
>>   static DEVICE_ATTR(xgmi_device_id, S_IRUGO, amdgpu_xgmi_show_device_id, NULL);
>> +static DEVICE_ATTR(xgmi_node_segment_size, S_IRUGO,
>> +                amdgpu_xgmi_show_node_segment_size, NULL);
>> +static DEVICE_ATTR(xgmi_physical_node_id, S_IRUGO,
>> +                amdgpu_xgmi_show_physical_node_id, NULL);
>>   static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);
>>
>>   static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
>> @@ -295,6 +319,8 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
>>        char node[10];
>>
>>        device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
>> +     device_remove_file(adev->dev, &dev_attr_xgmi_node_segment_size);
>> +     device_remove_file(adev->dev, &dev_attr_xgmi_physical_node_id);
>>        device_remove_file(adev->dev, &dev_attr_xgmi_error);
>>
>>        if (hive->kobj.parent != (&adev->dev->kobj))
>> @@ -318,6 +344,14 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
>>        if (r)
>>                goto error;
>>
>> +     r = device_create_file(adev->dev, &dev_attr_xgmi_node_segment_size);
>> +     if (r)
>> +             goto error;
>> +
>> +     r = device_create_file(adev->dev, &dev_attr_xgmi_physical_node_id);
>> +     if (r)
>> +             goto error;
>> +
>>        /* Create sysfs link to hive info folder on the first device */
>>        if (hive->kobj.parent != (&adev->dev->kobj)) {
>>                r = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
> Regards,
> --
> Luben
>


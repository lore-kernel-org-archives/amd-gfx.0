Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FC2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 11:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9911860C51
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 11:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9911860C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A87F6E5A0;
	Tue,  2 Nov 2021 11:09:11 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B8A6E5A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 11:09:10 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 d72-20020a1c1d4b000000b00331140f3dc8so1775651wmd.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Nov 2021 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=icgX/46V/U1DTGkQySQPJOp9y8S7TszrA40APruvk8A=;
 b=OK+jfvYNSaGiDArG8PPEXqTi4+FchImG/xme72PejLd365xviy5CnWZj6jkvtTlGQp
 ymBImRE2+K7vwyzXAGkcC966U7zDHHf351ekSvgxrzDYMEe6C/XlSQzgtuQqrroT6Gpx
 vUQhOtqn0GQVdimTXeSx3H9sIPjfCQizI9h/b2QaR/mqID6zya0WA5qPOmTRTORPuXcY
 DrufGymuQMjYNaJEaUiCqn4m9BrpZpDQ9As/0geTVYn7WP89LiXhb8U2eb2l4hJHblxd
 3YotM4wSpHe333prQpfcju+7HeHq7r+gQbBqg5ds9VzUw55Fe/52nV68riIW0oQN7EcX
 CQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=icgX/46V/U1DTGkQySQPJOp9y8S7TszrA40APruvk8A=;
 b=gu/YD73/F6dpv5+Yl/AK6zhmAN55ZjAD8Rj7tTISw1RmUdmoDN1wB/yFJI88YboH6V
 n/uR80tUkNw+7yxoTK79RAI5E0+J/pva9GxRbPmyKqukSXt4uFY5Hd6wpn8MFQRLx7Hy
 NpjUUrwEQfUcAlRf5fFg9g5ZSkcYzolhZWWE3cBS1QpTA6qfCSKycSNBQ/SwgrFjZ4hs
 eWD3LVXlxqXJetpMozYRO1kaPRNzsh3uJButRJoogzZE3+1mrE3diezQyIvBTxI4ve2X
 OPJLhfbNIRUTeQMSrGgcEf+s52Lg6WQxTKMf6RqKpoYZoCxs2PctBQQcjbTre28oLrWQ
 IqFA==
X-Gm-Message-State: AOAM533itzN2Nm4t+sm888VuMUV7NP97nA++QyQ16ry1Tdh+Gl6jw+J1
 TUPUPjK3WTwZDpeydLMKIrcDi8wwuBM=
X-Google-Smtp-Source: ABdhPJzBnqoz6MUuhgQCUccnnfwvvVp1N0Eb2yXltS/MdjKjBXSNYKoMxM3oxOTRXSDYW6/gZLzZ9w==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr6312858wmi.61.1635851348739; 
 Tue, 02 Nov 2021 04:09:08 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:2746:f022:81db:a2f4?
 ([2a02:908:1252:fb60:2746:f022:81db:a2f4])
 by smtp.gmail.com with ESMTPSA id r7sm8601546wrq.29.2021.11.02.04.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 04:09:08 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: return early on error while setting bar0
 memtype
To: "Das, Nirmoy" <nirmoy.das@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211029150917.4462-1-nirmoy.das@amd.com>
 <69967ca1-6482-7cd2-1c32-d4de5c8136eb@amd.com>
 <c807f013-1931-bf17-6942-28e7413bc627@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7b1efea0-d937-c7e7-4d9d-7583cc9fa368@gmail.com>
Date: Tue, 2 Nov 2021 12:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c807f013-1931-bf17-6942-28e7413bc627@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.11.21 um 11:11 schrieb Das, Nirmoy:
>
> On 11/2/2021 9:00 AM, Lazar, Lijo wrote:
>>
>>
>> On 10/29/2021 8:39 PM, Nirmoy Das wrote:
>>> We set WC memtype for aper_base but don't check return value
>>> of arch_io_reserve_memtype_wc(). Be more defensive and return
>>> early on error.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 073ba2af0b9c..6b25982a9077 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -1032,9 +1032,14 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>>>       /* On A+A platform, VRAM can be mapped as WB */
>>>       if (!adev->gmc.xgmi.connected_to_cpu) {
>>>           /* reserve PAT memory space to WC for VRAM */
>>> -        arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>>> +        int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>>>                   adev->gmc.aper_size);
>>
>> BTW, isn't it more appropriate to use visible vram size? There are 
>> cases where pci resize rounds aperture to the next higher size > size 
>> of actual VRAM.
>
>
> Good point, I will update this one and send again.

Not a good idea at all.

The aperture size is rounded up to the next power of two and that's 
exactly what we should stick to if we don't want to get an error code in 
return.

Regards,
Christian.

>
>
> Regards,
>
> Nirmoy
>
>
>>
>> Thanks,
>> Lijo
>>>   +        if (r) {
>>> +            DRM_ERROR("Unable to set WC memtype for the aperture 
>>> base\n");
>>> +            return r;
>>> +        }
>>> +
>>>           /* Add an MTRR for the VRAM */
>>>           adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
>>>                   adev->gmc.aper_size);
>>>


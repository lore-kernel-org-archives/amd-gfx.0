Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ECCC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 14:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64AA28D155;
	Wed, 20 Jul 2022 14:30:06 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A70BE8D140
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 14:30:04 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id h9so1314244wrm.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=lihVnESNxtKqa5QCvhIky2zRyKJ/iz7K7AKnzi3zyFo=;
 b=CMSOyGO1c4uAYhd58n6vZa/LdEF18y1MrE2U+JpfXH60g+YS25R7xO+1RrycjcgqB0
 Ucj5tSSyajmpwxvkxFFGm2UpZgxx+KBdYpTq9HxPWoyTeocOOZN0kmZbXsXZPUSGrZYc
 OliB7C7wTWXAe4CZwC8motrjr437NgW2SNME2OzK3ytGCcY/QJLzGuKyZMmZ0BaXF1oc
 CYIoPpRkH2g210ede6ofiKMHs7Sv0GOdX6bGNB+fUN7QziHAedkPIGkTVdXN1HB5izU/
 jWUTSwC68LDIYr+oAUbwpfcYRqaA7Zx6hKmS8qs1Vjsta1a39KWUEZQFIjejFU/AksUO
 DUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=lihVnESNxtKqa5QCvhIky2zRyKJ/iz7K7AKnzi3zyFo=;
 b=Pxe+eOzgdB5b3N0s3VShR8c471xJS+5re7caZnwSlwvqrW6cLe1TRFuM5UfL20K49u
 ylyUFWuQ/XoYCNtd0kEyPO74jA5avg40SQPCaFG2zJjM0NjHn0Z64c667DL5EZQF7WL/
 v4GGPgWimE3GW2NiF/q2o7hAW875bfXcLsax5KxQqhvAhvH9fQuwMbr6qHTaaTT0H0DI
 E21NgqRSCeZsEMhIa5BJpsONBZTRFb0rk/XqdaeaTlUSD02ic+yPqoQqM2D2X/bTitbQ
 yHhJP+p8DOHxJcvVfK48sriYfkrG/e5j8QX+06+Ijc3UdP9qCCi+BCu/5AOkV3OfIBri
 vTbw==
X-Gm-Message-State: AJIora+XH3XLkuEsQnsOjvVlzgBFmPDJCtOCLHEOKqjkL1kDkAZWmNf3
 9lcyoD7uK6SU9RZgy7Lbw/c=
X-Google-Smtp-Source: AGRyM1uNA7vH7aSSBg4L6YfIelC0ib7H8IJ9vEhsFIhG5rtRx4l4vk/I41MRQjWDH91DKLVhFWFg4A==
X-Received: by 2002:adf:f64f:0:b0:21d:76c6:d98 with SMTP id
 x15-20020adff64f000000b0021d76c60d98mr30795743wrp.299.1658327403095; 
 Wed, 20 Jul 2022 07:30:03 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:c3a3:a774:9c4e:7491?
 ([2a02:908:1256:79a0:c3a3:a774:9c4e:7491])
 by smtp.gmail.com with ESMTPSA id
 bj5-20020a0560001e0500b0021dd8e1309asm178447wrb.75.2022.07.20.07.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Jul 2022 07:30:02 -0700 (PDT)
Message-ID: <579fc4f4-679a-1e7d-d511-14102b9c1692@gmail.com>
Date: Wed, 20 Jul 2022 16:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix the incomplete product number
Content-Language: en-US
To: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
 Roy Sun <Roy.Sun@amd.com>
References: <20220720082659.49637-1-Roy.Sun@amd.com>
 <619fc381-04e0-bc1f-62ad-a1169a63febc@igalia.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <619fc381-04e0-bc1f-62ad-a1169a63febc@igalia.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.07.22 um 16:26 schrieb André Almeida:
> Às 05:26 de 20/07/22, Roy Sun escreveu:
>> The comments say that the product number is a 16-digit HEX string so the
>> buffer needs to be at least 17 characters to hold the NUL terminator.
>>
> Which comment?

In internal documentation of the eeprom layout I think.

>
>> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 9f729a648005..187e3dae3965 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1019,7 +1019,7 @@ struct amdgpu_device {
>>   	bool                            psp_sysfs_en;
>>   
>>   	/* Chip product information */
>> -	char				product_number[16];
>> +	char				product_number[20];
> If 17 is enough, why setting as 20?

That's the next multiple of 4 and so avoids alignment issues.


Christian.

>
>>   	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
>>   	char				serial[20];
>>   


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047A8C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 01:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC8110E056;
	Wed,  9 Aug 2023 01:36:47 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3FA10E21F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 23:51:25 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a78a2c0f81so2687546b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Aug 2023 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691538685; x=1692143485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8BP2Tfc3vy3cwSRBFZ2e1oFmyYaIxvroBai/slP3GKA=;
 b=oy4I54MZ8ganu/0JKBY0LhQhTIqQOeeid+0JTq4zCkX0T27cFCqd/n4zCKlu3pq7ea
 0U9rGCU/g9TPOnKVjbZe89IDLSOEx5GyFjBJ1EYeYnGvEIKZpyWw3JFKL+oN9cz9QV2/
 iabpsWWxbLifd0OQd4FLOxgd6brB2u1Y203xUBdEX0B2NrGfHWS3B8ZhgtZAj3eXEOgB
 sChHtX1rafSBpfl+fW10B03dZCHnz1Ty71FK9HBwsNbaHPnQtMi4Fe7BK5RB/5q6iatP
 ZdUKkcREk/vdmE48o1jiLxpBalmolahXNaeaJCnWWgoHs+jiXKtKI+o3itnmvuKakC9S
 zqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691538685; x=1692143485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8BP2Tfc3vy3cwSRBFZ2e1oFmyYaIxvroBai/slP3GKA=;
 b=D+kHHGbflLPgvEgM+ZjwBTMm3exfI5hwVAjBnfk8aj3Gb6M9joPeUCqsNWhDqCgQig
 UOkZ1z4TBUWrV7bLBJ3dYgKOXRnWcbejxeazUKUhlfk2ST0qNKjQkUQSrOj6IiCX4FHu
 c4Pbj60HP9FjlnrXMHVBW3qh4SBfXn8nES5qD+iZJk4Y4RRV80PmV2qcLL5Jal87bm9k
 KC6QHtnHdBKvqGDpSAAicr5tRwoc9btJz/ge7z2L+1jemk2PqXll+OHbMeDUJrYttsYp
 7qhb93bA4T3W/cauabg0HnrFB3ySjazw8Xbd22P4I4KI7V90hyV51Q9znPy2AQvB3+fA
 LHqg==
X-Gm-Message-State: AOJu0YxEvFC8ssmKrXBqXfGW0Imd19Eg2aE0Q7Gyb0BPsLM9DBqPqYGv
 rrMLaQu2RMPr0NpzEEKXf3Q=
X-Google-Smtp-Source: AGHT+IE/gWTYeRXx8tnVq3xxFY5cMVtu8CcfVrP6BfYlMpgvl6xRQ6q/cxMFeSH0+1LZm+eEux/Qyg==
X-Received: by 2002:a54:4582:0:b0:3a7:1cca:f99f with SMTP id
 z2-20020a544582000000b003a71ccaf99fmr1263858oib.34.1691538684989; 
 Tue, 08 Aug 2023 16:51:24 -0700 (PDT)
Received: from ?IPV6:2601:204:df00:9cd0::c121? ([2601:204:df00:9cd0::c121])
 by smtp.gmail.com with ESMTPSA id
 ju22-20020a170903429600b001bb9b5e86b7sm9573153plb.91.2023.08.08.16.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 16:51:24 -0700 (PDT)
Message-ID: <93e3d058-96c3-4ff7-afd5-d6701cdc349b@gmail.com>
Date: Tue, 8 Aug 2023 16:51:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amdkfd: Use memdup_user() rather than duplicating its
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>
References: <20230808205752.23704-1-rauji.raut@gmail.com>
 <8370cf91-66b5-d96b-fed8-a38eb488a011@amd.com>
From: Atul Raut <rauji.raut@gmail.com>
In-Reply-To: <8370cf91-66b5-d96b-fed8-a38eb488a011@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Aug 2023 01:36:45 +0000
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
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Felix,

I appreciate the code review.
Will correct the  typo (seems to have appeared during patch creation 
following compilation).
Shortly as the compilation is successful, V2 will be sent.

-Atul

On 8/8/23 15:47, Felix Kuehling wrote:
> On 2023-08-08 16:57, Atul Raut wrote:
>> To prevent its redundant implementation and streamline
>> code, use memdup_user.
>>
>> This fixes warnings reported by Coccinelle:
>> ./drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:2811:13-20: 
>> WARNING opportunity for memdup_user
>>
>> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 2df153828ff4..51740e007e89 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -2808,12 +2808,9 @@ static uint32_t *get_queue_ids(uint32_t 
>> num_queues, uint32_t *usr_queue_id_array
>>       if (!usr_queue_id_array)
>>           return NULL;
>>   -    queue_ids = kzalloc(array_size, GFP_KERNEL);
>> -    if (!queue_ids)
>> -        return ERR_PTR(-ENOMEM);
>> -
>> -    if (copy_from_user(queue_ids, usr_queue_id_array, array_size))
>> -        return ERR_PTR(-EFAULT);
>> +    queue_ids = memdup_user(usr_queue_id_array, array_size);
>> +    if (IS_ERR(Iqueue_ids))
>
> You have a typo in the variable name here. Did you at least 
> compile-test the patch?
>
>
>> +        return ERR_PTR(queue_ids);
>
> I think it should just return queue_ids here. That's already an 
> ERR_PTR in case of errors. So you don't even need the "if". Just this 
> should do the job:
>
>     return memdup_user(usr_queue_id_array, array_size);
>
> The error checking is done by the caller.
>
> Regards,
>   Felix
>
>
>>         return queue_ids;
>>   }

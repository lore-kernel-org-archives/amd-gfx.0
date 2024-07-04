Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B66DC30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 14:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A2F110EB1C;
	Thu,  4 Jul 2024 14:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="DSEbDojF";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="MOv9AUzx";
	dkim-atps=neutral
Received: from bunu.damsy.net (bunu.damsy.net [51.159.160.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3568D10EB1D
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202404r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1720102756;
 bh=eqDX+lMZnWlGAorFHzZPvq3
 w69gfYgwmJUTH46oESdw=; b=DSEbDojF2Iiag+2MEKw6gGM0p242vBkRz1+w+cXl629xn+h0GY
 LvfzCR5P935XLz2/m54Gg+pOnlMBzBfNqnjuJog6geSpd9bBCyOCY19BT/Ib1TCbJdc081oe3j/
 PuX9V/eCEAMy6BU2WNTCfj0NBqnoQEP4SwffOY5CpA3R/Mxa7HDqdNopgeI0lyr/AXmkOu0P0c2
 A6ooRV1g0LKXBs0weIjF6TVXLPy5HL/mIDqhIJDKp935atLUwhFQurYIHOalTOFxpnO4zAkwujG
 SQVH4G3DuzhrNvtaoGBi2RHvMWzKM/ArTLg9uRKNz/awNJ+YHxWWGm9ZqJcBIZee3Iw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202404e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1720102756; bh=eqDX+lMZnWlGAorFHzZPvq3
 w69gfYgwmJUTH46oESdw=; b=MOv9AUzxxBNP1guBEIKXpxa2dd6lveyjkR0b17cOdiO9sRLFyx
 obdLCcn3yPqfMvpZbgmfeAtKBwDdIPs+jmAw==;
Message-ID: <d0641524-c300-4020-82be-9903b422efd6@damsy.net>
Date: Thu, 4 Jul 2024 16:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disallow multiple BO_HANDLES chunks in one
 submit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240702132357.327220-1-pierre-eric.pelloux-prayer@amd.com>
 <636b7a69-f6e4-41b3-886b-1dbe92d15479@amd.com>
 <f014af20-9d7b-4276-8e06-eb48329d2f16@damsy.net>
 <5a63063e-a3c3-4ce5-ac7b-95aafd7dffce@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <5a63063e-a3c3-4ce5-ac7b-95aafd7dffce@amd.com>
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



Le 03/07/2024 à 16:10, Christian König a écrit :
> Am 03.07.24 um 14:48 schrieb Pierre-Eric Pelloux-Prayer:
>> Le 02/07/2024 à 15:35, Christian König a écrit :
>>> Am 02.07.24 um 15:23 schrieb Pierre-Eric Pelloux-Prayer:
>>>> Before this commit, only submits with both a BO_HANDLES chunk and a
>>>> 'bo_list_handle' would be rejected (by amdgpu_cs_parser_bos).
>>>>
>>>> But if UMD sent a multiple BO_HANDLES, what would happen is:
>>>> * only the last one would be really used
>>>> * all the others would leak memory as amdgpu_cs_p1_bo_handles would
>>>>    overwrite the previous p->bo_list value
>>>>
>>>> This commit rejects submissions with multiple BO_HANDLES chunks to
>>>> match the implementation of the parser.
>>>>
>>>> Signed-off-by: Pierre-Eric Pelloux-Prayer 
>>>> <pierre-eric.pelloux-prayer@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index c08dfffae262..69d168d6f35a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -154,6 +154,10 @@ static int amdgpu_cs_p1_bo_handles(struct 
>>>> amdgpu_cs_parser *p,
>>>>       struct drm_amdgpu_bo_list_entry *info;
>>>>       int r;
>>>> +    /* Disallow multiple BO_HANDLES chunks. */
>>>
>>> Describe why you do something, instead of what you do since that 
>>> should be obvious from the code.
>>>
>>> E.g. something like /* Only allow a single BO list to avoid memory 
>>> leak. */
>>
>> It's not really to avoid a memleak because the code below could be fixed
>> to not leak the list.
>> This change is really about only disallowing multiple BO_HANDLES since 
>> this is the de-facto API, except it was not validated until now.
>>
>> I can rephrase the comment as /* Only a single BO list is allowed. */
>>
>> Would that work?
> 
> Mhm, we still need to give a reason why only a single BO list is allowed.
> 
> Maybe "Only a single BO list is allowed to simplify handling".

Works for me. I'll push a version with this comment instead of the 
original one.

Thanks!
Pierre-Eric


> 
> I don't really see a use case for having more than one BO list, but who 
> knows.
> 
> Regards,
> Christian.
> 
>>
>> Thanks,
>> Pierre-Eric
>>
>>>
>>> With that fixed Reviewed-by: Christian König <christian.koenig@amd.com>
>>>
>>> Regards,
>>> Christian.
>>>
>>>
>>>> +    if (p->bo_list)
>>>> +        return -EINVAL;
>>>> +
>>>>       r = amdgpu_bo_create_list_entry_array(data, &info);
>>>>       if (r)
>>>>           return r;

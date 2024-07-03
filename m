Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A21C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 12:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C665610E7DE;
	Wed,  3 Jul 2024 12:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="sCL+ILEm";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="deleqAzp";
	dkim-atps=neutral
Received: from bunu.damsy.net (bunu.damsy.net [51.159.160.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D47C10E7DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 12:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202404r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1720010904;
 bh=uDCZKIE5nI8F7WoxzH3TfBC
 5jQYP6Bp7PFOr/anHxtg=; b=sCL+ILEm0689XgNhwW3PIK+SaATHFZ+sHqkbrMmEY3ssEnIGOK
 fKBpKzOJgZ1ChgyUwG0ML3YwRvRwcoBuJOcvzgxDA9o9I3yIxiY8YbJkEYZm5+Ntbo47raW/Rr/
 OVnvn6Jm14GO+F8SJBNEsGOomEkq3Xe6rA1WflHLekkZDDLMk35Hc+GwXll/7a05M84UcXX/Y+q
 EZjzZTQ6TZZCI2GeGb+Wz/8tPANazGFdyMwA0hsm1BuUEacn9C+VvZUuNqr8dSMFbveZ8XsHvlN
 upbup1gr7tYYyRN/nWpov+fNb02LMW7Q20pyy4Cz8BG3m5T+Ooxh1H7gF1yESGp85bQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202404e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1720010904; bh=uDCZKIE5nI8F7WoxzH3TfBC
 5jQYP6Bp7PFOr/anHxtg=; b=deleqAzpKkmMgOdPl7OciNrI8FFRDOlqik5FdkEQ0sfwNdpZ77
 YH4zgljZp8/sI/KFVX3aMnKs52Imez9JtCBw==;
Message-ID: <f014af20-9d7b-4276-8e06-eb48329d2f16@damsy.net>
Date: Wed, 3 Jul 2024 14:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disallow multiple BO_HANDLES chunks in one
 submit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240702132357.327220-1-pierre-eric.pelloux-prayer@amd.com>
 <636b7a69-f6e4-41b3-886b-1dbe92d15479@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <636b7a69-f6e4-41b3-886b-1dbe92d15479@amd.com>
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



Le 02/07/2024 à 15:35, Christian König a écrit :
> Am 02.07.24 um 15:23 schrieb Pierre-Eric Pelloux-Prayer:
>> Before this commit, only submits with both a BO_HANDLES chunk and a
>> 'bo_list_handle' would be rejected (by amdgpu_cs_parser_bos).
>>
>> But if UMD sent a multiple BO_HANDLES, what would happen is:
>> * only the last one would be really used
>> * all the others would leak memory as amdgpu_cs_p1_bo_handles would
>>    overwrite the previous p->bo_list value
>>
>> This commit rejects submissions with multiple BO_HANDLES chunks to
>> match the implementation of the parser.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer 
>> <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index c08dfffae262..69d168d6f35a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -154,6 +154,10 @@ static int amdgpu_cs_p1_bo_handles(struct 
>> amdgpu_cs_parser *p,
>>       struct drm_amdgpu_bo_list_entry *info;
>>       int r;
>> +    /* Disallow multiple BO_HANDLES chunks. */
> 
> Describe why you do something, instead of what you do since that should 
> be obvious from the code.
> 
> E.g. something like /* Only allow a single BO list to avoid memory leak. */

It's not really to avoid a memleak because the code below could be fixed
to not leak the list.
This change is really about only disallowing multiple BO_HANDLES since 
this is the de-facto API, except it was not validated until now.

I can rephrase the comment as /* Only a single BO list is allowed. */

Would that work?

Thanks,
Pierre-Eric

> 
> With that fixed Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Regards,
> Christian.
> 
> 
>> +    if (p->bo_list)
>> +        return -EINVAL;
>> +
>>       r = amdgpu_bo_create_list_entry_array(data, &info);
>>       if (r)
>>           return r;

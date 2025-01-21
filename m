Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E7BC0218B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 16:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 655E810E60A;
	Tue, 21 Jan 2025 16:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I0KhVxc4";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3154810E60A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 16:52:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8CF4BA417F0;
 Tue, 21 Jan 2025 16:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D30C4CEE0;
 Tue, 21 Jan 2025 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737478326;
 bh=Lv3gHE/XC9EtwiKwYTVLpwL+F321/nHYz5MM+M11Sdk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=I0KhVxc4MojWnqeaJaLsMUAd9EHzvwWrbWRyTKmMb5hcgc4iG+iKDi10lGMbIHnOR
 ygdUhyiSRsoNuF0GZCw4nCtdHeagQ2tiUSc7Ezql+kNX0CQDfIswDmSiKsEWDyAQb0
 5xd9yC5iV4PIuEuFN5NZa5rXWnOjvuMEoiN9OfyQ2zZ7VsfUXqhrAWkG5yZ0BnYvQh
 iiQ+R52JKXzslxkLORW1u8LWGA199T/k530/Z5WJddIDJLKc9xeF5fP1uEzVdpe9QO
 yRKRu8pnFWfQcNBphUFXAa26Okg2HNXvHWW1W62VikzO2paCkerGCrGtO9yeqEB33c
 NeTVjUGVcS6MQ==
Message-ID: <f5c084d6-0b27-4cc0-abd1-e0c1b9829615@kernel.org>
Date: Tue, 21 Jan 2025 10:52:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/display: Adjust plane init for off by one
 error
To: Harry Wentland <harry.wentland@amd.com>, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, Luke Jones <luke@ljones.dev>
References: <20250121135719.2883833-1-superm1@kernel.org>
 <20250121135719.2883833-2-superm1@kernel.org>
 <3143e415-a792-43cd-a76c-328c2089044b@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <3143e415-a792-43cd-a76c-328c2089044b@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/21/25 10:32, Harry Wentland wrote:
> 
> 
> On 2025-01-21 08:57, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The number of active surfaces is initialized to the number
>> of active planes.  If the number of planes aren't initialized
>> properly then the last plane can end up not getting initialized
>> which can be a divide by zero error.
>>
>> Reported-and-tested-by: Luke Jones <luke@ljones.dev>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3794
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3533
>> Fixes: 7966f319c66d9 ("drm/amd/display: Introduce DML2")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
>> index 8dabb1ac0b684..45147b812d7d9 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
>> @@ -6787,7 +6787,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
>>   		}
>>   	}
>>   
>> -	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
>> +	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
> 
> Shouldn't this be either
> 	k <= num_active_planes -1
> or
> 	k < num_active_planes
> ?
> 
> Is num_active_planes wrong somehow?

Oh I see your point, that /should/ be the right value then for this 
particular loop and the rest of the corrections don't make sense either.

I'm not sure where the issue actually is then.

> 
> Harry
> 
>>   		CalculateBytePerPixelAndBlockSizes(
>>   								mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k],
>>   								mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k],
> 


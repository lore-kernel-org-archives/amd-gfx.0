Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CC9C36011
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 16:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F8F410E09D;
	Fri, 28 Mar 2025 16:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PtrMFcX9";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 355D110E09D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 16:18:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 61D72A40A08;
 Fri, 28 Mar 2025 16:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00F0C4CEE4;
 Fri, 28 Mar 2025 16:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743178706;
 bh=L2QGY73g/nQW5Dh/jwUQbJIdhNL2YH9yDgF8bxBbLts=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PtrMFcX9dEHO46KBLXj9P7sI99NgiCY1zpmEutXGnOsHzBRuHO3/Dg4cjKnpID6pB
 JN0JbzNIQ/xDSdoTSrAK/Hq1/koWFBj1X7lIU1YlCtSqT7x8viyZZxda/KtrA1rPMW
 8wGy3S9NS5HpEXOnQ6Oi+48lOb3rjU0xcMV495SVLorw+O233Z7sUAC8WOgMwDhTKZ
 WC++ecbqT4wIFQVJM8BJ0BmouwZXa8j3TEuJClia9HWnEmxxnpqXjq6gD++0mETNC8
 RguXU8z23j39ykdY0ySfNJkOJu2Cs5fg5gcc6d5GTg7tS6WbRdxLZaxHtWb0AJvcX2
 VKVzStRkt6azw==
Message-ID: <e3f1d166-e313-4b50-9642-712a02dbade1@kernel.org>
Date: Fri, 28 Mar 2025 11:18:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] drm/amd: Avoid showing an error about memory
 allocation in amdgpu_acpi_enumerate_xcc()
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20250327203858.3796086-1-superm1@kernel.org>
 <20250327203858.3796086-3-superm1@kernel.org>
 <6147f825-536c-4e4f-8b5a-afdc97120946@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <6147f825-536c-4e4f-8b5a-afdc97120946@amd.com>
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

On 3/27/2025 23:05, Lazar, Lijo wrote:
> 
> 
> On 3/28/2025 2:08 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> checkpatch.pl complains about unnecessary error messages for failing
>> to allocate memory. These aren't needed when the return code is -ENOMEM.
> 
> It's not about the error code. It conveys till what stage driver
> proceeded and when the failure happened. I do see other instances in
> kernel which do give an error message with -ENOMEM.
> 

OK Thanks.  I will change this to an ACPI handle message then (roll it 
into patch 1).


> Thanks,
> Lijo
> 
>> Drop such a message from amdgpu_acpi_enumerate_xcc().
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> index 1c5994de5a723..840901d65fed7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1116,10 +1116,8 @@ static int amdgpu_acpi_enumerate_xcc(void)
>>   
>>   		xcc_info = kzalloc(sizeof(struct amdgpu_acpi_xcc_info),
>>   				   GFP_KERNEL);
>> -		if (!xcc_info) {
>> -			DRM_ERROR("Failed to allocate memory for xcc info\n");
>> +		if (!xcc_info)
>>   			return -ENOMEM;
>> -		}
>>   
>>   		INIT_LIST_HEAD(&xcc_info->list);
>>   		xcc_info->handle = acpi_device_handle(acpi_dev);
> 


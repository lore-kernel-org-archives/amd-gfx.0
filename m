From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] drm/amdgpu_gem: fix error handling path in
 amdgpu_gem_va_update_vm
Date: Thu, 15 Feb 2018 10:11:40 -0600
Message-ID: <fcd63cde-c593-32d5-5b7a-0ffd0a602bb3@embeddedor.com>
References: <20180215052000.GA25691@embeddedgus>
 <b3638ffe-b29f-b30b-4a2c-ccc50f7562b0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b3638ffe-b29f-b30b-4a2c-ccc50f7562b0@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: christian.koenig@amd.com, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org



On 02/15/2018 06:32 AM, Christian König wrote:
> Am 15.02.2018 um 06:20 schrieb Gustavo A. R. Silva:
>> Currently, if amdgpu_vm_bo_update() fails, the returned error
>> is being ignored.
>>
>> Fix this by properly checking _r_ after calling amdgpu_vm_bo_update.
>> Also, remove redundant code just before label _error_.
>>
>> Addresses-Coverity-ID: 1464280 ("Unused value")
>> Fixes: 0abc6878fc2d ("drm/amdgpu: update VM PDs after the PTs")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 

Thanks, Christian
--
Gustavo

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index e48b4ec..db85fc0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -523,12 +523,13 @@ static void amdgpu_gem_va_update_vm(struct 
>> amdgpu_device *adev,
>>           goto error;
>>       if (operation == AMDGPU_VA_OP_MAP ||
>> -        operation == AMDGPU_VA_OP_REPLACE)
>> +        operation == AMDGPU_VA_OP_REPLACE) {
>>           r = amdgpu_vm_bo_update(adev, bo_va, false);
>> +        if (r)
>> +            goto error;
>> +    }
>>       r = amdgpu_vm_update_directories(adev, vm);
>> -    if (r)
>> -        goto error;
>>   error:
>>       if (r && r != -ERESTARTSYS)
> 

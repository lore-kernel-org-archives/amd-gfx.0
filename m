From: "Zhang, Jerry (Junwei)" <Jerry.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Reserve fence slots for command submission
Date: Wed, 4 Jul 2018 14:55:55 +0800
Message-ID: <5B3C6F7B.80901@amd.com>
References: <1530673358-20219-1-git-send-email-Jerry.Zhang@amd.com> <e6385817-e437-e5de-0297-a6af16648a2c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <e6385817-e437-e5de-0297-a6af16648a2c@gmail.com>
Sender: stable-owner@vger.kernel.org
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Cc: michel.daenzer@amd.com, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On 07/04/2018 02:34 PM, Christian König wrote:
> Am 04.07.2018 um 05:02 schrieb Junwei Zhang:
>> From: Michel Dänzer <michel.daenzer@amd.com>
>>
>> Without this, there could not be enough slots, which could trigger the
>> BUG_ON in reservation_object_add_shared_fence.
>>
>> v2:
>> * Jump to the error label instead of returning directly (Jerry Zhang)
>> v3:
>> * Reserve slots for command submission after VM updates (Christian König)
>>
>> Cc: stable@vger.kernel.org
>> Bugzilla: https://bugs.freedesktop.org/106418
>> Reported-by: mikhail.v.gavrilov@gmail.com
>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>> Signed-off-by: Junwei Zhang <Jerry.Zhang@amd.com>
>
> I would put that at the end of amdgpu_bo_vm_update_pte(), but that is only a minor nit pick.

At first, I really put it at the end of amdgpu_bo_vm_update_pte().
On the 2nd thought, that func may be called by others(although it's not for now),
so I move it out of there to the caller.

Jerry

>
> Patch is Reviewed-by: Christian König <christian.koenig@amd.com> anyway.
>
> Regards,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 7a625f3..1bc0281 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -928,6 +928,10 @@ static int amdgpu_cs_ib_vm_chunk(struct amdgpu_device *adev,
>>           r = amdgpu_bo_vm_update_pte(p);
>>           if (r)
>>               return r;
>> +
>> +        r = reservation_object_reserve_shared(vm->root.base.bo->tbo.resv);
>> +        if (r)
>> +            return r;
>>       }
>>       return amdgpu_cs_sync_rings(p);
>

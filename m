From: maowenan <maowenan@huawei.com>
Subject: Re: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
Date: Sat, 22 Jun 2019 21:56:00 +0800
Message-ID: <063c9726-8f16-f9b7-2d16-bc87a99085bb@huawei.com>
References: <20190622104318.GT28859@kadam>
 <20190622130527.182022-1-maowenan@huawei.com>
 <alpine.DEB.2.21.1906221504110.3253@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1906221504110.3253@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, dan.carpenter@oracle.com, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org



On 2019/6/22 21:06, Julia Lawall wrote:
> 
> 
> On Sat, 22 Jun 2019, Mao Wenan wrote:
> 
>> There is one warning:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>   int ret = 0;
>>       ^
>> amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
>> which will use the return value. So it returns 'ret' for caller.
>> amdgpu_device_init()
>> 	r = amdgpu_pmu_init(adev);
>>
>> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
>>  amdgpu_pmu_init().
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> index 0e6dba9..145e720 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>>  	case CHIP_VEGA20:
>>  		/* init df */
>>  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
>> -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>> -				       DF_V3_6_MAX_COUNTERS);
>> +							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>> +							   DF_V3_6_MAX_COUNTERS);
>>
>>  		/* other pmu types go here*/
> 
> I don't know what is the impact of the other pmu types that are planned
> for the future.  Perhaps it would be better to abort the function
> immediately in the case of a failure.

I guess it would be better to use new function or new switch case clause to process different PMU types
in future.

> 
> julia
> 
>>  		break;
>> @@ -261,7 +261,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>>  		return 0;
>>  	}
>>
>> -	return 0;
>> +	return ret;
>>  }
>>
>>
>> --
>> 2.7.4
>>
>>
> 

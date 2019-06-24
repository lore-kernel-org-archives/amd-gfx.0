From: maowenan <maowenan@huawei.com>
Subject: Re: [PATCH -next v3] drm/amdgpu: return 'ret' immediately if failed
 in amdgpu_pmu_init
Date: Mon, 24 Jun 2019 17:29:33 +0800
Message-ID: <4795ba5c-8e41-e1e0-c96a-47fdda3995e3@huawei.com>
References: <alpine.DEB.2.21.1906230809400.4961@hadrien>
 <20190624034532.135201-1-maowenan@huawei.com> <20190624083952.GO18776@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624083952.GO18776@kadam>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, julia.lawall@lip6.fr, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, jonathan.kim@amd.com, Joe Perches <joe@perches.com>
List-Id: amd-gfx.lists.freedesktop.org



On 2019/6/24 16:39, Dan Carpenter wrote:
> On Mon, Jun 24, 2019 at 11:45:32AM +0800, Mao Wenan wrote:
>> There is one warning:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>   int ret = 0;
>>       ^
>> amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
>> which will use the return value. So it should return 'ret' immediately if init_pmu_by_type() failed.
>> amdgpu_device_init()
>> 	r = amdgpu_pmu_init(adev);
>>
>> This patch is also to update the indenting on the arguments so they line up with the '('.
>>
>> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
>>  amdgpu_pmu_init().
>>  v2->v3: change the subject for this patch; return 'ret' immediately if failed to call init_pmu_by_type(). 
>>
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> index 0e6dba9..b702322 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> @@ -252,8 +252,11 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>>  	case CHIP_VEGA20:
>>  		/* init df */
>>  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
>> -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>> -				       DF_V3_6_MAX_COUNTERS);
>> +							   "DF", "amdgpu_df",
>> +							   PERF_TYPE_AMDGPU_DF,
>> +							   DF_V3_6_MAX_COUNTERS);
>> +		if (ret)
>> +			return ret;
> 
> No no.  Sorry, the original indenting was correct and lined up with the
> '(' character in 'init_pmu_by_type(', that's the way it should be.  If
> we were to remove the "ret = " then we'd have to pull the arguments back
> as well.  I think this fix that Julia suggested is really the right so
> leave the indenting alone.
> 

> It looks like you've right aligned the arguments.  That's not the right
> way, the original was correct.
> 
After using 8 character for tab(thanks to Joe), the aligned here is wrong, yes, the original was correct.

so my v4 is only to change ret, don't change the indenting?

> regards,
> dan carpenter
> 
> 
> .
> 

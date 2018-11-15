From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable 'ring'
Date: Thu, 15 Nov 2018 19:56:31 +0800
Message-ID: <6e67a5b3-6a0e-6c3a-af90-2125713f522f@huawei.com>
References: <1542279133-103893-1-git-send-email-yuehaibing@huawei.com>
 <BY2PR12MB0040A0E1C221A3EBBF270C30ECDC0@BY2PR12MB0040.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BY2PR12MB0040A0E1C221A3EBBF270C30ECDC0@BY2PR12MB0040.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Huang, Ray" <Ray.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Francis, David" <David.Francis@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org


On 2018/11/15 19:49, Huang, Ray wrote:
>> -----Original Message-----
>> From: YueHaibing [mailto:yuehaibing@huawei.com]
>> Sent: Thursday, November 15, 2018 6:52 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
>> <David1.Zhou@amd.com>; airlied@linux.ie; Liu, Shaoyun
>> <Shaoyun.Liu@amd.com>; Francis, David <David.Francis@amd.com>; Huang,
>> Ray <Ray.Huang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Gao, Likun
>> <Likun.Gao@amd.com>
>> Cc: YueHaibing <yuehaibing@huawei.com>; amd-gfx@lists.freedesktop.org;
>> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; kernel-
>> janitors@vger.kernel.org
>> Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'ring'
>>
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: In function
>> 'psp_v10_0_ring_stop':
>> drivers/gpu/drm/amd/amdgpu/psp_v10_0.c:230:19: warning:
>>  variable 'ring' set but not used [-Wunused-but-set-variable]
>>
>> It not used since commit
>> 4ef72453311a ("drm/amdgpu: added api for stopping psp ring (v2)")
> 
> Thanks, please also remove the similar code in psp_v3_1. 
> With that updates, patch is Reviewed-by: Huang Rui <ray.huang@amd.com>
> 

Ok, will send v2.

>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>> index 295c220..d78b430 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>> @@ -240,12 +240,9 @@ static int psp_v10_0_ring_stop(struct psp_context
>> *psp,
>>  			       enum psp_ring_type ring_type)  {
>>  	int ret = 0;
>> -	struct psp_ring *ring;
>>  	unsigned int psp_ring_reg = 0;
>>  	struct amdgpu_device *adev = psp->adev;
>>
>> -	ring = &psp->km_ring;
>> -
>>  	/* Write the ring destroy command to C2PMSG_64 */
>>  	psp_ring_reg = 3 << 16;
>>  	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
>>
>>
>>
>>
> 
> 
> .
> 

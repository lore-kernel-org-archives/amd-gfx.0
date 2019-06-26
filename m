From: maowenan <maowenan@huawei.com>
Subject: Re: [PATCH -next v4] drm/amdgpu: return 'ret' immediately if failed
 in amdgpu_pmu_init
Date: Wed, 26 Jun 2019 19:35:40 +0800
Message-ID: <2d7c2525-4503-3706-7d00-0b9bf230266d@huawei.com>
References: <20190624094850.GQ18776@kadam>
 <20190624112318.149299-1-maowenan@huawei.com>
 <CH2PR12MB3831BE36FF61D74FC529F64F85E00@CH2PR12MB3831.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CH2PR12MB3831BE36FF61D74FC529F64F85E00@CH2PR12MB3831.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org



On 2019/6/25 1:42, Kim, Jonathan wrote:
> Immediate return should be ok since perf registration isn't dependent on gpu hw.
> 
> Reviewed-by: Jonathan Kim <Jonathan.Kim@amd.com>

thanks for review.

> 
> -----Original Message-----
> From: Mao Wenan <maowenan@huawei.com> 
> Sent: Monday, June 24, 2019 7:23 AM
> To: airlied@linux.ie; daniel@ffwll.ch; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; dan.carpenter@oracle.com; julia.lawall@lip6.fr
> Cc: kernel-janitors@vger.kernel.org; amd-gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org; Kim, Jonathan <Jonathan.Kim@amd.com>; Mao Wenan <maowenan@huawei.com>
> Subject: [PATCH -next v4] drm/amdgpu: return 'ret' immediately if failed in amdgpu_pmu_init
> 
> [CAUTION: External Email]
> 
> There is one warning:
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>   int ret = 0;
>       ^
> amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
> which will use the return value. So it should return 'ret' immediately if init_pmu_by_type() failed.
> amdgpu_device_init()
>         r = amdgpu_pmu_init(adev);
> 
> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in  amdgpu_pmu_init().
>  v2->v3: change the subject for this patch; return 'ret' immediately if failed to call init_pmu_by_type().
>  v3->v4: delete the indenting for init_pmu_by_type() arguments. The original indenting is correct.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 0e6dba9f60f0..c98cf77a37f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -254,6 +254,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>                 ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
>                                        "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>                                        DF_V3_6_MAX_COUNTERS);
> +               if (ret)
> +                       return ret;
> 
>                 /* other pmu types go here*/
>                 break;
> --
> 2.20.1
> 

From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variables 'ret'
Date: Sat, 22 Jun 2019 13:43:19 +0300
Message-ID: <20190622104318.GT28859@kadam>
References: <20190622030314.169640-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190622030314.169640-1-maowenan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mao Wenan <maowenan@huawei.com>
Cc: airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Sat, Jun 22, 2019 at 11:03:14AM +0800, Mao Wenan wrote:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 0e6dba9..0bf4dd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -246,12 +246,10 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
>  /* init amdgpu_pmu */
>  int amdgpu_pmu_init(struct amdgpu_device *adev)
>  {
> -	int ret = 0;
> -
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA20:
>  		/* init df */
> -		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> +		init_pmu_by_type(adev, df_v3_6_attr_groups,
>  				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>  				       DF_V3_6_MAX_COUNTERS);


You're resending this for other reasons, but don't forget to update the
indenting on the arguments so they still line up with the '('.

regards,
dan carpenter

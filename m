From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variables
 'ret'
Date: Sat, 22 Jun 2019 08:02:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906220801210.3253@hadrien>
References: <20190622030314.169640-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-406165930-1561183337=:3253"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190622030314.169640-1-maowenan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mao Wenan <maowenan@huawei.com>
Cc: airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-406165930-1561183337=:3253
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 22 Jun 2019, Mao Wenan wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>   int ret = 0;
>       ^
>
> It is never used since introduction in 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
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

Maybe it would be better to use ret?

If knowing whether the call has failed is really useless, then maybe the
return type should be void?

julia


>
> --
> 2.7.4
>
>
--8323329-406165930-1561183337=:3253--

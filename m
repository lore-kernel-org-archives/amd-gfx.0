From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
Date: Sun, 23 Jun 2019 20:46:55 -0700
Message-ID: <f7af76e8237f490f75d9f2624127e01c55476d2f.camel@perches.com>
References: <20190622104318.GT28859@kadam>
         <20190622130527.182022-1-maowenan@huawei.com>
         <0ab82cdb0bec30e7e431f106f8e0e9d141491555.camel@perches.com>
         <b468d765-bef7-70a8-9a14-bad0e6ed14df@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b468d765-bef7-70a8-9a14-bad0e6ed14df@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: maowenan <maowenan@huawei.com>, airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, dan.carpenter@oracle.com, julia.lawall@lip6.fr
Cc: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jonathan Kim <jonathan.kim@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, 2019-06-24 at 11:41 +0800, maowenan wrote:
> 
> On 2019/6/23 2:13, Joe Perches wrote:
> > On Sat, 2019-06-22 at 21:05 +0800, Mao Wenan wrote:
> > > There is one warning:
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> > >   int ret = 0;
> > []
> > >  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
> > >  amdgpu_pmu_init().
> > []
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > []
> > > @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
> > >  	case CHIP_VEGA20:
> > >  		/* init df */
> > >  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> > > -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> > > -				       DF_V3_6_MAX_COUNTERS);
> > > +							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> > > +							   DF_V3_6_MAX_COUNTERS);
> > 
> > trivia:
> > 
> > The indentation change seems superfluous and
> > appears to make the code harder to read.
> > 
> > You could also cc Jonathan Kim who wrote all of this.
> I think this is just display issue in mail format. It is correct that in vi/vim.
> The arguments are line up with '(' after my change.

Use 8 character tabs and try again please.

> @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)$
>  ^Icase CHIP_VEGA20:$
>  ^I^I/* init df */$
>  ^I^Iret = init_pmu_by_type(adev, df_v3_6_attr_groups,$
> -^I^I^I^I       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,$
> -^I^I^I^I       DF_V3_6_MAX_COUNTERS);$
> +^I^I^I^I^I^I^I   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,$
> +^I^I^I^I^I^I^I   DF_V3_6_MAX_COUNTERS);$

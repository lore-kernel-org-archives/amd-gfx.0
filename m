From: Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: make undeclared variables static
Date: Fri, 25 Oct 2019 06:37:58 +0300
Message-ID: <20191025033758.GA3201@wambui>
References: <20191019072426.20535-1-wambui@karuga.xyz>
 <0f3fa30e-0392-054b-a81e-b9cb4475fe07@amd.com>
Reply-To: 0f3fa30e-0392-054b-a81e-b9cb4475fe07@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0f3fa30e-0392-054b-a81e-b9cb4475fe07@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <hwentlan@amd.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, outreachy-kernel@googlegroups.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 23, 2019 at 03:09:34PM +0000, Harry Wentland wrote:
> On 2019-10-19 3:24 a.m., Wambui Karuga wrote:
> > Make the `amdgpu_lockup_timeout` and `amdgpu_exp_hw_support` variables
> > static to remove the following sparse warnings:
> > drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:103:19: warning: symbol 'amdgpu_lockup_timeout' was not declared. Should it be static?
> 
> This should be declared in amdgpu.h. amdgpu is maintained on the
> amd-staging-drm-next branch from
> https://cgit.freedesktop.org/~agd5f/linux/?h=amd-staging-drm-next. Can
> you check there?
> 
Hey Harry,
I checked the amd-staging-drm-next branch, and 'amdgpu_lockup_timeout'
is already declared as extern in amdgpu.h, so sparse only warns about
'amdgpu_exp_hw_support'. 
I'll do the same for 'amdgpu_exp_hw_support' and send an update patch
series for this and the "_LENTH" mispelling.

Thanks,
wambui karuga
> > drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:117:18: warning: symbol 'amdgpu_exp_hw_support' was not declared. Should it be static?
> > 
> > Signed-off-by: Wambui Karuga <wambui@karuga.xyz>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 3fae1007143e..c5b3c0c9193b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -100,7 +100,7 @@ int amdgpu_disp_priority = 0;
> >  int amdgpu_hw_i2c = 0;
> >  int amdgpu_pcie_gen2 = -1;
> >  int amdgpu_msi = -1;
> > -char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
> > +static char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
> >  int amdgpu_dpm = -1;
> >  int amdgpu_fw_load_type = -1;
> >  int amdgpu_aspm = -1;
> > @@ -114,7 +114,7 @@ int amdgpu_vm_block_size = -1;
> >  int amdgpu_vm_fault_stop = 0;
> >  int amdgpu_vm_debug = 0;
> >  int amdgpu_vm_update_mode = -1;
> > -int amdgpu_exp_hw_support = 0;
> > +static int amdgpu_exp_hw_support;
> 
> This is indeed only used in this file but for consistency's sake it's
> probably better to also declare it in amdgpu.h rather than make it
> static here.
> 
> Harry
> 
> >  int amdgpu_dc = -1;
> >  int amdgpu_sched_jobs = 32;
> >  int amdgpu_sched_hw_submission = 2;
> > 

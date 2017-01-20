From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: amdgpu: Corrupted video on 32 bit systems (possible fix)
Date: Fri, 20 Jan 2017 11:47:53 +0900
Message-ID: <40da3f7e-6634-7588-36b5-f03378faee26@daenzer.net>
References: <20170119193537.GA3296@teela.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170119193537.GA3296@teela.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
To: Nils Holland <nholland@tisys.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On 20/01/17 04:35 AM, Nils Holland wrote:
> Hi folks,
> 
> there seems to be an issue on 32 bit kernels which makes graphics
> output look all messed up under X when using the amdgpu drm kernel
> driver.
> 
> In fact, the same issue was present at some time in 2015 using the
> radeon driver too, but it has been fixed a long time ago, as can be
> seen here:
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=84627#c35
> 
> Now, I reported the same issue in conjunction with the amdgpu driver
> back when I first noticed it back then. Nothing has happened since
> then, but my bug report can still be found here:
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=91831
> 
> Personally, I had been using the (working) radeon driver again, and
> only today I decided to check if the issue in amdgpu still exists. And
> yes, it seems so: I still get garbled output when using a current
> kernel with a current version of the amdgpu driver.
> 
> Now, I've tried to just "port"  the fix that had been done to the radeon
> driver in 2015 (see the first link above) to the amdgpu driver and created
> myself the following little patch:
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c	2016-12-11 20:17:54.000000000 +0100
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c	2017-01-19 15:38:56.972034489 +0100
> @@ -372,6 +372,10 @@
>  	if (!drm_arch_can_wc_memory())
>  		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>  
> +	#ifdef CONFIG_X86_32
> +		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +	#endif
> +
>  	amdgpu_fill_placement_to_bo(bo, placement);
>  	/* Kernel allocation are uninterruptible */
>  	r = ttm_bo_init(&adev->mman.bdev, &bo->tbo, size, type,

The corresponding code in the radeon driver has changed quite a bit
since this original fix. It would be better to bring the amdgpu code in
line with the current radeon code.


> With this patch, the amdgpu driver works fine for me on my 32 bit
> kernel: All graphics output looks the way it's supposed to, even with
> full acceleration enabled - great!
> 
> I'd suggest that it might be a good idea to put to apply the above
> patch or something similar to the official sources.

Indeed. Do you want to create a proper patch and submit it to the
amd-gfx mailing list for review? See Documentation/SubmittingPatches for
more information.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

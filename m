From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Disable RPM helpers while reprobing
 connectors on resume
Date: Wed, 27 Jul 2016 16:31:46 -0400
Message-ID: <CADnq5_PVAAoLH3RMPNKJ4tWWYLd+YOJ+NnxK98hE20=YU67Y1g@mail.gmail.com>
References: <1468856499-19246-1-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1468856499-19246-1-git-send-email-cpaul@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Lyude <cpaul@redhat.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "for 3.8" <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Chunming Zhou <David1.Zhou@amd.com>, Jammy Zhou <Jammy.Zhou@amd.com>, Monk Liu <Monk.Liu@amd.com>, Flora Cui <Flora.Cui@amd.com>, Tom St Denis <tom.stdenis@amd.com>, "open list:RADEON and AMDGPU DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jul 18, 2016 at 11:41 AM, Lyude <cpaul@redhat.com> wrote:
> Just about all of amdgpu's connector probing functions try to acquire
> runtime PM refs. If we try to do this in the context of
> amdgpu_resume_kms by calling drm_helper_hpd_irq_event(), we end up
> deadlocking the system.
>
> Since we're guaranteed to be holding the spinlock for RPM in
> amdgpu_resume_kms, and we already know the GPU is in working order, we
> need to prevent the RPM helpers from trying to run during the initial
> connector reprobe on resume.
>
> There's a couple of solutions I've explored for fixing this, but this
> one by far seems to be the simplest and most reliable (plus I'm pretty
> sure that's what disable_depth is there for anyway).
>
> Reproduction recipe:
>   - Get any laptop dual GPUs using PRIME
>   - Make sure runtime PM is enabled for amdgpu
>   - Boot the machine
>   - If the machine managed to boot without hanging, switch out of X to
>     another VT. This should definitely cause X to hang infinitely.
>
> Changes since v1:
>   - add appropriate #ifdef checks for CONFIG_PM. This is not very
>     useful, but it appears some kernel test suites test compiling amdgpu
>     with CONFIG_PM disabled, which results in this patch breaking the builds
>     if we don't include this #ifdef
>
> Cc: stable@vger.kernel.org
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Signed-off-by: Lyude <cpaul@redhat.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6e92008..b7f5650 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1841,7 +1841,23 @@ int amdgpu_resume_kms(struct drm_device *dev, bool resume, bool fbcon)
>         }
>
>         drm_kms_helper_poll_enable(dev);
> +
> +       /*
> +        * Most of the connector probing functions try to acquire runtime pm
> +        * refs to ensure that the GPU is powered on when connector polling is
> +        * performed. Since we're calling this from a runtime PM callback,
> +        * trying to acquire rpm refs will cause us to deadlock.
> +        *
> +        * Since we're guaranteed to be holding the rpm lock, it's safe to
> +        * temporarily disable the rpm helpers so this doesn't deadlock us.
> +        */
> +#ifdef CONFIG_PM
> +       dev->dev->power.disable_depth++;
> +#endif
>         drm_helper_hpd_irq_event(dev);
> +#ifdef CONFIG_PM
> +       dev->dev->power.disable_depth--;
> +#endif
>
>         if (fbcon) {
>                 amdgpu_fbdev_set_suspend(adev, 0);
> --
> 2.7.4
>

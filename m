From: mikhail.v.gavrilov@gmail.com
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
Date: Fri, 30 Aug 2019 03:03:58 +0500
Message-ID: <a07be36905f145f2fb07beee73f9d3805c285022.camel@gmail.com>
References: <20190825141305.13984-1-hdanton@sina.com>
         <20190826092408.GA2112@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826092408.GA2112@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>, Hillf Danton <hdanton@sina.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Sun, Aug 25, 2019 at 10:13:05PM +0800, Hillf Danton wrote:
> Can we try to add the fallback timer manually?
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -322,6 +322,10 @@ int amdgpu_fence_wait_empty(struct amdgp
>         }
>         rcu_read_unlock();
>  
> +       if (!timer_pending(&ring->fence_drv.fallback_timer))
> +               mod_timer(&ring->fence_drv.fallback_timer,
> +                       jiffies + (AMDGPU_FENCE_JIFFIES_TIMEOUT <<
> 1));
> +
>         r = dma_fence_wait(fence, false);
>         dma_fence_put(fence);
>         return r;
> --
> 
> Or simply wait with an ear on signal and timeout if adding timer
> seems to go a bit too far?
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -322,7 +322,12 @@ int amdgpu_fence_wait_empty(struct amdgp
>         }
>         rcu_read_unlock();
>  
> -       r = dma_fence_wait(fence, false);
> +       if (0 < dma_fence_wait_timeout(fence, true,
> +                               AMDGPU_FENCE_JIFFIES_TIMEOUT +
> +                               (AMDGPU_FENCE_JIFFIES_TIMEOUT >> 3)))
> +               r = 0;
> +       else
> +               r = -EINVAL;
>         dma_fence_put(fence);
>         return r;
>  }

I tested both patches on top of 5.3 RC6. Each patch I was tested more
than 24 hours and I don't seen any regressions or problems with them.


On Mon, 2019-08-26 at 11:24 +0200, Daniel Vetter wrote:
> 
> This will paper over the issue, but won't fix it. dma_fences have to
> complete, at least for normal operations, otherwise your desktop will
> start feeling like the gpu hangs all the time.
> 
> I think would be much more interesting to dump which fence isn't
> completing here in time, i.e. not just the timeout, but lots of debug
> printks.
> -Daniel

As I am understood none of these patches couldn't be merged because
they do not fix the root cause they eliminate only the consequences?
Eliminating consequences has any negative effects? And we will never
know the root cause because not having enough debugging information.

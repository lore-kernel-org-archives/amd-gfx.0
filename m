From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 4/4] drm/amdgpu: Use drm_oom_badness for amdgpu.
Date: Tue, 30 Jan 2018 10:24:13 +0100
Message-ID: <20180130092413.GD25930@phenom.ffwll.local>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <1516294072-17841-5-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1516294072-17841-5-git-send-email-andrey.grodzovsky@amd.com>
Sender: owner-linux-mm@kvack.org
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jan 18, 2018 at 11:47:52AM -0500, Andrey Grodzovsky wrote:
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 46a0c93..6a733cdc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -828,6 +828,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl = amdgpu_kms_compat_ioctl,
>  #endif
> +	.oom_file_badness = drm_oom_badness,

Would be neat if we could roll this out for all gem drivers (once it's no
longer an RFC ofc).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

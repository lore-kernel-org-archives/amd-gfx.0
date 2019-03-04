From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix typing in amdgpu_virt_ops::trans_msg
Date: Mon, 4 Mar 2019 23:54:20 +0100
Message-ID: <20190304225419.7j5iiqrqm7msyvd7@ltop.local>
References: <20190304131000.17994-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190304131000.17994-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>, Monk Liu <Monk.Liu@amd.com>, Emily Deng <Emily.Deng@amd.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Mar 04, 2019 at 02:10:00PM +0100, Luc Van Oostenryck wrote:
> The method in struct amdgpu_virt_ops::trans_msg() is defined as
> using an 'u32' for its 2nd argument (the request) but the actual
> implementation()s and calls use an 'enum idh_request' for it.
> 
> Fix this by using 'enum idh_request' for the method declaration too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 722deefc0a7e..3e9aec6f2795 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -56,7 +56,7 @@ struct amdgpu_virt_ops {
>  	int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
>  	int (*reset_gpu)(struct amdgpu_device *adev);
>  	int (*wait_reset)(struct amdgpu_device *adev);
> -	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1, u32 data2, u32 data3);
> +	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req, u32 data1, u32 data2, u32 data3);
>  };


Sorry, this is patch is incorrect. Please ignore it.

-- Luc

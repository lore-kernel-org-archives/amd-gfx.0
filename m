From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: hide #warning for missing DC config
Date: Fri, 12 Jul 2019 14:01:46 -0400
Message-ID: <CADnq5_McVegix-m87OwHUvk80NdsFZPQ7d0X8qQtUf84h+Fg1A@mail.gmail.com>
References: <20190712094118.1559434-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190712094118.1559434-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jack Xiao <Jack.Xiao@amd.com>, Kevin Wang <kevin1.wang@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Xiaojie Yuan <xiaojie.yuan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Jul 12, 2019 at 5:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> It is annoying to have #warnings that trigger in randconfig
> builds like
>
> drivers/gpu/drm/amd/amdgpu/soc15.c:653:3: error: "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
> drivers/gpu/drm/amd/amdgpu/nv.c:400:3: error: "Enable CONFIG_DRM_AMD_DC for display support on navi."
>
> Remove these and rely on the users to turn these on.

Is there some sort of informational message we could use instead?
Unless you are a server user, most end users want this option enabled.

Alex

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c    | 2 --
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ----
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 9253c03d387a..10ec0e81ee58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -396,8 +396,6 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>  #if defined(CONFIG_DRM_AMD_DC)
>                 else if (amdgpu_device_has_dc_support(adev))
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
> -#else
> -#      warning "Enable CONFIG_DRM_AMD_DC for display support on navi."
>  #endif
>                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 87152d8ef0df..90fb0149fbea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -649,8 +649,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>  #if defined(CONFIG_DRM_AMD_DC)
>                 else if (amdgpu_device_has_dc_support(adev))
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
> -#else
> -#      warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
>  #endif
>                 if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev))) {
>                         amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
> @@ -671,8 +669,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>  #if defined(CONFIG_DRM_AMD_DC)
>                 else if (amdgpu_device_has_dc_support(adev))
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
> -#else
> -#      warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
>  #endif
>                 amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
>                 break;
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable 'adev'
Date: Mon, 28 Oct 2019 13:38:30 -0400
Message-ID: <CADnq5_PPCFLZzMCUxW4Ofd5+A=N5s-iMURrSEj8C6V1NJhS68A@mail.gmail.com>
References: <20191023075831.33636-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191023075831.33636-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, tiancyin <tianci.yin@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 23, 2019 at 4:10 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1221:24: warning: variable adev set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:488:24: warning: variable adev set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:547:24: warning: variable adev set but not used [-Wunused-but-set-variable]
>
> It is never used, so can removed it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index a61b0d9..ba00262 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -485,15 +485,12 @@ static int amdgpu_move_vram_ram(struct ttm_buffer_object *bo, bool evict,
>                                 struct ttm_operation_ctx *ctx,
>                                 struct ttm_mem_reg *new_mem)
>  {
> -       struct amdgpu_device *adev;
>         struct ttm_mem_reg *old_mem = &bo->mem;
>         struct ttm_mem_reg tmp_mem;
>         struct ttm_place placements;
>         struct ttm_placement placement;
>         int r;
>
> -       adev = amdgpu_ttm_adev(bo->bdev);
> -
>         /* create space/pages for new_mem in GTT space */
>         tmp_mem = *new_mem;
>         tmp_mem.mm_node = NULL;
> @@ -544,15 +541,12 @@ static int amdgpu_move_ram_vram(struct ttm_buffer_object *bo, bool evict,
>                                 struct ttm_operation_ctx *ctx,
>                                 struct ttm_mem_reg *new_mem)
>  {
> -       struct amdgpu_device *adev;
>         struct ttm_mem_reg *old_mem = &bo->mem;
>         struct ttm_mem_reg tmp_mem;
>         struct ttm_placement placement;
>         struct ttm_place placements;
>         int r;
>
> -       adev = amdgpu_ttm_adev(bo->bdev);
> -
>         /* make space in GTT for old_mem buffer */
>         tmp_mem = *new_mem;
>         tmp_mem.mm_node = NULL;
> @@ -1218,11 +1212,8 @@ static struct ttm_backend_func amdgpu_backend_func = {
>  static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
>                                            uint32_t page_flags)
>  {
> -       struct amdgpu_device *adev;
>         struct amdgpu_ttm_tt *gtt;
>
> -       adev = amdgpu_ttm_adev(bo->bdev);
> -
>         gtt = kzalloc(sizeof(struct amdgpu_ttm_tt), GFP_KERNEL);
>         if (gtt == NULL) {
>                 return NULL;
> --
> 2.7.4
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

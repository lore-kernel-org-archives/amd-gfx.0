From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v2 07/35] drm/amdgpu: Use kmemdup rather than duplicating
 its implementation
Date: Fri, 5 Jul 2019 16:32:39 -0400
Message-ID: <CADnq5_Pr1=69rwce-bkDA7y-16MgYwCg8z2ghOvDqooMMj3r6A@mail.gmail.com>
References: <20190703162718.32184-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703162718.32184-1-huangfq.daxian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Leo Li <sunpeng.li@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Jul 3, 2019 at 1:13 PM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
>
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>   - Fix a typo in commit message (memset -> memcpy)
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c           | 5 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           | 5 ++---
>  drivers/gpu/drm/amd/display/dc/core/dc.c        | 6 ++----
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 +---
>  4 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 02955e6e9dd9..48e38479d634 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -3925,11 +3925,10 @@ static int gfx_v8_0_init_save_restore_list(struct amdgpu_device *adev)
>
>         int list_size;
>         unsigned int *register_list_format =
> -               kmalloc(adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
> +               kmemdup(adev->gfx.rlc.register_list_format,
> +                       adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
>         if (!register_list_format)
>                 return -ENOMEM;
> -       memcpy(register_list_format, adev->gfx.rlc.register_list_format,
> -                       adev->gfx.rlc.reg_list_format_size_bytes);
>
>         gfx_v8_0_parse_ind_reg_list(register_list_format,
>                                 RLC_FormatDirectRegListLength,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b610e3b30d95..09d901ef216d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2092,11 +2092,10 @@ static int gfx_v9_1_init_rlc_save_restore_list(struct amdgpu_device *adev)
>         u32 tmp = 0;
>
>         u32 *register_list_format =
> -               kmalloc(adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
> +               kmemdup(adev->gfx.rlc.register_list_format,
> +                       adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
>         if (!register_list_format)
>                 return -ENOMEM;
> -       memcpy(register_list_format, adev->gfx.rlc.register_list_format,
> -               adev->gfx.rlc.reg_list_format_size_bytes);
>
>         /* setup unique_indirect_regs array and indirect_start_offsets array */
>         unique_indirect_reg_count = ARRAY_SIZE(unique_indirect_regs);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 18c775a950cc..6ced3b9cdce2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1263,14 +1263,12 @@ struct dc_state *dc_create_state(struct dc *dc)
>  struct dc_state *dc_copy_state(struct dc_state *src_ctx)
>  {
>         int i, j;
> -       struct dc_state *new_ctx = kzalloc(sizeof(struct dc_state),
> -                                          GFP_KERNEL);
> +       struct dc_state *new_ctx = kmemdup(src_ctx,
> +                       sizeof(struct dc_state), GFP_KERNEL);
>
>         if (!new_ctx)
>                 return NULL;
>
> -       memcpy(new_ctx, src_ctx, sizeof(struct dc_state));
> -
>         for (i = 0; i < MAX_PIPES; i++) {
>                         struct pipe_ctx *cur_pipe = &new_ctx->res_ctx.pipe_ctx[i];
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index 96e97d25d639..d4b563a2e220 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -167,12 +167,10 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
>  {
>         struct dc_stream_state *new_stream;
>
> -       new_stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
> +       new_stream = kzalloc(stream, sizeof(struct dc_stream_state), GFP_KERNEL);

This doesn't compile.  I've gone ahead and fixed it up locally and
applied it.  Please check that your patches compile before sending
them out.

Thanks,

Alex

>         if (!new_stream)
>                 return NULL;
>
> -       memcpy(new_stream, stream, sizeof(struct dc_stream_state));
> -
>         if (new_stream->sink)
>                 dc_sink_retain(new_stream->sink);
>
> --
> 2.11.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

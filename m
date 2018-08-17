From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] drm/amd/display: fix a compile warning
Date: Fri, 17 Aug 2018 11:46:18 -0700
Message-ID: <783744d1-29a2-c601-7d1f-b937308d407c@infradead.org>
References: <1534475388-40036-1-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534475388-40036-1-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, airlied@linux.ie
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
List-Id: amd-gfx.lists.freedesktop.org

On 08/16/2018 08:09 PM, Wen Yang wrote:
> Fix comile warning like,
>   CC [M]  drivers/gpu/drm/i915/gvt/execlist.o
>   CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.o
>   CC [M]  drivers/gpu/drm/radeon/btc_dpm.o
>   CC [M]  drivers/isdn/hisax/avm_a1p.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In function ‘dcn10_update_mpcc’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1903:9: warning: missing braces around initializer [-Wmissing-braces]
>   struct mpcc_blnd_cfg blnd_cfg = {0};
>          ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1903:9: warning: (near initialization for ‘blnd_cfg.black_color’) [-Wmissing-braces]
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>

works for me.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index cfcc54f..a06a035 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -1900,7 +1900,7 @@ static void update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state)
>  static void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>  {
>  	struct hubp *hubp = pipe_ctx->plane_res.hubp;
> -	struct mpcc_blnd_cfg blnd_cfg = {0};
> +	struct mpcc_blnd_cfg blnd_cfg = {{0}};
>  	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
>  	int mpcc_id;
>  	struct mpcc *new_mpcc;
> 


-- 
~Randy

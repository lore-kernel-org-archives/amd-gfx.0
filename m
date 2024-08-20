Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE64C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 05:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A4010E4AD;
	Tue, 20 Aug 2024 05:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VSmX4/4j";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F52710E4AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 05:10:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BA3EE601DA;
 Tue, 20 Aug 2024 05:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB67C4AF09;
 Tue, 20 Aug 2024 05:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724130654;
 bh=rIAkkhkrIowK2cYynufgK4ZO+fhS3YzxrC56jQ5CXBw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VSmX4/4jPteIMSfYl3nI2bDLp1kqdoGjtVv++ufhEQzicXC4Tizh7dfYOWYhsymH5
 pv5lKI4r1G0DDfC/gfq4G6DsEdgLRgVo3U5xAP3V4TQew6Yuyae6RBx6tR335VWzn0
 V7TVrTHgXBMATyXMpOzMhfxLB07pS3EDks/pruaD8ta/sEaFPkZce6vB967Gdfd00Q
 430gDRVy+TfR9jnc4I2rBWizhLNzgzPPIliLDhAJOtRmJGL6hsbjKOjb/L7nINbmOd
 2CpMG5YNxmivHFImegXvI4d0FFXKAlKJwCOiCAeB54CEM3UcHdVAttIQXfR/O1FJsI
 ow5EcAOJabhoQ==
Message-ID: <6a3f51ea-13cd-4c1f-a164-f022ea436234@kernel.org>
Date: Tue, 20 Aug 2024 00:10:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: change the panel power savings level
 without a modeset
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sebastian Wick <sebastian@sebastianwick.net>
References: <20240809204253.317856-1-hamza.mahfooz@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20240809204253.317856-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 8/9/24 15:42, Hamza Mahfooz wrote:
> We don't actually need to request that the compositor does a full
> modeset to modify the panel power savings level, we can instead
> just make a request to DMUB, to set the new level dynamically.
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Sebastian Wick <sebastian@sebastianwick.net>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---

Thanks, this will solve the side effects that users of GNOME shell were 
seeing when the attribute was modified.

I tested it on an applicable laptop running 6.11-rc4 and it works 
correctly.  I have one nit below, but feel free to ignore it if you 
don't agree.

Here's some tags:

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Closes: https://gitlab.gnome.org/GNOME/mutter/-/issues/3578

>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 17 +++++++-
>   drivers/gpu/drm/amd/display/dc/core/dc.c      | 39 +++++++++++--------
>   drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
>   3 files changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dd8353283bda..00a8a5959aa9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6819,9 +6819,14 @@ static ssize_t panel_power_savings_store(struct device *device,
>   					 const char *buf, size_t count)
>   {
>   	struct drm_connector *connector = dev_get_drvdata(device);
> +	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(connector);
>   	struct drm_device *dev = connector->dev;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct dc *dc = adev->dm.dc;
> +	struct pipe_ctx *pipe_ctx;
>   	long val;
>   	int ret;
> +	int i;
>   
>   	ret = kstrtol(buf, 0, &val);
>   
> @@ -6836,7 +6841,17 @@ static ssize_t panel_power_savings_store(struct device *device,
>   		ABM_LEVEL_IMMEDIATE_DISABLE;
>   	drm_modeset_unlock(&dev->mode_config.connection_mutex);
>   
> -	drm_kms_helper_hotplug_event(dev);
> +	mutex_lock(&adev->dm.dc_lock);
> +	for (i = 0; i < dc->res_pool->pipe_count; i++) {
> +		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
> +
> +		if (pipe_ctx->stream &&
> +		    pipe_ctx->stream->link == aconn->dc_link) {
> +			dc_set_abm_level(dc, pipe_ctx, val);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&adev->dm.dc_lock);
>   
>   	return count;
>   }
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 3ba2acfdae2a..60081cd978b7 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3319,6 +3319,23 @@ static bool update_planes_and_stream_state(struct dc *dc,
>   
>   }
>   
> +void dc_set_abm_level(struct dc *dc, struct pipe_ctx *pipe_ctx, int level)
> +{
> +	struct timing_generator *tg = pipe_ctx->stream_res.tg;
> +	struct abm *abm = pipe_ctx->stream_res.abm;
> +
> +	if (!abm)
> +		return;

AFAICT this is a programmer error if this was to actually happen.
I'd think a WARN_ON() makes sense here.

> +
> +	if (tg->funcs->is_blanked && !tg->funcs->is_blanked(tg))
> +		tg->funcs->wait_for_state(tg, CRTC_STATE_VBLANK);
> +
> +	if (level == ABM_LEVEL_IMMEDIATE_DISABLE)
> +		dc->hwss.set_abm_immediate_disable(pipe_ctx);
> +	else
> +		abm->funcs->set_abm_level(abm, level);
> +}
> +
>   static void commit_planes_do_stream_update(struct dc *dc,
>   		struct dc_stream_state *stream,
>   		struct dc_stream_update *stream_update,
> @@ -3447,22 +3464,12 @@ static void commit_planes_do_stream_update(struct dc *dc,
>   				dc->link_srv->set_dpms_on(dc->current_state, pipe_ctx);
>   			}
>   
> -			if (stream_update->abm_level && pipe_ctx->stream_res.abm) {
> -				bool should_program_abm = true;
> -
> -				// if otg funcs defined check if blanked before programming
> -				if (pipe_ctx->stream_res.tg->funcs->is_blanked)
> -					if (pipe_ctx->stream_res.tg->funcs->is_blanked(pipe_ctx->stream_res.tg))
> -						should_program_abm = false;
> -
> -				if (should_program_abm) {
> -					if (*stream_update->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE) {
> -						dc->hwss.set_abm_immediate_disable(pipe_ctx);
> -					} else {
> -						pipe_ctx->stream_res.abm->funcs->set_abm_level(
> -							pipe_ctx->stream_res.abm, stream->abm_level);
> -					}
> -				}
> +			if (stream_update->abm_level) {
> +				dc_set_abm_level(dc, pipe_ctx,
> +						 *stream_update->abm_level ==
> +						 ABM_LEVEL_IMMEDIATE_DISABLE ?
> +						 ABM_LEVEL_IMMEDIATE_DISABLE :
> +						 stream->abm_level);
>   			}
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 7873daf72608..134ef00d9668 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2494,6 +2494,8 @@ void dc_z10_save_init(struct dc *dc);
>   bool dc_is_dmub_outbox_supported(struct dc *dc);
>   bool dc_enable_dmub_notifications(struct dc *dc);
>   
> +void dc_set_abm_level(struct dc *dc, struct pipe_ctx *pipe_ctx, int level);
> +
>   bool dc_abm_save_restore(
>   		struct dc *dc,
>   		struct dc_stream_state *stream,


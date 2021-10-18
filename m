Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AE4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941BB6108E
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 941BB6108E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6A56EAAD;
	Mon, 18 Oct 2021 23:25:16 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF2E6EAAD
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:25:15 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae8cf.dynamic.kabel-deutschland.de
 [95.90.232.207])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A0C1761E5FE33;
 Tue, 19 Oct 2021 01:25:13 +0200 (CEST)
Subject: Re: [PATCH 27/27] Revert "drm/amd/display: Add helper for blanking
 all dp displays"
To: amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, qingqing.zhuo@amd.com,
 mikita.lipski@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 wayne.lin@amd.com, stylon.wang@amd.com, solomon.chiu@amd.com,
 pavle.kotarac@amd.com, Hanghong Ma <hanghong.ma@amd.com>,
 Mark Broadworth <mark.broadworth@amd.com>,
 Agustin Gutierrez <agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
 <20211015184332.221091-28-agustin.gutierrez@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <63e53597-e77c-f891-ba40-78d7a3fa2a15@molgen.mpg.de>
Date: Tue, 19 Oct 2021 01:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211015184332.221091-28-agustin.gutierrez@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Dear Augustin,


Am 15.10.21 um 20:43 schrieb Agustin Gutierrez:
> This reverts commit 50ac5b14c74c5706796cb6378f25a2121dba5b2d.
> 
> This patch introduced a couple of dmesg warnings,

Please give one example warning for people searching through the git 
history.

> this is not a valid approach anymore.

Nit: Please make it it’s own sentence.

> For this reason, we are reverting this patch, and we need to revert
> the workaround patch.
What is the workaround patch?


Kind regards,

Paul

> Cc: Hanghong Ma <hanghong.ma@amd.com>
> Cc: Mark Broadworth <mark.broadworth@amd.com>
> Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 45 -------------------
>   drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 -
>   .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++++++++--
>   .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 41 +++++++++++++++--
>   .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 39 ++++++++++++++--
>   .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 40 +++++++++++++++--
>   6 files changed, 131 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index c01309a1cbf2..e5d6cbd7ea78 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1988,51 +1988,6 @@ static enum dc_status enable_link_dp_mst(
>   	return enable_link_dp(state, pipe_ctx);
>   }
>   
> -void blank_all_dp_displays(struct dc *dc, bool hw_init)
> -{
> -	unsigned int i, j, fe;
> -	uint8_t dpcd_power_state = '\0';
> -	enum dc_status status = DC_ERROR_UNEXPECTED;
> -
> -	for (i = 0; i < dc->link_count; i++) {
> -		enum signal_type signal = dc->links[i]->connector_signal;
> -
> -		if ((signal == SIGNAL_TYPE_EDP) ||
> -			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
> -			if (hw_init && signal != SIGNAL_TYPE_EDP) {
> -				/* DP 2.0 spec requires that we read LTTPR caps first */
> -				dp_retrieve_lttpr_cap(dc->links[i]);
> -				/* if any of the displays are lit up turn them off */
> -				status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
> -							&dpcd_power_state, sizeof(dpcd_power_state));
> -			}
> -
> -			if ((signal != SIGNAL_TYPE_EDP && status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) ||
> -					(!hw_init && dc->links[i]->link_enc &&
> -					dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc))) {
> -				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
> -					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
> -					if (fe == ENGINE_ID_UNKNOWN)
> -						continue;
> -
> -					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
> -						if (fe == dc->res_pool->stream_enc[j]->id) {
> -							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
> -									dc->res_pool->stream_enc[j]);
> -							break;
> -						}
> -					}
> -				}
> -
> -				if (!dc->links[i]->wa_flags.dp_keep_receiver_powered ||
> -					(hw_init && signal != SIGNAL_TYPE_EDP))
> -					dp_receiver_power_ctrl(dc->links[i], false);
> -			}
> -		}
> -	}
> -
> -}
> -
>   static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
>   		enum engine_id eng_id,
>   		struct ext_hdmi_settings *settings)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
> index 69b008bafbbc..a73d64b1fd33 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -277,7 +277,6 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
>   		struct psr_context *psr_context);
>   
>   void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
> -void blank_all_dp_displays(struct dc *dc, bool hw_init);
>   
>   /* Request DC to detect if there is a Panel connected.
>    * boot - If this call is during initial boot.
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 8108f9ae2638..af3e68d3e747 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1649,13 +1649,31 @@ static enum dc_status apply_single_controller_ctx_to_hw(
>   
>   static void power_down_encoders(struct dc *dc)
>   {
> -	int i;
> -
> -	blank_all_dp_displays(dc, false);
> +	int i, j;
>   
>   	for (i = 0; i < dc->link_count; i++) {
>   		enum signal_type signal = dc->links[i]->connector_signal;
>   
> +		if ((signal == SIGNAL_TYPE_EDP) ||
> +			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
> +			if (dc->links[i]->link_enc->funcs->get_dig_frontend &&
> +				dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc)) {
> +				unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
> +									dc->links[i]->link_enc);
> +
> +				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
> +					if (fe == dc->res_pool->stream_enc[j]->id) {
> +						dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
> +									dc->res_pool->stream_enc[j]);
> +						break;
> +					}
> +				}
> +			}
> +
> +			if (!dc->links[i]->wa_flags.dp_keep_receiver_powered)
> +				dp_receiver_power_ctrl(dc->links[i], false);
> +		}
> +
>   		if (signal != SIGNAL_TYPE_EDP)
>   			signal = SIGNAL_TYPE_NONE;
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index aa2d430f2a1a..44d27579d898 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -1366,7 +1366,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
>   
>   void dcn10_init_hw(struct dc *dc)
>   {
> -	int i;
> +	int i, j;
>   	struct abm *abm = dc->res_pool->abm;
>   	struct dmcu *dmcu = dc->res_pool->dmcu;
>   	struct dce_hwseq *hws = dc->hwseq;
> @@ -1462,8 +1462,43 @@ void dcn10_init_hw(struct dc *dc)
>   		dmub_enable_outbox_notification(dc);
>   
>   	/* we want to turn off all dp displays before doing detection */
> -	if (dc->config.power_down_display_on_boot)
> -		blank_all_dp_displays(dc, true);
> +	if (dc->config.power_down_display_on_boot) {
> +		uint8_t dpcd_power_state = '\0';
> +		enum dc_status status = DC_ERROR_UNEXPECTED;
> +
> +		for (i = 0; i < dc->link_count; i++) {
> +			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
> +				continue;
> +
> +			/* DP 2.0 requires that LTTPR Caps be read first */
> +			dp_retrieve_lttpr_cap(dc->links[i]);
> +
> +			/*
> +			 * If any of the displays are lit up turn them off.
> +			 * The reason is that some MST hubs cannot be turned off
> +			 * completely until we tell them to do so.
> +			 * If not turned off, then displays connected to MST hub
> +			 * won't light up.
> +			 */
> +			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
> +							&dpcd_power_state, sizeof(dpcd_power_state));
> +			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
> +				/* blank dp stream before power off receiver*/
> +				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
> +					unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
> +
> +					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
> +						if (fe == dc->res_pool->stream_enc[j]->id) {
> +							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
> +										dc->res_pool->stream_enc[j]);
> +							break;
> +						}
> +					}
> +				}
> +				dp_receiver_power_ctrl(dc->links[i], false);
> +			}
> +		}
> +	}
>   
>   	/* If taking control over from VBIOS, we may want to optimize our first
>   	 * mode set, so we need to skip powering down pipes until we know which
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index 2936a334cd64..df2717116604 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -437,7 +437,7 @@ void dcn30_init_hw(struct dc *dc)
>   	struct dce_hwseq *hws = dc->hwseq;
>   	struct dc_bios *dcb = dc->ctx->dc_bios;
>   	struct resource_pool *res_pool = dc->res_pool;
> -	int i;
> +	int i, j;
>   	int edp_num;
>   	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
>   
> @@ -534,8 +534,41 @@ void dcn30_init_hw(struct dc *dc)
>   			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
>   
>   	/* we want to turn off all dp displays before doing detection */
> -	if (dc->config.power_down_display_on_boot)
> -		blank_all_dp_displays(dc, true);
> +	if (dc->config.power_down_display_on_boot) {
> +		uint8_t dpcd_power_state = '\0';
> +		enum dc_status status = DC_ERROR_UNEXPECTED;
> +
> +		for (i = 0; i < dc->link_count; i++) {
> +			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
> +				continue;
> +			/* DP 2.0 states that LTTPR regs must be read first */
> +			dp_retrieve_lttpr_cap(dc->links[i]);
> +
> +			/* if any of the displays are lit up turn them off */
> +			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
> +						     &dpcd_power_state, sizeof(dpcd_power_state));
> +			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
> +				/* blank dp stream before power off receiver*/
> +				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
> +					unsigned int fe;
> +
> +					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
> +										dc->links[i]->link_enc);
> +					if (fe == ENGINE_ID_UNKNOWN)
> +						continue;
> +
> +					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
> +						if (fe == dc->res_pool->stream_enc[j]->id) {
> +							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
> +										dc->res_pool->stream_enc[j]);
> +							break;
> +						}
> +					}
> +				}
> +				dp_receiver_power_ctrl(dc->links[i], false);
> +			}
> +		}
> +	}
>   
>   	/* If taking control over from VBIOS, we may want to optimize our first
>   	 * mode set, so we need to skip powering down pipes until we know which
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> index 186d08aec812..7308c4c744ba 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> @@ -72,7 +72,8 @@ void dcn31_init_hw(struct dc *dc)
>   	struct dc_bios *dcb = dc->ctx->dc_bios;
>   	struct resource_pool *res_pool = dc->res_pool;
>   	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
> -	int i;
> +	int i, j;
> +	int edp_num;
>   
>   	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
>   		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
> @@ -190,9 +191,40 @@ void dcn31_init_hw(struct dc *dc)
>   		dmub_enable_outbox_notification(dc);
>   
>   	/* we want to turn off all dp displays before doing detection */
> -	if (dc->config.power_down_display_on_boot)
> -		blank_all_dp_displays(dc, true);
> -
> +	if (dc->config.power_down_display_on_boot) {
> +		uint8_t dpcd_power_state = '\0';
> +		enum dc_status status = DC_ERROR_UNEXPECTED;
> +
> +		for (i = 0; i < dc->link_count; i++) {
> +			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
> +				continue;
> +
> +			/* if any of the displays are lit up turn them off */
> +			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
> +						     &dpcd_power_state, sizeof(dpcd_power_state));
> +			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
> +				/* blank dp stream before power off receiver*/
> +				if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY &&
> +						dc->links[i]->link_enc->funcs->get_dig_frontend) {
> +					unsigned int fe;
> +
> +					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
> +										dc->links[i]->link_enc);
> +					if (fe == ENGINE_ID_UNKNOWN)
> +						continue;
> +
> +					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
> +						if (fe == dc->res_pool->stream_enc[j]->id) {
> +							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
> +										dc->res_pool->stream_enc[j]);
> +							break;
> +						}
> +					}
> +				}
> +				dp_receiver_power_ctrl(dc->links[i], false);
> +			}
> +		}
> +	}
>   
>   	/* If taking control over from VBIOS, we may want to optimize our first
>   	 * mode set, so we need to skip powering down pipes until we know which
> 

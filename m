Return-Path: <SRS0=9dkd=HU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B58C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 22:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D43E64EB4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 22:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D43E64EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C8D89DB4;
	Thu, 18 Feb 2021 22:32:01 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6300B88E66
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Feb 2021 22:32:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C22E64D73;
 Thu, 18 Feb 2021 22:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613687520;
 bh=hFBycN0q8ae37lIznDyHqFHNPTIl94q9jms93GliOCk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ErsaiAPnfDApMQtDVsAIaSFxm73fATtriDfDrDiBMes9ohdV+xl5VkNPvZ8UgixqQ
 9lt+yMVe7f+EhUklnwjK9P8QOn3i4bpUnUquDDPsW9www7C3EO9PrVoG2EwaPGwj9o
 gpblqVUkhpQx0AcP3VCABp7RNgoKLUMWRsm0kMYxpicMXSzP33t6P3Cqp79PAapjab
 sbQDpBnK3Z2w+aFkbJUk4Hht/YuRIOvT8YAZFJFOWKLaNw77Jw0O5zh3eNmFpG7vAd
 TFxedIr/bSW6cBCrc76p5A3blHr5ufDaHwqpiox1joQLfze/O10s1FLoLwMJ9iH7hv
 BAcmtvbWrFbig==
Date: Thu, 18 Feb 2021 15:31:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
Subject: Re: [PATCH 09/14] drm/amd/display: Add Freesync HDMI support to DM
Message-ID: <20210218223158.GA52356@24bbad8f3778>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
 <20210211214444.8348-10-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210211214444.8348-10-qingqing.zhuo@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Harry.Wentland@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 11, 2021 at 04:44:39PM -0500, Qingqing Zhuo wrote:
> From: Stylon Wang <stylon.wang@amd.com>
> 
> [Why]
> Add necessary support for Freesync HDMI in Linux DM
> 
> [How]
> - Support Freesync HDMI by calling DC interace
> - Report Freesync capability to vrr_range debugfs from DRM
> - Depends on coming DMCU/DMUB firmware to enable feature
> 
> Signed-off-by: Stylon Wang <stylon.wang@amd.com>
> Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 175 ++++++++++++++----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 +
>  2 files changed, 144 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 626a8cc92d65..c55ee0a24c26 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -34,6 +34,7 @@
>  #include "dc/inc/hw/dmcu.h"
>  #include "dc/inc/hw/abm.h"
>  #include "dc/dc_dmub_srv.h"
> +#include "dc/dc_edid_parser.h"
>  #include "amdgpu_dm_trace.h"
>  
>  #include "vid.h"
> @@ -6995,6 +6996,12 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
>  		 */
>  		drm_mode_sort(&connector->probed_modes);
>  		amdgpu_dm_get_native_mode(connector);
> +
> +		/* Freesync capabilities are reset by calling
> +		 * drm_add_edid_modes() and need to be
> +		 * restored here.
> +		 */
> +		amdgpu_dm_update_freesync_caps(connector, edid);
>  	} else {
>  		amdgpu_dm_connector->num_modes = 0;
>  	}
> @@ -9718,11 +9725,84 @@ static bool is_dp_capable_without_timing_msa(struct dc *dc,
>  
>  	return capable;
>  }
> +
> +static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
> +		uint8_t *edid_ext, int len,
> +		struct amdgpu_hdmi_vsdb_info *vsdb_info)
> +{
> +	int i;
> +	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
> +	struct dc *dc = adev->dm.dc;
> +
> +	/* send extension block to DMCU for parsing */
> +	for (i = 0; i < len; i += 8) {
> +		bool res;
> +		int offset;
> +
> +		/* send 8 bytes a time */
> +		if (!dc_edid_parser_send_cea(dc, i, len, &edid_ext[i], 8))
> +			return false;
> +
> +		if (i+8 == len) {
> +			/* EDID block sent completed, expect result */
> +			int version, min_rate, max_rate;
> +
> +			res = dc_edid_parser_recv_amd_vsdb(dc, &version, &min_rate, &max_rate);
> +			if (res) {
> +				/* amd vsdb found */
> +				vsdb_info->freesync_supported = 1;
> +				vsdb_info->amd_vsdb_version = version;
> +				vsdb_info->min_refresh_rate_hz = min_rate;
> +				vsdb_info->max_refresh_rate_hz = max_rate;
> +				return true;
> +			}
> +			/* not amd vsdb */
> +			return false;
> +		}
> +
> +		/* check for ack*/
> +		res = dc_edid_parser_recv_cea_ack(dc, &offset);
> +		if (!res)
> +			return false;
> +	}
> +
> +	return false;
> +}
> +
> +static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> +		struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
> +{
> +	uint8_t *edid_ext = NULL;
> +	int i;
> +	bool valid_vsdb_found = false;
> +
> +	/*----- drm_find_cea_extension() -----*/
> +	/* No EDID or EDID extensions */
> +	if (edid == NULL || edid->extensions == 0)
> +		return false;
> +
> +	/* Find CEA extension */
> +	for (i = 0; i < edid->extensions; i++) {
> +		edid_ext = (uint8_t *)edid + EDID_LENGTH * (i + 1);
> +		if (edid_ext[0] == CEA_EXT)
> +			break;
> +	}
> +
> +	if (i == edid->extensions)
> +		return false;
> +
> +	/*----- cea_db_offsets() -----*/
> +	if (edid_ext[0] != CEA_EXT)
> +		return false;
> +
> +	valid_vsdb_found = parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, vsdb_info);
> +	return valid_vsdb_found;
> +}
> +
>  void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  					struct edid *edid)
>  {
>  	int i;
> -	bool edid_check_required;
>  	struct detailed_timing *timing;
>  	struct detailed_non_pixel *data;
>  	struct detailed_data_monitor_range *range;
> @@ -9733,6 +9813,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  	struct drm_device *dev = connector->dev;
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	bool freesync_capable = false;
> +	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
> +	bool hdmi_valid_vsdb_found = false;
>  
>  	if (!connector->state) {
>  		DRM_ERROR("%s - Connector has no state", __func__);
> @@ -9751,60 +9833,75 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  
>  	dm_con_state = to_dm_connector_state(connector->state);
>  
> -	edid_check_required = false;
>  	if (!amdgpu_dm_connector->dc_sink) {
>  		DRM_ERROR("dc_sink NULL, could not add free_sync module.\n");
>  		goto update;
>  	}
>  	if (!adev->dm.freesync_module)
>  		goto update;
> -	/*
> -	 * if edid non zero restrict freesync only for dp and edp
> -	 */
> -	if (edid) {
> -		if (amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
> -			|| amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP) {
> +
> +
> +	if (amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
> +		|| amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP) {
> +		bool edid_check_required = false;
> +
> +		if (edid) {
>  			edid_check_required = is_dp_capable_without_timing_msa(
>  						adev->dm.dc,
>  						amdgpu_dm_connector);
>  		}
> -	}
> -	if (edid_check_required == true && (edid->version > 1 ||
> -	   (edid->version == 1 && edid->revision > 1))) {
> -		for (i = 0; i < 4; i++) {
>  
> -			timing	= &edid->detailed_timings[i];
> -			data	= &timing->data.other_data;
> -			range	= &data->data.range;
> -			/*
> -			 * Check if monitor has continuous frequency mode
> -			 */
> -			if (data->type != EDID_DETAIL_MONITOR_RANGE)
> -				continue;
> -			/*
> -			 * Check for flag range limits only. If flag == 1 then
> -			 * no additional timing information provided.
> -			 * Default GTF, GTF Secondary curve and CVT are not
> -			 * supported
> -			 */
> -			if (range->flags != 1)
> -				continue;
> +		if (edid_check_required == true && (edid->version > 1 ||
> +		   (edid->version == 1 && edid->revision > 1))) {
> +			for (i = 0; i < 4; i++) {
> +
> +				timing	= &edid->detailed_timings[i];
> +				data	= &timing->data.other_data;
> +				range	= &data->data.range;
> +				/*
> +				 * Check if monitor has continuous frequency mode
> +				 */
> +				if (data->type != EDID_DETAIL_MONITOR_RANGE)
> +					continue;
> +				/*
> +				 * Check for flag range limits only. If flag == 1 then
> +				 * no additional timing information provided.
> +				 * Default GTF, GTF Secondary curve and CVT are not
> +				 * supported
> +				 */
> +				if (range->flags != 1)
> +					continue;
>  
> -			amdgpu_dm_connector->min_vfreq = range->min_vfreq;
> -			amdgpu_dm_connector->max_vfreq = range->max_vfreq;
> -			amdgpu_dm_connector->pixel_clock_mhz =
> -				range->pixel_clock_mhz * 10;
> +				amdgpu_dm_connector->min_vfreq = range->min_vfreq;
> +				amdgpu_dm_connector->max_vfreq = range->max_vfreq;
> +				amdgpu_dm_connector->pixel_clock_mhz =
> +					range->pixel_clock_mhz * 10;
>  
> -			connector->display_info.monitor_range.min_vfreq = range->min_vfreq;
> -			connector->display_info.monitor_range.max_vfreq = range->max_vfreq;
> +				connector->display_info.monitor_range.min_vfreq = range->min_vfreq;
> +				connector->display_info.monitor_range.max_vfreq = range->max_vfreq;
>  
> -			break;
> -		}
> +				break;
> +			}
>  
> -		if (amdgpu_dm_connector->max_vfreq -
> -		    amdgpu_dm_connector->min_vfreq > 10) {
> +			if (amdgpu_dm_connector->max_vfreq -
> +			    amdgpu_dm_connector->min_vfreq > 10) {
>  
> -			freesync_capable = true;
> +				freesync_capable = true;
> +			}
> +		}
> +	} else if (edid && amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> +		hdmi_valid_vsdb_found = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> +		if (hdmi_valid_vsdb_found && vsdb_info.freesync_supported) {
> +			timing  = &edid->detailed_timings[i];


This variable is uninitialized, as reported by clang:

$ make -skj"$(nproc)" CC=clang allyesconfig drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.o
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9811:38: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
                        timing  = &edid->detailed_timings[i];
                                                          ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9721:7: note: initialize the variable 'i' to silence this warning
        int i;
             ^
              = 0
1 warning generated.

Cheers,
Nathan

> +			data    = &timing->data.other_data;
> +
> +			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
> +			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
> +			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
> +				freesync_capable = true;
> +
> +			connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
> +			connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
>  		}
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 38bc0f88b29c..5f9950fd216c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -475,6 +475,14 @@ struct dm_connector_state {
>  	uint64_t pbn;
>  };
>  
> +struct amdgpu_hdmi_vsdb_info {
> +	unsigned int amd_vsdb_version;		/* VSDB version, should be used to determine which VSIF to send */
> +	bool freesync_supported;		/* FreeSync Supported */
> +	unsigned int min_refresh_rate_hz;	/* FreeSync Minimum Refresh Rate in Hz */
> +	unsigned int max_refresh_rate_hz;	/* FreeSync Maximum Refresh Rate in Hz */
> +};
> +
> +
>  #define to_dm_connector_state(x)\
>  	container_of((x), struct dm_connector_state, base)
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

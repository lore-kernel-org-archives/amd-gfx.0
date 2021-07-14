Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B833C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 17:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE58C613AB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 17:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE58C613AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841246E43B;
	Wed, 14 Jul 2021 17:49:08 +0000 (UTC)
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484AC6E43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 17:49:06 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 8F306C8007F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 19:49:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id HDNM5Q-Ur3hF for <amd-gfx@lists.freedesktop.org>;
 Wed, 14 Jul 2021 19:49:04 +0200 (CEST)
Received: from [IPv6:2003:e3:7f13:3500:839f:11f6:c93a:c68b]
 (p200300E37F133500839f11f6c93ac68b.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f13:3500:839f:11f6:c93a:c68b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPSA id 5712BC8007D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 19:49:04 +0200 (CEST)
Subject: Re: [PATCH v5 17/17] drm/amd/display: Add handling for new "Broadcast
 RGB" property
To: amd-gfx@lists.freedesktop.org
References: <20210630151018.330354-1-wse@tuxedocomputers.com>
 <20210630151018.330354-18-wse@tuxedocomputers.com>
From: Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <db3fefc8-5148-06bd-9273-065a1639494f@tuxedocomputers.com>
Date: Wed, 14 Jul 2021 19:49:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630151018.330354-18-wse@tuxedocomputers.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 30.06.21 um 17:10 schrieb Werner Sembach:
> This commit implements the "Broadcast RGB" drm property for the AMD GPU
> driver.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 14 +++++++++++---
>   .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  4 ++++
>   2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 02a5809d4993..80d5a11fb0c5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5247,7 +5247,8 @@ get_aspect_ratio(const struct drm_display_mode *mode_in)
>   }
>   
>   static enum dc_color_space
> -get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
> +get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
> +		       enum drm_mode_color_range preferred_color_range)
>   {
>   	enum dc_color_space color_space = COLOR_SPACE_SRGB;
>   
> @@ -5278,7 +5279,10 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
>   	}
>   	break;
>   	case PIXEL_ENCODING_RGB:
> -		color_space = COLOR_SPACE_SRGB;
> +		if (preferred_color_range == DRM_MODE_COLOR_RANGE_LIMITED_16_235)
> +			color_space = COLOR_SPACE_SRGB_LIMITED;
> +		else
> +			color_space = COLOR_SPACE_SRGB;
>   		break;

After some testing I found out, that what I did here, was useless.

amdgpu actually never sets the quantization_range range in the 
hdmi_avi_infoframe and from that I guess any quantization range, besides 
the default one, is not implemented in multiple places.

Until limited RGB is properly implemented in amdgpu there kind of is no 
purpose of generalizing the Broadcast RGB switch.

>   
>   	default:
> @@ -5424,7 +5428,10 @@ static void fill_stream_properties_from_drm_display_mode(
>   
>   	timing_out->aspect_ratio = get_aspect_ratio(mode_in);
>   
> -	stream->output_color_space = get_output_color_space(timing_out);
> +	stream->output_color_space = get_output_color_space(timing_out,
> +							    connector_state ?
> +							    connector_state->preferred_color_range :
> +							    DRM_MODE_COLOR_RANGE_UNSET);
>   
>   	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
>   	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
> @@ -7775,6 +7782,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>   		drm_connector_attach_active_bpc_property(&aconnector->base, 8, 16);
>   		drm_connector_attach_preferred_color_format_property(&aconnector->base);
>   		drm_connector_attach_active_color_format_property(&aconnector->base);
> +		drm_connector_attach_preferred_color_range_property(&aconnector->base);
>   		drm_connector_attach_active_color_range_property(&aconnector->base);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 2563788ba95a..80e1389fd0ec 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -421,6 +421,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
>   	if (connector->active_color_format_property)
>   		drm_connector_attach_active_color_format_property(&aconnector->base);
>   
> +	connector->preferred_color_range_property = master->base.preferred_color_range_property;
> +	if (connector->preferred_color_range_property)
> +		drm_connector_attach_preferred_color_range_property(&aconnector->base);
> +
>   	connector->active_color_range_property = master->base.active_color_range_property;
>   	if (connector->active_color_range_property)
>   		drm_connector_attach_active_color_range_property(&aconnector->base);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

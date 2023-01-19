Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5467CC46467
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 22:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F0C10E270;
	Thu, 19 Jan 2023 22:20:13 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0833910E270
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 22:20:11 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id n7so3243765wrx.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 14:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hWoXuPpGcGHvJfoS8a0d7Jz/G6WEKzX8Q0qSp8JN0rI=;
 b=R18tWXXnxT9R7UbDo0Y30xtTHhOnk/m4PNMQiczh2KaIMBmbv9SB1/xatqGN0pJ8/0
 aZRLNI8fk+2dJ9SgFYeaz5aKY8pd3CCNMawn1lrZq8w2/oHSY3r+e5nXswJltKrOolpo
 rjmbUnV/H8N2C8yCO0W2gOK15wjXx0CFG67ZGKyxBfhNo7ph5mraedbsIcpoMxe8eHD/
 b/++WEnbSh80ByonYVTIACNa0Hxe1V4JDhDJnQ83S5zwFBhBCuFklNdNFOQMy762Hv6S
 fq54EEvLyhSPEER97aAs88CZ7DZw0VpGlen7szRyQXeepkiksJYbWgkeOWjKe0csoYh6
 feFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hWoXuPpGcGHvJfoS8a0d7Jz/G6WEKzX8Q0qSp8JN0rI=;
 b=t5PkX7awAGmDJ1qqk+cqnNJ9AokCQb58XpiJnpppaGo3X8RKRmtW3TMkewhfnlhaLg
 nI0DcMXtqxiDx5AyTt+t70wODTLJu+bJyJJ/LYUJa4qnUGxvxStHULvD0G3yMRX6BWU9
 pT+Rr0Dhvi255i8pJNBnp59TnEqFmFKoZWLooOBsjqQ9kZSBRdnpRGICvNlVuYoFLcxL
 qGQ1AyjGvs+havMwqfKE6C/+RBPODFmF1w8BgyMbf1w60NY4FQl65uLts51hPCU/edxi
 gB/thw25E4LG9250bE6Z4+VR4YxkLjXnNi3mDv1gYUo2khDtPKi175yoKBnhAQoRAMYH
 LYkw==
X-Gm-Message-State: AFqh2krRSZznsDc02OBG6mNuz+6r9sHmCCLKFDrqm6vZHId6zBRBHz9X
 eE2Hp4IZ46BVV45MNz5SurRyWA==
X-Google-Smtp-Source: AMrXdXsoxx/ERUUC5z7Nntnqy/CvuFXBqXhk6uvTH6S9kgjqcC4XliJRCL7UsUdvYZMfpKCBqyd/sw==
X-Received: by 2002:a05:6000:a06:b0:2bc:858a:3df0 with SMTP id
 co6-20020a0560000a0600b002bc858a3df0mr12449869wrb.48.1674166809339; 
 Thu, 19 Jan 2023 14:20:09 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a5d4010000000b002bbed1388a5sm29422449wrp.15.2023.01.19.14.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jan 2023 14:20:09 -0800 (PST)
Message-ID: <bfe3d3e0-9a9d-23d8-9527-817faf6ce3d1@froggi.es>
Date: Thu, 19 Jan 2023 22:20:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] drm/amd/display: Hook up 'content type' property for
 HDMI
To: Melissa Wen <mwen@igalia.com>
References: <20230117212620.11262-1-joshua@froggi.es>
 <20230119181458.n4divmninme7o3dr@mail.igalia.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <20230119181458.n4divmninme7o3dr@mail.igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/19/23 18:14, Melissa Wen wrote:
> On 01/17, Joshua Ashton wrote:
>> Implements the 'content type' property for HDMI connectors.
>> Verified by checking the avi infoframe on a connected TV.
>>
>> This also simplifies a lot of the code in that area as well, there were
>> a lot of temp variables doing very little and unnecessary logic
>> that was quite confusing.
>>
>> It is not necessary to check for support in the EDID before sending a
>> 'content type' value in the avi infoframe also.
>>
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++
>>   .../gpu/drm/amd/display/dc/core/dc_resource.c | 69 ++++++-------------
>>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>>   3 files changed, 46 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 9547037857b6..999965fe3de9 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -5216,6 +5216,24 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
>>   	return color_space;
>>   }
>>   
>> +static enum display_content_type
>> +get_output_content_type(const struct drm_connector_state *connector_state)
>> +{
>> +	switch (connector_state->content_type) {
>> +	default:
>> +	case DRM_MODE_CONTENT_TYPE_NO_DATA:
>> +		return DISPLAY_CONTENT_TYPE_NO_DATA;
>> +	case DRM_MODE_CONTENT_TYPE_GRAPHICS:
>> +		return DISPLAY_CONTENT_TYPE_GRAPHICS;
>> +	case DRM_MODE_CONTENT_TYPE_PHOTO:
>> +		return DISPLAY_CONTENT_TYPE_PHOTO;
>> +	case DRM_MODE_CONTENT_TYPE_CINEMA:
>> +		return DISPLAY_CONTENT_TYPE_CINEMA;
>> +	case DRM_MODE_CONTENT_TYPE_GAME:
>> +		return DISPLAY_CONTENT_TYPE_GAME;
>> +	}
>> +}
>> +
>>   static bool adjust_colour_depth_from_display_info(
>>   	struct dc_crtc_timing *timing_out,
>>   	const struct drm_display_info *info)
>> @@ -5349,6 +5367,7 @@ static void fill_stream_properties_from_drm_display_mode(
>>   	}
>>   
>>   	stream->output_color_space = get_output_color_space(timing_out);
>> +	stream->content_type = get_output_content_type(connector_state);
>>   }
>>   
>>   static void fill_audio_info(struct audio_info *audio_info,
>> @@ -7123,6 +7142,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>>   				adev->mode_info.abm_level_property, 0);
>>   	}
>>   
>> +	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
>> +		/* Content Type is currently only implemented for HDMI. */
>> +		drm_connector_attach_content_type_property(&aconnector->base);
>> +	}
>> +
>>   	if (connector_type == DRM_MODE_CONNECTOR_HDMIA ||
>>   	    connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
>>   	    connector_type == DRM_MODE_CONNECTOR_eDP) {
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> index a5b5f8592c1b..39ceccdb6586 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> @@ -2944,14 +2944,9 @@ static void set_avi_info_frame(
>>   	uint32_t pixel_encoding = 0;
>>   	enum scanning_type scan_type = SCANNING_TYPE_NODATA;
>>   	enum dc_aspect_ratio aspect = ASPECT_RATIO_NO_DATA;
>> -	bool itc = false;
>> -	uint8_t itc_value = 0;
>> -	uint8_t cn0_cn1 = 0;
>> -	unsigned int cn0_cn1_value = 0;
>>   	uint8_t *check_sum = NULL;
>>   	uint8_t byte_index = 0;
>>   	union hdmi_info_packet hdmi_info;
>> -	union display_content_support support = {0};
>>   	unsigned int vic = pipe_ctx->stream->timing.vic;
>>   	unsigned int rid = pipe_ctx->stream->timing.rid;
>>   	unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
>> @@ -3055,49 +3050,27 @@ static void set_avi_info_frame(
>>   	/* Active Format Aspect ratio - same as Picture Aspect Ratio. */
>>   	hdmi_info.bits.R0_R3 = ACTIVE_FORMAT_ASPECT_RATIO_SAME_AS_PICTURE;
>>   
>> -	/* TODO: un-hardcode cn0_cn1 and itc */
>> -
>> -	cn0_cn1 = 0;
>> -	cn0_cn1_value = 0;
>> -
>> -	itc = true;
>> -	itc_value = 1;
>> -
>> -	support = stream->content_support;
>> -
>> -	if (itc) {
>> -		if (!support.bits.valid_content_type) {
>> -			cn0_cn1_value = 0;
>> -		} else {
>> -			if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GRAPHICS) {
>> -				if (support.bits.graphics_content == 1) {
>> -					cn0_cn1_value = 0;
>> -				}
>> -			} else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_PHOTO) {
>> -				if (support.bits.photo_content == 1) {
>> -					cn0_cn1_value = 1;
>> -				} else {
>> -					cn0_cn1_value = 0;
>> -					itc_value = 0;
>> -				}
>> -			} else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_CINEMA) {
>> -				if (support.bits.cinema_content == 1) {
>> -					cn0_cn1_value = 2;
>> -				} else {
>> -					cn0_cn1_value = 0;
>> -					itc_value = 0;
>> -				}
>> -			} else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GAME) {
>> -				if (support.bits.game_content == 1) {
>> -					cn0_cn1_value = 3;
>> -				} else {
>> -					cn0_cn1_value = 0;
>> -					itc_value = 0;
>> -				}
>> -			}
>> -		}
>> -		hdmi_info.bits.CN0_CN1 = cn0_cn1_value;
>> -		hdmi_info.bits.ITC = itc_value;
>> +	switch (stream->content_type) {
>> +	case DISPLAY_CONTENT_TYPE_NO_DATA:
>> +		hdmi_info.bits.CN0_CN1 = 0;
>> +		hdmi_info.bits.ITC = 0;
> Hmm.. why is ITC value equal zero here ^, instead of the same hardcoded
> `itc_value = 1`? Does it come from a DRM default value?
> 
> Other than that, changes seem fine to me and it's nice to see the code
> wired to the DRM and actually used.
> 
> CC'ing other AMD DC folks since I don't know if these changes affect
> other platforms. Can you guys verify it?

This is the same logic as before, itc_value is defaulted to 1, yes, but 
only assigned to hdmi_info.bits.ITC in the path with valid_content_type 
which was always false as that struct was never filled in.
So previously, ITC = 0 CN0_CN1 = 0 always.

The logic added here also matches the logic used by other DRM drivers 
using the common `drm_hdmi_avi_infoframe_content_type` logic such as Intel.

It might be nice to clean up the code so we can take advantage of the 
common helper here at some point, but currently AMDGPU uses its own 
`avi_info_frame` structure instead of the common one in DRM.
The structures should match (in theory! I did not look) so it might be 
possible to just cast `avi_info_frame*` to `hdmi_avi_infoframe*` and use 
the helper

Let me know what is preferred.

Thanks!
- Joshie 🐸✨

> 
>> +		break;
>> +	case DISPLAY_CONTENT_TYPE_GRAPHICS:
>> +		hdmi_info.bits.CN0_CN1 = 0;
>> +		hdmi_info.bits.ITC = 1;
>> +		break;
>> +	case DISPLAY_CONTENT_TYPE_PHOTO:
>> +		hdmi_info.bits.CN0_CN1 = 1;
>> +		hdmi_info.bits.ITC = 1;
>> +		break;
>> +	case DISPLAY_CONTENT_TYPE_CINEMA:
>> +		hdmi_info.bits.CN0_CN1 = 2;
>> +		hdmi_info.bits.ITC = 1;
>> +		break;
>> +	case DISPLAY_CONTENT_TYPE_GAME:
>> +		hdmi_info.bits.CN0_CN1 = 3;
>> +		hdmi_info.bits.ITC = 1;
>> +		break;
>>   	}
>>   
>>   	if (stream->qs_bit == 1) {
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>> index ef33d7d8a2bf..51dc30706e43 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>> @@ -205,6 +205,7 @@ struct dc_stream_state {
>>   	struct dc_csc_transform csc_color_matrix;
>>   
>>   	enum dc_color_space output_color_space;
>> +	enum display_content_type content_type;
>>   	enum dc_dither_option dither_option;
>>   
>>   	enum view_3d_format view_format;
>> -- 
>> 2.39.0
>>

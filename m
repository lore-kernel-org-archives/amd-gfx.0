Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A62C636D6
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Feb 2023 23:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE3910E1F3;
	Fri, 17 Feb 2023 23:55:30 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76DE10E1F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 23:55:27 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id e10so2628160wrg.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 15:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pu90YWxFIWX/Top0YzdBKgAKXIqTrNtYrrBCec47NFw=;
 b=j/lifOn/ZvzF97nKkeiaeaBoDbx5uxYJPj9qNXmPXX82Dvfz46W5eiM9wvgJ5LAnVd
 Ksix1vTWyU3dko64kNAsQAcicQn7XWp3nq0ylDzPl0V8Z0a1gSKZFNPE+dlzm89k9IaH
 HWZyKTKrpSgxd4gb+jbIoLOGWKpSAWFPs40GPGbws7x6l2Qas0Kh0RgSjGEP/1Y7e7nC
 8V/KctOr+7AC+rs61JTNXYP9AafWKzLI8r1+DLDjhnDukHTsM7J5aLJr/5qTTM7kRgKu
 fdu1P1hPpPEPXT9+zcfztm9clvGPP+w36JELZRafY7o9aiTCQAZB2Asd3ChaIi9r7+uG
 MzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pu90YWxFIWX/Top0YzdBKgAKXIqTrNtYrrBCec47NFw=;
 b=BNdr3Decp2EqBbFcK04MSS++ODk5/ywB4H9g8xpN4YwRxaUNKf6/J/AffSiYjk1Oa+
 8e8YPx654KFi89/UgpjRGP18Sp15a72sAIGhM9y+MYrA5t3aOarmlrLnjUHU4oKLdB5C
 v6O6xhE9qfG7RXS/yVCzGyVtmtkxi7I6UHKe1CSIEL/oVUX/FmNiVu/k76fec0mnkJNY
 2Iu7UpHJzeyOLl807cUa3+dTJeT0IkZ7Y1xvoAmFmotao3fs/xFRinxRVGV1oVLKiqRM
 tF7bxKxprjmpZb5Ite6ToWJ3qRgGaHTMR1GgZfXpfJvyHPZLDM+ZmG3xmrExBbCQZN3r
 ix6w==
X-Gm-Message-State: AO0yUKWbXbJDe/9R7fH2S7L8BXdQrobU+W+3iXYcfHQwUTocmZoAYVVs
 HTBMNUIHyDb/SWyzrJ0q6IniQw==
X-Google-Smtp-Source: AK7set/vHbIkacpQ1XcqHFYQQy8k2+MljXKpDBy1MGpath4/ZQi2XIo2O5wZyEFHcv0N+Vq1koXi9w==
X-Received: by 2002:a5d:4dc5:0:b0:2c5:4ca0:1abb with SMTP id
 f5-20020a5d4dc5000000b002c54ca01abbmr2520960wru.60.1676678125893; 
 Fri, 17 Feb 2023 15:55:25 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 q5-20020adfdfc5000000b002c5598c14acsm5484611wrn.6.2023.02.17.15.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Feb 2023 15:55:25 -0800 (PST)
Message-ID: <8af5c36a-c4f4-9ded-b831-aaee1cce7a93@froggi.es>
Date: Fri, 17 Feb 2023 23:55:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] drm/amd/display: Hook up 'content type' property for
 HDMI
To: Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>
References: <20230117212620.11262-1-joshua@froggi.es>
 <20230119181458.n4divmninme7o3dr@mail.igalia.com>
 <bfe3d3e0-9a9d-23d8-9527-817faf6ce3d1@froggi.es>
 <208bc529-d954-ab89-17ac-9b01acd93cc5@amd.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <208bc529-d954-ab89-17ac-9b01acd93cc5@amd.com>
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/23 00:24, Harry Wentland wrote:
> 
> 
> On 1/19/23 17:20, Joshua Ashton wrote:
>>
>>
>> On 1/19/23 18:14, Melissa Wen wrote:
>>> On 01/17, Joshua Ashton wrote:
>>>> Implements the 'content type' property for HDMI connectors.
>>>> Verified by checking the avi infoframe on a connected TV.
>>>>
>>>> This also simplifies a lot of the code in that area as well, there were
>>>> a lot of temp variables doing very little and unnecessary logic
>>>> that was quite confusing.
>>>>
>>>> It is not necessary to check for support in the EDID before sending a
>>>> 'content type' value in the avi infoframe also.
>>>>
>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>> ---
>>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++
>>>>    .../gpu/drm/amd/display/dc/core/dc_resource.c | 69 ++++++-------------
>>>>    drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>>>>    3 files changed, 46 insertions(+), 48 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index 9547037857b6..999965fe3de9 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -5216,6 +5216,24 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
>>>>        return color_space;
>>>>    }
>>>>    +static enum display_content_type
>>>> +get_output_content_type(const struct drm_connector_state *connector_state)
>>>> +{
>>>> +    switch (connector_state->content_type) {
>>>> +    default:
>>>> +    case DRM_MODE_CONTENT_TYPE_NO_DATA:
>>>> +        return DISPLAY_CONTENT_TYPE_NO_DATA;
>>>> +    case DRM_MODE_CONTENT_TYPE_GRAPHICS:
>>>> +        return DISPLAY_CONTENT_TYPE_GRAPHICS;
>>>> +    case DRM_MODE_CONTENT_TYPE_PHOTO:
>>>> +        return DISPLAY_CONTENT_TYPE_PHOTO;
>>>> +    case DRM_MODE_CONTENT_TYPE_CINEMA:
>>>> +        return DISPLAY_CONTENT_TYPE_CINEMA;
>>>> +    case DRM_MODE_CONTENT_TYPE_GAME:
>>>> +        return DISPLAY_CONTENT_TYPE_GAME;
>>>> +    }
>>>> +}
>>>> +
>>>>    static bool adjust_colour_depth_from_display_info(
>>>>        struct dc_crtc_timing *timing_out,
>>>>        const struct drm_display_info *info)
>>>> @@ -5349,6 +5367,7 @@ static void fill_stream_properties_from_drm_display_mode(
>>>>        }
>>>>          stream->output_color_space = get_output_color_space(timing_out);
>>>> +    stream->content_type = get_output_content_type(connector_state);
>>>>    }
>>>>      static void fill_audio_info(struct audio_info *audio_info,
>>>> @@ -7123,6 +7142,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>>>>                    adev->mode_info.abm_level_property, 0);
>>>>        }
>>>>    +    if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
>>>> +        /* Content Type is currently only implemented for HDMI. */
>>>> +        drm_connector_attach_content_type_property(&aconnector->base);
>>>> +    }
>>>> +
>>>>        if (connector_type == DRM_MODE_CONNECTOR_HDMIA ||
>>>>            connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
>>>>            connector_type == DRM_MODE_CONNECTOR_eDP) {
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>>> index a5b5f8592c1b..39ceccdb6586 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>>> @@ -2944,14 +2944,9 @@ static void set_avi_info_frame(
>>>>        uint32_t pixel_encoding = 0;
>>>>        enum scanning_type scan_type = SCANNING_TYPE_NODATA;
>>>>        enum dc_aspect_ratio aspect = ASPECT_RATIO_NO_DATA;
>>>> -    bool itc = false;
>>>> -    uint8_t itc_value = 0;
>>>> -    uint8_t cn0_cn1 = 0;
>>>> -    unsigned int cn0_cn1_value = 0;
>>>>        uint8_t *check_sum = NULL;
>>>>        uint8_t byte_index = 0;
>>>>        union hdmi_info_packet hdmi_info;
>>>> -    union display_content_support support = {0};
>>>>        unsigned int vic = pipe_ctx->stream->timing.vic;
>>>>        unsigned int rid = pipe_ctx->stream->timing.rid;
>>>>        unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
>>>> @@ -3055,49 +3050,27 @@ static void set_avi_info_frame(
>>>>        /* Active Format Aspect ratio - same as Picture Aspect Ratio. */
>>>>        hdmi_info.bits.R0_R3 = ACTIVE_FORMAT_ASPECT_RATIO_SAME_AS_PICTURE;
>>>>    -    /* TODO: un-hardcode cn0_cn1 and itc */
>>>> -
>>>> -    cn0_cn1 = 0;
>>>> -    cn0_cn1_value = 0;
>>>> -
>>>> -    itc = true;
>>>> -    itc_value = 1;
>>>> -
>>>> -    support = stream->content_support;
>>>> -
>>>> -    if (itc) {
>>>> -        if (!support.bits.valid_content_type) {
>>>> -            cn0_cn1_value = 0;
>>>> -        } else {
>>>> -            if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GRAPHICS) {
>>>> -                if (support.bits.graphics_content == 1) {
>>>> -                    cn0_cn1_value = 0;
>>>> -                }
>>>> -            } else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_PHOTO) {
>>>> -                if (support.bits.photo_content == 1) {
>>>> -                    cn0_cn1_value = 1;
>>>> -                } else {
>>>> -                    cn0_cn1_value = 0;
>>>> -                    itc_value = 0;
>>>> -                }
>>>> -            } else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_CINEMA) {
>>>> -                if (support.bits.cinema_content == 1) {
>>>> -                    cn0_cn1_value = 2;
>>>> -                } else {
>>>> -                    cn0_cn1_value = 0;
>>>> -                    itc_value = 0;
>>>> -                }
>>>> -            } else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GAME) {
>>>> -                if (support.bits.game_content == 1) {
>>>> -                    cn0_cn1_value = 3;
>>>> -                } else {
>>>> -                    cn0_cn1_value = 0;
>>>> -                    itc_value = 0;
>>>> -                }
>>>> -            }
>>>> -        }
>>>> -        hdmi_info.bits.CN0_CN1 = cn0_cn1_value;
>>>> -        hdmi_info.bits.ITC = itc_value;
>>>> +    switch (stream->content_type) {
>>>> +    case DISPLAY_CONTENT_TYPE_NO_DATA:
>>>> +        hdmi_info.bits.CN0_CN1 = 0;
>>>> +        hdmi_info.bits.ITC = 0;
>>> Hmm.. why is ITC value equal zero here ^, instead of the same hardcoded
>>> `itc_value = 1`? Does it come from a DRM default value?
>>>
>>> Other than that, changes seem fine to me and it's nice to see the code
>>> wired to the DRM and actually used.
>>>
>>> CC'ing other AMD DC folks since I don't know if these changes affect
>>> other platforms. Can you guys verify it?
>>
>> This is the same logic as before, itc_value is defaulted to 1, yes, but only assigned to hdmi_info.bits.ITC in the path with valid_content_type which was always false as that struct was never filled in.
>> So previously, ITC = 0 CN0_CN1 = 0 always.
>>
>> The logic added here also matches the logic used by other DRM drivers using the common `drm_hdmi_avi_infoframe_content_type` logic such as Intel.
>>
>> It might be nice to clean up the code so we can take advantage of the common helper here at some point, but currently AMDGPU uses its own `avi_info_frame` structure instead of the common one in DRM.
>> The structures should match (in theory! I did not look) so it might be possible to just cast `avi_info_frame*` to `hdmi_avi_infoframe*` and use the helper
>>
>> Let me know what is preferred.
>>
> 
> This series looks good to me and is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> I have not had a chance to test it. Do you have any way to verify
> that the receiver gets the correct content type?

It was tested on an LG OLED which has a debug overlay that shows the 
infoframe over the screen.

> 
> I also don't see any IGT tests that exercise these. It might be
> good to have those. Even if we can't verify correct functionality
> from IGT we can at least ensure setting this property doesn't
> lead to bad results in the drivers.
> 
> Would you like me to merge it through amd-staging-drm-next?

Yes please.

- Joshie 🐸✨

> 
> Harry
> 
>> Thanks!
>> - Joshie 🐸✨
>>
>>>
>>>> +        break;
>>>> +    case DISPLAY_CONTENT_TYPE_GRAPHICS:
>>>> +        hdmi_info.bits.CN0_CN1 = 0;
>>>> +        hdmi_info.bits.ITC = 1;
>>>> +        break;
>>>> +    case DISPLAY_CONTENT_TYPE_PHOTO:
>>>> +        hdmi_info.bits.CN0_CN1 = 1;
>>>> +        hdmi_info.bits.ITC = 1;
>>>> +        break;
>>>> +    case DISPLAY_CONTENT_TYPE_CINEMA:
>>>> +        hdmi_info.bits.CN0_CN1 = 2;
>>>> +        hdmi_info.bits.ITC = 1;
>>>> +        break;
>>>> +    case DISPLAY_CONTENT_TYPE_GAME:
>>>> +        hdmi_info.bits.CN0_CN1 = 3;
>>>> +        hdmi_info.bits.ITC = 1;
>>>> +        break;
>>>>        }
>>>>          if (stream->qs_bit == 1) {
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>>>> index ef33d7d8a2bf..51dc30706e43 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>>>> @@ -205,6 +205,7 @@ struct dc_stream_state {
>>>>        struct dc_csc_transform csc_color_matrix;
>>>>          enum dc_color_space output_color_space;
>>>> +    enum display_content_type content_type;
>>>>        enum dc_dither_option dither_option;
>>>>          enum view_3d_format view_format;
>>>> -- 
>>>> 2.39.0
>>>>
> 
> 

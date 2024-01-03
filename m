Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF16C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 19:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16C610E2B8;
	Wed,  3 Jan 2024 19:17:55 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4CE10E2B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 19:17:54 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d88724fb9so31744375e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 11:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1704309473; x=1704914273; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8CHAxND9/bKDKTe9qztYYelOx13FK2YkGpvou2gM23c=;
 b=I78N6S2wATPR5/Dkie6YOtVDgpzlzfAZaLZaUkvPTY/Za500eg7XK5TpBL/wObedrW
 1dKM5zUeCckTMJGqwTI27eijeWXjErz/fjsbjeOiW5iyX9rWUoCPNTwN1Whz/OtZRml0
 9M9AQoeus2xe+/Te8LwA4+Pd16gl3wIfHqAl54VVQFj/jS6Wys5hVtlE2/sAFZ9dQ2rW
 mMSbTovRLsQsIoiNkI9YILO/CeXfPtw3k4RGIcaCsafTh3ApyDxw3mB7ouGzePiFx/t3
 toKZ0dTjI9euxFLbGrUow2zdSBm/R4EWVwdCYcvua/gzqL0CeY79AP3bmn3CXP71RzhT
 ZQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704309473; x=1704914273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8CHAxND9/bKDKTe9qztYYelOx13FK2YkGpvou2gM23c=;
 b=l2ONbicpUKX00YHUOapnePFExWPle8hPMjUm9gi5aJkWzKY2MxGWXmoMlQn1tXMzcc
 Yu2ZkL3Lz9K11tqU+PzFjZ4FzztKnXUX1FOLe8wRvOQIxfJNNzE11P1B1CuXgQRxIt3w
 gYNynEJRJVDult0xzWyPz+fsd33a6EhrjyV7LfGkZJODgnoqb7zra5T6iyepR0SqPQPv
 6WmZzBcAszTVfqdpvUe0jTTbL5HeQ7T0lt1+PpGxOcUnM9ZT9Qj7et9bUaQdfHaqD5We
 mPuZ2ozD1wuH7uVLlnO/RPuYpXOdy9KBcpOuasgqCc4IC9K5Nfxjy9hyIXMS5tD9vU5I
 tDpw==
X-Gm-Message-State: AOJu0YyS7EBtgmn6ff/Vk7XDDA8bCUke2+tWbxHJssn5wtfYMc4YcK4h
 LxsttWyQTbkVlHYx0ZvRr0ZoJbBrdv9qhw==
X-Google-Smtp-Source: AGHT+IGE+QcQxD61Qv9hXJlq6d1+gtA3PipZ/HsOA6eg84KHCLws6MjeEUR1gWHpD797jdKX0YTa7A==
X-Received: by 2002:a05:600c:378a:b0:40d:40b8:98f0 with SMTP id
 o10-20020a05600c378a00b0040d40b898f0mr10160362wmr.5.1704309472892; 
 Wed, 03 Jan 2024 11:17:52 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a05600c4f0200b0040d5ae2906esm3186243wmq.30.2024.01.03.11.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 11:17:52 -0800 (PST)
Message-ID: <aa5dee62-cec8-464c-aeac-38fdac0a4a80@froggi.es>
Date: Wed, 3 Jan 2024 19:17:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets
 for DP/eDP displays without PSR
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240101182836.817565-1-joshua@froggi.es>
 <8db3e45e-037a-4dc5-aabb-519091b1a69e@amd.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <8db3e45e-037a-4dc5-aabb-519091b1a69e@amd.com>
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
Cc: Melissa Wen <mwen@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks! Is it possible for us to get this backported too?

I forgot to add a Fixes: tag to this commit. It should be

Fixes: 15f9dfd545a1 ("drm/amd/display: Register Colorspace property for 
DP and HDMI")

- Joshie 🐸✨

On 1/3/24 14:35, Hamza Mahfooz wrote:
> On 1/1/24 13:28, Joshua Ashton wrote:
>> The check for sending the vsc infopacket to the display was gated behind
>> PSR (Panel Self Refresh) being enabled.
>>
>> The vsc infopacket also contains the colorimetry (specifically the
>> container color gamut) information for the stream on modern DP.
>>
>> PSR is typically only supported on mobile phone eDP displays, thus this
>> was not getting sent for typical desktop monitors or TV screens.
>>
>> This functionality is needed for proper HDR10 functionality on DP as it
>> wants BT2020 RGB/YCbCr for the container color space.
>>
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Xaver Hugl <xaver.hugl@gmail.com>
>> Cc: Melissa Wen <mwen@igalia.com>
> 
> Applied, thanks!
> 
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  8 +++++---
>>   .../amd/display/modules/info_packet/info_packet.c   | 13 ++++++++-----
>>   2 files changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 2845c884398e..6dff56408bf4 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -6233,8 +6233,9 @@ create_stream_for_sink(struct drm_connector 
>> *connector,
>>       if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
>>           mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
>> -
>> -    if (stream->link->psr_settings.psr_feature_enabled || 
>> stream->link->replay_settings.replay_feature_enabled) {
>> +    else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
>> +             stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
>> +             stream->signal == SIGNAL_TYPE_EDP) {
>>           //
>>           // should decide stream support vsc sdp colorimetry capability
>>           // before building vsc info packet
>> @@ -6250,8 +6251,9 @@ create_stream_for_sink(struct drm_connector 
>> *connector,
>>           if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
>>               tf = TRANSFER_FUNC_GAMMA_22;
>>           mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, 
>> stream->output_color_space, tf);
>> -        aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>> +        if (stream->link->psr_settings.psr_feature_enabled)
>> +            aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>>       }
>>   finish:
>>       dc_sink_release(sink);
>> diff --git 
>> a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c 
>> b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>> index 84f9b412a4f1..738ee763f24a 100644
>> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>> @@ -147,12 +147,15 @@ void mod_build_vsc_infopacket(const struct 
>> dc_stream_state *stream,
>>       }
>>       /* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
>> -    if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
>> -        vsc_packet_revision = vsc_packet_rev4;
>> -    else if (stream->link->replay_settings.config.replay_supported)
>> +    if (stream->link->psr_settings.psr_feature_enabled) {
>> +        if (stream->link->psr_settings.psr_version == 
>> DC_PSR_VERSION_SU_1)
>> +            vsc_packet_revision = vsc_packet_rev4;
>> +        else if (stream->link->psr_settings.psr_version == 
>> DC_PSR_VERSION_1)
>> +            vsc_packet_revision = vsc_packet_rev2;
>> +    }
>> +
>> +    if (stream->link->replay_settings.config.replay_supported)
>>           vsc_packet_revision = vsc_packet_rev4;
>> -    else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
>> -        vsc_packet_revision = vsc_packet_rev2;
>>       /* Update to revision 5 for extended colorimetry support */
>>       if (stream->use_vsc_sdp_for_colorimetry)


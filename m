Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B6DC47073
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jan 2024 21:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F6910E040;
	Mon,  1 Jan 2024 21:37:02 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B0F10E040
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jan 2024 21:37:01 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d858c56cbso18227485e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jan 2024 13:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1704145020; x=1704749820; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u2yO6Si82hzlAS0Mg+Gkj8IYdJ+Sm4Q4sE/QqIJi3Bs=;
 b=XBCOQq2ydo8FBAeUvaTUopaPKMLJmzVUwM2Yp89cqCiAq9U9BZA/HKT82/r34QqLPM
 YFYllIBbg6gaknJg3VVZdo1+9AEeGPNfJvC3vUQ7xFlI0VK/IGiM6cgI8fhPIwEFB6kA
 aS3sn9Wv8MWsbwU3pM+rZRdt6NkkfvK+9YebFnSutWCPUuHvNieWnt4BrPvyy/QoWTjw
 TgykUIujXoPV+VhpoUtVgqsnPuQDfEinfUxa351BYbHe8baDEi0py9AwRF6AfbV3FPTT
 QxiLqQMHOJbe2jEpghZ+biUKD7ZAYUU8rbmG5KPl0jsTJY0jS52T1KvG+OVqhH25qG3E
 qsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704145020; x=1704749820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u2yO6Si82hzlAS0Mg+Gkj8IYdJ+Sm4Q4sE/QqIJi3Bs=;
 b=wnnu50YnYujM7ECsdoUC6cDqYRXNSaInWdZ7RwzORrGyj/ZQlncwwrY8HbxDO0Q/xw
 DcT6sj5N2CdY9YRX/THGwV5tED3FErlFRyddw0ASEcT3EtB47E1vFy88JGDu6cmkVysg
 rheyw1+DF0oyptJC9ocIBd/juj7pTVfagiSDSAaVakvD95ciOxfnmDwqqnVwwX7cPaC0
 qgRjNObWiah7qhIJWuDC+lG7QW9JNrfz+EiZjcmmDy07CzSmGLYCEG2u9bdQqqVHKLVa
 Ll1Qe/Z417JR5P94v6H4vQDcyCAwR/NKWDAV5vGf0VI+Sqa7BqnYvkLoMmkP9PzkiRk8
 5WCQ==
X-Gm-Message-State: AOJu0YwhOMalGLhK5uL8WMKBlcmA4+fHeTOKIumMCP47cPyqJjj0A2zz
 /Sc6tExSBqyPhHk/vexuedfBHIzvX45vHo588NEHcbNeq9Q=
X-Google-Smtp-Source: AGHT+IEgMEXUpDu7I7Zc2VzQpNGutkKk5w9/Wcx6kk48K6cQV3kg/SbjfBKWT/ZZ4nBZ0w2QvCDwnw==
X-Received: by 2002:a05:600c:3f8b:b0:40d:8a95:3196 with SMTP id
 fs11-20020a05600c3f8b00b0040d8a953196mr639048wmb.34.1704145019890; 
 Mon, 01 Jan 2024 13:36:59 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c444700b0040d83acde28sm9537346wmn.14.2024.01.01.13.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jan 2024 13:36:59 -0800 (PST)
Message-ID: <554945c2-bb85-497a-ba88-b486eadd8a3c@froggi.es>
Date: Mon, 1 Jan 2024 21:36:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets
 for DP/eDP displays without PSR
To: amd-gfx@lists.freedesktop.org
References: <20240101182836.817565-1-joshua@froggi.es>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <20240101182836.817565-1-joshua@froggi.es>
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
Cc: Melissa Wen <mwen@igalia.com>, Harry Wentland <harry.wentland@amd.com>,
 Xaver Hugl <xaver.hugl@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 From the issue:

```
Thank you for for fixing this!
I built a custom kernel with this patch on the fedora rawhide kernel 
(6.7.0-0.rc8.61.fc40.x86_64) and now the colors look correct. SDR 
content is now displayed as sRGB and HDR/WCG content can use the full 
capabilities of the display.
I currently don't have a desktop mail client installed to comment on the 
mailing list directly, so I'll post it here (not sure if it counts or 
matters 😀 )

Tested-By: Simon Berz <simon@berz.me>
```

- Joshie 🐸✨

On 1/1/24 18:28, Joshua Ashton wrote:
> The check for sending the vsc infopacket to the display was gated behind
> PSR (Panel Self Refresh) being enabled.
> 
> The vsc infopacket also contains the colorimetry (specifically the
> container color gamut) information for the stream on modern DP.
> 
> PSR is typically only supported on mobile phone eDP displays, thus this
> was not getting sent for typical desktop monitors or TV screens.
> 
> This functionality is needed for proper HDR10 functionality on DP as it
> wants BT2020 RGB/YCbCr for the container color space.
> 
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Xaver Hugl <xaver.hugl@gmail.com>
> Cc: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  8 +++++---
>   .../amd/display/modules/info_packet/info_packet.c   | 13 ++++++++-----
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2845c884398e..6dff56408bf4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6233,8 +6233,9 @@ create_stream_for_sink(struct drm_connector *connector,
>   
>   	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
>   		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
> -
> -	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
> +	else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
> +			 stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
> +			 stream->signal == SIGNAL_TYPE_EDP) {
>   		//
>   		// should decide stream support vsc sdp colorimetry capability
>   		// before building vsc info packet
> @@ -6250,8 +6251,9 @@ create_stream_for_sink(struct drm_connector *connector,
>   		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
>   			tf = TRANSFER_FUNC_GAMMA_22;
>   		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
> -		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>   
> +		if (stream->link->psr_settings.psr_feature_enabled)
> +			aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>   	}
>   finish:
>   	dc_sink_release(sink);
> diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> index 84f9b412a4f1..738ee763f24a 100644
> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> @@ -147,12 +147,15 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
>   	}
>   
>   	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
> -	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
> -		vsc_packet_revision = vsc_packet_rev4;
> -	else if (stream->link->replay_settings.config.replay_supported)
> +	if (stream->link->psr_settings.psr_feature_enabled) {
> +		if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
> +			vsc_packet_revision = vsc_packet_rev4;
> +		else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
> +			vsc_packet_revision = vsc_packet_rev2;
> +	}
> +
> +	if (stream->link->replay_settings.config.replay_supported)
>   		vsc_packet_revision = vsc_packet_rev4;
> -	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
> -		vsc_packet_revision = vsc_packet_rev2;
>   
>   	/* Update to revision 5 for extended colorimetry support */
>   	if (stream->use_vsc_sdp_for_colorimetry)


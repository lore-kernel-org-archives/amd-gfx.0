Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE9EC61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 07:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7402710EBC6;
	Tue,  1 Sep 2026 07:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ehFYVI/F";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FE510EA63
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:49:09 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so36295205e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788202147; x=1788806947; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mBRYrm7iZ0lt9Y/BYEBnIT0kCPY+bCfIH1rb2I4FEiI=;
 b=ehFYVI/FWmAcyS2CyaHWvUy/rN7u34eOJzXdGPn3xPZ7abJCzRHl9KsqsgDwuIuuH9
 1CDPPQ58RefuUpTQpIpoXfsAOiXOJwfH1NwVthI3JY4yn4HtwUhzHaUyHvtQcmHWVsaw
 EbUHLuWbfPW6dPn53hAsawy2+fOIUbSebzMjP2B1LYv7mJHvVEBS60dupYOTUn1moOlq
 MuWRn+EXSwGpsJHAmBE2bzQdtsmIDjzKUyLV/h5/+ntyBiOq/+qEeBMa5mcEy3wl7Jhd
 Vb+J2fwpawu+Yc4RssePZcXEYMbiP2YpmFfxQLwuNj1yhoVpjlpTfZjOfdd6YNAZzHH+
 Nphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788202147; x=1788806947;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mBRYrm7iZ0lt9Y/BYEBnIT0kCPY+bCfIH1rb2I4FEiI=;
 b=C08rlUtw9y9NFH4m/EnNo23y0ymOzZFFUJOFGt6hpzYCg5HOuqnzE8rb6t24CbjcpM
 vmz2K+lPsR/7+PQPvf/eAS56rYjfxFiuX4luTvJt87I51Gs4fBkCpZQ/AjlrLJQAhjs7
 Pir2nJP7guyanBl9bpshxS1tkU+ai86JSkqWVQT7FVx0pjj0s/qxslh5x0FC+GwwKaeN
 mvVeSoV+nd89vTjsCjK/e+Twxx5P5U7J4K/6wT7/TaTGqdq77tK5WePexMakV2bpmavC
 0QwOak4rzhDTMwO58O9HKKJPC4M9m8PlxwAI2LqIhFFOXr5jGIkyqUJvnRHkWIFVJqDc
 hbDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwmiunB4I4oe5YIjl0eiFGji7/atW/W3mlNbDASgEaA4reofFiC6aokQ9PaYWaZkn9x00P6EdM@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNSmUdSTpLs7T/FoK9g4YI3Oa7AROhoAdAH69AzMcmV6B4Qi0a
 zhbFzgVlBKnPDA/N4IGSLMej3Y7qsGgbpvRLCNVwAThJhwlhFAbd30Me
X-Gm-Gg: AR+sD10bxw/QlHrT2FKJCAFEQWHNXqVzvT+S7+mnKElyhiTzBb2WSE+MevxV7RTg49G
 h52lPntgdpszAm9vYfWMKGMAPmEmDmcnqnSx1Vn9dNVaIjgeVRHe2hq0PYyvtB1+IQueZA2kPtW
 dLzF2o9c+/d+BjwV/rqRKZKp8dmSWxkPimx0P4O/lKTDsyazqVYtC698yFT4iVj0RQSykL5XBUQ
 CB+CCzERm7mNrogd0Kvzfa7sQKAKzm14vUK24ad4zbih9Pb4tA24Jzps9VnvW88aBfkd2N1+xT+
 qEoYxdT3MeOac4EUmXRtn19mzC7fIj1nWdAXmV2XFpl/a3Gilq52NsPDxh/4us0IjgM6CVpYRsw
 SKW0v3jatCyFu29qwHii7EA+f3akQIOoX+MJ64lYM6riMtmPYBtcJyKkYWrHZ4et7kA/WWqKlUs
 06cyWKnlR/3TdUqdgntYAHaAB7NC/MMj/B1Xc4wZn/+PaLDLMHyh650d1NjpMyEHFrj61I9diuK
 Mq9dzBZdrscJOvu+5/DD/4Fz2EQhtz/pa5wds/ymqKkSnWtcAddD89JQXHWG4bgre3fau7WA1sU
 xgG1PULDb8NAbOE+uuyU0aEqL2kb4LK899rMcFFfi1dSYB4=
X-Received: by 2002:a05:600c:6b08:b0:498:952:e276 with SMTP id
 5b1f17b1804b1-49cdc41f98fmr34974615e9.8.1788202147210; 
 Mon, 31 Aug 2026 11:49:07 -0700 (PDT)
Received: from [192.168.168.11] (a109-50-200-65.cpe.netcabo.pt.
 [109.50.200.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce171c3sm12201185e9.8.2026.08.31.11.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:49:06 -0700 (PDT)
Message-ID: <c42ced8f-5e3a-42c9-ade4-d357575114ca@gmail.com>
Date: Mon, 31 Aug 2026 19:49:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] HDMI 2.1 VRR and ALLM support
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 daniel@fooishbar.org
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
Content-Language: en-US
From: Adolfo <adolfotregosa@gmail.com>
In-Reply-To: <20260814164344.3098143-1-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:59:19 +0000
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

I patched kernel 7.3-rc1, and I have KDE's Adaptive Sync property set to 
Automatic (Always makes the display gamma flicker). VRR itself is only 
engaged when entering a game.

My display (an LG C1 connected through an Onkyo RZ70 AVR) shows "fixed" 
when VRR is not active. While this seems logical, it causes the display 
to go blank every time I enter or exit a game, or, even worse, when I 
alt-tab while in a game.

In my case, I can have periods of up to 10 seconds with no image while 
the devices in the HDMI chain disagree with each other, and sometimes I 
lose the image completely.

A kernel parameter to force VRR to always be enabled should be 
available. This would prevent these signal-switching problems, and it is 
how "FreeSync" actually works and also with the unofficial kernel 
patches for AMD HDMI 2.1 + VRR on kernel 7.2.

There is also some evidence that keeping VRR active can avoid the 
mode-switch behavior seen on some TVs when VRR is enabled or disabled.

On 14/08/2026 17:43, Fangzhi Zuo wrote:
> This series adds HDMI 2.1 gaming support to amdgpu: Variable Refresh Rate
> (VRR) derived from the HDMI Forum VSDB (HF-VSDB), and Auto Low-Latency
> Mode (ALLM). It builds on a drm/edid patch that parses the HF-VSDB gaming
> capabilities into struct drm_hdmi_info.
>
>    - Patch 1 reports FreeSync from the AMD VSDB (existing mechanism).
>    - Patch 2 (drm/edid) parses the HF-VSDB VRR range and ALLM bit.
>    - Patch 3 enables VRR from the HF-VSDB when the AMD VSDB has no range.
>    - Patch 4 signals ALLM_Mode in the HF-VSIF when Gaming-VRR is active.
>
> v1: https://lore.kernel.org/amd-gfx/20260730171754.704049-1-jerry.zuo@amd.com/
> v2: https://lore.kernel.org/amd-gfx/20260806205449.16806-1-jerry.zuo@amd.com/
> v3: https://lore.kernel.org/amd-gfx/20260811003921.1398292-1-jerry.zuo@amd.com/
>
> Changes since v3:
>    - Drop the content-type based ALLM heuristic. ALLM_Mode is now set only
>      for the mandatory Gaming-VRR case (VRR_EN=1 with a sink that advertises
>      ALLM), per HDMI 2.1 Section 7.6.6; it is no longer derived from the
>      content type.
>
> Changes since v2:
>    - Fix coding-style issues in the VTEM info-packet code.
>
> Fangzhi Zuo (3):
>    drm/amd/display: Add 2.1 FreeSync support for AMD VSDB EDID Block
>    drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
>    drm/amd/display: Enable HDMI ALLM for Gaming-VRR
>
> Tomasz Pakuła (1):
>    drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   |  71 +++++++++++-
>   .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  41 +++++++
>   .../amd/display/modules/inc/mod_info_packet.h |   4 +
>   .../display/modules/info_packet/info_packet.c | 109 ++++++++++++++++++
>   drivers/gpu/drm/drm_edid.c                    |  42 +++++++
>   include/drm/drm_connector.h                   |  47 ++++++++
>   7 files changed, 317 insertions(+), 2 deletions(-)
>
>
> base-commit: de2622bbc20276eaaaafa8fdbd374ace1ced28dc

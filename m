Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EB2C624A4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF7810F424;
	Thu,  3 Sep 2026 07:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kp72dgcl";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681E610EF3F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 22:12:08 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso2426255e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788300727; x=1788905527; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=920ie7mR2uGNd0kS6o28FsYSJY1xch5R6Nydolas+Zw=;
 b=kp72dgcl4+TfB2hGSD/8paMkpYOw/XGmAsMGsGZdNrBXX8BdzUgT1TW+WfH9PZddBm
 oAmEgkWFzUcu/JHzrcP06xmKOvTTXOtq7+o92Lq+FhEsUxXwFSPUs1Dawg10zd3D/kpp
 miZebMWJ+M9lkfxx0tEbF1KIETDof4y6gYBVFwZUBCChNdmw7JBnSqSYeqUGAJLT41mv
 8QjDuMjIO4TPM2no7Uys4ZHk8mpUI3xN6GBqAlIfpCYmbqJcNQkGS+6A8xpIwHelWmWS
 4VUMoqkbAHnaRskOvyhfopLhuihA1wHZ0rYMGjuoIshSoelR9OY9bqiY5mUT1A8P3osi
 3rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788300727; x=1788905527;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=920ie7mR2uGNd0kS6o28FsYSJY1xch5R6Nydolas+Zw=;
 b=n57culySDAj70BGvJ1MgNd2QukHy43/nLoCaD4vag2KwtkaTlDrMXuOqH/cWQTEf7Y
 VqyF1u5jQhJHUcZHIEHYjTiHt+IId5rOlTE3Y4JVawiUf5tENfbnssPT99VLpxIxaGI8
 MVzxTNFSD/S7qHQJF2Y7hLW7659tL3dv+l7ogc5ivl96T5cvAzNuAL8lIU3lanMpcL+0
 CNe+e1/PPgIUOTNsy4BFYNNq007n6nbdIkQSUcQ4aUhvfIqkTBXf88up+tc3WqaoNifT
 ZgXBQ/IZUDejFiquTcqRMmRUZSQqb2EhQV8V5g5E9y6W83mzo0fPOL8mmdolIAYlEDKs
 iP+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rogy8d58KWVtiQxeaRul33yka2TKpjFQum8msXpxzui07NBujs3BUoy+tqq4uFEGajfnfEonBTc@lists.freedesktop.org
X-Gm-Message-State: AFuF++meO8rCNW3BrfiBshGzrGvNVUSuP8f/teRKNTnu+dkYn4fBXBaE
 dz4eIeEgUSI3UT9r8qeHA6fZKcYS3BByYTovND1pwR1/0rL9IIHDdZiy
X-Gm-Gg: AR+sD13gUc+dNTzVREkbIEepOsdXh2AkPQqVuKt8HcsTr6iYtLW3VH2cJJ0GLUVXCmF
 ySkaczgzV9sOA3wRXiQCK5m9POTC6jV3oUgRw2ppHWhzBQ9eSSVUJy4v34cwC8G8OayC8S1RkdC
 MoW8oqUByFzgRwG1BUZmwNSqejLMVcljZfhKEpNQzwxchyQgnuG/U0y61DI+6kRRab7FXTmMPaY
 VJzTbFhrlgQ57mR59hTu2bH7cXBSLrvH+c12m8tKnP0NpPdwCgsrV7frP4Y7fP7aeGoLiFF8enM
 hC43x87fwdNdf4oaFyby+SbvRcvp0T/fa+u08II6+2qtUaKxg8+XrdboM/+LYEu+PL/PCBCfWqW
 m6TdXWAdgGaDsxj3gn5C1iHRgpGv8OCp/yalatqusboQUejVexORCFI5fWlRrDysqIE/ndBrlbo
 I/kg1HUY/PMN5kovwPKswHTaXsZUXlJhvCKhZB9jryULKnQZkNiDe/Ji8ItwHwu6c3EPxcae4yj
 UMxjre3fgDJiSzEEKlIAn65QlkB670zMtvu1uPl6MfeXr8AYbe7ouwWNXEXbpFDcGFV3CjQlG7D
 +yhe2GREPeIZQIao1/Qll6pHny7FTvQ7KGG32e0b2VEx0g==
X-Received: by 2002:a05:600c:4fcd:b0:49b:90cc:3c87 with SMTP id
 5b1f17b1804b1-49ce582267bmr8034685e9.13.1788300726530; 
 Tue, 01 Sep 2026 15:12:06 -0700 (PDT)
Received: from [192.168.168.11] (a109-50-200-65.cpe.netcabo.pt.
 [109.50.200.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce592b017sm2314355e9.2.2026.09.01.15.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 15:12:06 -0700 (PDT)
Message-ID: <7ed80c0e-de24-4506-9db3-bc25c17d260e@gmail.com>
Date: Tue, 1 Sep 2026 23:12:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] HDMI 2.1 VRR and ALLM support
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 "daniel@fooishbar.org" <daniel@fooishbar.org>
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
 <c42ced8f-5e3a-42c9-ade4-d357575114ca@gmail.com>
 <CHXPR12MB999220744D9CB11795CEF3DD69E5A82@CHXPR12MB999220.namprd12.prod.outlook.com>
Content-Language: en-US
From: Adolfo <adolfotregosa@gmail.com>
In-Reply-To: <CHXPR12MB999220744D9CB11795CEF3DD69E5A82@CHXPR12MB999220.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:34:48 +0000
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

I patched kernel 7.3-rc1 with the passive-VRR patches, but VRR is not 
engaging while on the desktop, only in game.

On 01/09/2026 20:15, Zuo, Jerry wrote:
> AMD General
>
>> -----Original Message-----
>> From: Adolfo <adolfotregosa@gmail.com>
>> Sent: Monday, August 31, 2026 14:49
>> To: Zuo, Jerry <Jerry.Zuo@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org; Wentland, Harry
>> <Harry.Wentland@amd.com>; Tomasz Pakuła
>> <tomasz.pakula.oficjalny@gmail.com>; daniel@fooishbar.org
>> Subject: Re: [PATCH v4 0/4] HDMI 2.1 VRR and ALLM support
>>
>> [You don't often get email from adolfotregosa@gmail.com. Learn why this is
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> I patched kernel 7.3-rc1, and I have KDE's Adaptive Sync property set to
>> Automatic (Always makes the display gamma flicker). VRR itself is only
>> engaged when entering a game.
>>
>> My display (an LG C1 connected through an Onkyo RZ70 AVR) shows "fixed"
>> when VRR is not active. While this seems logical, it causes the display to go
>> blank every time I enter or exit a game, or, even worse, when I alt-tab while in
>> a game.
>>
>> In my case, I can have periods of up to 10 seconds with no image while the
>> devices in the HDMI chain disagree with each other, and sometimes I lose the
>> image completely.
>>
>> A kernel parameter to force VRR to always be enabled should be available.
>> This would prevent these signal-switching problems, and it is how "FreeSync"
>> actually works and also with the unofficial kernel patches for AMD HDMI 2.1
>> + VRR on kernel 7.2.
>>
>> There is also some evidence that keeping VRR active can avoid the mode-
>> switch behavior seen on some TVs when VRR is enabled or disabled.
> Thanks for your feedback. Regarding to your concern, I've uploaded another
> series of patches for "passive VRR". Please check and see if that works for you.
>
> Regards,
> Jerry
>
>> On 14/08/2026 17:43, Fangzhi Zuo wrote:
>>> This series adds HDMI 2.1 gaming support to amdgpu: Variable Refresh
>>> Rate
>>> (VRR) derived from the HDMI Forum VSDB (HF-VSDB), and Auto Low-
>> Latency
>>> Mode (ALLM). It builds on a drm/edid patch that parses the HF-VSDB
>>> gaming capabilities into struct drm_hdmi_info.
>>>
>>>     - Patch 1 reports FreeSync from the AMD VSDB (existing mechanism).
>>>     - Patch 2 (drm/edid) parses the HF-VSDB VRR range and ALLM bit.
>>>     - Patch 3 enables VRR from the HF-VSDB when the AMD VSDB has no
>> range.
>>>     - Patch 4 signals ALLM_Mode in the HF-VSIF when Gaming-VRR is active.
>>>
>>> v1:
>>> https://lore.kernel.org/amd-gfx/20260730171754.704049-1-jerry.zuo@amd.
>>> com/
>>> v2:
>>> https://lore.kernel.org/amd-gfx/20260806205449.16806-1-jerry.zuo@amd.c
>>> om/
>>> v3:
>>> https://lore.kernel.org/amd-gfx/20260811003921.1398292-1-
>> jerry.zuo@amd
>>> .com/
>>>
>>> Changes since v3:
>>>     - Drop the content-type based ALLM heuristic. ALLM_Mode is now set
>> only
>>>       for the mandatory Gaming-VRR case (VRR_EN=1 with a sink that
>> advertises
>>>       ALLM), per HDMI 2.1 Section 7.6.6; it is no longer derived from the
>>>       content type.
>>>
>>> Changes since v2:
>>>     - Fix coding-style issues in the VTEM info-packet code.
>>>
>>> Fangzhi Zuo (3):
>>>     drm/amd/display: Add 2.1 FreeSync support for AMD VSDB EDID Block
>>>     drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
>>>     drm/amd/display: Enable HDMI ALLM for Gaming-VRR
>>>
>>> Tomasz Pakuła (1):
>>>     drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from
>>> HF-VSDB
>>>
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
>>>    .../display/amdgpu_dm/amdgpu_dm_connector.c   |  71 +++++++++++-
>>>    .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  41 +++++++
>>>    .../amd/display/modules/inc/mod_info_packet.h |   4 +
>>>    .../display/modules/info_packet/info_packet.c | 109 ++++++++++++++++++
>>>    drivers/gpu/drm/drm_edid.c                    |  42 +++++++
>>>    include/drm/drm_connector.h                   |  47 ++++++++
>>>    7 files changed, 317 insertions(+), 2 deletions(-)
>>>
>>>
>>> base-commit: de2622bbc20276eaaaafa8fdbd374ace1ced28dc

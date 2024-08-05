Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7400BC3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Aug 2024 15:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC9210E239;
	Mon,  5 Aug 2024 15:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="K1xaeCBW";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F7D510E0CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Aug 2024 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722862524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sFTkFFBzy68gGYyVFthr8XWWlGLTI9qL1cAt5iZfio=;
 b=K1xaeCBW31rtEmP/jsmeK5FB2rF7ewjuKt7e7JudHCGs3xQ8ETbl6JaPZfAzVFfliTeR53
 3DgANnzQo0AmYK4I2Z8GokTrYaUhJRREiWeI5TrRsEtiymlFlT2ct9/yXMOVuJhqO1wHrd
 Nnap1iEL8UQ1QREXBOdsAi0heXemnzM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-4LSK3i7EM0aBQZvda8Rxog-1; Mon, 05 Aug 2024 08:55:22 -0400
X-MC-Unique: 4LSK3i7EM0aBQZvda8Rxog-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7abaf0aecdso713568166b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Aug 2024 05:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722862521; x=1723467321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6sFTkFFBzy68gGYyVFthr8XWWlGLTI9qL1cAt5iZfio=;
 b=wSOjfARCXRprQxI8nN8ztOvhQ/8xroweEAeJpJu3XeTJJALKM0PQ/E6P4P7/AaLw0B
 QxZ1YYUAjnp484Gg2cnxS5/GlXADzHBVNcUhb7u6oHGCl7oGJ7OIZbuG/coWT+wJgWou
 JsH4ZgiXtTz56WCebn8tsIfs8nS7aMOBSYj1T7YqXjfrM7/fhjgfvwztJX9LMENq4u46
 w4SCfkCaq5sFkNpO3uqp7V8r5N9NCxR7XnABswy0oyFY10Zoyunrmu0OIekIN7f2/6fd
 6/D4xJiVgTdNN7DfRRvBTmKIRY4DZz2KMZCb58feeGRUn+kcPe/S5lOu8e1Fva2USFnr
 rdcA==
X-Gm-Message-State: AOJu0YzejrEpgKEnu/I4U9PQhn0+4reUob7MGDA1fwAKHtiU0taJIEPf
 17Jukcvn4T0aqahUCGkKN75W+EpNlyUWiqcHS/VahpX7JSNlNb3HstvvGRUg5uvlGGVFhY61Lqf
 KU7BSqMZ569oVAiSCysU3K0g4RKc9w9QbHnoPVMeQDmXgEb92dpIhYQNzbvb0sGQ=
X-Received: by 2002:a17:906:d262:b0:a7a:9f78:fef with SMTP id
 a640c23a62f3a-a7dc5179f86mr918970366b.45.1722862521520; 
 Mon, 05 Aug 2024 05:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9YeBvy8oWLp/NyTyOio/5DPMJElgRHoNwm4t6biuGr97/fY6gQoYH1jOlXD1POvqPTXGZVQ==
X-Received: by 2002:a17:906:d262:b0:a7a:9f78:fef with SMTP id
 a640c23a62f3a-a7dc5179f86mr918967066b.45.1722862520880; 
 Mon, 05 Aug 2024 05:55:20 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d4542esm452408766b.127.2024.08.05.05.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 05:55:20 -0700 (PDT)
Message-ID: <df84bf60-bcb4-4fcc-bbf2-d627714e365d@redhat.com>
Date: Mon, 5 Aug 2024 14:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm: backlight quirk infrastructure and lower
 minimum for Framework AMD 13
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Aug 2024 15:43:07 +0000
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

Hi Thomas,

On 6/23/24 10:51 AM, Thomas Weißschuh wrote:
> The value of "min_input_signal" returned from ATIF on a Framework AMD 13
> is "12". This leads to a fairly bright minimum display backlight.
> 
> Add a generic quirk infrastructure for backlight configuration to
> override the settings provided by the firmware.
> Also add amdgpu as a user of that infrastructure and a quirk for the
> Framework 13 matte panel.
> Most likely this will also work for the glossy panel, but I can't test
> that.
> 
> One solution would be a fixed firmware version, but given that the
> problem exists since the release of the hardware, it has been known for
> a month that the hardware can go lower and there was no acknowledgment
> from Framework in any way, I'd like to explore this alternative
> way forward.
> 
> Notes:
> 
> * Should the quirk infrastructure be part of drm_edid.c?
> * The current allocation of struct drm_edid in amdgpu is bad.
>   But it is done the same way in other parts of amdgpu.
>   I do have patches migrating amdgpu to proper usage of struct drm_edid [0]

So now that we have agreed to move forward with this approach one
generic design issue / question which popped into my head is:

What happens if i915 also gets support for the minimum brightness quirk?

Specifically the panel used on the framework 13 will match the quirk
independent of which GPU driver is used. But does say a minimum value
of "5" have the same meaning / results in the same minimum duty-cycle
when used by the i915 code vs the amdgpu code ?

I know that the actual quirk sets the min pwm to 0, which presumably results
in a 0% duty cycle on both i915 and amdgpu, but I'm worried what happens
if we see the same panel used in designs which can have it attached to
different vendor GPUs, how should the GPU driver interpret the
pwm_min_brightness value so that it is interpretted consistently between
drivers ? 

I guess this is covered by the docbook saying that min-brightness is on
a 0-255 brightness scale (with 255 being 100%) though ?  Just making sure
that everyone has agreement on that being the scale and that drivers
should not directly take this value but scale it as necessary.
This should also (scale it as necessary) be explicitly mentioned in
the docs IMHO.

Regards,

Hans






> Mario:
> 
> I intentionally left out the consideration of the firmware version.
> The quirk will stay correct even if the firmware starts reporting
> correct values.
> If there are strong opinions it would be easy to add, though.
> 
> Based on amdgpu/drm-next.
> 
> [0] https://lore.kernel.org/lkml/20240616-amdgpu-edid-bios-v1-1-2874f212b365@weissschuh.net/
> 
> ---
> Changes in v2:
> - Introduce proper drm backlight quirk infrastructure
> - Quirk by EDID and DMI instead of only DMI
> - Limit quirk to only single Framework 13 matte panel
> - Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net
> 
> ---
> Thomas Weißschuh (3):
>       drm: Add panel backlight quirks
>       drm: panel-backlight-quirks: Add Framework 13 matte panel
>       drm/amd/display: Add support backlight quirks
> 
>  Documentation/gpu/drm-kms-helpers.rst             |  3 +
>  drivers/gpu/drm/Kconfig                           |  4 ++
>  drivers/gpu/drm/Makefile                          |  1 +
>  drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++
>  drivers/gpu/drm/drm_panel_backlight_quirks.c      | 76 +++++++++++++++++++++++
>  include/drm/drm_utils.h                           | 11 ++++
>  7 files changed, 124 insertions(+)
> ---
> base-commit: 1ecef5589320fd56af599b624d59c355d162ac7b
> change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
> 
> Best regards,


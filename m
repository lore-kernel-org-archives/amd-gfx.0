Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5674AD2B92B
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 13:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A66210E5A5;
	Tue,  5 Nov 2024 13:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Auq3LjXe";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC80410E5A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730814506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZmNKo4+zDgkky/zOIe5THsZvk+kV0tADHQOKhtWpPY=;
 b=Auq3LjXeqPuZeCGd/L3y24+Y30QZwokzjZqhF+BaeITzMIgitdo07E3JcqEivVLc7YtFB3
 A3auePjERpXrGXNoCvTZv6Kx1RRWLKGz160mlC21IwSfBD5fKoZAg0yi/cYUwbGlEIi3HL
 eOXAedJZq68T0bjIDN7MVnXpAJbXl8I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-G4KbQboyM9yPShbmzf_xgA-1; Tue, 05 Nov 2024 08:48:25 -0500
X-MC-Unique: G4KbQboyM9yPShbmzf_xgA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9a157d028aso422338366b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2024 05:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730814503; x=1731419303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZmNKo4+zDgkky/zOIe5THsZvk+kV0tADHQOKhtWpPY=;
 b=dg4bcfZr5oPmUTmcQOcNlsIpDu1YBUg8xDXlZV+lBYOzdAPK3fdobV3wJB2gBIIvQh
 3Q7cDD2y50/PTNDyf3HPNMOTLeG0ImI9DlIthjzXs1Iiwq0Tmcrzp6iH7JF9Jrx8NCjN
 PX94yEnUAKEwbgwQ/SCZ6dWj5DJ7FTdgrUK7lQMok4mfBIjPXxDE/p118oEaGovrNgcU
 8p40KUHsAsfmTn9+GT/P3erGNyp/V5fe/VzQptLfnQs1QrgdZEqm4uDXDgBuDwJ+2GAs
 GHAfFF3AnraN733u1tnhxuwgyb2VIzRamCy5x0TTl8AXKef5IZKAj0ZR9QEO6DM2MXZP
 vhaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7OQ/+0EbMBdDidNRvEcAOQvJtABJD67+zC0HKfSIdWCDG7jwVnVeOoxCm7PSVJIYRbgUtpPlA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyL+zPUWHBd937A4lHeSM/5iY++57fkttrz5+pigj6PWuAYIADi
 L5W31KoAvAPSjyjAIaBQ2lF3uNezzXlB9GL+I0VE9ZEsl1Z4MaUh2CMMvpvQ3TQoRmWd0vs59Bi
 3YWYKkMmMfd3LYvbdVWEtsI3OK3tJ84kEmnu0gJgRq3l/ijMfRfg10Grh+R2hjbUQ03NJsbs=
X-Received: by 2002:a17:906:f596:b0:a99:5773:3612 with SMTP id
 a640c23a62f3a-a9e65507131mr1451662466b.36.1730814503369; 
 Tue, 05 Nov 2024 05:48:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4LMk5LVIghlEylQkdgG/onw741EOAcp2lEz09JpgxOsGJgQkpyK3wtdbLPw1uI2BAZnVvfA==
X-Received: by 2002:a17:906:f596:b0:a99:5773:3612 with SMTP id
 a640c23a62f3a-a9e65507131mr1451660266b.36.1730814502957; 
 Tue, 05 Nov 2024 05:48:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722?
 ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb18137a2sm138651866b.189.2024.11.05.05.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:48:22 -0800 (PST)
Message-ID: <414c9f00-dd15-4d2e-8923-1ac64793becf@redhat.com>
Date: Tue, 5 Nov 2024 14:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] Add panic support for all DCE/DCN
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: yaolu@kylinos.cn
References: <20241031180430.3993389-1-alexander.deucher@amd.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241031180430.3993389-1-alexander.deucher@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 31/10/2024 19:04, Alex Deucher wrote:
> This builds on the patches from Lu and Jocelyn to fill in
> panic support for all DCE/DCN variants and code pathes.
> 
> v2: refactor to provide cleaner history and share more
> code to provide a more consistent experience across
> DC and non-DC.

I wasn't able to build this patchset.

drivers/gpu/drm/amd/amdgpu/dce_v10_0.c:2712:31: error: 
‘amdgpu_display_get_scanout_buffer’ undeclared here (not in a function)
  2712 |         .get_scanout_buffer = amdgpu_display_get_scanout_buffer,
       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.o
make[6]: *** [scripts/Makefile.build:229: 
drivers/gpu/drm/amd/amdgpu/dce_v10_0.o] Error 1
make[6]: *** Waiting for unfinished jobs....
drivers/gpu/drm/amd/amdgpu/dce_v11_0.c:2825:31: error: 
‘amdgpu_display_get_scanout_buffer’ undeclared here (not in a function)
  2825 |         .get_scanout_buffer = amdgpu_display_get_scanout_buffer,
       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[6]: *** [scripts/Makefile.build:229: 
drivers/gpu/drm/amd/amdgpu/dce_v11_0.o] Error 1
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1526:31: 
error: ‘amdgpu_display_get_scanout_buffer’ undeclared here (not in a 
function)
  1526 |         .get_scanout_buffer = amdgpu_display_get_scanout_buffer,


I think there is one patch missing, that should add the 
amdgpu_display_get_scanout_buffer() implementation.

I've built and tested the v1 which works on my 5700XT.

Thanks a lot for implementing drm_panic for all the other dcn/dce 
versions, I was hesitant to do that, because I can't test them.

Best regards,

-- 

Jocelyn



> 
> Alex Deucher (3):
>    drm/amd/display: add clear_tiling hubp callbacks
>    drm/amd/display: add clear_tiling mi callbacks
>    drm/amd/display: add non-DC drm_panic support
> 
> Jocelyn Falempe (1):
>    drm/amd/display: add DC drm_panic support
> 
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  27 +++++
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  27 +++++
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  27 +++++
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  26 +++++
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 103 +++++++++++++++++-
>   .../drm/amd/display/dc/dce/dce_mem_input.c    |  34 +++++-
>   .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  15 +++
>   .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |   2 +
>   .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  15 +++
>   .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   2 +
>   .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |   1 +
>   .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |   1 +
>   .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  17 +++
>   .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
>   .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   1 +
>   .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   3 +-
>   .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   1 +
>   .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  15 ++-
>   .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +
>   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
>   .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   2 +
>   21 files changed, 316 insertions(+), 8 deletions(-)
> 


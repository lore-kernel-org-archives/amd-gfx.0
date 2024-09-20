Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CB4CF9C51
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 15:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC1410E842;
	Fri, 20 Sep 2024 15:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CCfhKMJO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719D710E842
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 15:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726846592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XF81E5q3dcgpsAt6yPTalypggTyS/xoFs7GofpOnUp4=;
 b=CCfhKMJOoX6JAN1rxgmZV0KlK9BiRXbkZm6VnlvBWcap/o+lPAP0QD82MglPUHMD3TDlVJ
 BIE6Ubvsmn1AxGyCgViNQ/qTOm27nweOQWrJ8iPuISMdHvwmLLM+hPrEywkHPVnFCzj18q
 ngE67bQCBHnr3NdgJ1eDhKjDJc2WIgo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-tGp9QoTUNDquFAVGE-tk7A-1; Fri, 20 Sep 2024 11:36:31 -0400
X-MC-Unique: tGp9QoTUNDquFAVGE-tk7A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb2c9027dso16626815e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 08:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726846590; x=1727451390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XF81E5q3dcgpsAt6yPTalypggTyS/xoFs7GofpOnUp4=;
 b=ZOQwglCrVy7Wh2lPnh6TrtJYgET4n/rJdd8g/y94tPzKP5WCvmn6/BqaMJZIQNnAtG
 oU4IdCVRFH1Ciuqy+w1bocLAlDlrz9A9wbWytWbsS5b5mZJ4za1wxEhLKgtV8qSGU8PK
 FScAdwRDieN17bHgwU/R1lNFklKov3kmzKO80iqjs+dR87uuEQ57Dfx4AaDd59UuN9VB
 My6eRLuYQymfwIhBYBbQKj9HX3puugCcVQ6ue7Yb/puByLnuXQdTEaKchqU4ZMF02R1n
 TlJGocvnh5zE4gu4OF6/qp5w3C7ROjyTV7+r6/BBBB7bxabFF4KJndueC962Wa6Jp5Mw
 O/5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCValw4bMvOsQ0cwgqukkxoomMuFg3j/4UISYx+YtevKHnVfXWKAy974KSl/ojAkc5EskZ2nsZuS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHUN+UgY/UlvZsATHYMjyeK5EJJ6R1fCQSeYsHILf/9iMMPqPX
 IMgWd3lj3eVQkirXRerReWUuVosojJRdYc5tzasSfWPB1hk7Iljxdy8JRNlCvKnKblVoDPBN6uW
 yWFfYkscZolmkiB2msEYaDUeJ+6GFdsarfyvKbCI2KE22qWjItei1xAOYJ7ltV90=
X-Received: by 2002:a05:600c:310a:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-42e7ada4d19mr21185505e9.27.1726846589792; 
 Fri, 20 Sep 2024 08:36:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbBnSe6ZeVzt8REAbM4EztjbArVr1o71yxuBniSzhuLu4B6LPEfV+k7lLYBVAZUTUqL6NisQ==
X-Received: by 2002:a05:600c:310a:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-42e7ada4d19mr21185365e9.27.1726846589389; 
 Fri, 20 Sep 2024 08:36:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722?
 ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f9a22sm17878482f8f.61.2024.09.20.08.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2024 08:36:28 -0700 (PDT)
Message-ID: <16352ae0-7e61-440d-8c04-7ec912f9bf9a@redhat.com>
Date: Fri, 20 Sep 2024 17:36:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
To: Alex Deucher <alexdeucher@gmail.com>, Lu Yao <yaolu@kylinos.cn>
Cc: ckoenig.leichtzumerken@gmail.com, daniel@ffwll.ch, Xinhui.Pan@amd.com,
 airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, srinivasan.shanmugam@amd.com,
 sunil.khatri@amd.com
References: <20240802071752.116541-1-yaolu@kylinos.cn>
 <20240812060914.102614-1-yaolu@kylinos.cn>
 <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
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

On 17/09/2024 15:21, Alex Deucher wrote:
> On Mon, Aug 12, 2024 at 2:10 AM Lu Yao <yaolu@kylinos.cn> wrote:
>>
>> Add support for the drm_panic module, which displays a pretty user
>> friendly message on the screen when a Linux kernel panic occurs.
>>
>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> 
> Patch looks good to me.  Any chance you want to convert the other
> non-DC dce files (dce_v8_0.c, dce_v10_0.c, dce_v11_0.c) while you are
> at it?

I've made a similar patch in amdgpu_dm_plane.c, and it works on a Radeon 
pro w6400.
But it only works when I'm in a VT terminal (so the framebuffer is 
linear and CPU accessible).
When under Gnome/Wayland, the flag AMDGPU_GEM_CREATE_NO_CPU_ACCESS is 
set, so that means I can't vmap it ?

Also I don't know if there is a similar way to disable 
tiling/compression on this hardware.

Best regards,

-- 

Jocelyn


> 
> Alex
> 
> 
>> ---
>> Changes in v2:
>> 1. Drop include "drm_internal.h"
>> 2. Add disabling DC tiling ops.
>> Per suggestion from previous thread:
>> https://patchwork.freedesktop.org/patch/606879/?series=136832&rev=1
>> ---
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 48 +++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> index 05c0df97f01d..ba1b7a36caa3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> @@ -28,6 +28,7 @@
>>   #include <drm/drm_modeset_helper.h>
>>   #include <drm/drm_modeset_helper_vtables.h>
>>   #include <drm/drm_vblank.h>
>> +#include <drm/drm_panic.h>
>>
>>   #include "amdgpu.h"
>>   #include "amdgpu_pm.h"
>> @@ -2600,6 +2601,52 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
>>          .get_scanout_position = amdgpu_crtc_get_scanout_position,
>>   };
>>
>> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct drm_plane *plane,
>> +                                                        struct drm_scanout_buffer *sb)
>> +{
>> +       struct drm_framebuffer *fb;
>> +       struct amdgpu_bo *abo;
>> +       struct amdgpu_crtc *amdgpu_crtc;
>> +       struct amdgpu_device *adev;
>> +       uint32_t fb_format;
>> +
>> +       if (!plane->fb)
>> +               return -EINVAL;
>> +
>> +       fb = plane->fb;
>> +
>> +       abo = gem_to_amdgpu_bo(fb->obj[0]);
>> +       amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
>> +       adev = drm_to_adev(fb->dev);
>> +
>> +       if (!abo->kmap.virtual &&
>> +           ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->kmap)) {
>> +               DRM_WARN("amdgpu bo map failed, panic won't be displayed\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>> +               iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual);
>> +       else
>> +               iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
>> +
>> +       sb->width = fb->width;
>> +       sb->height = fb->height;
>> +       sb->format = fb->format;
>> +       sb->pitch[0] = fb->pitches[0];
>> +
>> +       /* Disable DC tiling */
>> +       fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
>> +       fb_format &= ~GRPH_ARRAY_MODE(0x7);
>> +       WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_helper_funcs = {
>> +       .get_scanout_buffer = dce_v6_0_drm_primary_plane_get_scanout_buffer
>> +};
>> +
>>   static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>>   {
>>          struct amdgpu_crtc *amdgpu_crtc;
>> @@ -2627,6 +2674,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>>          amdgpu_crtc->encoder = NULL;
>>          amdgpu_crtc->connector = NULL;
>>          drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_funcs);
>> +       drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_primary_plane_helper_funcs);
>>
>>          return 0;
>>   }
>> --
>> 2.25.1
>>
> 


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA176C369A8
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 08:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8528410E7C1;
	Wed, 25 Sep 2024 08:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="R7FwaUrz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809A310E7C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727253210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZA8VDPtGlvwIthUScFgsavzcHEFuzxlED4I0C6Ur+E=;
 b=R7FwaUrzhQ2x8lwpV9etbXYi68y3i8J8aYoZvgulKl20wYnjxeVuS4wyr1zrlSBRY5eV2z
 hefN2I+1iCr/wNSLffgmQAOqatuc2JYICknwx4CS8yu6grRQkciC0xxTphNvZGZvKxInkQ
 9spacfzrm90LhNSG3k0UywUZFzreswo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-rLWq1CnDPTCkMnuDJxBR4A-1; Wed, 25 Sep 2024 04:33:28 -0400
X-MC-Unique: rLWq1CnDPTCkMnuDJxBR4A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37cc9b5e533so90386f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 01:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727253207; x=1727858007;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eZA8VDPtGlvwIthUScFgsavzcHEFuzxlED4I0C6Ur+E=;
 b=vsEOqS4LPAG2ajwju5ARYNxvNJS2Q3tjo9mcBAOYqHgg6iR47759k1gR0RdNHX79Cw
 YnB+lHoKnZ33LCdMAcJR8m1z8IBihF4bLbEEy5OIsu33j700KRmJNrqcFbOowDVqS/NG
 TkvPfM7IPIRziiv7UmqYFx8akO5DdZvQ+7sozQvu5iHV7QuC1hgemkHml33lCNAUqFB7
 GgwSaNW7xBhi/WF2vDX/y/TdtOSLqp8icuLhQ5nF4M8+6lwAN5MvpIRTtOlHgwUgb/ae
 BediE1GJxOYtv7OEaGagn+tk6nihGMY+CeUNA1TFCijGHU89rymx4i+cWWUXN9G5NZ+R
 GwLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxtTxDEsU5Xyv9xivSoBINM5wWN3X/tTT1MOVtcAVgEx/Xmx6iWbHNV8sp3RvI+MkAffr7J4im@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNQRG9jz1QnxE1XI3SFLQYOYeCNuOh1rOwK2WAyN0YrD3iu+V2
 nXucRqczZnWQCyu3+eVbB32+Yv8vqRJBUXjV1WYN91O35Lflx1C69s8dsK4BPTy0sZuLqKcKx+p
 aepJrUigBtBsDuiXRa3vO/J9gduSgLa1qxfjcO8jXtZntz4SgJmBT8dcn8Ikm83A=
X-Received: by 2002:a5d:452d:0:b0:374:c0c9:d171 with SMTP id
 ffacd0b85a97d-37cc245b7d5mr1365140f8f.1.1727253207422; 
 Wed, 25 Sep 2024 01:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFymhK0jUZ+fPlNh2eTsqndaCWYE8cdqkpijneOQ2sfuibiyEcvSp9O/qZ6iD39XtkpfqBumw==
X-Received: by 2002:a5d:452d:0:b0:374:c0c9:d171 with SMTP id
 ffacd0b85a97d-37cc245b7d5mr1365123f8f.1.1727253207018; 
 Wed, 25 Sep 2024 01:33:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722?
 ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2cece5sm3328624f8f.54.2024.09.25.01.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 01:33:26 -0700 (PDT)
Message-ID: <8a1afe12-4d59-4cbd-aede-fce22f8fb979@redhat.com>
Date: Wed, 25 Sep 2024 10:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Lu Yao <yaolu@kylinos.cn>, ckoenig.leichtzumerken@gmail.com,
 daniel@ffwll.ch, Xinhui.Pan@amd.com, airlied@gmail.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, srinivasan.shanmugam@amd.com,
 sunil.khatri@amd.com
References: <20240802071752.116541-1-yaolu@kylinos.cn>
 <20240812060914.102614-1-yaolu@kylinos.cn>
 <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
 <16352ae0-7e61-440d-8c04-7ec912f9bf9a@redhat.com>
 <CADnq5_O7njHcvu0ejvVPPKF7szsbEQ8oFfHr9GTyD+zAe2EJ8g@mail.gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CADnq5_O7njHcvu0ejvVPPKF7szsbEQ8oFfHr9GTyD+zAe2EJ8g@mail.gmail.com>
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

On 24/09/2024 16:02, Alex Deucher wrote:
> On Fri, Sep 20, 2024 at 11:36 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> On 17/09/2024 15:21, Alex Deucher wrote:
>>> On Mon, Aug 12, 2024 at 2:10 AM Lu Yao <yaolu@kylinos.cn> wrote:
>>>>
>>>> Add support for the drm_panic module, which displays a pretty user
>>>> friendly message on the screen when a Linux kernel panic occurs.
>>>>
>>>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
>>>
>>> Patch looks good to me.  Any chance you want to convert the other
>>> non-DC dce files (dce_v8_0.c, dce_v10_0.c, dce_v11_0.c) while you are
>>> at it?
>>
>> I've made a similar patch in amdgpu_dm_plane.c, and it works on a Radeon
>> pro w6400.
>> But it only works when I'm in a VT terminal (so the framebuffer is
>> linear and CPU accessible).
>> When under Gnome/Wayland, the flag AMDGPU_GEM_CREATE_NO_CPU_ACCESS is
>> set, so that means I can't vmap it ?
> 
> It just means that the application does not need CPU access.  Whether
> or not the CPU can access the buffer or not depends on the size of the
> PCI BAR.  E.g., if the driver or bios has resized the PCI BAR, then
> the CPU can access the entire BAR, but if not you are generally
> limited to the first 256M of framebuffer.

I tried to use ttm_bo_kmap() anyway, it returns a valid virtual address, 
but writing to it has no effect on the display.
> 
>>
>> Also I don't know if there is a similar way to disable
>> tiling/compression on this hardware.
> 
> UNP_GRPH_CONTROL on chips with DCE display hardware and
> DCSURF_ADDR_CONFIG and DCSURF_TILING_CONFIG on DCN display hardware.

Thanks a lot, I will see if I can make this work.
For DCN, it depends on the HUBP version, and I need a pipe_ctx to access 
it. I didn't find how to get a pipe_ctx from the current primary plane.

Best regards,

-- 

Jocelyn

> 
> Alex
> 
>>
>> Best regards,
>>
>> --
>>
>> Jocelyn
>>
>>
>>>
>>> Alex
>>>
>>>
>>>> ---
>>>> Changes in v2:
>>>> 1. Drop include "drm_internal.h"
>>>> 2. Add disabling DC tiling ops.
>>>> Per suggestion from previous thread:
>>>> https://patchwork.freedesktop.org/patch/606879/?series=136832&rev=1
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 48 +++++++++++++++++++++++++++
>>>>    1 file changed, 48 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>>>> index 05c0df97f01d..ba1b7a36caa3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>>>> @@ -28,6 +28,7 @@
>>>>    #include <drm/drm_modeset_helper.h>
>>>>    #include <drm/drm_modeset_helper_vtables.h>
>>>>    #include <drm/drm_vblank.h>
>>>> +#include <drm/drm_panic.h>
>>>>
>>>>    #include "amdgpu.h"
>>>>    #include "amdgpu_pm.h"
>>>> @@ -2600,6 +2601,52 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
>>>>           .get_scanout_position = amdgpu_crtc_get_scanout_position,
>>>>    };
>>>>
>>>> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct drm_plane *plane,
>>>> +                                                        struct drm_scanout_buffer *sb)
>>>> +{
>>>> +       struct drm_framebuffer *fb;
>>>> +       struct amdgpu_bo *abo;
>>>> +       struct amdgpu_crtc *amdgpu_crtc;
>>>> +       struct amdgpu_device *adev;
>>>> +       uint32_t fb_format;
>>>> +
>>>> +       if (!plane->fb)
>>>> +               return -EINVAL;
>>>> +
>>>> +       fb = plane->fb;
>>>> +
>>>> +       abo = gem_to_amdgpu_bo(fb->obj[0]);
>>>> +       amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
>>>> +       adev = drm_to_adev(fb->dev);
>>>> +
>>>> +       if (!abo->kmap.virtual &&
>>>> +           ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->kmap)) {
>>>> +               DRM_WARN("amdgpu bo map failed, panic won't be displayed\n");
>>>> +               return -ENOMEM;
>>>> +       }
>>>> +
>>>> +       if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>>> +               iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual);
>>>> +       else
>>>> +               iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
>>>> +
>>>> +       sb->width = fb->width;
>>>> +       sb->height = fb->height;
>>>> +       sb->format = fb->format;
>>>> +       sb->pitch[0] = fb->pitches[0];
>>>> +
>>>> +       /* Disable DC tiling */
>>>> +       fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
>>>> +       fb_format &= ~GRPH_ARRAY_MODE(0x7);
>>>> +       WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_helper_funcs = {
>>>> +       .get_scanout_buffer = dce_v6_0_drm_primary_plane_get_scanout_buffer
>>>> +};
>>>> +
>>>>    static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>>>>    {
>>>>           struct amdgpu_crtc *amdgpu_crtc;
>>>> @@ -2627,6 +2674,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>>>>           amdgpu_crtc->encoder = NULL;
>>>>           amdgpu_crtc->connector = NULL;
>>>>           drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_funcs);
>>>> +       drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_primary_plane_helper_funcs);
>>>>
>>>>           return 0;
>>>>    }
>>>> --
>>>> 2.25.1
>>>>
>>>
>>
> 


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688CCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 17:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83586FB6C;
	Thu,  2 Dec 2021 17:47:39 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FD26FB6C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 17:47:38 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id r11so1092780edd.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Dec 2021 09:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cVSZBlCHxWwTkWx0nt4V7MOiDWfbl/1JSc8Gj6cp/g0=;
 b=SHi8aKkkpm+WBMHauAR4NYbxg568sWvfIoTTjasbec/Gv+hV9qH11BNEk2X3nWLqUI
 gDHHQtbU2NMv5KiYmSwJ7Jwb2yNMRzP1TFpouRCNNN4+vvNHuzQ86fBAHQJkOVGJZ6Q/
 VrNZSlkV1XVuvvkNMhi+m4OM6TvY7R6XqQfbwxaRZ6/C4DvBh/s8QnoREsL+dpdaps3g
 38ePgbFjJRNO6FX0X/KkN6IKni0kpvNyL2trrH/YXkJP1Unwnkd5yM9av1wBDoTrj4cP
 dQXPoJqNLoZLMAA0SoyG6xddfv4uHxoBHKJzik3NHdNvEOhy5+B07/ICssGapVg/G+AX
 JTRg==
X-Gm-Message-State: AOAM5321tncBsWWhDy3xAGLdLTJrfZmvG3eq57QQf8dYDnrRrQbGDhsr
 W0KwT1L/LC9hoGd2kK/e9nFX0Tb0nO1kRQ==
X-Google-Smtp-Source: ABdhPJy2XzcZ9177qhXZj51FrYa+9gOht9DZL9X6cOqntT6bKYuE8XfCTTXOXoLLqXSDmUEJUsM5hg==
X-Received: by 2002:a17:906:d54e:: with SMTP id
 cr14mr16713423ejc.458.1638467256832; 
 Thu, 02 Dec 2021 09:47:36 -0800 (PST)
Received: from [192.168.0.131] ([176.122.114.46])
 by smtp.gmail.com with ESMTPSA id yd20sm303303ejb.47.2021.12.02.09.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Dec 2021 09:47:36 -0800 (PST)
Message-ID: <2b8890fe-febe-d527-7da9-ae0a2c23d776@kde.org>
Date: Thu, 2 Dec 2021 19:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amd/display: Use oriented source size when
 checking cursor scaling
Content-Language: en-US
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211202121650.2265-1-vlad.zahorodnii@kde.org>
 <20211202125215.25307-1-vlad.zahorodnii@kde.org>
 <c2560a82-a4c6-6913-dc67-d11478f46afd@amd.com>
From: Vlad Zahorodnii <vlad.zahorodnii@kde.org>
In-Reply-To: <c2560a82-a4c6-6913-dc67-d11478f46afd@amd.com>
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
Cc: alexander.deucher@amd.com, contact@emersion.fr, Rodrigo.Siqueira@amd.com,
 xaver.hugl@gmail.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/2/21 16:54, Kazlauskas, Nicholas wrote:
> On 2021-12-02 7:52 a.m., Vlad Zahorodnii wrote:
>> dm_check_crtc_cursor() doesn't take into account plane transforms when
>> calculating plane scaling, this can result in false positives.
>>
>> For example, if there's an output with resolution 3840x2160 and the
>> output is rotated 90 degrees, CRTC_W and CRTC_H will be 3840 and 2160,
>> respectively, but SRC_W and SRC_H will be 2160 and 3840, respectively.
>>
>> Since the cursor plane usually has a square buffer attached to it, the
>> dm_check_crtc_cursor() will think that there's a scale factor mismatch
>> even though there isn't really.
>>
>> This fixes an issue where kwin fails to use hardware plane transforms.
>>
>> Changes since version 1:
>> - s/orientated/oriented/g
>>
>> Signed-off-by: Vlad Zahorodnii <vlad.zahorodnii@kde.org>
> 
> This looks correct to me. I guess it's also not modifying the actual 
> programming position, just the check to ensure that the cursor is going 
> to be unscaled in the correct orientation.
> 
> Would be good to have some IGT tests for these scaled cases to verify 
> atomic check pass/fail assumptions, but for now:

I'd be glad to add the tests, but I would need some assistance. Can we 
continue this conversation in the radeon irc channel (I'm zzag)?

> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> 
> Regards,
> Nicholas Kazlauskas
> 
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 ++++++++++++++-----
>>   1 file changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index a3c0f2e4f4c1..c009c668fbe2 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -10736,6 +10736,24 @@ static int dm_update_plane_state(struct dc *dc,
>>       return ret;
>>   }
>> +static void dm_get_oriented_plane_size(struct drm_plane_state 
>> *plane_state,
>> +                       int *src_w, int *src_h)
>> +{
>> +    switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
>> +    case DRM_MODE_ROTATE_90:
>> +    case DRM_MODE_ROTATE_270:
>> +        *src_w = plane_state->src_h >> 16;
>> +        *src_h = plane_state->src_w >> 16;
>> +        break;
>> +    case DRM_MODE_ROTATE_0:
>> +    case DRM_MODE_ROTATE_180:
>> +    default:
>> +        *src_w = plane_state->src_w >> 16;
>> +        *src_h = plane_state->src_h >> 16;
>> +        break;
>> +    }
>> +}
>> +
>>   static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>>                   struct drm_crtc *crtc,
>>                   struct drm_crtc_state *new_crtc_state)
>> @@ -10744,6 +10762,8 @@ static int dm_check_crtc_cursor(struct 
>> drm_atomic_state *state,
>>       struct drm_plane_state *new_cursor_state, *new_underlying_state;
>>       int i;
>>       int cursor_scale_w, cursor_scale_h, underlying_scale_w, 
>> underlying_scale_h;
>> +    int cursor_src_w, cursor_src_h;
>> +    int underlying_src_w, underlying_src_h;
>>       /* On DCE and DCN there is no dedicated hardware cursor plane. 
>> We get a
>>        * cursor per pipe but it's going to inherit the scaling and
>> @@ -10755,10 +10775,9 @@ static int dm_check_crtc_cursor(struct 
>> drm_atomic_state *state,
>>           return 0;
>>       }
>> -    cursor_scale_w = new_cursor_state->crtc_w * 1000 /
>> -             (new_cursor_state->src_w >> 16);
>> -    cursor_scale_h = new_cursor_state->crtc_h * 1000 /
>> -             (new_cursor_state->src_h >> 16);
>> +    dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, 
>> &cursor_src_h);
>> +    cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
>> +    cursor_scale_h = new_cursor_state->crtc_h * 1000 / cursor_src_h;
>>       for_each_new_plane_in_state_reverse(state, underlying, 
>> new_underlying_state, i) {
>>           /* Narrow down to non-cursor planes on the same CRTC as the 
>> cursor */
>> @@ -10769,10 +10788,10 @@ static int dm_check_crtc_cursor(struct 
>> drm_atomic_state *state,
>>           if (!new_underlying_state->fb)
>>               continue;
>> -        underlying_scale_w = new_underlying_state->crtc_w * 1000 /
>> -                     (new_underlying_state->src_w >> 16);
>> -        underlying_scale_h = new_underlying_state->crtc_h * 1000 /
>> -                     (new_underlying_state->src_h >> 16);
>> +        dm_get_oriented_plane_size(new_underlying_state,
>> +                       &underlying_src_w, &underlying_src_h);
>> +        underlying_scale_w = new_underlying_state->crtc_w * 1000 / 
>> underlying_src_w;
>> +        underlying_scale_h = new_underlying_state->crtc_h * 1000 / 
>> underlying_src_h;
>>           if (cursor_scale_w != underlying_scale_w ||
>>               cursor_scale_h != underlying_scale_h) {
>>
> 


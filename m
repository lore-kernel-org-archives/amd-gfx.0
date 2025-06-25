Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DC7C7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 11:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99EE110E216;
	Wed, 25 Jun 2025 11:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="OnGlByi7";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFD310E216
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 11:39:56 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45377776935so30838765e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1750851595; x=1751456395;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NE1PTD8YCq9/dqNYwhbQI6KwsDe9xmdMHIWyTROO0u0=;
 b=OnGlByi7mKwSB1u5jSUq0Ai+lnDJAqJ7e7jp/J8610jYQwNhgLOIyftV7XNm13ydOk
 yaKauveFlITk3I5fgq5zIUWGnl7vLDTMBMkKnupZGzG2Lq5wj466wPWhqyrIwyL1M74g
 xPfN9TWRvm6Bm05Ss1+AZ27Hkh+gfdZPWoFbOMV8lyVZTte5l5rIo3xpMpkTiCWXndnc
 VuRQlZjreSQg0KymXRgAz/zMTOZdeYuFfAxmdDl84PNjef3thDM2Ag4reIIJbxZoYaUB
 cG13JBF22TAlG+dhW3P1ui7gaxoW2nArKIuRw09XcaLtM2v9bxhchPnmZatvM/IOyyfT
 dmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750851595; x=1751456395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NE1PTD8YCq9/dqNYwhbQI6KwsDe9xmdMHIWyTROO0u0=;
 b=IAiBtbbn7maV4jOfWqXWbwGXgd6EVmRvBILcm527zFcNaxLWlKe1phb45y1SkHnT4o
 cfJrdfomKy68AZGX+KD9hOED1FsWJJ23o1TC1A0A2WDFVz8cgWIWgyxLXWlpEItpI/GP
 HF/V1x5xhNyXy6rXzF3lVlTwGPLMZe2+FRHtSIWS8HvrHDDKo4jNJKBxcvuCvsjJZjzZ
 tHutkcQtEG6a9sWAq0axSP6VSy2zwkSyc4E2HVGbpKVPMYkhJI2owGC8oUCeP65wJYtz
 cEn8UMadbB08oVi4OZZK31xSbzyUsnjpK6QRMkIwDtV/RFWFx6vAYRiQ1IMTgy2Nqltv
 S5KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4PLk+HstlFf+rjU1fnh9n4iSMhYJy2raW7OUvgHPK9EBQmqVv0iyX1NX8L1UPHXq7Q0lukG/K@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzcfyck7FcerXW8oz/6ls+VCRviSbHhHURweBTBznSINFAnDUkb
 B54hQwiVUUGcBwqVNuAL9hyDCYgw9lUspBfQ+cw7VyF6yGhedK+BvoKOgqmbKu2D1sw=
X-Gm-Gg: ASbGncstucuSkUhfx+K2J/uKzsSCB9qrHXIgpr1Cu4Vo89q8k6/6tng/iTHK0xV0b3e
 OihuTOf2urT14J5MCPN1fwB6siLhs2yd84QLafBuFCzKuDTnH3NDSBigPXoiKqU1kYtKInhwdPe
 2n/wM/yVy2nAtwbKw9kTs+Q0lzRkYO3Am2r/Jr7Ps7B6WDO+GrYVTOLyaIemMntKkhxmzWJkCqz
 r7ip8xo1JTkKryGfIVwPhajXEnYGHdX5pRZbvxcaksBoSy23JClfwj9WxrV3IL/1fjNIcMfqGLt
 /XfCiM1g+AZIaj4g8mPklIN5RE1VRiOt/U89PH2eUn7rR1A4zO7a9OgRywvsC5mii0FrnhDF1gU
 WpNJ8hnPNbxI=
X-Google-Smtp-Source: AGHT+IE8lRPbQtEO6DUfjfs2bwS0lk3YW8uRrZrki+XA7cuA1a7Il8FzJ14dpFTKgQZOTEPMibo+Iw==
X-Received: by 2002:a05:600c:a315:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-453822d608bmr17986745e9.5.1750851595170; 
 Wed, 25 Jun 2025 04:39:55 -0700 (PDT)
Received: from [192.168.0.101] ([81.79.92.254])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6fa2sm17491895e9.27.2025.06.25.04.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 04:39:54 -0700 (PDT)
Message-ID: <5ab33079-3533-411e-93f5-b711eaa3f64c@ursulin.net>
Date: Wed, 25 Jun 2025 12:39:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: put ctx's ref count in
 amdgpu_ctx_mgr_entity_fini()
To: "cao, lin" <lin.cao@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Chang, HaiJun" <HaiJun.Chang@amd.com>
References: <20250624091823.3963949-1-lincao12@amd.com>
 <b7fc658e-2778-48dd-8584-3f33bbcc5ab7@ursulin.net>
 <a88d5329-d500-490c-a054-7ed584322e1d@amd.com>
 <PH0PR12MB54971F5A5D9BC332B1BDB9DEF57BA@PH0PR12MB5497.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <PH0PR12MB54971F5A5D9BC332B1BDB9DEF57BA@PH0PR12MB5497.namprd12.prod.outlook.com>
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


On 25/06/2025 03:14, cao, lin wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> 
> Hi Ursulin, Christian,
> 
> I find the upstream patch: https://git.kernel.org/pub/scm/linux/kernel/ 
> git/torvalds/linux.git/commit/? 
> id=dd64956685fa48358c4152d952070c8c073e5f89 <https://git.kernel.org/pub/ 
> scm/linux/kernel/git/torvalds/linux.git/commit/? 
> id=dd64956685fa48358c4152d952070c8c073e5f89>
> 
> May I ask if I can modify the commit msg as:
> 
> drm/amdgpu: Fix memory leak in amdgpu_ctx_mgr_entity_fini
> 
> patch "dd64956685fa drm/amdgpu: Remove duplicated "context still
> alive" check" removed ctx put, which will cause amdgpu_ctx_fini()
> cannot be called and then cause some finished fence that added by
> amdgpu_ctx_add_fence() cannot be released and cause memleak.
> 
> Fixes: dd64956685fa ("drm/amdgpu: Remove duplicated "context still 
> alive" check")
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Acked-by: Christian König <christian.koenig@amd.com>

Looks good to me.

Regards,

Tvrtko

> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Tuesday, June 24, 2025 21:11
> *To:* Tvrtko Ursulin <tursulin@ursulin.net>; cao, lin <lin.cao@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Chang, HaiJun <HaiJun.Chang@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: put ctx's ref count in 
> amdgpu_ctx_mgr_entity_fini()
> On 24.06.25 11:46, Tvrtko Ursulin wrote:
>> 
>> On 24/06/2025 10:18, Lin.Cao wrote:
>>> patch "daf823f1d0cd drm/amdgpu: Remove duplicated "context still
>>> alive" check" removed ctx put, which will cause amdgpu_ctx_fini()
>>> cannot be called and then cause some finished fence that added by
>>> amdgpu_ctx_add_fence() cannot be released and cause memleak.
>> 
>> Ouch I removed the wrong one. :( Probably misread kref_put as kref_read..
>> 
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> 
>> 
>> But is the SHA correct? I see it is dd64956685fa.
> 
> That could be because our internal branch is not yet rebased.
> 
>> 
>> Which would mean adding:
>> 
>> Fixes: dd64956685fa ("drm/amdgpu: Remove duplicated "context still alive" check")
> 
> And maybe CC stable? Or in which release is that patch upstream?
> 
> Regards,
> Christian.
> 
>> 
>> Regards,
>> 
>> Tvrtko
>> 
>>> Signed-off-by: Lin.Cao <lincao12@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index 85567d0d9545..f5d5c45ddc0d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -944,6 +944,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>>>                   drm_sched_entity_fini(entity);
>>>               }
>>>           }
>>> +        kref_put(&ctx->refcount, amdgpu_ctx_fini);
>>>       }
>>>   }
>>>   
>> 
> 


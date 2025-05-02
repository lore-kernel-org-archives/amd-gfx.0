Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C76C3ABAC
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 15:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF4E910E063;
	Fri,  2 May 2025 15:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lcMdl5By";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4EA710E063
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 15:32:48 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6f2b05f87bcso24149126d6.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746199967; x=1746804767; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7U4aCRIusDM1dzUgjeA4fD7PDEbfIbKeUD1riuWUhDs=;
 b=lcMdl5Bywb+R8PXXGE1/63TVikrrNnidbZdLeDJd40rVglirvX/aLZHxtx+l5bOc6g
 rBJwUl4o5OFuITk2maU7ITCPqUunQH8Jqt7Jhbmcd67pKmTODX3uQkRmSGsS1VwOZBSs
 GBhlwv+tgxhn6dDB9WOw/13xUgDyWh6T8yMWT24l8r8sXE22NtX+tXheABp67yCDwvh+
 To6XtBl0ctwjdcd/a4vGydY/CV1bUTMYslT/Z8SpwmPnq0roAl6iTAarKg9FaKhBOi+z
 HOj3yVlA+gsXeRu9sTjb0gAFJkSNe6jtgPmCeeHicpIESgjYTJtu0mm0fJKGsP34dwFH
 ahHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746199967; x=1746804767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7U4aCRIusDM1dzUgjeA4fD7PDEbfIbKeUD1riuWUhDs=;
 b=pUOnSrzUB1WdLMPMJi6khiMTLBkTGwZbg1gMnw2B2Va557rtkhC7PQFAAsRO/1AwVw
 Xq/ZBGSGAPexvWtU2xkoSzxJYzsre27h19ncw4JyfFk/rItQNL8FZ7RssXjHUxhefuR1
 xWNmjIPukAx64lDTfb0afUrZ35tzt+aS9M/yHMuxVmMXkgapiDKVcc1r6hlluIalK2Gj
 u7mZoOILdRdNVTt9Wo6vu0R+fPtJor+mUUp1nsD2hFZDwxaIoPYWOCEcTvEfo1xPQkwG
 auYKwUr3+y2+nPlbdknmaWkIGmDxnsPHD3y+Kt6F3KvPYmBTpf+K1wLJMESzy2OfSjjj
 rGUQ==
X-Gm-Message-State: AOJu0YxdzNE1nC6VPN17lRU9MdmT5+Tvg8onvdDZkmctMHAvb+v3e447
 ynmfQ3u39IuWrz4WXKKFUFwYZsPcxibrvjPgRVntVH6HgkLYaj8F
X-Gm-Gg: ASbGnctkNLLo5r6O01yNNs4fLdXmOFwIgS+Et4eB+1eZSeOouLAbLlQ06Xhv/tp7QaI
 tXwW/tddvSG0SnA5pso0rJxzFv24/UtmS/s2sTINIR6dFm5xf8p2HvmjUENVhQBuu7nfeOlD7Gc
 HWzxy56OQUw53G58HuqO0+RLqSlXhdwVk6JGRl6RP98r3QQhSO/96A+3+EijFOGJgL62MAkQ6Pw
 rChdK3GlXUuSEPPnfKrmZyb8eesr42hsri0/QxHW8EdaE9Fc2IvubizZofZinhMX0sInYcTw8L9
 e2cYrTFcNVPyy+QP0TMWNfnW6/iMwmgEnY3FISVwuWot6VIrew==
X-Google-Smtp-Source: AGHT+IGg2kr9s36CBurCjo3dM1g5Upkr5xGKP9S9kENOMqf6j2JJ7YIWxFoWWBSdBHZIrZgOiU+gyQ==
X-Received: by 2002:a05:6214:1c07:b0:6eb:28e4:8518 with SMTP id
 6a1803df08f44-6f5155bba58mr55219186d6.34.1746199967481; 
 Fri, 02 May 2025 08:32:47 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6f50f44f5bfsm19273926d6.87.2025.05.02.08.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 08:32:47 -0700 (PDT)
Message-ID: <474bf7c1-f42a-4738-8ce0-24fced3b051c@gmail.com>
Date: Fri, 2 May 2025 11:32:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
 <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
 <2150d713-d9bf-400e-b51b-aee835431991@amd.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <2150d713-d9bf-400e-b51b-aee835431991@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/30/25 5:44 PM, Paneer Selvam, Arunpravin wrote:
> 
> 
> On 5/1/2025 2:50 AM, Alex Deucher wrote:
>> + Christian
>>
>> On Tue, Apr 29, 2025 at 7:24 AM John Olender <john.olender@gmail.com>
>> wrote:
>>> The drm_mm allocator tolerated being passed end > mm->size, but the
>>> drm_buddy allocator does not.
>>>
>>> Restore the pre-buddy-allocator behavior of allowing such placements.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
>>> Signed-off-by: John Olender <john.olender@gmail.com>
>> This looks correct to me.
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> I was thinking that we should return an error when lpfn > man->size.
> 
> Regards,
> Arun.

This patch restores the previous behavior in the spirit of "Do not crash
the kernel".  The existing uvd placements are pretty clear in their
intent and were accepted until the switch to drm_buddy.  I think it's
fair to consider their style as expected.

With that in mind, I'm not sure amdgpu_vram_mgr is the place this change
really belongs.  That is, I think it's worth asking:

1) Why does drm_mm accept end > mm->size without complaint?
2) Why doesn't drm_buddy do the same?

Thanks,
John

>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/
>>> gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> index 2d7f82e98df9..abdc52b0895a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct
>>> ttm_resource_manager *man,
>>>          int r;
>>>
>>>          lpfn = (u64)place->lpfn << PAGE_SHIFT;
>>> -       if (!lpfn)
>>> +       if (!lpfn || lpfn > man->size)
>>>                  lpfn = man->size;
>>>
>>>          fpfn = (u64)place->fpfn << PAGE_SHIFT;
>>> -- 
>>> 2.47.2
>>>
> 


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18709C624DB
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E8310F42E;
	Thu,  3 Sep 2026 07:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lWPFfqjv";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DDD310F2BE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 16:23:48 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso12786205e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2026 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788366227; x=1788971027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1N19Tlo/HZAKhPdr7ampF9wlM1CbFMGUBMOsaJtVD7A=;
 b=lWPFfqjvg+KTiH7DmTTet/7tXGwVcv2E9GD1FA+sMnafbvgg1I8P6wFaBecbFbkYdo
 fMTwznFg4npNPkQjRj9U7j8fzjwDegd72I4w5lgLZSZpr2ROiLShfr8mVWeVPoUsCFHM
 5pk1zhD4D1F70Nk4QlrufFcsS+Vzsom8tRhqjcE1XvIPdMiEGdDenRMMc246GJeqvbxW
 FNAlBTf2LZFvG8DjWDgqaftTQO7ThfKg7ohjkwEpWMnDmcvs/T1g0obcDhuSoii6ZT15
 7EnwwYKCv6HuM9HdRd3Sk3YuMJkDdWJjyOGXx7wUXIi3FzsB1pAZz1eYJpbHyjMEKh/R
 XF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788366227; x=1788971027;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1N19Tlo/HZAKhPdr7ampF9wlM1CbFMGUBMOsaJtVD7A=;
 b=LzD9HbM0Yl5n2C2+vgfNQZdiqaNHdAA+2ui5qDKbRVW6lVLhUOOGACjbfqU9At1+Vn
 fJh9v4Mh5vlM3yoTeHSY0pQNznv0TFHT7ptd+Hv3j5m4EV4h8cfA16VDBJYlWKxNZfFP
 H56Vhn7qhFi+LS8eYETakcMCSu5MLVCHQIJ6NyFyeuyAdtXvTaFyG7ftyvX3sbXE3TyP
 T46rX105oy9ZDkefN1AB1boi6oSyoToyntYP9giarVkktWtdQMAle5XWOiHxdNGYqzrm
 CcCFiYVD61KgEAYFAslZbHMK0IG8ECunDiLWtiQozPsRUv9CLHZLBYde2kbkA/cn1tMm
 rAdg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrN3LbdndyJSQdvOWOswprYfP9wl4yS8NQOSqUB3pLgkvZK0ZCGhdASyUOqKotCkWnB+61X6FCp@lists.freedesktop.org
X-Gm-Message-State: AFuF++ms1rqL9XnazKuW53GUEqh6ljmzWobHmErfymy+ksY28GXr0zBy
 xAYK1UoCG+wd3SJ6KE0uPlcvKX3caPSDMUBy30cIVqZ4C7GER1FtEs0w
X-Gm-Gg: AR+sD12cKo63K0dYBoF+V1zsMzmQtbwJdgbHT3CjDXh+XjeTn1N4xsyv+Brfrw3Vr4N
 N0I6epfrKUBgliDDD62ZnE32s6OTdqxzw1ijOM62drD8Dnk5MSDhCkoxyx4DVLPEt39jW6zMJMu
 JE6myBs7+SSsl+dsWhIkRTZPMBivxA7gD58i1IwzTMg1sMzit2uYSS4mmOIBbfdrVLjRvnwLhaM
 +AtzRB9LFBING4kxz8pCYIr6ZXk6Bp1fPhkg/IoQvMhXgmmPYrrqiQJa/63q6iWMCL1A1ULAQxM
 l+CxhkOXplW+tPHwA9grvdWGIk2CEt6HNf2v5tRbrMAiYpyde5ZuLQ/zPYWGSfcdMN3H7pioYsb
 p+5KKeKILeVSnU65OJ1y+6mLOUryq+TdVowRsTlRoLgnQeLqZe5b+Z4F8YKecvbuYQXKPQC7s/e
 JHIIh7raL4ZIlaj8ilmU8+e5Wdt4oxXdStWSEE2LVHbUYKeVRdZ8i17sB0vWdhYtY9r0IW3Zk/1
 p0MYB1j6CnsnZJG1nBUu3vgMcspsnKO6AmzQi6pFJrykW4Mu9MeZbwmCp8LNv1XbN8Dx3qtouGz
 VmhxCLUhFzfPYcjzmObev24kHampRyXiInZ/Mlr16s6LG0SZb517iCG0Mg==
X-Received: by 2002:a05:600c:8b05:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49ce5817bfemr136244235e9.6.1788366226723; 
 Wed, 02 Sep 2026 09:23:46 -0700 (PDT)
Received: from [192.168.168.11] (a109-50-200-65.cpe.netcabo.pt.
 [109.50.200.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm2104795e9.15.2026.09.02.09.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 09:23:46 -0700 (PDT)
Message-ID: <1aeed63d-c7ee-426b-977f-af00a309987a@gmail.com>
Date: Wed, 2 Sep 2026 17:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] drm/amd/display: passive VRR
To: Fangzhi Zuo <jerry.zuo@amd.com>, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20260901191251.2653684-1-jerry.zuo@amd.com>
Content-Language: en-US
From: Adolfo <adolfotregosa@gmail.com>
In-Reply-To: <20260901191251.2653684-1-jerry.zuo@amd.com>
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


I tested these patches in conjunction with the HDMI 2.1 VRR ones on 
kernel 7.3-rc1, and VRR still does not engage while on the desktop, only 
in-game.


On 01/09/2026 20:12, Fangzhi Zuo wrote:

> Passive VRR keeps a sink in its variable-refresh state during fixed-refresh
> (desktop) use, avoiding the blanking/brightness flicker that HDMI sinks
> without seamless VRR transitions show on VRR entry/exit. It is opt-out
> (enabled by default where the connector advertises passive_vrr_capable) and
> is not useful for DP/eDP, where seamless VRR transitions are mandated by the
> standard.
>
> Patch 1 adds the DRM core plumbing: the PASSIVE_VRR_DISABLED atomic CRTC
> property and the immutable passive_vrr_capable connector property, with the
> attach/set helpers.
>
> Patch 2 wires these into amdgpu via the existing DC
> stream->freesync_on_desktop path.
>
> Patch 3 fixes the MCCS FreeSync fallback so that HDMI-Forum VRR (HF-VSDB)
> sinks keep freesync_capable; without it passive VRR never engages on the
> very TMDS HF-VSDB sinks it targets.
>
>
> Fangzhi Zuo (1):
>    drm/amd/display: Keep FreeSync for HF-VSDB VRR sinks in MCCS fallback
>
> Tomasz Pakuła (2):
>    drm: Add passive_vrr properties for passive/desktop VRR
>    drm/amd/display: Use passive_vrr properties in amdgpu
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   | 13 +++-
>   .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  7 ++
>   drivers/gpu/drm/drm_atomic_uapi.c             |  4 +
>   drivers/gpu/drm/drm_connector.c               | 73 +++++++++++++++++++
>   drivers/gpu/drm/drm_crtc.c                    |  2 +
>   drivers/gpu/drm/drm_mode_config.c             |  6 ++
>   include/drm/drm_connector.h                   | 15 ++++
>   include/drm/drm_crtc.h                        |  9 +++
>   include/drm/drm_mode_config.h                 |  6 ++
>   10 files changed, 134 insertions(+), 2 deletions(-)
>
>
> base-commit: 8c77d618886a143de5cd87a35963b4993075802a

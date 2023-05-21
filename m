Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B46EC77B75
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 07:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A21C610E254;
	Mon, 22 May 2023 07:20:20 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7939810E083
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 May 2023 00:03:14 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f3a611b3ddso2714017e87.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 May 2023 17:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684627392; x=1687219392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hzuHTgVFvJOcibg5XLms2snXPUj1XRLOS2dGHZrGZ9w=;
 b=de+9pEzv+V+RtnsauZw1xJ6xg3xowMNpYhR2hrMHrnN5DwuHS53a/6mYf3PqexfLDE
 RmrA2Q1Evv0OP57PG0lL7CptzD1/v+W6Ui+nhQg3eOzfYJi3E1B+Nl/i0L1ES4GWMT8f
 hKQ6Gny7a2IG1sUuaXzRAkjqj425vczlNPoNuYao4FDu0bDB6aHhHifRiA+cbZ6Dp5dL
 RxXrYhFBElafPjSMSfWd3B42NflJBjfdFsI70JRdiGFsK5LLXgQuRfj6NtUmJvfqTAZk
 8ZlXl8RV+FdQ5aW0+FzdsRL+MjC9E0sLOjKiSK+uc9xK5OjdQfAumgrB4VV3YZxgt4cK
 AIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684627392; x=1687219392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hzuHTgVFvJOcibg5XLms2snXPUj1XRLOS2dGHZrGZ9w=;
 b=egQdjOMs/h8aVi8KIoJvILXTf1meFtYIT+hbnSZfuZm56hdJ0qRVQx711rsoSdMJZs
 d9aJ08ohW9bi3GlAIuUXPI2EIXPF1X7x3+KJ2fQwoXGnzBv+6WtO682Bdk7TtdyBfRAQ
 YiLciReEAC1B9IDzXi/C8uei1XG72s10hu8tt7JgJ9AvTw+Ik+C2wh9hrbNIPDP1lXuo
 huStZO7LW6+VaOVYpUnHJehgZgDg+b62CcHLjKBwsziR2Ej7Ns6/9PmqfpxRoXzhYsYY
 UMHkCyXkJSVG5vW5mqPdkWiYrLwnBLtNGruRmv4gkiRjKUdjqSsSzhIfhOoJVmp6hOZX
 J6vA==
X-Gm-Message-State: AC+VfDxfPVl8JhpjbYqVegB43/JoAguFwHasB3sjCM726k9g0T1/sH5f
 GLKyW+xO9iGyJB3LOGqoHwjoSw==
X-Google-Smtp-Source: ACHHUZ4inqGzFl0yu2BA3Hvm7A2976kcqcOuiyRPVgeqFJjRLVRuHQcUW5BDIw84DZ989za7vayVVQ==
X-Received: by 2002:ac2:4c49:0:b0:4f0:74:61a0 with SMTP id
 o9-20020ac24c49000000b004f0007461a0mr2566610lfk.0.1684627392247; 
 Sat, 20 May 2023 17:03:12 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5?
 (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
 by smtp.gmail.com with ESMTPSA id
 c28-20020ac2531c000000b004f38411f148sm418378lfh.84.2023.05.20.17.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 May 2023 17:03:11 -0700 (PDT)
Message-ID: <da1f7aa1-f560-31f4-6114-e400f35d325b@linaro.org>
Date: Sun, 21 May 2023 03:03:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/9] drm: fdinfo memory stats
Content-Language: en-GB
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
References: <20230515143023.801167-1-robdclark@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230515143023.801167-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 22 May 2023 07:20:19 +0000
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
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Akhil P Oommen <quic_akhilpo@quicinc.com>, Lijo Lazar <lijo.lazar@amd.com>,
 open list <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Rob Clark <robdclark@chromium.org>, Guchun Chen <guchun.chen@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Sean Paul <sean@poorly.run>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>, Jim Cromie <jim.cromie@gmail.com>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Peter Maucher <bellosilicio@gmail.com>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Christopher Healy <healych@amazon.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 freedreno@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 15/05/2023 17:30, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Similar motivation to other similar recent attempt[1].  But with an
> attempt to have some shared code for this.  As well as documentation.
> 
> It is probably a bit UMA-centric, I guess devices with VRAM might want
> some placement stats as well.  But this seems like a reasonable start.
> 
> Basic gputop support: https://patchwork.freedesktop.org/series/116236/
> And already nvtop support: https://github.com/Syllo/nvtop/pull/204
> 
> I've combined the separate series to add comm/cmdline override onto
> the end of this, simply out of convenience (they would otherwise
> conflict in a bunch of places).
> 
> v2: Extend things to allow for multiple regions other than just system
>      "memory", make drm_show_memory_stats() a helper so that, drivers
>      can use it or not based on their needs (but in either case, re-
>      use drm_print_memory_stats()
> v3: Docs fixes
> v4: use u64 for drm_memory_stats, small docs update and collected
>      Tvrtko's a-b
> 
> [1] https://patchwork.freedesktop.org/series/112397/
> 
> Rob Clark (9):
>    drm/docs: Fix usage stats typos
>    drm: Add common fdinfo helper
>    drm/msm: Switch to fdinfo helper
>    drm/amdgpu: Switch to fdinfo helper
>    drm: Add fdinfo memory stats
>    drm/msm: Add memory stats to fdinfo
>    drm/doc: Relax fdinfo string constraints
>    drm/fdinfo: Add comm/cmdline override fields
>    drm/msm: Wire up comm/cmdline override for fdinfo
> 
>   Documentation/gpu/drm-usage-stats.rst      | 101 ++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  16 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |   2 +-
>   drivers/gpu/drm/drm_file.c                 | 147 +++++++++++++++++++++
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  24 +++-
>   drivers/gpu/drm/msm/msm_drv.c              |  15 ++-
>   drivers/gpu/drm/msm/msm_gem.c              |  15 +++
>   drivers/gpu/drm/msm/msm_gpu.c              |   2 -
>   drivers/gpu/drm/msm/msm_gpu.h              |  10 ++
>   include/drm/drm_drv.h                      |   7 +
>   include/drm/drm_file.h                     |  51 +++++++
>   include/drm/drm_gem.h                      |  32 +++++
>   13 files changed, 378 insertions(+), 47 deletions(-)

What is the expected merge plan for this series? msm-next? drm-misc?



-- 
With best wishes
Dmitry


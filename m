Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF18C47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 09:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36DCA10E560;
	Tue, 23 Jan 2024 09:29:37 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC26510E0CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 09:29:35 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-40eb2f3935eso8426975e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 01:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706002114; x=1706606914; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kw4Srobn+f1O7VL878FXWvTuM60WtZXWiD2XR6BnhL8=;
 b=BLJIW9U5ALNN1qplcD1+x4l+GGU7fc9eaQPXGUEokcmZAL5/d5e46pyay7XsYsCV1B
 9FA297wmwfdoVBUgmmDYhb2RG3y9FBsCR37WnRZ2LMldsT/brIm0zKZA9b9R1n2V1dr0
 WhnHQKC/LzSLehitxZtdvjHSJB3Du6Big5Ridpdv7gGWFFjnJCz46dBX8/KfCOMPsCTO
 Kz7KrnhmT8cfpgjr+XJZi7LOnSIDjLosD2cBHvgfrlYnchU9TEULxXVXw3jAzRWTCQWY
 7rvmKy56wB0XwXjuX8hRa9IxBciS2Vo+XHBu8+Mj3+aYcgXsteH4SHO1gUHb77V7uTHK
 Kx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706002114; x=1706606914;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kw4Srobn+f1O7VL878FXWvTuM60WtZXWiD2XR6BnhL8=;
 b=OcZP3T+AsbWx8b61UTbjO+Xe0hZ3dfOH0csSEowkZs0k9DVJfLuHndn3jFcSbJOJkc
 O8NoW/2f/BF5w+cM8Zd42kn5tKrwZGe+J1hOuTPMtvN5699fssuu0tY76KTtJ/XUGXde
 CFg96UKLyTn9H9/LBCWyZZgHHuDkhzm1cElNuiYEeHjZURINdWahoAbppGRQKeq4YacF
 OG3u2KDU/QfPtXHNHbmcqTv1h9MehSyRZfT5BdKXrll+K/bHc2TjBhUsoTjcIcuGaiH4
 UhWmup6QCKKYCAh2xrU0DDhpGJ/tAWqPiTKjo14EUGIpdRh6hbCqSYoy9xcMyUuK13l2
 g+5A==
X-Gm-Message-State: AOJu0YzMF0rE1AU1eqfd2EuMthVHhc1fg9xXeXQszm6lc74szfdydEsW
 LLJZrtTwrZm1LaQGripPUYu9+wqLkRHaadjrfqJJAv06gdn4x1BVEihNZ5vU
X-Google-Smtp-Source: AGHT+IFFuGMJJjgVFzCcyEikeVyYKjgt0oO1Ilt53tB5LstuA8CohaGKcGPm7HSUivwILnFmNrmp4w==
X-Received: by 2002:a05:600c:4e50:b0:40e:7f2c:9dbd with SMTP id
 e16-20020a05600c4e5000b0040e7f2c9dbdmr373419wmq.13.1706002114078; 
 Tue, 23 Jan 2024 01:28:34 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c1d9300b0040eb6cdcbdbsm1710314wms.14.2024.01.23.01.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 01:28:33 -0800 (PST)
Message-ID: <57798354-836c-40cd-a592-d428d768811b@gmail.com>
Date: Tue, 23 Jan 2024 10:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Expand and improve AMDGPU documentation
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.01.24 um 22:24 schrieb Rodrigo Siqueira:
> This patchset improves how the AMDGPU display documentation is
> organized, expands the kernel-doc to extract information from the
> source, and adds more context about DC workflow. Finally, at the end of
> this series, we also introduce a contribution section for those
> interested in contributing to the display code.
>
> Changes since V1:
> - Remove unprecise information about the DC process.
> - Expand the contribution list.
> - Rebase.

Acked-by: Christian König <christian.koenig@amd.com> for the whole series.

>
> Thanks
> Siqueira
>
> Rodrigo Siqueira (8):
>    Documentation/gpu: Add basic page for HUBP
>    Documentation/gpu: Add simple doc page for DCHUBBUB
>    Documentation/gpu: Add kernel doc entry for DPP
>    Documentation/gpu: Add kernel doc entry for MPC
>    Documentation/gpu: Add entry for OPP in the kernel doc
>    Documentation/gpu: Add entry for the DIO component
>    Documentation/gpu: Add an explanation about the DC weekly patches
>    Documentation/gpu: Introduce a simple contribution list for display
>      code
>
>   .../gpu/amdgpu/display/dcn-blocks.rst         |  78 ++++++
>   .../amdgpu/display/display-contributing.rst   | 168 ++++++++++++
>   .../gpu/amdgpu/display/display-manager.rst    |   3 -
>   Documentation/gpu/amdgpu/display/index.rst    |  78 +++++-
>   drivers/gpu/drm/amd/display/TODO              | 110 --------
>   .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   6 +
>   drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  26 ++
>   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  13 +-
>   drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 250 ++++++++++++------
>   drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  16 ++
>   .../amd/display/dc/link/hwss/link_hwss_dio.h  |  10 +
>   11 files changed, 560 insertions(+), 198 deletions(-)
>   create mode 100644 Documentation/gpu/amdgpu/display/dcn-blocks.rst
>   create mode 100644 Documentation/gpu/amdgpu/display/display-contributing.rst
>   delete mode 100644 drivers/gpu/drm/amd/display/TODO
>


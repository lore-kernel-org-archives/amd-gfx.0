Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9073DC6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A58510EB90;
	Thu, 15 Sep 2022 17:13:10 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63CD010EB90
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:13:05 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so43553670ejb.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=JmseKwbHx602XAPbF+E2me7xH15foMjDJ5CnjoljVQo=;
 b=KGqXJINX6MY4dCjPj4Ys9oWQNXVp5fChIl98oS6DkTz0/HeEKedl5jlVOxG/R+Yxwp
 tLSp6063aYWCFBcom7nWAgfv3GJTjcB6XhLATTZImowLnWQwIBcY8Fr1Qp96YJyz35a9
 ND6JKTAvdTUgjLMfPGwC3PJ+bKGKJq5wE/qnToZaz0rNiK+UZ29GbYmQuyNJ1+duTUkK
 joXaolSdd5+466fgHTd2D7but3r/R04iLkKxxig1rQ2ULqRKCjf84pFoPk2oVns8gNu4
 og6w8RzI/ikXZ5sjoCfdoTbmp+bTW5oaQaHyDVebJZnAyQP5yUhh4yDdoQLR8f/++Bv2
 WW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=JmseKwbHx602XAPbF+E2me7xH15foMjDJ5CnjoljVQo=;
 b=aW/AVSwc7/drxUQgST7UvYm5P37gT4EDeB9Ezovk63cZq6wVDv8dGto4tG3hDpZaxI
 +IU7S8w7t86+/TjII9cNJCKFTguXkuhJG3/WHGhAqJLRndpclaSI1b37PlKeEcywnuhN
 3Usq0P44zJu+Q9TF5OJcEv0gZ3AaGhYU14enrAbmggLuWIV20QigT/7FrMsF0m/L+gkV
 cM8+LwAWwQ1pQOrXIWVqwLsVyEwCzxrtjfAITRinyVvCuW/rV1UvVecmZBEZxpR85256
 NaiSwmLhfN6GoQc+k3WoFy0JIxvzJ8p7rutBlo7ITRfnV1j7xLSHeA3MMkR8XOiqPjmS
 bPMg==
X-Gm-Message-State: ACrzQf0QBtSa+lc+Jiu2FwCs3i4QS5guJeJQXmtnZCNjmNon/Ngzr/iy
 8/18nxMu/ATBwq+7HKHCkDQ=
X-Google-Smtp-Source: AMsMyM493McqjgLPM0wEVtNUByT4IuI/RCy/l8HDedC9qg2OlPaPNxa+Nc/anDGqnLQOe+l2hbd5lQ==
X-Received: by 2002:a17:906:9b83:b0:730:b3ae:343 with SMTP id
 dd3-20020a1709069b8300b00730b3ae0343mr682646ejc.670.1663261983783; 
 Thu, 15 Sep 2022 10:13:03 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:ebab:c56b:20c:6343?
 ([2a02:908:1256:79a0:ebab:c56b:20c:6343])
 by smtp.gmail.com with ESMTPSA id
 kv24-20020a17090778d800b007707fc31b8dsm9232278ejc.26.2022.09.15.10.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Sep 2022 10:13:03 -0700 (PDT)
Message-ID: <3c024253-c3f9-e6df-d475-16aa1f5b42a5@gmail.com>
Date: Thu, 15 Sep 2022 19:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/10] switch to common helper for rlc fw init
Content-Language: en-US
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Likun Gao <Likun.Gao@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220915170135.23060-1-Hawking.Zhang@amd.com>
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

Nice cleanup, feel free to add an Acked-by: Christian König 
<christian.koenig@amd.com> to the whole series.

Regards,
Christian.

Am 15.09.22 um 19:01 schrieb Hawking Zhang:
> Replace IP specific implementation with common rlc helper
> for rlc firmware initialization.
>
> This also helps reduce duplicated code when introduce new
> ip block support.
>
> Hawking Zhang (10):
>    drm/amdgpu: add helper to init rlc fw in header v2_0
>    drm/amdgpu: add helper to init rlc fw in header v2_1
>    drm/amdgpu: add helper to init rlc fw in header v2_2
>    drm/amdgpu: add helper to init rlc fw in header v2_3
>    drm/amdgpu: add helper to init rlc fw in header v2_4
>    drm/amdgpu: add helper to init rlc firmware
>    drm/amdgpu/gfx8: switch to amdgpu_gfx_rlc_init_microcode
>    drm/amdgpu/gfx9: switch to amdgpu_gfx_rlc_init_microcode
>    drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_init_microcode
>    drm/amdgpu/gfx11: switch to amdgpu_gfx_rlc_init_microcode
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 264 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |   4 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 191 +----------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 156 +-------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  60 +-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 106 +---------
>   6 files changed, 289 insertions(+), 492 deletions(-)
>


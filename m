Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3ABAC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 16:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418D110E590;
	Wed, 24 May 2023 16:12:02 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F2DD10E4DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 16:12:00 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso760061f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684944718; x=1687536718;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=k72tOLHNx9m56BXts73JUfuZbFrbujBUrTnehtgDexQ=;
 b=EtUy1cT338QhJ12TcFnp4j/CEuWv4Yt8jNNXowheZkIKoGi9WlZzNh0xDPDTWoMoZF
 AXBqX7soBwzGywtMChbffgU6DKKeKQCq+EBqimBte3QJLQV8wawUdTFpAB4rAVPJxYGM
 IIvm3K3uaJjas73TUnERcMICPokNky1JbBvie2mjaTh6TtIC2qeR9Fohgh1563uI84ff
 CQo1kKdnhAuyAHong+zSvjmeNs/mtplC7GQlK36bX/Ffi1mEdl22qrqH2wVGGC/N8fut
 Si0wa9LslXA//MwsEhc2/0vfkOxC47LHpN4S8MReA6rN+WtPTta11s/kPgqTjHQiBAuC
 DXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684944718; x=1687536718;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k72tOLHNx9m56BXts73JUfuZbFrbujBUrTnehtgDexQ=;
 b=hB3eMH6vI6P3ekxVZUAhx5fFBDZKn9lYIDTqZi8J7UgdAsiA+MqQcPHYzLgJcPXbNC
 nz1YGd24qIt2MYScP/B8CkBtAVOvtxIYCHAX1UdM1bwG3ww+uZk4RGKiYSGPHUeVZU1Z
 ph1MF6jfL4feN8yTeC4gSmGD+byWQIVb4s/AURaKILoIfNp8ozdcGotdTWjHCAjaWsML
 k/ptLhJqrIy2BlC5prvGvQDojkng/r7WYC0g1NELBnqwYQ4Dwf8cU272r70QaKsbBUOC
 hdbJij+xofzMLdiiVgIIqgbDZCfwrFS0/EU+uMp2nE66DrsR56Uejgtuj/sadK0NCu1t
 ow1g==
X-Gm-Message-State: AC+VfDwRgDJvOW6O5Xa7KH8HrmxZns9OYJqkAy2mtSIf49yTMbVK5n0o
 l0Xr7W97K4Vw+swccE9xB0NbJw==
X-Google-Smtp-Source: ACHHUZ7yzSRYJcrJoJX1pJvtfP6AqsaU7Xxlwr8toSEa+a55GzhttWpC2GloIzGWvYf5g3l7Wu+/rg==
X-Received: by 2002:a5d:604f:0:b0:309:e24:57aa with SMTP id
 j15-20020a5d604f000000b003090e2457aamr209929wrt.19.1684944718139; 
 Wed, 24 May 2023 09:11:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:39c7:394c:5a3:4047?
 ([2a01:e0a:982:cbb0:39c7:394c:5a3:4047])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a056000104e00b00307b5376b2csm14807613wrx.90.2023.05.24.09.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 09:11:57 -0700 (PDT)
Message-ID: <9a489856-436f-0c7b-9bfc-2336d26ad403@linaro.org>
Date: Wed, 24 May 2023 18:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: (subset) [PATCH v4 0/9] drm: fdinfo memory stats
Content-Language: en-US
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
References: <20230515143023.801167-1-robdclark@gmail.com>
 <168494461551.3403386.4095735722928777312.b4-ty@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <168494461551.3403386.4095735722928777312.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linux-doc@vger.kernel.org, Akhil P Oommen <quic_akhilpo@quicinc.com>,
 Lijo Lazar <lijo.lazar@amd.com>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Rob Clark <robdclark@chromium.org>, Guchun Chen <guchun.chen@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org,
 Chia-I Wu <olvaffe@gmail.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 linux-arm-msm@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Sean Paul <sean@poorly.run>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>, Jim Cromie <jim.cromie@gmail.com>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Peter Maucher <bellosilicio@gmail.com>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Christopher Healy <healych@amazon.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 freedreno@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 24/05/2023 18:10, Neil Armstrong wrote:
> Hi,
> 
> On Mon, 15 May 2023 07:30:07 -0700, Rob Clark wrote:
>> Similar motivation to other similar recent attempt[1].  But with an
>> attempt to have some shared code for this.  As well as documentation.
>>
>> It is probably a bit UMA-centric, I guess devices with VRAM might want
>> some placement stats as well.  But this seems like a reasonable start.
>>
>> Basic gputop support: https://patchwork.freedesktop.org/series/116236/
>> And already nvtop support: https://github.com/Syllo/nvtop/pull/204
>>
>> [...]
> 
> Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
> 
> [1/9] drm/docs: Fix usage stats typos
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0020582a8afe9a8570f80ec503c59bf049a616de
> [2/9] drm: Add common fdinfo helper
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3f09a0cd4ea3b9d34495450d686227d48e7ec648
> [3/9] drm/msm: Switch to fdinfo helper
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=51d86ee5e07ccef85af04ee9850b0baa107999b6
> [4/9] drm/amdgpu: Switch to fdinfo helper
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=376c25f8ca47084c4f0aff0f14684780756ccef4
> [5/9] drm: Add fdinfo memory stats
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=686b21b5f6ca2f8a716f9a4ade07246dbfb2713e
> [6/9] drm/msm: Add memory stats to fdinfo
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3e9757f5ddb98238226ad68a1609aa313de35adb
> [7/9] drm/doc: Relax fdinfo string constraints
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=90d63a150b85fd1debb9c01237fb78faee02746a
> 

Hmm no idea what happened, but I really applied v5 !

Neil

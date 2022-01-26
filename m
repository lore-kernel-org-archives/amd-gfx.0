Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77923C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 11:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0043210E36C;
	Wed, 26 Jan 2022 11:54:51 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BFB10E36C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 11:54:50 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 i187-20020a1c3bc4000000b0034d2ed1be2aso3597327wma.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 03:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ZXjeQERqvFzlCzz2ruulYh5WcBs9abTexvrOjz95g6o=;
 b=PV4AjS5DsN1xxLRiYI2l/0g2bhbvMNviJJfB8wGDYg7uvK2YPkAwbd+c3NCWzkgBmX
 xHFtDtDa5osDOVx6LQNNGdUIUiZ+O4nT7Y0bgQr7xXZazRqASKe5AJ/ZZ5BGDMVthkmO
 GRY527Aw8zy9Sy5HX9B8P+VY6PyT/1XSvRFQBqCGdNu34Um+tHbSsZDmcPAP//hRk9pz
 ejINUkmQmlGa+jbtNIr8lTVKE600Nc9jgtbQGAJsSI4b+YbWC2E6b5BBCDqo/qvAbIoG
 0DLkU0OxTOxjmiXqqRTVftqp30lmPN+W9fEMlgIWFd/3jpNne8qjtYedPyF/FdvFITUH
 Tw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ZXjeQERqvFzlCzz2ruulYh5WcBs9abTexvrOjz95g6o=;
 b=XICiGVKXuQPzaE91PL5o/AgNZXH1rG2xikK8EGmdCylVZgp9tvsbtZ3GHowCOWAS7D
 FuGxYEXhmrVciwJw57DQLPqPM/goY9weJhkWjU1liimytvsIsWpEw9s3PVS+JgN+Hijj
 Dt5Rbt2lVusRRaHS8HorgBorWmZzYU/r6SuWbeBAArkW1qUh3uffU6zKErTs1eQVgxvj
 zrr/M9OIhS0un5CwIYiIqftUGoJ9+Rp0sxXGtgme+UhnOvZvWQOcOTv+z298Jjr8ou8f
 WMUQ/RsuoxB3V6eWVVlUq6jFZNhxRgkFKYS52kCm9uXF4MqB4QONhozD1iJ0a+j3xAdH
 I7tw==
X-Gm-Message-State: AOAM530u/e9OSOEwGFSGSfuBkGSD4wIPJB85p+KvXPX2v3m73xt7zZcT
 NmQoTKZykBrZglk1yZZp96M=
X-Google-Smtp-Source: ABdhPJz0sYTU93F9TAlBQs4wCIm1lByxQB8czXwaFqb0nOTUP3MNcHAF30mdQWUwXdF9xWSbLdcxuA==
X-Received: by 2002:a05:600c:b58:: with SMTP id
 k24mr6327025wmr.6.1643198089054; 
 Wed, 26 Jan 2022 03:54:49 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:6cbd:23a3:7abe:f6e2?
 ([2a02:908:1252:fb60:6cbd:23a3:7abe:f6e2])
 by smtp.gmail.com with ESMTPSA id 16sm2933354wmj.12.2022.01.26.03.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jan 2022 03:54:48 -0800 (PST)
Message-ID: <ef5aa6ef-4fc7-cb7c-019e-01cd77ec0c84@gmail.com>
Date: Wed, 26 Jan 2022 12:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220126075326.1134770-1-Lang.Yu@amd.com>
 <fd878564-3f15-ba76-83f1-42284782e7d5@gmail.com>
 <YfEqQHHo3SGxDJUW@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YfEqQHHo3SGxDJUW@lang-desktop>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.01.22 um 12:02 schrieb Lang Yu:
> On 01/26/ , Christian König wrote:
>> Am 26.01.22 um 08:53 schrieb Lang Yu:
>>> We observed a gpu hang when querying mmhub CG status(i.e.,
>>> cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
>>> skillfish doesn't support any CG features.
>>>
>>> Only allow asics which support CG features accessing related
>>> registers. Will add similar safeguards for other IPs in the
>>> furture.
>> I think you should probably add a macro or function for this check, apart
>> from that looks good to me.
> Thanks for you advice. Is it fine to use such a macro?
>
> #define amdgpu_device_cg_flag_isset(flag) ((adev->cg_flags) & (flag))

No, first of all that can also be a function and doesn't need to be a macro.

Then we should probably encapsulate more functionality or otherwise it 
is rather usless.

Think more about a function like amdgpu_gmc_cg_enabled() instead.

Regards,
Christian.

>
> Regards,
> Lang
>
>> Christian.
>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 3 +++
>>>    drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 3 +++
>>>    drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 3 +++
>>>    drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 3 +++
>>>    drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 3 +++
>>>    5 files changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>>> index 4c9f0c0f3116..1869e2019461 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>>> @@ -550,6 +550,9 @@ static void mmhub_v1_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>>>    {
>>>    	int data, data1;
>>> +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
>>> +		return;
>>> +
>>>    	if (amdgpu_sriov_vf(adev))
>>>    		*flags = 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
>>> index 3b901f941627..f7b9843b36e6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
>>> @@ -546,6 +546,9 @@ static void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>>>    {
>>>    	int data, data1;
>>> +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
>>> +		return;
>>> +
>>>    	if (amdgpu_sriov_vf(adev))
>>>    		*flags = 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>>> index 3718ff610ab2..3f5f326379b7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>>> @@ -686,6 +686,9 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>>>    {
>>>    	int data, data1;
>>> +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
>>> +		return;
>>> +
>>>    	if (amdgpu_sriov_vf(adev))
>>>    		*flags = 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
>>> index 9e16da28505a..b23dd9ddfb5c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
>>> @@ -580,6 +580,9 @@ static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>>>    {
>>>    	int data, data1, data2, data3;
>>> +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
>>> +		return;
>>> +
>>>    	if (amdgpu_sriov_vf(adev))
>>>    		*flags = 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
>>> index 619106f7d23d..a2d5c8424e2b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
>>> @@ -651,6 +651,9 @@ static void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>>>    {
>>>    	int data, data1;
>>> +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
>>> +		return;
>>> +
>>>    	if (amdgpu_sriov_vf(adev))
>>>    		*flags = 0;


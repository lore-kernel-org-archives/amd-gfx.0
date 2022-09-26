Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD91BC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A02C10E460;
	Mon, 26 Sep 2022 15:19:47 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F80A10E460
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:19:44 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id lh5so14787720ejb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=loWyMc6xof8v4o9EgadiUVjct/n7/Aq18LHWjLZPFvc=;
 b=JeIhx3uBEW22yw6buatGmieDV7SeEVQdegXr8YssED23AzNeXj2WkhYqlbquyhcv0v
 9tZhUGltR9Cr6ZlvFoNH5qKdqQiL7Ji3xBrkrzDLYzHz6YDncNxsCLmRC0W6Th7eiy2q
 Qs4Ytg/WvsLO1OQzaGsDgaPjBD2z0h3mYxjMBV+/KlgJs8LsoLIjAV8d6+n/YGgF1e2D
 sn63C1BlmnY6wCsiKwgVK/jk2FeEwQCVKkQx9WsgWTUM/FAlv+q0FRl80Zy8FR+SMrPY
 jVsnBD0ZPfmJ3HUyp67vUS+0eUlKbARsrmN45Xt4a18NkBrl8CPMuEEJqvjQMgE96R7x
 CWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=loWyMc6xof8v4o9EgadiUVjct/n7/Aq18LHWjLZPFvc=;
 b=XU0cHtog3JG+SbmBxoSuBINHLY9q6U1fsWaK0rPubZx5ZnM9xCp2HtHtWPvVc59kEZ
 YGWpbPThfLNNKuh5JffcuH9EPen+oonvyw/izyUQ8zOQUOpvbcaXckK/GsWODb8KbAAt
 tdsP1/SmvRe0pVJBlkE/bEVI2z3XGtfeIO/p3NdXA2QIhU1yZU7r6dngvXri7jagAnFC
 4OOXNJSrMifUHPRhrNJJntdZbsu5kMz1ED1Pe2I9HjaYEmiOZltqs2c6kNQUdZzFE6Bf
 xRNGfTqv4bqRz+zkXsZ6tnVRdIawG1+AVVbK5/cPxxdd+1lohIQsUbFVPYCAObq0n2IE
 rD5w==
X-Gm-Message-State: ACrzQf0FBAuLtleZfucE11OLmdWHK/O1KQVqB4Aus8W1h0iUyITbYnMR
 5VmD4AWytfLP5iBjuuGKhb9VE+AetKY=
X-Google-Smtp-Source: AMsMyM7w8kDrEToX7sNjSEfFIcGtldqnRi0M+EYHVgGKlDfT1lY6Mu++wOMZZfiAe7ZpI11QmUC5/g==
X-Received: by 2002:a17:906:fe0b:b0:730:3646:d177 with SMTP id
 wy11-20020a170906fe0b00b007303646d177mr17731169ejb.688.1664205582505; 
 Mon, 26 Sep 2022 08:19:42 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:66f0:63b6:d71a:f3d1?
 ([2a02:908:1256:79a0:66f0:63b6:d71a:f3d1])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a509989000000b0043df042bfc6sm12130534edb.47.2022.09.26.08.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Sep 2022 08:19:41 -0700 (PDT)
Message-ID: <48afef1e-b318-1f33-f35b-f098b7e76722@gmail.com>
Date: Mon, 26 Sep 2022 17:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220926150252.18635-1-shashank.sharma@amd.com>
 <20220926150252.18635-2-shashank.sharma@amd.com>
 <5e13829e-369b-80a1-5226-c3f0b62534a0@amd.com>
 <55293735-fee0-5e81-73cb-0215bc9cc989@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <55293735-fee0-5e81-73cb-0215bc9cc989@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.09.22 um 17:14 schrieb Sharma, Shashank:
>
> Hello Christian,
>
> On 9/26/2022 5:10 PM, Christian König wrote:
>> Am 26.09.22 um 17:02 schrieb Shashank Sharma:
>>> Allow the user to specify a workload hint to the kernel.
>>> We can use these to tweak the dpm heuristics to better match
>>> the workload for improved performance.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   include/uapi/drm/amdgpu_drm.h | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>> b/include/uapi/drm/amdgpu_drm.h
>>> index c2c9c674a223..da5019a6e233 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -212,6 +212,8 @@ union drm_amdgpu_bo_list {
>>>   #define AMDGPU_CTX_OP_QUERY_STATE2    4
>>>   #define AMDGPU_CTX_OP_GET_STABLE_PSTATE    5
>>>   #define AMDGPU_CTX_OP_SET_STABLE_PSTATE    6
>>> +#define AMDGPU_CTX_OP_GET_WORKLOAD_PROFILE    7
>>
>> Do we really have an use case for getting the profile or is that just 
>> added for completeness?
>> To be honest, there is no direct use case for a get(). We have 
> self-reset in kernel to clear the profile, so this is just for the 
> sake of completeness.

The problem is we usually need an userspace use case to justify 
upstreaming of an UAPI.

We already had a couple of cases where we only upstreamed UAPI for the 
sake of completeness (set/get pair for example) and then years later 
found out that the getter is completely broken for years because nobody 
used it.

So if we don't really need it I would try to avoid it.

Christian.

>
>> At base minimum we need a test-case for both to exercise the UAPI.
>>
>
> Agree, I have already added some test cases in libdrm/tests/amdgpu for 
> my local testing, I will start publishing them once we have an 
> agreement on the UAPI and kernel design.
>
> - Shashank
>
>> Regards,
>> Christian.
>>
>>> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE    8
>>>   /* GPU reset status */
>>>   #define AMDGPU_CTX_NO_RESET        0
>>> @@ -252,6 +254,17 @@ union drm_amdgpu_bo_list {
>>>   #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>>>   #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>>> +/* GPU workload hints, flag bits 8-15 */
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff << 
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 << 
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 << 
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 << 
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 << 
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 << 
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
>>> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)       (n >> 
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +
>>>   struct drm_amdgpu_ctx_in {
>>>       /** AMDGPU_CTX_OP_* */
>>>       __u32    op;
>>> @@ -281,6 +294,11 @@ union drm_amdgpu_ctx_out {
>>>               __u32    flags;
>>>               __u32    _pad;
>>>           } pstate;
>>> +
>>> +        struct {
>>> +            __u32    flags;
>>> +            __u32    _pad;
>>> +        } workload;
>>>   };
>>>   union drm_amdgpu_ctx {
>>


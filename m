Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C1CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 07:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 524A810F06D;
	Wed,  2 Mar 2022 07:52:24 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4892E10F069
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 07:52:23 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aee50.dynamic.kabel-deutschland.de
 [95.90.238.80])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id B9C1561EA1928;
 Wed,  2 Mar 2022 08:52:20 +0100 (CET)
Message-ID: <1ac4aea7-53f8-920a-7079-add068306f8e@molgen.mpg.de>
Date: Wed, 2 Mar 2022 08:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/3] drm/amdgpu: convert code name to ip version for
 noretry set
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Yifan Zhang <yifan1.zhang@amd.com>
References: <20220301150121.3785743-1-yifan1.zhang@amd.com>
 <20220301150121.3785743-2-yifan1.zhang@amd.com>
 <d356df33-4f6f-e8a2-08c3-cfee6b904c37@molgen.mpg.de>
 <54c29b0b-fe03-7c59-061c-15a87965e477@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <54c29b0b-fe03-7c59-061c-15a87965e477@gmail.com>
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Christian,


Am 02.03.22 um 08:46 schrieb Christian König:
> Am 01.03.22 um 16:24 schrieb Paul Menzel:

[…]

>> Am 01.03.22 um 16:01 schrieb Yifan Zhang:
>>> Use IP version rather than codename for noretry set.
>>
>> Why?
> 
> Why not?

No idea as the commit message currently does not document the motivation.

>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 17 ++++++++---------
>>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index ab75e189bc0b..fbc22b7b6315 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -559,14 +559,14 @@ void amdgpu_gmc_noretry_set(struct 
>>> amdgpu_device *adev)
>>>   {
>>>       struct amdgpu_gmc *gmc = &adev->gmc;
>>>   -    switch (adev->asic_type) {
>>> -    case CHIP_VEGA10:
>>> -    case CHIP_VEGA20:
>>> -    case CHIP_ARCTURUS:
>>> -    case CHIP_ALDEBARAN:
>>> -    case CHIP_BEIGE_GOBY:
>>> -    case CHIP_YELLOW_CARP:
>>> -    case CHIP_RENOIR:
>>> +    switch (adev->ip_versions[GC_HWIP][0]) {
>>> +    case IP_VERSION(9, 0, 1):
>>> +    case IP_VERSION(9, 4, 0):
>>> +    case IP_VERSION(9, 4, 1):
>>> +    case IP_VERSION(9, 4, 2):
>>> +    case IP_VERSION(10, 3, 5):
>>> +    case IP_VERSION(10, 3, 3):
>>> +    case IP_VERSION(9, 3, 0):
>>
>> I think, sorting these entries might be useful.
>>
>> Should the names be added as comments for those not having them 
>> memorized?
>>
>>>           /*
>>>            * noretry = 0 will cause kfd page fault tests fail
>>>            * for some ASICs, so set default to 1 for these ASICs.
>>> @@ -576,7 +576,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device 
>>> *adev)
>>>           else
>>>               gmc->noretry = amdgpu_noretry;
>>>           break;
>>> -    case CHIP_RAVEN:
>>
>> Why remove this?
>>
>>>       default:
>>>           /* Raven currently has issues with noretry
>>>            * regardless of what we decide for other


Kind regards,

Paul

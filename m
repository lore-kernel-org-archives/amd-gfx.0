Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB63C982D8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 15:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F2110F3E7;
	Fri, 18 Sep 2026 15:01:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="H2UUOM6E";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E86910F3E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 15:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=6tmEa2PuKufYUAhDwRxD2pjyiClCYDV33wUpebA44b0=; b=H2UUOM6EqebhG+AOCMo4BExvjo
 YCc0CmXKKXi9ZTzy7ZynPHh4AYsa6mwuN1Cn2DLnJobVejwIy9vix844igk/lH4KiFIO5UoOipADG
 3dE8UO7+4dXlqZRVa5Wz0vylFevvOl95/v9faMF2COP/VvYTNaSieiGDG6gsXLI2oVfr7tx+GKhcB
 mM611zM/rXT4kkvy13SgoIPOa3ODhSlfsXtatBoqdkxJYWaI7IxkSwxdXbfSMdxqvGu5zYbiCfE4q
 oI1fF2fIUDs+9daDLgKMQGV4os/Lonncmhmc735EewK6+QfzcsdHyhEvQadJjCN6fEQvNct5LqUvs
 4xEUGN0g==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x7a60-003zrp-E3; Fri, 18 Sep 2026 17:01:48 +0200
Message-ID: <e7fe0088-5e6e-48d5-9198-f73eb2585111@igalia.com>
Date: Fri, 18 Sep 2026 16:01:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] drm/amdgpu: More compact VCN IB emission
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
 <20260918120518.96922-2-tvrtko.ursulin@igalia.com>
 <474139b2-c3c2-4d2b-81d7-e209231870f2@amd.com>
 <84ae6c9c-6ea5-4e02-9dbe-5ba855580da1@igalia.com>
 <de963600-ba53-4e34-bba1-2a838cbc2457@amd.com>
 <052c9390-8906-4f8f-a501-30730c41f011@igalia.com>
 <04dc6bc5-4fb0-4e8b-a3f4-bc681ddf0b73@amd.com>
 <720027b8-deec-4953-a1e5-8b1781285c8c@igalia.com>
 <95af58a6-f89f-4430-9be2-d4d4a18dd1e9@amd.com>
 <6a1d885b-56bd-4b08-8d1e-cf0967bc7a14@amd.com>
 <f0874f34-8f55-49a5-aee3-89c529f7f83a@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <f0874f34-8f55-49a5-aee3-89c529f7f83a@amd.com>
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


On 18/09/2026 15:58, Lazar, Lijo wrote:
> 
> 
> On 18-Sep-26 8:01 PM, Lazar, Lijo wrote:
>>
>>
>> On 18-Sep-26 7:55 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 18-Sep-26 7:37 PM, Tvrtko Ursulin wrote:
>>>>
>>>> On 18/09/2026 14:34, Lazar, Lijo wrote:
>>>>> On 18-Sep-26 6:59 PM, Tvrtko Ursulin wrote:
>>>>>>
>>>>>> On 18/09/2026 14:23, Lazar, Lijo wrote:
>>>>>>> On 18-Sep-26 6:43 PM, Tvrtko Ursulin wrote:
>>>>>>>>
>>>>>>>> On 18/09/2026 14:08, Lazar, Lijo wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 18-Sep-26 5:35 PM, Tvrtko Ursulin wrote:
>>>>>>>>>> Avoid constant register reloads while emitting IBs by using a 
>>>>>>>>>> local write
>>>>>>>>>> pointer and only updating the size at the end of each helper.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>>>>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>> ---
>>>>>>>>>> v2:
>>>>>>>>>>   *  Fix decode buffer overwrite
>>>>>>>>>
>>>>>>>>> Overall for this series, below type of calculation  -
>>>>>>>>>
>>>>>>>>>      ib->length_dw = ptr - ib->ptr;
>>>>>>>>>
>>>>>>>>> is not anticipating a case like below.
>>>>>>>>>
>>>>>>>>>          r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
>>>>>>>>>          if (r)
>>>>>>>>>                  goto error;
>>>>>>>>>
>>>>>>>>>          r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
>>>>>>>>>          if (r)
>>>>>>>>>                  goto error;
>>>>>>>>
>>>>>>>> So amdgpu_vcn_enc_ring_test_ib() - are you saying there is a bug 
>>>>>>>> there? Help me see it please.
>>>>>>>>
>>>>>>>> ib->length_dw update is enclosed in both of those helpers, same 
>>>>>>>> as before the patch.
>>>>>>>>
>>>>>>>
>>>>>>> What I'm saying is -
>>>>>>>
>>>>>>> It's the same ib pointer that is passed to back to back calls.
>>>>>>>
>>>>>>> Legacy implementation fills like -
>>>>>>>
>>>>>>> ib->ptr[ib->length_dw++]
>>>>>>>
>>>>>>> So no assumption that it is starting from offset 0 always. After 
>>>>>>> the function is filled, length gets updated based on what is filled.
>>>>>>>
>>>>>>> I don't see the same with an assignment like
>>>>>>>
>>>>>>>      ib->length_dw = ptr - ib->ptr;
>>>>>>
>>>>>> Hm, but both of those helpers emit separate jobs with their own 
>>>>>> respective IB.
>>>>>>
>>>>>
>>>>> Wouldn't this kind of logic help to be on the safer side -
>>>>>
>>>>> ib->length_dw += ptr - &ib->ptr[start_size];
>>>>
>>>> I am not sure at which call sites you would suggest that?
>>>>
>>>> I used the pattern of whoever writes to the IB starts their block with:
>>>>
>>>>      u32 *ptr = &ib->ptr[ib->length_dw];
>>>>
>>>> Then they emit their stuff, and finally close with:
>>>>
>>>>      ib->length_dw = ptr - ib->ptr;
>>>>
>>>> By that design callers are safe since all are self-contained. I at 
>>>> the moment do not see how making that more complicated would make it 
>>>> safer.
>>>>
>>>
>>> I would say all places where the function starts like below without 
>>> keeping any assumptions.
>>>
>>>      ib->ptr[ib->length_dw++] = <value>;
>>>
>>> I don't see the complication with a code like this
>>>
>>>      ib->length_dw += ptr - &ib->ptr[ib->length_dw];
>>>
>>> It keeps the same behavior as before.
>>>
>>
>> As such the patch logic conflicts itself.
>>
>> For this to be true -
>>      ib->length_dw = ptr - ib->ptr;
>>
>> It should start like.
>>
>>      u32 *ptr = ib->ptr;
>>
>> Now it starts like
>>      u32 *ptr = &ib->ptr[ib->length_dw];
>>
>> So if you feel the new way is self contained, I would expect a change 
>> here as well. Otherwise, this could be read as a bug.
>>
> 
> Sorry for the noise. Got confused for a while; now I see what you meant.

No worries it happens to everyone! :)

Regards,

Tvrtko


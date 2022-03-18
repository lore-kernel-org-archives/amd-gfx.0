Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE6DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 07:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B1510E18B;
	Fri, 18 Mar 2022 07:04:59 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7BFE10E18B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 07:04:58 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef49.dynamic.kabel-deutschland.de
 [95.90.239.73])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 32FCE61E6478B;
 Fri, 18 Mar 2022 08:04:57 +0100 (CET)
Message-ID: <9085b528-2a24-f57a-3763-deed6155393b@molgen.mpg.de>
Date: Fri, 18 Mar 2022 08:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v3] drm/amdgpu: add workarounds for VCN TMZ issue on
 CHIP_RAVEN
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20220314024519.2201231-1-Lang.Yu@amd.com>
 <39dcbcab-8a92-4a01-e355-6e37ac4f1ce6@molgen.mpg.de>
 <YjE9CDYjvJ72IQNg@lang-desktop>
 <c502a443-0987-6d88-1ef3-603723f04634@molgen.mpg.de>
 <YjGB+Dx4nUIOyuMf@lang-desktop>
 <aa16b25a-197d-87d5-001f-87fdfcd1a139@gmail.com>
 <36b37edb-b8e1-5d12-7683-19b8f692fbc5@molgen.mpg.de>
 <84b01f7f-5cdd-50ac-a7bd-3c14d9bc823f@gmail.com>
Content-Language: en-US
In-Reply-To: <84b01f7f-5cdd-50ac-a7bd-3c14d9bc823f@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Christian,


Am 16.03.22 um 11:08 schrieb Christian König:

> Am 16.03.22 um 10:57 schrieb Paul Menzel:

>> Am 16.03.22 um 10:41 schrieb Christian König:
>>> Am 16.03.22 um 07:21 schrieb Lang Yu:
>>>> On 03/16/ , Paul Menzel wrote:
>>
>>>>> Am 16.03.22 um 02:27 schrieb Lang Yu:
>>>>>> On 03/15/ , Paul Menzel wrote:
>>>>>>> Am 14.03.22 um 03:45 schrieb Lang Yu:
>>>>>>>
>>>>>>> Thank you for your patch. A shorter commit message summary would be:
>>>>>>>
>>>>>>>> drm/amdgpu: Work around VNC TMZ issue on CHIP_RAVEN
>>>>>>>> It is a hardware issue that VCN can't handle a GTT
>>>>>>>> backing stored TMZ buffer on CHIP_RAVEN series ASIC.
>>>>>>> Where is that documented, and how can this be reproduced?
>>>>>> It is documented in AMD internal Confluence and JIRA.
>>>>>> Secure playback with a low VRAM config(thus TMZ buffer
>>>>>> will be allocted in GTT domain) may reproduce this issue.
>>>>> It’d be great if as much of the details from this non-publicly accessible
>>>>> information could be added to the commit message, and a way to reproduce
>>>>> this as there does not seem to be a test for this. (Also I guess a tag with
>>>>> a reference to the internal issue would be acceptable, so in case more
>>>>> question surface in the future.)
>>>> Thanks. I will add an internal link.
>>>
>>> Lang, please don't!
>>>
>>> This isn't an information which is expected to be made public.
>>
>> Well, how are then even the AMD folks able to link a (upstream) commit 
>> to an issue?
> 
> Well quite simply: We don't do that since it isn't necessary.

What other ways do you (or future AMD developers) have then? (I would 
also use *helpful* or *useful*.)

(In two years, when maybe nobody of the current AMD developers work at 
AMD anymore, and a user bisects a problems to this patch I could imagine 
it would help the future AMD developers to have this connection.)

>> If it’s not possible, even more detailed information about the issue 
>> including how to reproduce it needs to be part of the commit message.
> 
> No, why should we do that? It's an AMD internal hardware problem which 
> we add a software workaround for here. The hardware details why and what 
> are completely irrelevant to the public.
> 
> All that we need to document is that VCN can't handle GTT on Raven, and 
> that's exactly what the commit message is doing. That's perfectly enough 
> to write a test case.

Thank you for clarifying, but I am not interested in the hardware 
details, but how to reproduce and test the issue. And according to Lang 
this information is present in the issue. Seeing how complex the 
graphics driver are, a lot of documentation is not publicly available, a 
recipe to manually reproduce and test the issue is most helpful.


Kind regards,

Paul

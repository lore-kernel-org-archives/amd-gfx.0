Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C18C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  1 May 2022 07:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B41810E9B9;
	Sun,  1 May 2022 07:08:19 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C42E010E9B9;
 Sun,  1 May 2022 07:08:18 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aed6d.dynamic.kabel-deutschland.de
 [95.90.237.109])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id E7CEF61EA1923;
 Sun,  1 May 2022 09:08:15 +0200 (CEST)
Message-ID: <543a9e76-ca90-984b-b155-a0647cdeacff@molgen.mpg.de>
Date: Sun, 1 May 2022 09:08:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv4] drm/amdgpu: disable ASPM on Intel Alder Lake based
 systems
Content-Language: en-US
To: Richard Gong <richard.gong@amd.com>
References: <20220412215000.897344-1-richard.gong@amd.com>
 <d4ba3998-34aa-86d2-bde9-bc6ae9d8d08d@molgen.mpg.de>
 <CADnq5_MgvcGPWf2gYn_3qCr+Gq1P39tvv-W-o8NhivvMpMwUBA@mail.gmail.com>
 <91e916e3-d793-b814-6cbf-abee0667f5f8@molgen.mpg.de>
 <94fd858d-1792-9c05-b5c6-1b028427687d@amd.com>
 <efc1dfd1-2b54-aee5-1497-4b800a468141@molgen.mpg.de>
 <237da02b-0ed8-6b1c-3eaf-5574aab4f13f@amd.com>
 <294555b4-2d1b-270f-6682-3a17e9df133c@molgen.mpg.de>
 <5adfe067-dc00-6567-e218-c5c68670cf5b@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <5adfe067-dc00-6567-e218-c5c68670cf5b@amd.com>
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
Cc: Dave Airlie <airlied@linux.ie>, Xinhui Pan <xinhui.pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Alexander Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Richard,


Sorry for the late reply.

Am 26.04.22 um 15:53 schrieb Gong, Richard:

> On 4/21/2022 12:35 AM, Paul Menzel wrote:

>> Am 21.04.22 um 03:12 schrieb Gong, Richard:
>>
>>> On 4/20/2022 3:29 PM, Paul Menzel wrote:
>>
>>>> Am 19.04.22 um 23:46 schrieb Gong, Richard:
>>>>
>>>>> On 4/14/2022 2:52 AM, Paul Menzel wrote:
>>>>>> [Cc: -kernel test robot <lkp@intel.com>]
>>>>
>>>> […]
>>>>
>>>>>> Am 13.04.22 um 15:00 schrieb Alex Deucher:
>>>>>>> On Wed, Apr 13, 2022 at 3:43 AM Paul Menzel wrote:
>>>>>>
>>>>>>>> Thank you for sending out v4.
>>>>>>>>
>>>>>>>> Am 12.04.22 um 23:50 schrieb Richard Gong:

[…]

>>>>>>>> I am still not clear, what “hang during suspend/resume” means. I 
>>>>>>>> guess
>>>>>>>> suspending works fine? During resume (S3 or S0ix?), where does 
>>>>>>>> it hang?
>>>>>>>> The system is functional, but there are only display problems?
>>>>> System freeze after suspend/resume.
>>>>
>>>> But you see certain messages still? At what point does it freeze 
>>>> exactly? In the bug report you posted Linux messages.
>>>
>>> No, the system freeze then users have to recycle power to recover.
>>
>> Then I misread the issue? Did you capture the messages over serial log 
>> then?
> 
> I think so. We captured dmesg log.

Then the (whole) system did *not* freeze, if you could still log in 
(maybe over network) and execute `dmesg`. Please also paste the 
amdgpu(?) error logs in the commit message.

> As mentioned early we need support from Intel on how to get ASPM working 
> for VI generation on Intel Alder Lake, but we don't know where things 
> currently stand.

Who is working on this, and knows?


Kind regards,

Paul

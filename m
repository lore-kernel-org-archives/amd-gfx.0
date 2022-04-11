Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64073C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 07:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01FB910EED9;
	Mon, 11 Apr 2022 07:41:45 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF5910EED9;
 Mon, 11 Apr 2022 07:41:44 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae91f.dynamic.kabel-deutschland.de
 [95.90.233.31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4A1D261EA1923;
 Mon, 11 Apr 2022 09:41:42 +0200 (CEST)
Message-ID: <0d0a3f0f-f021-ccc2-a80a-f789cb53a47b@molgen.mpg.de>
Date: Mon, 11 Apr 2022 09:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCHv2] drm/amdgpu: disable ASPM on Intel AlderLake based
 systems
Content-Language: en-US
To: Richard Gong <richard.gong@amd.com>
References: <20220408190502.4103670-1-richard.gong@amd.com>
 <44354d78-b340-fbc4-fd6c-060d7ad3404e@molgen.mpg.de>
 <45ea5705-71d6-4008-f094-1aa902e5cc41@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <45ea5705-71d6-4008-f094-1aa902e5cc41@amd.com>
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
Cc: airlied@linux.ie, xinhui.pan@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, Dell.Client.Kernel@dell.com,
 christian.koenig@amd.com, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Cc: +<Dell.Client.Kernel@dell.com>]

Dear Richard,


Am 11.04.22 um 02:27 schrieb Gong, Richard:

> On 4/8/2022 7:19 PM, Paul Menzel wrote:

>> Am 08.04.22 um 21:05 schrieb Richard Gong:
>>> Active State Power Management (ASPM) feature is enabled since kernel 5.14.
>>> There are some AMD GFX cards (such as WX3200 and RX640) that cannot be
>>> used with Intel AlderLake based systems to enable ASPM. Using these GFX
>>
>> Alder Lake
> will correct in the next version.
>>
>>> cards as video/display output, Intel Alder Lake based systems will hang
>>> during suspend/resume.
>>
>> Please reflow for 75 characters per line.
>>
>> Also please mention the exact system you had problems with (also 
>> firmware versions).
>>
>>>
>>> Add extra check to disable ASPM on Intel AlderLake based systems.
>>
>> Is that a problem with Intel Alder Lake or the Dell system? Shouldn’t 
>> ASPM just be disabled for the problematic cards for the Dell system. 
>> You write newer cards worked fine.
> 
> There is a problem with Dell system (Dell Precision DT workstation), 
> which is based on Intel Alder Lake.
> 
> ASPM works just fine on these GPU's. It's more of an issue with whether 
> the underlying platform supports ASPM or not.

At least you didn’t document what the real issue is, that ASPM does not 
work. With current information (some GPU graphics card with the the Dell 
system and others don’t), it could be the GPU, the Dell system 
(firmware, …), a problem with Alder Lake SOC, or another bug. I hope you 
are in contact with Dell to analyze it, so ASPM can be enabled again.

[…]


Kind regards,

Paul

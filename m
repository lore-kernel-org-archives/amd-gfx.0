Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE501C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 08:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831C2611BF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 08:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 831C2611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5866EB50;
	Tue, 19 Oct 2021 08:26:00 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F776EB50
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 08:25:59 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef98.dynamic.kabel-deutschland.de
 [95.90.239.152])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7FD5761E5FE00;
 Tue, 19 Oct 2021 10:25:57 +0200 (CEST)
Subject: Re: [PATCH] amd/display: remove ChromeOS workaround
To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Sean Paul <seanpaul@chromium.org>, amd-gfx@lists.freedesktop.org
References: <20211014153433.169454-1-contact@emersion.fr>
 <7105dc75-eaba-d3b6-3d81-c92528961e0a@molgen.mpg.de>
 <83v0yDp6ECf071d9soan6ioi2tnd6POWo1kem9kUb08Vdlf1cMkYQlKp-mD5M1e7Vnr9Y-XBdP4R8CcvuAUOZWTod-KI3DdoNhAN-hnOfss=@emersion.fr>
 <9e6e9cbc-676d-4b2e-4a45-16f6f82d96e4@molgen.mpg.de>
 <IbTspowQBQlcRaVOdJ40EaV2xtWsqFXO1SbYF4AXqpDPehiAwIWyuMOBmuItYsLAHxbI2wAk5vxE2ydg_WeXoehmP51XBoiHnOPlqdl1tOg=@emersion.fr>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <6610f563-0693-54c3-c905-efabf1d4d524@molgen.mpg.de>
Date: Tue, 19 Oct 2021 10:25:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <IbTspowQBQlcRaVOdJ40EaV2xtWsqFXO1SbYF4AXqpDPehiAwIWyuMOBmuItYsLAHxbI2wAk5vxE2ydg_WeXoehmP51XBoiHnOPlqdl1tOg=@emersion.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

Dear Simon,


Am 19.10.21 um 10:10 schrieb Simon Ser:
> On Tuesday, October 19th, 2021 at 01:21, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> 
>> Am 19.10.21 um 01:06 schrieb Simon Ser:
>>> On Tuesday, October 19th, 2021 at 01:03, Paul Menzel wrote:
>>>
>>>> Excuse my ignorance. Reading the commit message, there was a Linux
>>>> kernel change, that broke Chrome OS userspace, right? If so, and we do
>>>> not know if there is other userspace using the API incorrectly,
>>>> shouldn’t the patch breaking Chrome OS userspace be reverted to adhere
>>>> to Linux’ no-regression rule?
>>>
>>> No. There was a ChromeOS bug which has been thought to be an amdgpu bug. But
>>> fixing that "bug" breaks other user-space.
>>
>> Thank you for the explanation. I guess the bug was only surfacing
>> because Chrome OS device, like Chromebooks, are only using AMD hardware
>> since a short while (maybe last year).
>>
>> Reading your message *amdgpu: atomic API and cursor/overlay planes* [1]
>> again, it says:
>>
>>> Up until now we were using cursor and overlay planes in gamescope [3],
>>> but some changes in the amdgpu driver [1] makes us unable to use planes
>>
>> So this statement was incorrect? Which changes are that? Or did Chrome
>> OS ever work correctly with an older Linux kernel or not?
> 
> The sequence of events is as follows:
> 
> - gamescope can use cursor and overlay planes.
> - ChromeOS-specific commit lands, fixing some ChromeOS issues related to video
>    playback. This breaks gamescope overlays.

I guess, I am confused, which Chrome OS specific commit that is. Is it 
one of the reverted commits below? Which one?

1.  ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication
when using overlay")
2.  e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay validation by 
considering cursors"")

> - Discussion to restrict the ChromeOS-specific logic to ChromeOS, or to revert
>    it, either of these fix gamescope.
> 
> Given this, I don't see how the quoted statement is incorrect? Maybe I'm
> missing something?

Your reply from August 2021 to commit ddab8bd788f5 (drm/amd/display: Fix 
two cursor duplication when using overlay) from April 2021 [2]:

> Hm. This patch causes a regression for me. I was using primary + overlay
> not covering the whole primary plane + cursor before. This patch breaks it.
> 
> This patch makes the overlay plane very useless for me, because the primary
> plane is always under the overlay plane.

So, I would have thought, everything worked fine before some Linux 
kernel commit changed behavior, and regressed userspace.


Kind regards,

Paul


[2]: 
https://lore.kernel.org/amd-gfx/SrcUnUUGJquVgjp9P79uV8sv6s-kMHG4wp0S3b4Nh9ksi29EIOye5edofuXkDLRvGfvkkRpQZ9JM7MNqew2B3kFUhaxsonDRXprkAYXaQUo=@emersion.fr/

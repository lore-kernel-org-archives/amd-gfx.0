Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1FBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 07:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DFFC1121C4;
	Wed, 13 Apr 2022 07:11:09 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC8410FBFC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 07:11:07 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae908.dynamic.kabel-deutschland.de
 [95.90.233.8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A5FD561EA192A;
 Wed, 13 Apr 2022 09:11:05 +0200 (CEST)
Message-ID: <28aa9e6b-5267-ea95-9a61-7c488fa97cdc@molgen.mpg.de>
Date: Wed, 13 Apr 2022 09:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Vega 56 failing to process EDID from VR Headset
Content-Language: en-US
To: James Dutton <james.dutton@gmail.com>
References: <CAAMvbhF-mcZd+mfSUVpYShvKmFiQ6pb+j2eosBr-kvsxE+202g@mail.gmail.com>
 <fae30821-f0b8-440a-a0d1-4c2a7d37ec07@molgen.mpg.de>
 <CAAMvbhFcD_YuoZEM+LyY6Yga9foR5mUBqPZP9TPpto5o4EGo1Q@mail.gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAAMvbhFcD_YuoZEM+LyY6Yga9foR5mUBqPZP9TPpto5o4EGo1Q@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear James,


Am 13.04.22 um 00:13 schrieb James Dutton:
> On Tue, 12 Apr 2022 at 07:13, Paul Menzel wrote:
>> Am 11.04.22 um 23:39 schrieb James Dutton:
>> So, did you do any changes to Linux? Why do you think the EDID is at fault?
>>
>> […]
>>
>> I suggest to analyze, why `No DP link bandwidth` is logged. The macro is
>> `DC_NO_DP_LINK_BANDWIDTH`, and you should first check why
>> `dp_validate_mode_timing()` in
>> `drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c` returns false.

>> PS: Using the issue tracker [1] might make it easier to keep track of
>> this problem, and also to attach all the necessary information.
>>
>>
>> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues/

> I will do some more investigation. In addition to it not processing
> the EDID particularly well...
> Since my email, I have found out that it is failing to complete CR
> (Clock Recovery) on Link 0,2, but it works on 1,3 at HBR2. All 4 Links
> work at HBR1.   (I need the HBR2 working)
> The CR negotiation in the code looks a bit wrong to me, so I will look
> into that a bit more.
> Looking at the current amdgpu source code   (I am using Mainline
> kernel version 5.17.1), it appears to retry CR negotiation, but each
> time it uses the same settings, rather than try different driver
> parameters, as recommended in the DP standards and compliance test
> documents.

[…]

Awesome, that you review the code with your expertise. Though I suggest 
to look at and work on agd5f/amd-staging-drm-next [1], having the latest 
code for the driver.

> Once I know more, I will put all the info in the issue track, as you
> suggest.

I am looking forward to it. To not get lost in all the problems, one 
email or issue per problem might be a good way forward, and adding 
people adding the code (`git blame -w`) to Cc might also help.

Happy debugging and hacking!


Kind regards,

Paul


[1]: https://gitlab.freedesktop.org/agd5f/linux/

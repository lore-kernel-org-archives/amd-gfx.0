Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C73CC5AD5A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 22:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B238A10F145;
	Wed, 12 Aug 2026 22:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WyzytDJL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D9A10F145
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 22:21:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D0BFC42B9E;
 Wed, 12 Aug 2026 22:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772CB1F000E9;
 Wed, 12 Aug 2026 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786573307;
 bh=lSjfsT9lz56s5Gpwb7v0lw3+r8UguBFDrjycJYrRh50=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WyzytDJLW4uygTB8IkrNv+M6l8KIdEXdWj0ar5ta618faApIAlLlo6conCSs2Vnf8
 /RmPyIQchw5ZRaEgcfwzoN/asl/qrvGpDYC/EmT6+MHkCHruoug94FEa/9ERu3Tgjf
 UMARMLQSCJAPLr8J7MLgeiQLTOt2EDgshkBHbbERI6funv0ohrjMmthWR2NUqikhoo
 7m4S7acpeOBGRgcHuOKdlx03xQoh6bAiZbpXi/7YThGLbExImYG6uoIVY+Ym57rzmL
 zCxtonGW2KVyLbyH3TxflcIV4spiCqk96HrQTfYz0p1zPjZgH/WWjAriS6804MHqgx
 PwklUDbDxCZrg==
Date: Wed, 12 Aug 2026 18:21:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 George Zhang <george.zhang@amd.com>
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
Message-ID: <anzx-jMt6_6OTdTI@laps>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
 <2026081151-reabsorb-calamari-7442@gregkh>
 <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
 <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>
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

On Tue, Aug 11, 2026 at 01:25:14PM -0400, Alex Deucher wrote:
>On Tue, Aug 11, 2026 at 11:25 AM Sergio Callegari
><sergio.callegari@gmail.com> wrote:
>>
>> On 11/08/2026 10:08, Greg KH wrote:
>> > We aim to be "bug compatible" with Linus's branch, otherwise the
>> > "pressure" to fix those bugs goes down.  But I defer to the maintainers
>> > of the code involved if it is being worked on, and they want it
>> > reverted, great, we can do that.  Otherwise we prefer to leave it as-is.
>>
>> I understand. Sorry for asking about things that might be obvious to
>> most people here. My expectation was that only a selected subset of the
>> patches on the Linus' tree were to enter in stable, so do we really need
>> to have stable "bug compatible" wrt this bug? The original behavior was
>> not free of issues, but they were rather minor (a reporting issue). Now
>> we have this very bad behavior where the display remains dark.
>>
>> To make the matter worse, on systems that have encrypted root the screen
>> remains dark also on that password prompt (observed with plymouth).
>>
>> In any case, I managed testing 7.2.0RC7 and it is fine again.
>>
>> Looks like the Linus' tree has more changes wrt backlight, and the
>> interesting ones are probably those in the cumulative fix
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=973fd9493ec21f12e760fbbedeb7b0b2317c02f4.
>>
>
>Thanks for testing.  It sounds like we should revert the change from
>stable.  There must be some dependency we are missing in stable.

Hmm...

In stable kernels, convert_custom_brightness() still scales the user value by
(max - min), but f1b5d8f9cc54 ("drm/amd/display: Fix backlight max_brightness
to match exported range") widened the exported range to max. Past ~(max - min),
scale_input_to_fw() exceeds AMDGPU_MAX_BL_LEVEL and
convert_brightness_from_user() returns >0xFFFF, which wraps in
dce_driver_set_backlight(). With the defaults the cliff lands on 64533, which
is what Sergio sees.

Upstream only hides it: mod_power_set_backlight_percent() clamps at 100%.

Does this make sense?

-- 
Thanks,
Sasha

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B084EC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Dec 2022 15:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBBB10E07C;
	Tue, 27 Dec 2022 15:34:01 +0000 (UTC)
X-Greylist: delayed 488 seconds by postgrey-1.36 at gabe;
 Mon, 26 Dec 2022 19:32:45 UTC
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167C010E12E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Dec 2022 19:32:45 +0000 (UTC)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 89DACA003F;
 Mon, 26 Dec 2022 20:24:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 89DACA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1672082656; bh=G+feGOdiLCP3tiUA/WiebYF7xmjX4QgATt6Yoy3yzMc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=2P9cw4xV0sfTsmKCNRmPtGqCR4N78rkcFlOheLZnSLaJMlidFWyJZigNKefI8Pegq
 UF2iWY1e9EaXE04wKOfHY4wo8wnjuYtDI/ivgaD6eDWto8SAEWNcYZtPviWlh18Iak
 syN0AN6eAEC//Q7FHfbwzeDrczoAKaNHeAGAeFUU=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 26 Dec 2022 20:24:11 +0100 (CET)
Message-ID: <47f3590c-f371-c997-374f-0a2a3dde86dc@perex.cz>
Date: Mon, 26 Dec 2022 20:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ALSA: hda/hdmi: Use only dynamic PCM device allocation
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, =?UTF-8?Q?Michael_La=c3=9f?=
 <bevan@bi-co.net>
References: <20220922084017.25925-1-perex@perex.cz>
 <1c9c00dec72c241a399b3b7c0a305382a5712529.camel@bi-co.net>
 <87edsnxqmo.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <87edsnxqmo.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Dec 2022 15:33:58 +0000
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
Cc: ALSA development <alsa-devel@alsa-project.org>,
 amd-gfx@lists.freedesktop.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 25. 12. 22 19:52, Takashi Iwai wrote:
> On Sun, 25 Dec 2022 13:14:28 +0100,
> Michael Laß wrote:
>>
>> CC'ing amd-gfx as this might be an issue in the amd driver.
>>
>> This change causes a regression in Linux 6.1 at least on some AMD APUs.
>> There are reports from users with Ryzen 4750U, 5800U and 5850U chips
>> where the HDMI sound devices don't show up anymore. I'm affected by
>> this as well.
>>
>> Reverting this commit (ef6f5494) makes the HDMI audio devices show up
>> again. I verified that this is still an issue in current Linux git
>> (72a85e2b).
>>
>> Am Donnerstag, dem 22.09.2022 um 10:40 +0200 schrieb Jaroslav Kysela:
>>>> Per discussion on the alsa-devel mailing list [1], the legacy PIN to PCM
>>>> device mapping is obsolete nowadays. The maximum number of the simultaneously
>>>> usable PCM devices is equal to the HDMI codec converters.
>>>>
>>>> Remove the extra PCM devices (beyond the detected converters) and force
>>>> the use of the dynamic PCM device allocation. The legacy code is removed.
>>>>
>>>> I believe that all HDMI codecs have the jack sensing feature. Move the check
>>>> to the codec probe function and print a warning, if a codec without this
>>>> feature is detected.
>>
>> The corresponding message ("jack not detectable") is not shown on the
>> affected system.
>>
>>>> [1] https://lore.kernel.org/alsa-devel/2f37e0b2-1e82-8c0b-2bbd-1e5038d6ecc6@perex.cz/
>>
>> Links to some reports of this issue:
>> https://bugzilla.kernel.org/show_bug.cgi?id=216836
>> https://bbs.archlinux.org/viewtopic.php?pid=2075700
>> https://bugs.archlinux.org/task/76917
>> https://www.reddit.com/r/archlinux/comments/zsqq7i/hdmi_audio_is_broken_after_updating_kernel_to_611
> 
> Could you give alsa-info.sh outputs from both working and non-working
> cases?  Run the script with --no-upload option during the playback of
> HDMI stream, and attach the outputs.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216836

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

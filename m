Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1951C5AC67
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 12:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67C210E314;
	Tue, 11 Aug 2026 12:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="UvTz/Vn/";
	dkim-atps=neutral
X-Greylist: delayed 468 seconds by postgrey-1.36 at gabe;
 Tue, 11 Aug 2026 05:32:08 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [185.244.194.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B130110EA4B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 05:32:08 +0000 (UTC)
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hK0RQ27LWz9Cmf;
 Tue, 11 Aug 2026 07:24:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1786425858;
 bh=v0Tg3ZnPRcotZDFgtJVylnE8t3hD5XhREn53fn8R/P4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UvTz/Vn/JhlzIbbkpvqdzCiX/HIANqTHR4xdmp5Owaa3yazl+b6SaDrschqDBQ95j
 6pLdcr3qW9rGZ7Gz6uqfuev29bjusW3m1Rxiic95poZv7+zMwpEI8Vv4xDQDP+Qwan
 B+8UlNgfQ4eKxmSYLs9L1nUwm4Mefh4Zo8JzDcMIouOVr7HbjXri5168k0NSEhroe+
 ix+7xSlt5wy2vcgc9hayC5p9wdVGCWZitFvDY2Z2qT7c4mzWmpnQFam9p2l+DceLVr
 vxygAbra4r1GLuPYNrMCWMINbddaWo9PwHFOydFKdY15bmvB0KZdccY9dFdWUAWIFT
 rm+sLQj+brN2A==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hK0RQ1R8sz7wQZ;
 Tue, 11 Aug 2026 07:24:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hK0RN3J57z8tf6;
 Tue, 11 Aug 2026 07:24:16 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id A0E8D5FA60;
 Tue, 11 Aug 2026 07:24:15 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
Date: Tue, 11 Aug 2026 07:24:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
To: Greg KH <gregkh@linuxfoundation.org>,
 Sergio Callegari <sergio.callegari@gmail.com>
Cc: stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 George Zhang <george.zhang@amd.com>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <2026081106-pebbly-cahoots-37a7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178642585611.1330248.4545404733011382024@mxe9fb.netcup.net>
X-NC-CID: WEohhmkvU4GRgtzzV1+7dBZ5kmzu/VCK0bQpMzD6qlyUOt1lGD4=
X-Mailman-Approved-At: Tue, 11 Aug 2026 12:05:18 +0000
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

[CCing a few people and lists]

/me just wanted to send a revert request himself, but then saw that
there was one to join in

On 8/11/26 04:29, Greg KH wrote:
> On Mon, Aug 10, 2026 at 03:17:43PM +0200, Sergio Callegari wrote:
>> after having looked a bit more thoroughly into the matter, and having gone
>> through the relevant commits that introduced and subsequently modified the
>> AMD backlight brightness code paths, I would like to suggest reverting
>> commit
>>
>> 1191285ecb4233e5bf907da7e9394d7999055566

For the record, that is f1b5d8f9cc54ae ("drm/amd/display: Fix backlight
max_brightness to match exported range") [v7.2-rc4, v7.1.6
(1191285ecb4233), v6.18.42 (490ceacd2162de)]

And yes, 6.18.y seems affected, too, according to a comment in the
ticket linked below.

>> from the 7.1 stable series.
> 
> It needs to be reverted in Linus's tree first, otherwise the regression
> will be hit when you update to 7.2.
Normally I'd agree, but according to one reporter that problem does not
happen with 7.2-rc:
https://gitlab.freedesktop.org/drm/amd/-/work_items/5562#note_3603131

So it seems it's some missing backport or something like that. But it
seems nobody yet has mentioned which other change(s) might be be
missing, unless I missed it (which is quite possible).

Quite a few people are affected, as can be seen by all the duplicated
Alex marked for the ticket linked above.

Given all that I wonder if dropping that commit for now might be the
best move.

Ciao, Thorsten

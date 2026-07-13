Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54473C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66C710E9A7;
	Mon, 13 Jul 2026 13:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="FfkoyydB";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.61.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1156F10E108
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 10:56:49 +0000 (UTC)
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
 by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4gzKBR4GJSz70d1;
 Mon, 13 Jul 2026 12:56:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1783940207;
 bh=2ZZkHVudlaMtoonDI2SZXRw2rz+0+Us6B/f+6trY8Eo=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=FfkoyydB1+rp78A//nI9sDskav/SGpyNWtQHzoTr7/rZK7fU3i2Wze7IeC4ORwwGQ
 tc2KonexliZ92mrDjLf1ZeFbC5CvavZgmCRoA9+h3rN11Z5K4tKSdRIiqyQ+Hv8wpt
 g1JBfiNwhLMc7G8K1h6fjHvZjYL+IrqH7a+FucZl6dDsCMgV/aoaief+5Vb6Ls7Q6u
 skJkKbaDdFkDz6sk4yQKwAeYpZtHF4Cu19h/QLIYglrzGVIm9hA7xBcBhw4ehocMXu
 TRRXQhoP/M5tOSZ7lbhfdzh8dCTeQALVHg3Z5bPXz8dboC8KUXOzJp1fC3Ki4MLMQS
 iSeei/V5NfwhQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4gzKBR3Xf2z70ct;
 Mon, 13 Jul 2026 12:56:47 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gzKBQ6G1Qz8svF;
 Mon, 13 Jul 2026 12:56:46 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 2FC61603F0;
 Mon, 13 Jul 2026 12:56:41 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f903ef1d-0d2d-4b71-afc2-e86207db7e8a@leemhuis.info>
Date: Mon, 13 Jul 2026 12:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658
 (R7 260X)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>
References: <20260713061443.32561-1-timur.kristof@gmail.com>
 <c2050464-7f95-4b6a-95db-698c637136df@leemhuis.info>
 <fMZgsndLRnm1-Yt6VBK1JA@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <fMZgsndLRnm1-Yt6VBK1JA@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178394020144.3768149.7611686007791612494@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 2FC61603F0
X-NC-CID: egUMxveJ5Jrl61v+duK/03J2Wxg8hGSI2mBuvor/V3Fd5YfivtY=
X-Mailman-Approved-At: Mon, 13 Jul 2026 13:09:32 +0000
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

On 7/13/26 12:00, Timur Kristóf wrote:
> On Monday, July 13, 2026 10:28:08 AM Central European Summer Time Thorsten 
> Leemhuis wrote:
>> On 7/13/26 08:14, Timur Kristóf wrote:
>
>>> What I expected to happen is that the GPU would simply use
>>> its maximum memory clock, and indeed this is what seemed
>>> to happen according to amdgpu_pm_info which reads the
>>> current MCLK value from the SMU.
>>> However, some users reported a huge perf regression
>>
>> Were those private reports? If not, please consider linking them in the
>> trailers using Link: or Closes: tags, as explained in the patch
>> submission guidelines (and mandated by Linus, see the quotes and links
>> in
>> https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-> the-importance-of-pointing-to-bug-reports-using-link-closes-tags for
>> details).

Thx for the reply!

> There is no bug report. I had a conversation on Reddit which brought my 
> attention to this issue, then I actually plugged in the GPU, tested it and 
> noticed that there is indeed a problem,

FWIW, we occasionally link to reddit threads as well, but sounds like
this would not make sense here.

> and this patch here is the best fix I  could find.

Great, thx.

BTW (feel free to ignore this if you have no idea): I first had wondered
if there is a bug report about this in
https://gitlab.freedesktop.org/drm/amd/-/work_items and wanted to search
if the culprit was mentioned anywhere. Do you by chance know if that is
somehow possible?

To provide an example of what I want:

https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16043#note_3563809
mentions commit-id 2914709c (Revert "drm/i915/backlight: Remove
try_vesa_interface"") -- but I didn't find a way to find tickets then
refer to that commit, for example with a search like this:
https://gitlab.freedesktop.org/search?search=2914709c&nav_source=navbar&search_code=true

Is there some trick to do this?

Ciao, Thorsten

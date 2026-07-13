Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9D7C44507
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B1510E9A6;
	Mon, 13 Jul 2026 13:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="gR+33CMf";
	dkim-atps=neutral
X-Greylist: delayed 432 seconds by postgrey-1.36 at gabe;
 Mon, 13 Jul 2026 11:28:15 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [194.59.206.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192F110E905
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 11:28:15 +0000 (UTC)
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
 by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gzKkP6NtXz4Gvt;
 Mon, 13 Jul 2026 13:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1783941661;
 bh=+Srm2RlS9ODdW1n2btLT8VOhjgw9/2wwoYrw2kYUT2I=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=gR+33CMfaI1l1hx5ixcv/PttLExzu3pJEldV+yAKaywPueWrkM5v+IkwpCCUP95GZ
 I5xL6NLQnj1nR0gEmnMfKVfYVcF4WCFJaehfCIaYN9zsJ/04s4fKcdhOIEGjSXKrmB
 E4svSxyWGr/mtJy1s0E1WCXHnrQqB/gQL7WN1B2roUODxb0kO+UHFRJIJwBXOAoGeE
 v2DDyETfyaBHXNUmHw85b4Ync9dfKIukW9C9/dUv6H0R9MKXoszo48FE5M6A/8WLf7
 mWBr/JjkmAUIbICxzgQzL6XRRD0d0K//UgI5iJhAl9ywdUdGaETbHwuhs3oc4HF3rU
 09xxdpcG9/nDQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gzKkP5hcTz7wHk;
 Mon, 13 Jul 2026 13:21:01 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gzKkP24dVz8sgw;
 Mon, 13 Jul 2026 13:21:01 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id A1882601EC;
 Mon, 13 Jul 2026 13:20:57 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <0dece759-302d-4b54-8716-9d641dad3b84@leemhuis.info>
Date: Mon, 13 Jul 2026 13:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658
 (R7 260X)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>
References: <20260713061443.32561-1-timur.kristof@gmail.com>
 <fMZgsndLRnm1-Yt6VBK1JA@gmail.com>
 <f903ef1d-0d2d-4b71-afc2-e86207db7e8a@leemhuis.info>
 <5CyapnyQRMWqVd6eVa9xiw@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <5CyapnyQRMWqVd6eVa9xiw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178394165796.3837220.6999120502901293845@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: A1882601EC
X-NC-CID: wrqJVcW3Fhs7HhjnzHWlFUtcpgB02QyJ574RJZrev8Z7qQkiSm4=
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

On 7/13/26 13:11, Timur Kristóf wrote:
>> To provide an example of what I want:
>>
>> https://gitlab.freedesktop.org/drm/i915/kernel/-/
>> work_items/16043#note_35638
>> 09 mentions commit-id 2914709c (Revert "drm/i915/backlight: Remove
>> try_vesa_interface"") -- but I didn't find a way to find tickets then
>> refer to that commit, for example with a search like this:
>> https://gitlab.freedesktop.org/search?
>> search=2914709c&nav_source=navbar&sear
>> ch_code=true
>>
>> Is there some trick to do this?
> For that example, if you open the commit link:
> https://gitlab.freedesktop.org/drm/i915/kernel/-/commit/
> 2914709c914101eb704e01bed2351070d4161ccf
> 
> You can scroll down and see that the commit was mentioned, and you can then 
> click on the issues where it was mentioned.

Ahh, great, thx, you helped me quite a lot. Fun fact: I had briefly
looked at pages like that for a reference already, but seem I didn't
scroll down far enough. :-/

Ciao, Thorsten

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EBBFCE087
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 13:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC66910E953;
	Thu, 26 Feb 2026 13:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="Tyr6nIlG";
	dkim-atps=neutral
X-Greylist: delayed 475 seconds by postgrey-1.36 at gabe;
 Thu, 26 Feb 2026 06:15:55 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400BD10E05C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 06:15:55 +0000 (UTC)
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
 by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4fM1GP70R9z8g0R;
 Thu, 26 Feb 2026 06:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1772086078;
 bh=YgLF/QZ7DNboUw70vUFZKMnCHyULdhdFZwE/VpZGRVU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Tyr6nIlGF6dLwTPmmV26mzkolNdjJjGfcU6FFexVKVFXJNcD9NwuPOgQfpWAIYghg
 eamGRo2E02b3N+5P0o7WwpXpSfi/Qassapk4uW0iybEL51v/2CJIXrejxw2WTOkH8m
 CSwGzwxs4nF1Cus8KYQdsBg54idGFgha09Ku3zfc6oX+LYqjicc2tNWMCcipADE9cO
 Y1lVRWRU6eLhaPWBb69jD/LeNwbwu0DCtv5Nijc+Zfmo829F7S+H2lXeSQQB4gppK4
 cNYuojCWZGEpEjAo8tt/WXeJ6puqGsBlsnDGOz/02vWlglDP14u3FeU3UZwoGsvRRS
 aK+xTan+wQT9g==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4fM1GP6FhHz8fy0;
 Thu, 26 Feb 2026 06:07:57 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fM1GN0Ncxz8svL;
 Thu, 26 Feb 2026 07:07:55 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 166946746C;
 Thu, 26 Feb 2026 07:07:55 +0100 (CET)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ff09cd21-3290-4254-85d3-42966efc4ff5@leemhuis.info>
Date: Thu, 26 Feb 2026 07:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] next/master: (build) undefined reference to
 `__udivmoddi4' in vmlinux.unstripped (drive...
To: Randy Dunlap <rdunlap@infradead.org>, kernelci@lists.linux.dev,
 kernelci-results@groups.io, amd-gfx@lists.freedesktop.org
Cc: regressions@lists.linux.dev, gus@collabora.com,
 linux-next@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <177205314269.2960.1720626770087948602@d14e337afe00>
 <469ff3b3-8bb9-44ce-9b08-af49f5c22a5a@infradead.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <469ff3b3-8bb9-44ce-9b08-af49f5c22a5a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177208607542.761837.14536169702537603704@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 166946746C
X-NC-CID: 2pNAdk141nwAJ0xhYwf4rFmqgMXzu0TqHMGlOX5neVwQHuIvlOo=
X-Mailman-Approved-At: Thu, 26 Feb 2026 13:55:07 +0000
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

On 2/26/26 06:48, Randy Dunlap wrote:
> [adding amd-gfx]

FWIW, from a very quick look this looks to be the same issue that 0day
reported yesterday also that Kees wants to look into:

https://lore.kernel.org/all/202602250926.E587F86@keescook/
https://lore.kernel.org/all/202602251312.pq8yvrww-lkp@intel.com/

Ciao, Thorsten

> On 2/25/26 12:59 PM, KernelCI bot wrote:
>>
>>
>>
>>
>> Hello,
>>
>> New build issue found on next/master:
>>
>> ---
>>  undefined reference to `__udivmoddi4' in vmlinux.unstripped (drivers/gpu/drm/amd/ras/rascore/ras_core.c) [logspec:kbuild,kbuild.compiler.linker_error]
>> ---
>>
>> - dashboard: https://d.kernelci.org/i/maestro:dc8172b1090ab934a0e5bf70ede907ed6caaba80
>> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> - commit HEAD:  877552aa875839314afad7154b5a561889e87ea9
>> - tags: next-20260225
>>
>> Please include the KernelCI tag when submitting a fix:
>>
>> Reported-by: kernelci.org bot <bot@kernelci.org>
>>
>>
>> Log excerpt:
>> =====================================================
>>   LD      .tmp_vmlinux1
>> ld: drivers/gpu/drm/amd/ras/rascore/ras_core.o: in function `ras_core_convert_timestamp_to_time':
>> ras_core.c:(.text+0x273): undefined reference to `__udivmoddi4'
>>
>> =====================================================
>>
>>
>> # Builds where the incident occurred:
>>
>> ## defconfig+kcidebug+x86-board on (i386):
>> - compiler: gcc-14
>> - config: https://files.kernelci.org/kbuild-gcc-14-x86-kcidebug-699f38921f24bb69463aa0f4/.config
>> - dashboard: https://d.kernelci.org/build/maestro:699f38921f24bb69463aa0f4
>>
>>
>> #kernelci issue maestro:dc8172b1090ab934a0e5bf70ede907ed6caaba80
>>
>> --
>> This is an experimental report format. Please send feedback in!
>> Talk to us at kernelci@lists.linux.dev
>>
>> Made with love by the KernelCI team - https://kernelci.org
>>
> 


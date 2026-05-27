Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2550CCD6E45
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 07:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932BF10ED24;
	Thu, 28 May 2026 07:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="bdQ5+7NB";
	dkim-atps=neutral
X-Greylist: delayed 432 seconds by postgrey-1.36 at gabe;
 Wed, 27 May 2026 08:46:14 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [185.244.194.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A154410E167
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 08:46:14 +0000 (UTC)
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gQNM773BRz95pN;
 Wed, 27 May 2026 10:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1779871140;
 bh=Sr0H+KAy4WCc04GejdOIgsotYR9rZsPYwwXu98pnoT8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bdQ5+7NBHtESfpaU2IOzXYz3SQYl0lAcmfEQJ0N6W2Pt+/8ULStEOduh/Qv9Rij5p
 pcQG6/zLdtc8Rp1qfcyg9t0U7TxKtmNlVrAE7HmJPySkhA6jQkPv8rka0eg1DFJFJS
 YKyNKtOhiBWapwBIcC/DSgQFiZkymPgMyBwg0Ugo3BzecNdRmPTPbzw9GuoSD5z0gQ
 kfgqRNxZhxTj587JRQuZra37qOa3qZsd4wDRZsz6H3B5L6ttldsMgZumt0VHKQ2GJD
 3LsXwziFnWvnD6lnutWtg8lYmh1QbWS00m/+Gy7RRr5Me0yaU8eyCC/KSwXr8mx21o
 eLyvB91iz/9ig==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gQNM76KZlz7wgN;
 Wed, 27 May 2026 10:38:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gQNM63Bs3z8tZn;
 Wed, 27 May 2026 10:38:58 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 0A7E361820;
 Wed, 27 May 2026 10:38:57 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=linux@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <e3fa05e5-ca09-4179-8b03-db168558f77a@leemhuis.info>
Date: Wed, 27 May 2026 10:38:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Write REFCLK to 48MHz on DCN21
To: Alex Deucher <alexdeucher@gmail.com>, IVAN.LIPSKI@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 mario.limonciello@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Max Chernoff <git@maxchernoff.ca>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260514155348.2114429-3-IVAN.LIPSKI@amd.com>
 <CADnq5_PDFT1+8G_yAVBa0nGpBgbs=npszsW_G2n85f+zh33_zg@mail.gmail.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <CADnq5_PDFT1+8G_yAVBa0nGpBgbs=npszsW_G2n85f+zh33_zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177987113741.4140924.2598995578202932072@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 0A7E361820
X-NC-CID: hsbW1m3zccmoQXJZeZUihVYgqvihA2KPedSs3+cUnrx/DP2djU8=
X-Mailman-Approved-At: Thu, 28 May 2026 07:29:41 +0000
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



On 5/14/26 19:18, Alex Deucher wrote:
> On Thu, May 14, 2026 at 12:04 PM <IVAN.LIPSKI@amd.com> wrote:
>>
>> From: Ivan Lipski <ivan.lipski@amd.com>
>>
>> [Why&How]
>> dccg21_init() calls dccg2_init() which hardcodes 100MHz refclk values
>> for MICROSECOND_TIME_BASE_DIV and MILLISECOND_TIME_BASE_DIV. DCN21
>> uses 48MHz refclk, so the wrong values corrupt DCCG timing and cause eDP
>> link training failure on cold boot.
>>
>> Write the correct 48MHz values directly instead of calling dccg2_init().
>>
>> Fixes: b7dfeea1e168 ("drm/amd/display: Add missing DCCG register entries for DCN20-DCN316")
>>
>> v2:
>> Fixed typo
>>
>> Reported-by: Max Chernoff <git@maxchernoff.ca>
>> Tested-by: Max Chernoff <git@maxchernoff.ca>
>> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>

What happened to this regression fix? From the outside it looks like it
did not make any progress in the last 12+ days -- but from the outside
it's easy to miss something (like an alternative fix), so please just
tell me if that's the case

Side note: Adding these might be good:

 Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5272
 Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5311

Ciao, Thorsten

> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> For a future patch, it would be a nice clean up to read the ref clock
> from the driver and program the clock as needed rather than requiring
> a separate callback for each chip and using a hardcoded programming
> sequence.
> 
> Alex
> 
>> ---
>>  .../drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c    | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
>> index bdc3ce5d4f47..be167bbd42b5 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
>> @@ -105,15 +105,26 @@ static void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppcl
>>   * dccg2_init() unconditionally overwrites MICROSECOND_TIME_BASE_DIV to
>>   * 0x00120264, destroying the marker before it can be read.
>>   *
>> - * Guard the call: if the S0i3 marker is present, skip dccg2_init() so the
>> + * Guard the call: if the S0i3 marker is present, skip init so the
>>   * WA can function correctly. bios_golden_init() will handle init in that case.
>> + *
>> + * DCN21 uses 48MHz refclk, not 100MHz, so we must explicitly set the correct
>> + * values (48MHz is taken from rn_clk_mgr_construct()).
>>   */
>>  static void dccg21_init(struct dccg *dccg)
>>  {
>> +       struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
>> +
>>         if (dccg2_is_s0i3_golden_init_wa_done(dccg))
>>                 return;
>>
>> -       dccg2_init(dccg);
>> +       /* 48MHz refclk from rn_clk_mgr_construct() */
>> +       REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x00120230);
>> +       REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x0010bb80);
>> +       REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0x0e01003c);
>> +
>> +       if (REG(REFCLK_CNTL))
>> +               REG_WRITE(REFCLK_CNTL, 0);
>>  }
>>
>>  static const struct dccg_funcs dccg21_funcs = {
>> --
>> 2.43.0
>>
> 


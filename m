Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAA1CD4F3C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 07:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610A010F21D;
	Thu, 21 May 2026 07:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="TiS8wmmg";
	dkim-atps=neutral
X-Greylist: delayed 468 seconds by postgrey-1.36 at gabe;
 Wed, 20 May 2026 09:06:43 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [46.38.247.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC3610EF7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 09:06:43 +0000 (UTC)
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
 by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4gL57L2cdnz8Bhl;
 Wed, 20 May 2026 10:58:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1779267534;
 bh=kmrXM2xDfbqfbD/fPnVMn722OKYUpDmg0PIS/FT5SZg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TiS8wmmgmEN3MmJ97cDmmZS8IBihnWHKhIwMnVLkARVLaOj2ScsgoWL+p6Eca13Up
 tAsME4F78gk0PMpZ7A0/q29X/7i13398cZiojoyhZptQyVFVVIePw+h1dbleeyyUxq
 LrlTUsrn1bAvl0CqiYY8+7YtOIKTJuUtpN967X71k/aKQEPRtvwNN+LwDxyd1jNpJp
 KPjk4pWiMWnRNvAQ4CoUAcdlA6YIHeWYlxWXtRR95//I6E1ehgB0ab6Ktndveb+/lw
 h8BbSNQauyLac/bbTp3sDtAVim9NEHULXRI3BYoPt/uZ7G44stU+EcGtXs9bBNStVx
 lY/lsDT7Ra0Ew==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4gL57L1vx9z4x86;
 Wed, 20 May 2026 10:58:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gL57K0Kq4z8tYl;
 Wed, 20 May 2026 10:58:53 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 56A1D6034C;
 Wed, 20 May 2026 10:58:52 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <3e181f99-42d3-484f-a89b-2f5955146a5b@leemhuis.info>
Date: Wed, 20 May 2026 10:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 7.0-rc4 dcn31_program_compbuf_size trace
To: Minxi Hou <houminxi@gmail.com>, jwollrath@web.de
Cc: amd-gfx@lists.freedesktop.org, Eric Naim <dnaim@cachyos.org>,
 Bhuvanachandra Pinninti <bpinnint@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 Antonio Quartulli <antonio@mandelbit.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260316094232.6bb6f0bf@schienar>
 <20260518080835.100682-1-houminxi@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260518080835.100682-1-houminxi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177926753273.259557.14850135628493609089@mxe9fb.netcup.net>
X-NC-CID: G1osxqXGYcLY/uTBF2vW+9WvFR2CJOYw9Mw7Dp7IC2jHdK6N1ds=
X-Mailman-Approved-At: Thu, 21 May 2026 07:01:28 +0000
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

[+a few people]

On 5/18/26 10:08, Minxi Hou wrote:
> On Mon, 16 Mar 2026 09:42:32 +0100, Julian Wollrath wrote:
>> when turning the display off via 'xset dpms force off' I observe the
>> following warning and trace under 7.0-rc4 with a AMD Ryzen 7 PRO 8840U
> 
> I can reproduce the same warning on different hardware with a different
> trigger.
> 
> Machine: HP Z66 G6 14 (ProBook 4 G1ah), AMD Ryzen 7 H 255 (HawkPoint1),
> kernel 7.0.8-200.fc44.x86_64.
> 
> Trigger: HDMI hotplug with an external 4K monitor. The Z66's HDMI port
> uses a DP-to-HDMI protocol converter with FRL support (dmesg shows
> "DP-HDMI FRL PCON supported"). Connecting the monitor at boot causes
> the first timeout during initialization; subsequent hotplug events
> repeat it at runtime.
> 
> The call trace matches yours exactly:
>   dcn31_program_compbuf_size line:141
>   dcn20_optimize_bandwidth
>   dc_commit_state_no_check
>   dc_commit_streams
>   amdgpu_dm_atomic_commit_tail
> 
> Not seen with 6.19.x. CachyOS community bisected this to:
> 
>   commit 592c5b80110d5e9e50873b5364818cb6f401e26d
>   "drm/amd/display: Migrate HUBBUB register access from hwseq to hubbub component"

Antonio posted a RFC fix for that comment here with a reference to a
warning that on a *very quick* look looks similar:
https://lore.kernel.org/all/20260519144509.2646680-1-antonio@mandelbit.com/

Wondering if we need a ticket here to get this resolved:
https://gitlab.freedesktop.org/drm/amd/-/work_items/

But from the reply to Antonio's patch is sounds like it's not needed.

Ciao, Thorsten

> One thing I noticed on my setup: the amdgpu driver defaults to
> max_bpc=16 for the HDMI connector. With a HDMI 2.0 monitor (BenQ
> EL2870U, Max TMDS 340 MHz) at 4K@60Hz, the higher color depth
> increases bandwidth demand during compbuf reprogramming and makes the
> timeout happen more often. Adding amdgpu.deep_color=0 helps but does
> not fix the root cause.
> 
> Partial workaround:
>   amdgpu.runpm=0 amdgpu.gfx_off=0 amdgpu.deep_color=0
> 
> A patch proposed by Giuseppe Ranieri in the CachyOS issue tracker [1]
> changes the REG_WAIT parameters from 1us*100 to 1000us*30 and resolves
> the warning for several users with DCN 3.1 hardware. Discussion there
> is ongoing about whether 2-10us*1000 would be a better fit.
> 
> [1] https://github.com/CachyOS/linux-cachyos/issues/810
> 
> Minxi Hou


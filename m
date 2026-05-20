Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7E6CD4F5E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 07:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10A010E091;
	Wed, 20 May 2026 07:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q5GWE7J4";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE4310EF49
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 07:49:22 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gL3b32G3Lz9v8b;
 Wed, 20 May 2026 09:49:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779263359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kneXu0dudDxw2Q/FUh/dwchoPSoTiKGSuKWrOuL0Z20=;
 b=q5GWE7J4BIRPX4ppu3UgQ0tsZ9xoAg1YNCMdnFGghmiqom0v/IED63Zg5g+PyBIGu9B/c1
 4BVXbD6OIATDXlXThc5hoCbR6PbuMs0lQb67VNc+Gum2wosjEBDf9lE+6iTUsXKklVDe6L
 1XA6JE5y7BFWSdWmCpN0DTpGzhfZTsyjfrFa9jpm+QOupmOouY1VOXkrz82RoWEJ0wGw+M
 u6/j6/0HqJzO4fo1kdyo4C/LGhmdF8ota8JqT4XrPyWxvlL/a7Z24hXoF8iXgPv/Lpk3Uz
 gvpra7CI6ZZoPOrwBVWAPFsMoWhX2IcpfhPGQjw1vQsU4hG6vOI9+uWWjRgaLw==
Message-ID: <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
Date: Wed, 20 May 2026 09:49:17 +0200
MIME-Version: 1.0
Subject: Re: Test result / finding of "drm/amd/display: Consult MCCS FreeSync
 cap only if requested & supported"
To: Pei-Hsin Yang <peihsiny@valvesoftware.com>
References: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
In-Reply-To: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7d5863e5518f2d7eb06
X-MBO-RS-META: djog3ijsh8zpqd6d5qfa6coxnzdfjjfa
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

On 5/19/26 22:12, Pei-Hsin Yang wrote:
> 
> Here is my test result and finding after applying Michel Dänzer’s patch on May 18, 2026 to SteamOS 6.16 branch.
> 
>  
> 
> Applied patch from Michael Dänzer to SteamOS 6.16.
> 
>  
> 
> Tested with 3 HDMI sinks with different FreeSync/HDMI VRR capabilities.  I saw one case that a FreeSync sink (Dell S2721HS) with E6h VCP code supported was detected as FreeSync capable at beginning but identified as not FreeSync capable later – after do_mccs is changed from true to false.

And that doesn't happen without my patch applied?


> I understood the recent implementation to determine freesync_capable is trusting hardware (via MCCS VCP transaction) over EDID.  But in real world application, it does cause certain false detection to inadvertently disable the VRR.
> 
>  
> 
> My opinion is: If EDID has AMD FreeSync VSDB specified with valid refresh rate range, then it should be determined as FreeSync capable.  As for MCCS VCP Code support, it is used to send Set command to sink to enable/disable the VRR handling.  Result of dm_helpers_read_mccs_caps() at runtime should not override the freesync_capable value.  Because the impact of MCCS VCP Code Set command failure is significantly lower than the disabling VRR when sink is capable.

I basically agree.


TBH I don't really want to be fixing the regression I hit, I'd prefer the AMD display team to handle it.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

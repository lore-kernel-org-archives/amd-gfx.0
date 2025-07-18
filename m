Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F549C87FC3
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 15:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D0D10E21C;
	Sun, 20 Jul 2025 15:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="ipPcvZM3";
	dkim=pass (2048-bit key; unprotected) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="XJuhlFvi";
	dkim-atps=neutral
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [91.218.175.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C2C10E9CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=mCJTMl6hmU/t/
 n7RMrAexSGMCuHAoxTnyKTXuygkquM=;
 h=in-reply-to:references:subject:cc:
 to:from:date; d=hacktheplanet.fi; b=ipPcvZM3bpMRJzxRS0cot5qFHDc+uFbNh/
 hJrhoxcKvc68HaecB44RlKS7zlclhqvmPniNnPsgpormEgUYIVt6FDOowL7BvGrzRvlvjN
 otPTSFQUyLVli7gPNsRtNMZlz9J2nvVjLHpcDvUn2N9IQhYfUx3uh57SqfMgMRkc3bsOH0
 YXVuBwLGfTW5mwbyxFuTVNwfs/r6vkgDRihTr+MeGUrCO0Q9wT1Y264pYbO5NiR2Ub5/I7
 je7NJ2i8fwnZOy9YJkZMXLdWZrsX6ja4gVfP5V8KpCcUZxmIEfvG0a0vaTnNky58NwqVaR
 yO13azxNMKaq2ZkNDH/eVRUdb84A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
 s=key1; t=1752849384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U4fWzDUDVjTYg2bPTnEOawxX6k0jS8mMVyArseOI0Ro=;
 b=XJuhlFvinkI3yznxCnIYv2c0XaEPy6pnW/s+axNlivjtyGr1LBuHtl9DMslPWcbGJOEUI2
 NJKOpBr6bVvFxOtkeDf2x/i1lqyo0h3D0fk3h7GvAnkI189C++7fCwsBPCcd9+1beaeaKk
 vlBmjvmrd1fG82LdTsqNjDR1Up5AZepcwFD/6XEcyCn9TvbQK1pJSJeAQa37bOZYEUTNR1
 6+fC2dKgKnu+70i+2Hrdy5ajG6SUg59oPhq9YuuImiVhC5735Mcz7oLPX06Y/ywteZK77h
 AbGzTzFLwmQqmBtfqA28gVhfve6tglukDQQ+EnkyfN4seCDrbWcNjhknLAcDxg==
Date: Fri, 18 Jul 2025 23:36:17 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] drm/amd/display: backlight brightness set to 0 at
 amdgpu initialization
Message-ID: <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Sun, 20 Jul 2025 15:32:54 +0000
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

On Fri, Jul 18 2025 08:10:06 -0500, Mario Limonciello wrote:
> Do you by chance have an OLED panel?  I believe what's going on is that
> userspace is writing zero or near zero and on OLED panels with older kernels
> this means non-visible.

Yes, this is an OLED panel. But I don't believe it's userspace writing
anything at this point in the boot; before the bisected commit,
brightness was set to 32 (out of max 255) on this hardware when I
checked from the initramfs rescue shell. At the bisected commit, it's 0
(out of max 255).

> There is another commit that fixes the behavior that is probably missing.

Which commit is that? It's not in 6.15.7?

-- 
Lauri Tirkkonen | lotheac @ IRCnet

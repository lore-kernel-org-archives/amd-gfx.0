Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10BEC87FC5
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 15:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFF210E44E;
	Sun, 20 Jul 2025 15:33:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P4pfsF6G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA3F10E1CD
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 10:26:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AC3E043BE7;
 Sun, 20 Jul 2025 10:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C786C4CEE7;
 Sun, 20 Jul 2025 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1753007211;
 bh=Pz8ePT3kQcq17jbtptxl1AKFPCx1WvRQsWQDiB0w498=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P4pfsF6Gch1EW10+BCYiQjpN9WTd9OYx/ty8wcBjeYU4y1TPaDNfLUXuPb1Uc0Fft
 aDvo08qO75RRzbaHhXT+kXTVET54Fh0Qq2T0+eB94My+Lq7Oh6ebl6y6eXAQ6TrVdu
 KPY9PEFL5/vZPLn/6uLCstH654SHa1YH9ZwqiCvc=
Date: Sun, 20 Jul 2025 12:26:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: Mario Limonciello <superm1@kernel.org>, stable@vger.kernel.org,
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 Wayne Lin <wayne.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [REGRESSION] [PATCH] drm/amd/display: fix initial backlight
 brightness calculation
Message-ID: <2025072012-deluge-arbitrate-9129@gregkh>
References: <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
 <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
 <aHr--GxhKNj023fg@hacktheplanet.fi>
 <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
 <cc7a41dc-066a-41c8-a271-7e4c92088d65@kernel.org>
 <aHy4Ols-BZ3_UgQQ@hacktheplanet.fi>
 <aHy4tohvbwd1HpxI@hacktheplanet.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHy4tohvbwd1HpxI@hacktheplanet.fi>
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

On Sun, Jul 20, 2025 at 06:36:54PM +0900, Lauri Tirkkonen wrote:
> DIV_ROUND_CLOSEST(x, 100) returns either 0 or 1 if 0<x<=100, so the
> division needs to be performed after the multiplication and not the
> other way around, to properly scale the value.
> 
> Fixes: 6c56c8ec6f97 ("drm/amd/display: Fix default DC and AC levels")

This should be a commit id in Linus's tree, NOT in just one stable
branch.

Also, you forgot to add a cc: stable@vger.kernel.org so that it will be
picked up by a stable release.

thanks,

greg k-h

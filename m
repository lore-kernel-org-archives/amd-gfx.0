Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14236E98E0B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B5410E290;
	Mon, 23 Feb 2026 08:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jiY6AZ35";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ADED10E120;
 Sat, 21 Feb 2026 05:41:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E6E2944206;
 Sat, 21 Feb 2026 05:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68461C4CEF7;
 Sat, 21 Feb 2026 05:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1771652500;
 bh=dILJaJLWNaymGhs7gSN08DU8nY4kViwy9GwyMBXqpl8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jiY6AZ35TrJOFjA1SxH9rqIxI/9lg0sGDlmZm4m0KItyXLqq+68cSfrFgFjKVITcq
 ZZccWg8G7+I79sWX/wGnmMyCbKuUXT3k0pckiYC4UCTzEtXnKB2iFiou75i6IDzYGD
 j90LzJWXFruCYdx0DAIk4Y63nBRMxqvFEmHfrGhI=
Date: Sat, 21 Feb 2026 06:41:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "open list:AMD POWERPLAY AND SWSMU" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] 6.12 and below: amdgpu: fix panic with SI and DC
Message-ID: <2026022126-calculate-matador-e7bd@gregkh>
References: <20260221034402.69537-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221034402.69537-1-rosenp@gmail.com>
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:29:05 +0000
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

On Fri, Feb 20, 2026 at 07:44:00PM -0800, Rosen Penev wrote:
> The first commit is needed for the second one to be reverted cleanly.
> 
> The second breaks DC support on my AMD 7750. Kernel panics and I get a
> black screen on boot. With these two reverted, 6.12 is usable again.
> 
> Tried to git cherry-pick the fixes but that proved to be difficult to
> do cleanly.
> 
> I see 6.6 also has these two commits.
> 
> Not sure what the proper procedure is to request reverts on stable
> kernels.

Close, see my comments on the first patch.

thanks,

greg k-h

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716C9FEE4E9
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Feb 2026 09:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10D010EC61;
	Sat, 28 Feb 2026 09:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/abKRFI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D907710E0E4;
 Sat, 28 Feb 2026 01:28:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F32643A08;
 Sat, 28 Feb 2026 01:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4101C116C6;
 Sat, 28 Feb 2026 01:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1772242102;
 bh=QVTdJpksh0R6F5V/824NY/+c7ANoYX1Yr9+hZikFsN8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e/abKRFIhVVasV6wH/QrhcfHlEjash7A1FDlpXfrOzXnL0oV3NpNcaKnoO0OVpiO/
 eTXMOOeh3i1JNd5X9fsOznNZ3+P/YxKO3q1fRRYMVf2olpG4ZsAHhHZ7hXcdueTP1+
 gz4AeEEPvNTtO8wrepZWhYHeZZ2CyzpNI3Bvofpk=
Date: Fri, 27 Feb 2026 20:28:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Eliav Farber <farbere@amazon.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Bert Karwatzki <spasswolf@web.de>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Wentao Liang <vulab@iscas.ac.cn>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for 6.1 0/2] prepare to fix panic on old GPUs
Message-ID: <2026022733-backhand-acquaint-233a@gregkh>
References: <20260228011213.423524-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228011213.423524-1-rosenp@gmail.com>
X-Mailman-Approved-At: Sat, 28 Feb 2026 09:19:10 +0000
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

On Fri, Feb 27, 2026 at 05:12:11PM -0800, Rosen Penev wrote:
> In order to backport upstream fixes for black screen on boot with DC
> and old GPUs, These two commits need backporting for 6.1.

What fixes exactly?  Please make them part of the series, otherwise it
makes no sense for us to take them.

Also, you forgot to sign off on these patches, so we couldn't take them
even if we wanted to :(

thanks,

greg k-h

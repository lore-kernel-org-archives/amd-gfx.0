Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13464E98E0A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8BC10E27D;
	Mon, 23 Feb 2026 08:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQ7uNqDd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB3110E123;
 Sat, 21 Feb 2026 06:34:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E99760053;
 Sat, 21 Feb 2026 06:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A85DC4CEF7;
 Sat, 21 Feb 2026 06:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1771655638;
 bh=hHq5dcyYTdFsZlLYK9nRJEVSiMhOiqtXt6G6U+a034A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TQ7uNqDdWUiZrYJoxLWRuOOS4giMJEmmrXgRY7Zr/haqVJZBl3BouBqAc/w1TjTCZ
 d8iCXbdnlWDVnaIWFMnV8BZSPm1GieSjsz6n+rNbSjlSdg9B974EGiZpEdK2rcue2r
 RC0Rf5gKCZMlzw+g4o2aOK4eKNWNUmt5kHVGCcHY=
Date: Sat, 21 Feb 2026 07:33:55 +0100
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
Subject: Re: [PATCH 2/2] Revert "drm/amd/pm: Disable SCLK switching on Oland
 with high pixel clocks (v3)"
Message-ID: <2026022126-chair-spout-641a@gregkh>
References: <20260221034402.69537-1-rosenp@gmail.com>
 <20260221034402.69537-3-rosenp@gmail.com>
 <2026022148-unsorted-pushover-8262@gregkh>
 <CAKxU2N9dJg9dy05h6oGgWidc81-kdGw=jUuM-i4KL1=EhevrZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9dJg9dy05h6oGgWidc81-kdGw=jUuM-i4KL1=EhevrZw@mail.gmail.com>
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:29:06 +0000
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

On Fri, Feb 20, 2026 at 09:52:29PM -0800, Rosen Penev wrote:
> On Fri, Feb 20, 2026 at 9:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 20, 2026 at 07:44:02PM -0800, Rosen Penev wrote:
> > > This reverts commit 0bb91bed82d414447f2e56030d918def6383c026.
> > >
> > > This commit breaks stable kernels older than 6.18 that are booted with
> > > radeon.si_support=0 amdgpu.si_support=1 amdgpu.dc=1
> > >
> > > In 6.17, threre are further commits that are needed to get the DC
> > > codepath in amdgpu for Southern Islands GPUs working but they seem to be
> > > too much of a hastle to backport cleanly. The simplest solution is to
> > > revert this problematic commit
> >
> > Ok, this is better, but still, this only applies to 6.12.y, right?
> The reverted commit (or rather the one from master) was backported to
> at least 6.12 and 6.6. I didn't check what other kernels include it.

I see it in the following kernel releases:
	6.1.156 6.6.112 6.12.53 6.17.3 6.18

All except 6.17.y is currently being supported.

thanks,

greg k-h

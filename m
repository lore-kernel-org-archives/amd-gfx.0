Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C67AE98E0E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9966610E295;
	Mon, 23 Feb 2026 08:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yg7fznlM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B301E10E04D;
 Sat, 21 Feb 2026 06:33:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 088D5440F6;
 Sat, 21 Feb 2026 06:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C86C4CEF7;
 Sat, 21 Feb 2026 06:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1771655585;
 bh=caYN/1ZHoXnmBXJ/pT/J0UP8KCsi4oMgXHnH+pcWTj4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yg7fznlMJoEOg8cCoqbUhIB+kzehIXTov2fnMzlbPNC5Pok2m4eLQTPV7i7db1N1o
 C7ntz/7MKNOEWf+ECYr6Z2YWLlNISV03vyU8wEsF2h4am12nzET+5f2O0fP2hM9o06
 FOjnPl7QcVW2fieCnnfFzBgqwYosLsbyVMiwMS1w=
Date: Sat, 21 Feb 2026 07:33:02 +0100
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
Subject: Re: [PATCH 1/2] Revert "drm/amd/pm: Disable MCLK switching on SI at
 high pixel clocks"
Message-ID: <2026022124-creature-extenuate-34da@gregkh>
References: <20260221034402.69537-1-rosenp@gmail.com>
 <20260221034402.69537-2-rosenp@gmail.com>
 <2026022132-gem-stylishly-2c49@gregkh>
 <CAKxU2N8g+BRzyZ=5dWjrL3Eb4zRz-_yfv29tfJL2uvJpZWZUcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8g+BRzyZ=5dWjrL3Eb4zRz-_yfv29tfJL2uvJpZWZUcw@mail.gmail.com>
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

On Fri, Feb 20, 2026 at 09:54:02PM -0800, Rosen Penev wrote:
> On Fri, Feb 20, 2026 at 9:40 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 20, 2026 at 07:44:01PM -0800, Rosen Penev wrote:
> > > This reverts commit d033e8cf4e8f6395102cdbc3cb00dc7cb9542f53.
> >
> > Why?  You need to explain why you do something, not just what you are
> > doing.
> Not sure how to specify that it's a requirement for the second patch
> so that git revert works without problems.

Just say so, nothing complex here, just describe the problem and what is
needed to resolve it.  This ends up in the changelog, your patch 0/2
does not.

thanks,

greg k-h

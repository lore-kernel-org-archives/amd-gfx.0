Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6F9CA6002
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA0C10EBCD;
	Mon,  5 Oct 2026 07:28:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iVUoeIeK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB71610E0FE
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 14:12:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 57A0040DA4;
 Sat,  3 Oct 2026 14:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01EC1F0089B;
 Sat,  3 Oct 2026 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1791036725;
 bh=P3v29nLDCqH85Ja4FY16YyWLhmvfC0hUp7w90sSZd3E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iVUoeIeKSUc9uB0RLbEMdw5Nj2upjvYU0qmwe48/EEfcP+wJz4Ali0tQZWBKQK+Eg
 TU36FkjgChU73KUvs23tfe+BgvjPg0L6rCjx2MDgmegJLU0rza1v/H2hOHVwZp41Zz
 zi34rbJPlc3oUnaiMlV5O0WclGTdslCUuRobhj4c=
Date: Sat, 3 Oct 2026 16:11:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Mesa <miguel@miguelmesa.com>
Cc: stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Jerry.Zuo@amd.com,
 harry.wentland@amd.com, mario.limonciello@amd.com, mgorny@gentoo.org
Subject: Re: [PATCH 7.2.y] drm/amd/display: keep HDMI 4:2:0-only modes and
 automatic 4:4:4
Message-ID: <2026100353-vintage-skipper-594a@gregkh>
References: <20261003131523.1502250-1-miguel@miguelmesa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003131523.1502250-1-miguel@miguelmesa.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 07:28:12 +0000
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

On Sat, Oct 03, 2026 at 03:15:23PM +0200, Miguel Mesa wrote:
> commit 7e5760f084d0 ("drm/amd/display: add HDMI 2.1 Compliance Support")
> selects YCbCr 4:2:0 for a 4:2:0-only mode only when the IGT override asks
> for it, and YCbCr 4:4:4 only when that override is YCbCr 4:4:4. On a
> normal boot the override is unset.
> 
> A 3840x2160@60 mode that the sink lists only in the YCbCr 4:2:0 block
> then falls through to 4:4:4 or RGB, and the Wayland session cannot build
> the output layer: kwin_wayland_drm: Failed to create framebuffer (EINVAL)
> right after login. v7.3-rc5 selects 4:2:0 again for those modes when the
> color format is automatic. Do the same here, including HDMI FRL.
> 
> Keep automatic YCbCr 4:4:4 for the other HDMI modes, as 7.1 did. The TMDS
> depth fallback also runs for HDMI FRL, so a mode that does not fit at
> 4:4:4 can still drop to 4:2:0.
> 
> This is not a backport of a mainline commit. The 7.3 fix is the rewrite
> in 0b0ff65d3c ("drm/amd/display: Refactor stream validation"), which
> cannot be cherry-picked to 7.2;

Why not?  What's preventing that?  We'll gladly take large sets of
patches to fix bugs, in fact we prefer to.

> Jerry Zuo confirmed the pre-7.3 logic is
> gone there. This patch restores the pre-regression selection on the 7.2
> code, following the v7.3-rc5 rule. Mario Limonciello asked for it to be
> sent to stable in drm/amd#5760.
> 
> Regression: black screen after login on HDMI sinks whose modes fall
> through to RGB, e.g. Strix Halo (gfx1151) + TCL 4K TV whose 3840x2160@60
> is YCbCr 4:2:0-only (VIC 97). 7e5760f084d0 shipped in 7.2; still unfixed
> in 7.2.9.
> 
> Tested on CachyOS linux-cachyos-bore 7.2.7-3 (znver4) on that Strix Halo
> box: Plasma runs at 3840x2160@60 with the same userspace and firmware
> that stayed black on every stock 7.2.x kernel.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5760
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5893
> Reported-by: Michał Górny <mgorny@gentoo.org>
> Reported-by: Miguel Mesa <miguel@miguelmesa.com>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Miguel Mesa <miguel@miguelmesa.com>
> Signed-off-by: Miguel Mesa <miguel@miguelmesa.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>

A bot can not be an author.  Please read the documentation for how to
use a LLM in the kernel.

thanks,

greg k-h

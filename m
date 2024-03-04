Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4F0C5478C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 14:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7AE1121EA;
	Mon,  4 Mar 2024 14:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P4s0sK4x";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7095D10FFA0
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 10:42:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BE13960CF4
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 10:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ECBC433C7;
 Mon,  4 Mar 2024 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1709548968;
 bh=V5fcT4xKaaljAl/3SVxmCZ7qFbY1AvXsibo4PeR1n2w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P4s0sK4xISCq6LtGbcEioHxTeDFVSSEMdHoL+p4dQcMak25CyxHh7C4WimnXl/mxJ
 u/2mCaEUtxwKMm3QPsc2DQ7GevUTCbUW7EyJ/qreyZlVZu1Xccs76BCkItY79LX3HS
 nrFqX2ds+pvE+XseDAIRLPfycxeJdo8fSsItLK3I=
Date: Mon, 4 Mar 2024 11:42:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Please apply commit 5b750b22530fe53bf7fd6a30baacd53ada26911b to
 linux-6.1.y
Message-ID: <2024030439-setback-dandruff-edfb@gregkh>
References: <20240228014555.GA2678858@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228014555.GA2678858@dev-arch.thelio-3990X>
X-Mailman-Approved-At: Mon, 04 Mar 2024 14:16:56 +0000
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

On Tue, Feb 27, 2024 at 06:45:55PM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please apply upstream commit 5b750b22530f ("drm/amd/display: Increase
> frame warning limit with KASAN or KCSAN in dml") to linux-6.1.y, as it
> is needed to avoid instances of -Wframe-larger-than in allmodconfig,
> which has -Werror enabled. It applies cleanly for me and it is already
> in 6.6 and 6.7. The fixes tag is not entirely accurate and commit
> e63e35f0164c ("drm/amd/display: Increase frame-larger-than for all
> display_mode_vba files"), which was recently applied to that tree,
> depends on it (I should have made that clearer in the patch).
> 
> If there are any issues, please let me know.

Now queued up, thanks.

greg k-h

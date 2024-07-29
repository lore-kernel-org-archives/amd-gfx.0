Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAB4C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA3110E4EB;
	Tue, 30 Jul 2024 07:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DcHfSgzz";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5983E10E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 09:45:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6CF5B61228;
 Mon, 29 Jul 2024 09:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C199DC32786;
 Mon, 29 Jul 2024 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1722246347;
 bh=8ZQ2zn8Or662G4pel4BS2xL70Ie4jCL8uD1hXV8e5Jg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DcHfSgzzSx5coCWMXPNoB1SkS9rT4jQVG9XZ+t5ASf+JFYpULeeyTV+C14HTxkysd
 ZGbrkiyDhEJmLfOdM1E5+jeyUQRECuNsDMKBuFFytinE2rjp5AoMUjXcEMOqTEb7fB
 /xRq5iEDNyFskPRqJLMsOK8okpUf58AKWiWq/GNk=
Date: Mon, 29 Jul 2024 11:45:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: mikhail.v.gavrilov@gmail.com, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: fix corruption with high refresh rates
 on DCN 3.0
Message-ID: <2024072937-undivided-liver-b59b@gregkh>
References: <20240716173322.4061791-1-alexander.deucher@amd.com>
 <a3af3f0b-df81-4407-a38d-2fa35b33b08c@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3af3f0b-df81-4407-a38d-2fa35b33b08c@leemhuis.info>
X-Mailman-Approved-At: Tue, 30 Jul 2024 07:54:54 +0000
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

On Mon, Jul 29, 2024 at 10:31:38AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 16.07.24 19:33, Alex Deucher wrote:
> > This reverts commit bc87d666c05a13e6d4ae1ddce41fc43d2567b9a2 and the
> > register changes from commit 6d4279cb99ac4f51d10409501d29969f687ac8dc.
> > 
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3478
> > Cc: mikhail.v.gavrilov@gmail.com
> > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > [...]
> 
> Hi Greg, quick note, as I don't see the quoted patch in your 6.10-queue
> yet: you might want to pick up e3615bd198289f ("drm/amd/display: fix
> corruption with high refresh rates on DCN 3.0") [v6.11-rc1, contains
> table tag] rather sooner than later for 6.10.y, as the problem
> apparently hit a few people and even made the news:
> https://lore.kernel.org/all/20240723042420.GA1455@sol.localdomain/
> https://www.reddit.com/r/archlinux/comments/1eaxjzo/linux_610_causes_screen_flicker_on_amd_gpus/

Thanks, now queued up.

greg k-h

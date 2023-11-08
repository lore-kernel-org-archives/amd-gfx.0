Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5727CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 14:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1430710E77A;
	Wed,  8 Nov 2023 14:11:55 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C2210E064
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 07:52:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CD0A2614ED;
 Wed,  8 Nov 2023 07:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2121FC433C8;
 Wed,  8 Nov 2023 07:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1699429972;
 bh=3PeDvtMdSO3qjEIRN0wzlZUivW+dRg1lpgO8Cx8G+fY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hSt2svxHMxfcvq8fGAArYucSippdqVxYXhNKd4RbHB/xNIehdFm4zoG/NKJidho+v
 +Q7b0VeYVrWNhucZHAsGu0uMmvRCiek/mNXiEJOpEU7cVcOJ3pdSbC8Qn7IN6OROSy
 I0cugCSoAjzPQE3lrRKchuGsf0Dbwp2mZVsm5CNA=
Date: Wed, 8 Nov 2023 08:52:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
Message-ID: <2023110833-renegade-fidgety-a008@gregkh>
References: <20231108033359.3948216-1-li.ma@amd.com>
 <2023110845-factual-dawn-7d68@gregkh>
 <9a5ba6df-5d15-4c23-98cd-686b1f62e05b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a5ba6df-5d15-4c23-98cd-686b1f62e05b@gmail.com>
X-Mailman-Approved-At: Wed, 08 Nov 2023 14:11:48 +0000
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
Cc: yifan1.zhang@amd.com, amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 mario.limonciello@amd.com, Alexander.Deucher@amd.com,
 "David S . Miller" <davem@davemloft.net>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 08, 2023 at 08:40:48AM +0100, Heiner Kallweit wrote:
> On 08.11.2023 08:05, Greg KH wrote:
> > On Wed, Nov 08, 2023 at 11:34:00AM +0800, Li Ma wrote:
> >> From: Heiner Kallweit <hkallweit1@gmail.com>
> >>
> >> This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
> >> causes tx timeouts with RTL8168h, see referenced bug report.
> >>
> >> Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
> >> Cc: stable@vger.kernel.org
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> Signed-off-by: David S. Miller <davem@davemloft.net>
> >> (cherry picked from commit 90ca51e8c654699b672ba61aeaa418dfb3252e5e)
> >> ---
> >>  drivers/net/ethernet/realtek/r8169_main.c | 4 ----
> >>  1 file changed, 4 deletions(-)
> > 
> > Is this a proposed stable tree patch?  If so, what kernel(s) are you
> > wanting it applied to?
> > 
> This should have been sent neither to you nor stable@vger.kernel.org.
> This patch has been applied to stable already, the mail is something
> AMD-internal it seems.

Then someone needs to seriously fix their scripts as it is very
confusing :(

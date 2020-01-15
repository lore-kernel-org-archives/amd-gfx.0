Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB9FC33CB3
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 20:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4849124679
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 20:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLHu9wBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4849124679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049A86EB30;
	Wed, 15 Jan 2020 20:17:42 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AA66EB30
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 20:17:40 +0000 (UTC)
Received: from localhost (mobile-166-170-223-177.mycingular.net
 [166.170.223.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C1632064C;
 Wed, 15 Jan 2020 20:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579119460;
 bh=FVWkWszGL3z65oDZ4FHtyBm3OoqEBpNNOugsgaGVLcs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=BLHu9wBt04iSEepGo7az9v2EnYpvKrX9foXUPvXTayGLx2Ad6en7FJuJwJtG6aObP
 jXP+jBB85xIdhP/gxzMPiKzr09s8QKjkoJmiKin1dVYtsHJ1L95fPgfg2cQGyWxM6t
 Zcczu26mh0R5zjUQWmR2QyDuJT0T/zwp3YnPo4ik=
Date: Wed, 15 Jan 2020 14:17:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 0/2] Adjust AMD GPU ATS quirks
Message-ID: <20200115201738.GA190184@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_Onw1JgtAYiJgkdL55pe5UdVaJ7j-Tmj3THikWEs-nbkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Linux PCI <linux-pci@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 15, 2020 at 12:26:32PM -0500, Alex Deucher wrote:
> On Wed, Jan 15, 2020 at 12:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 14, 2020 at 05:41:44PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Jan 14, 2020 at 03:55:21PM -0500, Alex Deucher wrote:
> > > > We've root caused the issue and clarified the quirk.
> > > > This also adds a new quirk for a new GPU.
> > > >
> > > > Alex Deucher (2):
> > > >   pci: Clarify ATS quirk
> > > >   pci: add ATS quirk for navi14 board (v2)
> > > >
> > > >  drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
> > > >  1 file changed, 25 insertions(+), 7 deletions(-)
> > >
> > > I propose the following, which I intend to be functionally identical.
> > > It just doesn't repeat the pci_info() and pdev->ats_cap = 0.
> >
> > Applied to pci/misc for v5.6, thanks!
> 
> Can we add this to stable as well?

Done!  Do you want it in v5.5?  It's pretty localized so looks pretty
low-risk.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

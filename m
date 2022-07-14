Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0335C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 12:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6DC10F65D;
	Thu, 14 Jul 2022 12:23:24 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DB1112A9A
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3ZwteaP4NnrDJ+pme08P/9gfb4eLG/+pqy4tLFWFnzA=; b=QOv58TMYcmxUyS6UiJ7BnIiiKt
 BuKeR2bXbIJea1RuS2ywAiSh4CrY1ftuzQ1kgxypa+bWwr4Knu+1U4Gl3F9RvD5HBVRNuqOCi6qMP
 op2zsevbvDPqe14yPqg+jNOLVmdsiaq5xuAjDjHVWG9r2v0eo51xZPfFkcUGSy1eqWktsQ/8uDV6E
 RjK0z9/fAxxersZPCCUVdD2HUNplnVAaTtmQ640zhlQRiXrsFoJljFckvvDIEYwULcEihJxgT4IxN
 kjLTs41Gt/3bQ+GDElnAvRn/k17ieHOf0PFMn4apLVapgSf1KUUrdrTfAl8laypddwx48Pf02t+rQ
 +j+UuMaQ==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33332)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <linux@armlinux.org.uk>)
 id 1oBxpe-0005ka-77; Thu, 14 Jul 2022 13:20:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1oBxpc-0006bM-NC; Thu, 14 Jul 2022 13:20:36 +0100
Date: Thu, 14 Jul 2022 13:20:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 5.19-rc6
Message-ID: <YtAKFNgeC1vXjHYI@shell.armlinux.org.uk>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
 <CAHk-=wh-SE=s+bJq_jwuQ6zfnifaAwYdXikpXo8iZ4JbbNph4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-SE=s+bJq_jwuQ6zfnifaAwYdXikpXo8iZ4JbbNph4Q@mail.gmail.com>
X-Mailman-Approved-At: Thu, 14 Jul 2022 12:23:23 +0000
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Li <sunpeng.li@amd.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 01:42:15PM -0700, Linus Torvalds wrote:
> On Wed, Jul 13, 2022 at 1:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > That patch is (and has been) in linux-next for a long time,
> > as commit d2ca1fd2bc70, and with the following tags.
> >
> >      Fixes: 7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
> >      Reported-by: Guenter Roeck <linux@roeck-us.net>
> >      Tested-by: Guenter Roeck <linux@roeck-us.net>
> >      Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >      Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> >
> > So, yes, it fixes the problem. I don't know where it is pulled from, though.
> > I thought that it is from Russell's tree, given his Signed-off-by:,
> > but I never really checked.
> 
> Heh. Yeah, with that sign-off, I bet it's in Russell's queue, bit it
> just ended up in the "for next release" branch. Russell?

Oh, I see, I never rebased my "misc" branch from the last cycle, so it
looks to me like 9192/1 was due for _this_ merge window - so I merged
the fix for it into that same branch, rather than the "fixes" branch.
I've moved it over to the correct branch now.

Looks like there's another fix that's in that very same state as well.

Expect a pull request shortly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

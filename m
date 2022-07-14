Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3E7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 12:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F303D1120F3;
	Thu, 14 Jul 2022 12:15:22 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BE210EABE
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8IsG3X6zCfF6DLdWoVTEy5WGlpBO4SysD3lWEtSUkiM=; b=jnnl+pDIp9qmpJESNHT4kZK9Sk
 wv6gsqi+CQ1dQqvqbWqrsgN/o6Q9ZUcR8/t8t37+FaKkyP2/zBN7JmcOK6VorXpf5Mo0ac0epXuBB
 NZRhSYJvIyY4pLELJxngsRsSbUPw/4wbtFdiQzirnWeYOdg7zCPBJFYZhR3uQmAd8apivkpdswyLj
 GgcwVFrNVAMe5RdkExrbtqDc9bUSyUK1i+Y9r4II38IqRnUkPoLJi9a4T41oCq6WfRx0Flki8VxBr
 gosBlbUYIvxyLgmzyGiIBsghk7C2y1P8A30o2qYnP5K3kUC72JqSTR8appZuJpfjT0qhl4AuIbRZ0
 OX/U1diw==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33330)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <linux@armlinux.org.uk>)
 id 1oBxjP-0005k5-MF; Thu, 14 Jul 2022 13:14:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1oBxjJ-0006b8-ND; Thu, 14 Jul 2022 13:14:05 +0100
Date: Thu, 14 Jul 2022 13:14:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.19-rc6
Message-ID: <YtAIjVDa7IKRO3JX@shell.armlinux.org.uk>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
X-Mailman-Approved-At: Thu, 14 Jul 2022 12:15:21 +0000
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
 Linus Torvalds <torvalds@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 01:40:41PM -0700, Guenter Roeck wrote:
> On 7/13/22 13:21, Linus Torvalds wrote:
> > On Wed, Jul 13, 2022 at 12:49 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > 
> > > There may be a patch that solves that, but it's never been submitted to
> > > my patch system:
> > > 
> > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > 
> > That patch looks sane to me, but I guess Guenter would need to check
> > ... Guenter?
> > 
> 
> That patch is (and has been) in linux-next for a long time,
> as commit d2ca1fd2bc70, and with the following tags.
> 
>     Fixes: 7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
>     Reported-by: Guenter Roeck <linux@roeck-us.net>
>     Tested-by: Guenter Roeck <linux@roeck-us.net>
>     Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>     Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> So, yes, it fixes the problem. I don't know where it is pulled from, though.
> I thought that it is from Russell's tree, given his Signed-off-by:,
> but I never really checked.

Ah, yes, it's in the same bracnh as 9192/1. So if Linus is reporting
that 9192/1 is still a problem in linux-next, then this patch does
_not_ fix it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

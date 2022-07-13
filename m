Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99CDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 19:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA4F10EB44;
	Wed, 13 Jul 2022 19:58:17 +0000 (UTC)
X-Greylist: delayed 447 seconds by postgrey-1.36 at gabe;
 Wed, 13 Jul 2022 19:56:55 UTC
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F86E98B64
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 19:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vLDEqhzo2TaQVwqjUuNT+W0GxvNmOEUkAw73oQRdZgM=; b=qDvNOAgq0NAckeNXodpxM/2sNr
 XXzohI48XYlUc+QzgVkHAnsxXPEJg+UhJnJE5agvMXCyZ625ZYkSmBLlspeiq2dwlhGP5Mdu254xX
 6gCqzUM7W/dnCtlkzn81TGJDdGyHihRArgI+6HXun7sZt9ZeWfgibhRFyIi1tVkOAT8Re7GFzYequ
 6WUJX8AyDSwz0qBFhRuS7fGa12F4/O9Eo58PZk6qxHslGQRaBz7zlDYk2Tlj2Gn8oj9j+rrmCiAIf
 WKY9w3ykUJazd4lNTqPSarhmuCkaHngOBXqizVrRrlLUG0qF6U/BuidZJf4XuoWPy5Bxf5XzcZEAR
 uMe+3n1A==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33320)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <linux@armlinux.org.uk>)
 id 1oBiM4-0004yJ-0v; Wed, 13 Jul 2022 20:49:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1oBiLy-0005vT-Po; Wed, 13 Jul 2022 20:48:58 +0100
Date: Wed, 13 Jul 2022 20:48:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 5.19-rc6
Message-ID: <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
X-Mailman-Approved-At: Wed, 13 Jul 2022 19:58:16 +0000
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

On Wed, Jul 13, 2022 at 12:36:50PM -0700, Linus Torvalds wrote:
> On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > OF: amba_device_add() failed (-19) for /amba/smc@10100000
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
> > refcount_t: underflow; use-after-free.
> 
> This too has been going on since -rc1, but it's not obvious what caused it.
> 
> At a guess, looking around the amba changes, I'm assuming it's
> 
>   7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
> 
> Does reverting that commit make it go away?

There may be a patch that solves that, but it's never been submitted to
my patch system:

https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/

I'm sorry, but I'm utterly crap at picking up patches off mailing lists,
so if stuff doesn't end up inthe patch system, it gets missed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

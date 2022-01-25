Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF65C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 15:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039228968D;
	Tue, 25 Jan 2022 15:39:16 +0000 (UTC)
X-Greylist: delayed 3745 seconds by postgrey-1.36 at gabe;
 Tue, 25 Jan 2022 15:22:41 UTC
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6404410E38E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 15:22:41 +0000 (UTC)
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1nCMg9-0001mq-00; Tue, 25 Jan 2022 15:20:13 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 87595C10D8; Tue, 25 Jan 2022 15:20:02 +0100 (CET)
Date: Tue, 25 Jan 2022 15:20:02 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v5.17-rc1
Message-ID: <20220125142002.GA26778@alpha.franken.de>
References: <20220123125737.2658758-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Tue, 25 Jan 2022 15:39:14 +0000
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
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mips@vger.kernel.org,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <me@tobin.cc>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 24, 2022 at 08:55:40AM +0100, Geert Uytterhoeven wrote:
> >  + /kisskb/src/lib/test_printf.c: error: "PTR" redefined [-Werror]:  => 247:0, 247
> >  + /kisskb/src/sound/pci/ca0106/ca0106.h: error: "PTR" redefined [-Werror]:  => 62, 62:0
> 
> mips-gcc8/mips-allmodconfig
> mipsel/mips-allmodconfig

fixing patch sent.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

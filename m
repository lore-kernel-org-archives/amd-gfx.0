Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF695C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 19:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA92E10E484;
	Mon, 28 Feb 2022 19:06:00 +0000 (UTC)
X-Greylist: delayed 361 seconds by postgrey-1.36 at gabe;
 Mon, 28 Feb 2022 18:26:57 UTC
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8FE10E4BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 18:26:57 +0000 (UTC)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay11.hostedemail.com (Postfix) with ESMTP id 8480C81766;
 Mon, 28 Feb 2022 18:20:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf09.hostedemail.com (Postfix) with ESMTPA id 5C4272002A; 
 Mon, 28 Feb 2022 18:20:29 +0000 (UTC)
Message-ID: <0be9de3920442df490f01b6fb1c42521c3de6190.camel@perches.com>
Subject: Re: [PATCH 1/6] drivers: usb: remove usage of list iterator past
 the loop body
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Jakob Koschel
 <jakobkoschel@gmail.com>
Date: Mon, 28 Feb 2022 10:20:28 -0800
In-Reply-To: <20220228112413.GA2812@kadam>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-2-jakobkoschel@gmail.com>
 <20220228112413.GA2812@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1e1i8ombnsc3cdkptu3anccezjc89zox
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5C4272002A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+i6vY6IDwHpNq++UEo/5hqvP4PvgQNb4E=
X-HE-Tag: 1646072429-12569
X-Mailman-Approved-At: Mon, 28 Feb 2022 19:05:59 +0000
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
Cc: alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-iio@vger.kernel.org,
 nouveau@lists.freedesktop.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 dri-devel@lists.freedesktop.org, Cristiano Giuffrida <c.giuffrida@vu.nl>,
 amd-gfx@lists.freedesktop.org, samba-technical@lists.samba.org,
 linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
 linux-arch <linux-arch@vger.kernel.org>, linux-cifs@vger.kernel.org,
 kvm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
 Jason Gunthorpe <jgg@ziepe.ca>, intel-wired-lan@lists.osuosl.org,
 kgdb-bugreport@lists.sourceforge.net, bcm-kernel-feedback-list@broadcom.com,
 linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Arnd Bergman <arnd@arndb.de>, linux-pm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org,
 Brian Johannesmeyer <bjohannesmeyer@gmail.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 v9fs-developer@lists.sourceforge.net, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-sgx@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, tipc-discussion@lists.sourceforge.net,
 linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 2022-02-28 at 14:24 +0300, Dan Carpenter wrote:

> a multi-line indent gets curly braces for readability even though
> it's not required by C.  And then both sides would get curly braces.

That's more your personal preference than a coding style guideline.



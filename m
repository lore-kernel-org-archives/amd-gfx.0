Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C01C47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 14:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58875206D3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 14:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58875206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD6F6E483;
	Mon, 11 May 2020 14:08:43 +0000 (UTC)
X-Greylist: delayed 8731 seconds by postgrey-1.36 at gabe;
 Mon, 11 May 2020 14:08:42 UTC
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net
 [IPv6:2a01:37:3000::53df:4ef0:0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F486E2B1;
 Mon, 11 May 2020 14:08:42 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "*.hostsharing.net",
 Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
 by bmailout2.hostsharing.net (Postfix) with ESMTPS id E85682800932A;
 Mon, 11 May 2020 16:08:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 93056ACC2; Mon, 11 May 2020 16:08:40 +0200 (CEST)
Date: Mon, 11 May 2020 16:08:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 0/6] RFC Support hot device unplug in amdgpu
Message-ID: <20200511140840.kd2yacwvyuaqkxkk@wunner.de>
References: <1589050310-19666-1-git-send-email-andrey.grodzovsky@amd.com>
 <20200511095433.GA206103@phenom.ffwll.local>
 <20200511114307.jfirnlvkikmulyhu@wunner.de>
 <CAKMK7uGA7XHPwuS3GF9u+YQ-GRBfZzf5CCRH15Tx_qnH3Pcchw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uGA7XHPwuS3GF9u+YQ-GRBfZzf5CCRH15Tx_qnH3Pcchw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 11, 2020 at 02:21:57PM +0200, Daniel Vetter wrote:
> On Mon, May 11, 2020 at 1:43 PM Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, May 11, 2020 at 11:54:33AM +0200, Daniel Vetter wrote:
> > > - One unfortunate thing with drm_dev_unplug is that the driver core is
> > >   very opinionated and doesn't tell you whether it's a hotunplug or a
> > >   driver unload. In the former case trying to shut down hw just wastes
> > >   time (and might hit driver bugs), in the latter case driver engineers
> > >   very much expect everything to be shut down.
> > 
> > You can get that information at the PCI bus level with
> > pci_dev_is_disconnected().
> 
> Ok, so at least for pci devices you could do something like
> 
> if (pci_dev_is_disconnected())
>     drm_dev_unplug();
> else
>     drm_dev_unregister();
>
> In the ->remove callback and both users and developers should be
> happy.

Basically yes.  But if the driver is unbound e.g. via sysfs and the
device is hot-removed while it is being unbound, that approach fails.

So you'll need checks for pci_dev_is_disconnected() further below in
the call stack as well to avoid unpleasant side effects such as unduly
delaying unbinding or ending up in infinite loops when reading "all ones"
from PCI BARs, etc.

It may also be worth checking for pci_dev_is_disconnected() in ioctls
as well and directly returning -ENODEV, though of course that suffers
from the same race.  (The device may disappear after the check for
pci_dev_is_disconnected(), or it may have already disappeared but
pciehp hasn't updated the device's channel state yet.)

Thanks,

Lukas
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360FC47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 11:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD77420735
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 11:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD77420735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D8B89D40;
	Mon, 11 May 2020 11:51:45 +0000 (UTC)
X-Greylist: delayed 514 seconds by postgrey-1.36 at gabe;
 Mon, 11 May 2020 11:51:43 UTC
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net
 [83.223.78.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A851789D40;
 Mon, 11 May 2020 11:51:43 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "*.hostsharing.net",
 Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
 by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4913C2802D276;
 Mon, 11 May 2020 13:43:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id F27E2ACC2; Mon, 11 May 2020 13:43:07 +0200 (CEST)
Date: Mon, 11 May 2020 13:43:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 0/6] RFC Support hot device unplug in amdgpu
Message-ID: <20200511114307.jfirnlvkikmulyhu@wunner.de>
References: <1589050310-19666-1-git-send-email-andrey.grodzovsky@amd.com>
 <20200511095433.GA206103@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200511095433.GA206103@phenom.ffwll.local>
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
 ckoenig.leichtzumerken@gmail.com, michel@daenzer.net,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel.vetter@ffwll.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 11, 2020 at 11:54:33AM +0200, Daniel Vetter wrote:
> - One unfortunate thing with drm_dev_unplug is that the driver core is
>   very opinionated and doesn't tell you whether it's a hotunplug or a
>   driver unload. In the former case trying to shut down hw just wastes
>   time (and might hit driver bugs), in the latter case driver engineers
>   very much expect everything to be shut down.

You can get that information at the PCI bus level with
pci_dev_is_disconnected().  The flag queried by this function is set
upon hot removal.  Be aware however that the device is guaranteed to
be unreachable if the function returns true, but the converse is NOT
guaranteed, i.e. the function may return false even though the device
has just gone away.

Those somewhat difficult semantics are one of the reasons why some
people are skeptical of the function's merits (notably Greg KH).
See this LWN article for more information:

https://lwn.net/Articles/767885/
(scroll down to the "Surprise removal" section)

I've suggested to Greg a few years back that we should have a flag
at the device level to indicate whether it's gone, not just at the bus
level.  That way the property could be expressed regardless of the bus
used.  It would facilitate the feature you're missing, that the driver
core tells you whether it's a surprise removal or not.  Unfortunately
Greg rejected the idea.

Thanks,

Lukas
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

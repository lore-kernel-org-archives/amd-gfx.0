Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAEEC77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 15:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F1D10E2DF;
	Thu, 20 Apr 2023 15:57:59 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D04D10E2D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 15:56:24 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CC87360E86;
 Thu, 20 Apr 2023 15:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4063C433D2;
 Thu, 20 Apr 2023 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1682006183;
 bh=Lq0gIWW8Cir+KduE3rUz7uG2k9+bSD+8t1FU5sU5tPk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TCa9VqUAcNZqgV3j5VNB8MLC2gHb7vexX99DfZDpATFpuPS5xSQf6291+8XknbEMU
 yF3BA5c4ByS/Hn+OPZEeKVnKc7SMAlwje2mYyrTaTqXQ3wd/m2Rwj0emAh1v5wsQRC
 +foHqM/XOeIxlpnBf9tUWVhYTpv7DaIzmwZlkPj4=
Date: Thu, 20 Apr 2023 17:56:15 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH 6.1.y] drm/amdgpu/vcn: Disable indirect SRAM on Vangogh
 broken BIOSes
Message-ID: <ZEFgn4iY_swFKnc0@kroah.com>
References: <20230418221522.1287942-1-gpiccoli@igalia.com>
 <BL1PR12MB514405B37FC8691CB24F9DADF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
 <be4babae-4791-11f3-1f0f-a46480ce3db2@igalia.com>
 <BL1PR12MB51443694A5FEFA899704B3EBF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
 <9b9a28f5-a71f-bb17-8783-314b1d30c51f@igalia.com>
 <ZEEzNSEq-15PxS8r@kroah.com>
 <94b63d19-4151-c294-50eb-c325ea9c699f@igalia.com>
 <ZEFUGSlqQu3v8ryf@kroah.com>
 <caf5bfc9-89d2-1320-4386-2c026ec3afcc@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caf5bfc9-89d2-1320-4386-2c026ec3afcc@igalia.com>
X-Mailman-Approved-At: Thu, 20 Apr 2023 15:57:56 +0000
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
Cc: "sashal@kernel.org" <sashal@kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 20, 2023 at 12:36:00PM -0300, Guilherme G. Piccoli wrote:
> On 20/04/2023 12:02, gregkh@linuxfoundation.org wrote:
> >> [...]
> >>> Which "one" are you referring to here?
> >>>
> >>> confused,
> >>>
> >>> greg k-h
> >>
> >> This one, sent in this email thread.
> > 
> > I don't have "this email thread" anymore, remember, some of us get
> > thousand+ emails a day...
> 
> I don't really understand the issue to be honest, we are talking in the
> very email thread! The email was sent April/18, it's not old or anything.

That's 3000+ emails ago for me :)

> But in any case, for reference, this is the original email from the lore
> archives:
> https://lore.kernel.org/stable/20230418221522.1287942-1-gpiccoli@igalia.com/
> 
> > 
> >> The title of the patch is "drm/amdgpu/vcn: Disable indirect SRAM on
> >> Vangogh broken BIOSes", target is 6.1.y and (one of the) upstream
> >> hash(es) is 542a56e8eb44 heh
> > 
> > But that commit says it fixes a problem in the 6.2 tree, why is this
> > relevant for 6.1.y?
> > 
> 
> That is explained in the email and the very reason for that, is the
> duplicate hashes we are discussing here.
> 
> The fix commit in question points the "Fixes:" tag to 82132ecc5432
> ("drm/amdgpu: enable Vangogh VCN indirect sram mode"), which appears to
> be in 6.2 tree, right?
> 
> But notice that 9a8cc8cabc1e ("drm/amdgpu: enable Vangogh VCN indirect
> sram mode") is the *same* offender and..is present on 6.1 !
> 
> In other words, when I first wrote this fix, I just checked the tree
> quickly and came up with "Fixes: 82132ecc5432", but to be thorough, I
> should have pointed the fixes tag to 9a8cc8cabc1e, to pick it on 6.1.y.
> 
> 
> tl;dr: the offender is present on 6.1.y, but this fix is not, hence I'm
> hereby requesting the merge. Some backport/context adjustment was
> necessary and it was properly tested in the Steam Deck.

Ok, we'll queue it up soon, thanks.

greg k-h

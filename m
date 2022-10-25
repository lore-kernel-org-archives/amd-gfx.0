Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E85C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 18:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B61B10E060;
	Tue, 25 Oct 2022 18:52:20 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3564010E060
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 18:52:17 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AD8A861AFD;
 Tue, 25 Oct 2022 18:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B672AC433C1;
 Tue, 25 Oct 2022 18:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666723936;
 bh=TQdJlERfQEUABscmmDLT7Y2HrdNrXv8E1A8x0FSRGM0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HXDjtzO+UBdc1yePh5W/WLyMc2oBVDdqLtEyJlyYfQFURF57pFKrqXSW+UPaZgfDe
 /J5qfQ34amGSi1DcyeqPwJ2zcr9+kab5xk5EakePQ60CKJJ69OixTqZQNqlbPCadn1
 BbtqO81A0cfshr4hly4SDb4WourJsd9sJqFAxtDwMnD9KBRfC5PxIYZj1H7kY7XMlC
 dk7WpufcgTIuHAKKuRaY+n7swd4MfCATpj4+zGaPDHY0VwMjhkd0G9/vxZNmy5sOYn
 8eGQGzXCeqeaekcSMnjCybgm1iXyUZ+WKQjx73kKf6ePmFxUT+B3zDoLmPWmYdi2KT
 vJRF+9c8CHYoQ==
Date: Tue, 25 Oct 2022 11:52:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [linux-next:master] BUILD SUCCESS WITH WARNING
 76cf65d1377f733af1e2a55233e3353ffa577f54
Message-ID: <20221025115214.26a12211@kernel.org>
In-Reply-To: <Y1eccygLSjEoPdHV@shell.armlinux.org.uk>
References: <6356c451.pwLIF+9EvDUrDjTY%lkp@intel.com>
 <20221024145527.0eff7844@kernel.org>
 <Y1eccygLSjEoPdHV@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: kernel test robot <lkp@intel.com>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-mediatek@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 ntfs3@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 25 Oct 2022 09:21:07 +0100 Russell King (Oracle) wrote:
> Not me, Sean. My original implementation of phylink_validate_mask_caps()
> doesn't know anything about rate matching, so my version didn't have
> this issue.
> 
> Sean's version of my patch (which is what was submitted) added the
> dereference that causes this, so, it's up to Sean to figure out a fix -
> but he reading his follow up to the build bot's message, he seems to
> be passing it over to me to fix!
> 
> I've got other issues to be worked on right now, and have no time to
> spare to fix other people's mistakes. Sorry.
> 
> You can't always rely on the apparent author mentioned in the commit to
> be the actual person responsible for the changes in a patch.

Eh, confusing authorship trail, sorry.

I'll send a patch to drop the if (), if it's really needed we'll hear
about it sooner or later.

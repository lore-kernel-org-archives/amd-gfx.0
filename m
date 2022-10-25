Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA0EC38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 13:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF3110E385;
	Tue, 25 Oct 2022 13:12:12 +0000 (UTC)
X-Greylist: delayed 352 seconds by postgrey-1.36 at gabe;
 Tue, 25 Oct 2022 08:27:26 UTC
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EAEC10E278
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EtmojnUqnCVKWOh8C7J92DZrsq9/z0GK3KV0rT9mLpw=; b=BiKMTB/c8/919DvH6LZjZyf2T7
 Lk+Oc0WQgSHrU043Y+cnUTrcCAWFFIRwbP/gwShZJOH7Ph6ZjNkE4YzQLwl+rZ6FQMYOZVZ1KaAAv
 JrHnpzzBk58E6Bw1q1q6MogLgb0j7g2H4c3zZg9FWX17eaRq/RM83PQCbfJMvNXNS9KzKq0aINVsM
 KaygbGcRwn6F39U9DxcVpgeF99Nlne7F879RubTg63DmK7uq37EnDvG5KYZFfCKozoHb2sgk7eO4l
 lwO6xacAFy+7uJjlKmYCqjbyjVIn9IsBwGV8SHQv4hpDF3zC3DsR7nT9nOHu1R4lpXKIo3O5UJycU
 fdMcQzOw==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34940)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <linux@armlinux.org.uk>)
 id 1onFBQ-0004Dt-7i; Tue, 25 Oct 2022 09:21:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1onFBL-0007xV-IX; Tue, 25 Oct 2022 09:21:07 +0100
Date: Tue, 25 Oct 2022 09:21:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [linux-next:master] BUILD SUCCESS WITH WARNING
 76cf65d1377f733af1e2a55233e3353ffa577f54
Message-ID: <Y1eccygLSjEoPdHV@shell.armlinux.org.uk>
References: <6356c451.pwLIF+9EvDUrDjTY%lkp@intel.com>
 <20221024145527.0eff7844@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024145527.0eff7844@kernel.org>
X-Mailman-Approved-At: Tue, 25 Oct 2022 13:12:08 +0000
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

On Mon, Oct 24, 2022 at 02:55:27PM -0700, Jakub Kicinski wrote:
> On Tue, 25 Oct 2022 00:58:57 +0800 kernel test robot wrote:
> > drivers/net/phy/phylink.c:588 phylink_validate_mask_caps() warn: variable dereferenced before check 'state' (see line 583)
> 
> Hi Russell, I think the warning is semi-legit. Your commit f392a1846489
> ("net: phylink: provide phylink_validate_mask_caps() helper") added an 
> if (state) before defer'ing state but it's already deref'ed higher up
> so can't be null.

Not me, Sean. My original implementation of phylink_validate_mask_caps()
doesn't know anything about rate matching, so my version didn't have
this issue.

Sean's version of my patch (which is what was submitted) added the
dereference that causes this, so, it's up to Sean to figure out a fix -
but he reading his follow up to the build bot's message, he seems to
be passing it over to me to fix!

I've got other issues to be worked on right now, and have no time to
spare to fix other people's mistakes. Sorry.

You can't always rely on the apparent author mentioned in the commit to
be the actual person responsible for the changes in a patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

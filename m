Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5598C77B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 19:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBA810E0D1;
	Mon, 29 May 2023 19:18:53 +0000 (UTC)
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com
 (mailrelay6-1.pub.mailoutpod2-cph3.one.com [46.30.211.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E29410E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 19:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=/l6Mg+b7EV4jY8x9miIBhVcWtjESBETdVoWxoFEeAkc=;
 b=LeWJ62Ais/TfMdLjk0WYkuXZzax4iD4BrnE7sSau5wCKsHKRhnZN+zg85cT9kGHq4Y/UTMbSJ/GJq
 u8jNF4U4EedArMWNsmFjKkMkRB7KYlwpwf6vn2xCvSSZp7AR3N/xWyoNDbANeom9faDjz97e2i+mbR
 dGY0+8QE6gyK49Xm24bQuAdV8tFSUQg/zix3zpWcXiXYNPJK5BYl1Xsevo+IDCMIIiKBaVFMlFUTEf
 7XNlBUGHCdhfkdkTnSQe9MUPN++PbC1gY/TzDrg5UQJ4hfKTaswNz2tLZdrf1+vvGsRt2BTE0vUEUo
 T3S1yDxoMpoJXELiRbkj4ygmiv7CD1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=/l6Mg+b7EV4jY8x9miIBhVcWtjESBETdVoWxoFEeAkc=;
 b=EQYlVyX671ncuU52K4e3wUOWPuZLsB7f7qnw/CUh34TTTsTtDQapNrVpQya0JaMBtmjMXqRzvoZbc
 MII6VFLBg==
X-HalOne-ID: 7aa65568-fe55-11ed-8ac4-6f01c1d0a443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay6 (Halon) with ESMTPSA
 id 7aa65568-fe55-11ed-8ac4-6f01c1d0a443;
 Mon, 29 May 2023 19:17:42 +0000 (UTC)
Date: Mon, 29 May 2023 21:17:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 01/13] fbdev: Add Kconfig options to select different
 fb_ops helpers
Message-ID: <20230529191741.GA1370714@ravnborg.org>
References: <20230524092150.11776-1-tzimmermann@suse.de>
 <20230524092150.11776-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524092150.11776-2-tzimmermann@suse.de>
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
Cc: freedreno@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 javierm@redhat.com, dri-devel@lists.freedesktop.org, mripard@kernel.org,
 daniel@ffwll.ch, linux-tegra@vger.kernel.org, airlied@gmail.com,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Thomas,

On Wed, May 24, 2023 at 11:21:38AM +0200, Thomas Zimmermann wrote:
> Many fbdev drivers use the same set of fb_ops helpers. Add Kconfig
> options to select them at once. This will help with making DRM's
> fbdev emulation code more modular, but can also be used to simplify
> fbdev's driver configs.
> 
> v3:
> 	* fix select statement (Jingfeng)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
I like these, thanks.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

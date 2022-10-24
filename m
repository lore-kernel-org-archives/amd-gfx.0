Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C76CC38A2D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 21:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D8A410E05C;
	Mon, 24 Oct 2022 21:55:37 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FFA10E05C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 21:55:31 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3D43CB80D69;
 Mon, 24 Oct 2022 21:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866F9C433D6;
 Mon, 24 Oct 2022 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666648529;
 bh=oQ9KNEH5p9KGrsnEcH5S1RduBGb6wJ0EGUHoylNIUA0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=owCi5MX6mT/TF8uDWZXk/zB9Mvqn4fHQ+Z09FxiZbMlhfGo/km40JdiQRn+Th/D/h
 qo2T9XR3Wqhn+6FfAQv3Flhg/LYkRHu+Tjjd3RsVi4/9bgOiUYS9dedx1JEPH8K7+W
 7Oqu6Et9S70kCC+V2cR/eHwe69kMssr3xbUFZ6432fsDgrk9FfPjyYkdZicN0BVUMa
 EXfZY9NRnItX/1zYXfzyj8nC4kYB0LXrXC377Av1LnRfYDokrgTNOqRpe3I9SEBsEf
 2QkV1CUUnJ3GnbpWNXWNhSaMDF401o5mxDxG/xI20wA0k0iS4d3qwTHoq6Q8kukfZt
 lLoBNP6hs8E0g==
Date: Mon, 24 Oct 2022 14:55:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: kernel test robot <lkp@intel.com>, Russell King
 <rmk+kernel@armlinux.org.uk>
Subject: Re: [linux-next:master] BUILD SUCCESS WITH WARNING
 76cf65d1377f733af1e2a55233e3353ffa577f54
Message-ID: <20221024145527.0eff7844@kernel.org>
In-Reply-To: <6356c451.pwLIF+9EvDUrDjTY%lkp@intel.com>
References: <6356c451.pwLIF+9EvDUrDjTY%lkp@intel.com>
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
Cc: linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-mediatek@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 ntfs3@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 25 Oct 2022 00:58:57 +0800 kernel test robot wrote:
> drivers/net/phy/phylink.c:588 phylink_validate_mask_caps() warn: variable dereferenced before check 'state' (see line 583)

Hi Russell, I think the warning is semi-legit. Your commit f392a1846489
("net: phylink: provide phylink_validate_mask_caps() helper") added an 
if (state) before defer'ing state but it's already deref'ed higher up
so can't be null.

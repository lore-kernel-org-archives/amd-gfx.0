Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0484C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 22 May 2022 21:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135B010E1CE;
	Sun, 22 May 2022 21:42:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F37F10E53C;
 Sun, 22 May 2022 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RzMWJ+V7j6n8wqrdlxSAaZ65WmCdGM5jpjFwYqURuAU=; b=KcmlhnLarEdV5Hogd22WEy04wc
 fIAC//AKmkT1hu9BOGzKTN9giV2GHY/5ZIjNSME5+BVQ7fMpe7aDmjO++gQrc5dfC+ZJb9sFKhrKb
 7YN8508ec+ZXufjZLhiBF1TSGV9hdiz1kfCQG1n354+x+JlVxwgWUCUXc+AI+LVOGZm8D7QTR8vSj
 SIXtAbGQMzxz29kMBziWGwHHot0FIjk8VBwzkRJTG0zc8wPn9jJIZ5LhlMIJFHDKRbcOt6ebCXLPL
 7pBLHdpGi53Qh8WZ0eBhi768k6Q/WocMotP2Wpd1k9NZdTrBNpb3JuK+aEB9yrvbkWWzS8l3/oZOD
 29p2Z10A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nskAB-001Ecq-QI; Sun, 22 May 2022 11:54:23 +0000
Date: Sun, 22 May 2022 04:54:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 736ee37e2e8eed7fe48d0a37ee5a709514d478b3
Message-ID: <Yookb5den2ruDBDo@infradead.org>
References: <6285958d.+Z2aDZ4O1Y9eiazd%lkp@intel.com>
 <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
 <CAMuHMdU3SYOwE5ftDwymQpVwWmpbC=1Ytyp0Y9GaeUS2i1cP+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU3SYOwE5ftDwymQpVwWmpbC=1Ytyp0Y9GaeUS2i1cP+A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Sun, 22 May 2022 21:42:33 +0000
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
Cc: linux-hwmon@vger.kernel.org,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 kernel test robot <lkp@intel.com>, KVM list <kvm@vger.kernel.org>,
 linux-staging@lists.linux.dev, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linux-nvme@lists.infradead.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-sparse@vger.kernel.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:TI ETHERNET SWITCH DRIVER \(CPSW\)" <linux-omap@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

How about just turning the MMIO/PIO accessors on m68k into inline
functions as they are on most other architectures?

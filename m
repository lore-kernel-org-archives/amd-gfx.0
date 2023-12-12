Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F36C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 08:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0737310E58D;
	Tue, 12 Dec 2023 08:39:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 584F810E568
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3ses/ZsQ18kkMwgX82j0GHRHgEu7yezobRPEQDwOeVE=; b=loj03fvm+MJwW7UkZI87OSv2dM
 qeINzFTWACJoUVBnZlcSrmQkrWLr5xuEsDdRgvb5xBuN1aE/bWKNEgWHFUlBi/ZV9SF22qyvnJGUA
 DZ68pilvL8lEA0iIGTlXV2zGf7lHqaMbEX21rfTXZE6tuqmlioNpEuuuLEimLtiwvnN/Y7QaN0miK
 8Pw/X9MRFAr9i/CbFXHP2hssmAw31NucyJ04pGVjNFulPJR0JNcg2RsF/iul5D+xi4/72npQbSeXG
 AMPg9usdCOgER055N5knKYZHyWtjFPb5xvlUOXsPtI+/8n7GRnUxeWFCsRjRL0cG2Zs0GDs92YoTC
 1eySzcnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1rCwv4-00AuEj-0x; Tue, 12 Dec 2023 07:11:06 +0000
Date: Mon, 11 Dec 2023 23:11:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Message-ID: <ZXgHisDUsJMw7z3N@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-6-samuel.holland@sifive.com>
 <ZXczty+Y6dTDL4Xi@infradead.org>
 <7c40dfe8-f245-413f-a424-bde52ce21b6a@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c40dfe8-f245-413f-a424-bde52ce21b6a@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Tue, 12 Dec 2023 08:39:33 +0000
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
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 11, 2023 at 10:12:27AM -0600, Samuel Holland wrote:
> On 2023-12-11 10:07 AM, Christoph Hellwig wrote:
> 
> Unfortunately, not all of the relevant options can be no-prefixed:

Ok.  That is another good argument for having the obj-fpu += syntax
I proposed.  You might need help from the kbuild maintainers from that
as trying to understand the kbuild magic isn't something I'd expect
from a normal contributor (including myself..).


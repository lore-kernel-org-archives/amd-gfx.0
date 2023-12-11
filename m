Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16E3C10DC3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 16:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB5910E48E;
	Mon, 11 Dec 2023 16:12:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E6510E488
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MO8te+CcZhuqh9lyi6N+6OpnOSi5nFlWtax3fsNSytk=; b=y2MkADK4CsUrTrRfEeLVo69I26
 XGJJPYgXVKpIpPYUV+5CJE2s241GM5VyUiBDUCk17cKRUQuKsPma5DgB0ZsZRa/Ixj/507F0O34iq
 GXKpirxPm23nbHyhgtnjiU0VmzeC64y7b9uFE6auvqLAkNuYntKnzbmp+lNx3WiCyvdTuFHOVUBRd
 bWHefEf15J+Tm4W4MQjC0AE0hmFJSMeY1M1LzWMmQPxG1oCIgmMSoIwjsu1+DKFlMS3yCpRmhGZ+S
 mqVPY7PuJqBG4LFCyUYYdA9UYo01SjP5q1DHxWK2K24NTg30TuUrdS4ThieLbUPuQVCXE1GPAA7Ng
 TeoO3row==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1rCilh-005dP1-2k; Mon, 11 Dec 2023 16:04:29 +0000
Date: Mon, 11 Dec 2023 08:04:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [RFC PATCH 03/12] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Message-ID: <ZXczDXH6KZWwcWLQ@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-4-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-4-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Mon, 11 Dec 2023 16:12:41 +0000
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

On Thu, Dec 07, 2023 at 09:54:33PM -0800, Samuel Holland wrote:
> Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
> tree, use it instead of duplicating the flags here.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

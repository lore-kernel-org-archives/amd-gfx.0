Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42C1C10F13
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 16:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A3E10E49A;
	Mon, 11 Dec 2023 16:12:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E410F10E488
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7/9PVAoW+mQkYndhB1mGTPqj7a0+NR0wxr/3ILbUkfI=; b=TeWHg8VZSEjB97ULraUC03LR2V
 9GC7hrJ0A2gqejqPepZpofgeBkUk0EVbz/vD0fh6fK/Pusr93obgkapD9TgcuvEfVgLqAQyhawo1/
 QPRqUA+ePWr2UqnfeEquAZ6BVqZqgaTn3YvcN9HdTFXdhb/6CADXiwbbw1vcgtF2p9HTQXlKVlqSM
 eyF/Q02AbITgCJ7jsrkAJcFCeERnZF8MxEjneMz/1yh8P8Ty73TErCHiYVQIIlTHviIQXJooTFonT
 hJXhhHFfFXybb/NYo+IqCrGs2rePIPKcPL+CZA/221GjtLICb55HO+UalInlQyqUmSHQgFSksIjFb
 gemr5Klw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1rCipZ-005fBl-02; Mon, 11 Dec 2023 16:08:29 +0000
Date: Mon, 11 Dec 2023 08:08:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [RFC PATCH 07/12] powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <ZXcz/Bi6xP1CYK60@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-8-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-8-samuel.holland@sifive.com>
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

On Thu, Dec 07, 2023 at 09:54:37PM -0800, Samuel Holland wrote:
> PowerPC provides an equivalent to the common kernel-mode FPU API, but in
> a different header and using different function names. The PowerPC API
> also requires a non-preemptible context. Add a wrapper header, and
> export the CFLAGS adjustments.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

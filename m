Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66028C10DC3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 16:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B6110E49B;
	Mon, 11 Dec 2023 16:12:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4620C10E108
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=voX1j54PoeLMwiQxMkFN5YaL2nBXSYPeTjd4yAFjCQA=; b=ifw6UNjUEDXllsbmZ4AL+dQpRW
 W7b4XK9Kv2/xZ1tcblE7ZfPY/0dMQS0FEvx+i2C6aAE7Zt7MP/UVmUe/mhIExmXNoeKSWR72X4ReC
 icB9zGsV3UObHyUoHkKwukaPk5sKzjyLMManm+Ed1NR3M9AXPCg7SGx6gNkh/lCOKPdmxYNuDiXKe
 +vPv++gGyb9vO0onHi8hOeAukUR55fcRtmV0/FupL1Zz4rC0EOk2DlmrIbKBCnZ1/X9rpJ8qxM7fL
 5WaQwgOsHX/LIFPFPmJ7abBBvtKt5+kdFvtLwoI1y1PYRxUnUZ4Uky9Byl+Nm//eqRAtc8ufLM3GM
 rJYlXhJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1rCioR-005edf-1j; Mon, 11 Dec 2023 16:07:19 +0000
Date: Mon, 11 Dec 2023 08:07:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Message-ID: <ZXczty+Y6dTDL4Xi@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-6-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-6-samuel.holland@sifive.com>
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

> +CFLAGS_REMOVE_neon1.o += $(CC_FLAGS_NO_FPU)
> +CFLAGS_REMOVE_neon2.o += $(CC_FLAGS_NO_FPU)
> +CFLAGS_REMOVE_neon4.o += $(CC_FLAGS_NO_FPU)
> +CFLAGS_REMOVE_neon8.o += $(CC_FLAGS_NO_FPU)

Btw, do we even really need the extra variables for compiler flags
to remove?  Don't gcc/clang options work so that if you add a
no-prefixed version of the option later it transparently gets removed?

Except for that:

Reviewed-by: Christoph Hellwig <hch@lst.de>

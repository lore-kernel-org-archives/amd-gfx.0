Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E633C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 16:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 769A910E498;
	Mon, 11 Dec 2023 16:12:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C850C10E0C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=OpglHNMJJzSYx4T/kW665rmi/jtAX7GsOChv2TFobqY=; b=ZBI0pwfXyKO4WzDr/GoqiD07Co
 m9H1p0cuX7jyp3zfEsid8e96EHf+FruxRo/h9Z7aOTec1EOYzK3w7twOUDO+5r7Uvy7TgMg4AhN5A
 XPpQFSaIDNbG/IBqRqkMg8PSNXaQJhQT+kmZwtDwtvsmC5rBu6G0SQKuKeXZ7OMu9/F0IkykBurtB
 EEhOu4Snnpdf9XEFPoOtR5CXbfp/Nzs620D3v3x75LY3An5m3oy0jj0x0sxyL/OfsYUpD8097DPzd
 N08o8m6dQi9yotKcqJ65fCfFOrsa2THZBmM8Ys+fEUKATZ5MecKZO9sg24Lt1Q188iC+k4EOk+doJ
 ZqUnAXFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1rCisO-005gRx-1R; Mon, 11 Dec 2023 16:11:24 +0000
Date: Mon, 11 Dec 2023 08:11:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [RFC PATCH 09/12] riscv: Add support for kernel-mode FPU
Message-ID: <ZXc0rAdi7Vo8nbS8@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-10-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-10-samuel.holland@sifive.com>
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

> +#ifdef __riscv_f
> +
> +#define kernel_fpu_begin() \
> +	static_assert(false, "floating-point code must use a separate translation unit")
> +#define kernel_fpu_end() kernel_fpu_begin()
> +
> +#else
> +
> +void kernel_fpu_begin(void);
> +void kernel_fpu_end(void);
> +
> +#endif

I'll assume this is related to trick that places code in a separate
translation unit, but I fail to understand it.  Can you add a comment
explaining it?


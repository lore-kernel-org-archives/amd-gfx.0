Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A0DC61D9B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 14:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5998010E648;
	Wed, 22 Nov 2023 14:05:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA1E10E5DC;
 Wed, 22 Nov 2023 08:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=c3B+JcPJMghWo+nJ71PzWYCU8IF2ZA/XTIwpeIzvQJc=; b=iry9qYaAzZ72Yw7RgNmlMyzxch
 uBcG/uUni+Zl/djnDtICDx2l+t+X3Ms06RvQs4Lb3itE+ICRA3BnUQ28ve4901i8R99Of7L2yah8D
 RblXmxBNOT8SZ7EBXHivnR/9JonEkP8AEz38O1JNMe914sZQ5FMz2k2Jr39lzxrjJl/9/hXlr6jaT
 12mYDAlJbu2ZIMzyAGZU06bSsjjuQnN46n5Ddo7tAMPWslUGtxgB2dPGvggIsGAiGH+vRaouJkXNV
 grvsGAUvQL6fLENnXHV+maDUx3GbhmSxIZtB7YLNaGffCD8FCcCGJH+zdWAY+BERdes5OswtdPonj
 UpNoiBaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1r5ifs-0014GP-2o; Wed, 22 Nov 2023 08:33:32 +0000
Date: Wed, 22 Nov 2023 00:33:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 1/3] riscv: Add support for kernel-mode FPU
Message-ID: <ZV283NfE/K5zLXDD@infradead.org>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-2-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122030621.3759313-2-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Wed, 22 Nov 2023 14:05:10 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Palmer Dabbelt <palmer@dabbelt.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 linux-riscv@lists.infradead.org, Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 21, 2023 at 07:05:13PM -0800, Samuel Holland wrote:
> +static inline void kernel_fpu_begin(void)
> +{
> +	preempt_disable();
> +	fstate_save(current, task_pt_regs(current));
> +	csr_set(CSR_SSTATUS, SR_FS);
> +}
> +
> +static inline void kernel_fpu_end(void)
> +{
> +	csr_clear(CSR_SSTATUS, SR_FS);
> +	fstate_restore(current, task_pt_regs(current));
> +	preempt_enable();
> +}

Is there any critical reason to inline these two?  I'd much rather see
them out of line and exported instead of the low-level helpers.


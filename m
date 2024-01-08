Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629CAC3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 14:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4A010E236;
	Mon,  8 Jan 2024 14:32:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A3C10E1D5
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nTS1Uj9X0YK5sE131pQWTs2iFDkjMx4GKaOmTl5jpqE=; b=Fy176uqqVZeORczKkanJckGA3E
 rjRR9SFWlqdBWFeQhMUeo2x5lV8XpdYa4GI0iYUzJ6xe4JfoH/ClDNDCMVJub0LPMWEwUwd8I8dr0
 WwH6zcQyiGmBNcE7Fs8axj5Vg+MNCFSetI0lVOGPKPgwxoNDApJeoPP6xe17PMl4YbYUkYENMyduB
 f083OT27kxtEMpbQucthM3SKI66TxkTOiSrMzwOmJqYthGOqjcJQX6LHBVpu97K2Nyn2Uoe2m6xiJ
 DGQPT42ehYs1d42jNISUDZY/OxsBiSJHVw2pJE0uDLbTxsdKq7BFvXx0o48duef+zb5iDUsv9NZhu
 bOOsB0Vw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1rMm44-004Uoy-0z; Mon, 08 Jan 2024 09:37:00 +0000
Date: Mon, 8 Jan 2024 01:37:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v2 07/14] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <ZZvCPMcYq6KBs7ND@infradead.org>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
 <20231228014220.3562640-8-samuel.holland@sifive.com>
 <CAAhV-H5TJPqRcgS6jywWDSNsCvd-PsVacgxgoiF-fJ00ZnS4uA@mail.gmail.com>
 <84389bc3-f2e7-49c5-a820-de60ee00f8a7@sifive.com>
 <CAAhV-H4JxP-j5A7KuNSBncZkHF9i3O1njCtMjVkd3=RNbE5Q7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4JxP-j5A7KuNSBncZkHF9i3O1njCtMjVkd3=RNbE5Q7w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Mon, 08 Jan 2024 14:32:47 +0000
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
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 loongarch@lists.linux.dev, WANG Xuerui <git@xen0n.name>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jan 07, 2024 at 10:39:07AM +0800, Huacai Chen wrote:
> > Do you mean that LoongArch32 does not support double-precision FP in hardware?
> > At least both of the consumers in this series use double-precision, so my first
> > thought is that LoongArch32 could not select ARCH_HAS_KERNEL_FPU_SUPPORT.
> Then is it possible to introduce CC_FLAGS_SP_FPU and CC_FLAGS_DP_FPU?
> I think there may be some place where SP FP is enough.

Let's defer that until it is actually neeed.

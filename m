Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B9BC02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 21:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A104310E3DA;
	Mon, 10 Feb 2025 21:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vl2lsKYL";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C22B10E3DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 21:26:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 68C2A5C5EBE;
 Mon, 10 Feb 2025 21:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE27C4CED1;
 Mon, 10 Feb 2025 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739222815;
 bh=ofm1ktslAjBtWS0yfrjTo5bd77wR/QRUhpc5kK/lkEw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vl2lsKYLUtR0YlnfLqjy5wD3rTLZSCKRFzJQ2EOsbpDUzjv2fH1yNizTHcYIzjgNs
 SRjtKp4T3/KG7rLVCHt9xLvsAVL1ex00WyW9JpbdD73zKC9YXgLAtePfxswHRQ4jH1
 y0kGr9Xp/vDI9fdOrE301Wfnsq+gMv1inwa2a5dIW296epc9c5HehSC0yfYXpWOVfw
 JkvY8Q/06i4shaKcyb+MPsCnrQN4Cu8chRnugQ+WExUk1BiKwh6t8xuWODKJADUK1X
 4tIDwB/TukU2O9sLkFYrzXtkrfLX+hH2ItIWEyDfQaCvNAJsVhRDbyDa75RwCbNE5E
 N0cCZU/Hm+mMA==
Date: Mon, 10 Feb 2025 13:26:53 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
Message-ID: <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
 <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 10, 2025 at 02:07:43PM +0800, Tiezhu Yang wrote:
> On 01/15/2025 09:34 AM, Josh Poimboeuf wrote:
> > On Sat, Jan 11, 2025 at 02:57:42PM +0800, Tiezhu Yang wrote:
> > > Hi Josh and Peter,
> > > 
> > > On 12/17/2024 09:08 AM, Tiezhu Yang wrote:
> > > > This version is based on tip/tip.git objtool/core branch [1], add some weak
> > > > and arch-specific functions to make the generic code more readable, tested
> > > > with the latest upstream mainline Binutils, GCC and Clang.
> > > 
> > > ...
> > > 
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=objtool/core
> > > > 
> > > > Tiezhu Yang (9):
> > > >   objtool: Handle various symbol types of rodata
> > > >   objtool: Handle different entry size of rodata
> > > >   objtool: Handle PC relative relocation type
> > > >   objtool: Handle unreachable entry of rodata
> > > >   objtool/LoongArch: Add support for switch table
> > > >   objtool/LoongArch: Add support for goto table
> > > >   LoongArch: Enable jump table for objtool
> > > >   LoongArch: Convert unreachable() to BUG()
> > > >   drm/amd/display: Mark dc_fixpt_from_fraction() noinline
> > > 
> > > Are you OK with the first 8 patches?
> > > What's the merge plan for this series?
> > 
> > Sorry, my inbox is still reeling from the holidays.  I will review this
> > soon.
> 
> What are the status of the first 8 patches?
> What is the next step? Is there anything else to be done here?
> I would really appreciate any advice on how to get this merged.

Please post a new revision rebased on tip/master, with patch 4 dropped,
and I'll queue them up for -tip.  Thanks for your patience.

-- 
Josh

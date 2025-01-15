Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEABE77188
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 01:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D69E10E388;
	Wed, 15 Jan 2025 01:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HBygPGta";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E90110E388
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 01:34:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 23D63A41A83;
 Wed, 15 Jan 2025 01:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E25EC4CEDD;
 Wed, 15 Jan 2025 01:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736904886;
 bh=OXCHDIVdFs+lD+uci6+EY4R2agA/+sdGam9mXKqjzhs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HBygPGta7fs0zulpH4swS2t1N+kZKFXIxcKBmN2/Ewi5+DhA0Tzd8QYiC443tN3Q4
 y0BHSYwNgpin/7LyzWaegxjAsGvBLd460uIHZV10W+qa1/CITbBl7UfpRG5lmvUCFw
 BD51zpxDqMUaXWscGRP1R5kq/u7rjjpHxe8Y3hu7G5v2BC40+vWoemAFxrxfXzwNK8
 982z7KSpsMYPbORmU3aI8MHxZ/SRBZoxDWrpWf7HB7/417YaCLrqlTIymAOdt5lljL
 MkOkWT51DqyxUK/rUnyDmp76GLAiq/k4Iv68k5/QUbTHr0J8BSREMWBFoi5krlAo3D
 lRebyjGXBsVBw==
Date: Tue, 14 Jan 2025 17:34:44 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
Message-ID: <20250115013444.anzoct6gvs56m225@jpoimboe>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
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

On Sat, Jan 11, 2025 at 02:57:42PM +0800, Tiezhu Yang wrote:
> Hi Josh and Peter,
> 
> On 12/17/2024 09:08 AM, Tiezhu Yang wrote:
> > This version is based on tip/tip.git objtool/core branch [1], add some weak
> > and arch-specific functions to make the generic code more readable, tested
> > with the latest upstream mainline Binutils, GCC and Clang.
> 
> ...
> 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=objtool/core
> > 
> > Tiezhu Yang (9):
> >   objtool: Handle various symbol types of rodata
> >   objtool: Handle different entry size of rodata
> >   objtool: Handle PC relative relocation type
> >   objtool: Handle unreachable entry of rodata
> >   objtool/LoongArch: Add support for switch table
> >   objtool/LoongArch: Add support for goto table
> >   LoongArch: Enable jump table for objtool
> >   LoongArch: Convert unreachable() to BUG()
> >   drm/amd/display: Mark dc_fixpt_from_fraction() noinline
> 
> Are you OK with the first 8 patches?
> What's the merge plan for this series?

Sorry, my inbox is still reeling from the holidays.  I will review this
soon.

-- 
Josh

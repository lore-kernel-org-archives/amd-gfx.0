Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE12EC021A0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 23:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E40210E1A8;
	Tue, 11 Feb 2025 23:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UFcAL+yN";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5169E10E1A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 23:30:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C0695A40812;
 Tue, 11 Feb 2025 23:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC51AC4CEDD;
 Tue, 11 Feb 2025 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739316657;
 bh=NClWj+hoesfa5XuCbBYDAKUXJXVXFF21o0ZpYn2FjQ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UFcAL+yNXznuxsj7iLlv0H1VTSeqTvbKk5iFryb9sKY5pB/PuVnp6b3jmd8soRAYe
 GRj9G62yEpaDWWtSjdOP/NXlmMZ8M45PoqkoqupSvjRWyp5QgFKZPYM4yNAiEB0M/A
 T5y4o1T++Kk+L04A5Mzyb0KEHw3M9UJ5m/YrJT0YD7QKlWbjTWw1/fIbEWnvoxPdWE
 B3vWQGHu9r9c5PSEvwOmz+53pfd/bz1ahN3Stwf8fSRQjpKLk3GM2O4Nns8Hx2m3D6
 FObZgpQQQBPlF+v5dh5/e64KEVVEe0kG1wP4WOvgEu3JkUNUom4B9q7x07nJAZRmTV
 rbYWrebC38+HA==
Date: Tue, 11 Feb 2025 15:30:56 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
Message-ID: <20250211233056.q47mp5askk7qrxcp@jpoimboe>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
 <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
 <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
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

On Tue, Feb 11, 2025 at 07:59:57PM +0800, Huacai Chen wrote:
> Hi, Josh,
> 
> On Tue, Feb 11, 2025 at 5:26 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Mon, Feb 10, 2025 at 02:07:43PM +0800, Tiezhu Yang wrote:
> > > On 01/15/2025 09:34 AM, Josh Poimboeuf wrote:
> > > > On Sat, Jan 11, 2025 at 02:57:42PM +0800, Tiezhu Yang wrote:
> > > > > Hi Josh and Peter,
> > > > >
> > > > > On 12/17/2024 09:08 AM, Tiezhu Yang wrote:
> > > > > > This version is based on tip/tip.git objtool/core branch [1], add some weak
> > > > > > and arch-specific functions to make the generic code more readable, tested
> > > > > > with the latest upstream mainline Binutils, GCC and Clang.
> > > > >
> > > > > ...
> > > > >
> > > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=objtool/core
> > > > > >
> > > > > > Tiezhu Yang (9):
> > > > > >   objtool: Handle various symbol types of rodata
> > > > > >   objtool: Handle different entry size of rodata
> > > > > >   objtool: Handle PC relative relocation type
> > > > > >   objtool: Handle unreachable entry of rodata
> > > > > >   objtool/LoongArch: Add support for switch table
> > > > > >   objtool/LoongArch: Add support for goto table
> > > > > >   LoongArch: Enable jump table for objtool
> > > > > >   LoongArch: Convert unreachable() to BUG()
> > > > > >   drm/amd/display: Mark dc_fixpt_from_fraction() noinline
> > > > >
> > > > > Are you OK with the first 8 patches?
> > > > > What's the merge plan for this series?
> > > >
> > > > Sorry, my inbox is still reeling from the holidays.  I will review this
> > > > soon.
> > >
> > > What are the status of the first 8 patches?
> > > What is the next step? Is there anything else to be done here?
> > > I would really appreciate any advice on how to get this merged.
> >
> > Please post a new revision rebased on tip/master, with patch 4 dropped,
> > and I'll queue them up for -tip.  Thanks for your patience.
> You will queue the whole series, or the first 5 patches, or the first 3 patches?

The new series now has 7 patches:

Tiezhu Yang (7):
  objtool: Handle various symbol types of rodata
  objtool: Handle different entry size of rodata
  objtool: Handle PC relative relocation type
  objtool/LoongArch: Add support for switch table
  objtool/LoongArch: Add support for goto table
  LoongArch: Enable jump table for objtool
  LoongArch: Convert unreachable() to BUG()

I was planning on queueing all 7.

In particular, patch 6 should stay with the objtool patches since
they're directly related.

But I was also just going to grab 7 as well.

Please let me know if you disagree.

-- 
Josh

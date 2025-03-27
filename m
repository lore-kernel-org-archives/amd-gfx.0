Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F82C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 10:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D6F10E2C2;
	Thu, 27 Mar 2025 10:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gXJ0SesR";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859BA10E2C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 10:41:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6F8EBA42504;
 Thu, 27 Mar 2025 10:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7FFC4CEDD;
 Thu, 27 Mar 2025 10:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743072063;
 bh=Ezoe49kR7+OTzs5Hu3HjQWUKC5r7LalD1FQSkG40hI0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gXJ0SesR6wUH4598bnHQ4Ur78SiVbJfRciil3jI953+nAb4Wnh3eJLJy4F/P2Hync
 5K0d05eliuk9rIvVoojlzmTCF9zhNTTxnnhJ7dRX/F2na+imaA4BGiPKPObQFgs5+u
 GkcM3nlweZsZabZ5DWHnqht7mEMuz8ri5mg40+GMRgDfxmE5zCvsPteFnMtTUy85DE
 cREaUCUdPx7LrM+3SDxnRy97zQBESYIIq4qAI6cC1ZGErpki/l4m5mohbUOFpmNcHN
 Bs9I6pJ7quPYXjYXjp+Swh4ES6mDY/niq1vojGp7rFrYrn6Hh4e3ASkD5MZ0ppfZFP
 c4FiAdHIjjikw==
Date: Thu, 27 Mar 2025 11:40:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Balbir Singh <balbirs@nvidia.com>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: commit 7ffb791423c7 breaks steam game
Message-ID: <Z-UrOtLLMTNFLRfU@gmail.com>
References: <20250325101424.4478-1-spasswolf@web.de>
 <64945196-f05f-478e-a2b5-f0bd58345136@amd.com>
 <c66e2c03648370d5e5c0745f32ebd58367bbe48b.camel@web.de>
 <CAHk-=wh5Suzp0z7AnK0NgSKfEAWQJw7Dgv5eku=rzBuM1ugQDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5Suzp0z7AnK0NgSKfEAWQJw7Dgv5eku=rzBuM1ugQDg@mail.gmail.com>
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


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 26 Mar 2025 at 15:00, Bert Karwatzki <spasswolf@web.de> wrote:
> >
> > As Balbir Singh found out this memory comes from amdkfd
> > (kgd2kfd_init_zone_device()) with CONFIG_HSA_AMD_SVM=y. The memory gets placed
> > by devm_request_free_mem_region() which places the memory at the end of the
> > physical address space (DIRECT_MAP_PHYSMEM_END). DIRECT_MAP_PHYSMEM_END changes
> > when using nokaslr and so the memory shifts.
> 
> So I just want to say that having followed the thread as a spectator,
> big kudos to everybody involved in this thing. Particularly to you,
> Bart, for all your debugging and testing, and to Balbir for following
> up and figuring it out.
> 
> Because this was a strange one.

I'd like to second that praise - Bert went above and beyond what could 
be expected from or even hoped from someone who reports a regression 
that broke his machine. Also, Balbir diligently followed down the 
regression to a root cause that was far away from his original code of 
interest. It was nice to lurk in this thread.

Thanks,

	Ingo

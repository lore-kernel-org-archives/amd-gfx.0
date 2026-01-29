Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B49D73E87
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 21:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8591710E8C9;
	Thu, 29 Jan 2026 21:51:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FaqBH9Q4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E49610E2DA;
 Thu, 29 Jan 2026 21:51:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 279B243FC3;
 Thu, 29 Jan 2026 21:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EC8C4CEF7;
 Thu, 29 Jan 2026 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769723476;
 bh=Q3zSRrovWIg3qmOPSQjV0l/EKEt3ItdS6bxMEwS5hy8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=FaqBH9Q4U7OFys5R54AL4OyCg9MohsuSenTOYbfovDHiAFJImhToOKL8cibZML05A
 pLzDda4TwEdLJuUvW2ZVAPUGm+zZZEHs+G3NKafjtHBZqzrzBoSrN/3URg9JtalS3K
 4tG+stzA4gyXCw+UAjlhzlPMt+pYWNs48CoaJMMAhQgj4KjmtIpsH3Du60NoD/xx7K
 Z8R0skKUd6D2YIfUeagvZ/7G1xyhK2QCemCyGnyCai3m29eeQtqEt08Q796miVEWbk
 uOAZS0dsfhwZ9hF4Kud/pB3ZbnDobW+SsvkA1/uRkVRBECfwr7FM5H25AyySQUsQJg
 2XmxC14tZ94kw==
From: Thomas Gleixner <tglx@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Brett Creeley <brett.creeley@amd.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Vivian Wang <wangruikang@iscas.ac.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v4 0/4] PCI/MSI: Generalize no_64bit_msi into msi_addr_mask
In-Reply-To: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
References: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
Date: Thu, 29 Jan 2026 22:51:12 +0100
Message-ID: <87ecn8m6jz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Jan 29 2026 at 09:56, Vivian Wang wrote:
> I would appreciate if driver maintainers can take a look and see whether
> the masks I've set makes sense, although I believe they shouldn't cause
> problems on existing platforms. I'm also not familiar with PPC enough to
> touch the arch/powerpc firmware calls further - help would be
> appreciated.
>
> My intention is that the first two patches are taken up by PCI
> maintainers, and the rest go through the maintainers of individual
> drivers since they could use more device-specific testing and review. If
> this is not convenient I'll be happy to split it up or something.

I'm happy to take the first two right away.

I can pick up the driver specific ones as well if there are no
objections; they both have been looked at by the relevant maintainers
and they obviously depend on the first ones so they have either to go
together or postponed for the next window, which doesn't make a lot of
sense.

If nobody complains I pick up the lot tomorrow morning.

Thanks,

        tglx

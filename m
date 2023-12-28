Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F29C47073
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 10:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE00D10E0FC;
	Thu, 28 Dec 2023 10:02:15 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918E910E039
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 03:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1703733552;
 bh=EfJurZriD67cDIIwfiSM+kPHFvEVVHjMJmp7iWbFTLU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=nfF7UQxSvEFaj4zjVVDZFGc/PuImmuvaZ3mEKMBJyLZm//iqAnLT0yisJQwrCU7S0
 bVxB5akL39HmDbuq/jT4FGLf0kG7kMimzsxsXVIQl/mVEy6wniHoOa3HjFqSvwg89c
 FwIVvXQps64q92tRsf80IoYSQySfoqSCVs6siW9OBv42MMkw4ViUAtXCJbfNsKG6jA
 JedpVqkGyrM26BxsJG65GhzLbngP100uf6zRb8p8DvCR1wTRoUbRUvXTe88wX+1nMn
 fbLyXQTIPhHG72UC0XCwCWZ6EhuHxg/PdFGez6CnLQRSkY31By3C1FxLqqZHNiIIU8
 bOMIA4nGmREWg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T0tyk6hCKz4wxx;
 Thu, 28 Dec 2023 14:19:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Samuel Holland <samuel.holland@sifive.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org, Christoph Hellwig
 <hch@lst.de>
Subject: Re: [PATCH v2 08/14] powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
In-Reply-To: <20231228014220.3562640-9-samuel.holland@sifive.com>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
 <20231228014220.3562640-9-samuel.holland@sifive.com>
Date: Thu, 28 Dec 2023 14:19:08 +1100
Message-ID: <87wmszj9oz.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 28 Dec 2023 10:02:14 +0000
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
Cc: linux-arch@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 Samuel Holland <samuel.holland@sifive.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Samuel Holland <samuel.holland@sifive.com> writes:
> PowerPC provides an equivalent to the common kernel-mode FPU API, but in
> a different header and using different function names. The PowerPC API
> also requires a non-preemptible context. Add a wrapper header, and
> export the CFLAGS adjustments.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v1)
>
>  arch/powerpc/Kconfig           |  1 +
>  arch/powerpc/Makefile          |  5 ++++-
>  arch/powerpc/include/asm/fpu.h | 28 ++++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/include/asm/fpu.h

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

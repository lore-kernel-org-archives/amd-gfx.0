Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025F1C021A0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 23:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10FC10E763;
	Tue, 11 Feb 2025 23:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pKLL61fw";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A6810E763
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 23:34:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AC4925C49F4;
 Tue, 11 Feb 2025 23:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B85CC4CEDD;
 Tue, 11 Feb 2025 23:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739316886;
 bh=PXjOkztQtS20D6Nh1IncoMXQ5YlWhRlg8ZJHVtBRdtM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pKLL61fwRbfWBU4Fm1uWF3wSUkGkVyN4BcEy6w45cicRmzuTkyvVP6B8ws+bi6srS
 twx1aTHOjA9SrFr1dE6qi2MByeLocSUuAwW1QbkJKy7GscJBE/2yYWG3HC1wjRoWHq
 2WAk+GT26ywwzvsYqAQrMx2AIzVVgIEEDKnbfkriUJ8lQ5KP98awdQ5IcdnyacKXqv
 3PnOMmQ3+WLO2Iw5URjBwIECbOyMK5jcLQsA9qBgUJru+RlkQrFGjSuaD1WZgaWp4Q
 gbJkI+UslNwsJGrh8aJZnguj2CiAfFjfQw5MoF1F6WDXfZoIeOT+YCh8tAslHtvdCk
 FQb+MzoKqwzbQ==
Date: Tue, 11 Feb 2025 15:34:44 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kexy Biscuit <kexybiscuit@aosc.io>
Cc: yangtiezhu@loongson.cn, amd-gfx@lists.freedesktop.org,
 chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, peterz@infradead.org
Subject: Re: [PATCH] objtool: remove duplicate case value R_PPC64_REL32
Message-ID: <20250211233444.nt6nvks4jim753bk@jpoimboe>
References: <20241217010905.13054-3-yangtiezhu@loongson.cn>
 <20250211141956.553850-2-kexybiscuit@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211141956.553850-2-kexybiscuit@aosc.io>
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

On Tue, Feb 11, 2025 at 10:19:57PM +0800, Kexy Biscuit wrote:
> In arch/powerpc/include/uapi/asm/elf.h, R_PPC64_REL32 is defined as a
> macro to R_PPC_REL32, makes the case value here being duplicate and
> creates the following error...
> 
> arch/powerpc/decode.c: In function ‘arch_reloc_size’:
> arch/powerpc/decode.c:114:9: error: duplicate case value
>   114 |         case R_PPC64_REL32:
>       |         ^~~~
> arch/powerpc/decode.c:113:9: note: previously used here
>   113 |         case R_PPC_REL32:
>       |         ^~~~
> 
> Remove the duplicate case value to fix the error.
> 
> Fixes: "FROMLIST: objtool: Handle different entry size of rodata"
> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
> ---
> This patch is required for this series to build on powerpc, however I'm
> not sure if it's the preferred way... Please advise.

If there are no objections, I'll squash this into the original patch to
avoid breaking bisection.

-- 
Josh

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F024C021B2
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 21:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A88010E9E8;
	Thu, 20 Feb 2025 21:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kr/jFqhM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4729110E9E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 21:33:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 86CF368307;
 Thu, 20 Feb 2025 21:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA0C4CEE3;
 Thu, 20 Feb 2025 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740087227;
 bh=RoVzIYQI0Sz67H8m1YsKGIZn7Z2NnixLo6bTVb4oSmI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kr/jFqhMsC41D9nQAnzIGStdkhH3ADbWwcO9Oi/kVJja8hI69c84MTb0dHUc03grP
 0ZTAldeyL/P7wHhOX/j00y1W/g7UrI0QZc7XRJMwPNxg5mR0c8Z5OCwAxY2ROq+Oxt
 fagY1+MmUWjXtLjejAy4uZFoOXsBLRM9vJ/bqtUmZHUxOi10z51PW0Dgf6E+dGJxPW
 tXCqgOu63lzPKNMkyDUdR+Z2Jvrl1uXTwo04f2dEx7nGpSP2fjiI7FcM/bT3aYW/lE
 oNqzErJqTHCM4ybHSDZ1Ojk2vQQ+c+H70OULvAowUkhUAdmgORn82c3cGPuj2xPkqC
 luVzY6MAo8cCA==
Date: Thu, 20 Feb 2025 13:33:45 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
Message-ID: <20250220213345.6bbca4eqethbvzwp@jpoimboe>
References: <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
 <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
 <20250211233056.q47mp5askk7qrxcp@jpoimboe>
 <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
 <20250213025108.svqgj5nzseqs6qox@jpoimboe>
 <CAAhV-H5mYGnxHPxAeXkHo2XBvi-RtPjDQRBnDiDyKVtFv-ZBBQ@mail.gmail.com>
 <20250218174632.gwseuvgezj7eni2j@jpoimboe>
 <CAAhV-H4Vwhsrp-y=pLa6xh=nVEOZy4wu2mPj00ES=OjsM7vruA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H4Vwhsrp-y=pLa6xh=nVEOZy4wu2mPj00ES=OjsM7vruA@mail.gmail.com>
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

On Wed, Feb 19, 2025 at 05:49:01PM +0800, Huacai Chen wrote:
> > Looks like that's not going to work.  Without patch 7 I'm getting a
> > warning (upgraded to a build error with a pending change to upgrade
> > objtool warnings to errors):
> >
> > arch/loongarch/kernel/machine_kexec.o: error: objtool: kexec_reboot() falls through to next function crash_shutdown_secondary()
> > arch/loongarch/kernel/machine_kexec.o: error: objtool:   kexec_reboot+0x1c: (branch)
> > arch/loongarch/kernel/machine_kexec.o: error: objtool:   kexec_reboot+0x0: <=== (sym)
> > arch/loongarch/kernel/machine_kexec.o: error: objtool: 1 warning(s) upgraded to errors
> >
> > And that would break bisection anyway, so that really needs to come
> > before the others.
> OK, then please take the whole series of V7, but please exchange the
> order of Patch-6 and Patch-7 (I think the enablement should be the
> last for bisection).
> For V7: Acked-by: Huacai Chen <chenhuacai@loongson.cn>

Ok, but to avoid the warning, patch 7 needs to come *before* the objtool
patches, so it will be the following order:

LoongArch: Convert unreachable() to BUG()
objtool: Handle various symbol types of rodata
objtool: Handle different entry size of rodata
objtool: Handle PC relative relocation type
objtool/LoongArch: Add support for switch table
objtool/LoongArch: Add support for goto table
LoongArch: Enable jump table for objtool

-- 
Josh

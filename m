Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419BEE77188
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 19:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC9310E325;
	Wed, 18 Dec 2024 19:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SgWujbWq";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5511C10E325
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 19:06:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 588825C641A;
 Wed, 18 Dec 2024 19:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC63CC4CECD;
 Wed, 18 Dec 2024 19:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734548760;
 bh=s8I59DHOReFsqMjDpIrOMGgg9VMuysWKuT+LcUwsDFk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SgWujbWqNAuI3SetRENzu3S+BO3gUB9sa1jRxD34d6yvxqknjHcKAucgomoYJ7SBH
 FGRGkz2EGrq7brpwim+RJum47chntue6bFx1H5H4nzbuRyCYpxvQJDD85QkxPVBJSB
 X2e8qQX1UzTEspo+UxUCkXXsNCDalteVqlJPGhAoayqAp/0SfrmiT9k/go3KIiUDk2
 SeAACHji472GBvEanhoP5pg01cPpJnv+cnjkzZPNqwJ4x/UcJ7keRyiCCHoUK07W0X
 UZbkeEDEwGtKJbSXOha9ylafMl3eP7EjXk2ASf+rPF3sLuyAL1Q8BLJeVajL0D/rh1
 OUW3K4yqf6QBw==
Date: Wed, 18 Dec 2024 11:05:58 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] drm/amd/display: Mark dc_fixpt_from_fraction()
 noinline
Message-ID: <20241218190558.g2hykmjgbny4n5i3@jpoimboe>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <20241217015006.30305-1-yangtiezhu@loongson.cn>
 <CAAhV-H4WpcWjrQdkm3Sx4DVbp=2oW9nNGAbNqR4BEmiryrptNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4WpcWjrQdkm3Sx4DVbp=2oW9nNGAbNqR4BEmiryrptNQ@mail.gmail.com>
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

On Wed, Dec 18, 2024 at 10:36:00PM +0800, Huacai Chen wrote:
> Hi, Tiezhu,
> 
> On Tue, Dec 17, 2024 at 9:50 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > When compiling with Clang on LoongArch, there exists the following objtool
> > warning in drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.o:
> >
> >   dc_fixpt_recip() falls through to next function dc_fixpt_sinc()
> >
> > This is because dc_fixpt_from_fraction() is inlined in dc_fixpt_recip()
> > by Clang, given dc_fixpt_from_fraction() is not a simple function, just
> > mark it noinline to avoid the above issue.
> I don't know whether drm maintainers can accept this, because it looks
> like a workaround. Yes, uninline this function "solve" a problem and
> seems reasonable in this case because the function is "not simple",
> but from another point of view, you may hide a type of bug.

Agreed, it sounds like there's definitely a bug which this patch is
papering over.

-- 
Josh

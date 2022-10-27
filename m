Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3591DFA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 15:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7804610E674;
	Thu, 27 Oct 2022 15:22:16 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA30410E674
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 15:22:11 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id E54E2CE2754;
 Thu, 27 Oct 2022 15:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF234C433D6;
 Thu, 27 Oct 2022 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666884127;
 bh=7CCqV7S56whMH0I8+DwFbrPHyWtgF8ZkABlJBTWhaQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OYsnm0KNgRfxzJ2mHK9oMe8pPla7C9FNDSlmovGa5Or5E2obM4aRglu5cFQvxBEMm
 GgWmQR7gDQ95MOx5SfJNC5gKtWbx3em/izqTLTTEI6RfARnB5Qbjv85LfpJJHiiCuT
 ULTRT/bYMquIQahEC5e4h0K1SIFmixfhSTzwUkHuw9eRM10FNWghAWt02/Le6TtahV
 zWUXM+DYz0yxRJ/GhROWf6xl8cFvz1RX2q6/vnDAVg0fg2TQwciR6xVEvSyk19JZlU
 UFJmD1oYLjhaxeOjx0wHAZlq+s9B+ayoTs539L/qmRspnTavN1kA1yxstMJoXqosbT
 cPzASPPHfzV7Q==
Date: Thu, 27 Oct 2022 08:22:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Message-ID: <Y1qiHbjdZNNjxFq5@dev-arch.thelio-3990X>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
 <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
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
Cc: Ao Zhong <hacc1225@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Leo Li <sunpeng.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Rodrigo,

On Thu, Oct 27, 2022 at 10:29:33AM -0400, Rodrigo Siqueira wrote:
> Nathan/Stephen,
> 
> Maybe I'm wrong, but I think you have access to some sort of CI that tests
> multiple builds with different compiles and configs, right? Is it possible
> to check this patch + amd-staging-drm-next in the CI to help us to
> anticipate any compilation issue if we merge this change?

Yup, I have a build framework that I have developed for my
ClangBuiltLinux work that I was planning on putting this through to see
if there are any new warnings that show up in this code since it is
going to be built on a new architecture. I will report back on Ao's v2
(or v3 if it is available since Arnd had some comments on v2) when that
is done.

> Or should we merge it and wait until it gets merged on the mainline? In case
> of a problem, we can easily revert a small patch like this, right?

Sure, although if we can catch issues beforehand, that would be nice :)

Cheers,
Nathan

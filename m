Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FB4CF45D4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 00:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C94610E443;
	Tue, 13 Jan 2026 00:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FmivJll5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0215A10E443
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 00:53:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B0F541B13;
 Tue, 13 Jan 2026 00:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0988BC116D0;
 Tue, 13 Jan 2026 00:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768265611;
 bh=EvvB6/WbIVvCrsHcEq2SG+Kse8Izaug3kCrqUhEiGSo=;
 h=Date:From:To:Cc:Subject:From;
 b=FmivJll5UiQtl59+17eVl36vj3k0407XPme34niXvDS+MpUjpbA7YLttwf/efwpRO
 KSNo9RGuLhkaQ9BC1ItKDaPd6IsClkgvwyQDcGolzN9YCN2gDvGPT8hN/GfGKbR+cc
 ybrzvtws1Zjo5PY7Iq/WFOCKFSn1q409Ixi8rlcAXiD0u9jEB42l1Ij9IN75m+UnPS
 +joB9L4E8OeTQXTDw2rxszKQqt4tJFTqpvItfUYuIxjXncEw2PYP56ibnDrnph5+Ol
 uKq5/tRQBauywj2UVs89TwQC0eThI+ezT12TDEzIvTZwBYrr75HYuZtazkBEu+Lwlm
 7BZaE2qgs1rwQ==
Date: Mon, 12 Jan 2026 17:53:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Apply 70740454377f1ba3ff32f5df4acd965db99d055b to linux-6.12.y
Message-ID: <20260113005327.GA2283840@ax162>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Greg and Sasha,

Commit 70740454377f ("drm/amd/display: Apply e4479aecf658 to dml") was
recently queued up for 6.18. This same change will be needed in 6.12 but
it will need commit 820ccf8cb2b1 ("drm/amd/display: Respect user's
CONFIG_FRAME_WARN more for dml files") applied first for it to apply
cleanly. Please let me know if there are any problems with this.

Cheers,
Nathan

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9E3C52D7F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 07:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C33D010E229;
	Tue, 13 Aug 2024 07:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E8498Olq";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E7E10E232
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 15:00:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B30FD60921
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 15:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADE4C4AF0F;
 Mon, 12 Aug 2024 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1723474818;
 bh=sVrXZXI7CBoQfRqFkJa8UtNQF3Cbc1SAfjv8VFMOQpQ=;
 h=Date:From:To:Cc:Subject:From;
 b=E8498OlqKtVNaJ0f+8w1tApZyKC+Mu7m43HcMdC/TdJ+a4sivYJ1XmS2zx+xLRQOz
 i03uBG7SkIzlpd69EA/SkbzbnZ/TvmGlF9lC/9V11DPQb4hcRRQt3249w2YzwDo+bM
 wxWHQ44XLSWD2z4kGIM++wB16oA4jViVLOMR8Xdo=
Date: Mon, 12 Aug 2024 17:00:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: AMD drm patch workflow is broken for stable trees
Message-ID: <2024081247-until-audacious-6383@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 13 Aug 2024 07:30:16 +0000
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

Hi all,

As some of you have noticed, there's a TON of failure messages being
sent out for AMD gpu driver commits that are tagged for stable
backports.  In short, you all are doing something really wrong with how
you are tagging these.

Please fix it up to NOT have duplicates in multiple branches that end up
in Linus's tree at different times.  Or if you MUST do that, then give
us a chance to figure out that it IS a duplicate.  As-is, it's not
working at all, and I think I need to just drop all patches for this
driver that are tagged for stable going forward and rely on you all to
provide a proper set of backported fixes when you say they are needed.

Again, what you are doing today is NOT ok and is broken.  Please fix.

greg k-h

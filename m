Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D572C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 01:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70DAF10E1B1;
	Wed, 28 Feb 2024 01:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k1o2nvXp";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112BE10E1B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 01:45:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F297B6124C;
 Wed, 28 Feb 2024 01:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B25EC433F1;
 Wed, 28 Feb 2024 01:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709084757;
 bh=xklcXaT4eTFbG1Se3wPnwYyKUpa9I+yjQPpHl5UYWHk=;
 h=Date:From:To:Cc:Subject:From;
 b=k1o2nvXp5EtvIzAJsZdS4HVaUtlu2Q+gBiNAqnYIRCBT+FydDt1frqGHPHoGMtFVS
 b9YOisZu6kY4XeHewr6V+b4+d01/ZiFM49wqxzdaJkdKg4m3dP09Yb08o269aDG9Kg
 JMNXu33I0T+oxNzJedrVag+hiODUTlLDBAO4fRwMUCAgu0Y88hmrUr/Uwsm2JTgRvJ
 jknM1xzdEpYoPNfvT2BQcFyRi+pRM21RQqOta/GDrE6ah9/lfNZdpTbAGXeYcuoAsn
 0JZvT5xG9AULMyYf7WEsKWAnHH+URMn9Ge8623Rp26DsRdkkBEQiHKweoIG/V/Ik5S
 zDewdYhP+DSow==
Date: Tue, 27 Feb 2024 18:45:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Please apply commit 5b750b22530fe53bf7fd6a30baacd53ada26911b to
 linux-6.1.y
Message-ID: <20240228014555.GA2678858@dev-arch.thelio-3990X>
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

Please apply upstream commit 5b750b22530f ("drm/amd/display: Increase
frame warning limit with KASAN or KCSAN in dml") to linux-6.1.y, as it
is needed to avoid instances of -Wframe-larger-than in allmodconfig,
which has -Werror enabled. It applies cleanly for me and it is already
in 6.6 and 6.7. The fixes tag is not entirely accurate and commit
e63e35f0164c ("drm/amd/display: Increase frame-larger-than for all
display_mode_vba files"), which was recently applied to that tree,
depends on it (I should have made that clearer in the patch).

If there are any issues, please let me know.

Cheers,
Nathan

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33086C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 08:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A76B511351B;
	Thu,  6 Jan 2022 08:25:15 +0000 (UTC)
X-Greylist: delayed 318 seconds by postgrey-1.36 at gabe;
 Wed, 05 Jan 2022 21:31:39 UTC
Received: from forward104p.mail.yandex.net (forward104p.mail.yandex.net
 [77.88.28.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DB289BF3
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jan 2022 21:31:39 +0000 (UTC)
Received: from myt6-a7b93d14a87c.qloud-c.yandex.net
 (myt6-a7b93d14a87c.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:2492:0:640:a7b9:3d14])
 by forward104p.mail.yandex.net (Yandex) with ESMTP id 0FF723C1E677;
 Thu,  6 Jan 2022 00:26:17 +0300 (MSK)
Received: from myt5-cceafa914410.qloud-c.yandex.net
 (myt5-cceafa914410.qloud-c.yandex.net [2a02:6b8:c12:3b23:0:640:ccea:fa91])
 by myt6-a7b93d14a87c.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 oRrWpH315b-QGeqQIOW; Thu, 06 Jan 2022 00:26:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1641417977; bh=cq4tsU5pDnLDeBZpZ8/vm7TCIw9KkhUDRSOhwBZM/O8=;
 h=Date:To:From:Subject:Message-ID;
 b=Yq+bLphZeaE8uibtITZUIbPvYP3mvxUJehdEml+I43b3B9yJQyEQhYaKY+1Efgaao
 MUlyQ5qFyIc7XRkMQ9DpJrGDGbsDMszPt9LP9T/PR4SxBK79Sg62h5wNr8galZZqCh
 XzOtcIdyl9iz9j9qBXKqubJG0xGWyqO4QJIkgWDU=
Authentication-Results: myt6-a7b93d14a87c.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by myt5-cceafa914410.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id L5adxC5tU1-QFPqNdND; Thu, 06 Jan 2022 00:26:15 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
X-Yandex-Fwd: 2
Message-ID: <7143a7147978f4104171072d9f5225d2ce355ec1.camel@yandex.ru>
Subject: Bug: amdgpu stutter and spam `Fence fallback timer expired` after
 suspend
From: Konstantin Kharlamov <hi-angel@yandex.ru>
To: linux-i2c@vger.kernel.org, wsa@kernel.org, bibby.hsieh@mediatek.com, 
 amd-gfx@lists.freedesktop.org
Date: Thu, 06 Jan 2022 00:26:15 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Jan 2022 08:25:13 +0000
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

Hello! Just a heads up to this report https://gitlab.freedesktop.org/drm/amd/-/issues/1850

Basically, after waking up on suspend there're freezes in apps using amdgpu, and there's a spam in syslog `Fence fallback timer expired on ring …`.

I bisected that to a commit 

	5a7b95fb993ec399c8a685552aa6a8fc995c40bd i2c: core: support bus regulator controlling in adapter

Since the commit is not in AMDGPU, I send this email to linux-i2c. The commit author CCed as well.

Should I send a revert, or is there a way to fix this?

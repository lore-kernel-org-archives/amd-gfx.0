Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736C7D3A675
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2F310E6A6;
	Tue, 29 Oct 2024 17:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.b="ftJCncz0";
	dkim-atps=neutral
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB3410E138;
 Tue, 29 Oct 2024 13:32:06 +0000 (UTC)
Received: from fpc.intra.ispras.ru (unknown [10.10.165.10])
 by mail.ispras.ru (Postfix) with ESMTPSA id EAB4E40A1DA8;
 Tue, 29 Oct 2024 13:32:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EAB4E40A1DA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1730208723;
 bh=h+3XDlW6T/2uheGXHlR7H84/H84D9Vs/nAUE/JVwEwM=;
 h=From:To:Cc:Subject:Date:From;
 b=ftJCncz0e5MIm4Z/yaQ3uNRRWlnNDce39E8zxZk0yPtHeputXrErzMOHxlUkCnvxx
 3VtKRHJ0oVoKL8BOMF18L3lHAQvDuIqm1qptvweIwTWGBbxzGNNEGzf6aM+nlwPaa+
 nWPL4vgHbwQReqP0Ksp9TjtBCAkm5lDkFP83FbX4=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, Alex Deucher <alexander.deucher@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jonathan Gray <jsg@jsg.id.au>
Subject: [PATCH 0/1] On DRM -> stable process
Date: Tue, 29 Oct 2024 16:31:40 +0300
Message-Id: <20241029133141.45335-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Oct 2024 17:03:44 +0000
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

I'm writing as a bystander working with 6.1.y stable branch and possibly
lacking some context with the established DRM -> stable patch flow, Cc'ing
a large number of people.

The commit being reverted from 6.1.y is the one that duplicates the
changes already backported to that branch with another commit. It is
essentially a "similar" commit but cherry-picked at some point during the
DRM development process.

The duplicate has no runtime effect but should not actually remain in the
stable trees. It was already reverted [1] from 6.6/6.10/6.11 but still made
its way later to 6.1.

[1]: https://lore.kernel.org/stable/20241007035711.46624-1-jsg@jsg.id.au/T/#u

At [1] Greg KH also stated that the observed problems are quite common
while backporting DRM patches to stable trees. The current duplicate patch
has in every sense a cosmetic impact but in other circumstances and for
other patches this may have gone wrong.

So, is there any way to adjust this process?

BTW, a question to the stable-team: what Git magic (3-way-merge?) let the
duplicate patch be applied successfully? The patch context in stable trees
was different to that moment so should the duplicate have been expected to
fail to be applied?

--
Fedor

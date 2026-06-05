Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0424CD8C96
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jun 2026 07:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67BED112D77;
	Sat,  6 Jun 2026 07:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="rQaSNd5v";
	dkim-atps=neutral
X-Greylist: delayed 678 seconds by postgrey-1.36 at gabe;
 Fri, 05 Jun 2026 11:44:02 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8D811A798
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1780659841; x=1781264641; i=markus.elfring@web.de;
 bh=CMdHGUxs8Ri/zAHYzo036fmvdg11ZbV7UKbl7K5xoYQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
 Cc:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rQaSNd5vNScD6a3ue1BkVkxxqggKyi+OOqdq+zZYZOpNeOwX1s+MEaOKI0sSTMyv
 bYyxj/j9GrqscWMlpvmMDyltbh+OUusoPsMOD6WN3+PXV3fvdwHBN/SJ40Rp87a5T
 dJj6/9AbVy/o3nBtQk0+za1/aDBkmP7XgZ1QpgJ1++0MeHUIN3B9ppGjNHEt+TET2
 DSEnMGs3fiP4ErgnWQRRXDii3xA8l9h2rLFYTkXSfaH5mipa/tsvqGiMd2zrtcl54
 0w1dhqG+zrHOggflS+oTkKbjiCbHudLFCVbyxwpQnmXU+WkXc5j2itC/h/2a93JaJ
 ZnLMmGAySOzwIz0ZPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfU1-1wtRWZ1mRP-00XLds; Fri, 05
 Jun 2026 13:30:20 +0200
Message-ID: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
Date: Fri, 5 Jun 2026 13:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Kees Cook <kees@kernel.org>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Rong Zhang <i@rong.moe>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Tom Chung <chiahsuan.chung@amd.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] drm/amd/display: More efficient data output in four
 functions
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YjRKuUg1oNMMi6pzfxyr7Gew5lL6jPzt8INLbghegPb013dsjpc
 EQFfb98aUrrebZIY9gGod8s/rvckYRI7mJHU7px+/AzcP/Zwu+m2Lw7B9xl9gCZevONFr2E
 L9cJjMCpI5TgL18pcMZlzF0KfGoF0OfTIAH6dmmiWYG7ED2uVb5yAY9rOeggSWoIqO7nF84
 0LqZMRCeyTnsu3vSNR+Eg==
UI-OutboundReport: notjunk:1;M01:P0:qcBtKdvY8zw=;y8n7/PBzJhbFcScN0t6Ra+fjpaR
 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
 6n59Sj6/moL7UhRBlh9YIt6gZPw=
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:22:57 +0000
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jun 2026 13:00:03 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Simplify data output in psr_capability_show()
  Simplify data output in ips_status_show()
  Use seq_putc() in three functions

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c   | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

=2D-=20
2.54.0


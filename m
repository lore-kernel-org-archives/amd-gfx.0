Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB304CD8C8B
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jun 2026 07:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEC5112D79;
	Sat,  6 Jun 2026 07:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="Z4TCCuG2";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1583210E615
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 11:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1780659484; x=1781264284; i=markus.elfring@web.de;
 bh=6LBnlSmiBPuB+N4bVjMCx9ZmUvUeo2H9AeSH0XpS1vo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Z4TCCuG2+mCY46FIL04aC/owL/qW2uxf2wDGs5IpiwpEt4wnXH+IrS6QXYqXkTNE
 X9q6ksnqDUuMicN/KUGzeTpMxibJCEJxxwtv6jbdZdwqjc64bGbf0fRxFdJwCMKVG
 3QpXtL9I61pR1hcX9TNX4V4Pq9eAXs5qq+513R6HofOPmkZ6CFt59cqA8RB4NPnsm
 UvFWMLBhx585Chg6PqvH3imUnSXF/1uh/+ngcYWECZjXmAv8lJ7P87DyyHoDjqVve
 9F9OVeXBynPEe5k3kDGS5DQ2HKd2p7K9hJxdrEtHU8inPDZUToAU5bL/uQgC0J1OY
 jM2oi2EvUbM6XiR5Gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62yY-1xJwop3iDw-00yBxe; Fri, 05
 Jun 2026 13:32:39 +0200
Message-ID: <89f8663f-2a5c-4f1f-a534-0934195e7fc7@web.de>
Date: Fri, 5 Jun 2026 13:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] drm/amd/display: Simplify data output in ips_status_show()
From: Markus Elfring <Markus.Elfring@web.de>
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
Cc: LKML <linux-kernel@vger.kernel.org>
References: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CYcxFNZhVdW+vbAHngJKGkF1xlYwzXR59NPAuIrJKPec1oDeQLG
 WAaIQWk+6EoYnZbOIF0aQzCyatQwxPmuQrKSOTgU3yNxIbBME1OaSltj3iCUnAMubey7S5O
 fioytaDxxuGkEfyi5sWb9JIH2ysuV2klHCj/hE7CN7zS6PWQxt8BWBQSHUu+M9J5hOjE1Zm
 nBY0PFbLKrpkAm8zt643A==
UI-OutboundReport: notjunk:1;M01:P0:yU8keT1Tqsc=;RWkXzu5tOvf+8XAYCiIF+dTN5sD
 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
 ZPXiUg==
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
Date: Fri, 5 Jun 2026 12:40:31 +0200

Move the specification for a line break from a seq_puts() call
to a previous seq_printf() call.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 6e6f391b640e..885e9b7bc27a 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2705,11 +2705,10 @@ static int ips_status_show(struct seq_file *m, voi=
d *unused)
 		rcg_count =3D ips_fw->rcg_exit_count;
 		ips1_count =3D ips_fw->ips1_exit_count;
 		ips2_count =3D ips_fw->ips2_exit_count;
-		seq_printf(m, "exit counts: rcg=3D%u ips1=3D%u ips2=3D%u",
+		seq_printf(m, "exit counts: rcg=3D%u ips1=3D%u ips2=3D%u\n",
 			   rcg_count,
 			   ips1_count,
 			   ips2_count);
-		seq_puts(m, "\n");
 	}
 	return 0;
 }
=2D-=20
2.54.0


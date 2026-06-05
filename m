Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC7ECD8C90
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jun 2026 07:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CC0112D7B;
	Sat,  6 Jun 2026 07:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="utcZiOiM";
	dkim-atps=neutral
X-Greylist: delayed 374 seconds by postgrey-1.36 at gabe;
 Fri, 05 Jun 2026 11:36:59 UTC
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F96410E612
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1780659417; x=1781264217; i=markus.elfring@web.de;
 bh=wgEiKtbllfO9OonOAtpb3Ylmk6jkA2e38dIKpcgdKjQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=utcZiOiMEd2WafBPaZAfgDd0T3uV147WKGcs1cK5wo4qu9ZF0hMVYq7+UlhJsA+v
 xXZbS0XGpBMHQU7/0mowEkVX5l7WFlJoSGDUtnFmCV7nsYnVZqSilkHwJ8mGFuGrX
 X5N1/z95aYFHwpcH6+Tx74CUx94Cc0tccF0YuCxdWOEOv2KqHpLG5OihmyWILxDsd
 rrQgy5pbAZ9PKIRh9yNB4xwK9Zc1hMZumNPBTmCd/QHadE0ayJajpa8Kq7dLHUjQk
 +QjEdZ1wDZ9q0Hc4KheR1lgY7GagLOXfZ1chbPAUrMUgrQ9YyD548oBVOX1xtlkzo
 CdjEHN3mCyazXx0qCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdfCN-1x4nSL3XTF-00itXn; Fri, 05
 Jun 2026 13:31:28 +0200
Message-ID: <e2023393-da68-4775-9f55-16363191328a@web.de>
Date: Fri, 5 Jun 2026 13:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] drm/amd/display: Simplify data output in
 psr_capability_show()
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
X-Provags-ID: V03:K1:Y/EQ0GSwyX3z+Tzi/Qanb8V+kF6+He3zHX1nm6+wzGCmVTCCTEz
 KPvt9us1UKEfPMYfjMeZq4WW1LJ9mT7rJoRgyG61nIVrc35eYRvG4vz34cCXsNU7MJ2bcfv
 m6erlnW8z7AdvYFUvKgVBOhoeHTy04779+ioe8CjHWdpI4GIGn+9lQ4fwJwoME5S7PH816I
 Rtt7TGJafY4m6yKY5v4Ew==
UI-OutboundReport: notjunk:1;M01:P0:pocv5Za6paM=;i5E50bIb+5VEBcyMyoTb1UCS3/F
 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
 hI0iQP5X1Y580/2Ktfcr5XvxWx0=
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
Date: Fri, 5 Jun 2026 11:39:13 +0200

Move the specification for a line break from a seq_puts() call
to a seq_printf() call.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 4b09a740f205..6e6f391b640e 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1076,9 +1076,9 @@ static int psr_capability_show(struct seq_file *m, v=
oid *data)
 	seq_printf(m, "Sink support: %s", str_yes_no(link->dpcd_caps.psr_info.ps=
r_version !=3D 0));
 	if (link->dpcd_caps.psr_info.psr_version)
 		seq_printf(m, " [0x%02x]", link->dpcd_caps.psr_info.psr_version);
-	seq_puts(m, "\n");
=20
-	seq_printf(m, "Driver support: %s", str_yes_no(link->psr_settings.psr_fe=
ature_enabled));
+	seq_printf(m, "\nDriver support: %s",
+		   str_yes_no(link->psr_settings.psr_feature_enabled));
 	if (link->psr_settings.psr_version)
 		seq_printf(m, " [0x%02x]", link->psr_settings.psr_version);
 	seq_puts(m, "\n");
=2D-=20
2.54.0


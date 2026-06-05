Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E94ECD8C93
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jun 2026 07:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C21112D78;
	Sat,  6 Jun 2026 07:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="rCvXuPVe";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07459112ACB
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1780659544; x=1781264344; i=markus.elfring@web.de;
 bh=5xZ+f8SzZDJmAU1EnpH9VXvDuhlbt0Ej9kbmVsUaruM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rCvXuPVeK+/HXnPdFIz/XmkJztX9rHT0N0kICsWMoDeJtr3NBMYDFmm63H1auanc
 qFPKB+xXlb2gDHcRSVr/d1JCHmrPFi2MnAyaKXrC37dvPxSoWovCVyLWzWfvhpf4/
 mfNKdvCr1A0GyFAnVaSzZ3RLJ6/SAewoOYPAj+esBT0xqznogRZ55hiNMzXy0gZxu
 IXQxmM2JTGk7IT4SrSJIjZ+OAutlR4raMc6AqnswJUEuH3gFewQ4hs05xmerkIYkG
 IKVwHhhmxRN13q9+QoIpKZ0k7/H/xaORrtKJGO5CUWclVxaW6XfHRrv6kA8lW5ASJ
 eP3P1PzUHCVmIvRNPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVwi-1wyRmH1mjG-00cggA; Fri, 05
 Jun 2026 13:33:39 +0200
Message-ID: <da65ea0b-81bd-4109-89cd-f4a5120edba0@web.de>
Date: Fri, 5 Jun 2026 13:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] drm/amd/display: Use seq_putc() in three functions
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
X-Provags-ID: V03:K1:HgInL5ze4wR8Y0N9Mto0KsoCWfwmTzkVA1Oa8BEkJD/EuLbh2Jp
 DN5y0RTawt+zh0CCLaSb5BQKBGPcmCmCPzLF3X6Xb3OapZyQ4NnSpN+QKpQfgnYnOC+SZsU
 l5Dqo+TTFNJr6nFhuN3bA2764Rx+8aGtm3Q+hjF+0XflCCBvf/UoOqISgKPbB0yJzqlGj8t
 YXQ5AK95JhxU5TfANSHCA==
UI-OutboundReport: notjunk:1;M01:P0:AIIZkaF3mL8=;VzRgb/PuKIrkSufPQfiOHKxqJww
 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
 P81Low==
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
Date: Fri, 5 Jun 2026 12:44:01 +0200

Single characters should occasionally be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 885e9b7bc27a..e45fa6e97fc6 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -606,7 +606,7 @@ static int dp_lttpr_status_show(struct seq_file *m, vo=
id *unused)
 		break;
 	}
=20
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
=20
@@ -1081,7 +1081,7 @@ static int psr_capability_show(struct seq_file *m, v=
oid *data)
 		   str_yes_no(link->psr_settings.psr_feature_enabled));
 	if (link->psr_settings.psr_version)
 		seq_printf(m, " [0x%02x]", link->psr_settings.psr_version);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
=20
 	return 0;
 }
@@ -1266,7 +1266,7 @@ static int hdcp_sink_capability_show(struct seq_file=
 *m, void *data)
 	if (!hdcp_cap && !hdcp2_cap)
 		seq_printf(m, "%s ", "None");
=20
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
=20
 	return 0;
 }
=2D-=20
2.54.0


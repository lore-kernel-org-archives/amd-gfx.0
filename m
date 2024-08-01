Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26327C52D70
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 07:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966EF10E9A0;
	Fri,  2 Aug 2024 07:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="gN2ljHnU";
	dkim-atps=neutral
X-Greylist: delayed 322 seconds by postgrey-1.36 at gabe;
 Thu, 01 Aug 2024 16:58:03 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A4410E02D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1722531481; x=1723136281; i=spasswolf@web.de;
 bh=YXzdAyJuCN+crNIs8n0L2vrv8e4Yz9lRbDuGR0XjS1A=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gN2ljHnUhvpdfAJdptXcPPguuN9YXFqwH18t7m1TqplLsq72uXgCw8XDP+mdFdf7
 /3dupNTcdQNaakk3vS8CaagLTKyNs7MklOaSbRNVlt7MwVR9FrizD5er+HW9CGfrw
 UkklMbIyn75dyF0ZOnLs27kKgXbz4iyvGYUtnBuIRY7M3q5UOMnc7R53X1qhJq7W/
 DCepHzgLhexYagZHrRMZs0NP2qk5zG3MBfdSdNEWUKsRw38bU/wweJjT9CusI3Qf9
 QC6GKvV08d1ej3bsZA5GYUXs2HxPNeKk6P5feiIiQRN04qXmj2UMcQw8Cu+70+fZI
 7tgghZ/xEYGySMMbtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MVrbz-1sjDXd3vRF-00TU6B; Thu, 01 Aug 2024 18:52:37 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: commit 9d8c094ddab0 breaks Xorg/xfce4
Date: Thu,  1 Aug 2024 18:52:32 +0200
Message-ID: <20240801165234.2806-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:84uszetUgx3rIli4ubyycxiX/XKr4EoFSLGH2U7qZS1I0dx4F1M
 tihI36Ktj+Z9y0jfN4y6puI9HduYSkR5hWRpX/3AQW8+823JtMVrnd4rAl9k1FxpPyZyLbT
 pFUGoHhgXMi3SC5iZc78p5GYQkQM7xpra8xrefoSj+fzbQifjP7ScOmixgRYBq8hhf4FDOv
 sTy/wSwzV3RjSI0QwvYNg==
UI-OutboundReport: notjunk:1;M01:P0:OqkyKK+uCns=;28jgk4DZB24WbgmTCgiRNWmznEp
 XEyz5RFRRICegcEBHfZykJVZShZZvlH6eZ60lxqvhD3vJ8fOGOCVkbdl4p9FggcrkXXnrFNN8
 lRsp16v84BeVmSoZqyL0cn1VFEOzbcGTH1nHfNV7PySt6AZj+4Grr9IuCouGzPNpqv2I28HAz
 W/e/sEPzcRq36+rga8aQM5x2jSdngGpzfZbLXYvWZ5xRvP39pQ+uhtx9Y0aZeXIdX3NOZWQ9j
 Vpbc6gSnnSxV6JciXL7Z0tmv5o1B0o7E9FlrCKqqVTTpltoWCf027eldGRmW1/SEjJYYY5iqR
 qWhFyCKkQJv53uyX9IZyNW3E55WSGCHDzAdaGH+sy3rne9JkHuzbL5yo8AKq9cmzS7HPcfBTo
 2OddiMdQ8mY5EoaZY3CwttTatI8R/GltwKVQ22evAxf9D8fZqeMS5kGWynFC4zSR2NOHs+nSn
 QwJ0HVfq3ZrurPLn421G6gbXZOO8KRFJOpjUf/s6a0hpBwomgF7MCcAMeGx5KcH5rp7iRElFK
 0Q3mCwS6HsFx7N4zFaNibVW6aR7ffhHPv2iKVEEXYzJIDHsZ8uUWp6gXhE3S2kKLpTT9N8Vqs
 tlaJrkz/6CIAY67kNBmbu/T4477z4rDJG+ia3hZiRiQEXhNT2osOj1Hr3p6hIMeGlHCnd81UT
 WvKibRf1tE61I8k0/acnMu+HQeHXdX2jEsKQfds8+919V1BoIiHoDeZK5dikGjWlyRGERN24S
 4zv/zQeM2CSZ8SF0H/FBpHoVDONqE/Uu5vzaIwYTwVHoi7qspm27DWupEzI1KS6Z+DrpNRonl
 vr/wy+T2QXCJSSKT44NR5ZDQ==
X-Mailman-Approved-At: Fri, 02 Aug 2024 07:37:20 +0000
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

Since linux-next-20240801 starting Xorg/xfce4 fails on my MSI Alpha15 Lapt=
op.
I bisected this to the following commit and reverting this in linux-next-2=
0240801
fixes the issue for me. Gnome (with Xwayland) works as usual.

9d8c094ddab05db88d183ba82e23be807848cad8 is the first bad commit
commit 9d8c094ddab05db88d183ba82e23be807848cad8
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Wed Jul 3 00:17:22 2024 -0500

    drm/amd: Add power_saving_policy drm property to eDP connectors

    When the `power_saving_policy` property is set to bit mask
    "Require color accuracy" ABM should be disabled immediately and
    any requests by sysfs to update will return an -EBUSY error.

    When the `power_saving_policy` property is set to bit mask
    "Require low latency" PSR should be disabled.

    When the property is restored to an empty bit mask ABM and PSR
    can be enabled again.

    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
    Reviewed-by: Leo Li <sunpeng.li@amd.com>
    Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
    Link: https://patchwork.freedesktop.org/patch/msgid/20240703051722.328=
-3-mario.limonciello@amd.com

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       |  4 ++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 52 ++++++++++++++++++=
+++++++++++++++++++++++++++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 ++
 3 files changed, 53 insertions(+), 5 deletions(-)

Bert Karwatzki

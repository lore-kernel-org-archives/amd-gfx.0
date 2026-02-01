Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35300E7C717
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Feb 2026 10:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CADC10E19A;
	Sun,  1 Feb 2026 10:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="qWxyUGqB";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BBAA10E021
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Feb 2026 00:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769905834; x=1770510634; i=spasswolf@web.de;
 bh=d6RYlx3yK4P+6jd/5Dgx/Cn1UsWZNBAbdIwOfCNrkiM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qWxyUGqBD+uiU/R1APmXEZm3eJZLTqrqezos+Q4Pa08Ux5Fw5jEUElzczBEAfDIV
 M6Rpa0DEn9Y5DMjE6QdEmmOBMg08EY77ElhDPFjoaQVTRVfePA1iXnxNuqBzoWFHG
 lqxURgCKgMBnueiBS53oyXoe9/RmZbcvfIf3RvnyyXcaa16Gqdu4tW8QfjfikiNjw
 xR6dBl0ppTYEDO2o7Jzivx3M0jRccm9y/v3Kmrz7auWP2UzA0Pf9DJTqmAwlH9rZJ
 D+qe5h7gdwbLwHzXEiM+CxtjSlztsgLkltVjL4PbTsOAYg6jYyFo+eOnvV440GN5v
 mFTBqeQbOU/Mqe3WGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MxHYK-1vxFOR2bt2-013256; Sun, 01 Feb 2026 01:25:11 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>, linux-next@vger.kernel.org,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.18.8] Revert "drm/amd: Check if ASPM is enabled from PCIe
 subsystem"
Date: Sun,  1 Feb 2026 01:25:06 +0100
Message-ID: <20260201002508.1293510-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kkjx055O66fHG9mySxQvFWsbp905osS4cpb77/CuMdx4sMVBqsY
 XQeU5h7om42I93gOtTaJbVlwu8tokQuw2xCtLQYBwnSK7bCEeZC9cD+7Yb+k60SFAfI+ul7
 hvKBJV2yfi8bxe1U2sdyQ/C5/DzbyhFdy1LjqKIKWx1cEU548hHVJDnVWvMldZWrk7onEfl
 2qL9pjBbYFKAIMEIxj8sA==
UI-OutboundReport: notjunk:1;M01:P0:AHd65BPKoRY=;+EXGkxGhMkHCGqhwAS4Xd9EHFN2
 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
 eg0PWh/WxGVMyMdUGiVv3MMFHml8fjImf6qkJd
X-Mailman-Approved-At: Sun, 01 Feb 2026 10:52:53 +0000
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

This reverts commit 7294863a6f01248d72b61d38478978d638641bee.

This commit was erroneously applied again after commit 0ab5d711ec74=20
("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
removed it, leading to very hard to debug crashes, when used with a system=
 with two
AMD GPUs of which only one supports ASPM.

Link: https://lore.kernel.org/linux-acpi/20251006120944.7880-1-spasswolf@w=
eb.de/
Link: https://github.com/acpica/acpica/issues/1060
Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per =
device")

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_drv.c
index 7333e19291cf..ec9516d6ae97 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2334,9 +2334,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
=20
-	if (amdgpu_aspm =3D=3D -1 && !pcie_aspm_enabled(pdev))
-		amdgpu_aspm =3D 0;
-
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(pdev, flags & AMD_ASIC_MASK))
 		supports_atomic =3D true;
=2D-=20
2.47.3


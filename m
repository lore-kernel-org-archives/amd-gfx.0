Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E6EE7C716
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Feb 2026 10:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE5310E1B5;
	Sun,  1 Feb 2026 10:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="QzV7BNb4";
	dkim-atps=neutral
X-Greylist: delayed 309 seconds by postgrey-1.36 at gabe;
 Sun, 01 Feb 2026 00:30:13 UTC
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E42D310E021
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Feb 2026 00:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769905812; x=1770510612; i=spasswolf@web.de;
 bh=y0V9evUWCSrc36tGmZkyA+MaUew9cEUr5/Zz2d8SD/4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QzV7BNb4dYvy0/Wr4UQ+zfoqaMKQr++joie9xwqRxjgl1Lq5mgOajpr0pkcycpZE
 vgIuc5lBo5d4HWmgFDp8B6u6uK1+SkmE8cHn2qhWrRYyD17rpWusXNSXdqShyqvAa
 8KstaSAazeRxwd02pWa8zNcXHDJ+/yKL5vQG8qnfD6ou2A46HjihGZkKuEZbrkFqu
 3LhLzTGICtsZXK65lsqqc79BH0NAJ9nao7tuKN++mgRJaSUbmbp8TEobnmvklsOdV
 YIbda7rUhjE7aBZlbOtjV+K1bpZ11PuMph33gdEXYhJXW698iA8OJUe4rjnDdASam
 JpNzVgLKT407nkNaPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MpU1w-1w4uNR1TYK-00be1z; Sun, 01 Feb 2026 01:24:49 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>, linux-next@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] Revert "drm/amd: Check if ASPM is enabled from PCIe subsystem"
Date: Sun,  1 Feb 2026 01:24:45 +0100
Message-ID: <20260201002446.1293486-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sn8qE80Gv/XGh35Mtij6Yfr923Y6MWZEmL1cr19ydeNwDae6HlA
 V0tlzMngsUmFXyhX2FNRjuqmMPMPAbMHAeNk59JNFJIMmzD0UHnt2RKSY7CkJyv0WojkPgu
 ACDGq7mX547b1BhyVq2qyTukH8tZnCMWs3ywN3LWkJE3cNdiqNjGuxESaI0gOjO+SK5kZwy
 UHOoGXfChalPBAK1udsEg==
UI-OutboundReport: notjunk:1;M01:P0:9aiub/v88Ws=;6v3ZtrjQzqbrIYk1WTtQ/jZkzVV
 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
 uoi8j1VgIvp4m48SeFhpEWBYEnlRk1NoZzuiwG
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
index d6d0a6e34c6b..95d26f086d54 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2405,9 +2405,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
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

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A495C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 08:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2137C10E333;
	Fri, 28 Mar 2025 08:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="CFUAsBWu";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261C210E008
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1743105268; x=1743710068; i=natalie.vock@gmx.de;
 bh=iiUjQT48nMtMus9CRebJbO4RcBkAhCE+mHpEAw//WRU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CFUAsBWucJKcwoXCxKvhuhMxUC4I5Y/IHixv55V91S5W4Ps0KuKySZC+0h2C/KHP
 DMjJtbN4K1+I+gzNz+Y8XXiKphdoBwpnZA5yEGI+UM1QyXQwxOO0D747tr8ZiuFAQ
 RCK6v4QnU0h1bbR1EnpvhuImrtKx3Dr3Mp5VG2Ypg7BWqfQfN8e4fGOlwctEDyUzl
 Gc8cCsAp0slZuEtDdS57KXTsg7SdjKTwZpCvawWQgTkyQszfM7FbD6pwTP7Fw40Ms
 B7OJoRcUpaCFuCjTiydXao2bxE7nqmqfhlk7HUC3bYa3ogo0KjoPr4bTaP9Tqe2fS
 20+p/1L8/YjY69wJpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([109.91.201.165]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MUowb-1tXFjh3Dof-00UxEZ; Thu, 27 Mar 2025 20:54:28 +0100
From: Natalie Vock <natalie.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] drm/amdgpu: Add cgroups implementation
Date: Thu, 27 Mar 2025 20:51:28 +0100
Message-ID: <20250327195400.130758-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:grWYKW44tPEuTtoFWS5uMKtkW5aReddzei8HP6qvEBhOwUoip3r
 cMHAynOUUD8YpqTOnwc4kPNc9Rha4R5cxDEmhLIIIfl3h9l0G7kzZ43NgRLROpowdYI1Ax0
 d6DpkDKBK4zjE+OJt+ns4OIb7UCeU+9dFjeiVGp0UO6fwyok3exzLzDD9GBPoKvEA6ZMki0
 AnWRS368IM9Dp1CZb4t2A==
UI-OutboundReport: notjunk:1;M01:P0:rU1bjI/HBAc=;H4b0u9/0B9XNMMRVG32w3XrxSuJ
 YZe3yOVELOkDY2uDVrOY/8Z8uRLoLCqA0AUYdji+Es1xMBjSeUMSU/oZYyot+lJvDAuxzaNRc
 NlG+/bBKJYcAF9nUdWlZuNzXE2MNTOABlMoxpJNdvZCjvtNO9D6VQmBPt0VcR9DRvZ6HqRbqe
 UR9m6YE+9x9GtpnxPCAJkZ/m4viUrNegeJQZE3V6AurWs68FcQVNvmkPnqFx5SjvAqLwmRrm4
 U8kKTuIpe58uRKF1XJad5k/Fsr91oDxTWRW593m2a9ZOSyJ1sHbNeNltQG6NY+64WzN/vv2LT
 A4wd3rSJJUYd5b7ORkBfKBHW6BjzNfkNjSH7lz0BR/yvU/gETQiKidqz7Z+HmdATdi6cMAKab
 PXWpY8XBxVZchBJKeJZRl1KAfZC7raV+Cnte/GzOWEL3qvbffMJkys6I2inyI6Vvq+19drMFF
 5LcHsnjY/9C0j3z8XsEVTsW3GK3DYL2GDEHAraGlWJE6LiAOKp15tmdzjnn3dd4Ixs5YZ774f
 1yM3dAfWzEyMxd1/T19xJeKElrqzSolscymaDkP0YUpJLwkyWk/tDoJJv5yiFdtOuVw1g/hQX
 Hpy8OxDCr0LsiMTwVJkF1UAVUla2VoNIX06eo/GrlqcOnL4I8Cbc9UgJgBBH0oqjXpU7kbCgC
 opUMkipH2k9EkWjZ4yZqdq7Km1msQPZEAoV4/RQfxEje5Y1mEA9tSIQStsSyIDp+f8RvL8Mil
 V0c1dr3c7/7yMYJGajTmyPisqppUPoNiRu5ubAMwI5L67e3Mc4HTFz9JYbYRVIKeKld9haH/j
 evhhSt8dTNQJY4h3KAKXuI3NiF5nB0xAgid35v5xw1wDI41h3qcdy1ln8vE9SkZP9oQgXGTzS
 XoZgTIMYuVMIfuGNb1KQ6hwJToWtEmrk5YbMy/mj95lC9mPjoYn6wmKON0EtA+U+ajJlk7QGN
 WXeuaFQ+LbkrDANHfaSNqWTtrYCxUvxEmPe4gccwSEXySfdnWTi3L5PGJ00JPRgeL0TSUdtMV
 mOatqEiaG8q74CPyqkcEo44GHT+dkH3PAReoOD7fNwVQwDUDSfm3aHemsm+8fyKasBTFKXkq6
 oDxDxHab2Pa7ng98oPurvmEwwKsePpi7QybspzikXHT7D+MWk1HHKsUV7QckKIrnEB/obWw6Q
 N4/oVrvAAly5SE36UJuMmPvW0qC6QU1M/HdDNVR02oMc7OuFp1g+/2H4HMpy+AJomRf0NzS+C
 lsABQKf3WnFunH1WNrrgRb5oXfEC8c2NAr+IeDsrkTlqbsEzkLnRSBZtRdxdrwGGTHRo8zif1
 FC8RBcfC/78upu9vcoTcBy1uyolIbulsJizXAiGa8Jb5dtAg3uO8RRbq01DxME9fvb5h8W5aS
 nRRgZoYG3Yed7QT59xaPvyYNxivDOeQug7xVN+Jfp/u6ytZ8jSLlZ6a3hrYrdKOuKUdrmmtMU
 IZyE7wien6j26Ppe1AUVEQq2m6aQ=
X-Mailman-Approved-At: Fri, 28 Mar 2025 08:18:37 +0000
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

From: Maarten Lankhorst <dev@lankhorst.se>

Similar to xe, enable some simple management of VRAM only.

Co-developed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
=2D--

Resending this one since it got lost in the initial dmem cgroup
submission. Probably needs to be merged through drm-misc-next since
amd-staging-drm-next doesn't have dmem cgroups yet.

=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vram_mgr.c
index ff5e52025266c..7b86d7f9d5d56 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -24,6 +24,7 @@

 #include <linux/dma-mapping.h>
 #include <drm/ttm/ttm_range_manager.h>
+#include <drm/drm_drv.h>

 #include "amdgpu.h"
 #include "amdgpu_vm.h"
@@ -908,6 +909,9 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	struct ttm_resource_manager *man =3D &mgr->manager;
 	int err;

+	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev-=
>gmc.real_vram_size);
+	if (IS_ERR(man->cg))
+		return PTR_ERR(man->cg);
 	ttm_resource_manager_init(man, &adev->mman.bdev,
 				  adev->gmc.real_vram_size);


base-commit: 1822532477cb5f007313de4c70079c09aaa270d5
=2D-
2.49.0


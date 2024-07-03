Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E7BC30653
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 17:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58BDB10E98E;
	Wed,  3 Jul 2024 17:49:17 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450AA10E990
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 17:49:16 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 463HnAna2610387; Wed, 3 Jul 2024 23:19:10 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 463HnAbl2610380;
 Wed, 3 Jul 2024 23:19:10 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/2] drm:amdgpu: enable IH ring1 for IH v7.0
Date: Wed,  3 Jul 2024 23:19:07 +0530
Message-Id: <20240703174908.2610353-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We need IH ring1 for handling the pagefault
interrupts which over flow in default
ring for specific usecases.

Enable ring1 allows software to redirect
high interrupts to ring1 from default IH
ring.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index aa6235dd4f2b..548b3c63a765 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -546,8 +546,15 @@ static int ih_v7_0_sw_init(void *handle)
 	adev->irq.ih.use_doorbell = true;
 	adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
 
-	adev->irq.ih1.ring_size = 0;
-	adev->irq.ih2.ring_size = 0;
+	if (!(adev->flags & AMD_IS_APU)) {
+		r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, IH_RING_SIZE,
+					use_bus_addr);
+		if (r)
+			return r;
+
+		adev->irq.ih1.use_doorbell = true;
+		adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
+	}
 
 	/* initialize ih control register offset */
 	ih_v7_0_init_register_offset(adev);
-- 
2.34.1


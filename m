Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC391C04FFF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 13:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F57D10F0B0;
	Tue, 16 Apr 2024 13:34:38 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CE110F0A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 13:34:36 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 43GDYQjG003391; Tue, 16 Apr 2024 19:04:26 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 43GDYQZE003390;
 Tue, 16 Apr 2024 19:04:26 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 2/5] drm:amdgpu: Enable IH ring1 for IH v6.1
Date: Tue, 16 Apr 2024 19:04:20 +0530
Message-Id: <20240416133423.3346-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416133423.3346-1-sunil.khatri@amd.com>
References: <20240416133423.3346-1-sunil.khatri@amd.com>
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

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index b8da0fc29378..73dba180fabd 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -550,8 +550,15 @@ static int ih_v6_1_sw_init(void *handle)
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
 	ih_v6_1_init_register_offset(adev);
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C031EC04FF9
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 13:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF33F10F63C;
	Fri, 12 Apr 2024 13:17:19 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753AF10F639
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 13:17:15 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 43CDHAeY036195; Fri, 12 Apr 2024 18:47:10 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 43CDHAev036194;
 Fri, 12 Apr 2024 18:47:10 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu: Enable redirection of irq's for IH V6.1
Date: Fri, 12 Apr 2024 18:46:45 +0530
Message-Id: <20240412131645.35990-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412131645.35990-1-sunil.khatri@amd.com>
References: <20240412131645.35990-1-sunil.khatri@amd.com>
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

Enable redirection of irq for pagefaults for specific
clients to avoid overflow without dropping interrupts.

So here we redirect the interrupts to another IH ring
i.e ring1 where only these interrupts are processed.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index d3ce1b809550..b31c3fe0d90d 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -346,6 +346,20 @@ static int ih_v6_1_irq_init(struct amdgpu_device *adev)
 			    DELAY, 3);
 	WREG32_SOC15(OSSSYS, 0, regIH_MSI_STORM_CTRL, tmp);
 
+	/*
+	 * Redirect the interrupts to IH RB1
+	 */
+	tmp = RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX);
+	tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_INDEX, INDEX, 0);
+	WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX, tmp);
+
+	tmp = RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA);
+	tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, CLIENT_ID, 0xa);
+	tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, SOURCE_ID, 0x0);
+	tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA,
+			    SOURCE_ID_MATCH_ENABLE, 0x1);
+	WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA, tmp);
+
 	pci_set_master(adev->pdev);
 
 	/* enable interrupts */
-- 
2.34.1


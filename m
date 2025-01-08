Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18C6C02183
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EAC10EBCC;
	Wed,  8 Jan 2025 14:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GeyiVRXH";
	dkim-atps=neutral
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D396310E8B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344817; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=a18FZXrpSo939y8wREpsZgvJuFbiokGXqQoBd7KuEDk=;
 b=GeyiVRXHsVo8OIKQiQXpWEYfda04/ro3MQ0oVBCmmxnyzDauYyM+gDgwcO7w+wdhKMlUOc6QKnbPuLOQ3as8GPC87+4jagFmwWBMra+/zZ2HdNyabymxFWXQmWfTc4dUIEcpF+8jMP8zA3TzzQc1rFsTNrAtjoT1JWMn8zR6gvE=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXFv_1736344815 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:16 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 13/13] drm/amdgpu/asic: make ip block operations symmetric
 by .early_fini()
Date: Wed,  8 Jan 2025 22:00:05 +0800
Message-ID: <7aca2e843624283534f3ba784276a968bd84616a.1736344725.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736344725.git.gerry@linux.alibaba.com>
References: <cover.1736344725.git.gerry@linux.alibaba.com>
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

Make ip block operations for asic symmetric by making using of the
.early_fini() hook, which will undo work done by the .late_init() hook.
1) introduce xxx_common_early_fini() for nv/soc15/soc21/soc24.
2) move `enable_doorbell_selfring_aperture(adev, false)` from .hw_init()
   into .early_fini().
3) call xgpu_nv_mailbox_put_irq() for nv.c to avoid possible resource
   leakage.
4) use flags to track irq reference count usage.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 14 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc15.c | 22 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/soc21.c | 35 ++++++++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/soc24.c | 17 +++++++++++----
 4 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 4e8f9af1e2be..f87b9c835774 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -973,6 +973,18 @@ static int nv_common_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int nv_common_early_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
+
+	if (amdgpu_sriov_vf(adev))
+		xgpu_nv_mailbox_put_irq(adev);
+
+	return 0;
+}
+
 static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1024,7 +1036,6 @@ static int nv_common_hw_fini(struct amdgpu_ip_block *ip_block)
 	 * selfring doorbell.
 	 */
 	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 
 	return 0;
 }
@@ -1110,6 +1121,7 @@ static const struct amd_ip_funcs nv_common_ip_funcs = {
 	.name = "nv_common",
 	.early_init = nv_common_early_init,
 	.late_init = nv_common_late_init,
+	.early_fini = nv_common_early_fini,
 	.sw_init = nv_common_sw_init,
 	.sw_fini = nv_common_sw_fini,
 	.hw_init = nv_common_hw_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 1dca7d7c813c..e084430f8998 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1217,6 +1217,18 @@ static int soc15_common_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int soc15_common_early_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
+
+	if (amdgpu_sriov_vf(adev))
+		xgpu_ai_mailbox_put_irq(adev);
+
+	return 0;
+}
+
 static int soc15_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1288,16 +1300,7 @@ static int soc15_common_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	/* Disable the doorbell aperture and selfring doorbell aperture
-	 * separately in hw_fini because soc15_enable_doorbell_aperture
-	 * has been removed and there is no need to delay disabling
-	 * selfring doorbell.
-	 */
 	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
-
-	if (amdgpu_sriov_vf(adev))
-		xgpu_ai_mailbox_put_irq(adev);
 
 	return 0;
 }
@@ -1476,6 +1479,7 @@ static const struct amd_ip_funcs soc15_common_ip_funcs = {
 	.name = "soc15_common",
 	.early_init = soc15_common_early_init,
 	.late_init = soc15_common_late_init,
+	.early_fini = soc15_common_early_fini,
 	.sw_init = soc15_common_sw_init,
 	.sw_fini = soc15_common_sw_fini,
 	.hw_init = soc15_common_hw_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 03b9bcb8eb6d..5a6da83c938a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -796,6 +796,7 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 
 static int soc21_common_late_init(struct amdgpu_ip_block *ip_block)
 {
+	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -816,12 +817,16 @@ static int soc21_common_late_init(struct amdgpu_ip_block *ip_block)
 		}
 	} else {
 		if (adev->nbio.ras &&
-		    adev->nbio.ras_err_event_athub_irq.funcs)
+		    adev->nbio.ras_err_event_athub_irq.funcs) {
 			/* don't need to fail gpu late init
 			 * if enabling athub_err_event interrupt failed
 			 * nbio v4_3 only support fatal error hanlding
 			 * just enable the interrupt directly */
-			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
+			r = amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
+			if (r)
+				return r;
+			amdgpu_ip_block_set_marker(ip_block, AMDGPU_MARKER_IRQ0);
+		}
 	}
 
 	/* Enable selfring doorbell aperture late because doorbell BAR
@@ -832,6 +837,22 @@ static int soc21_common_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int soc21_common_early_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
+
+	if (amdgpu_sriov_vf(adev)) {
+		xgpu_nv_mailbox_put_irq(adev);
+	} else {
+		if (amdgpu_ip_block_test_and_clear_marker(ip_block, AMDGPU_MARKER_IRQ0))
+			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
+	}
+
+	return 0;
+}
+
 static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -877,15 +898,6 @@ static int soc21_common_hw_fini(struct amdgpu_ip_block *ip_block)
 	 * selfring doorbell.
 	 */
 	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
-
-	if (amdgpu_sriov_vf(adev)) {
-		xgpu_nv_mailbox_put_irq(adev);
-	} else {
-		if (adev->nbio.ras &&
-		    adev->nbio.ras_err_event_athub_irq.funcs)
-			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
-	}
 
 	return 0;
 }
@@ -1000,6 +1012,7 @@ static const struct amd_ip_funcs soc21_common_ip_funcs = {
 	.name = "soc21_common",
 	.early_init = soc21_common_early_init,
 	.late_init = soc21_common_late_init,
+	.early_fini = soc21_common_early_fini,
 	.sw_init = soc21_common_sw_init,
 	.sw_fini = soc21_common_sw_fini,
 	.hw_init = soc21_common_hw_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index b20dc81dc257..5a4a04834ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -455,6 +455,18 @@ static int soc24_common_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int soc24_common_early_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
+
+	if (amdgpu_sriov_vf(adev))
+		xgpu_nv_mailbox_put_irq(adev);
+
+	return 0;
+}
+
 static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -504,10 +516,6 @@ static int soc24_common_hw_fini(struct amdgpu_ip_block *ip_block)
 	 * selfring doorbell.
 	 */
 	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
-
-	if (amdgpu_sriov_vf(adev))
-		xgpu_nv_mailbox_put_irq(adev);
 
 	return 0;
 }
@@ -590,6 +598,7 @@ static const struct amd_ip_funcs soc24_common_ip_funcs = {
 	.name = "soc24_common",
 	.early_init = soc24_common_early_init,
 	.late_init = soc24_common_late_init,
+	.early_fini = soc24_common_early_fini,
 	.sw_init = soc24_common_sw_init,
 	.sw_fini = soc24_common_sw_fini,
 	.hw_init = soc24_common_hw_init,
-- 
2.43.5


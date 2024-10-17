Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6582D2126D
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 10:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BCC810E7DF;
	Thu, 17 Oct 2024 10:06:33 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960C410E7D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 10:06:24 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49HA6Ion1492228; Thu, 17 Oct 2024 15:36:18 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49HA6IZX1492227;
 Thu, 17 Oct 2024 15:36:18 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 11/15] drm/amdgpu: clean the dummy hw_fini functions
Date: Thu, 17 Oct 2024 15:36:11 +0530
Message-Id: <20241017100615.1492144-12-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017100615.1492144-1-sunil.khatri@amd.com>
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
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

Remove the dummy hw_fini functions for all
ip blocks.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c |  6 ------
 drivers/gpu/drm/amd/amdgpu/cik.c         |  6 ------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 11 +----------
 drivers/gpu/drm/amd/amdgpu/si.c          |  6 ------
 4 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index ed8015313827..e3a399bfab61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -600,11 +600,6 @@ static int amdgpu_vkms_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int amdgpu_vkms_hw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -661,7 +656,6 @@ static const struct amd_ip_funcs amdgpu_vkms_ip_funcs = {
 	.sw_init = amdgpu_vkms_sw_init,
 	.sw_fini = amdgpu_vkms_sw_fini,
 	.hw_init = amdgpu_vkms_hw_init,
-	.hw_fini = amdgpu_vkms_hw_fini,
 	.suspend = amdgpu_vkms_suspend,
 	.resume = amdgpu_vkms_resume,
 	.is_idle = amdgpu_vkms_is_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index c8fb592f13df..9cb25d0d1051 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2138,11 +2138,6 @@ static int cik_common_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cik_common_hw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int cik_common_resume(struct amdgpu_ip_block *ip_block)
 {
 	return cik_common_hw_init(ip_block);
@@ -2181,7 +2176,6 @@ static const struct amd_ip_funcs cik_common_ip_funcs = {
 	.early_init = cik_common_early_init,
 	.late_init = NULL,
 	.hw_init = cik_common_hw_init,
-	.hw_fini = cik_common_hw_fini,
 	.resume = cik_common_resume,
 	.is_idle = cik_common_is_idle,
 	.wait_for_idle = cik_common_wait_for_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 9d0e342a2f81..a1af5c90f79a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -40,7 +40,6 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_uni_mes.bin");
 
 static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block);
-static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block);
 static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev);
 static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
 
@@ -1516,7 +1515,6 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 	return r;
 
 failure:
-	mes_v12_0_hw_fini(ip_block);
 	return r;
 }
 
@@ -1600,15 +1598,9 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 failure:
-	mes_v12_0_hw_fini(ip_block);
 	return r;
 }
 
-static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int mes_v12_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
@@ -1617,7 +1609,7 @@ static int mes_v12_0_suspend(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	return mes_v12_0_hw_fini(ip_block);
+	return 0;
 }
 
 static int mes_v12_0_resume(struct amdgpu_ip_block *ip_block)
@@ -1663,7 +1655,6 @@ static const struct amd_ip_funcs mes_v12_0_ip_funcs = {
 	.sw_init = mes_v12_0_sw_init,
 	.sw_fini = mes_v12_0_sw_fini,
 	.hw_init = mes_v12_0_hw_init,
-	.hw_fini = mes_v12_0_hw_fini,
 	.suspend = mes_v12_0_suspend,
 	.resume = mes_v12_0_resume,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 66ccb76eb72a..e1b3bef6992a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2634,11 +2634,6 @@ static int si_common_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_common_hw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int si_common_resume(struct amdgpu_ip_block *ip_block)
 {
 	return si_common_hw_init(ip_block);
@@ -2676,7 +2671,6 @@ static const struct amd_ip_funcs si_common_ip_funcs = {
 	.early_init = si_common_early_init,
 	.late_init = NULL,
 	.hw_init = si_common_hw_init,
-	.hw_fini = si_common_hw_fini,
 	.resume = si_common_resume,
 	.is_idle = si_common_is_idle,
 	.wait_for_idle = si_common_wait_for_idle,
-- 
2.34.1


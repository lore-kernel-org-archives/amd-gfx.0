Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7538CEDD9B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 14:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FEF910E740;
	Wed,  9 Oct 2024 14:25:19 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33BE010E742
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 14:25:17 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 499EPBDn891932; Wed, 9 Oct 2024 19:55:11 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 499EPBvw891931;
 Wed, 9 Oct 2024 19:55:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 04/13] drm/amdgpu: clean the dummy sw_fini functions
Date: Wed,  9 Oct 2024 19:54:53 +0530
Message-Id: <20241009142502.891864-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009142502.891864-1-sunil.khatri@amd.com>
References: <20241009142502.891864-1-sunil.khatri@amd.com>
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

Remove the dummy sw_fini functions for all
ip blocks.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 6 ------
 drivers/gpu/drm/amd/amdgpu/cik.c        | 6 ------
 drivers/gpu/drm/amd/amdgpu/nv.c         | 6 ------
 drivers/gpu/drm/amd/amdgpu/si.c         | 7 -------
 drivers/gpu/drm/amd/amdgpu/soc21.c      | 6 ------
 drivers/gpu/drm/amd/amdgpu/soc24.c      | 6 ------
 drivers/gpu/drm/amd/amdgpu/vi.c         | 6 ------
 7 files changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index c75bc32ca7ef..9b98b40ac4db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -33,11 +33,6 @@
 #include "isp_v4_1_0.h"
 #include "isp_v4_1_1.h"
 
-static int isp_sw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 /**
  * isp_hw_init - start and test isp block
  *
@@ -169,7 +164,6 @@ static const struct amd_ip_funcs isp_ip_funcs = {
 	.name = "isp_ip",
 	.early_init = isp_early_init,
 	.late_init = NULL,
-	.sw_fini = isp_sw_fini,
 	.hw_init = isp_hw_init,
 	.hw_fini = isp_hw_fini,
 	.suspend = isp_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index a374d1bb24ab..f3f6b32d4e2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2124,11 +2124,6 @@ static int cik_common_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cik_common_sw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int cik_common_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2190,7 +2185,6 @@ static const struct amd_ip_funcs cik_common_ip_funcs = {
 	.name = "cik_common",
 	.early_init = cik_common_early_init,
 	.late_init = NULL,
-	.sw_fini = cik_common_sw_fini,
 	.hw_init = cik_common_hw_init,
 	.hw_fini = cik_common_hw_fini,
 	.suspend = cik_common_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 4e8f9af1e2be..95c6461aab6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -983,11 +983,6 @@ static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int nv_common_sw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1111,7 +1106,6 @@ static const struct amd_ip_funcs nv_common_ip_funcs = {
 	.early_init = nv_common_early_init,
 	.late_init = nv_common_late_init,
 	.sw_init = nv_common_sw_init,
-	.sw_fini = nv_common_sw_fini,
 	.hw_init = nv_common_hw_init,
 	.hw_fini = nv_common_hw_fini,
 	.suspend = nv_common_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 3714c6d77f30..f0817d5fbea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2148,12 +2148,6 @@ static int si_common_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_common_sw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
-
 static void si_init_golden_registers(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
@@ -2686,7 +2680,6 @@ static const struct amd_ip_funcs si_common_ip_funcs = {
 	.name = "si_common",
 	.early_init = si_common_early_init,
 	.late_init = NULL,
-	.sw_fini = si_common_sw_fini,
 	.hw_init = si_common_hw_init,
 	.hw_fini = si_common_hw_fini,
 	.suspend = si_common_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index c4b950e75133..cdcc5c09a6b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -842,11 +842,6 @@ static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int soc21_common_sw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1000,7 +995,6 @@ static const struct amd_ip_funcs soc21_common_ip_funcs = {
 	.early_init = soc21_common_early_init,
 	.late_init = soc21_common_late_init,
 	.sw_init = soc21_common_sw_init,
-	.sw_fini = soc21_common_sw_fini,
 	.hw_init = soc21_common_hw_init,
 	.hw_fini = soc21_common_hw_fini,
 	.suspend = soc21_common_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index b20dc81dc257..34ed064a6a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -465,11 +465,6 @@ static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int soc24_common_sw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -591,7 +586,6 @@ static const struct amd_ip_funcs soc24_common_ip_funcs = {
 	.early_init = soc24_common_early_init,
 	.late_init = soc24_common_late_init,
 	.sw_init = soc24_common_sw_init,
-	.sw_fini = soc24_common_sw_fini,
 	.hw_init = soc24_common_hw_init,
 	.hw_fini = soc24_common_hw_fini,
 	.suspend = soc24_common_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 4996049dc199..7a19b4f5b09f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1699,11 +1699,6 @@ static int vi_common_sw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int vi_common_sw_fini(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int vi_common_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2043,7 +2038,6 @@ static const struct amd_ip_funcs vi_common_ip_funcs = {
 	.early_init = vi_common_early_init,
 	.late_init = vi_common_late_init,
 	.sw_init = vi_common_sw_init,
-	.sw_fini = vi_common_sw_fini,
 	.hw_init = vi_common_hw_init,
 	.hw_fini = vi_common_hw_fini,
 	.suspend = vi_common_suspend,
-- 
2.34.1


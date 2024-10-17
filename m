Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106A0D21275
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 10:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6042710E7DB;
	Thu, 17 Oct 2024 10:06:25 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A6CB10E7DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 10:06:23 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49HA6IfO1492183; Thu, 17 Oct 2024 15:36:18 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49HA6IWU1492182;
 Thu, 17 Oct 2024 15:36:18 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 02/15] drm/amdgpu: clean the dummy sw_init functions
Date: Thu, 17 Oct 2024 15:36:02 +0530
Message-Id: <20241017100615.1492144-3-sunil.khatri@amd.com>
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

Remove the dummy sw_init functions for all
IP blocks.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 6 ------
 drivers/gpu/drm/amd/amdgpu/cik.c        | 6 ------
 drivers/gpu/drm/amd/amdgpu/si.c         | 6 ------
 3 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index adc0b80ca5db..c75bc32ca7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -33,11 +33,6 @@
 #include "isp_v4_1_0.h"
 #include "isp_v4_1_1.h"
 
-static int isp_sw_init(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int isp_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
@@ -174,7 +169,6 @@ static const struct amd_ip_funcs isp_ip_funcs = {
 	.name = "isp_ip",
 	.early_init = isp_early_init,
 	.late_init = NULL,
-	.sw_init = isp_sw_init,
 	.sw_fini = isp_sw_fini,
 	.hw_init = isp_hw_init,
 	.hw_fini = isp_hw_fini,
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 6c18ab35cf69..a374d1bb24ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2124,11 +2124,6 @@ static int cik_common_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cik_common_sw_init(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int cik_common_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
@@ -2195,7 +2190,6 @@ static const struct amd_ip_funcs cik_common_ip_funcs = {
 	.name = "cik_common",
 	.early_init = cik_common_early_init,
 	.late_init = NULL,
-	.sw_init = cik_common_sw_init,
 	.sw_fini = cik_common_sw_fini,
 	.hw_init = cik_common_hw_init,
 	.hw_fini = cik_common_hw_fini,
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index b9934661a92e..3714c6d77f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2148,11 +2148,6 @@ static int si_common_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_common_sw_init(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int si_common_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
@@ -2691,7 +2686,6 @@ static const struct amd_ip_funcs si_common_ip_funcs = {
 	.name = "si_common",
 	.early_init = si_common_early_init,
 	.late_init = NULL,
-	.sw_init = si_common_sw_init,
 	.sw_fini = si_common_sw_fini,
 	.hw_init = si_common_hw_init,
 	.hw_fini = si_common_hw_fini,
-- 
2.34.1


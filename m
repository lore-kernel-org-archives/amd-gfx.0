Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246D3CED635
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 09:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD60010E6B0;
	Wed,  9 Oct 2024 09:20:10 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D60C10E6AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 09:20:08 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4999K459834074; Wed, 9 Oct 2024 14:50:04 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4999K4dR834073;
 Wed, 9 Oct 2024 14:50:04 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [V2 2/2] drm/admgpu: clean the dummy sw_init functions
Date: Wed,  9 Oct 2024 14:50:00 +0530
Message-Id: <20241009092000.834054-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009092000.834054-1-sunil.khatri@amd.com>
References: <20241009092000.834054-1-sunil.khatri@amd.com>
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

Remove the dummy sw_init functions and set the
corresponding functions to NULL.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/cik.c        | 7 +------
 drivers/gpu/drm/amd/amdgpu/si.c         | 7 +------
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index adc0b80ca5db..4add6c412779 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 6c18ab35cf69..bb961b274487 100644
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
@@ -2195,7 +2190,7 @@ static const struct amd_ip_funcs cik_common_ip_funcs = {
 	.name = "cik_common",
 	.early_init = cik_common_early_init,
 	.late_init = NULL,
-	.sw_init = cik_common_sw_init,
+	.sw_init = NULL,
 	.sw_fini = cik_common_sw_fini,
 	.hw_init = cik_common_hw_init,
 	.hw_fini = cik_common_hw_fini,
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index b9934661a92e..0578c7ce4dc5 100644
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
@@ -2691,7 +2686,7 @@ static const struct amd_ip_funcs si_common_ip_funcs = {
 	.name = "si_common",
 	.early_init = si_common_early_init,
 	.late_init = NULL,
-	.sw_init = si_common_sw_init,
+	.sw_init = NULL,
 	.sw_fini = si_common_sw_fini,
 	.hw_init = si_common_hw_init,
 	.hw_fini = si_common_hw_fini,
-- 
2.34.1


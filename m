Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662F0C27C44
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 09:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E8D113596;
	Wed, 29 May 2024 09:50:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1240E1135AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 09:50:42 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 44T9oaGV1669937; Wed, 29 May 2024 15:20:36 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 44T9oakY1669936;
 Wed, 29 May 2024 15:20:36 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 2/3] drm/amdgpu: add print support for gfx9 ipdump
Date: Wed, 29 May 2024 15:20:31 +0530
Message-Id: <20240529095032.1669886-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529095032.1669886-1-sunil.khatri@amd.com>
References: <20240529095032.1669886-1-sunil.khatri@amd.com>
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

Add support of gfx9 ipdump print so devcoredump
could trigger it to dump the captured registers
in devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 528a20393313..f3d281de2a34 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6946,6 +6946,22 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static void gfx_v9_ip_print(void *handle, struct drm_printer *p)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t i;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9);
+
+	if (!adev->gfx.ip_dump_core)
+		return;
+
+	for (i = 0; i < reg_count; i++)
+		drm_printf(p, "%-50s \t 0x%08x\n",
+			   gc_reg_list_9[i].reg_name,
+			   adev->gfx.ip_dump_core[i]);
+
+}
+
 static void gfx_v9_ip_dump(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -6979,7 +6995,7 @@ static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.set_powergating_state = gfx_v9_0_set_powergating_state,
 	.get_clockgating_state = gfx_v9_0_get_clockgating_state,
 	.dump_ip_state = gfx_v9_ip_dump,
-	.print_ip_state = NULL,
+	.print_ip_state = gfx_v9_ip_print,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
-- 
2.34.1


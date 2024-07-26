Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E9CC3DA7F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 12:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 854D210E978;
	Fri, 26 Jul 2024 12:48:05 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C279F10E1EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 12:48:04 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46QCls9N3121346; Fri, 26 Jul 2024 18:17:54 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46QCls2F3121339;
 Fri, 26 Jul 2024 18:17:54 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: print VCN instance dump for valid instance
Date: Fri, 26 Jul 2024 18:17:50 +0530
Message-Id: <20240726124751.3121312-1-sunil.khatri@amd.com>
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

VCN dump is dependent on power state of the ip. Dump is
valid if VCN was powered up at the time of ip dump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 28 +++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9e1cbeee10db..c2278cc49dd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2329,7 +2329,7 @@ static void vcn_v3_0_print_ip_state(void *handle, struct drm_printer *p)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
-	uint32_t inst_off;
+	uint32_t inst_off, is_powered;
 
 	if (!adev->vcn.ip_dump)
 		return;
@@ -2342,11 +2342,17 @@ static void vcn_v3_0_print_ip_state(void *handle, struct drm_printer *p)
 		}
 
 		inst_off = i * reg_count;
-		drm_printf(p, "\nActive Instance:VCN%d\n", i);
+		is_powered = (adev->vcn.ip_dump[inst_off] &
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		for (j = 0; j < reg_count; j++)
-			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_3_0[j].reg_name,
-				   adev->vcn.ip_dump[inst_off + j]);
+		if (is_powered) {
+			drm_printf(p, "\nActive Instance:VCN%d\n", i);
+			for (j = 0; j < reg_count; j++)
+				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_3_0[j].reg_name,
+					   adev->vcn.ip_dump[inst_off + j]);
+		} else {
+			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
+		}
 	}
 }
 
@@ -2354,7 +2360,7 @@ static void vcn_v3_0_dump_ip_state(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i, j;
-	bool reg_safe;
+	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 
@@ -2366,11 +2372,13 @@ static void vcn_v3_0_dump_ip_state(void *handle)
 			continue;
 
 		inst_off = i * reg_count;
-		reg_safe = (RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS) &
-			    UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
+		is_powered = (adev->vcn.ip_dump[inst_off] &
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (reg_safe)
-			for (j = 0; j < reg_count; j++)
+		if (is_powered)
+			for (j = 1; j < reg_count; j++)
 				adev->vcn.ip_dump[inst_off + j] =
 					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], i));
 	}
-- 
2.34.1


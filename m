Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D83C52D7B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 11:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C33E10E305;
	Tue, 13 Aug 2024 11:30:48 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9F810E2FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 11:30:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 47DBUbU0768879; Tue, 13 Aug 2024 17:00:37 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 47DBUb7n768878;
 Tue, 13 Aug 2024 17:00:37 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
 Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 05/18] drm/amdgpu: add print support for vcn_v5_0 ip dump
Date: Tue, 13 Aug 2024 17:00:21 +0530
Message-Id: <20240813113034.768804-6-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813113034.768804-1-sunil.khatri@amd.com>
References: <20240813113034.768804-1-sunil.khatri@amd.com>
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

Add support for logging the registers in devcoredump
buffer for vcn_v5_0.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 34 ++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a30a42b1ba03..c305386358b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1343,6 +1343,38 @@ static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static void vcn_v5_0_print_ip_state(void *handle, struct drm_printer *p)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, j;
+	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
+	uint32_t inst_off, is_powered;
+
+	if (!adev->vcn.ip_dump)
+		return;
+
+	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i)) {
+			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
+			continue;
+		}
+
+		inst_off = i * reg_count;
+		is_powered = (adev->vcn.ip_dump[inst_off] &
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+		if (is_powered) {
+			drm_printf(p, "\nActive Instance:VCN%d\n", i);
+			for (j = 0; j < reg_count; j++)
+				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_5_0[j].reg_name,
+					   adev->vcn.ip_dump[inst_off + j]);
+		} else {
+			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
+		}
+	}
+}
+
 static void vcn_v5_0_dump_ip_state(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1390,7 +1422,7 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.set_clockgating_state = vcn_v5_0_0_set_clockgating_state,
 	.set_powergating_state = vcn_v5_0_0_set_powergating_state,
 	.dump_ip_state = vcn_v5_0_dump_ip_state,
-	.print_ip_state = NULL,
+	.print_ip_state = vcn_v5_0_print_ip_state,
 };
 
 const struct amdgpu_ip_block_version vcn_v5_0_0_ip_block = {
-- 
2.34.1


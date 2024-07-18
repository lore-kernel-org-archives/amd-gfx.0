Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA0EC3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 04:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74B210E4F3;
	Thu, 18 Jul 2024 04:43:02 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDEF10E4F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 04:42:59 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46I4gsgw1822105; Thu, 18 Jul 2024 10:12:54 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46I4gsJp1822104;
 Thu, 18 Jul 2024 10:12:54 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 2/6] drm/amdgpu: add print support for sdma_v_7_0 ip_dump
Date: Thu, 18 Jul 2024 10:12:46 +0530
Message-Id: <20240718044250.1822051-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718044250.1822051-1-sunil.khatri@amd.com>
References: <20240718044250.1822051-1-sunil.khatri@amd.com>
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

Add print support for ip dump for sdma_v_7_0 in
devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 327b5387949a..62ef4a737a56 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1535,6 +1535,27 @@ static void sdma_v7_0_get_clockgating_state(void *handle, u64 *flags)
 {
 }
 
+static void sdma_v7_0_print_ip_state(void *handle, struct drm_printer *p)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, j;
+	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_7_0);
+	uint32_t instance_offset;
+
+	if (!adev->sdma.ip_dump)
+		return;
+
+	drm_printf(p, "num_instances:%d\n", adev->sdma.num_instances);
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		instance_offset = i * reg_count;
+		drm_printf(p, "\nInstance:%d\n", i);
+
+		for (j = 0; j < reg_count; j++)
+			drm_printf(p, "%-50s \t 0x%08x\n", sdma_reg_list_7_0[j].reg_name,
+				   adev->sdma.ip_dump[instance_offset + j]);
+	}
+}
+
 static void sdma_v7_0_dump_ip_state(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1574,6 +1595,7 @@ const struct amd_ip_funcs sdma_v7_0_ip_funcs = {
 	.set_powergating_state = sdma_v7_0_set_powergating_state,
 	.get_clockgating_state = sdma_v7_0_get_clockgating_state,
 	.dump_ip_state = sdma_v7_0_dump_ip_state,
+	.print_ip_state = sdma_v7_0_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs sdma_v7_0_ring_funcs = {
-- 
2.34.1


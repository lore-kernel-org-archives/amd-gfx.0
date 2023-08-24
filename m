Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E064C7EE43
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF5810E5E4;
	Thu, 24 Aug 2023 21:58:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5B710E5DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmnuQwco8d4xeFB9csszHp9eBCH8Wyp2Apxciimi6xhqdO4ZiqjncLKsTlZEW8cOIpkx7Tiud6Z7cZHjj/Ihui3W4rd51vGXU0NewRcPFBM9bX1VtONdgqeLawgk9VWlJoTMFE8SrVNSJZY2GLIqxH94YkYxD2V2iaotgYNBj1ZyL8Jg9cQyi22+qJHj98u6rMIvIENXwK7Ca6sliQXdMZYn/anm5rqZ5VP++IoFC8WfdIlCsMi2/prGl+wWD9UP1erzNPIHcFqtOqRcY3Ck3qxs3UrPDsfWFo5Tj29vtD2MMsqNyGHLUg0WsbQ1IddwUm7o1iO8joKox8B+Y+XaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE30/aO08N80Y4Nbesruzet47Y7d0CV1LqAYi52bhs0=;
 b=I2OnI/cxxOsyUikptPdFUeguK668Wlb3ecQyFPDSSulecH7sMRzH75LPYxwPFtwMyQCxc9mM2uxr27JqrFqssMA/RuTiZPrcG17lAMHu4WEZ7y6ywhD35AZ298cho9aNqsF/TvQwETOJNjIFGssKGACbuXMv53j6TQd/1qXntnGms2LB/MV92WROGzEdzh2J3YN+2YEasho9J/GdmHLMG0gJriwDQT79PY93u+htQYTdk3czZr8/yX10OuR8Iag4orYL8RJy1iAx13mjlaU/qNgkFgmTHM0DaI4jixkQ6lcxaqH2HMPkHrhhYI7DxGOHOodFJIzgWiaGC+F+XTfubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE30/aO08N80Y4Nbesruzet47Y7d0CV1LqAYi52bhs0=;
 b=D2YNZ7NtVcAzPEliNPfG0G2rglyrSRBidAz2cR9DeIQcg06BaOGny8oLnvqWiAojc82YmoyKjGDkUXzHOpXl/nvp1+pU0UUqHOYxYGJ9ywg4+5eEgsI5WBBPEwoVmqJgYxrRRB6YKISik9aTn0922gc+/soF5H2mPZF6zlITcow=
Received: from DS0PR17CA0012.namprd17.prod.outlook.com (2603:10b6:8:191::20)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 21:58:53 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::a9) by DS0PR17CA0012.outlook.office365.com
 (2603:10b6:8:191::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amdgpu: add initial support for UMSCH
Date: Thu, 24 Aug 2023 17:58:27 -0400
Message-ID: <20230824215835.2740115-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 65853c2f-2068-4a3e-026e-08dba4ed4e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKBrowB2ZLU0DMA3tQkXR3Ku9AKa4h54F+Nw+DorwszO9As+prnXWdBJcE9979HZ8p0XgqKaBNdbmjtyxc14iKXsUORf/oE4dMyqbJN5Yfe60oEBp3CM6cFC8NaIqxonrc2dacu/CBPCnhbkkk2tm4TyPMbidJGB8RAj/yEO7epPzFtgHkO9VjzlKfxzt3d1tc7yD8mGjT//BmJB9vLWO3+KXxENH5Bq9XoQerhvHkfmULWZ68H9jP1Awv/6VuA5WHwkvr6aOM2ggJb64cgwRJdnGm50B//7qjSFHD0lN5oK31ejA6LdkFeZ//oGc1rxhh0Dq649+EJYD5VKYpvFAckNf8wKjodD8nLc4tR8bnzPWzvl1eiZfV8ccuMGCn1hCJz6rqtysNLL20IvZ7iqDLF8oafC26E+A3xoJXj3/jHHkP7+Dq/NJfRVVKmY/LyRM93j6eY5J+kvyDP7CuFJn5Bf39bHGyzfvAHjSCf0fDSqGtwI+7A/HitpSaHElU9oNGMVn0WgQqz2DPQGtR7qcUcSc6zvFNGdJipXfje0OPZPlOR0DVJsPgsH1ZTPYf5TlMB02E011dMQhFTQhUS4jgqaa6EA4bzJPumJANejUoJnrh5WEuDJWQrJkwcD0km3o7FJligCTuesVjXxKIKbcpo0XgkeU3KmXWlOAPvogCph4mddHkVpXUTEBRXbRJCBjAxwMa4gaBxW+zyQlkhDOYwXBMSX/3mszTjP8oV4RNlW7WDtR5yeve3Gvg6gxCFhudFxr0YTKq5BWbH8XmFPdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(6916009)(316002)(70586007)(70206006)(66899024)(8676002)(8936002)(4326008)(2616005)(36756003)(41300700001)(1076003)(40460700003)(81166007)(82740400003)(356005)(478600001)(6666004)(5660300002)(40480700001)(83380400001)(30864003)(2906002)(36860700001)(47076005)(7696005)(86362001)(336012)(426003)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:53.0492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65853c2f-2068-4a3e-026e-08dba4ed4e57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add basic data structure, dummy ring functions
and ip functions for UMSCH.

Implement sw_init(ring_init and init_microcodede) and
hw_init(load_microcode), UMSCH can boot up now.

Implement hw_init(ring_start) and hw_fini(ring_stop),
UMSCH is ready for command submission now.

Implement set_hw_resources and add/remove_queue,
UMSCH is ready for scheduling now.

Aggregated doorbell is used to notify UMSCH FW that
there is unmapped queue with corresponding priority level
(e.g., AGDB[0] for Real time band, etc.) is updating its job.

v2: squash together initial patches to avoid breaking the
    build (Alex)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 361 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h | 210 ++++++++++
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c   | 385 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.h   |  30 ++
 6 files changed, 996 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 97bce96e0e50..6fb121d1084e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -221,6 +221,11 @@ amdgpu-y += \
 	amdgpu_vpe.o \
 	vpe_v6_1.o
 
+# add UMSCH block
+amdgpu-y += \
+	amdgpu_umsch_mm.o \
+	umsch_mm_v4_0.o
+
 #
 # add ATHUB block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1b83a419f680..17dd20bc6910 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -81,6 +81,7 @@
 #include "amdgpu_vcn.h"
 #include "amdgpu_jpeg.h"
 #include "amdgpu_vpe.h"
+#include "amdgpu_umsch_mm.h"
 #include "amdgpu_gmc.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_sdma.h"
@@ -952,6 +953,10 @@ struct amdgpu_device {
 	/* vpe */
 	struct amdgpu_vpe		vpe;
 
+	/* umsch */
+	struct amdgpu_umsch_mm		umsch_mm;
+	bool				enable_umsch_mm;
+
 	/* firmwares */
 	struct amdgpu_firmware		firmware;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
new file mode 100644
index 000000000000..a8a35547e883
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/firmware.h>
+
+#include "amdgpu.h"
+#include "amdgpu_umsch_mm.h"
+#include "umsch_mm_v4_0.h"
+
+int amdgpu_umsch_mm_submit_pkt(struct amdgpu_umsch_mm *umsch, void *pkt, int ndws)
+{
+	struct amdgpu_ring *ring = &umsch->ring;
+
+	if (amdgpu_ring_alloc(ring, ndws))
+		return -ENOMEM;
+
+	amdgpu_ring_write_multiple(ring, pkt, ndws);
+	amdgpu_ring_commit(ring);
+
+	return 0;
+}
+
+int amdgpu_umsch_mm_query_fence(struct amdgpu_umsch_mm *umsch)
+{
+	struct amdgpu_ring *ring = &umsch->ring;
+	struct amdgpu_device *adev = ring->adev;
+	int r;
+
+	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, adev->usec_timeout);
+	if (r < 1) {
+		dev_err(adev->dev, "ring umsch timeout, emitted fence %u\n",
+			ring->fence_drv.sync_seq);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void umsch_mm_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_umsch_mm *umsch = (struct amdgpu_umsch_mm *)ring;
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell)
+		WDOORBELL32(ring->doorbell_index, ring->wptr << 2);
+	else
+		WREG32(umsch->rb_wptr, ring->wptr << 2);
+}
+
+static u64 umsch_mm_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_umsch_mm *umsch = (struct amdgpu_umsch_mm *)ring;
+	struct amdgpu_device *adev = ring->adev;
+
+	return RREG32(umsch->rb_rptr);
+}
+
+static u64 umsch_mm_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_umsch_mm *umsch = (struct amdgpu_umsch_mm *)ring;
+	struct amdgpu_device *adev = ring->adev;
+
+	return RREG32(umsch->rb_wptr);
+}
+
+static const struct amdgpu_ring_funcs umsch_v4_0_ring_funcs = {
+	.type = AMDGPU_RING_TYPE_UMSCH_MM,
+	.align_mask = 0,
+	.nop = 0,
+	.support_64bit_ptrs = false,
+	.get_rptr = umsch_mm_ring_get_rptr,
+	.get_wptr = umsch_mm_ring_get_wptr,
+	.set_wptr = umsch_mm_ring_set_wptr,
+	.insert_nop = amdgpu_ring_insert_nop,
+};
+
+int amdgpu_umsch_mm_ring_init(struct amdgpu_umsch_mm *umsch)
+{
+	struct amdgpu_device *adev = container_of(umsch, struct amdgpu_device, umsch_mm);
+	struct amdgpu_ring *ring = &umsch->ring;
+
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+	ring->use_doorbell = 0;
+	ring->no_scheduler = true;
+	ring->doorbell_index = (AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1) + 6;
+
+	snprintf(ring->name, sizeof(ring->name), "umsch");
+
+	return amdgpu_ring_init(adev, ring, 1024, NULL, 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
+}
+
+int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
+{
+	const struct umsch_mm_firmware_header_v1_0 *umsch_mm_hdr;
+	struct amdgpu_device *adev = umsch->ring.adev;
+	const char *fw_name = NULL;
+	int r;
+
+	switch (adev->ip_versions[VCN_HWIP][0]) {
+	case IP_VERSION(4, 0, 5):
+		fw_name = "amdgpu/umsch_mm_4_0_0.bin";
+		break;
+	default:
+		break;
+	}
+
+	r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, fw_name);
+	if (r) {
+		release_firmware(adev->umsch_mm.fw);
+		adev->umsch_mm.fw = NULL;
+		return r;
+	}
+
+	umsch_mm_hdr = (const struct umsch_mm_firmware_header_v1_0 *)adev->umsch_mm.fw->data;
+
+	adev->umsch_mm.ucode_size = le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_size_bytes);
+	adev->umsch_mm.data_size = le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_data_size_bytes);
+
+	adev->umsch_mm.irq_start_addr =
+		le32_to_cpu(umsch_mm_hdr->umsch_mm_irq_start_addr_lo) |
+		((uint64_t)(le32_to_cpu(umsch_mm_hdr->umsch_mm_irq_start_addr_hi)) << 32);
+	adev->umsch_mm.uc_start_addr =
+		le32_to_cpu(umsch_mm_hdr->umsch_mm_uc_start_addr_lo) |
+		((uint64_t)(le32_to_cpu(umsch_mm_hdr->umsch_mm_uc_start_addr_hi)) << 32);
+	adev->umsch_mm.data_start_addr =
+		le32_to_cpu(umsch_mm_hdr->umsch_mm_data_start_addr_lo) |
+		((uint64_t)(le32_to_cpu(umsch_mm_hdr->umsch_mm_data_start_addr_hi)) << 32);
+
+	return 0;
+}
+
+int amdgpu_umsch_mm_allocate_ucode_buffer(struct amdgpu_umsch_mm *umsch)
+{
+	const struct umsch_mm_firmware_header_v1_0 *umsch_mm_hdr;
+	struct amdgpu_device *adev = umsch->ring.adev;
+	const __le32 *fw_data;
+	uint32_t fw_size;
+	int r;
+
+	umsch_mm_hdr = (const struct umsch_mm_firmware_header_v1_0 *)
+		       adev->umsch_mm.fw->data;
+
+	fw_data = (const __le32 *)(adev->umsch_mm.fw->data +
+		  le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_offset_bytes));
+	fw_size = le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_size_bytes);
+
+	r = amdgpu_bo_create_reserved(adev, fw_size,
+				      4 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->umsch_mm.ucode_fw_obj,
+				      &adev->umsch_mm.ucode_fw_gpu_addr,
+				      (void **)&adev->umsch_mm.ucode_fw_ptr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create umsch_mm fw ucode bo\n", r);
+		return r;
+	}
+
+	memcpy(adev->umsch_mm.ucode_fw_ptr, fw_data, fw_size);
+
+	amdgpu_bo_kunmap(adev->umsch_mm.ucode_fw_obj);
+	amdgpu_bo_unreserve(adev->umsch_mm.ucode_fw_obj);
+	return 0;
+}
+
+int amdgpu_umsch_mm_allocate_ucode_data_buffer(struct amdgpu_umsch_mm *umsch)
+{
+	const struct umsch_mm_firmware_header_v1_0 *umsch_mm_hdr;
+	struct amdgpu_device *adev = umsch->ring.adev;
+	const __le32 *fw_data;
+	uint32_t fw_size;
+	int r;
+
+	umsch_mm_hdr = (const struct umsch_mm_firmware_header_v1_0 *)
+		       adev->umsch_mm.fw->data;
+
+	fw_data = (const __le32 *)(adev->umsch_mm.fw->data +
+		  le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_data_offset_bytes));
+	fw_size = le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_data_size_bytes);
+
+	r = amdgpu_bo_create_reserved(adev, fw_size,
+				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->umsch_mm.data_fw_obj,
+				      &adev->umsch_mm.data_fw_gpu_addr,
+				      (void **)&adev->umsch_mm.data_fw_ptr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create umsch_mm fw data bo\n", r);
+		return r;
+	}
+
+	memcpy(adev->umsch_mm.data_fw_ptr, fw_data, fw_size);
+
+	amdgpu_bo_kunmap(adev->umsch_mm.data_fw_obj);
+	amdgpu_bo_unreserve(adev->umsch_mm.data_fw_obj);
+	return 0;
+}
+
+static void umsch_mm_agdb_index_init(struct amdgpu_device *adev)
+{
+	uint32_t umsch_mm_agdb_start;
+	int i;
+
+	umsch_mm_agdb_start = adev->doorbell_index.max_assignment + 1;
+	umsch_mm_agdb_start = roundup(umsch_mm_agdb_start, 1024);
+	umsch_mm_agdb_start += (AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1);
+
+	for (i = 0; i < CONTEXT_PRIORITY_NUM_LEVELS; i++)
+		adev->umsch_mm.agdb_index[i] = umsch_mm_agdb_start + i;
+}
+
+static int umsch_mm_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = amdgpu_device_wb_get(adev, &adev->umsch_mm.wb_index);
+	if (r) {
+		dev_err(adev->dev, "failed to alloc wb for umsch: %d\n", r);
+		return r;
+	}
+
+	adev->umsch_mm.sch_ctx_gpu_addr = adev->wb.gpu_addr +
+					  (adev->umsch_mm.wb_index * 4);
+
+	mutex_init(&adev->umsch_mm.mutex_hidden);
+
+	umsch_mm_agdb_index_init(adev);
+
+	return 0;
+}
+
+
+static int umsch_mm_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	switch (adev->ip_versions[VCN_HWIP][0]) {
+	case IP_VERSION(4, 0, 5):
+		umsch_mm_v4_0_set_funcs(&adev->umsch_mm);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	adev->umsch_mm.ring.funcs = &umsch_v4_0_ring_funcs;
+	umsch_mm_set_regs(&adev->umsch_mm);
+
+	return 0;
+}
+
+static int umsch_mm_late_init(void *handle)
+{
+	return 0;
+}
+
+static int umsch_mm_sw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = umsch_mm_init(adev);
+	if (r)
+		return r;
+
+	r = umsch_mm_ring_init(&adev->umsch_mm);
+	if (r)
+		return r;
+
+	r = umsch_mm_init_microcode(&adev->umsch_mm);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int umsch_mm_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	release_firmware(adev->umsch_mm.fw);
+	adev->umsch_mm.fw = NULL;
+
+	amdgpu_ring_fini(&adev->umsch_mm.ring);
+
+	mutex_destroy(&adev->umsch_mm.mutex_hidden);
+	amdgpu_device_wb_free(adev, adev->umsch_mm.wb_index);
+
+	return 0;
+}
+
+static int umsch_mm_hw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+		r = umsch_mm_load_microcode(&adev->umsch_mm);
+		if (r)
+			return r;
+	}
+
+	umsch_mm_ring_start(&adev->umsch_mm);
+
+	r = umsch_mm_set_hw_resources(&adev->umsch_mm);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int umsch_mm_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	umsch_mm_ring_stop(&adev->umsch_mm);
+
+	amdgpu_bo_free_kernel(&adev->umsch_mm.data_fw_obj,
+			      &adev->umsch_mm.data_fw_gpu_addr,
+			      (void **)&adev->umsch_mm.data_fw_ptr);
+
+	amdgpu_bo_free_kernel(&adev->umsch_mm.ucode_fw_obj,
+			      &adev->umsch_mm.ucode_fw_gpu_addr,
+			      (void **)&adev->umsch_mm.ucode_fw_ptr);
+	return 0;
+}
+
+static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs = {
+	.name = "umsch_mm_v4_0",
+	.early_init = umsch_mm_early_init,
+	.late_init = umsch_mm_late_init,
+	.sw_init = umsch_mm_sw_init,
+	.sw_fini = umsch_mm_sw_fini,
+	.hw_init = umsch_mm_hw_init,
+	.hw_fini = umsch_mm_hw_fini,
+};
+
+const struct amdgpu_ip_block_version umsch_mm_v4_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_UMSCH_MM,
+	.major = 4,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &umsch_mm_v4_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
new file mode 100644
index 000000000000..660150c630e7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_UMSCH_MM_H__
+#define __AMDGPU_UMSCH_MM_H__
+
+enum UMSCH_SWIP_ENGINE_TYPE {
+	UMSCH_SWIP_ENGINE_TYPE_VCN0 = 0,
+	UMSCH_SWIP_ENGINE_TYPE_VCN1 = 1,
+	UMSCH_SWIP_ENGINE_TYPE_VCN = 2,
+	UMSCH_SWIP_ENGINE_TYPE_VPE = 3,
+	UMSCH_SWIP_ENGINE_TYPE_MAX
+};
+
+enum UMSCH_SWIP_AFFINITY_TYPE {
+	UMSCH_SWIP_AFFINITY_TYPE_ANY = 0,
+	UMSCH_SWIP_AFFINITY_TYPE_VCN0 = 1,
+	UMSCH_SWIP_AFFINITY_TYPE_VCN1 = 2,
+	UMSCH_SWIP_AFFINITY_TYPE_MAX
+};
+
+enum UMSCH_CONTEXT_PRIORITY_LEVEL {
+	CONTEXT_PRIORITY_LEVEL_IDLE = 0,
+	CONTEXT_PRIORITY_LEVEL_NORMAL = 1,
+	CONTEXT_PRIORITY_LEVEL_FOCUS = 2,
+	CONTEXT_PRIORITY_LEVEL_REALTIME = 3,
+	CONTEXT_PRIORITY_NUM_LEVELS
+};
+
+struct umsch_mm_set_resource_input {
+	uint32_t vmid_mask_mm_vcn;
+	uint32_t vmid_mask_mm_vpe;
+	uint32_t logging_vmid;
+	uint32_t engine_mask;
+	union {
+		struct {
+			uint32_t disable_reset : 1;
+			uint32_t disable_umsch_mm_log : 1;
+			uint32_t reserved : 30;
+		};
+		uint32_t uint32_all;
+	};
+};
+
+struct umsch_mm_add_queue_input {
+	uint32_t process_id;
+	uint64_t page_table_base_addr;
+	uint64_t process_va_start;
+	uint64_t process_va_end;
+	uint64_t process_quantum;
+	uint64_t process_csa_addr;
+	uint64_t context_quantum;
+	uint64_t context_csa_addr;
+	uint32_t inprocess_context_priority;
+	enum UMSCH_CONTEXT_PRIORITY_LEVEL context_global_priority_level;
+	uint32_t doorbell_offset_0;
+	uint32_t doorbell_offset_1;
+	enum UMSCH_SWIP_ENGINE_TYPE engine_type;
+	uint32_t affinity;
+	enum UMSCH_SWIP_AFFINITY_TYPE affinity_type;
+	uint64_t mqd_addr;
+	uint64_t h_context;
+	uint64_t h_queue;
+	uint32_t vm_context_cntl;
+
+	struct {
+		uint32_t is_context_suspended : 1;
+		uint32_t reserved : 31;
+	};
+};
+
+struct umsch_mm_remove_queue_input {
+	uint32_t doorbell_offset_0;
+	uint32_t doorbell_offset_1;
+	uint64_t context_csa_addr;
+};
+
+struct MQD_INFO {
+	uint32_t rb_base_hi;
+	uint32_t rb_base_lo;
+	uint32_t rb_size;
+	uint32_t wptr_val;
+	uint32_t rptr_val;
+	uint32_t unmapped;
+};
+
+struct amdgpu_umsch_mm;
+
+struct umsch_mm_funcs {
+	int (*set_hw_resources)(struct amdgpu_umsch_mm *umsch);
+	int (*add_queue)(struct amdgpu_umsch_mm *umsch,
+			 struct umsch_mm_add_queue_input *input);
+	int (*remove_queue)(struct amdgpu_umsch_mm *umsch,
+			    struct umsch_mm_remove_queue_input *input);
+	int (*set_regs)(struct amdgpu_umsch_mm *umsch);
+	int (*init_microcode)(struct amdgpu_umsch_mm *umsch);
+	int (*load_microcode)(struct amdgpu_umsch_mm *umsch);
+	int (*ring_init)(struct amdgpu_umsch_mm *umsch);
+	int (*ring_start)(struct amdgpu_umsch_mm *umsch);
+	int (*ring_stop)(struct amdgpu_umsch_mm *umsch);
+	int (*ring_fini)(struct amdgpu_umsch_mm *umsch);
+};
+
+struct amdgpu_umsch_mm {
+	struct amdgpu_ring		ring;
+
+	uint32_t			rb_wptr;
+	uint32_t			rb_rptr;
+
+	const struct umsch_mm_funcs	*funcs;
+
+	const struct firmware		*fw;
+	uint32_t			fw_version;
+	uint32_t			feature_version;
+
+	struct amdgpu_bo		*ucode_fw_obj;
+	uint64_t			ucode_fw_gpu_addr;
+	uint32_t			*ucode_fw_ptr;
+	uint64_t			irq_start_addr;
+	uint64_t			uc_start_addr;
+	uint32_t			ucode_size;
+
+	struct amdgpu_bo		*data_fw_obj;
+	uint64_t			data_fw_gpu_addr;
+	uint32_t			*data_fw_ptr;
+	uint64_t			data_start_addr;
+	uint32_t			data_size;
+
+	uint32_t			wb_index;
+	uint64_t			sch_ctx_gpu_addr;
+	uint32_t			*sch_ctx_cpu_addr;
+
+	uint32_t			vmid_mask_mm_vcn;
+	uint32_t			vmid_mask_mm_vpe;
+	uint32_t			engine_mask;
+	uint32_t			vcn0_hqd_mask;
+	uint32_t			vcn1_hqd_mask;
+	uint32_t			vcn_hqd_mask[2];
+	uint32_t			vpe_hqd_mask;
+	uint32_t			agdb_index[CONTEXT_PRIORITY_NUM_LEVELS];
+
+	struct mutex			mutex_hidden;
+};
+
+int amdgpu_umsch_mm_submit_pkt(struct amdgpu_umsch_mm *umsch, void *pkt, int ndws);
+int amdgpu_umsch_mm_query_fence(struct amdgpu_umsch_mm *umsch);
+
+int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch);
+int amdgpu_umsch_mm_allocate_ucode_buffer(struct amdgpu_umsch_mm *umsch);
+int amdgpu_umsch_mm_allocate_ucode_data_buffer(struct amdgpu_umsch_mm *umsch);
+
+int amdgpu_umsch_mm_ring_init(struct amdgpu_umsch_mm *umsch);
+
+#define umsch_mm_set_hw_resources(umsch) \
+	((umsch)->funcs->set_hw_resources ? (umsch)->funcs->set_hw_resources((umsch)) : 0)
+#define umsch_mm_add_queue(umsch, input) \
+	((umsch)->funcs->add_queue ? (umsch)->funcs->add_queue((umsch), (input)) : 0)
+#define umsch_mm_remove_queue(umsch, input) \
+	((umsch)->funcs->remove_queue ? (umsch)->funcs->remove_queue((umsch), (input)) : 0)
+
+#define umsch_mm_set_regs(umsch) \
+	((umsch)->funcs->set_regs ? (umsch)->funcs->set_regs((umsch)) : 0)
+#define umsch_mm_init_microcode(umsch) \
+	((umsch)->funcs->init_microcode ? (umsch)->funcs->init_microcode((umsch)) : 0)
+#define umsch_mm_load_microcode(umsch) \
+	((umsch)->funcs->load_microcode ? (umsch)->funcs->load_microcode((umsch)) : 0)
+
+#define umsch_mm_ring_init(umsch) \
+	((umsch)->funcs->ring_init ? (umsch)->funcs->ring_init((umsch)) : 0)
+#define umsch_mm_ring_start(umsch) \
+	((umsch)->funcs->ring_start ? (umsch)->funcs->ring_start((umsch)) : 0)
+#define umsch_mm_ring_stop(umsch) \
+	((umsch)->funcs->ring_stop ? (umsch)->funcs->ring_stop((umsch)) : 0)
+#define umsch_mm_ring_fini(umsch) \
+	((umsch)->funcs->ring_fini ? (umsch)->funcs->ring_fini((umsch)) : 0)
+
+static inline void amdgpu_umsch_mm_lock(struct amdgpu_umsch_mm *umsch)
+{
+	mutex_lock(&umsch->mutex_hidden);
+}
+
+static inline void amdgpu_umsch_mm_unlock(struct amdgpu_umsch_mm *umsch)
+{
+	mutex_unlock(&umsch->mutex_hidden);
+}
+
+extern const struct amdgpu_ip_block_version umsch_mm_v4_0_ip_block;
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
new file mode 100644
index 000000000000..0683a8cb044d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include "amdgpu.h"
+#include "soc15_common.h"
+#include "soc21.h"
+#include "vcn/vcn_4_0_0_offset.h"
+#include "vcn/vcn_4_0_0_sh_mask.h"
+
+#include "amdgpu_umsch_mm.h"
+#include "umsch_mm_4_0_api_def.h"
+#include "umsch_mm_v4_0.h"
+
+static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
+{
+	struct amdgpu_device *adev = umsch->ring.adev;
+	uint32_t data;
+	int r;
+
+	r = amdgpu_umsch_mm_allocate_ucode_buffer(umsch);
+	if (r)
+		return r;
+
+	r = amdgpu_umsch_mm_allocate_ucode_data_buffer(umsch);
+	if (r)
+		goto err_free_ucode_bo;
+
+	data = RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
+	data = REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL, MES_CORE_SOFT_RESET, 0);
+	WREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL, data);
+
+	data = RREG32_SOC15(VCN, 0, regVCN_MES_CNTL);
+	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_INVALIDATE_ICACHE, 1);
+	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_RESET, 1);
+	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_ACTIVE, 0);
+	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_HALT, 1);
+	WREG32_SOC15(VCN, 0, regVCN_MES_CNTL, data);
+
+	data = RREG32_SOC15(VCN, 0, regVCN_MES_IC_BASE_CNTL);
+	data = REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, VMID, 0);
+	data = REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, EXE_DISABLE, 0);
+	data = REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, CACHE_POLICY, 0);
+	WREG32_SOC15(VCN, 0, regVCN_MES_IC_BASE_CNTL, data);
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_INTR_ROUTINE_START,
+		     lower_32_bits(adev->umsch_mm.irq_start_addr >> 2));
+	WREG32_SOC15(VCN, 0, regVCN_MES_INTR_ROUTINE_START_HI,
+		     upper_32_bits(adev->umsch_mm.irq_start_addr >> 2));
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_PRGRM_CNTR_START,
+		     lower_32_bits(adev->umsch_mm.uc_start_addr >> 2));
+	WREG32_SOC15(VCN, 0, regVCN_MES_PRGRM_CNTR_START_HI,
+		     upper_32_bits(adev->umsch_mm.uc_start_addr >> 2));
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_INSTR_BASE_LO, 0);
+	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_INSTR_BASE_HI, 0);
+
+	data = adev->umsch_mm.uc_start_addr + adev->umsch_mm.ucode_size - 1;
+	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_INSTR_MASK_LO, lower_32_bits(data));
+	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_INSTR_MASK_HI, upper_32_bits(data));
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_IC_BASE_LO,
+		     lower_32_bits(adev->umsch_mm.ucode_fw_gpu_addr));
+	WREG32_SOC15(VCN, 0, regVCN_MES_IC_BASE_HI,
+		     upper_32_bits(adev->umsch_mm.ucode_fw_gpu_addr));
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_MIBOUND_LO, 0x1FFFFF);
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_BASE0_LO,
+		     lower_32_bits(adev->umsch_mm.data_start_addr));
+	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_BASE0_HI,
+		     upper_32_bits(adev->umsch_mm.data_start_addr));
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_MASK0_LO,
+		     lower_32_bits(adev->umsch_mm.data_size - 1));
+	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_MASK0_HI,
+		     upper_32_bits(adev->umsch_mm.data_size - 1));
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_DC_BASE_LO,
+		     lower_32_bits(adev->umsch_mm.data_fw_gpu_addr));
+	WREG32_SOC15(VCN, 0, regVCN_MES_DC_BASE_HI,
+		     upper_32_bits(adev->umsch_mm.data_fw_gpu_addr));
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_MDBOUND_LO, 0x3FFFF);
+
+	data = RREG32_SOC15(VCN, 0, regUVD_UMSCH_FORCE);
+	data = REG_SET_FIELD(data, UVD_UMSCH_FORCE, IC_FORCE_GPUVM, 1);
+	data = REG_SET_FIELD(data, UVD_UMSCH_FORCE, DC_FORCE_GPUVM, 1);
+	WREG32_SOC15(VCN, 0, regUVD_UMSCH_FORCE, data);
+
+	data = RREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL);
+	data = REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
+	data = REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
+	WREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL, data);
+
+	data = RREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL);
+	data = REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
+	WREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL, data);
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_GP0_LO, 0);
+	WREG32_SOC15(VCN, 0, regVCN_MES_GP0_HI, 0);
+
+	WREG32_SOC15(VCN, 0, regVCN_MES_GP1_LO, 0);
+	WREG32_SOC15(VCN, 0, regVCN_MES_GP1_HI, 0);
+
+	data = RREG32_SOC15(VCN, 0, regVCN_MES_CNTL);
+	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_INVALIDATE_ICACHE, 0);
+	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_RESET, 0);
+	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_HALT, 0);
+	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_ACTIVE, 1);
+	WREG32_SOC15(VCN, 0, regVCN_MES_CNTL, data);
+
+	r = SOC15_WAIT_ON_RREG(VCN, 0, regVCN_MES_MSTATUS_LO, 0xAAAAAAAA, 0xFFFFFFFF);
+	if (r) {
+		dev_err(adev->dev, "UMSCH FW Load: Failed, regVCN_MES_MSTATUS_LO: 0x%08x\n",
+			RREG32_SOC15(VCN, 0, regVCN_MES_MSTATUS_LO));
+		goto err_free_data_bo;
+	}
+
+	return 0;
+
+err_free_data_bo:
+	amdgpu_bo_free_kernel(&adev->umsch_mm.data_fw_obj,
+			      &adev->umsch_mm.data_fw_gpu_addr,
+			      (void **)&adev->umsch_mm.data_fw_ptr);
+err_free_ucode_bo:
+	amdgpu_bo_free_kernel(&adev->umsch_mm.ucode_fw_obj,
+			      &adev->umsch_mm.ucode_fw_gpu_addr,
+			      (void **)&adev->umsch_mm.ucode_fw_ptr);
+	return r;
+}
+
+static void umsch_mm_v4_0_aggregated_doorbell_init(struct amdgpu_umsch_mm *umsch)
+{
+	struct amdgpu_device *adev = umsch->ring.adev;
+	uint32_t data;
+
+	data = RREG32_SOC15(VCN, 0, regVCN_AGDB_CTRL0);
+	data = REG_SET_FIELD(data, VCN_AGDB_CTRL0, OFFSET,
+	       umsch->agdb_index[CONTEXT_PRIORITY_LEVEL_REALTIME]);
+	data = REG_SET_FIELD(data, VCN_AGDB_CTRL0, EN, 1);
+	WREG32_SOC15(VCN, 0, regVCN_AGDB_CTRL0, data);
+
+	data = RREG32_SOC15(VCN, 0, regVCN_AGDB_CTRL1);
+	data = REG_SET_FIELD(data, VCN_AGDB_CTRL1, OFFSET,
+	       umsch->agdb_index[CONTEXT_PRIORITY_LEVEL_FOCUS]);
+	data = REG_SET_FIELD(data, VCN_AGDB_CTRL1, EN, 1);
+	WREG32_SOC15(VCN, 0, regVCN_AGDB_CTRL1, data);
+
+	data = RREG32_SOC15(VCN, 0, regVCN_AGDB_CTRL2);
+	data = REG_SET_FIELD(data, VCN_AGDB_CTRL2, OFFSET,
+	       umsch->agdb_index[CONTEXT_PRIORITY_LEVEL_NORMAL]);
+	data = REG_SET_FIELD(data, VCN_AGDB_CTRL2, EN, 1);
+	WREG32_SOC15(VCN, 0, regVCN_AGDB_CTRL2, data);
+
+	data = RREG32_SOC15(VCN, 0, regVCN_AGDB_CTRL3);
+	data = REG_SET_FIELD(data, VCN_AGDB_CTRL3, OFFSET,
+	       umsch->agdb_index[CONTEXT_PRIORITY_LEVEL_IDLE]);
+	data = REG_SET_FIELD(data, VCN_AGDB_CTRL3, EN, 1);
+	WREG32_SOC15(VCN, 0, regVCN_AGDB_CTRL3, data);
+}
+
+static int umsch_mm_v4_0_ring_start(struct amdgpu_umsch_mm *umsch)
+{
+	struct amdgpu_ring *ring = &umsch->ring;
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t data;
+
+	data = RREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL);
+	data = REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, OFFSET, ring->doorbell_index);
+	data = REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 1);
+	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);
+
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell, ring->doorbell_index, 0);
+
+	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+
+	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_SIZE, ring->ring_size);
+
+	data = RREG32_SOC15(VCN, 0, regVCN_RB_ENABLE);
+	data &= ~(VCN_RB_ENABLE__AUDIO_RB_EN_MASK);
+	WREG32_SOC15(VCN, 0, regVCN_RB_ENABLE, data);
+
+	umsch_mm_v4_0_aggregated_doorbell_init(umsch);
+
+	return 0;
+}
+
+static int umsch_mm_v4_0_ring_stop(struct amdgpu_umsch_mm *umsch)
+{
+	struct amdgpu_ring *ring = &umsch->ring;
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t data;
+
+	data = RREG32_SOC15(VCN, 0, regVCN_RB_ENABLE);
+	data = REG_SET_FIELD(data, VCN_RB_ENABLE, UMSCH_RB_EN, 0);
+	WREG32_SOC15(VCN, 0, regVCN_RB_ENABLE, data);
+
+	data = RREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL);
+	data = REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 0);
+	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);
+
+	return 0;
+}
+
+static int umsch_mm_v4_0_set_hw_resources(struct amdgpu_umsch_mm *umsch)
+{
+	union UMSCHAPI__SET_HW_RESOURCES set_hw_resources = {};
+	struct amdgpu_device *adev = umsch->ring.adev;
+	int r;
+
+	set_hw_resources.header.type = UMSCH_API_TYPE_SCHEDULER;
+	set_hw_resources.header.opcode = UMSCH_API_SET_HW_RSRC;
+	set_hw_resources.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	set_hw_resources.vmid_mask_mm_vcn = umsch->vmid_mask_mm_vcn;
+	set_hw_resources.vmid_mask_mm_vpe = umsch->vmid_mask_mm_vpe;
+	set_hw_resources.engine_mask = umsch->engine_mask;
+
+	set_hw_resources.vcn0_hqd_mask[0] = umsch->vcn0_hqd_mask;
+	set_hw_resources.vcn1_hqd_mask[0] = umsch->vcn1_hqd_mask;
+	set_hw_resources.vcn_hqd_mask[0] = umsch->vcn_hqd_mask[0];
+	set_hw_resources.vcn_hqd_mask[1] = umsch->vcn_hqd_mask[1];
+	set_hw_resources.vpe_hqd_mask[0] = umsch->vpe_hqd_mask;
+
+	set_hw_resources.g_sch_ctx_gpu_mc_ptr = umsch->sch_ctx_gpu_addr;
+
+	set_hw_resources.enable_level_process_quantum_check = 1;
+
+	memcpy(set_hw_resources.mmhub_base, adev->reg_offset[MMHUB_HWIP][0],
+	       sizeof(uint32_t) * 5);
+	set_hw_resources.mmhub_version = adev->ip_versions[MMHUB_HWIP][0];
+
+	memcpy(set_hw_resources.osssys_base, adev->reg_offset[OSSSYS_HWIP][0],
+	       sizeof(uint32_t) * 5);
+	set_hw_resources.osssys_version = adev->ip_versions[OSSSYS_HWIP][0];
+
+	set_hw_resources.api_status.api_completion_fence_addr = umsch->ring.fence_drv.gpu_addr;
+	set_hw_resources.api_status.api_completion_fence_value = ++umsch->ring.fence_drv.sync_seq;
+
+	r = amdgpu_umsch_mm_submit_pkt(umsch, &set_hw_resources.max_dwords_in_api,
+				       API_FRAME_SIZE_IN_DWORDS);
+	if (r)
+		return r;
+
+	r = amdgpu_umsch_mm_query_fence(umsch);
+	if (r) {
+		dev_err(adev->dev, "UMSCH SET_HW_RESOURCES: Failed\n");
+		return r;
+	}
+
+	return 0;
+}
+
+static int umsch_mm_v4_0_add_queue(struct amdgpu_umsch_mm *umsch,
+				   struct umsch_mm_add_queue_input *input_ptr)
+{
+	struct amdgpu_device *adev = umsch->ring.adev;
+	union UMSCHAPI__ADD_QUEUE add_queue = {};
+	int r;
+
+	add_queue.header.type = UMSCH_API_TYPE_SCHEDULER;
+	add_queue.header.opcode = UMSCH_API_ADD_QUEUE;
+	add_queue.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	add_queue.process_id = input_ptr->process_id;
+	add_queue.page_table_base_addr = input_ptr->page_table_base_addr;
+	add_queue.process_va_start = input_ptr->process_va_start;
+	add_queue.process_va_end = input_ptr->process_va_end;
+	add_queue.process_quantum = input_ptr->process_quantum;
+	add_queue.process_csa_addr = input_ptr->process_csa_addr;
+	add_queue.context_quantum = input_ptr->context_quantum;
+	add_queue.context_csa_addr = input_ptr->context_csa_addr;
+	add_queue.inprocess_context_priority = input_ptr->inprocess_context_priority;
+	add_queue.context_global_priority_level =
+		(enum UMSCH_AMD_PRIORITY_LEVEL)input_ptr->context_global_priority_level;
+	add_queue.doorbell_offset_0 = input_ptr->doorbell_offset_0;
+	add_queue.doorbell_offset_1 = input_ptr->doorbell_offset_1;
+	add_queue.affinity.u32All = input_ptr->affinity;
+	add_queue.mqd_addr = input_ptr->mqd_addr;
+	add_queue.engine_type = (enum UMSCH_ENGINE_TYPE)input_ptr->engine_type;
+	add_queue.h_context = input_ptr->h_context;
+	add_queue.h_queue = input_ptr->h_queue;
+	add_queue.vm_context_cntl = input_ptr->vm_context_cntl;
+	add_queue.is_context_suspended = input_ptr->is_context_suspended;
+
+	add_queue.api_status.api_completion_fence_addr = umsch->ring.fence_drv.gpu_addr;
+	add_queue.api_status.api_completion_fence_value = ++umsch->ring.fence_drv.sync_seq;
+
+	r = amdgpu_umsch_mm_submit_pkt(umsch, &add_queue.max_dwords_in_api,
+				       API_FRAME_SIZE_IN_DWORDS);
+	if (r)
+		return r;
+
+	r = amdgpu_umsch_mm_query_fence(umsch);
+	if (r) {
+		dev_err(adev->dev, "UMSCH ADD_QUEUE: Failed\n");
+		return r;
+	}
+
+	return 0;
+}
+
+static int umsch_mm_v4_0_remove_queue(struct amdgpu_umsch_mm *umsch,
+				      struct umsch_mm_remove_queue_input *input_ptr)
+{
+	union UMSCHAPI__REMOVE_QUEUE remove_queue = {};
+	struct amdgpu_device *adev = umsch->ring.adev;
+	int r;
+
+	remove_queue.header.type = UMSCH_API_TYPE_SCHEDULER;
+	remove_queue.header.opcode = UMSCH_API_REMOVE_QUEUE;
+	remove_queue.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	remove_queue.doorbell_offset_0 = input_ptr->doorbell_offset_0;
+	remove_queue.doorbell_offset_1 = input_ptr->doorbell_offset_1;
+	remove_queue.context_csa_addr = input_ptr->context_csa_addr;
+
+	remove_queue.api_status.api_completion_fence_addr = umsch->ring.fence_drv.gpu_addr;
+	remove_queue.api_status.api_completion_fence_value = ++umsch->ring.fence_drv.sync_seq;
+
+	r = amdgpu_umsch_mm_submit_pkt(umsch, &remove_queue.max_dwords_in_api,
+				       API_FRAME_SIZE_IN_DWORDS);
+	if (r)
+		return r;
+
+	r = amdgpu_umsch_mm_query_fence(umsch);
+	if (r) {
+		dev_err(adev->dev, "UMSCH REMOVE_QUEUE: Failed\n");
+		return r;
+	}
+
+	return 0;
+}
+
+static int umsch_mm_v4_0_set_regs(struct amdgpu_umsch_mm *umsch)
+{
+	struct amdgpu_device *adev = container_of(umsch, struct amdgpu_device, umsch_mm);
+
+	umsch->rb_wptr = SOC15_REG_OFFSET(VCN, 0, regVCN_UMSCH_RB_WPTR);
+	umsch->rb_rptr = SOC15_REG_OFFSET(VCN, 0, regVCN_UMSCH_RB_RPTR);
+
+	return 0;
+}
+
+static const struct umsch_mm_funcs umsch_mm_v4_0_funcs = {
+	.set_hw_resources = umsch_mm_v4_0_set_hw_resources,
+	.add_queue = umsch_mm_v4_0_add_queue,
+	.remove_queue = umsch_mm_v4_0_remove_queue,
+	.set_regs = umsch_mm_v4_0_set_regs,
+	.init_microcode = amdgpu_umsch_mm_init_microcode,
+	.load_microcode = umsch_mm_v4_0_load_microcode,
+	.ring_init = amdgpu_umsch_mm_ring_init,
+	.ring_start = umsch_mm_v4_0_ring_start,
+	.ring_stop = umsch_mm_v4_0_ring_stop,
+};
+
+void umsch_mm_v4_0_set_funcs(struct amdgpu_umsch_mm *umsch)
+{
+	umsch->funcs = &umsch_mm_v4_0_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.h b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.h
new file mode 100644
index 000000000000..06bc0fa74996
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __UMSCH_MM_V4_0_H__
+#define __UMSCH_MM_V4_0_H__
+
+void umsch_mm_v4_0_set_funcs(struct amdgpu_umsch_mm *umsch);
+
+#endif
-- 
2.41.0


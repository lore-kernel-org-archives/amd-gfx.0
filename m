Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103D1C54FB9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 07:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F42410E273;
	Tue, 21 Nov 2023 07:34:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FAE10E273
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 07:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXc4xxPaC37xiiNsjirTeYZEtjF6L9qfkid52H/+eVfdHO9P80V0+YMcw8pz2Cbf1KbOvYubSbse7rLch/kxCkYt0fQuQuJmmcZcRZmIRfooJf5OQRI2FPquLAJVxfbMeIB+3O5h7+nUsuLKEf68g/ex5qCP04wEYApRluBNzYwWFo5ey2ekE0fMQSNx6cKBYQSDEg5252MNWFAMSLEV5u8Ddb5iUW8ACl3h6Us9wjbr5E6SmgAP7EqNSs2jON980YLnZ7GrMQ7WzR1H2JpsqGOGNezEQZ5yzNb1+n8xiXKCDLIWilZOba6cYsDKAhZmjqUFaTt83+8FeuEwxJhjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyw6WDZKipDHvkikhy/Ra4oRHewkL1oWkkETdiCC5oo=;
 b=TehTFslPVRXAQ5SqUEw3O8w88lOy2B9JJtYnCUg3WECTmID/4/DQItfJSA87WnI3R1PoYTQw2fwhWaBPEwK7gHDLCayM2U7d5yT7WaLWSBymsocgW5fhUHEwywJYVYO0JGeILvLhKmoSsSZz+RTkE2VG+KUQPE9/SGLunTYT8cKh+XacINBgDi0RR1NmskCp6BXjGUhbfH2YkmNUanseOjVv27a1lZXpjEmSmY82SOVqfD8okpP9lsL8UHdxxXY1x2cvsEbyTztA87NStAziulx5mdckNA93+DiAhoWglbcLjf6fKXE/ZHM54SMxhqgfjxGS8fYs34Z9wBm6RPk+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyw6WDZKipDHvkikhy/Ra4oRHewkL1oWkkETdiCC5oo=;
 b=Gcv7f/1pxFJI7As/NCmsH5JUTJ/iEA8NfJnCC8ueSwLjvrh46vUlcytwo/aBi7duKl/co2XUYEaCvIhATFK/ZEZI78+IzfM/RQKcxIYhs+iOIps/Rti83cGDNLUlCPHUPu3N+inFzBwZ4PwlW1cXhqet0RelURCjwWe6Y1PETrc=
Received: from MW4PR04CA0342.namprd04.prod.outlook.com (2603:10b6:303:8a::17)
 by CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 07:34:06 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::ad) by MW4PR04CA0342.outlook.office365.com
 (2603:10b6:303:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Tue, 21 Nov 2023 07:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.3 via Frontend Transport; Tue, 21 Nov 2023 07:34:06 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 01:33:58 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/6] drm/amdgpu: add ring mode support for lsdma
Date: Tue, 21 Nov 2023 15:30:12 +0800
Message-ID: <20231121073014.2984557-5-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231121073014.2984557-1-yifan1.zhang@amd.com>
References: <20231121073014.2984557-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|CH2PR12MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 63baefcf-d5a8-4979-c5c4-08dbea643e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZTOmnoxHESmyF5mqb1dQQGr/rKDigVsoSVlUU2ZCP4ugbz90/iSFkO6MAa672+j9BaaJt96pzirpNaEOeJxCT9gRNu/FBC9VGHtpxoMflM337Lr68vtYfiEniZ8sl6WlScZzVFpljL7grlrjpirNif3m8p4YaVEaNRnORtSHB/NZXavIXseuYdNZg/YjotkT2UUFdFQB8+cblAoqOqn6PtkWxX+mXrVexXajCc5ngQUFlGUphUG8RCG9fh4usdUp50GUu0hJMDyhn67z0TVojqzRHcRSs+pXrV8jX2NAikWZUun+mTbC0GW3mXiIHVSBIMACEzRYuJ3X6x3nTTDQDIdqS18B0Dkk3wMrzZKYQO3A1Gy+PtiY8gqqGjKuAlVxITtyxU8H0Pe2h5idxxUZmhx7dl5zpEYJRqHHgaSrbNwYf5ZwM4kB8ly/JJWJPcl755jrIS+pwUmkKKaoDbPr7MA5pqnY8CxOXDK43OfeG1Go1/jtatL44MhhskXHG9K68EB0jE3Phni56MMy0aWEDguU0mCdzxEqqoJzxImugetWeT2/P8T7Uapk8DdWwkddsWaAPQX3XjRuQGuz0pLvu9+/v8lM4lGXZGPxCxIAxUB0WV+axEbupmwYLjPskXBTfSua/AXb/H+0U9jkjF6JM2eBC8NM3bMkSlUbqMm7PiNuI+mxAS63jnYasyjhrQuoz32TeQyEC3y5Va8fxeeWCb5YL54x9G1ftrS4Qvw+PMQvehphXGM9UJVGxwmf814
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(70206006)(40460700003)(6916009)(316002)(54906003)(70586007)(7696005)(36756003)(6666004)(336012)(426003)(2616005)(26005)(1076003)(16526019)(478600001)(82740400003)(81166007)(356005)(83380400001)(36860700001)(86362001)(47076005)(40480700001)(30864003)(5660300002)(2906002)(8936002)(4326008)(41300700001)(8676002)(21314003)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:34:06.1196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63baefcf-d5a8-4979-c5c4-08dbea643e1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4955
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang Yu <lang.yu@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add ring mode support for lsdma.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c     |   40 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h     |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |    1 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c       | 1293 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h       |    3 +-
 6 files changed, 1384 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f96811bbe40e..3e7ad86d7fa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2044,6 +2044,22 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int amdgpu_discovery_set_lsdma_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
+	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 1):
+	case IP_VERSION(6, 0, 2):
+	case IP_VERSION(6, 0, 3):
+	case IP_VERSION(6, 1, 0):
+		amdgpu_device_ip_block_add(adev, &lsdma_v6_0_ip_block);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 {
 	if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
@@ -2699,6 +2715,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = amdgpu_discovery_set_lsdma_ip_blocks(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_discovery_set_mes_ip_blocks(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
index 4d1d4994ea3f..44428c4de958 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
@@ -25,6 +25,8 @@
 #include "amdgpu_lsdma.h"
 
 #define AMDGPU_LSDMA_MAX_SIZE	0x2000000ULL
+/* LSDMA CSA resides in the 5th page of CSA */
+#define AMDGPU_CSA_LSDMA_OFFSET 	(4096 * 4)
 
 int amdgpu_lsdma_wait_for(struct amdgpu_device *adev,
 			  uint32_t reg_index, uint32_t reg_val,
@@ -89,3 +91,41 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+uint64_t amdgpu_lsdma_get_csa_mc_addr(struct amdgpu_ring *ring,
+				     unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint64_t csa_mc_addr;
+
+	/* don't enable OS preemption on SDMA under SRIOV */
+	if (amdgpu_sriov_vf(adev) || vmid == 0 || !adev->gfx.mcbp)
+		return 0;
+
+	if (ring->is_mes_queue) {
+		uint32_t offset = 0;
+
+		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+				  sdma[ring->idx].sdma_meta_data);
+		csa_mc_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+	} else {
+		csa_mc_addr = amdgpu_csa_vaddr(adev) + AMDGPU_CSA_LSDMA_OFFSET;
+	}
+
+	return csa_mc_addr;
+}
+
+void amdgpu_lsdma_destroy_inst_ctx(struct amdgpu_device *adev)
+{
+	amdgpu_ucode_release(&adev->lsdma.fw);
+}
+
+void amdgpu_lsdma_unset_buffer_funcs_helper(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *lsdma;
+
+	lsdma = &adev->lsdma.ring;
+
+   if (adev->mman.buffer_funcs_ring == lsdma)
+		amdgpu_ttm_set_buffer_funcs_status(adev, false);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index c61ba58c5ee0..933c59ded652 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -24,10 +24,6 @@
 #ifndef __AMDGPU_LSDMA_H__
 #define __AMDGPU_LSDMA_H__
 
-struct amdgpu_lsdma {
-	const struct amdgpu_lsdma_funcs      *funcs;
-};
-
 struct amdgpu_lsdma_funcs {
 	int (*copy_mem)(struct amdgpu_device *adev, uint64_t src_addr,
 			uint64_t dst_addr, uint64_t size);
@@ -43,4 +39,33 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
 int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
 			  uint32_t reg_val, uint32_t mask);
 
+struct amdgpu_lsdma {
+	struct amdgpu_irq_src	trap_irq;
+	struct amdgpu_irq_src	illegal_inst_irq;
+	struct amdgpu_irq_src	ecc_irq;
+	struct amdgpu_irq_src	vm_hole_irq;
+	struct amdgpu_irq_src	doorbell_invalid_irq;
+	struct amdgpu_irq_src	pool_timeout_irq;
+	struct amdgpu_irq_src	srbm_write_irq;
+
+	uint32_t 		lsdma_mask;
+
+	/* LSDMA firmware */
+	const struct firmware	*fw;
+	uint32_t		fw_version;
+	uint32_t		feature_version;
+
+	struct amdgpu_ring	ring;
+	struct amdgpu_ring	page;
+	bool			burst_nop;
+	uint32_t		aid_id;
+
+	const struct amdgpu_lsdma_funcs	*funcs;
+
+};
+
+uint64_t amdgpu_lsdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned int vmid);
+void amdgpu_lsdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
+void amdgpu_lsdma_destroy_inst_ctx(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7f6a14e2282e..95004c2de81d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -79,6 +79,7 @@ enum amdgpu_ring_type {
 	AMDGPU_RING_TYPE_VCN_ENC	= AMDGPU_HW_IP_VCN_ENC,
 	AMDGPU_RING_TYPE_VCN_JPEG	= AMDGPU_HW_IP_VCN_JPEG,
 	AMDGPU_RING_TYPE_VPE		= AMDGPU_HW_IP_VPE,
+	AMDGPU_RING_TYPE_LSDMA		= AMDGPU_HW_IP_LSDMA,
 	AMDGPU_RING_TYPE_KIQ,
 	AMDGPU_RING_TYPE_MES,
 	AMDGPU_RING_TYPE_UMSCH_MM,
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
index 1a285b531881..26577525df0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
@@ -22,12 +22,21 @@
  */
 
 #include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
 #include "amdgpu.h"
 #include "lsdma_v6_0.h"
 #include "amdgpu_lsdma.h"
 
 #include "lsdma/lsdma_6_0_0_offset.h"
 #include "lsdma/lsdma_6_0_0_sh_mask.h"
+#include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
+#include "sdma_v6_0_0_pkt_open.h"
+#include "v11_structs.h"
+
+static void lsdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev);
 
 static int lsdma_v6_0_wait_pio_status(struct amdgpu_device *adev)
 {
@@ -119,3 +128,1287 @@ const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
 	.fill_mem = lsdma_v6_0_fill_mem,
 	.update_memory_power_gating = lsdma_v6_0_update_memory_power_gating
 };
+
+/**
+ * lsdma_v6_0_ctxempty_int_enable - enable or disable context empty interrupts
+ *
+ * @adev: amdgpu_device pointer
+ * @enable: enable/disable context switching due to queue empty conditions
+ *
+ * Enable or disable the async dma engines queue empty context switch.
+ */
+static void lsdma_v6_0_ctxempty_int_enable(struct amdgpu_device *adev, bool enable)
+{
+	uint32_t f32_cntl;
+
+
+	if (!amdgpu_sriov_vf(adev)) {
+			f32_cntl = RREG32_SOC15(LSDMA, 0, regLSDMA_INT_CNTL);
+			f32_cntl = REG_SET_FIELD(f32_cntl, LSDMA_INT_CNTL,
+					CTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
+			WREG32_SOC15(LSDMA, 0, regLSDMA_INT_CNTL, f32_cntl);
+	}
+}
+
+/**
+ * lsdma_v6_0_gfx_stop - stop the gfx async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Stop the gfx async dma ring buffers.
+ */
+static void lsdma_v6_0_gfx_stop(struct amdgpu_device *adev)
+{
+	u32 rb_cntl, ib_cntl;
+
+	amdgpu_lsdma_unset_buffer_funcs_helper(adev);
+
+	rb_cntl = RREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_CNTL);
+	rb_cntl = REG_SET_FIELD(rb_cntl, LSDMA_QUEUE0_RB_CNTL, RB_ENABLE, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_CNTL, rb_cntl);
+
+	ib_cntl = RREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_IB_CNTL);
+	ib_cntl = REG_SET_FIELD(rb_cntl, LSDMA_QUEUE0_IB_CNTL, IB_ENABLE, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_CNTL, ib_cntl);
+
+}
+
+/**
+ * lsdma_v6_0_rlc_stop - stop the compute async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Stop the compute async dma queues.
+ */
+static void lsdma_v6_0_rlc_stop(struct amdgpu_device *adev)
+{
+	/* XXX todo */
+}
+
+
+/**
+ * lsdma_v6_0_enable - stop the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ * @enable: enable/disable the DMA MEs.
+ *
+ * Halt or unhalt the async dma engines.
+ */
+static void lsdma_v6_0_enable(struct amdgpu_device *adev, bool enable)
+{
+	u32 f32_cntl;
+
+	if (!enable) {
+		lsdma_v6_0_gfx_stop(adev);
+		lsdma_v6_0_rlc_stop(adev);
+	}
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	f32_cntl = RREG32_SOC15(LSDMA, 0, regLSDMA_F32_CNTL);
+	f32_cntl = REG_SET_FIELD(f32_cntl, LSDMA_F32_CNTL, HALT, enable ? 0 : 1);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_F32_CNTL, f32_cntl);
+}
+
+
+/**
+ * lsdma_v6_0_emit_copy_buffer - copy buffer using the sDMA engine
+ *
+ * @ib: indirect buffer to fill with commands
+ * @src_offset: src GPU address
+ * @dst_offset: dst GPU address
+ * @byte_count: number of bytes to xfer
+ * @tmz: if a secure copy should be used
+ *
+ * Copy GPU buffers using the DMA engine.
+ * Used by the amdgpu ttm implementation to move pages if
+ * registered as the asic copy callback.
+ */
+static void lsdma_v6_0_emit_copy_buffer(struct amdgpu_ib *ib,
+				       uint64_t src_offset,
+				       uint64_t dst_offset,
+				       uint32_t byte_count,
+				       bool tmz)
+{
+	ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_COPY) |
+		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
+		SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
+	ib->ptr[ib->length_dw++] = byte_count - 1;
+	ib->ptr[ib->length_dw++] = 0; /* src/dst endian swap */
+	ib->ptr[ib->length_dw++] = lower_32_bits(src_offset);
+	ib->ptr[ib->length_dw++] = upper_32_bits(src_offset);
+	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
+	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
+}
+
+/**
+ * lsdma_v6_0_emit_fill_buffer - fill buffer using the sDMA engine
+ *
+ * @ib: indirect buffer to fill
+ * @src_data: value to write to buffer
+ * @dst_offset: dst GPU address
+ * @byte_count: number of bytes to xfer
+ *
+ * Fill GPU buffers using the DMA engine.
+ */
+static void lsdma_v6_0_emit_fill_buffer(struct amdgpu_ib *ib,
+				       uint32_t src_data,
+				       uint64_t dst_offset,
+				       uint32_t byte_count)
+{
+	ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_CONST_FILL);
+	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
+	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
+	ib->ptr[ib->length_dw++] = src_data;
+	ib->ptr[ib->length_dw++] = byte_count - 1;
+}
+
+
+static const struct amdgpu_buffer_funcs lsdma_v6_0_buffer_funcs = {
+	.copy_max_bytes = 0x400000,
+	.copy_num_dw = 7,
+	.emit_copy_buffer = lsdma_v6_0_emit_copy_buffer,
+
+	.fill_max_bytes = 0x400000,
+	.fill_num_dw = 5,
+	.emit_fill_buffer = lsdma_v6_0_emit_fill_buffer,
+};
+
+
+static void lsdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev)
+{
+		adev->mman.buffer_funcs = &lsdma_v6_0_buffer_funcs;
+		adev->mman.buffer_funcs_ring = &adev->lsdma.ring;
+}
+
+
+/**
+ * lsdma_v6_0_ring_get_rptr - get the current read pointer
+ *
+ * @ring: amdgpu ring pointer
+ *
+ * Get the current rptr from the hardware.
+ */
+static uint64_t lsdma_v6_0_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	u64 *rptr;
+
+	/* XXX check if swapping is necessary on BE */
+	rptr = (u64 *)ring->rptr_cpu_addr;
+
+	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
+	return ((*rptr) >> 2);
+}
+
+
+/**
+ * lsdma_v6_0_ring_get_wptr - get the current write pointer
+ *
+ * @ring: amdgpu ring pointer
+ *
+ * Get the current wptr from the hardware.
+ */
+static uint64_t lsdma_v6_0_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u64 wptr = 0;
+
+	if (ring->use_doorbell) {
+		/* XXX check if swapping is necessary on BE */
+		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
+		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
+	} else {
+		wptr = (u64)RREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_WPTR) |
+			(u64)RREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_WPTR_HI) << 32;
+	}
+
+	return wptr >> 2;
+}
+
+/**
+ * sdma_v6_0_ring_set_wptr - commit the write pointer
+ *
+ * @ring: amdgpu ring pointer
+ *
+ * Write the wptr back to the hardware.
+ */
+static void lsdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t *wptr_saved;
+	uint32_t *is_queue_unmap;
+	uint64_t aggregated_db_index;
+	uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
+
+	if (ring->is_mes_queue) {
+		wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
+		is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
+					      sizeof(uint32_t));
+		aggregated_db_index =
+			amdgpu_mes_get_aggregated_doorbell_index(adev,
+							 ring->hw_prio);
+
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+			     ring->wptr << 2);
+		*wptr_saved = ring->wptr << 2;
+		if (*is_queue_unmap) {
+			WDOORBELL64(aggregated_db_index, ring->wptr << 2);
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+					ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		} else {
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+					ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+
+			if (*is_queue_unmap)
+				WDOORBELL64(aggregated_db_index,
+					    ring->wptr << 2);
+		}
+	} else {
+		if (ring->use_doorbell) {
+			DRM_DEBUG("Using doorbell -- "
+				  "wptr_offs == 0x%08x "
+				  "lower_32_bits(ring->wptr) << 2 == 0x%08x "
+				  "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
+				  ring->wptr_offs,
+				  lower_32_bits(ring->wptr << 2),
+				  upper_32_bits(ring->wptr << 2));
+			/* XXX check if swapping is necessary on BE */
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+				     ring->wptr << 2);
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+				  ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		} else {
+			DRM_DEBUG("Not using doorbell -- "
+				  "ring->wptr << 2 0x%016llx\n"
+				  "*(ring->rptr_cpu_addr) 0x%016llx\n",
+				  ring->wptr << 2,
+				  (u64)(*ring->rptr_cpu_addr));
+			WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_WPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_WPTR_HI,	upper_32_bits(ring->wptr << 2));
+		}
+	}
+}
+
+static void lsdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
+{
+	struct amdgpu_lsdma *lsdma = &ring->adev->lsdma;
+	int i;
+
+	for (i = 0; i < count; i++)
+		if (lsdma && lsdma->burst_nop && (i == 0))
+			amdgpu_ring_write(ring, ring->funcs->nop |
+				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
+		else
+			amdgpu_ring_write(ring, ring->funcs->nop);
+}
+
+
+/*
+ * lsdma_v6_0_ring_emit_ib - Schedule an IB on the DMA engine
+ *
+ * @ring: amdgpu ring pointer
+ * @ib: IB object to schedule
+ * @flags: unused
+ * @job: job to retrieve vmid from
+ *
+ * Schedule an IB in the DMA ring.
+ */
+static void lsdma_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
+				   struct amdgpu_job *job,
+				   struct amdgpu_ib *ib,
+				   uint32_t flags)
+{
+	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
+	uint64_t csa_mc_addr = amdgpu_lsdma_get_csa_mc_addr(ring, vmid);
+
+	/* An IB packet must end on a 8 DW boundary--the next dword
+	 * must be on a 8-dword boundary. Our IB packet below is 6
+	 * dwords long, thus add x number of NOPs, such that, in
+	 * modular arithmetic,
+	 * wptr + 6 + x = 8k, k >= 0, which in C is,
+	 * (wptr + 6 + x) % 8 = 0.
+	 * The expression below, is a solution of x.
+	 */
+	lsdma_v6_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
+
+	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_INDIRECT) |
+			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
+	/* base must be 32 byte aligned */
+	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr) & 0xffffffe0);
+	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_write(ring, ib->length_dw);
+	amdgpu_ring_write(ring, lower_32_bits(csa_mc_addr));
+	amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));
+}
+
+/**
+ * lsdma_v6_0_ring_emit_fence - emit a fence on the DMA ring
+ *
+ * @ring: amdgpu ring pointer
+ * @addr: address
+ * @seq: fence seq number
+ * @flags: fence flags
+ *
+ * Add a DMA fence packet to the ring to write
+ * the fence seq number and DMA trap packet to generate
+ * an interrupt if needed.
+ */
+static void lsdma_v6_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
+				      unsigned flags)
+{
+	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
+	/* write the fence */
+	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_FENCE) |
+			  SDMA_PKT_FENCE_HEADER_MTYPE(0x3)); /* Ucached(UC) */
+	/* zero in first two bits */
+	BUG_ON(addr & 0x3);
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write(ring, lower_32_bits(seq));
+
+	/* optionally write high bits as well */
+	if (write64bit) {
+		addr += 4;
+		amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_FENCE) |
+				  SDMA_PKT_FENCE_HEADER_MTYPE(0x3));
+		/* zero in first two bits */
+		BUG_ON(addr & 0x3);
+		amdgpu_ring_write(ring, lower_32_bits(addr));
+		amdgpu_ring_write(ring, upper_32_bits(addr));
+		amdgpu_ring_write(ring, upper_32_bits(seq));
+	}
+
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
+		uint32_t ctx = ring->is_mes_queue ?
+			(ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0;
+		/* generate an interrupt */
+		amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_TRAP));
+		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(ctx));
+	}
+}
+/**
+ * lsdma_v6_0_ring_emit_hdp_flush - emit an hdp flush on the DMA ring
+ *
+ * @ring: amdgpu ring pointer
+ *
+ * Emit an hdp flush packet on the requested DMA ring.
+ */
+static void lsdma_v6_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 ref_and_mask = 0;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
+
+	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
+			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
+	amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_done_offset(adev)) << 2);
+	amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_req_offset(adev)) << 2);
+	amdgpu_ring_write(ring, ref_and_mask); /* reference */
+	amdgpu_ring_write(ring, ref_and_mask); /* mask */
+	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
+			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10)); /* retry count, poll interval */
+}
+
+/*
+ * lsdma_v6_0_ring_emit_vm_flush - vm flush using sDMA
+ *
+ * @ring: amdgpu_ring pointer
+ * @vmid: vmid number to use
+ * @pd_addr: address
+ *
+ * Update the page table base and flush the VM TLB
+ * using sDMA.
+ */
+static void lsdma_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
+					 unsigned vmid, uint64_t pd_addr)
+{
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+
+	/* Update the PD address for this VMID. */
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	/* Trigger invalidation. */
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(ring->vm_inv_eng) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(0x1f));
+	amdgpu_ring_write(ring, req);
+	amdgpu_ring_write(ring, 0xFFFFFFFF);
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
+}
+
+static int lsdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	unsigned i;
+	unsigned index;
+	int r;
+	u32 tmp;
+	u64 gpu_addr;
+	volatile uint32_t *cpu_ptr = NULL;
+
+	tmp = 0xCAFEDEAD;
+
+	if (ring->is_mes_queue) {
+		uint32_t offset = 0;
+		offset = amdgpu_mes_ctx_get_offs(ring,
+					 AMDGPU_MES_CTX_PADDING_OFFS);
+		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		*cpu_ptr = tmp;
+	} else {
+		r = amdgpu_device_wb_get(adev, &index);
+		if (r) {
+			dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
+			return r;
+		}
+
+		gpu_addr = adev->wb.gpu_addr + (index * 4);
+		adev->wb.wb[index] = cpu_to_le32(tmp);
+	}
+
+	r = amdgpu_ring_alloc(ring, 5);
+	if (r) {
+		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
+		amdgpu_device_wb_free(adev, index);
+		return r;
+	}
+
+	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
+			  SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR));
+	amdgpu_ring_write(ring, lower_32_bits(gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(gpu_addr));
+	amdgpu_ring_write(ring, SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0));
+	amdgpu_ring_write(ring, 0xabcdef12);
+	amdgpu_ring_commit(ring);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (ring->is_mes_queue)
+			tmp = le32_to_cpu(*cpu_ptr);
+		else
+			tmp = le32_to_cpu(adev->wb.wb[index]);
+		if (tmp == 0xabcdef12)
+			break;
+		if (amdgpu_emu_mode == 1)
+			msleep(1);
+		else
+			udelay(1);
+	}
+
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+
+	if (!ring->is_mes_queue)
+		amdgpu_device_wb_free(adev, index);
+
+	return r;
+}
+
+
+/*
+ * lsdma_v6_0_ring_test_ib - test an IB on the DMA engine
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @timeout: timeout value in jiffies, or MAX_SCHEDULE_TIMEOUT
+ *
+ * Test a simple IB in the DMA ring.
+ * Returns 0 on success, error on failure.
+ */
+static int lsdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ib ib;
+	struct dma_fence *f = NULL;
+	unsigned index;
+	long r;
+	u32 tmp = 0;
+	u64 gpu_addr;
+	volatile uint32_t *cpu_ptr = NULL;
+
+	tmp = 0xCAFEDEAD;
+	memset(&ib, 0, sizeof(ib));
+
+	if (ring->is_mes_queue) {
+		uint32_t offset = 0;
+		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
+		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+
+		offset = amdgpu_mes_ctx_get_offs(ring,
+					 AMDGPU_MES_CTX_PADDING_OFFS);
+		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		*cpu_ptr = tmp;
+	} else {
+		r = amdgpu_device_wb_get(adev, &index);
+		if (r) {
+			dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
+			return r;
+		}
+
+		gpu_addr = adev->wb.gpu_addr + (index * 4);
+		adev->wb.wb[index] = cpu_to_le32(tmp);
+
+		r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+		if (r) {
+			DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+			goto err0;
+		}
+	}
+
+	ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
+		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
+	ib.ptr[1] = lower_32_bits(gpu_addr);
+	ib.ptr[2] = upper_32_bits(gpu_addr);
+	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+	ib.ptr[4] = 0xfeffe123;
+	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib.length_dw = 8;
+
+	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
+	if (r)
+		goto err1;
+
+	r = dma_fence_wait_timeout(f, false, timeout);
+	if (r == 0) {
+		DRM_ERROR("amdgpu: IB test timed out\n");
+		r = -ETIMEDOUT;
+		goto err1;
+	} else if (r < 0) {
+		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
+		goto err1;
+	}
+
+	if (ring->is_mes_queue)
+		tmp = le32_to_cpu(*cpu_ptr);
+	else
+		tmp = le32_to_cpu(adev->wb.wb[index]);
+
+	if (tmp == 0xfeffe123) {
+		r = 0;
+	} else {
+		r = -EINVAL;
+	}
+
+err1:
+	amdgpu_ib_free(adev, &ib, NULL);
+	dma_fence_put(f);
+err0:
+	if (!ring->is_mes_queue)
+		amdgpu_device_wb_free(adev, index);
+	return r;
+}
+
+static void lsdma_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
+				     uint32_t reg, uint32_t val)
+{
+	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_SRBM_WRITE) |
+			  SDMA_PKT_SRBM_WRITE_HEADER_BYTE_EN(0xf));
+	amdgpu_ring_write(ring, reg);
+	amdgpu_ring_write(ring, val);
+}
+
+static void lsdma_v6_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+					 uint32_t val, uint32_t mask)
+{
+	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
+			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* equal */
+	amdgpu_ring_write(ring, reg << 2);
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, val); /* reference */
+	amdgpu_ring_write(ring, mask); /* mask */
+	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
+			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10));
+}
+
+static void lsdma_v6_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
+						   uint32_t reg0, uint32_t reg1,
+						   uint32_t ref, uint32_t mask)
+{
+	amdgpu_ring_emit_wreg(ring, reg0, ref);
+	/* wait for a cycle to reset vm_inv_eng*_ack */
+	amdgpu_ring_emit_reg_wait(ring, reg0, 0, 0);
+	amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
+}
+
+
+static unsigned lsdma_v6_0_ring_init_cond_exec(struct amdgpu_ring *ring)
+{
+	unsigned ret;
+
+	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_COND_EXE));
+	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
+	amdgpu_ring_write(ring, 1);
+	ret = ring->wptr & ring->buf_mask;/* this is the offset we need patch later */
+	amdgpu_ring_write(ring, 0x55aa55aa);/* insert dummy here and patch it later */
+
+	return ret;
+}
+
+
+static void lsdma_v6_0_ring_patch_cond_exec(struct amdgpu_ring *ring,
+					   unsigned offset)
+{
+	unsigned cur;
+
+	BUG_ON(offset > ring->buf_mask);
+	BUG_ON(ring->ring[offset] != 0x55aa55aa);
+
+	cur = (ring->wptr - 1) & ring->buf_mask;
+	if (cur > offset)
+		ring->ring[offset] = cur - offset;
+	else
+		ring->ring[offset] = (ring->buf_mask + 1) - offset + cur;
+}
+
+static int lsdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
+{
+	int i, r = 0;
+	struct amdgpu_device *adev = ring->adev;
+
+	/* assert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, false);
+
+	/* emit the trailing fence */
+	ring->trail_seq += 1;
+	amdgpu_ring_alloc(ring, 10);
+	lsdma_v6_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
+				  ring->trail_seq, 0);
+	amdgpu_ring_commit(ring);
+
+	/* assert IB preemption */
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_PREEMPT, 1);
+
+	/* poll the trailing fence */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (ring->trail_seq ==
+		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		r = -EINVAL;
+		DRM_ERROR("ring %d failed to be preempted\n", ring->idx);
+	}
+
+	/* deassert IB preemption */
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_PREEMPT, 0);
+
+	/* deassert the preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, true);
+	return r;
+}
+
+/*
+ * lsdma_v6_0_ring_pad_ib - pad the IB
+ * @ib: indirect buffer to fill with padding
+ * @ring: amdgpu ring pointer
+ *
+ * Pad the IB with NOPs to a boundary multiple of 8.
+ */
+static void lsdma_v6_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
+{
+	struct amdgpu_lsdma *lsdma = &ring->adev->lsdma;
+	u32 pad_count;
+	int i;
+
+	pad_count = (-ib->length_dw) & 0x7;
+	for (i = 0; i < pad_count; i++)
+		if (lsdma->burst_nop && (i == 0))
+			ib->ptr[ib->length_dw++] =
+				SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_NOP) |
+				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
+		else
+			ib->ptr[ib->length_dw++] =
+				SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_NOP);
+}
+
+/**
+ * lsdma_v6_0_ring_emit_pipeline_sync - sync the pipeline
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Make sure all previous operations are completed (CIK).
+ */
+static void lsdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+{
+	uint32_t seq = ring->fence_drv.sync_seq;
+	uint64_t addr = ring->fence_drv.gpu_addr;
+
+	/* wait for idle */
+	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
+			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3) | /* equal */
+			  SDMA_PKT_POLL_REGMEM_HEADER_MEM_POLL(1));
+	amdgpu_ring_write(ring, addr & 0xfffffffc);
+	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
+	amdgpu_ring_write(ring, seq); /* reference */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
+	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
+			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
+}
+
+
+
+
+static const struct amdgpu_ring_funcs lsdma_v6_0_ring_funcs = {
+	.type = AMDGPU_RING_TYPE_LSDMA,
+	.align_mask = 0xf,
+	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
+	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
+	.get_rptr = lsdma_v6_0_ring_get_rptr,
+	.get_wptr = lsdma_v6_0_ring_get_wptr,
+	.set_wptr = lsdma_v6_0_ring_set_wptr,
+	.emit_frame_size =
+		5 + /* sdma_v6_0_ring_init_cond_exec */
+		6 + /* sdma_v6_0_ring_emit_hdp_flush */
+		6 + /* sdma_v6_0_ring_emit_pipeline_sync */
+		/* sdma_v6_0_ring_emit_vm_flush */
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
+		10 + 10 + 10, /* sdma_v6_0_ring_emit_fence x3 for user fence, vm fence */
+	.emit_ib_size = 5 + 7 + 6, /* sdma_v6_0_ring_emit_ib */
+	.emit_ib = lsdma_v6_0_ring_emit_ib,
+	.emit_fence = lsdma_v6_0_ring_emit_fence,
+	.emit_pipeline_sync = lsdma_v6_0_ring_emit_pipeline_sync,
+	.emit_vm_flush = lsdma_v6_0_ring_emit_vm_flush,
+	.emit_hdp_flush = lsdma_v6_0_ring_emit_hdp_flush,
+	.test_ring = lsdma_v6_0_ring_test_ring,
+	.test_ib = lsdma_v6_0_ring_test_ib,
+	.insert_nop = lsdma_v6_0_ring_insert_nop,
+	.pad_ib = lsdma_v6_0_ring_pad_ib,
+	.emit_wreg = lsdma_v6_0_ring_emit_wreg,
+	.emit_reg_wait = lsdma_v6_0_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = lsdma_v6_0_ring_emit_reg_write_reg_wait,
+	.init_cond_exec = lsdma_v6_0_ring_init_cond_exec,
+	.patch_cond_exec = lsdma_v6_0_ring_patch_cond_exec,
+	.preempt_ib = lsdma_v6_0_ring_preempt_ib,
+};
+
+static void lsdma_v6_0_set_ring_funcs(struct amdgpu_device *adev)
+{
+	adev->lsdma.ring.funcs = &lsdma_v6_0_ring_funcs;
+}
+
+static int lsdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned type,
+					enum amdgpu_interrupt_state state)
+{
+	u32 lsdma_int_cntl;
+
+
+	if (!amdgpu_sriov_vf(adev)) {
+		lsdma_int_cntl = RREG32_SOC15(LSDMA, 0, regLSDMA_INT_CNTL);
+		lsdma_int_cntl = REG_SET_FIELD(lsdma_int_cntl, LSDMA_INT_CNTL, TRAP_INT_ENABLE,
+				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		WREG32_SOC15(LSDMA, 0, regLSDMA_INT_CNTL, lsdma_int_cntl);
+	}
+
+	return 0;
+}
+
+static int lsdma_v6_0_process_trap_irq(struct amdgpu_device *adev,
+				      struct amdgpu_irq_src *source,
+				      struct amdgpu_iv_entry *entry)
+{
+	int queue;
+	uint32_t mes_queue_id = entry->src_data[0];
+
+	DRM_DEBUG("IH: LSDMA trap, client_id %d, src_id %d, ring_id %d,\
+			vmid %d, mes_queue_id %d\n", entry->client_id, entry->src_id,
+			entry->ring_id, entry->vmid, mes_queue_id);
+
+	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
+		struct amdgpu_mes_queue *queue;
+
+		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
+
+		spin_lock(&adev->mes.queue_id_lock);
+		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
+		if (queue) {
+			DRM_DEBUG("process lsmda queue id = %d\n", mes_queue_id);
+			amdgpu_fence_process(queue->ring);
+		}
+		spin_unlock(&adev->mes.queue_id_lock);
+		return 0;
+	}
+
+	queue = entry->ring_id & 0xf;
+
+	switch (entry->client_id) {
+	case SOC21_IH_CLIENTID_LSDMA:
+		switch (queue) {
+		case 0:
+			amdgpu_fence_process(&adev->lsdma.ring);
+			break;
+		default:
+			break;
+		}
+		break;
+	}
+	return 0;
+}
+
+
+static const struct amdgpu_irq_src_funcs lsdma_v6_0_trap_irq_funcs = {
+	.set = lsdma_v6_0_set_trap_irq_state,
+	.process = lsdma_v6_0_process_trap_irq,
+};
+
+static void lsdma_v6_0_set_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->lsdma.trap_irq.num_types = 1;
+	adev->lsdma.trap_irq.funcs = &lsdma_v6_0_trap_irq_funcs;
+}
+
+/**
+ * lsdma_v6_0_vm_copy_pte - update PTEs by copying them from the GART
+ *
+ * @ib: indirect buffer to fill with commands
+ * @pe: addr of the page entry
+ * @src: src addr to copy from
+ * @count: number of page entries to update
+ *
+ * Update PTEs by copying them from the GART using sDMA.
+ */
+static void lsdma_v6_0_vm_copy_pte(struct amdgpu_ib *ib,
+				  uint64_t pe, uint64_t src,
+				  unsigned count)
+{
+	unsigned bytes = count * 8;
+
+	ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_COPY) |
+		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR);
+	ib->ptr[ib->length_dw++] = bytes - 1;
+	ib->ptr[ib->length_dw++] = 0; /* src/dst endian swap */
+	ib->ptr[ib->length_dw++] = lower_32_bits(src);
+	ib->ptr[ib->length_dw++] = upper_32_bits(src);
+	ib->ptr[ib->length_dw++] = lower_32_bits(pe);
+	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
+
+}
+
+/**
+ * lsdma_v6_0_vm_write_pte - update PTEs by writing them manually
+ *
+ * @ib: indirect buffer to fill with commands
+ * @pe: addr of the page entry
+ * @value: dst addr to write into pe
+ * @count: number of page entries to update
+ * @incr: increase next addr by incr bytes
+ *
+ * Update PTEs by writing them manually using sDMA.
+ */
+static void lsdma_v6_0_vm_write_pte(struct amdgpu_ib *ib, uint64_t pe,
+				   uint64_t value, unsigned count,
+				   uint32_t incr)
+{
+	unsigned ndw = count * 2;
+
+	ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
+		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
+	ib->ptr[ib->length_dw++] = lower_32_bits(pe);
+	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
+	ib->ptr[ib->length_dw++] = ndw - 1;
+	for (; ndw > 0; ndw -= 2) {
+		ib->ptr[ib->length_dw++] = lower_32_bits(value);
+		ib->ptr[ib->length_dw++] = upper_32_bits(value);
+		value += incr;
+	}
+}
+
+/**
+ * sdma_v6_0_vm_set_pte_pde - update the page tables using sDMA
+ *
+ * @ib: indirect buffer to fill with commands
+ * @pe: addr of the page entry
+ * @addr: dst addr to write into pe
+ * @count: number of page entries to update
+ * @incr: increase next addr by incr bytes
+ * @flags: access flags
+ *
+ * Update the page tables using sDMA.
+ */
+static void lsdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
+				     uint64_t pe,
+				     uint64_t addr, unsigned count,
+				     uint32_t incr, uint64_t flags)
+{
+	/* for physically contiguous pages (vram) */
+	ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_PTEPDE);
+	ib->ptr[ib->length_dw++] = lower_32_bits(pe); /* dst addr */
+	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
+	ib->ptr[ib->length_dw++] = lower_32_bits(flags); /* mask */
+	ib->ptr[ib->length_dw++] = upper_32_bits(flags);
+	ib->ptr[ib->length_dw++] = lower_32_bits(addr); /* value */
+	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
+	ib->ptr[ib->length_dw++] = incr; /* increment size */
+	ib->ptr[ib->length_dw++] = 0;
+	ib->ptr[ib->length_dw++] = count - 1; /* number of entries */
+}
+
+static const struct amdgpu_vm_pte_funcs lsdma_v6_0_vm_pte_funcs = {
+	.copy_pte_num_dw = 7,
+	.copy_pte = lsdma_v6_0_vm_copy_pte,
+	.write_pte = lsdma_v6_0_vm_write_pte,
+	.set_pte_pde = lsdma_v6_0_vm_set_pte_pde,
+};
+
+
+static void lsdma_v6_0_set_vm_pte_funcs(struct amdgpu_device *adev)
+{
+	adev->vm_manager.vm_pte_funcs = &lsdma_v6_0_vm_pte_funcs;
+	adev->vm_manager.vm_pte_scheds[0] = &adev->lsdma.ring.sched;
+	adev->vm_manager.vm_pte_num_scheds = 1;
+}
+
+static int lsdma_v6_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+
+	lsdma_v6_0_set_ring_funcs(adev);
+	lsdma_v6_0_set_buffer_funcs(adev);
+	lsdma_v6_0_set_vm_pte_funcs(adev);
+	lsdma_v6_0_set_irq_funcs(adev);
+
+	return 0;
+}
+
+static int lsdma_v6_0_sw_init(void *handle)
+{
+	struct amdgpu_ring *ring;
+	int r, i;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	/* SDMA trap event */
+	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_LSDMA,
+			      GFX_11_0_0__SRCID__LSDMA_TRAP,
+			      &adev->lsdma.trap_irq);
+	if (r)
+		return r;
+
+	ring = &adev->lsdma.ring;
+	ring->ring_obj = NULL;
+	ring->use_doorbell = false;
+
+	DRM_INFO("LSDMA %d use_doorbell being set to: [%s]\n", i,
+			ring->use_doorbell?"true":"false");
+
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+	sprintf(ring->name, "lsdma");
+	r = amdgpu_ring_init(adev, ring, 1024, &adev->lsdma.trap_irq,
+			     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		return r;
+
+	return r;
+}
+
+static int lsdma_v6_0_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+
+	amdgpu_ring_fini(&adev->lsdma.ring);
+
+	amdgpu_lsdma_destroy_inst_ctx(adev);
+
+	return 0;
+}
+
+
+/**
+ * lsdma_v6_0_gfx_resume - setup and start the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set up the gfx DMA ring buffers and enable them.
+ * Returns 0 for success, error for failure.
+ */
+static int lsdma_v6_0_gfx_resume(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	u32 rb_cntl, ib_cntl;
+	u32 rb_bufsz;
+	u32 doorbell;
+	u32 doorbell_offset;
+	int r;
+
+	ring = &adev->lsdma.ring;
+
+	if (!amdgpu_sriov_vf(adev))
+		WREG32_SOC15(LSDMA, 0, regLSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
+
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = RREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_CNTL);
+	rb_cntl = REG_SET_FIELD(rb_cntl, LSDMA_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
+#ifdef __BIG_ENDIAN
+	rb_cntl = REG_SET_FIELD(rb_cntl, LSDMA_QUEUE0_RB_CNTL, RB_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, LSDMA_QUEUE0_RB_CNTL,
+				RPTR_WRITEBACK_SWAP_ENABLE, 1);
+#endif
+	rb_cntl = REG_SET_FIELD(rb_cntl, LSDMA_QUEUE0_RB_CNTL, RB_PRIV, 1);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_CNTL, rb_cntl);
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_WPTR_POLL_ADDR_LO, lower_32_bits(ring->wptr_gpu_addr));
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_WPTR_POLL_ADDR_HI, upper_32_bits(ring->wptr_gpu_addr));
+
+	/* set the wb address whether it's enabled or not */
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_RPTR_ADDR_HI, upper_32_bits(ring->rptr_gpu_addr));
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_RPTR_ADDR_LO, lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+
+	rb_cntl = REG_SET_FIELD(rb_cntl, LSDMA_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_BASE, ring->gpu_addr >> 8);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_BASE_HI, ring->gpu_addr >> 40);
+
+	ring->wptr = 0;
+
+	/* before programing wptr to a less value, need set minor_ptr_update first */
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_MINOR_PTR_UPDATE, 1);
+
+	if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
+		WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_WPTR, lower_32_bits(ring->wptr) << 2);
+		WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_WPTR_HI, upper_32_bits(ring->wptr) << 2);
+	}
+
+	doorbell = RREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_DOORBELL);
+	doorbell_offset = RREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_DOORBELL_OFFSET);
+
+	if (ring->use_doorbell) {
+		doorbell = REG_SET_FIELD(doorbell, LSDMA_QUEUE0_DOORBELL, ENABLE, 1);
+		doorbell_offset = REG_SET_FIELD(doorbell_offset, LSDMA_QUEUE0_DOORBELL_OFFSET,
+				OFFSET, ring->doorbell_index);
+	} else {
+		doorbell = REG_SET_FIELD(doorbell, LSDMA_QUEUE0_DOORBELL, ENABLE, 0);
+	}
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_DOORBELL, doorbell);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_DOORBELL_OFFSET, doorbell_offset);
+
+
+	if (amdgpu_sriov_vf(adev))
+		lsdma_v6_0_ring_set_wptr(ring);
+
+	/* set minor_ptr_update to 0 after wptr programed */
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_MINOR_PTR_UPDATE, 0);
+
+	/* enable DMA RB */
+	rb_cntl = REG_SET_FIELD(rb_cntl, LSDMA_QUEUE0_RB_CNTL, RB_ENABLE, 1);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_RB_CNTL, rb_cntl);
+
+	ib_cntl = RREG32_SOC15_IP(LSDMA, regLSDMA_QUEUE0_IB_CNTL);
+	ib_cntl = REG_SET_FIELD(ib_cntl, LSDMA_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+#ifdef __BIG_ENDIAN
+	ib_cntl = REG_SET_FIELD(ib_cntl, LSDMA_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
+#endif
+	/* enable DMA IBs */
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_IB_CNTL, ib_cntl);
+
+	if (amdgpu_sriov_vf(adev))
+		lsdma_v6_0_enable(adev, true);
+
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+
+	if (adev->mman.buffer_funcs_ring == ring)
+		amdgpu_ttm_set_buffer_funcs_status(adev, true);
+
+	adev->lsdma.burst_nop = true;
+
+	return 0;
+}
+
+/**
+ * sdma_v6_0_start - setup and start the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set up the DMA engines and enable them.
+ * Returns 0 for success, error for failure.
+ */
+static int lsdma_v6_0_start(struct amdgpu_device *adev)
+{
+	int r;
+
+	lsdma_v6_0_ctxempty_int_enable(adev, true);
+
+	/* start the gfx rings and rlc compute queues */
+	r = lsdma_v6_0_gfx_resume(adev);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int lsdma_v6_0_hw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return lsdma_v6_0_start(adev);
+}
+
+static int lsdma_v6_0_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* disable the scheduler for SDMA */
+		amdgpu_lsdma_unset_buffer_funcs_helper(adev);
+		return 0;
+	}
+
+	lsdma_v6_0_ctxempty_int_enable(adev, false);
+	lsdma_v6_0_enable(adev, false);
+
+	return 0;
+}
+
+static int lsdma_v6_0_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return lsdma_v6_0_hw_fini(adev);
+}
+
+static int lsdma_v6_0_resume(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return lsdma_v6_0_hw_init(adev);
+}
+
+static bool lsdma_v6_0_is_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	u32 tmp;
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_STATUS_REG);
+	if (!(tmp & LSDMA_STATUS_REG__IDLE_MASK))
+			return false;
+
+	return true;
+}
+
+static int lsdma_v6_0_wait_for_idle(void *handle)
+{
+	unsigned i;
+	u32 tmp;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_STATUS_REG);
+
+		if (tmp & LSDMA_STATUS_REG__IDLE_MASK)
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static int lsdma_v6_0_soft_reset(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	u32 tmp;
+
+	lsdma_v6_0_gfx_stop(adev);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_FREEZE);
+	tmp |= LSDMA_FREEZE__FREEZE_MASK;
+	WREG32_SOC15(LSDMA, 0, regLSDMA_FREEZE, tmp);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_F32_CNTL);
+	tmp |= LSDMA_F32_CNTL__HALT_MASK;
+	tmp |= LSDMA_F32_CNTL__RESET_MASK;
+	WREG32_SOC15(LSDMA, 0, regLSDMA_F32_CNTL, tmp);
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_QUEUE0_PREEMPT, 0);
+
+	udelay(100);
+
+	return lsdma_v6_0_start(adev);
+}
+
+static bool lsdma_v6_0_check_soft_reset(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring;
+	int r;
+	long tmo = msecs_to_jiffies(1000);
+
+	ring = &adev->lsdma.ring;
+	r = amdgpu_ring_test_ib(ring, tmo);
+	if (r)
+		return true;
+
+	return false;
+}
+
+static int lsdma_v6_0_set_clockgating_state(void *handle,
+					   enum amd_clockgating_state state)
+{
+	return 0;
+}
+
+static int lsdma_v6_0_set_powergating_state(void *handle,
+					  enum amd_powergating_state state)
+{
+	return 0;
+}
+
+static void lsdma_v6_0_get_clockgating_state(void *handle, u64 *flags)
+{
+}
+
+
+const struct amd_ip_funcs lsdma_v6_0_ip_funcs = {
+	.name = "lsdma_v6_0",
+	.early_init = lsdma_v6_0_early_init,
+	.late_init = NULL,
+	.sw_init = lsdma_v6_0_sw_init,
+	.sw_fini = lsdma_v6_0_sw_fini,
+	.hw_init = lsdma_v6_0_hw_init,
+	.hw_fini = lsdma_v6_0_hw_fini,
+	.suspend = lsdma_v6_0_suspend,
+	.resume = lsdma_v6_0_resume,
+	.is_idle = lsdma_v6_0_is_idle,
+	.wait_for_idle = lsdma_v6_0_wait_for_idle,
+	.soft_reset = lsdma_v6_0_soft_reset,
+	.check_soft_reset = lsdma_v6_0_check_soft_reset,
+	.set_clockgating_state = lsdma_v6_0_set_clockgating_state,
+	.set_powergating_state = lsdma_v6_0_set_powergating_state,
+	.get_clockgating_state = lsdma_v6_0_get_clockgating_state,
+};
+
+const struct amdgpu_ip_block_version lsdma_v6_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_LSDMA,
+	.major = 6,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &lsdma_v6_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h
index 3ef79be1a9bf..c6940bf0914e 100644
--- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h
@@ -24,8 +24,7 @@
 #ifndef __LSDMA_V6_0_H__
 #define __LSDMA_V6_0_H__
 
-#include "soc15_common.h"
-
 extern const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs;
+extern const struct amdgpu_ip_block_version lsdma_v6_0_ip_block;
 
 #endif /* __LSDMA_V6_0_H__ */
-- 
2.37.3


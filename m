Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39097C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 12:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA1610EB8C;
	Fri, 11 Apr 2025 12:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LIAp5qZ3";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E574710EB8C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 12:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFcPUPIK64XdWnF7tsN98xR71B60+fcOpfLH5hmTf/W+nJhm1zyLrNCoHlVLuRbUSgd39tnoweKd3tnVDQgNuQvknW+TDfb7OWKVBdEfaP70pajfvEZWp9MLeCB1g0Qw4d6gcubnScMArfDfRtkT7LVoxKwrQyMcR05v7ZHwLID1jTcOaxBBoVf+aA8f4ZZv8dr4sidvYbr+xwp47leKY5+0rviRZNzVtDTKUm5h4ScnIyW11/uG5H+iwMejmXm4owiW4dXQMNLx1zwoyeLgyxDAH3ZtcFoF9fB04R3FoKcvQ/xO5vM3B40zjQSUFET7i6oVCSWO0W9NbGfkj2Qc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn9TKtc1vwnV1pTsqCkeRVBqApUgNmQ2cbW63zVk3zs=;
 b=NTQCO7/srnmqs/iPLX6OMm56Qjdqv+ApM2QeDeGum2BoDVmnW6KzewJfLDEvJzt3MYvpgjZ3fjrmyiQJ5XEFfnrpF6zSBIdfWM6Dfq1v4q4zK2Sw7otecXuMg6AZn/ffbIRbrYthOXsqfWIbjGLdr5MJSWzDy3KTYsAa+EHqMJhJPi9YqxgjC2oTaAPbxtwlUPTN5NW+ONMmrr9Iomb8AXQXOUsQFBsQwxDYnZ8D9q1W3HdMQqROJSWnPG6Z/Z3nXnBCxVpU7cl7MZmwGSGwVVCLiF4lvPcKNgocV9u8jg30hyCfMuaOApoe+7MQMgdE7u7j2LkmpHIlFuhMh8rVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn9TKtc1vwnV1pTsqCkeRVBqApUgNmQ2cbW63zVk3zs=;
 b=LIAp5qZ3bc5oJ337xYokWn17U1C+CE8U5GPqyhHyo3shwaRSIbrIVIJtWtGTYjk+vFs1d0ciBO9rDtezGF9ZAZICGePcBzHU/yw1UyzSO4DCsz1ensHi879ffyesHuB1cpimjnlllHMhDeEGX9YiRgVnz2AGjcjSyF0IdIaqoYE=
Received: from BYAPR07CA0085.namprd07.prod.outlook.com (2603:10b6:a03:12b::26)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 12:15:43 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:12b:cafe::51) by BYAPR07CA0085.outlook.office365.com
 (2603:10b6:a03:12b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 12:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 12:15:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 07:15:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use generic hdp flush function
Date: Fri, 11 Apr 2025 17:45:23 +0530
Message-ID: <20250411121524.589317-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: af16e404-b410-46d2-8d2e-08dd78f294bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MgC3Qr9moSQIxh1nlOdw2wRi0D4m56ZHxcDOHT//Iq+jwQW1fdo+y8NnmisN?=
 =?us-ascii?Q?6SxU9rbqZVrqT83Qnv/QLCm/2HsSI8IugRV1lKN76s3EQbTBh08jF3AJS0Az?=
 =?us-ascii?Q?lNYtV1tygUVE0ir6OcCwQGGCQbfs6G/6p/UZU7bZaTDIOt9xOitIFGLy6Lug?=
 =?us-ascii?Q?IkL0tBlH6aCbJH1BL0cB2Kr0+ejh1nyJJj/rVX3JT94Oaw4p75PuZmNGhN0L?=
 =?us-ascii?Q?g/DG0UEXaG0wSWEFL0Uq+Gf4rT2Tu13g5vgUkaObq3gB/umqwQHHevMuTIKe?=
 =?us-ascii?Q?Gngw5XzA0HDTslnBoiNulPs4wseE3JQmrs7h78yBf5m8QLVrQCkDgSncPe6B?=
 =?us-ascii?Q?+we2dNvJHKNFQlq7EtXJPUzhHYKOYwL+rvRc9vGyWtBRll9ZjBX51j90YPL3?=
 =?us-ascii?Q?kywBked1SkxGWELWuprsRjCaG4AdWl7vUupHcEY8iLeO/X5S/lqck+8nYcF2?=
 =?us-ascii?Q?tX5936Q5BLfjafJUwTKSfAxq6F3oXAV92s+GQ01Ed6o5lEQm6j7C48JiisNI?=
 =?us-ascii?Q?LmFq2vaEO6PIi7H6Mm5ZG0vt/z7W9K0mJ+nxFdJStslTRrlkdjtYsi7rieGb?=
 =?us-ascii?Q?P++xx2F2Y0CmQJlkdIPGIOQppnPZXT7TKpQOE6DE3lFKnFog+6hpArcA2WAU?=
 =?us-ascii?Q?RwEMvwevpekziyHvc0sWsu36QOVWMrHNu5tADtckuEh3rdVj8QEldHwoIfIF?=
 =?us-ascii?Q?/jcmI4DCzisb62ja4GLX9+XMlOvEuO2ljyCNdRRNeg5Yz/j/goD2LgrYNLNJ?=
 =?us-ascii?Q?iBxjX2mVgtFTYp5gdvgA/TgCa3h76pwOHIL0+i/Vh17YDM1lkr7tnWpvQ2Wp?=
 =?us-ascii?Q?B1vKUYIDrDt4p5OA/06L4wko93ZaKQnAIcVDl1vpUhVrm3KMaKyD9K71/9LH?=
 =?us-ascii?Q?t6B6aAK8KvEcY0f/vrftXBznVAyM+qmklbA3vSL4hXxSh/aVnzMsHyj6MG8H?=
 =?us-ascii?Q?8fl6xUAnt8FWB6Aq4YtkeUxmlCCysEViqLaQM/G5jSnplxZ3In+N1iTP2WJH?=
 =?us-ascii?Q?4wHmGc38poVYRllzGB90O2i3fbI06lGz2EaeUNo1XvNPZh0YaTKXB2CxlFCT?=
 =?us-ascii?Q?AWzRk/GkUT1vu59o/GptUfSiYePFsl3YQ08XisqlyHP010gk65eIyCTTH1ko?=
 =?us-ascii?Q?HYJ7laQcj9tFpZU8oP7OFGzP8U/sL8xUx5hmV2sH/7QmXeHYAFoxCw+SDWS1?=
 =?us-ascii?Q?5P97mV3z2EevcstAjBOXmg/eqY67twYpHpPlvc5KsuTlIuA56ArhfBIAX+xF?=
 =?us-ascii?Q?qZBZ7+72Wd8laY3PpqQSw1dhviU6+pUrtqONcZ4HAZ4WRnDvoajg4H2UXecY?=
 =?us-ascii?Q?1lPFcFVImoHgj5oqDQcg/P2H3vTf5Bnn85ELzLf315dSyNdD9TcALMKuD3qv?=
 =?us-ascii?Q?rehKgFEt/eD0ELVvYGpQpsOEiWOgKdNfQtwK8nSRQgnjAneY2wwzLKLW0LUE?=
 =?us-ascii?Q?qB0UBa3wcg32yznflbw/sipezSjL2XMgn9cVZv+4C2sZWCrQ3QdaY65CXRyW?=
 =?us-ascii?Q?+ePkx+Ndc98XwyG0ehqAWzJ2GmAWDKDSDhgH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:15:42.7878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af16e404-b410-46d2-8d2e-08dd78f294bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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

Except HDP v5.2 all use a common logic for HDP flush. Use a generic
function. HDP v5.2 forces NO_KIQ logic, revisit it later.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 13 +------------
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c   | 13 +------------
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c   | 13 +------------
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c   | 13 +------------
 6 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index b6cf801939aa..7fd8f09c28e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 {
@@ -46,3 +47,23 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 	/* hdp ras follows amdgpu_ras_block_late_init_default for late init */
 	return 0;
 }
+
+void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
+			      struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset +
+			KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
+			       2,
+		       0);
+		RREG32((adev->rmmio_remap.reg_offset +
+			KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
+		       2);
+	} else {
+		amdgpu_ring_emit_wreg(ring,
+				      (adev->rmmio_remap.reg_offset +
+				       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
+					      2,
+				      0);
+	}
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 7b8a6152dc8d..4cfd932b7e91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -44,4 +44,6 @@ struct amdgpu_hdp {
 };
 
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
+void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
+			      struct amdgpu_ring *ring);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index f1dc13b3ab38..e6c0d86d3486 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -36,17 +36,6 @@
 #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK     0x00020000L
 #define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
 
-static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
@@ -180,7 +169,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 };
 
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
-	.flush_hdp = hdp_v4_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
 	.update_clock_gating = hdp_v4_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v4_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index 43195c079748..8bc001dc9f63 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -27,17 +27,6 @@
 #include "hdp/hdp_5_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
-static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
@@ -217,7 +206,7 @@ static void hdp_v5_0_init_registers(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_hdp_funcs hdp_v5_0_funcs = {
-	.flush_hdp = hdp_v5_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.invalidate_hdp = hdp_v5_0_invalidate_hdp,
 	.update_clock_gating = hdp_v5_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v5_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index a88d25a06c29..ec20daf4272c 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -30,17 +30,6 @@
 #define regHDP_CLK_CNTL_V6_1	0xd5
 #define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
 
-static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
@@ -149,7 +138,7 @@ static void hdp_v6_0_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 const struct amdgpu_hdp_funcs hdp_v6_0_funcs = {
-	.flush_hdp = hdp_v6_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.update_clock_gating = hdp_v6_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v6_0_get_clockgating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index 49f7eb4fbd11..ed1debc03507 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -27,17 +27,6 @@
 #include "hdp/hdp_7_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
-static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
@@ -137,7 +126,7 @@ static void hdp_v7_0_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 const struct amdgpu_hdp_funcs hdp_v7_0_funcs = {
-	.flush_hdp = hdp_v7_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.update_clock_gating = hdp_v7_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v7_0_get_clockgating_state,
 };
-- 
2.25.1


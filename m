Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8C5C5478C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 06:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B052D112893;
	Tue,  5 Mar 2024 06:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L6yGYPDi";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40471112893
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 06:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MffZVcMzKS+N36gAmyG7croUY2MQabXKgT5Q2Lr+tUQSpr2Dx2YwWFNVJLwOw5a1JGAPpNtldZeN5oBK1tofAoSR/FCwSs0hXjOeqLwB1J4Q11olfBKTSb7XZ0T9BVCeM240CHgFE56gfC5Z/RE1qUnJa55OxOfQqt1Q7+xGjYEVwXkdsAc6k2RgXemigubCvLcAcq61Fs20Z7N0ay50UwaLPeB5L/Xl+3VsBu3q+iyy/0+bnRptEe9fYkkOkxWMNXWGufTfFYhBvI60ttpyI8p0G95rOnRzIf+ORgZ5kOShu1WbPt/AksxYkydg4RPaj8xYBRQSKWSXZNXpmK+YTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/17Zw2tvWuarWt4Y9O2khXMZl4SXA8VulmIq+48A01Y=;
 b=SoMlEsUm3wZI5LI690stZpcj/ZoflCQUrzoB/q5NrStRK/rHL3psq2I7g3RwcpfjlkRE9vIEgtyS3qF0U+oUj0j83XRPz4oN1jsYqOHsH/DfDPcA8jeH7xITWpHmCykpBXQuUu8gE0nkOesUTl3ceorub6UgfaxJ6krG1qOnD3+9I4fosybqMWO4eSeDO4pgQ315I199T11XFySmsOpIFZL4YPZLmjlwXs2HdOKTgPtdwm8h3n4yaGvUZfl/j4PxyqTrMyj4yPWZRgZzAx7Kx3im/Dl/jG8c/GpPHagGeFqOUlpL9zg5CNg4JjBriuNxHx0B30p4W4+R6lRm5wHnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/17Zw2tvWuarWt4Y9O2khXMZl4SXA8VulmIq+48A01Y=;
 b=L6yGYPDipNgSCnUSL7LDfxQGqKOS7x5XrJoamYCJx/q3WqlkXY0r/nXUM2j+XvV9HaAe3Ys7YOcOuf11SMw/rTPGg7UU+XLvPQBNrlirkV9qeLIdnSgEKWb3hCMs2OQeWYTqCcPRdStrehwo0zjAzS8AkdWw0hx1BlK1Atyl79w=
Received: from MW4PR04CA0084.namprd04.prod.outlook.com (2603:10b6:303:6b::29)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 06:41:00 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::37) by MW4PR04CA0084.outlook.office365.com
 (2603:10b6:303:6b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 06:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.0 via Frontend Transport; Tue, 5 Mar 2024 06:40:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 00:40:47 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <samir.dhume@amd.com>, <leo.liu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add HDP flush to VCN v4.0.3
Date: Tue, 5 Mar 2024 12:10:30 +0530
Message-ID: <20240305064031.548905-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 927241f6-5718-4620-7b73-08dc3cdf37ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FlKL9Ly7gVT023evZepebrSsbNyNVMA/GAE83GHjoRShXhiZTxe9o4Ax8syo6pqWN7cL88nl6/JAVPq/2dBcY97yoLfrQJft4ZBlBD5s+QTNzFkwe2Ue5dU3lXoK2ohIvaIZPzvTsQgtckOmMPZKWJxEeDC8BYNMQs0PPXONqD6UyYLRuIuqt22YuPusdpNGxj/mqdEW1Pm8avURk8lHaQ4sHxSoapOp06J5gYtXDfNx20bKbNGISZNmHFyRHWD9nEbzRL6Iddm78UVgvljuy3HNUZPL2KtCGGr8R0rd3SxkcVdGnQPDuqs5RA+VWciQYP7/VtdARnFJSxfox0KJTpzJ4R8gpHDPr6Y1x49cWljX39+5mVdJxO/r79SLhLxoCnKmMR4Xrh9BUZw2pc5QjYwmRSpLR3PIEH7UeNQqk2w19Tsgm6M2XJWvFGfGKg2Dz5drsIEXxsdT7baZGIGEpvf6CbKVk7UeOcHcnlzlrEEZDbJJN6xSLrRGd3S0bLNW9q88KtVJQsHYRqPlQ1TBCwYqcXE/8tZcw/QIYHGscAH9QWaFdx04uMC5CGSWzbCCQzc8bD0uGyu2cjTcHJ9Y254BXvblRxwnbDl/hbdG4L6KKdV7WnG851MFJvSLFrcFbda6ae2UEyATeFUuCXAvi/94n8rZiGceu4k3pcqb2YjPgJgoH97RjPRtQctu/u1R0Sky3BVg3B+BxVXt/neFzrhAAAxokixSgE47vYuHkETRoNQJl7YhtBhiuq4Btyv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 06:40:58.2916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 927241f6-5718-4620-7b73-08dc3cdf37ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

VCN 4.0.3 cannot trigger HDP flush with RRMT enabled. Instead, trigger
HDP flush from host side before ringing doorbell.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 810bbfccd6f2..7b5ad13b618e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -36,6 +36,7 @@
 #include "vcn/vcn_4_0_3_offset.h"
 #include "vcn/vcn_4_0_3_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 #define mmUVD_DPG_LMA_CTL		regUVD_DPG_LMA_CTL
 #define mmUVD_DPG_LMA_CTL_BASE_IDX	regUVD_DPG_LMA_CTL_BASE_IDX
@@ -1380,6 +1381,26 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 				    regUVD_RB_WPTR);
 }
 
+static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
+	 * This is a workaround to avoid any HDP flush through VCN ring. Instead
+	 * HDP flush will be done by driver while submitting doorbell.
+	 */
+}
+
+static void vcn_v4_0_3_flush_hdp(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+#ifdef CONFIG_X86_64
+	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
+		return;
+#endif
+	if (ring->wptr)
+		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+}
+
 /**
  * vcn_v4_0_3_unified_ring_set_wptr - set enc write pointer
  *
@@ -1394,6 +1415,9 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
+	/* Flush HDP before ringing doorbell */
+	vcn_v4_0_3_flush_hdp(ring);
+
 	if (ring->use_doorbell) {
 		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
@@ -1420,6 +1444,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
 	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
 	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_vcn_enc_ring_test_ring,
 	.test_ib = amdgpu_vcn_unified_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
-- 
2.25.1


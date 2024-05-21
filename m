Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FF8C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 16:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A659E10E3B2;
	Tue, 21 May 2024 16:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mPdSa5Z7";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7921710E17C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 16:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INtpEc/WKB6qyxO78bBWQSjfPotdvC/lamueQ8ERv9ML6nwgH5k/azR1jgqWcKYydCq3JyyyyjBnbdHu0VEOG8UHmx5dMBTzEMCeG6OOiC3QfhRK3wVYLMvImMsnllyhmRrWLsDuj57aTM0KEUab9zGRqk+r5hw/MVwkTbT5YYw24+ZU1+rIGv8SbqhFerFEnpyYiOIX/T+6jHxdAdfYAEUs4KNK0WheFI6Pf7U2MWZqjC3f1LNwzNHa3RH0OQgzW2YI0a9gGIB0k/msdVXRHHHMH889+R3/Rb9M04Eg09i0LDmmy2DXmHuaptCv9au8eVUErp4Pa6eYK3soTcZaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvQcZHYADj9Qu3cMHE6+SNLtsTMFKkoOYpqswnL+fyM=;
 b=SnchRLILHs/8chSGUPKfY1R5faDG7r3wLgy1yilJGY1eCQCMyEEmlJq2lOn3T2LpbwgbeLhQHW6sQuga/87oTIjDelMmLcwFsIt+G5/+Q6+g/ZSi7z2Iqv/hwLHiIT/gLgCEqzEGMRwAnnUoBJJ6Nfexo73P5VasABA82p0gW8FVlin7drJFNeqPuxhNcmn6hAwngEArwHAA2bUTZKWkqShM//AOVTavW30oKGul1TifQ2xuBp3UQ04nA5UxuFuM33MZSYu/XYzd9X9soq1prO6aXRW8XnH4GDTa5j9heam5gcn1XWSUjlwWQn9tOA36lwg/djX+xRN1/EO6zMa8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvQcZHYADj9Qu3cMHE6+SNLtsTMFKkoOYpqswnL+fyM=;
 b=mPdSa5Z7CJdA6NSbhCfrdVpXz2UBCoTe8Cy+q+DWjcnb6qGeLiUg/DzIFsP8XDsy+x4pCZvjkYAjeIkRgoQymiEKFJM3iQNJmR5kvKp52R0DIhCwM/j36QVtdTlqpfp48nuug3FZLyVvoP/b40cWjdiyVMChQtAxElZnQj3HGoI=
Received: from BYAPR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:74::33)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Tue, 21 May 2024 16:49:01 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::60) by BYAPR05CA0056.outlook.office365.com
 (2603:10b6:a03:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17 via Frontend
 Transport; Tue, 21 May 2024 16:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 16:48:58 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 11:48:57 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v1 1/3] drm/amd/amdgpu: Map ISP interrupts as generic IRQs
Date: Tue, 21 May 2024 12:48:39 -0400
Message-ID: <20240521164841.36101-2-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521164841.36101-1-pratap.nirujogi@amd.com>
References: <20240521164841.36101-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 360b17e0-8a8c-4781-2b90-08dc79b5e94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?48txunLROTeoTMMjz+GXFfCxuXu3JKKGnbjHpE0oS0GAmYL6Q+YfR5pM4ZPE?=
 =?us-ascii?Q?ITiD1My1BqaOxH01+m6mnVSNGf/kZoqfogvuqJKm5us5Klq91UuYptGEksIQ?=
 =?us-ascii?Q?HBmt0L7LWiht3F9WJVaFvEJLsHh04uaWHTErfQUon2V/3MgIGbAQHzWX3Xz3?=
 =?us-ascii?Q?k/RvqPDgCjcRD0UWSN+55Qdc61lwXhRXEKLmWTlMDXbfT+7Z4ovwPkfSgmrY?=
 =?us-ascii?Q?5Sx7cnzNOpDGXbNL9/da7oSJwX5bscungzojkxI+jHohHf5XyhgjNeqxj+2n?=
 =?us-ascii?Q?tLfHsdDsj59IABU7GGWlT7pOEym5NN+/AzviPGkfs5j4Pzc37lgD8uLyNmeY?=
 =?us-ascii?Q?DmvzwzkY/651AyI4Y0N03LWDl+tTN6Xi6liWP/1hGasYMczjdkYl+91w+qXn?=
 =?us-ascii?Q?LJlP26zVxf0e8ard2NGd89zVdkOG8ZbeyAXlAUNfHCETcNdYirPFGJp7Ru+c?=
 =?us-ascii?Q?bnTNYoEKMt+doViVy4TJSkYXAgRTPks4b+vMpgCL2XemC4Ap1WA6PlPYCWNn?=
 =?us-ascii?Q?j+lh+WDEII5mx9ukGKO7z4/eLlCsbnJ8edbwAiCaDYQMw7CjCfIBe+zCFHPV?=
 =?us-ascii?Q?WJMsM2pdC6Y/j/VuM+i5GJMNfIXP2P/J9Io8FNvBfrV24okqu/lHbVr+wxfK?=
 =?us-ascii?Q?nA0xdddBe8HwbI4CD/gPQDz3APe4JpHD6Ap3qYgZ9i4/iPz7cH6RGzXSbdbw?=
 =?us-ascii?Q?dsBKOzywLKuTH94ynd4FgBnAyETgoSBGZEDVDS3yAMknWVmrwA6bJztsLXOH?=
 =?us-ascii?Q?Tw518I13kYV9nIVZ5gVXePCvyH86WQFD42+VWEGgY6T+dyT5f8WUWYkMgGR2?=
 =?us-ascii?Q?9gA0Sg9r7riSlgtEbmzxVVjPMYX3dKFxoOfKGzyk40Svoc4+EB9dHNnX4z5j?=
 =?us-ascii?Q?oYpZnvRb+4j3/jDTt/pVROiNcQNgWP92ME3ypPiXN1rxFWf5o6IEnFiJrnna?=
 =?us-ascii?Q?INMIMGfrF95lKyOqEXs87nxUurLPuCOyWHbl1POLsRtcnCD7iLFlRfZ3pIS7?=
 =?us-ascii?Q?+9WsIzWyfUhffchApTs99UIXobvJHHIDvxEpPkbFxklGYb+KD32/vFgm0j0G?=
 =?us-ascii?Q?sosZZkd/+Lw7Fh9aKgjBD6dsp3o37Gf9dPhuKLP350tyPOeoROPw3XGy1qO9?=
 =?us-ascii?Q?OFlT3U6bGsex8T4QVcB81bEtg7PArpZmvIxF0aXllJCOU8fYUeHoRJTeYnBF?=
 =?us-ascii?Q?gblHlrbo81IgXkS+XT8tuuSZiSqOacSJ0UWWIOm65yudk37JOSwBUrBLkdTy?=
 =?us-ascii?Q?1Fw16K4VVxqYE64zK9MuaAkJpvncguK5y3JsNqO1ekECCb/jW7vR9D+CQaBk?=
 =?us-ascii?Q?xl5JM+ZxQ7/hl0yCzd5/6qdUHwOjygl4i/ySx7oQrCMi+AP8KYh5Wra7fjzL?=
 =?us-ascii?Q?qp1vXZyZ7Yt+kY+o3Z9wN9/d7C5u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:48:58.8551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360b17e0-8a8c-4781-2b90-08dc79b5e94d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
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

Map ISP IH interrupts to Linux generic IRQ for ISP driver to
handle the interrupts using MFD IORESOURCE_IRQ resource.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       | 31 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h       |  2 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |  6 ++
 .../amd/include/ivsrcid/isp/irqsrcs_isp_4_1.h | 62 +++++++++++++++++++
 5 files changed, 99 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/isp/irqsrcs_isp_4_1.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 665c63f55278..46fe85d3ed71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -466,7 +466,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 	} else	if (src_id >= AMDGPU_MAX_IRQ_SRC_ID) {
 		DRM_DEBUG("Invalid src_id in IV: %d\n", src_id);
 
-	} else if ((client_id == AMDGPU_IRQ_CLIENTID_LEGACY) &&
+	} else if (((client_id == AMDGPU_IRQ_CLIENTID_LEGACY) ||
+		    (client_id == SOC15_IH_CLIENTID_ISP)) &&
 		   adev->irq.virq[src_id]) {
 		generic_handle_domain_irq(adev->irq.domain, src_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 25e88661ac60..52e53d2b8748 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -31,6 +31,8 @@
 #include "amdgpu.h"
 #include "amdgpu_isp.h"
 
+#include "ivsrcid/isp/irqsrcs_isp_4_1.h"
+
 #define mmDAGB0_WRCLI5_V4_1	0x6811C
 #define mmDAGB0_WRCLI9_V4_1	0x6812C
 #define mmDAGB0_WRCLI10_V4_1	0x68130
@@ -38,6 +40,17 @@
 #define mmDAGB0_WRCLI19_V4_1	0x68154
 #define mmDAGB0_WRCLI20_V4_1	0x68158
 
+static const unsigned int isp_int_srcid[MAX_ISP_INT_SRC] = {
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT9,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT10,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT11,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT12,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT13,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT14,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT15,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
+};
+
 static int isp_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -69,11 +82,12 @@ static int isp_sw_fini(void *handle)
  */
 static int isp_hw_init(void *handle)
 {
-	int r;
-	u64 isp_base;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	const struct amdgpu_ip_block *ip_block =
 		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ISP);
+	u64 isp_base;
+	int int_idx;
+	int r;
 
 	if (!ip_block)
 		return -EINVAL;
@@ -90,7 +104,7 @@ static int isp_hw_init(void *handle)
 		goto failure;
 	}
 
-	adev->isp.isp_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
+	adev->isp.isp_res = kcalloc(9, sizeof(struct resource), GFP_KERNEL);
 	if (!adev->isp.isp_res) {
 		r = -ENOMEM;
 		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
@@ -114,8 +128,17 @@ static int isp_hw_init(void *handle)
 	adev->isp.isp_res[0].start = isp_base;
 	adev->isp.isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
 
+	for (int_idx = 0; int_idx < MAX_ISP_INT_SRC; int_idx++) {
+		adev->isp.isp_res[int_idx + 1].name = "isp_irq";
+		adev->isp.isp_res[int_idx + 1].flags = IORESOURCE_IRQ;
+		adev->isp.isp_res[int_idx + 1].start =
+			amdgpu_irq_create_mapping(adev, isp_int_srcid[int_idx]);
+		adev->isp.isp_res[int_idx + 1].end =
+			adev->isp.isp_res[int_idx + 1].start;
+	}
+
 	adev->isp.isp_cell[0].name = "amd_isp_capture";
-	adev->isp.isp_cell[0].num_resources = 1;
+	adev->isp.isp_cell[0].num_resources = 9;
 	adev->isp.isp_cell[0].resources = &adev->isp.isp_res[0];
 	adev->isp.isp_cell[0].platform_data = adev->isp.isp_pdata;
 	adev->isp.isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
index a11ec0543b93..764d70beb9e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -30,6 +30,8 @@
 
 #define ISP_REGS_OFFSET_END 0x629A4
 
+#define MAX_ISP_INT_SRC 8
+
 struct isp_platform_data {
 	void *adev;
 	u32 asic_type;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 0fbf5fa7b0f8..2e0469feca1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -535,6 +535,12 @@ static void ih_v6_1_set_self_irq_funcs(struct amdgpu_device *adev)
 static int ih_v6_1_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret;
+
+	ret = amdgpu_irq_add_domain(adev);
+	if (ret) {
+		return ret;
+	}
 
 	ih_v6_1_set_interrupt_funcs(adev);
 	ih_v6_1_set_self_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/isp/irqsrcs_isp_4_1.h b/drivers/gpu/drm/amd/include/ivsrcid/isp/irqsrcs_isp_4_1.h
new file mode 100644
index 000000000000..2ecdfd4f1b03
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/isp/irqsrcs_isp_4_1.h
@@ -0,0 +1,62 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+#ifndef __IRQSRCS_ISP_4_1_H__
+#define __IRQSRCS_ISP_4_1_H__
+
+
+#define ISP_4_1__SRCID__ISP_SEMA_WAIT_FAIL_TIMEOUT			0x12	// Semaphore wait fail timeout
+#define ISP_4_1__SRCID__ISP_SEMA_WAIT_INCOMPLETE_TIMEOUT		0x13	// Semaphore wait incomplete timeout
+#define ISP_4_1__SRCID__ISP_SEMA_SIGNAL_INCOMPLETE_TIMEOUT		0x14	// Semaphore signal incomplete timeout
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE5_CHANGED			0x15	// Ringbuffer base5 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT5			        0x16	// Ringbuffer write point 5 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE6_CHANGED			0x17	// Ringbuffer base6 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT6			        0x18	// Ringbuffer write point 6 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE7_CHANGED			0x19	// Ringbuffer base7 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT7			        0x1A	// Ringbuffer write point 7 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE8_CHANGED			0x1B	// Ringbuffer base8 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT8			        0x1C	// Ringbuffer write point 8 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE9_CHANGED			0x00    // Ringbuffer base9 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT9			        0x01    // Ringbuffer write point 9 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE10_CHANGED			0x02    // Ringbuffer base10 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT10			        0x03    // Ringbuffer write point 10 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE11_CHANGED			0x04    // Ringbuffer base11 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT11			        0x05    // Ringbuffer write point 11 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE12_CHANGED			0x06    // Ringbuffer base12 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT12			        0x07    // Ringbuffer write point 12 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE13_CHANGED			0x08    // Ringbuffer base13 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT13			        0x09    // Ringbuffer write point 13 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE14_CHANGED			0x0A    // Ringbuffer base14 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT14			        0x0B    // Ringbuffer write point 14 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE15_CHANGED			0x0C    // Ringbuffer base15 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT15			        0x0D    // Ringbuffer write point 15 changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_BASE16_CHANGED			0x0E    // Ringbuffer base16 address changed
+#define ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16			        0x0F    // Ringbuffer write point 16 changed
+#define ISP_4_1__SRCID__ISP_MIPI0			                0x29	// MIPI0 interrupt
+#define ISP_4_1__SRCID__ISP_MIPI1			                0x2A	// MIPI1 interrupt
+#define ISP_4_1__SRCID__ISP_I2C0			                0x2B	// I2C0 PAD interrupt
+#define ISP_4_1__SRCID__ISP_I2C1			                0x2C	// I2C1 PAD interrupt
+#define ISP_4_1__SRCID__ISP_FLASH0			                0x2D	// Flash0 interrupt
+#define ISP_4_1__SRCID__ISP_FLASH1			                0x2E	// Flash1 interrupt
+#define ISP_4_1__SRCID__ISP_DEBUG			                0x2F	// Debug information
+
+#endif
-- 
2.34.1


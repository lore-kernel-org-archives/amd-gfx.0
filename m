Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396ACC28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 09:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D404810E712;
	Wed,  2 Apr 2025 09:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oTLaAXKh";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AB210E712
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 09:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbAsX7VxEw2iBZBVs4Ckxbxq85Q+ACWEbrhN5bga1flQPeRhoq6X1RaLzxhzJB22f+nFiMb29iXBI4odE7Hbh9LA81bpCw/9YSEpT6mbdqBiE1qZVhcjt5HWb84wyIua1w5DxRK01OfiVHriUrcstdvQkbth8bzgniq6C7oLCPhb6hQjlfzyM4RmOlZzyFw2cn4vGdSfxlmO7EhKz8Y/VuFJJLKD+q8s2udOkRe8rJiDy5uS+kchSOD/kadKwuj+PNe4xEE4rpwDS1hWBXlJEZIlB0n5+cjoj9NCOY9gvKQSIAP05CwVWnpHDjiXbit5OW0GjWWoVH4lv1v/rR0pvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcPMbFlPuVxgc2ZGk7m5X0Z8dK1AghX2vt6MzNl4qPc=;
 b=RB0DMj5aCquHy2j6IzPaOMEZZSkbwOO3uPIfPN6bxMwL6yizclNSsf5FHFicMVvzSEcjRN4SrjESl6Oa8Rr19RyubsAl4z12F+ZCC6AuvmMjzf1h1iup1e+PnAiIacYzSka4jNq1X3JmAMj2XE42jG1T68yzRp/1SS/NLOENdLydSE+Yl/eW39XjwKcIfpntA2Ap+QgFsk3+IXYCZEu4P3Ir5dQmnfIQRlAFpZvqdUOBB3CulxCL2TBzOZ1xR9i5gzpZSn4QwX+SqCaOugf1swe3HKnqZ6VaY7n8ep0zvJxYT9PR05QmNHQB4vd+SCewzzj4uOnS2Q6PTs+IM1a5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcPMbFlPuVxgc2ZGk7m5X0Z8dK1AghX2vt6MzNl4qPc=;
 b=oTLaAXKhTTsyqfeNeM2bMc28gMIIeKTyK0TevMul2qTSTaOM91VXW5N9vd/eRM0MyFQ3/wcKepQJC3IU3bZ8UdP4pocdYgpeggSvlDfo9IEuKxbDUcUS1ENIY89HvHLNzKHa7qxU1BTohMfG+ZdSU2UekDzJd3D7R5CJnBNZDm0=
Received: from CYXPR02CA0008.namprd02.prod.outlook.com (2603:10b6:930:cf::14)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 09:14:28 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::ae) by CYXPR02CA0008.outlook.office365.com
 (2603:10b6:930:cf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 09:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 09:14:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 04:14:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 04:14:25 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 2 Apr 2025 04:14:18 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v3 2/7] drm/amd/amdgpu: Implement SDMA soft reset directly for sdma
 v5
Date: Wed, 2 Apr 2025 17:14:01 +0800
Message-ID: <20250402091406.1641643-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402091406.1641643-1-jesse.zhang@amd.com>
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: df8294f2-989e-4bcb-9392-08dd71c6c4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5SOZawG4qhDGkjkYhnSkxekaRmIkMBWU41VxxKXV7892t8iqkWShf1dkg8rs?=
 =?us-ascii?Q?4q6KPL3V4xBaI7piF11L/e0mrPkEXF4JZ3XaqrW464q5UIv3tRH1zLSCXoRw?=
 =?us-ascii?Q?9xUfMRyViFuHQqtMA8hjdo4tIBisedcj4SR8lBFYOY9JhhFs1QTvuTjcOVUQ?=
 =?us-ascii?Q?MX3CqIcMLlAeKReJ7CRDItIaXZW6OX8h2SRrfJa28InHtL0nDZI7bgQjKYZM?=
 =?us-ascii?Q?jf549UpjWdWLrY981UFOzAfF7KC8PLIEUqdaDUjiY7T6PFd1Vf9isV42Fc1y?=
 =?us-ascii?Q?cPnT/HLoZbnzLTe+9Yj3QfSffsU1EwV1wHg5fP43qxcKfoElKV2j1UlW6jXz?=
 =?us-ascii?Q?F0jzvPXMd6plYbvZFRBXm7owqCqk9zilTSgZ4xGqb18yKwV7sB9vzFDmMeDl?=
 =?us-ascii?Q?U1texJ5INSmsP4C/4D3r6TfyqnXsKy+yHFz5QC8LDEhGAKFpyhxIMoblSeV+?=
 =?us-ascii?Q?0ZK6IFvakClEgzN+wYPYndG4sk6l6H6tg9kczi9sbAgzPcWDRYg9sXPJx6Ij?=
 =?us-ascii?Q?QOnvMayxswLv1Zmd4BTTNyrCpnulhOb/5ZgTmoy6gReSn5DUguzSH6XBiie0?=
 =?us-ascii?Q?vnKJf15M0Gm2V2zByqSdRdW8jLqAxP/Uzh6goiTNjTomkoSOmqQl+0EHmG2C?=
 =?us-ascii?Q?u27yXom34ge7BgjAdA1aSi6FW00NWHrXzVpJy/OvjPbvDD2Bl85SqsU2W1jg?=
 =?us-ascii?Q?iDnVtQOf7CPtZMSACgqj/EhXfVTgIFpchKinn+VWmZhbPtdMGTMgaWyu6S3g?=
 =?us-ascii?Q?pgZlUg4/1uMOvntphtd5Te/WYty15gqGn1zdvPzz7kFJMd+ipEswFfktfpcp?=
 =?us-ascii?Q?sTgorYqvyxz3ypmf1kyiabekj2thZKltmrdItOfYpcAPAb+G40wFqdUCSCoz?=
 =?us-ascii?Q?kAY8Y57uWelU5/vG6rIm/RaXlVV5NvCtEpPrDxcHNUa8fzVeVjFUbBqAzHpz?=
 =?us-ascii?Q?KeBCtsIne13YxNh0i/sz3iE+GPnzrLfwwj9+HjklimeUcidTwvjI3tWP+kBe?=
 =?us-ascii?Q?nAOaGoz0nKcqM37vPAzpWYccknPld9QcG3F15QrUHg8V+2H8D5EEkwopUP0M?=
 =?us-ascii?Q?FfQSr/y3QzFsS8L5qq7MFmMyvJ0EZi1NrSUOJBzVXa+xOP30NOv3OcxwUtrF?=
 =?us-ascii?Q?y/wHcaLRepEqwh6Wm8zavHwpEGfoOUiO432tOCR8xjfkFg25cWRwBRBbXOV+?=
 =?us-ascii?Q?Br0D4L2YDUKAxCnnUUuoi9Cpg3RUDGAP882eSo4u3KskuKWz/cXE6TK+dCva?=
 =?us-ascii?Q?aw8ioh5OE8c+GwB6mIezUB1oS9JVv68acBcg45tgGCF240eXcLPGZ8a63PDy?=
 =?us-ascii?Q?Jp4RdqhSm8t7RPg4cAI5kv089ejgkvTzfHvojccJobuFb3nRx4svj/ozP/t7?=
 =?us-ascii?Q?WmS/zZqCHUKeJm/fqa7SeNgTKKaMasSdpT9qbFMEnqI61fETFey05BsM5NHG?=
 =?us-ascii?Q?wNAAuTvAjW9zhFt8nMLC6+ApXh1P58BBTxZgE2Z9iXdK1sEpzerWZ9TyA105?=
 =?us-ascii?Q?5emom247b0pQD2c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:14:27.6505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8294f2-989e-4bcb-9392-08dd71c6c4ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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

This patch introduces a new function `amdgpu_sdma_soft_reset` to handle SDMA soft resets directly,
rather than relying on the DPM interface.

1. **New `amdgpu_sdma_soft_reset` Function**:
   - Implements a soft reset for SDMA engines by directly writing to the hardware registers.
   - Handles SDMA versions 4.x and 5.x separately:
     - For SDMA 4.x, the existing `amdgpu_dpm_reset_sdma` function is used for backward compatibility.
     - For SDMA 5.x, the driver directly manipulates the `GRBM_SOFT_RESET` register to reset the specified SDMA instance.

2. **Integration into `amdgpu_sdma_reset_engine`**:
   - The `amdgpu_sdma_soft_reset` function is called during the SDMA reset process, replacing the previous call to `amdgpu_dpm_reset_sdma`.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 46 +++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index b51fe644940f..26d7c0aca9a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -26,6 +26,8 @@
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
+#include "gc/gc_10_1_0_offset.h"
+#include "gc/gc_10_3_0_sh_mask.h"
 
 #define AMDGPU_CSA_SDMA_SIZE 64
 /* SDMA CSA reside in the 3rd page of CSA */
@@ -553,6 +555,48 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
 	list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
 }
 
+static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
+{
+	u32 soft_reset;
+	int r = 0;
+
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(4, 4, 2):
+	case IP_VERSION(4, 4, 4):
+	case IP_VERSION(4, 4, 5):
+		/* For SDMA 4.x, use the existing DPM interface for backward compatibility */
+		r = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+		break;
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 1):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 5):
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 4):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 6):
+	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 7):
+		/* For SDMA 5.x, directly manipulate the GRBM_SOFT_RESET register */
+		soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+		soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << instance_id;
+		/* Issue the soft reset */
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+
+		udelay(50);
+		/* Clear the soft reset bit */
+		soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << instance_id);
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+		break;
+	default:
+		break;
+	}
+
+	return r;
+}
+
 /**
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
@@ -587,7 +631,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		gfx_ring->funcs->stop_queue(gfx_ring);
 
 	/* Perform the SDMA reset for the specified instance */
-	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
 		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
 		goto exit;
-- 
2.25.1


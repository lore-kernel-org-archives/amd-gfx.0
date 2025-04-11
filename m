Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728D4C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 08:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11EF210EB32;
	Fri, 11 Apr 2025 08:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZZJU6zef";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5992610EB32
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWVqpMnFOlNGXX+4CugQv17I/iEGdE7gMspSzuO/QLoMqM+SdIgzV6eJpTvkTpP5EGYWOcXVDtH0/JjqmYloZt6PvYm0GGIF0Fnl/s1KjwDTV0nHz+veMRTHdavP4IKKE1aqYiPIs9Yv41t3ygQSWBa/RsNkwfFStHA5ew7JZGVOR6vhjNKC5rTxtJxFxnD4fJZzhkN+zN4BW/XwogYj/F0YlU5b4SIGfIPgyx2S86ZXI6/HWxZ1dBYsry/eQBg0GfP0iJcNknDqGXxmzigQzVGlNAN8p5t7JEcZK2+pBPplNpd79SBkoPq479G0mC68pnNYqZ+2l70CGHyAc7h9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPJTOmj/QU0l+wk41IUN5sUIWXbTz95ny257mN7I5u8=;
 b=m8CQIeOTR0b7qRWKWQ1gCd1kTZIOXJogtgvn6Z/PT2UXSVc6/gjGiV74MMESrS37bEmLCI5EVkKsB8fC8emDlvTbtPKKJY+S6Ps+pKZX0nvqlrijp5ejUTdfK+V4UfvEn/L2XphcL52iE3+zHiZkfVZEozgD7wlZ3jVRtd3ol5SSdRMoKAEzUxk3948gQ2kcgrpz7nx/BOYHoTAFOlUGThl7ZQDheK6fKU4f0MIfVOIs92HT1I2MlzVJv74Qtv4Z/p2mLXVlBY4BecZjPIHotC2alW/X5k0wM8ebifPALIXPZKtha7wwv85yiDyPyZcyQLModtqj9lWOK0H31K2l+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPJTOmj/QU0l+wk41IUN5sUIWXbTz95ny257mN7I5u8=;
 b=ZZJU6zef8bSlSc4t22/fTV74eUmbsje6Yl22kB18mj/c97FOlyl9Xdu1GvziggyIkYga6ro439RnfNj2o4pO1ZcLPdcjCWDGohQoTp2S8nOt+kSCZInkJZlPe8QzTbbDMDHNmOEnMKYzbyzs0eyGAdPYXv/UX2e1cUvE5G8Yx34=
Received: from DM6PR10CA0020.namprd10.prod.outlook.com (2603:10b6:5:60::33) by
 CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:30:24 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::76) by DM6PR10CA0020.outlook.office365.com
 (2603:10b6:5:60::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 08:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 08:30:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:30:23 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 11 Apr 2025 03:30:11 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [v5 5/6] drm/amdgpu: Implement SDMA soft reset directly for v5.x
Date: Fri, 11 Apr 2025 16:29:20 +0800
Message-ID: <20250411082921.3228498-5-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250411082921.3228498-1-jesse.zhang@amd.com>
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c7c3d0-14ea-4f63-30aa-08dd78d31adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?18/skBOgTY6ps8c/BVIgHbhGl4FQxYsTZxyKE9i91lsRW1ijpz5W6b7DQJG/?=
 =?us-ascii?Q?ZRfEepNThVoWuOj5eORa28Xk6FyXVq2dLC2BbMDQ6fa9NegG1F5FW5EUjXAY?=
 =?us-ascii?Q?IS9xughXrIvzbBTsNd127E/dn/OE9Xmvx0cKa4jcz2ZYGzsuGbJfIIWjyMQg?=
 =?us-ascii?Q?omr1Yce7oCAx3bpZ5sBB5c4wzalCKKr059kt5PwTO+yUrlI5jjsh7xdY2D4l?=
 =?us-ascii?Q?DbY+UeDcDNDeY3Qf/kV4xiMX4ARWwxIfD3C3guMNmMlCliKeO+KyLBP0tXbn?=
 =?us-ascii?Q?m0fLiaFr10/YaU6Pu9WNZWbQFL2pyqKRGFlcTiujqdz9nnjCC8fZh0pY8mC9?=
 =?us-ascii?Q?Hb8fSbUnncG+0HqbH5G9N61muwdDMpzAvxcw4RJiov++R5D01v2NEMu/KjAt?=
 =?us-ascii?Q?59qOoNAv3aXJVxYVQ/9t9E15IBpjGV/EJ75BllFeaCfSyw4xrCobaPQm2Kqb?=
 =?us-ascii?Q?3y3z2z4DBM9rXFXcvc4VErgfqWg2Lz3RUZLugaMdpUdqrSPKWUXCbM4OxLVP?=
 =?us-ascii?Q?B6SFD2HWR7tNW8m2fc/76VXRVTO0WlXRM+DWvbDzciS+y/ACKb6fKhXp2BjA?=
 =?us-ascii?Q?bQkAJ8KZ5tHuuPIUoK3eyDGcVC0n8ZVG/f3QxCdxyXt8bPT1fx1jNmuQm/Mk?=
 =?us-ascii?Q?P0P4YZkVK2eVl1qE7o4+dOkp349q6lqIb23sp3Yg5IMNLRm+/If79VJ6H2uu?=
 =?us-ascii?Q?4kc53C5LS4Bzgn/nra2oTFp9AabUL4qeGNl7Zv0fYgur1MHLpw05yxCTWf2U?=
 =?us-ascii?Q?QNAYzDQX9K/V2YJy1NKFfpMlMhP8cquWD1S8TmXQ0W7/fPGBXN/MYuV87YjK?=
 =?us-ascii?Q?RXPJy4V0bBEDZaqDr0z4qGpi44FwOrKqXIWxx4Sqmbfsxu8DUhPTPeC6ohvW?=
 =?us-ascii?Q?cPdVltKQK/XuuMyoUNmTx8N1i03RMCO+nhph5hdeuDGcbW+eh1JwsZAbHzRg?=
 =?us-ascii?Q?A6NW3zOgHPUfFqICYVtlBcjKXPzZX0WCTmoXuc32Hz7NmDYjy0VJ4YYoR61j?=
 =?us-ascii?Q?bqin0en3lNUtjKN9Q+0+BBRNN6juNqyqihpeDQPCQLegCqqLScXn3L1mfEGH?=
 =?us-ascii?Q?j5XvUbs+FLi1+QejtcT73m7+BzTXnp0tsWUr4a8pDIgVAd6Dr9rQ8MSQFu5e?=
 =?us-ascii?Q?WHBbTaytQ9LTylq+FBZmtq/vT1jCUzkNUphfZnsRsG4gQZBCURblAjyFDwPJ?=
 =?us-ascii?Q?jy2BJFl0KTwp+oO5FsBpxQ8WOyvRVWpxpf7LS1f45hE14Fa3AY03OeY/ualZ?=
 =?us-ascii?Q?vWTfXTZ3W+oDQ8Mfl1jnXNieJG51qxLIa1IWIWjVzEmVXGydgaTNMTEW84CG?=
 =?us-ascii?Q?fhbfB6ckmbaJRKSd2O2ENGJXZFgdNp6TTfjWxE8x0kzbNmV6sqjPDv9k5Sgz?=
 =?us-ascii?Q?6NILgAmZk4dj0psViX1JutcqrFg4IvkoXBkVeKh4yWlVlGQkDiNIWiHIRTPq?=
 =?us-ascii?Q?i1q3IdSjsidjL48cUr/dmztctE7rBk08Xh7OZjhL3QYtYVbtlTnSEpAetO2f?=
 =?us-ascii?Q?vzfDSD17QIVU9sZnyt7UG6SPpqNW33tPIV13?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:30:23.9702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c7c3d0-14ea-4f63-30aa-08dd78d31adb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 38 +++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 7139d574c23e..b271a0626886 100644
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
@@ -554,6 +556,40 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
 	list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
 }
 
+static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
+{
+	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
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
+		if (sdma_instance->funcs->soft_reset_kernel_queue)
+			r = sdma_instance->funcs->soft_reset_kernel_queue(adev, instance_id);
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
@@ -588,7 +624,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		sdma_instance->funcs->stop_kernel_queue(gfx_ring);
 
 	/* Perform the SDMA reset for the specified instance */
-	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
 		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
 		goto exit;
-- 
2.25.1


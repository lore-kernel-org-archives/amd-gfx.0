Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30034C61CE7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 09:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB73010E5EB;
	Wed, 11 Jun 2025 09:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35wG7FFv";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67FA010E5EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 09:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGNzcyjzyOnTUjT2DdcMp0JPyiPgTY26JBo3sacPQ2D2syo4otfxE5BW6MbDFJaglnPyq77rl8aVZzSq6AUB0JRf2pqDnG8A5mWCQ3zRnunpY0VSppL+L13vp6w9ZiBzIhmlEb/FPxzI5KUuK47msL1o8RM6DbnVJ/y8nl69r5JATNYy/dLKEtBDqATTAX/OW9K2Vikfl8KxlV9vAQKXAeN2AKAUlA70VGx97IKc8O2azzpc29VqpSN3WjZMXeegUJQ1IiYEQAepc1ZJDdECpcH3l1pfhCa0ejp/F02bXxtc7IIZCa8FUX3poyWydrnCY1gB/UVvV7lp9/G6mynLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puSMsE+s2cmOWE7fFr1GFqCvboi4okrFFJcnuPvoeUI=;
 b=f1jpqi17T7VIStixePEnvsDcG+CFhArE8JfqnSEGuz7dITJBYLu7R141qL/u0RJS6RV2PafjOdOoiqovD9Rfiavm1rRDfsmce7eONgMyrYcQhQDarYAkI09n730y/RNEV2dZG6ppPUVaRtxohN0+exnV7F1hh/4KQKafs7WPWLigEbgUKez1/S6cPMKKPDq35Mf9num/ycLPWJbSH3+ouuzHTZ+5vk1n7hr7KFIaNQt4BQ9x2/hPJK8ifIXePIUpQYWMTriWFBnF1WYxaU80tqCXphTpA+CwAdYOplsdQVtmamBOCF5M+LaS6oy1SthJvDqKFyCoT2ClUPSVBcJIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puSMsE+s2cmOWE7fFr1GFqCvboi4okrFFJcnuPvoeUI=;
 b=35wG7FFvjq0TZ1NDZLkxxily0OlkmSO0hLNE7ofVOHHhTVT7MNS5uRMDZ7mo2Hk/Nb2LnshhLEKZl7iEeGD3pqFKQ1vzg+Hta2cLyoLvCz+pbXtDHOa/Sjkypc6PVVDtHpzIQuFuMghscYjEKNygQ3k9fgv0dAXCXjzoS16YKfs=
Received: from BLAPR03CA0106.namprd03.prod.outlook.com (2603:10b6:208:32a::21)
 by CY1PR12MB9583.namprd12.prod.outlook.com (2603:10b6:930:fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Wed, 11 Jun
 2025 09:42:43 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::f) by BLAPR03CA0106.outlook.office365.com
 (2603:10b6:208:32a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 09:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 09:42:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 04:42:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 04:42:42 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Jun 2025 04:42:40 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [v3 3/3] drm/amdgpu: Add soft reset callback to SDMA v4.4.x
Date: Wed, 11 Jun 2025 17:42:20 +0800
Message-ID: <20250611094220.3376420-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611094220.3376420-1-jesse.zhang@amd.com>
References: <20250611094220.3376420-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CY1PR12MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec0c8ff-4fb9-4201-d1a7-08dda8cc5046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dyigu/2FUHvoCRSHZts6W7PGpSIbJiyxjGLgwdNQKbgIkJqO6EouQmbhnj0p?=
 =?us-ascii?Q?ShJdH7basSyUCYsbNnN2BkV+yTSxjv5JXNPPOLeXNL0TKtexQ8MJtHjf+Gos?=
 =?us-ascii?Q?X9uT/Lxr86Mqh8aiJ5F0rOT5knSt9CGLW4PaTIk4D1ee8+f6zDfjyFdThcsS?=
 =?us-ascii?Q?sTtdyi7N+5wTuBAxUCt0y4Q5xofoZN2EBZY5IjfkIRMT1DPcdVAIUkmNAGpo?=
 =?us-ascii?Q?cu6v/J9Xqbpf4pwUW/9QEkYBe1l3/aHTdI2eQ+Q6BLcxZ15FBMG6OhwEk0xu?=
 =?us-ascii?Q?1YrjGhMzcuw6P0A0qjNChsm8wnGCYAD66wzjjri4+Tik/5lqb+FFN5VzcKLm?=
 =?us-ascii?Q?3XBuZSsSGVfanV7jMOS4P5CiVk2QhA+1VKQFbuqQbJPp9q/Omwp9LnbaM8am?=
 =?us-ascii?Q?L+UDKo/aIxdp8ay14xnGFteScWnQC/pBUI1LBdXmRUkLY6OS9wvZn8GofS5P?=
 =?us-ascii?Q?MrM51+uerETnNu9MiSiaheFXiOGwzDDjP0gQS/rHyOhTAd4ASRb2BEI6Aq0C?=
 =?us-ascii?Q?iOzKE1IkPRcbxg8/Xl1TLOXOUd7zMhBEJE5Z76U5Xsp97xRbmiAnoWm+E9QS?=
 =?us-ascii?Q?khTjgwdwJYN+RVYizMmgYWG8V9OOFf49sarCL8TACxDfU5Otl5G+w5Eowdqi?=
 =?us-ascii?Q?0qmdES58m335vQJqcscCE/Z7x2jQgLoibhVerbElrnG9hsGRKTqKuTy9wMCZ?=
 =?us-ascii?Q?WmXLe9BMmAqg/r0D/75Jz18QcD3LS0Jst0RmEmQ0ZdMzFNjc3I4tfAUYysdv?=
 =?us-ascii?Q?qXANlmKFhpjvW6f5v8iyG0cwx6uURc1jU8Y9mRLtzMtQlDQ+G4xlLrc+WYYi?=
 =?us-ascii?Q?7Wfc5z4SgTHhNFg0L8LdxC93IDly+PCKhfPAd9RaV3gmy5kSb8eNDrHAUCDi?=
 =?us-ascii?Q?bMt+TVldPn6foC7HzBFCOGMtWSw0MyRjWdpjeukkhSWerZ7U6OHrws4cEwc9?=
 =?us-ascii?Q?H7DIGAg/BKdb5dTiGcugNgP1JCZQ+k53fZeWPIbx1H33Ea2bgDRQMO/qRQZy?=
 =?us-ascii?Q?Rk4UJmrJ2MjcSbddyFdRX0B/XeDK9Uml70ZB/kxiKTUT0ohRP7CikqqOlMyA?=
 =?us-ascii?Q?Y114lzJerGtiw0Bf2lFO96AdWjuUGYelGI7f8uy6PnlkUYGfkpyrDTlTQCU1?=
 =?us-ascii?Q?f9JuW9msqQJ/j47mwpm1JatRS15Eq+swdExb/bOku8tRg+jpfmrzrgXoJJhc?=
 =?us-ascii?Q?FynChVda47x/5zZ2ghxgO8Nr+e0IKyGOGeezzIuc+SeKHiXc0AKa0AjB3ZAk?=
 =?us-ascii?Q?q0JY9mXDGCWXzDWtOb26x3h2S4es9zD5Of0u07JrndlzC+p1uvv+RSKycGk7?=
 =?us-ascii?Q?d6BuN6HCdr7xrYpGhvNs5ycXbVP7gPRVhC+7ziJCeixIKkPujY4BQSNnhbIq?=
 =?us-ascii?Q?HrLicUglHJGRVi+5ft5cmIIzBjUuQgNg0PoxEqdovXD1vzA8VHtKXDw4AcWb?=
 =?us-ascii?Q?ZXEYRiCqP1twl97YDaxJnMGXP7KEJML3nxkofMj7kDRmROwhsxuwHM0hJuBB?=
 =?us-ascii?Q?ksiOx6OkmjHakXPvG3NS2W1NOGLyMdlInfOw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 09:42:42.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec0c8ff-4fb9-4201-d1a7-08dda8cc5046
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9583
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

Implement soft reset engine callback for SDMA 4.4.x IPs. This avoids IP
version check in generic implementation.

V2: Correct physical instance ID calculation in soft_reset_engine (Jesse)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 10 +++++++
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 9b54a1ece447..a1e54bcef495 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -534,37 +534,11 @@ bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_rin
 static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 {
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
-	int r = -EOPNOTSUPP;
-
-	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
-	case IP_VERSION(4, 4, 2):
-	case IP_VERSION(4, 4, 4):
-	case IP_VERSION(4, 4, 5):
-		/* For SDMA 4.x, use the existing DPM interface for backward compatibility,
-		 * we need to convert the logical instance ID to physical instance ID before reset.
-		 */
-		r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
-		break;
-	case IP_VERSION(5, 0, 0):
-	case IP_VERSION(5, 0, 1):
-	case IP_VERSION(5, 0, 2):
-	case IP_VERSION(5, 0, 5):
-	case IP_VERSION(5, 2, 0):
-	case IP_VERSION(5, 2, 2):
-	case IP_VERSION(5, 2, 4):
-	case IP_VERSION(5, 2, 5):
-	case IP_VERSION(5, 2, 6):
-	case IP_VERSION(5, 2, 3):
-	case IP_VERSION(5, 2, 1):
-	case IP_VERSION(5, 2, 7):
-		if (sdma_instance->funcs->soft_reset_kernel_queue)
-			r = sdma_instance->funcs->soft_reset_kernel_queue(adev, instance_id);
-		break;
-	default:
-		break;
-	}
 
-	return r;
+	if (sdma_instance->funcs->soft_reset_kernel_queue)
+		return sdma_instance->funcs->soft_reset_kernel_queue(adev, instance_id);
+
+	return -EOPNOTSUPP;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 3de125062ee3..ea0eabd9166e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -109,6 +109,8 @@ static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring);
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
+static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
+					 u32 instance_id);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1337,6 +1339,7 @@ static bool sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev)
 static const struct amdgpu_sdma_funcs sdma_v4_4_2_sdma_funcs = {
 	.stop_kernel_queue = &sdma_v4_4_2_stop_queue,
 	.start_kernel_queue = &sdma_v4_4_2_restore_queue,
+	.soft_reset_kernel_queue = &sdma_v4_4_2_soft_reset_engine,
 };
 
 static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
@@ -1745,6 +1748,13 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
 }
 
+static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
+					 u32 instance_id)
+{
+	/* For SDMA 4.x, use the existing DPM interface for backward compatibility */
+	return amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
+}
+
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
-- 
2.34.1


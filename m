Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C07C3601A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 03:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2F010E6A9;
	Wed,  2 Apr 2025 03:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jwmigYbM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3B710E1B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 03:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL/hPgulSKyuiAMYwkz8gxSncliYqVMkS18FzKoVFzyp4c06PsKORdsV6z2svxLJBqiGuOOjgJkUujJhFgu/nvj9NkookwyG9Ok7DAvmeA+TuvYMUEKRPXnHKl2st9AYBTn8PcLzlzARKhE5VQXxA/GTd0fOMmBgl+inJghKSbk8MnOcbHxsZbFs4mxQxV8IqYbwglhjV0AM3Hh0iMM90T28BJ5NP7YoHzd+XCQ5kjfbQG1xGZQtIFAY35ZXFvVdNMGPVWJc1inDsF99ET++Bkp3dcPJBN+Z/eQX9crPr78nh6b/0fg4KmmQkLp9e2lBRUF+FCgRjwHVLARchGmrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr1qOPqoMYb6H/1YfeIU+OdmpK9JcnXFVA2r3KFQEq0=;
 b=HCJwTNT5UawcDGQefD7kc5kO0OHfjhsyHnXmkgtHV/VKFQZZk8OsU/9XptJV9bGYgswuRJSk0wUpv8TwXyvPuqkIV7cwqOund4JzKEJcP9SRMMDk1siqNn1BeK71+e8pRj+pNqRVy9Ko4IrtOqeZpEu6Ld0Xee6vOVphUL1jOkpdA7V2bwvkU4xUQV+WZ0e5vuJYZ88sjHBcEfcDqcMYYrx+cwyXoZWrYK3kyofWOpWLw6VAvrM4/zMOciCeK4aRdZ7qRlDgEfQfXG/Twi8ILW/M7kSHZgPxlJaMuGPogeF1s+VpaVue2jDWZOB1unopJTsu7eyIf3YKM1vBX41jJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr1qOPqoMYb6H/1YfeIU+OdmpK9JcnXFVA2r3KFQEq0=;
 b=jwmigYbMmJV2zbYYobPJHQhCD9lAqhRmxKVF9Eso9prAIV+rptNIc5kl0IMhgqBRcTe2usESZPBzLKr16v83npSjRDzPhwu9VBqz3Jn96Hnp6+n669dpmT70QQGPKFKm+hs/pnumBvM8J2A+Mry9T++eNSIRyM7WV/58CCqqlFE=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 03:02:41 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::6) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22 via Frontend Transport; Wed,
 2 Apr 2025 03:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 03:02:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:02:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:02:40 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 1 Apr 2025 22:02:28 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 2/7 V2] drm/amd/amdgpu: Implement SDMA soft reset directly for
 sdma v5
Date: Wed, 2 Apr 2025 11:02:10 +0800
Message-ID: <20250402030215.1074975-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402030215.1074975-1-jesse.zhang@amd.com>
References: <20250402030215.1074975-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: cb008a91-0cc3-4f4a-bee7-08dd7192d55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wYIXLanVbI5DnDzJfD5De4uGO0WBtwklO7RVm73pSjP/orFnrS0NBcpVvsgN?=
 =?us-ascii?Q?GMNh/0pz2JY9rxLSElDcCLLOuFcm8l/g/apJSrLQMBluqVmjbvY/MXXB7mgD?=
 =?us-ascii?Q?XvkBhJgQOW0/p9T3S68OWI5H11XPfwG2lEW9SSdbr1ph+TI3G9BjxNP+iIoP?=
 =?us-ascii?Q?3fKSQ7l1NwfsMpjUAQntIj1RbIu2lJgNUCyDjJziMDqSe/H/KP+/zUjNjnhc?=
 =?us-ascii?Q?KiaAD5IY0eFkkvbr6yQYf6W+wPoMLVV19d2rsnT4S64blYMlZoDRkubjRgMA?=
 =?us-ascii?Q?i4V2nxogmpmg9c2ZRU6oePBA/XcdC/i3iT5DOr4UC6868pKFJlTjKK85RBIg?=
 =?us-ascii?Q?3VBtl2XaoC3t64fjUheQsd9UOR8FKfU3R0hRtEtPCShicXnolbHQeeW781JQ?=
 =?us-ascii?Q?e+GHBl1yKu5x5nUxgmwMwkBvkt0Eagtor8jg4Mf/UT4cGvk8URY9OA/Yy4iT?=
 =?us-ascii?Q?oiZJX7hV7rP888ZKSu6Yi4saiZq5ZSxkC1YPhLUItWtmoklFXCPaxLvn1nQF?=
 =?us-ascii?Q?7l1KR5sf7Om9jYo3xChxMTAa8i3UJN7L350/fB1nXSmes9PgXNIXKPDvdYDm?=
 =?us-ascii?Q?o2JFLMoj2ONzIH+l8w0i+zxyW8oPeX1VTEvNPnsXdeqozNGjrC5SawQjKGd7?=
 =?us-ascii?Q?gpPaIiZheNt28bvPOvMvF6ZnzVbG5CfFdozhfWQURPgBE6SWWfMATn0UThTg?=
 =?us-ascii?Q?k4b8lz+FrHVdDItnbFhQepBBdlaVlcQgqHM+NUBc/+sad/3GzdNeMUUCOECk?=
 =?us-ascii?Q?ELUmGSo7v290TkdrajT3wSiJbVUHJw64Alh4kWNtm+9iOG2Gy/nRyrNSjZUj?=
 =?us-ascii?Q?yFj+FiGeLV87hWiySBHC2cjn2RCNojr4m0pTStFls66BEF+jCWacIP5YWFCh?=
 =?us-ascii?Q?s7LFoxYb9fvdUW07jcU7leueHCyS0uobEbaSGz+2Nbl38hkHj4eOt6XlXcHr?=
 =?us-ascii?Q?UqJ9aMl0jiSiAlH03+9Vg/Kh98xyrZjmsmLOz2ovmBSKiSg6WBlR2/mDid5d?=
 =?us-ascii?Q?a8OJm1DPQYLgTapL/RHEWl0SZjvCB0KQZFGBQwRcOQTA/0aMMaB9JNy6Y8z3?=
 =?us-ascii?Q?07mQ+9HQze4NWKo+dfp0oH1JWlCa3vINC2E0ePE55m6uzpHLT71yGwSVzyLK?=
 =?us-ascii?Q?ad+1zoYbXsyENIpmbGNmJctTZfnKbm3Hk5OqhnUB7raEpc+rHJpuD21DqET7?=
 =?us-ascii?Q?FoRHJ3r9HacOvO1q9dmjNEBtJ3lS1cheKFsw2kGXIRB89sJXh91hRpu8R6Cb?=
 =?us-ascii?Q?eL/RGUHGgdd98M5M/A3oXipms7GIEDKSU1wujS38CUms9PZLp14wFgrrYjE9?=
 =?us-ascii?Q?fxJjUfj3arKJMsfaOpADxVheU8CPQRONkPs8UQ4vSD4mV5JNX4ZYHJ58Mq4y?=
 =?us-ascii?Q?W6WaNB/2ARDObQUZVAyBnGVVWiw1A4XNXxDnOggfFoap5brbmPcpV8iPKPKK?=
 =?us-ascii?Q?8baxYzvYMMKR1s0Ig+3e98KllLaj3yoL7R/lYZ2CdRYq+8w6Tr69sQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 03:02:41.3639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb008a91-0cc3-4f4a-bee7-08dd7192d55b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 46 +++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 7d862c887a1a..dbc7c7cfee01 100644
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
 		gfx_ring->funcs->stop_queue(adev, instance_id);
 
 	/* Perform the SDMA reset for the specified instance */
-	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
 		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
 		goto exit;
-- 
2.25.1


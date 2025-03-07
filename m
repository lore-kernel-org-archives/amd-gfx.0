Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C549C282D0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 06:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4141510EAE1;
	Fri,  7 Mar 2025 06:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hnqNiY+r";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0676B10EAE8
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 06:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq0dzDWKsI+G/LP1e0QXxx9SRHX2Rna7PFSyl5b1FYm6B6MS2Xz8JV5PSodeB96uyZaPWgVcR/fzP7NUzu5+x951b+s1PGA4Cd+b0dggqL9xwxmMtLZqZHUz0HR2tAz4KVMXQSSNoHA1ZvY8Tdqg6V8NFnlE0CG7wVJM5aMTj73yl+lxoSmENkLQEzX0qIKr4y9bsISz7rYzM/Dq5FgBwM5sPpOD2fH0heCH97PbCoysZ8Uhb1OPXRbxbfKSZNoWMykrHE7C6pTRWqr3NtM55ldBF/RP8eFrj1WipiOhfSj435EKKc208jXepOGioeRDM+H/ND0o8SkPC4325qbbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzCUD8jqv3TQM2xE9x47M7ActjhlXBf4/ReWjrXT7i0=;
 b=cUTYdZeSsYFXgVrLlnxtuI2izf9Kx4Sr+R5QI5L1RnFawwiHgJDmIfmUsIi6AprgXVC8h3tdi5XdBRQr6dT/cPsEzc+eMKhsP4dVWuxCGpOihCzDlWvC1+UYhWbOfVJ1AJ2XoohZfcCgc2CFu51ZXgHUifaejtymNcr6DXbjUYMyFivJtWrkQdbuaz1ahRWMsUxAcm92BXFVrUNvnZtZHw8h3s7gVkrEX7ZWPm7f9s/c8tdQE79eK0wtyyBTcfbmD9+or4rhyR/b5QiCdxUCqoS1f79ane/s+MJOIn17ypuZgcl5REJcWzqQvH59HOxoLxlRAQRIU8XbyZ9/htpvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzCUD8jqv3TQM2xE9x47M7ActjhlXBf4/ReWjrXT7i0=;
 b=hnqNiY+rOF/nr60MxhFneqPnS+MihrE6EdY9vYTeJfflxa4M/chvX/CJL3zN3r4hoTKaFFfUtb/X4O960ZgldPO8cko0VRYsUcYYd92meuX4p2td+0JBFzMbl+AYkHHpxTb82C8Ge0fedr7FqAEASwDV7aIL7SSYsj25odm/bVA=
Received: from BN0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:e6::30)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 06:20:26 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::c9) by BN0PR03CA0025.outlook.office365.com
 (2603:10b6:408:e6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Fri,
 7 Mar 2025 06:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 06:20:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 00:20:23 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] Documentation/amdgpu: Add debug_mask documentation
Date: Fri, 7 Mar 2025 11:50:06 +0530
Message-ID: <20250307062006.251686-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307062006.251686-1-lijo.lazar@amd.com>
References: <20250307062006.251686-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2be144-a4ac-4c81-d942-08dd5d402621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GWgqS32SFmCDfe2CHF2mmCWfAjGMlsOB6HpcaQoLTGu51BpeR7bNvssJ2doe?=
 =?us-ascii?Q?T7Sc5NfvErTSQWAD3afEY1ipU/eg+JR6gH5XEFzGvrUMERPO1ZRFAcHOUD/P?=
 =?us-ascii?Q?+yplhg72LGJfcGipNMvpziF+jeLeJtyIefP9VKbXFFCwZhXLdWdzKFMxoVnv?=
 =?us-ascii?Q?XKePjD1so0CtHMI4nsFXJyNbZlXcXu+ZdHwEUHhU88We/kSnOHw9K6QqPv80?=
 =?us-ascii?Q?YAMbBw3r3AKQZc6qbigv04LMjL6pL4jXiyMh0IZFUwUMwgfoGSoB4s7Bbd/n?=
 =?us-ascii?Q?lMhtuqXl9ISjPHZ2Ykw+eckWLYLRNoh5G0irPMeO5G9TgcZ2O9lhF0/8+PjY?=
 =?us-ascii?Q?K2LfW4aj8CZiqvulpwFnweJUHQjlD7KcEeNVBQn/l04/5EV2adCtQmxwKMy6?=
 =?us-ascii?Q?lgNCfkJf5UTk/Hx0lEnGB+zEegBq1lTHPh4TTC7QhL3EU5A7+HveRIc4SlYc?=
 =?us-ascii?Q?apS5NKdNziipmaHUolLvsOU9uPpCgNxuhoFoDifE4zrRq7NMqrr9th955me4?=
 =?us-ascii?Q?K92Aixi11qX9foGBMsldZFLaFMue2B09bCxnkC7B3NRRvZBmfQG8yKuQK/pq?=
 =?us-ascii?Q?V8/n8J4WBcZWqtcBBZ/dGeEcMUHZIDwodlatE1IiGvuQhcTD//An3Mnd48XF?=
 =?us-ascii?Q?uduD/B7/iKst6kdUjATWkCrjmRlFj4EdSyDSidAMTLd4wwfxIlLlzjw/SWVf?=
 =?us-ascii?Q?3C4FaRfiuBLt/9T5r+oEYt9YONVMaYG5TflnrAdzXmNXxmaZJ6lthsuK+ikJ?=
 =?us-ascii?Q?uMFcidnNyOy+DT+rj0IlbLNGkFwF1N1ByJG/AY4aB40lXJDgrLHszKWjJd/y?=
 =?us-ascii?Q?VPwQrz6YVezg+WG5sqfG21W0CgHLP6OovdkJpL3kjQvQ9cPbu8CORJimZiW7?=
 =?us-ascii?Q?pU+xPaafrdSPOmQ4sw8g/+IiGNuNsN3+z19qo0CKFHhTCANK+SRi+LZR22px?=
 =?us-ascii?Q?iJTABc4UFLzEapHBwA62B6fLccWFk7Z+Ng2PzVvIwnbfKw0oeAU+5gDjVDv/?=
 =?us-ascii?Q?xelLGe/W7EYRsu1d5b0uS+vFI2k13RvWZDzPM9w4BQxWvWCYnZM82JtZ8qRF?=
 =?us-ascii?Q?fM9X9/fJfj9Lq272uFA8sObYfPjuzG5JwepGkUBUCIlfr1V/Mj2yz/zmFgFN?=
 =?us-ascii?Q?gxG+3PkQNUFeQMElP8YMMbTgS+/Hsx+PvE6awswGj6QtAZ3MdF7i5rES3SDh?=
 =?us-ascii?Q?ApuSLps1EMkM+yFpmzowTEu8aCInuQ0tJXUR37bpRty89HdCgoZOBmpMFx9Z?=
 =?us-ascii?Q?0xQL8mxhi3VD2fM9P6fwMRp4oC1qG4wxx0hz+JkTTUTf3ocdEdtAlCTqKB06?=
 =?us-ascii?Q?e4snMeNRjv+2uaXEq0hPS6jcYLsNyN5nKglT2//kOIbnHc7QJxF4SZSsP0CV?=
 =?us-ascii?Q?SQnj6nEleDk74SdCR7bTY2LTV6GVw+MbXC+YsA+d6/HmQa7n6lAF9DtyqJ7z?=
 =?us-ascii?Q?gQ5o9j/DFWtXFk+7kfnvh+SY4wkGk+p5yFuKPmuVySZPjHy3bJWcAAUyCGr0?=
 =?us-ascii?Q?S3c6su0lgu7MXhY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:20:25.4896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2be144-a4ac-4c81-d942-08dd5d402621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
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

Add description for debug_mask bit options.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 22775c204632..04b518417da0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1055,6 +1055,11 @@ module_param_named(seamless, amdgpu_seamless, int, 0444);
  *   limits the VRAM size reported to ROCm applications to the visible
  *   size, usually 256MB.
  * - 0x4: Disable GPU soft recovery, always do a full reset
+ * - 0x8: Use VRAM for firmware loading
+ * - 0x10: Enable ACA based RAS logging
+ * - 0x20: Enable experimental resets
+ * - 0x40: Disable ring resets
+ * - 0x80: Use VRAM for SMU pool
  */
 MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by default");
 module_param_named_unsafe(debug_mask, amdgpu_debug_mask, uint, 0444);
-- 
2.25.1


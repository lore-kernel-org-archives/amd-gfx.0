Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E737C19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 15:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AFD610EB20;
	Thu, 27 Feb 2025 15:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJpOarSq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C0F10EB20
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 15:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWVR5EAWIyEgKXu2/sNfrd9PviPentPGSX9wJtwCB5qm6Y/Ft0LCpp+/Oh3PUPtpKXezu8U5EC/einVx2JtnVGmR+h9t27/g8rGnqGlJcvJNqzxUVYEgAMWVY+uR1j4w/iloOcs+MnaTozjb0K0xZeJ928K6A3G8tuoNFD5CYQf01Mc+3X5kmLN8T/q3M7ZzJ8ulHGK9777zOLhxaQyAa9mhkKV85uF3qA3xD7N4cQj86E7OBIxZI3q5ZU+cXLVgKhR6UQavY5paghWQrTJjJHyk3DIjOuDe5MaCK99s1qAZT+MMo6qF3RPgjAwBPvNbbK9FZ1WVJh7pF7QZEP/K4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlzT+R8TdT8AU1vHJNzh4Hwzr2FEWfuDrTyi+8YNGjg=;
 b=xkzCFvc5E0Paa0sL3soUIAOaxMEYSqbNb5umx5V5nyaWuP4JsjbqyUP6AHi47N4pv4u4uZagxWNp9IjQS+/LfkuYqTgJ5WDYShX4syfRN49qzGge4RoMLRvbf5e+zucKisNKt+updB87in4kDH6CXK2MEcjPbX6Sj6UMBcY//JjX/iEZ+8CJP1lPF7RBgsfRHFuVM5L/SRbo5k8NXUx3hv5K+iM0uNmza8BWBFi7gyZgMmSKJEft/kAug+pABoJL/zwBibV+WXO7HeTeNLn1cqLw3as3SX6HxbBtILuQEwsjNmmwLpWQbgidv0rspWRyll1qKEHXGUJ7BlxIYq/a4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlzT+R8TdT8AU1vHJNzh4Hwzr2FEWfuDrTyi+8YNGjg=;
 b=KJpOarSqf+EQ8wihoO/AEr4DDN48K+s8G5EVhthq9aHapp1IBUZkdZ7nyLB4HHqK1fvhdqpqyOAVzMPdOiJ5UBauUNZw3CekmK1GziqM6QFPI9pDXxs/WPEdq/rxBzzZtiCJQRCVKR0/j+PgL6I6D6MZJT8Pgpxs0el2pG/y8q4=
Received: from BN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:408:ee::25)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 15:04:11 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::d4) by BN0PR04CA0020.outlook.office365.com
 (2603:10b6:408:ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Thu,
 27 Feb 2025 15:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 15:04:11 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 09:03:49 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, kernel test robot
 <lkp@intel.com>
Subject: [PATCH] drm/amd/pm: Fix indentation issue
Date: Thu, 27 Feb 2025 23:03:21 +0800
Message-ID: <20250227150321.813265-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 95db0bff-9e2e-44a7-bbbf-08dd573ffe27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+qBJokb+TdsqMo6PEL341yx1eHniFUO+0UL3oi1Sd3HCCNr2Rdj2IEIfk+0x?=
 =?us-ascii?Q?0LPdkZsSMszyUWcd1KIquyTmv/Ow/PIexwBfUxFE9itpKJs2C4xpWkNLKUJ3?=
 =?us-ascii?Q?+qpODRgP99I9zgsGvLCHdSfPZSFOa5sT55csVOBJQSh3PuqU4HzUEvKpxtZU?=
 =?us-ascii?Q?X03CYHr6vlDxyie4d5+eSHcSBNz/MUr4PDmVwdzsQihmHZct+holThUa3biE?=
 =?us-ascii?Q?KsDCj1M3dtGUq5/BubuAtT903/gopMgzBOuk0WnfpLzeL8uOcfGgDAo8sHyj?=
 =?us-ascii?Q?yPpTAYhIPzI88GDMx874GOYglUaIQfc2cSqxTf2gLGySnTdqILaisIAAOZVU?=
 =?us-ascii?Q?+wMy/63T6Y4w554W/OD7m7KbVX71mPdngdCevIMFzgseWvGfmuVYpxUmZyM8?=
 =?us-ascii?Q?E/UFA5HjkzsehtNHAuDvs/ycLkOuXcKSqibB506zY6knNud1NlsrIUK/6bNq?=
 =?us-ascii?Q?Le3uCa1b+ky+Vwx8MHmDagSZSNqd7+8k2HFT6fugQYhg1BnPcdzkI8BVTeR7?=
 =?us-ascii?Q?PXJQyfJjYrwKPdGUuYjOQfyuPo8KOzJ6lTpyBy5qVEliu/p09WkzklQtKxpJ?=
 =?us-ascii?Q?TzufvkHo86Dl7A+A0fol/bRiLHoaC9Gnh58a3VxlbiqMnk0FsELewe3MZcuf?=
 =?us-ascii?Q?9vRtfb/v9dga267Zo+l9lxHPC5SHoTBDIe++y8np6M+T0feLqqN2Ck/glByg?=
 =?us-ascii?Q?u+4Rf9R8NTVfh15q4WFt+Q4a2x9RXdh6EtkJXVU92fOja5mUlEHqoSrwWa9J?=
 =?us-ascii?Q?TYYGiMSSvCLjfk7bjXHG6LYI+FYnx/UR1ZyOvj3Kn3vaRdhctlyiYQTO39Xl?=
 =?us-ascii?Q?npHuqq+V9UfBi5NgE2InwUsCqI3Tt7oxJuV+7uUV0Fulxrv/66oCUggfND3b?=
 =?us-ascii?Q?kMllpN1f4YNQVdjnIXe198oiMqDv8AB2SFhNhJ3diIcVRi9qoALfp3AOSC95?=
 =?us-ascii?Q?8qIh9W4YXYWWiYemg8bPu0Oy304KHMBgB2hX33zvzBicNFzE8XyCw5LIfSmF?=
 =?us-ascii?Q?gE+n++gXI5Ko9UoWoz2CK14l6tH0LQoE3hPq2qGzKOImMCRFi3Uxa1EvDgzY?=
 =?us-ascii?Q?Dylwz62Us0SupKu74+5HUFI4FDO+GDpEKqe/uGJK+ymZXkeAZ0EHirGAjxso?=
 =?us-ascii?Q?3YgxlpsMhPNOhq8mmhDi33EPb9tNKQGcvoJP5//sRp4M6Gl1qklM5LNXSD/l?=
 =?us-ascii?Q?oZU7fbr/y9JGKJRLpLcATT/Z4lOGbjnVD59g4JUX8JKG5WwcueC7qkK2sfoZ?=
 =?us-ascii?Q?zLKVAnfYDHFo0fHl6Bwkra9k+6z5U4g5M9wyKKPtm6ybtggdrYKXguSwwTKy?=
 =?us-ascii?Q?iXff7pOWs4VwsjSx9PZLP2+NznZug0VCyI2ebYHdyYCq1uPlE2V4CEGit+U2?=
 =?us-ascii?Q?Gqf4WDsMQoLa77j0j1yVNI99+LHZBxLwoA/2uxvXfDDUefszUa4O2jlaoKyq?=
 =?us-ascii?Q?gRcK2dLmvrMIXs/UQIGCtU9FU+ndYOkOJ9xbZRczIvRJYnewXynHDgMjgduS?=
 =?us-ascii?Q?F3ukvib4j4kHLxY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:04:11.4582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95db0bff-9e2e-44a7-bbbf-08dd573ffe27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
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

Fix indentation issue for smu_v_13_0_12 get_gpu_metrics

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502272246.OISqUnC1-lkp@intel.com

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 5e80b9aabfc9..285dbfe10303 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -469,7 +469,7 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
 				SMUQ10_ROUND(metrics->GfxBusy[inst]);
 			gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
 				SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
-				idx++;
+			idx++;
 		}
 	}
 
-- 
2.46.0


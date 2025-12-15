Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1D6D41D74
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 09:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A30110E259;
	Mon, 15 Dec 2025 09:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iqW7y9r0";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2319710E259
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 09:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy6Q+x1mYlnJLsDDvF6IQT+/p277HcVEtHZojRkvtnik6iuO34Ax5BO6QD445ekgZGKIbxZXUwbmOzznMYuZq9Dk3QOKeQOUKc5X/+JMCsnOafRPik6RBMcYNMUyfbsWQoBYd6vUwIj0AlB/2ZFqAdgVERm0qeRjyB1MUVgSE4HnE+IrenxRZXzAbT3pPhJ/GBkX2Eizu0yH6kfoLKwm69kKnLy4trwUUitTNH3kqaCnw/sAYksQJvoyDhir7kNpzY+c/EWvGPmjQh/MqMXF3q7Cxgkq+ZKmH2dla1CPtNFGIRZoewX8yCPieTnCDlI4Q5kd4SKCwYThVveMEG2GFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVvgsRUwwpsVCqm5IxVD0cZ5zySmPFNOQV2Rd9YAdr4=;
 b=NvfJghd9kTM5EGMwNq24+mt80SIopwmKOqX9cIsulfAX0sBoVO3djDzDgs+MEDXeG+Nl/u7v+lsZmEommK9Yzenb5pZKiiXoBmZWPjBOofOflGoX3saZTDnRUMhOBIv8gYCgFGol8b6EtiL6XsOXpIgcWZupEvCi9S1zfRZrwMzkP5aOQBWrS8kjz8res7VcipINe7DvgHMzzCjZWHI6EUoBViE/Oub7NuKn57cej/mNXmayg5MavgMUMcT4n9B4Cu5iMakNc0rspdK6G6VgYpXFVEHBJryk3gixDhA892nTxUuu1dOCvYFsjSp+n4+uFxgHUMlPWT1W+Y/0wBvOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVvgsRUwwpsVCqm5IxVD0cZ5zySmPFNOQV2Rd9YAdr4=;
 b=iqW7y9r02Yi68mattkaSVcCE2pwGHE6wx0+mphu/7bq5DW2R00YlGcd/e8xy7Q8MvzeyJ0h0c2g9OHcNiijrMyL0/c8cs7/4eeLpS8tYBizmkxm58CDqJ/zFSRHjx6pScmdOvplIkUmbKQhCrK6rEAboZHUGqRbUqRLjVb196j4=
Received: from BN9PR03CA0110.namprd03.prod.outlook.com (2603:10b6:408:fd::25)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:57:48 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::5c) by BN9PR03CA0110.outlook.office365.com
 (2603:10b6:408:fd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 09:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 09:57:48 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 03:57:46 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: force send pcie parmater on navi1x
Date: Mon, 15 Dec 2025 17:57:35 +0800
Message-ID: <20251215095735.977069-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215095735.977069-1-kevinyang.wang@amd.com>
References: <20251215095735.977069-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d36b6a-031c-41e7-f220-08de3bc06717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ygUzkM+I+cDuWuhNPTQZ+BaTb+cqRfcfNz/xcrsOr6XSN+1W4OGSg7M6/88S?=
 =?us-ascii?Q?bzw0C326XTHnDRt54dX3B+LIuDo58sw4ckyDuUazar7YXC6O0gj0+/x9wub7?=
 =?us-ascii?Q?JM2G8w8RQBAyRr4cgUbkROJFOCulubW9NYJI+KbePLfeo9/4p0BYxbyT0vs9?=
 =?us-ascii?Q?Yy9HTjMnxq84mdsps/0d5hjMp1sgrfysApPJDdx+6BITUa+6AOUt5AQggdwS?=
 =?us-ascii?Q?rAKET+tEIT6Zig3lD8bsWZlY49VknfDfVPCx0EHEGJY92li42q2SsvbkqonY?=
 =?us-ascii?Q?vhvJ/UNLL0EueVyegfph6bF+ez4HzVJHScIc6hp+uNsK2JS/UDZXP8hV4Pqj?=
 =?us-ascii?Q?mFAF+109V1NFEHWlQLFCpXM72EaBw14YyOXMWvtOVvUUCbs80usTW4LO++gV?=
 =?us-ascii?Q?ZFQD3hrRjABUPu4j7wS/MQSBSKM9txQLAyXFe02A1GjOi0p0YoN+9Yx6atRK?=
 =?us-ascii?Q?w6kHu/YUUi6/TS8FdiTs3Tp4fFon3tHgu15L3evFVQOD2rjR00BGOHhKoI0y?=
 =?us-ascii?Q?NYVZUPWqIpBPez8zP6ZMfd1ec9VDzK4vkMDW1rjrRe0DOME6O/0L3VX9OmNZ?=
 =?us-ascii?Q?HeH7pv1dHLl+7gR/43MH7vvmElrr6yLvNWJ9RvRCKWYO9hIa2ZTEj6DXLrPC?=
 =?us-ascii?Q?nhmcrDSon4Cxkqz6+XcKzV6IF1Mcofatpl0+YxI1yF3zRIwKQ6jrISU9QGiP?=
 =?us-ascii?Q?W5qLYuwmvajkQ62bFD2wWlCTKHxYi4vrU9/soH9X1uD19ZJ5sllpsMNIL8Wk?=
 =?us-ascii?Q?YCOIaWDC+vNpb9/4t9X1LlH3p250nDmGiys6cnn0XUZlzWpKMURiUNYLtmAc?=
 =?us-ascii?Q?NMlHcyXlX2tv19drR5znW5wuNnpOBbQ2+CJPGX/ouu5OFLFY8X5+zqTe/epV?=
 =?us-ascii?Q?QpQdAcvU9rM9UnScpl0cJ5h8NjTXvHu9ajqvhDepgG4hqjM6ixr3kEPyjBNr?=
 =?us-ascii?Q?DKnliW2TO5Hm9rAg0cUqpvqnaY6edsFiyZ0OD51Ory/PjdpXoiNb4yhC1h0k?=
 =?us-ascii?Q?avkyh8VTeN9zjJYe0PlW89yikzCC7MrljOmLwYRZUOFI8kwp/ijkFzkojrzT?=
 =?us-ascii?Q?KNQm5BDPPhAXTghHQsuB2tS3+2odaF/wCreDqB50FM1nWOhLpr0qeH1mfFlV?=
 =?us-ascii?Q?/wUiKooi+Rv8wRDkeu4TQnxbAibqdzE+nfuesQlfyUJZ1YarpoFXmryM/QfY?=
 =?us-ascii?Q?muLd8sph9zRPbotKUsJX6zhzgMWJcgKUJA6xrM9ETFE4heSenknvxnzIGt7A?=
 =?us-ascii?Q?/6sl6zqgAC6nShc4HyozSL1ZB85LfYau7fGJeIACdRfYSAzB0Lf27qrI61zs?=
 =?us-ascii?Q?MmFqh5ZIGtW/UQcKAh66MVnyJ75MPzEGkaS0EFHCHVSO8XM2X9KrD9znraxP?=
 =?us-ascii?Q?rALgDbYo4EjthqfMm5lcpHMy06S91jGqKtMWpZI9wI/tap5/ug/GXW8wu/ia?=
 =?us-ascii?Q?KsvManFlWStxwK2gtBFLsKX3QotLRDiO+4xAoZP2VBRzPp8NsqNwn2RLQL7T?=
 =?us-ascii?Q?ayBI4GyIOKWLDZuGTzzG8NIYmSSds03FgBHi3QfsRBxr9qmCVBkQQ6JUKERp?=
 =?us-ascii?Q?xbHPsqGKoY7adW0i08o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 09:57:48.2148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d36b6a-031c-41e7-f220-08de3bc06717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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

the PMFW didn't initialize the PCIe DPM parameters
and requires the KMD to actively provide these parameters.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 0c26fe6fb949..96dbb7a9d9fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2215,16 +2215,16 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 			dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
 									pptable->PcieLaneCount[i] > pcie_width_cap ?
 									pcie_width_cap : pptable->PcieLaneCount[i];
-			smu_pcie_arg = i << 16;
-			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
-			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							SMU_MSG_OverridePcieParameters,
-							smu_pcie_arg,
-							NULL);
-			if (ret)
-				break;
 		}
+		smu_pcie_arg = i << 16;
+		smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
+		smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_OverridePcieParameters,
+						      smu_pcie_arg,
+						      NULL);
+		if (ret)
+			return ret;
 	}
 
 	return ret;
-- 
2.34.1


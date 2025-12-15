Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FCDD59D99
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 10:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD9C010E3F0;
	Mon, 15 Dec 2025 10:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="argfvHrf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D305510E3F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 10:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmNBugvgMioMMsNFgNe/NwKK30YQgkFwbLcT0z5UJxRmgXZuU+piLowekZ8YLx0FA8YIkeR1w7evt2r/mB2RJ5wu5XHUDYMAKqmihLsWU9XoiYQhNWXHXD8K44b/9U6j2Y7mJLR79PRe2u7VjYDIRIvCH6EJfy1LIeIC7Af6gr59nwHdDbyiCnTAO+iX/aln3nWi5HpZZFhT/h1eMzUIz/JbpIzSRc90c8B6wnvLfFR48Zy2SY4CQiGtxfE8T7ZUQAFLDouOgm1mvzsVNlOUqokUUWMLJ6dKtLSJSzhBCzZZWZjdzq2JfLdHGjZvJpJa76lwRtPqMNfZsnUBKvM9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4e+T3gQGud4WRddDBsc/XliSjrGZh+jT/yO2JK+c4y8=;
 b=J9Y8HHkQO4RlvwKPV9eXcX3WKdHjrnuDnuFiMuW4lg+ysbDhJDorPM6NEylh1N2C9cSZrKrYsi9M71rR+I9+OkEtldSDbJV28V0OOdwaJxJZce8k975IDKdd/MC/UWjO1Pl70c4cDwij6bhlQiHXC/6LrNKvXODoRX1kGkFA1eLvi8/8tb24xyeG2CPki1vEOwJpMYtUNJu1tV+ElUrevOQKktPHvpIe+QRYwc6hNwLgw2K+FbzX/mrdLDfYCX7MVJTTFBRoeC40W32ViZfRS9Sp4hRH9JH3mkwsIF491YRuuG6cKRoCYZrraulwhyHa04FEwLhGgidgA6ciej3atg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e+T3gQGud4WRddDBsc/XliSjrGZh+jT/yO2JK+c4y8=;
 b=argfvHrf3N0ru4DV6d8QbOGQ6uOh9oeEU+wtXXtHe2z/CHBUiU2HtF6h9ckunTTbjwfV7/TXbIaSqgdN5tejqIbqvaOIyfX58lQZV3Iv4uQB7/B2E6maXYRfg1dRbgyAju3OWUzFc3UFOsUPkrRF5t5j8byCuiDUfQUpnHPyJG8=
Received: from BL1PR13CA0369.namprd13.prod.outlook.com (2603:10b6:208:2c0::14)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:46:47 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::6e) by BL1PR13CA0369.outlook.office365.com
 (2603:10b6:208:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 10:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 10:46:47 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 04:46:45 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: force send pcie parmater on navi1x
Date: Mon, 15 Dec 2025 18:46:34 +0800
Message-ID: <20251215104634.983674-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215104634.983674-1-kevinyang.wang@amd.com>
References: <20251215104634.983674-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff57756-3aee-4126-19a9-08de3bc73ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lbN9CBXg9TSuPjKhPTcfU1NRkLcFDTAFZBhkF+p7gvV8bk/53+IoCMwR0BtS?=
 =?us-ascii?Q?VVf5vZxOwb3rrNJlT+H4Gm388NJja0G+jK/wkvkIqdW6bqKo9uBPcja4KFVz?=
 =?us-ascii?Q?w72ARz0d2z9oc3zEHLVp3MwN1Xe9UDoGgT7oWNaPhdiKyUWmbzvHeMJJ+1dq?=
 =?us-ascii?Q?a0Lo7FjTe0hDYmOeQD4CgLAfkaeUwWtk1rcwNdDDKk4yhYZmKsodeCKpS8P0?=
 =?us-ascii?Q?RUW33PsFG6UjKZmlmn1YeIgvvCkF2BYcQajwBuBq+iI6CB0rzx8rKRK3JwRf?=
 =?us-ascii?Q?GrrN7PT3VjyNk5gI7loH2sqCK2siuMMgZoa+bLIR4MaA/EbH0nIXYXbFanHJ?=
 =?us-ascii?Q?ErUtCgwA+hy73gb483fJXXdJLGRTLWmcRH9QP9D5Pq1iVt84kcV8rg89/W2S?=
 =?us-ascii?Q?y5Bh0cNemGTGnMSetw8do7AR64SJTcCuaZLf+ScuyYpTEJ+JcYvu7w4QuhB5?=
 =?us-ascii?Q?SQfTNGa32UH8vGyiaQkhBVUF1J6X8mtLaimdPSqjooQfmfHeVZOSy93b74D8?=
 =?us-ascii?Q?iSfYYStlH7/P8EZ/1kjjq8d9wnH7qMzUkJoqClQI5O71vLP8liSEGLBpPyKP?=
 =?us-ascii?Q?vNIhrzdfTJLDNaLvQWC6vm2B8nuh6zgmsmRqIu2q0Yanedq0U9lYpCwMmABF?=
 =?us-ascii?Q?jEGMyh67Uwji/TAe2CzgJmpjBaP2j4PHntYEGcEk2c5Ob/U6n+NCxOyn5qeQ?=
 =?us-ascii?Q?C2cdM4Y13J5vDjpujJjoib1jADbMUOS0aCQrQ7GdqYoGAc5VwRXG8ouj/seR?=
 =?us-ascii?Q?Dk/QXgU7Rmiu+qke0nQt5uxMgwSGAyC2NbkBlUkhUfBChjGAo2YH8nxwxBj5?=
 =?us-ascii?Q?a7Pf0w7dcJa0CZDA9eGeLegkBn0t6RrLGCW34tkWASpUVdRO7km4QppcJi2I?=
 =?us-ascii?Q?hxmUpTbDWuTDsimIBmuedzdJ+PpEpQlHNkOTEVscX/+Uhlp/QfseXLSRhfkT?=
 =?us-ascii?Q?57Tku4ZRgA5aIjwEYpxkAHnNGyKQ7bCQRseCfaL5FR8iMyHWQbxEr757JPU7?=
 =?us-ascii?Q?WNcs0S2awrXmmgMM4NwFShDSCCrSsefjywLkYKXL0cnSDlsS5Tp+sDktmaoH?=
 =?us-ascii?Q?Tex0UAVK/UiQ7EfDoJYgFQRIWDmJHG/P7B22Hc2gkcCV/Bj09wJuuRohJ+RL?=
 =?us-ascii?Q?vG17rR00n8YvJo6eP9Fklni6sQJNlegJP/bI19KCU2lZsRne0k2xNA5PjWo6?=
 =?us-ascii?Q?s/DVTxW2iQpCHqeKHjfbqVOHc9BN9jlX0qf2Vqp4Y7YEFaNexdkGGgw7ddfF?=
 =?us-ascii?Q?yv5PAgF0ARV6/N1HwEcdXXCVKD23XP4S14DsZvOjiHgkbJ+Dn6mJ8JOOg2NN?=
 =?us-ascii?Q?zq27BtcMGv9rxU8q4SbFc4nWjmrTCQN0k/HNY6z/Cb2CXsq9NJKMpaqNN0Fr?=
 =?us-ascii?Q?8lO66P1R36CK2iuu85q9CD5yvNSgCBqET1D6xgPCr3A7Is9FoJUVrKi4Qgu2?=
 =?us-ascii?Q?h20bLMenpZcv4zZNNMk2/5QTTyKw6t7TF1gFbpysD6BLmgp9SU1cn16mSTVa?=
 =?us-ascii?Q?e/hIxlMx1co/9cX8QvMdspSJaOkTEctwhX70Wy1DvDLGniuAgVMPDpuJ2w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:46:47.1051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff57756-3aee-4126-19a9-08de3bc73ece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442
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

v1:
the PMFW didn't initialize the PCIe DPM parameters
and requires the KMD to actively provide these parameters.

v2:
clean & remove unused code logic (lijo)

Fixes: 1a18607c07bb ("drm/amd/pm: override pcie dpm parameters only if it is necessary")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 33 +++++++++----------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 0c26fe6fb949..4896200a0bd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2207,24 +2207,21 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 	dpm_context->dpm_tables.pcie_table.lclk_levels = NUM_LINK_LEVELS;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
-		if (pptable->PcieGenSpeed[i] > pcie_gen_cap ||
-			pptable->PcieLaneCount[i] > pcie_width_cap) {
-			dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
-									pptable->PcieGenSpeed[i] > pcie_gen_cap ?
-									pcie_gen_cap : pptable->PcieGenSpeed[i];
-			dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
-									pptable->PcieLaneCount[i] > pcie_width_cap ?
-									pcie_width_cap : pptable->PcieLaneCount[i];
-			smu_pcie_arg = i << 16;
-			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
-			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							SMU_MSG_OverridePcieParameters,
-							smu_pcie_arg,
-							NULL);
-			if (ret)
-				break;
-		}
+		dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
+			pptable->PcieGenSpeed[i] > pcie_gen_cap ?
+			pcie_gen_cap : pptable->PcieGenSpeed[i];
+		dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
+			pptable->PcieLaneCount[i] > pcie_width_cap ?
+			pcie_width_cap : pptable->PcieLaneCount[i];
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


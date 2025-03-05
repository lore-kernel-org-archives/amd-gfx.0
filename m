Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A77BC28B22
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 21:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F94610E789;
	Wed,  5 Mar 2025 21:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C3TbEDHV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E4310E789
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 21:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqET3v90hFFQM6v3ily8P6PfyjTJW7GQhvDJ7+uqrmLPMIEnHtX2he9zGiqkfcb4zEnur5HcWjR81WaGOpRtabb8O1SF6Ug8xYmuOraAwtjtnSlzKkMVr1o0ljaRMHNqhitMTD7dRTQnBcDOeM9FTHsAvrj04vNQbIe6TKsNeqZtLAgFni/teo5WpMJP0ZIJKBw1v7RBJ1W5UrEJUEDKyCMT3zm2rrpuGjNsFGIpSlDSDrLnnNZYVXQfDe2+Av3dZBHfHRFluejmNQWy7cS1Oul0g7ICM87RoStiash5H9iM5615v9EGUm7/X8ykJOvx+lbY7yRlCpxV4gbv68+fHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1wCzuJ1lrEk9pfptkHzvZH2FnkcUTBwHCnuzTcYyCs=;
 b=afXyc6IjbkATbZgHv9Bo3eRHqfzT3KMHrOh/yB1gEJyASmtysUeKlRNZEMXxX978xOcY04mCxoIMoM5rdxtH1D8Ej24JN1KAMEsCxnbDtzMGMVw163Aq3vA/UZr+cJo7Tk4BLW1/wdDFLM2uBvoIqgfVw4GPn6hXBgUexvQ8rjUEug6RUZtjAet1l65O+m5TREQg8MqQ1djwmxfVDo96bGJSPyzV6uz6EjoSrMG+j5lUZwTTPWXQ/XePnI1uKn0/gu1BCqLbupp0cVjxX/JFn1gEuTL73Ng90DEMis7XwRumXrZx8KSfm+Qa7KFaLgIJZoCxBdXR97Uq3olRZkm3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1wCzuJ1lrEk9pfptkHzvZH2FnkcUTBwHCnuzTcYyCs=;
 b=C3TbEDHV9O7/cnIAtILrgA8zKERq1WTAZCOz1conoKw1eKvARFf/WN78Dq2qbkm7GK+RxsQpp1QYcsK0i+Izk5zsoIf074Q2jUwShi/choDX1rDVAyp7/rJ0wUk69hiaYsnRkc+MLdXXyewzIwSrkKpcTzfPhzazuXqL7xOEt1A=
Received: from PH0PR07CA0070.namprd07.prod.outlook.com (2603:10b6:510:f::15)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 21:37:58 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::69) by PH0PR07CA0070.outlook.office365.com
 (2603:10b6:510:f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Wed,
 5 Mar 2025 21:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 21:37:57 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 15:37:56 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Fail initialization earlier when DC is disabled
Date: Wed, 5 Mar 2025 15:37:42 -0600
Message-ID: <20250305213742.13559-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c5c274-1898-4166-ec1c-08dd5c2dff23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iddBssQcV3KkvaYikbX3bd6fVPUu7c+K8zlWgL0NezZhuSQlyHSL6+Pu/y/x?=
 =?us-ascii?Q?dmdcYbhneesNGES7rK1R3n2CFpX3L2L5vOylVch6Ey4j6moRrp6oxLOawpag?=
 =?us-ascii?Q?U5UFTrstCQlA5yKZFgkvqpDpIH6OSVuYzA5EtY/AuJ6rIMdbS4MmTkPa9PQP?=
 =?us-ascii?Q?saFxM/Fsv+grJOgQsXvQy2mKZ5jMtQEN4bR01I6wrkVHyvE+UB88a7Br0fzD?=
 =?us-ascii?Q?OKZ3dZsP+gL0fts8YUIjC7hdrnCcaIjJ5l9Ds2Wm4KzMTTkC0TAgbGrDCv1p?=
 =?us-ascii?Q?/w+VQvSiLpBcFRQWjgMRhBJHZcuEDpr5nR3DbYb6YMRB9TMKbkY+NJqqTSFp?=
 =?us-ascii?Q?sjudYf8pOQATaM6rd+1jq7hYof9c88xI0U0SiKD2omtW39TZZaCEQkiTnaOS?=
 =?us-ascii?Q?kA/yUyyeI9RlxzkiKiI8OJHYDtruXkCNFN0JTg6H3YQ6Q4ZJPo+ekuA/Xx+Q?=
 =?us-ascii?Q?Oa8G2Lg0USHi9ktnzPoTEFpjU01lE7bKBLN9uNz/wnjgNIfHVtDV/7Jwo+7p?=
 =?us-ascii?Q?41AQqc0/081kfMOnsV4W9aHmcl08XibrZogiX2jg3ITzxesvubotS8eH2lOh?=
 =?us-ascii?Q?lS0f/aIeeFPnVRQOqL3hLF2O8Fja4R3D8HNAR9ao1pIhrfTzCMMVXpCufZdx?=
 =?us-ascii?Q?jAEUO1YD9XiMYdf1mgdeFGi7clBLWCHRJyXgwwTfqMKwiQi/cPaA0QBPkVqd?=
 =?us-ascii?Q?10YpaPlXQLoe70xx318sijNE8Je2NbrBjkRJq1XGdtOkneF+MGpJ0HKxCIQK?=
 =?us-ascii?Q?1zjKkgQduDmC1PWLK8w2wtpU91k4jTHMkPQgyEkfenN5aMHEw7bVKp0UaVk0?=
 =?us-ascii?Q?wcedqWHZccZLffaALFpvvavCzO8j2TKPPD80sHhCXWJZi/rRefn4qWdoMvnF?=
 =?us-ascii?Q?r3cNCIpQVjNUqbsharDb0NF/TMiH12dDumvogBEXuLnZA6+QTV5dkagPjmS2?=
 =?us-ascii?Q?MiT9mvo/p704JYgom83rG4GmfcNd+kwvm12tvTj4FCbMrqtjTECbLAF8bs8O?=
 =?us-ascii?Q?9PeqsUFXwpTDAaQ/D33Lia2ilInE/bHGqvijCWBhcOAqutkmAI3Z9DZdH6rP?=
 =?us-ascii?Q?l3X0shEVxwu2Gjc65grEVEbVpQRtVAC0ESY/zc4T+8Ni0i2J1u3hdtxysojw?=
 =?us-ascii?Q?gMPbe0Yas5k9dlO9WmNG+beJ8MtRAgXAtA/4l5afxD+HJRQnHWlq5KlQpg/x?=
 =?us-ascii?Q?SAlT3gYidH+SU+NbqllFAlZ7jeagNEFX1sCp05raPZK2ukL+zx4jEoO1wBkm?=
 =?us-ascii?Q?3uzHGOyacX/m0RZU1msEYwU47GqmuoVPZ0MER90HTSEn6cE82jfGi7HdyFvt?=
 =?us-ascii?Q?0QKk/yzroLfX5/ZZViU7QrDeAY/NFw8wv+6McEP0+mbQcY6qgd0aRd6L3Rp/?=
 =?us-ascii?Q?NGsa8qyAj7N4s5rwHEdN4vQnvQs76k7aUcbPPHAHFajVfqFHYo/bcrChMmeT?=
 =?us-ascii?Q?iaUlovTxLhXD2NHE7kWBGrvbS5xoqftGfHmWtNN4/sBXIkpCkxWk3lZ2qMHt?=
 =?us-ascii?Q?xx8yJzsgVH2tTyo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 21:37:57.8587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c5c274-1898-4166-ec1c-08dd5c2dff23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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

Modern APU and dGPU require DC support to be able to light up the
display.  If DC support has been disabled either by kernel config
or by kernel command line fail init early so that the system won't
freeze with a lack of display.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a4258127083d..c4e1505dcaac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2139,10 +2139,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (!amdgpu_device_has_dc_support(adev))
-		return 0;
-
-#if defined(CONFIG_DRM_AMD_DC)
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 		case IP_VERSION(1, 0, 0):
@@ -2166,15 +2162,24 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 1, 0):
+			if (!amdgpu_device_has_dc_support(adev)) {
+				dev_err(adev->dev,
+					"DC support is required for dm ip block(DCE_HWIP:0x%x)\n",
+					amdgpu_ip_version(adev, DCE_HWIP, 0));
+				return -EINVAL;
+			}
+
 			/* TODO: Fix IP version. DC code expects version 4.0.1 */
 			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
 				adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
 
+#if defined(CONFIG_DRM_AMD_DC)
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
 				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
+#endif
 		default:
 			dev_err(adev->dev,
 				"Failed to add dm ip block(DCE_HWIP:0x%x)\n",
@@ -2186,11 +2191,21 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
 		case IP_VERSION(12, 1, 0):
+
+		if (!amdgpu_device_has_dc_support(adev)) {
+			dev_err(adev->dev,
+				"DC support is required for dm ip block(DCI_HWIP:0x%x)\n",
+				amdgpu_ip_version(adev, DCI_HWIP, 0));
+			return -EINVAL;
+		}
+
+#if defined(CONFIG_DRM_AMD_DC)
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
 				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
+#endif
 		default:
 			dev_err(adev->dev,
 				"Failed to add dm ip block(DCI_HWIP:0x%x)\n",
@@ -2198,7 +2213,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 			return -EINVAL;
 		}
 	}
-#endif
 	return 0;
 }
 
-- 
2.48.1


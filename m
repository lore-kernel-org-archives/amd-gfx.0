Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227E0D5E374
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A010310E8E9;
	Tue, 16 Dec 2025 21:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vDNmPMu2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF0D10E8AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCzAKerGSp5aVAD7f1eZJ1WkXoEW2/L4xB0TTBUtbPach5RInLqjqBfcWYpIW6SIkJD3XsOPnTbqFN0jEuij4RN290yoZY7/qnHXbMY47I5s3Nb7cHBEp5IO62VQH+j+61GfzgJvWhAlHAorP6ZtWdTRasQr7jPTxYZWUHS13L96hE2lvEzMOWnAnLNWbDGwO2cVH3dt86n9ZP2ycOK5vv/O9p0Q+kkxHEeBgSmcsWZd5q802K4dureAbhd6N7HNZPoj5c+XbwcpzevLykscD+w4j465I027DHHwQpbRq7/i/REGV7BBDglJQ7cWWXtqXxqSAFg8JBnfYmh1o11vjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owofwdR0BipzuluKFL82pTfbMzulTv8p9XiUcxVzUqM=;
 b=NWe9Rh9jumLV/MewG/o0bqKTeqDtMh833Vw1Z7eIKRKmw3szmsq4JlyFMXtYw+YSp9x57dFGc9EzbT0Qixp5LNyBZkQx/qZ0QUoog3dd3+qMR08If+52tRQb/N3P9+zsWsT1bzjWl95b+n1e0VsOajyQ7Fu8XM/LRX05uKeiR94xRAcDBg8bIkaRCdO1tZcfFTzO7gj1Cxmt1LcamKM0HRMULtmq1smb8zs5h8PKdMSCRm+a/BqXK4zwcMAU12HpmKcK9BjZH3x6ej97eReSrI4IVSXD90j2TE3FqtJ81QfTkjJDpRv/QYLAdfL4RamJXQV8PINQU06Av0fMBWcnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owofwdR0BipzuluKFL82pTfbMzulTv8p9XiUcxVzUqM=;
 b=vDNmPMu2x0JoSqTWLgvrHOYZ+3s6Ynk0x3/JdNCk42NluISsSZ8028xR0Oe5UbC4o38RpmgYfKC6SsXLTFYH/8fUhn+eigQVIzPB8hLAuUt1/hk+nAOduUjNDz9K9cuE4ang95/g4ab4TCViDUWW6JYYCpqiP9ugjPe5cvWJ+Q4=
Received: from MN0P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::11)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:10:32 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::82) by MN0P221CA0004.outlook.office365.com
 (2603:10b6:208:52a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:10:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:10:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tim Huang <tim.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add support for MMHUB IP version 3.4.0
Date: Tue, 16 Dec 2025 16:10:09 -0500
Message-ID: <20251216211009.1963990-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216211009.1963990-1-alexander.deucher@amd.com>
References: <20251216211009.1963990-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ba2acf-4b93-4e57-401b-08de3ce78c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QO/F/m0D9P8pri5jgnmUTHd0Yf2TXcctDUFxQaakUKj+0SW0zjapr0XX4Kxo?=
 =?us-ascii?Q?mSEjj/zC/HT5ZZiMi8jwDjdoDL1IcsQJKI+qDnvWLLGVowO+2T89BVJBTDM0?=
 =?us-ascii?Q?ReEAOqnaagloxvqZZLJPWh2xsFiTFgBmwaA/KcotLVC3vgRmuhZapkwzBs3l?=
 =?us-ascii?Q?xEg02X+Uv60E1yQFe5DE0DUXSOapBVKNcAdMiSymPKfxLKGvRn/v2LuvfEg/?=
 =?us-ascii?Q?Ltg/UwAQY/knP0cVkemZWcephDLdfew3E9W9v7OQrgFrPDV3wk76tlyJ1SFm?=
 =?us-ascii?Q?WfQhzf3LtA8+giZQyIGW1aTm0BwSXA6uIp9lO5keI0fcA+E2mTsD7hp8zmlN?=
 =?us-ascii?Q?qHBSVlyHxmWp8PTFfVoQBp9P7lNN0yH/q5F5r2pMck1nfPophav7JF4rzvg7?=
 =?us-ascii?Q?cX/MQzJM95jsy+m0sIekW0PGK1n0roLftR4Fqflju9FShaYKGqp2+1iyxsQJ?=
 =?us-ascii?Q?/juF2Yz9Ujs8rYE7CXJzwCWmdcQfSqcFMmWGxIaaLm79HulMGV5NmKh9lTy4?=
 =?us-ascii?Q?XxxKyawl0LNVXnMi/Sa4tMcMZYlarWVfWH7rsBLy+xjNUB0H1/I4MATrJUIg?=
 =?us-ascii?Q?X0IgnFT+Rvo2uXj7ZqaeaIX0qGEfu7HkAeouIlEPBjdiEAYnenh4sx/Krt+j?=
 =?us-ascii?Q?C764F9tWzS7Iu1BDA8F8G31ZXHyvt3Iry9vb0SpduqR88ggEvu+pTQA+8kUX?=
 =?us-ascii?Q?RV1WFOsSBCBdBlX4vos4PWm/pxIuMqxkmFAN2Ut1rekh2pGPodKkk6hvAYmW?=
 =?us-ascii?Q?JqhTHRY0cPWNMXmkru5nNZaGlFCx76va2J+FQNZvdgjRXkZJiXpRAq1da3cK?=
 =?us-ascii?Q?/kdhPe9aT1Z1n5NtEY4PaMmD9C8OLupMxK1cqXfiEg3Dri4c7cd7TWwbJoFi?=
 =?us-ascii?Q?IYNphRGz+HcBrBKvKJDGTJXPm+7rksmlPQGNZLFxlstmeXsTz9dbzc6Riuct?=
 =?us-ascii?Q?uN3OajzqO/DuUyPnyNEwTt7EtpBjF+c2yRLEatAOGuv1NqOeTyGcFLQNRkeY?=
 =?us-ascii?Q?BwQhmv4oZZZ2nafY+vFOXQrwRNJZ0hjL+fnMEpGAl7H1t1jMAcJvFT1vKNYG?=
 =?us-ascii?Q?+Mx/1RWRttEq/y1NKNqjxyj4i1IiFraA/eEmXqidfiSXAqAvY8T9WZ73eaLn?=
 =?us-ascii?Q?7cgxLvcoBOa73tlxkjB7MnhtIpn+27Lq6nj059C1hLXXq4bbqDW7b6+0s++f?=
 =?us-ascii?Q?a3UfBoKthI6ImKkNLnqGKvfrTNnGibvPfbMPiHzkeMWX0JQXPmX9y38oarCR?=
 =?us-ascii?Q?kKhhEMLCe/9NEOWYgE5c6ndD8EeVOg/Jx0vLUz7wFXpOjrhzwnvgA4sV284W?=
 =?us-ascii?Q?rUSAzJtXy0ucy+IIkyngSEO5qV4QF0Kp0nHVVX0LjMNiF/Xj5a3ZycdXrrye?=
 =?us-ascii?Q?F7ZIf27/maaXf6NXrlzlI92n/ED1VpvRRE+EgmspijyV+LDwUb2Yg8vl7j5S?=
 =?us-ascii?Q?wyGaRPPCFJiylYRE1WlJ+eZcYZmCNJDbxjBfzRRo9sK9qyKsTSU+h1FDDGQm?=
 =?us-ascii?Q?5/k2LRmUiCrxaaUNKydzQk1tUxnjBZ5KT+8ssSZZ6FpS0LayYUMEVjvvEsee?=
 =?us-ascii?Q?x4lJ1OIeVjdlqAN70aI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:10:31.9696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ba2acf-4b93-4e57-401b-08de3ce78c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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

From: Tim Huang <tim.huang@amd.com>

This initializes MMHUB IP version 3.4.0.

v2: squash in clients table update (Alex)

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 34 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index ad5e512e3fb8a..7bd361057c3c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -584,6 +584,7 @@ static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(3, 3, 0):
 	case IP_VERSION(3, 3, 1):
 	case IP_VERSION(3, 3, 2):
+	case IP_VERSION(3, 4, 0):
 		adev->mmhub.funcs = &mmhub_v3_3_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index f6fc9778bc305..daf1f8ad4ccaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -163,6 +163,35 @@ static const char *mmhub_client_ids_v3_3_1[][2] = {
 	[32+30][1] = "VCN1",
 };
 
+static const char *mmhub_client_ids_v3_4[][2] = {
+	[0][0] = "VMC",
+	[4][0] = "DCEDMC",
+	[5][0] = "MPXSP",
+	[6][0] = "MPASP",
+	[7][0] = "MP1",
+	[8][0] = "MPM",
+	[23][0] = "HDP",
+	[24][0] = "LSDMA",
+	[25][0] = "JPEG",
+	[26][0] = "VPE",
+	[27][0] = "VSCH",
+	[28][0] = "VCNU",
+	[30][0] = "VCNRD",
+	[3][1] = "DCEDWB",
+	[4][1] = "DCEDMC",
+	[5][1] = "MPXSP",
+	[6][1] = "MPASAP",
+	[7][1] = "MP1",
+	[8][1] = "MPM",
+	[21][1] = "OSSSYS",
+	[23][1] = "HDP",
+	[24][1] = "LSDMA",
+	[25][1] = "JPEG",
+	[26][1] = "VPE",
+	[27][1] = "VSCH",
+	[29][1] = "VCNWR",
+};
+
 static uint32_t mmhub_v3_3_get_invalidate_req(unsigned int vmid,
 						uint32_t flush_type)
 {
@@ -211,6 +240,11 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 			    mmhub_client_ids_v3_3_1[cid][rw] :
 			    cid == 0x140 ? "UMSCH" : NULL;
 		break;
+	case IP_VERSION(3, 4, 0):
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_4) ?
+			mmhub_client_ids_v3_4[cid][rw] :
+		cid == 0x140 ? "UMSCH" : NULL;
+		break;
 	default:
 		mmhub_cid = NULL;
 		break;
-- 
2.52.0


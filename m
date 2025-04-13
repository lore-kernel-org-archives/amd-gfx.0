Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4543C369B1
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Apr 2025 16:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4B8E10E0DC;
	Sun, 13 Apr 2025 16:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDvrxeLT";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D063110E227
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 16:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chMK1pBT8XIrxfrxHphJSEj/svqFzTBp3P0W8IWvhewd9XnshmJGgIvfAIbNQ3j3frTgW2QnT+nKO4w9DRp1cjll3OjQuL6yZiPwRSLsRwLMeKWAgSy12AVuV4OHDyKXlpnGYvysrD8k60uRW6LAlh5tYNnkB6H77kvNMfl+znFx7HhkjXs+zfoUjs22RMFiLo/JS++61DM/ZZG+/4lZOr6MYnPZ/AxAUwk/sUnDDJf3MPC0UEPGwMB0WFHMEI+oLBixk+NaAJnfO/cDobq2+C9DxIcWgTVfcrEuZpMgXs49obVHo4PvYX0dq7MWVXtOzEBxDJVyC9JJIP0CABN9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5HObqqPIBQUalmweNp5FeNoIcop786Fccs0Cc/M5mQ=;
 b=etBHFcyx3kjV6H6D9XtmcrjhkHajhJG1FoJWKyF/KQyiv9X3dA2RZG6f+XJqcIU3CgA2rjig3tHrn7H2C1NU87P0Urxx5rrOfzwOWVmXFZTEgxk1UK2a2H6f9UN4AsrW6s4QXorxtGYWp1Gf6aW6kTBhK7OfKu4RXmbdkhr9cwYmfUt0B8aKN9EOWRVI9NcpJq9bDf3IGDNK4pGn1h6e6OEjJcOrBzPgkdT0/nlsABWfxKi93GmoQxmmlt5xp7oK9vzGKrTqDZPbgntlzmtVJIvFcjUW/FoEnSRghW0VW/b66QisWBiKxoXVuGImD9M0ktVSC2K4Ldm/NqbbJQ+z1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5HObqqPIBQUalmweNp5FeNoIcop786Fccs0Cc/M5mQ=;
 b=yDvrxeLTyKvzEDA20mtRXno7YYuAumpt3++2oEihGinfUIuMAICLXXD6qfF6VI4Bm8DJ88IeHLAy3lCdN1KgGq9bgNsOJFDHbgzKZgSjJVV7naqbrbDdaKDO7DD9Z8keSSmGXRgPnw3l05Y2p1NqxqSyfCL28fe9TyUKjGgPDes=
Received: from MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) by
 DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.33; Sun, 13 Apr 2025 16:06:23 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::32) by MN2PR01CA0061.outlook.office365.com
 (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Sun,
 13 Apr 2025 16:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Sun, 13 Apr 2025 16:06:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 11:06:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/sdma6: properly reference trap interrupts for userqs
Date: Sun, 13 Apr 2025 12:06:07 -0400
Message-ID: <20250413160608.2198429-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413160608.2198429-1-alexander.deucher@amd.com>
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b8cb29-b6b2-474c-1a40-08dd7aa522ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3j9t2hyV+CzvIeuRfYbqGciQjQD6XmsakSN2G7wmAmOTgUbQzxfXypDN0iW+?=
 =?us-ascii?Q?tA0d3MXc/JUdGcx//E3C6PEVUYVVs+Ftg7ukGCaccthuezktggCd5fV4lbt0?=
 =?us-ascii?Q?ySo1CfUKiNGxntN8aQiqTYaCYcWCDmR2nwAIiBrlczt8R6XqtRnnjUPbcYxR?=
 =?us-ascii?Q?0xygKhPGUTD3ycz/KXOC7DUyhNB1NDN46bpwbGS6MAPUJs9zI1vUsapVvXL0?=
 =?us-ascii?Q?p3FtVJA3uzX876NNcndG8aNiAWW9tdLpu3Tx8rZs/NJKHSBkt4u2LCHX6yMG?=
 =?us-ascii?Q?+AK2YdYpxUMeZ5//nU9n+Lca2U65UqwKMNVuiS5XHyE3HNo+pcmCDwbjycBq?=
 =?us-ascii?Q?GWhiXNQmDHlnQ4ixDA9Yiue0TAMOMjw6y2PRfg1w839PawGG6u8tFPlZRXGu?=
 =?us-ascii?Q?0sabdMvJUwVb04rHLyAi7d017AHaenZEwxLCGG+enWjZJp/dX1XtupRXdAsN?=
 =?us-ascii?Q?TlOovkaPGCM/QmSqLSVmIocab5lu7zq9Bu754FR2Lf9eEON7YXJstQkI4urZ?=
 =?us-ascii?Q?vZg1tjRm3H5oQxqNAkQVxVJ8M9fraSCgaE4Wzp+knU7ZfidisVsMsOJdBRZL?=
 =?us-ascii?Q?1OP7hwVaDJlZXvHGxAjqJKhTpxROXDvgoPdALVLn2ocEfpMqcoPMv7PkZDni?=
 =?us-ascii?Q?Gh47lKeBmOIEAisF8vbb0m3IfgaqKMzJBd0dbeA/GVurQdcOU58s0gfdXEFu?=
 =?us-ascii?Q?6Y749q80Qe+ys8OAvA+zvHbF3p0WwPUc3nNeQmzJqcVKhvblSRaCxMCSr4K9?=
 =?us-ascii?Q?fWEv5pF1/WQ/brVWC3lIufm1qDJ2xJyRxyN5lCV9QAb1D8Mz6X46Hmh9oUMc?=
 =?us-ascii?Q?m3DfgkiAHmK4d0gA2Av60pBg+b8qpgZfq5qA1ME+eJwMfx0XeMkYGv/kpRvT?=
 =?us-ascii?Q?jVefIXj7uaFSHdJLdjEf03e452gpSsEp3eJleKYTMNLyEdrMMWVrD/70Pq9G?=
 =?us-ascii?Q?Xy6axIObN3qGmpisvZifyBIoFjbmmQ0toYA3jjw1o+EXyBD6hrUIF0AHmDL4?=
 =?us-ascii?Q?TVrPDsToTEMQtf9RPhp9SnasYkdP/NsuKzzt57VBf6O7UZP0o8L4kupOSMjU?=
 =?us-ascii?Q?rXh45o2cj8BS3pGK1bUesZBHnCsJdiu/XH6179ol5ZFektxGE/FYFuhOLmx0?=
 =?us-ascii?Q?Gn0gX4V/HBLPRhYyCDkgyPbLik/8SjxdivJ8fsJQ8WeFoOQuwSvxRsXV+kNL?=
 =?us-ascii?Q?kGUZaP93Neieb8LUjF0HrnqmonUQXZN2ruWWVNAz2MH/C9R3t20fxaisxsCj?=
 =?us-ascii?Q?6wBgTLI/zO6Gas4HCrpXryVxjZ9DNecMKKY/PxyrZ6sHXuxo+41GqNpNWjBQ?=
 =?us-ascii?Q?um1KrCguGOhaH+hvLw0tL+hW5havDwDVlXEblvdw/8QH5cNEWb4giqa/cPuB?=
 =?us-ascii?Q?Yjk01aUY4hrR89sRAKh77DYmDSR3iCRVf9zsdG/Gx9b0DIdzvBFS29g09iWe?=
 =?us-ascii?Q?+DOQpWhxsdsq5zs0hyBn0tGXY0xsp1ViKGl+fno9AanS+bjX8MtZfipy11jV?=
 =?us-ascii?Q?66qiB9OMDAcM1Qk9QUUY36eQzV7VwbiWEuN9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2025 16:06:23.0100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b8cb29-b6b2-474c-1a40-08dd7aa522ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
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

We need to take a reference to the interrupts to make
sure they stay enabled even if the kernel queues have
disabled them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 31 +++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 2249a1ef057bf..c3d53974e7f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1377,11 +1377,39 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int sdma_v6_0_set_userq_trap_interrupts(struct amdgpu_device *adev,
+					       bool enable)
+{
+	unsigned int irq_type;
+	int i, r;
+
+	if (adev->userq_funcs[AMDGPU_HW_IP_DMA]) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			irq_type = AMDGPU_SDMA_IRQ_INSTANCE0 + i;
+			if (enable)
+				r = amdgpu_irq_get(adev, &adev->sdma.trap_irq,
+						   irq_type);
+			else
+				r = amdgpu_irq_put(adev, &adev->sdma.trap_irq,
+						   irq_type);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
 static int sdma_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 
-	return sdma_v6_0_start(adev);
+	r = sdma_v6_0_start(adev);
+	if (r)
+		return r;
+
+	return sdma_v6_0_set_userq_trap_interrupts(adev, true);
 }
 
 static int sdma_v6_0_hw_fini(struct amdgpu_ip_block *ip_block)
@@ -1393,6 +1421,7 @@ static int sdma_v6_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	sdma_v6_0_ctxempty_int_enable(adev, false);
 	sdma_v6_0_enable(adev, false);
+	sdma_v6_0_set_userq_trap_interrupts(adev, false);
 
 	return 0;
 }
-- 
2.49.0


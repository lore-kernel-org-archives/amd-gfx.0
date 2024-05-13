Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBEAC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 07:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152AB10E409;
	Mon, 13 May 2024 07:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dP2wXKG3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B87710E409
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 07:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz7zwl84SjfrNRaXtLsaXG/7hvDU2OqCvN39EhQ09xw5ciSvhq1IXfdB4BIhhMHohMBEly6X/wa0qrHqqM42d8Gmu4qLfnhzXp3yUdAi6f6Ma5OQJcyRdiyNtEWahVOZPDD0JmtZyVHwZUQoZdBKjC2UVwncoFGHmuzZFcoj1zplG5G4a7Bk6RMZi7KwysXMZonh4TH1JAGF0sXcFUkCHkAB3SGMQtBdRRukCjwRxQ+RYMHLWlTjGl18LN/bZN0SncSVQUUP4sxz1iXXd6/krk8uwKZfU1g4YGfHS8BXtE61A5O02l9LQ6q0Fmf1a+qhsFTgPyzGD4ik/uqRKsxcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ3YFt3/NFL8+MvbpMKgkWMasBR5gv7hDAyajwdiri4=;
 b=HSmW4n0UZdG9Z6+tIMiN+6BcJUlOv0qPpBzXzSA1XU0yK2dVCjsJx5ST20KVEOBmZ6DpvnMXD6eI42j0cbdCpDyBfgJyGRaYK7uK2Y7dirJIf/EzVoubtWN/MeTOxH3XAcCL/gbFKV5kkfRhx3c3OchhsJKzx4+np/T4hjjkqnzdO5u+p3pKwjUJuYTSMYcrBvp9e86nieXtJXCePUV/J1SeEFhEvPjQgJbaxWPO+XAb52SxkBPOxny9+9yvmDOdChjGCz/DoUSSAs4pGnS8Qd8Vjgb1i6RMHlDsSci3gt8BayAc7JOEPMjq3Icfe6ZxiILJ1exNEU++hUm5yNXPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ3YFt3/NFL8+MvbpMKgkWMasBR5gv7hDAyajwdiri4=;
 b=dP2wXKG3AQ9zv1Sg6Nq6DKSmKGkE6HZS+WbBLgR1XWEulOtbtC5/xuGbTLcsPyCIxIUV/G6GwRuK9dLgBDEXzE97WKPfxik0HUio5BUnlU7pkwob5M5VXDN9C9MyQnytu153L8ldVkBj18V2/dkK2SpEGxBuAbZZkjEks+PVxFk=
Received: from BN9PR03CA0494.namprd03.prod.outlook.com (2603:10b6:408:130::19)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 07:34:10 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::4d) by BN9PR03CA0494.outlook.office365.com
 (2603:10b6:408:130::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51 via Frontend
 Transport; Mon, 13 May 2024 07:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 07:34:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 02:34:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 02:34:06 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 13 May 2024 02:33:59 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
Date: Mon, 13 May 2024 15:33:59 +0800
Message-ID: <20240513073359.3612989-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 750314f8-3046-4a92-8b6e-08dc731f1477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cbj4iQ7ZuR1Ot42rNkuAL1b38B6rQZBBiTk5H0Cc1GL/YbOVpARd9Xyr8L1g?=
 =?us-ascii?Q?NIiRSOxCCXGGHGhR1KLNSD27bDYCD7k/YGYh0A6Y1bcJjTZ6V4Tx4s8uCYDU?=
 =?us-ascii?Q?IrzhFCRyMi0BzsLTRrc2J+bMvTifj1eRFcYBTBkCqHH9KWss6w8exMVldL2J?=
 =?us-ascii?Q?ELPMacOUPyFXqBcYwSVwvVwcppszSVuYM8UNDuJmdFLfYQoZtXJRRtBLLRNn?=
 =?us-ascii?Q?cpHA9F/jqqnhxamSec9Zv8xjE1vcMs6DQho+XdAsADMGI3jSyR4gjhd7nmnX?=
 =?us-ascii?Q?S1XlGOqG0X3mpm1HL4kKbe1tTiCl8W/+Ty9e0VJJ0U6dSMl7vnoOb6RzCgqi?=
 =?us-ascii?Q?FsK4TesJJvvkr61wK9t2/kECPxbGw8ZfA4d+vfU3mst8ggQRqcnslvVwPcsk?=
 =?us-ascii?Q?PDXHXGRo3QCutN1xo1d2m8cK+hp/0hNAxcyNtJUUDuL+caV/jd6xmBV7VEdj?=
 =?us-ascii?Q?VaOgiqSbHoF4NJn45mJNw4Bh0LE3ycG0wRqXLiFJDF8ya+QurrT/scwYGXBW?=
 =?us-ascii?Q?66t0k3U8GT0V8ZbnwAXNf8Gat3P5Yv16uvlz8J0BJ0bJlwaMKt1fbEtvj60f?=
 =?us-ascii?Q?TA6TTNBChKjE+DPUAILuMnRFIh5sZP8RtVrExRAR3u9by9Uv/FwOSHTUQYcD?=
 =?us-ascii?Q?1zlKmFShXYS3uO/0pGUhRinfodIUuIu6yMm1r/hOWxPqyHxgkksXnMe3nsCn?=
 =?us-ascii?Q?+AEHeb79HWehFlNnoqR3HLg6NRZkAH0isdAZvwU5XbH6fjYxHHjRaGFEj4+C?=
 =?us-ascii?Q?KKxgjEGJAIZG/qdfGi6zMjIBtD2MRGjZ6tzlPhU3Bu6ebbav7/rjepl3Po9B?=
 =?us-ascii?Q?nDhJrYSK2lTx+3VB8+86GB0QVxfQMLNaIxBeq9RUV4grDlr6KnH/aOa97SQP?=
 =?us-ascii?Q?6Ak7nOET6L5qkN2Djg/lIsq8t7EqERUh7B5rEY55HgFAubR6ta2ji0NrWIVF?=
 =?us-ascii?Q?Opst//RpCzb/FH13dZ6Y6ZMtd5WDWmnxYTVBIzStdHQq8rFLkzmstIXXKHcR?=
 =?us-ascii?Q?Vx6DBlnN2Aw2dHrzBJKcMZsJ2FyGiRhquS3Bg+vM0XIxH+rOsKexqZ4kT//J?=
 =?us-ascii?Q?thOKITDraZo3jZL+p+ennN7J7MlZHv0W3tjy0y2yOoTnM5tlI4EGZ9tbTUCe?=
 =?us-ascii?Q?VPOMcQ4sgWHqam8IKw9leqd7fyqQ4+zsZAmiiPbWJoz1KEoHGPFUJrAqAZ/O?=
 =?us-ascii?Q?E5vlAQbc48csRhzg/EdLXMo8bOetbyik4xUu1GpXbMJ6M+QBW2yWYKvS50fD?=
 =?us-ascii?Q?EVTXxR5U37oA4U+0g38hWkLiln711f1xGJkBnWaz3m8Uk2h5vkkon380Hc/d?=
 =?us-ascii?Q?N37yvF6MSGqbceHpfF/xPVXw47G/yQNb0X1YFwLc09n5//EMyx0z3cQhLmYI?=
 =?us-ascii?Q?91w19Zs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 07:34:10.4014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 750314f8-3046-4a92-8b6e-08dc731f1477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
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

Function hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr) returns a negative number

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index f4bd8e9357e2..1276a95acc90 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -30,9 +30,8 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 {
 	int result;
 	unsigned int i;
-	unsigned int table_entries;
 	struct pp_power_state *state;
-	int size;
+	int size, table_entries;
 
 	if (hwmgr->hwmgr_func->get_num_of_pp_table_entries == NULL)
 		return 0;
@@ -40,15 +39,17 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 	if (hwmgr->hwmgr_func->get_power_state_size == NULL)
 		return 0;
 
-	hwmgr->num_ps = table_entries = hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
+	table_entries = hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
 
-	hwmgr->ps_size = size = hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
+	size = hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
 					  sizeof(struct pp_power_state);
 
-	if (table_entries == 0 || size == 0) {
+	if (table_entries <= 0 || size == 0) {
 		pr_warn("Please check whether power state management is supported on this asic\n");
 		return 0;
 	}
+	hwmgr->num_ps = table_entries;
+	hwmgr->ps_size = size;
 
 	hwmgr->ps = kcalloc(table_entries, size, GFP_KERNEL);
 	if (hwmgr->ps == NULL)
-- 
2.25.1


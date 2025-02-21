Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EC1C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9193210EAB8;
	Fri, 21 Feb 2025 15:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bCWIawVj";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00F0A10EAB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENn/jKsnf9d+93l97uSoqrKRbMGlZxuFeH3mUrcOYj1Iv2t84V6EEF42IuQM23cb4t8QMv4dycWLuuEiIEqC343yEu1ONd07Cu97KuenAdUxT9JMlPJQ3DkkoINMx3AIhhEYP6JFeXzwXmx9WEGXay78cYKvd7NtK9A/rvgD/xn1MeujwfH6B1Ef6tFWaXoYs4ZN7+n5+uLpBjmoRMLZ3skrV2sqEvS34G7OchRjPfXH+lvSMzG4soSCfSAN/jacTn+j/ZhgoaN559CcnfcEKa0B+3mvTOyz8XXr8MQR0RxGrtzULZmoMnZMRkLx6QtE018oHpXQguLm2L4XJkSs3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R081jv5q5ZnRdjnlvuRbkOPLqptYpuS5ij+Y4wn93yE=;
 b=H0kT0wjHr+0tNDVct6HOXcktuCAINTjCnTEo0wW0keizHpypw4zASX1z3MYMHZzbVBms1g/wwZ7mgdcuZwSEyfEu4NY0lAkDwOpyQWJMuaqJEPE8700KPdCleE5+v/rUAmyzDlAo+VpZ+PaVHGod9cPvNh3elBoO9OO+xSKlw+FjY19VYpTxPnfqbXwtGnkEXNaosBloioDqkTOAL43NY3KE+e1BY65/aVFDr+GWsR6MgOkEzyt97ctH1Prq0CqlqedN2XeNcyihqOa2xEv5d10roeEBvFolokqCPctx5OOJDLaejVN/IGrj926jAkgj3xXV2s2NREbUvzRxMjbS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R081jv5q5ZnRdjnlvuRbkOPLqptYpuS5ij+Y4wn93yE=;
 b=bCWIawVjmLsZPQBwUY35IATBJfMMRRwKtzeau4QHwkqr0CmgT0SQUMMTifSZE9slx8RlJQfL56frCMiPTe9kYONfa6N5WoZhB1NIbAhp00PRV8WHViMyS0kg+fuBPt0BQ9bwfvTNYhBm7YBfy2SG1MKWE4fkVD+QpLyOgILuyWk=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 15:43:50 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::33) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:49 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:44 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 09/24] drm/amd/display: Fix unit test failure
Date: Fri, 21 Feb 2025 10:42:57 -0500
Message-ID: <20250221154312.1720736-10-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
References: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ee48eb-24a5-4d58-783e-08dd528e896a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gc6JRAvZwWTyU4Fau0G19XhwXokY1MxCHBLLYiQiCZXoCyCt6gt28MCWxLnz?=
 =?us-ascii?Q?dn8Zq08yCe1hc4F67d4ucEgWSVI3Emn6UdJDffIZVdwhlf6pIfC1cvKxw3Cf?=
 =?us-ascii?Q?gH2ljBhXe6dbpK420x02FzfItv12Vv0usWfP4JD017pqhFwLfdTbWoiSf1S6?=
 =?us-ascii?Q?pEgqbhVd4FEz7IAEIeJRmmCVonqyG20muGbSmVeCzsvB2Rm43bCCRjMXLeph?=
 =?us-ascii?Q?UCPGc4l29SVDyNRVlEoY5Z5z0vdOIjQsu1Dvts/LH95KIGQUribeQZvezobt?=
 =?us-ascii?Q?mdgHPuhMEqjV0Hi3Jf2rcF4u/c4RNaJLbUPaXpM/Z6UxX0fKMySe7yQzwnxV?=
 =?us-ascii?Q?CypBNqmfhgKPuhKZ9jP8nxSg1KV5yHLJ10UVOOMVSygyENK5GUvUvn4UV1d4?=
 =?us-ascii?Q?TNUUDvrF/Tbx90juoS7rJnMSppNbjE/GMb+UQxM1nwacl+EXjG+nds/tVzvd?=
 =?us-ascii?Q?/U7miz6CSXT91bNnIZCjq6Xs78Zb9TSmfteJcWJ7lVD/7vE4zqvgFNnKeNZ+?=
 =?us-ascii?Q?/RxkmOOIMNn4beixSaPXUR28W03g60tFxK94SjzytV1ppQR0Sp6EBbXgtoiR?=
 =?us-ascii?Q?Rsj9B/Y2d+scTRlQw25YcV0PDPYm1Y2dh/0EeYLwygKJ2d4NW21GbphcGPnL?=
 =?us-ascii?Q?XjFG8DgN1SVoCBZ7eWZunK7j4Vw00SRMBQkJDFwju15BcJCBRhsSCGYtjVfo?=
 =?us-ascii?Q?cR6gKHFjX45pPaqTnfRRLP3yvCtUnvSHn6x6pZyvb09BMNjbm5h7vKR9VxTw?=
 =?us-ascii?Q?S5StKvlIm7Iwza0iNdwUipXA8V6D4c/ox4m/DJs4xzqjSaTKmAbdwW8C9Itw?=
 =?us-ascii?Q?QTNCrokAc3LCCeZU3g6hxbGYiNeH79jkQUvGpqlIxNE5r/h9mkSUsSg+KdNj?=
 =?us-ascii?Q?ijqvNJUx/3buwW1/x2TGhA3X8G35nE98qk1JAC7xIUi2jy3xbMhF3vt5zsqt?=
 =?us-ascii?Q?de/bBevwodvep/z1agvqHjp/RIqtKasbX4RsvbYqosEigB7vy2bP92HScht8?=
 =?us-ascii?Q?Ko1UEAckQS2rNTsxBTuSEvO8QFHwXMVoc5mdki76BdY70hEJq4D5XbznNFbx?=
 =?us-ascii?Q?lIkRQ9IU0M8SLBq5rJ0wabVnS8ybjLgl12sH+qNn+p07SJQ3veelwGYDZHvG?=
 =?us-ascii?Q?kWpMIGIau9jpP6jICCndGD7viGv1sc6BYCd26pQPPFaqIlPqcGluLD78YNPl?=
 =?us-ascii?Q?/afZ/pr/CpV35gPFrxpBUNyXzKrS7jkkc3fgbau05fGaTy0quZf3VAGSK3Xq?=
 =?us-ascii?Q?ctlDCq6H6fMxYfQOuyWcRnb1bZjYY+RTT/AurmFDZuLLpB/v2a18YnyJ45ck?=
 =?us-ascii?Q?4SOCbFSjrw4FbKwVyUQaGTzCJHT8Q5vlk/CURT3UWeql2WyMbtOmapfL/v35?=
 =?us-ascii?Q?dlZbQ6gmBE1SI64tVlgsugAvX+k0qs3oiXkgDIBXsOo1UmdC5e46ITmJKoVj?=
 =?us-ascii?Q?Q3sbEIbZyyYSOTqZyfZvfDpsheetYg2kvXfrgfXc9bYMfux5N2rfe3XKwjzH?=
 =?us-ascii?Q?Ti8SywC4FoOx2xI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:49.9205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ee48eb-24a5-4d58-783e-08dd528e896a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Some of unit tests use large scaling ratio such that when we
 calculate optimal number of taps, max_taps is negative.
 Then in recent change, we changed max_taps to uint instead
 of int so now max_taps wraps and is positive.  This change
 changed the behaviour from returning back false to return
 true and breaks unit test check

[How]
Add check to prevent max_taps from wrapping and set to 0
 instead

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 047f05ab0181..ad77cef57ac7 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -1026,12 +1026,18 @@ static bool spl_get_optimal_number_of_taps(
 			lb_config, &num_part_y, &num_part_c);
 	/* MAX_V_TAPS = MIN (NUM_LINES - MAX(CEILING(V_RATIO,1)-2, 0), 8) */
 	if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) > 2)
-		max_taps_y = num_part_y - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) - 2);
+		if ((spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) - 2) > num_part_y)
+			max_taps_y = 0;
+		else
+			max_taps_y = num_part_y - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) - 2);
 	else
 		max_taps_y = num_part_y;
 
 	if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) > 2)
-		max_taps_c = num_part_c - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) - 2);
+		if ((spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) - 2) > num_part_c)
+			max_taps_c = 0;
+		else
+			max_taps_c = num_part_c - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) - 2);
 	else
 		max_taps_c = num_part_c;
 
-- 
2.34.1


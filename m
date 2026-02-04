Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF28AE8B364
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878E210E698;
	Wed,  4 Feb 2026 03:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WAWNVMzg";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605A010E698
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vw/ILO2Drx+heMo3k+3OUoAuw62X1PzRYlFfAg3Ddec0/k1t0qp3ez4GNmrHJYXZDG7I86Dj144G6E7eiHnoWk5UI+dBXDBspBxkzBPY7SMoJJ0QFlKoV2NYVbDM4i+wFU0QJ29npMPipab5mpZFhGFx/ZKg5hJJz2CIsPHolfMpMpgYNEk6l+LNH/KLkvie4yCE+DHWWI2sl9UzDF2/OwLvaRVZCGnBn9hFnG3geiHC61SMOx+idaS5O2bZPsGIjVT8o2elvLv5RADcChlOuZJT6YYSvnyCAPTQ4l6zcH/KFIip2mkRBbDlj0Ms26QH9DQU9IXMtyiuzyUhov1nuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKknFS0lypAdtCfE53nM6omYOsVy4b2vntYkcNdwrDs=;
 b=nnWl2ZC73AfLbZ5dxb/nbhHoWddy+6KGYLe3/8cUQE4pPZUl6qfS+F2COi5N7BYT0mlBm5yrkojrDbdhQtq5ziaoxSYbjYQG184ly4TfgpbQzCZzT0QMwkYP7OePmZ5mmooZYQ5JjimFJFYsYtsDcGz4Us1bdblDRy8QJvw0zC6+FHKMYO3cuCldL/5NLKDROQemS4OveXfDOq15aTUDKBku5oNeCIe4rzUPferE9HbI1MlLhhzPzb+yUtt021Eqjm0Tu848z092sKai4A4e2uKM8WOvBSw7Dwqqu+eu22kyjTpcgADItIbb5KVw0I5vRnExIhThEvKNVMtCwqfdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKknFS0lypAdtCfE53nM6omYOsVy4b2vntYkcNdwrDs=;
 b=WAWNVMzggsSbWklw8scenchfrEjYwJrtK3FjikZU78v43O8iotC2u0zWHauoBxlmCHELgENzEzzPxKM2r9jzZNjnft8Wg2yu/c4eQDziY14FJuFVDkmtrkTkZzivjdqJ7iABrdYymrGeskha5OF+7qvTcDRVK0Zope+ntfvvtA0=
Received: from CH2PR19CA0015.namprd19.prod.outlook.com (2603:10b6:610:4d::25)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:07:05 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::6d) by CH2PR19CA0015.outlook.office365.com
 (2603:10b6:610:4d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 4 Feb 2026 03:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:07:05 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:07:03 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 13/13] drm/amd/smu: Fix User mode stable P-states SMU15
Date: Wed, 4 Feb 2026 03:06:20 +0000
Message-ID: <20260204030621.33369-13-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f05b605-6038-46b3-5267-08de639a79cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G4ome6SyyxRx/3fTrjN8+a5n6y2adWFmLWXalBwISNJzmuVNSgOxFV+y+uzZ?=
 =?us-ascii?Q?m8wqVuuTOOBT6aQla+nKtcFyAXT1eD/efvcB5nxHpv5bswwpVJSfYThh1fxh?=
 =?us-ascii?Q?1TQBsrxmYqf6UfMph0LWzDNNvTxzaqUqaEfrJK0+cYK1VtdUj8KrlMQw7+ON?=
 =?us-ascii?Q?7XPNOPnhpOfja8i9tfRmFHa82CgdG9wW2YozNc+OuK1kyrKQJyVxg9QlQjTO?=
 =?us-ascii?Q?uVOShX+hx+NQc4mCm5tX9xJLOZKGlNVK4PaGOqsa8IKv4t81pMAmDUiR9yHt?=
 =?us-ascii?Q?rBa2AHGsB0Z2gYeg4fte5ip9ZHEXwVwdv/05exukMtS/Siidw4p5veVv1y0N?=
 =?us-ascii?Q?CMb/o0U6LUSSKUmdiZ71ZUeUC6j+dE4Kxfle8FKHZDbsmamApRLYG2JJNYBw?=
 =?us-ascii?Q?Amv1pkf5iaW5IFGgJaw/ldQ1n4TUMmHoblL4A2Dtc9jlGsLlGf4n66JPrRAU?=
 =?us-ascii?Q?H54E06z/q0LtsY1GnD2zS8Zw9VWOcIjFRRlWliKzS8H4I5bBYL7AGJWMRS71?=
 =?us-ascii?Q?JXi4QdgOeizQH4RrZV9DX51mVSrzkmYtBypb1sGoSy9ichJe/XyFGy6bL8GS?=
 =?us-ascii?Q?5RzKCN5LiuYqpVtisCT/Xvr9J12vgjzlvpyDD/7E2/aId+rOLvZB4A6wcHmP?=
 =?us-ascii?Q?j+9JXecK5o1SSNe6oKSgEJwM2GZtJg7XXakQ/4kiPc+vxGaL8ZpSchRmnSk+?=
 =?us-ascii?Q?dhXgdaFnnnpGp//O5P1OgOVmYkP5NRcLj2XcuiPZfmmhImaBPDZ4E42GmtOl?=
 =?us-ascii?Q?6aO1PjIrhrdq0/fv0tPAtVDnH0XKtJ98fiR55pQRZR1X2aFi4AX0MAopxsZf?=
 =?us-ascii?Q?8SL6YNFCoSDWWkIHwZyvs+3Jfc2Ly14svEJ2S9Y5Tc2tWLQascaTneDjFqSm?=
 =?us-ascii?Q?KsNB5IUfn1e2L4njhnG1CZ/KXq6bVSo0RQJRnonjQqmUsYNHVMqscRHFda1y?=
 =?us-ascii?Q?5nA4ogUNsvjJFDiN5BohDjkneXP+nvGeitqvwS++1dhUzvsJGqmSb9Me1Px2?=
 =?us-ascii?Q?cnbrFgG/0euj4W0674gvJH2XwWKGl7tRcDnfWfZ3aOFOTmeIPjzmaw9w9fZv?=
 =?us-ascii?Q?F3Fw9nxzUt859deuV37g96laQ5Bg8CRsVTiijfQVeWY++s7tzolV0Ir0wuRo?=
 =?us-ascii?Q?Gm0eAJ4DJTtLWxnwwPqLVCU0csDVin49KJ0uI75557o0bbo1I9c3yJLX05y3?=
 =?us-ascii?Q?as5ph0F3VOGOPIt5ZtVT59i3iuEcMF8lJzfDeQfSLFYLHBkjRi+wzaUfIxqq?=
 =?us-ascii?Q?4DQUuRf+HbsYvQT27UcLfrX8lGJiULEr/hPB15agjIXBzkK/t3THOnAnr+wU?=
 =?us-ascii?Q?oesJetvWsgfNwvfgeQilLpt1fcq6GcGzv1UQVzHS6S0xl1IovwBAmJc2es6f?=
 =?us-ascii?Q?iX8ZYHlsmqtra6ToT86J8YoAnPFijtEKcChaBi43Jz5b01zgduDLwb+KC3hJ?=
 =?us-ascii?Q?9a7dDMp2NJlTrpJFr36wTWn72DF7RN1lHtZVAVFPUoJYHnq5R1l0jRpAzVNj?=
 =?us-ascii?Q?IBDF1OcKGhvsT3Vc/RcYmLE1n2yFXJVzmSHyXsPjMiGwNGnyn4K5PzOzA/dU?=
 =?us-ascii?Q?ee2+MkQKm51Z5FEzHS1e70y+l+Y7W+UqHMON3jS+C5p9a733muMQomflvhN3?=
 =?us-ascii?Q?wPJhO8kPwiToKcf3oWFhJ4zTnvEmxmMr5dM9PrHzI9+/jUFb3j28SIOBMGnm?=
 =?us-ascii?Q?qta8gg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KcM9UFeA1dz6RJvDS4ZPlh+9bTph2Tye5inGHNQAIi9kwjll8KK5MIzCFWemUbyfgUJYhPOlzefhkc438COb+FmVqYQxh0IiocEkRHeVrROtAAwlaKP8CeeRBxirhyxgG6UhbMwWCXLuJ356hcxjKLkdDUUZ7LP4qubHl6ERPXZ4VBeGz5zgekKbKqqnaPwRZ7Uk84c9I97mTPSzSpMJ03kEMLJl+mh/7qRP6iee7vBOwJzt2XCReYKpLjZKSRUfuB2cEHVWmbwqxxnVKrpKW5PCZDyac2hizlCfb3l4e84Y+/8LOO1eyQ65cYwzTRvZZ7sSSSvfGvAPkLTDE+Bssa+/BNO02K+ms4cY4ESPidYuHPT/LXhzTwKhWY7QuAMA7VozBYt6Rf6l8KtaxW+AIwvUDi6LiD+e6Wxhn5tLUhsphpa9Yqa2mOYysEpFskbE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:07:05.2131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f05b605-6038-46b3-5267-08de639a79cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
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

SMU 15_0_0 exports only soft limits for CLKs
Use correct messages

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 6eb8a733d09e..f7c0e2fb5ba1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1028,26 +1028,21 @@ static int smu_v15_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		msg_set_min = SMU_MSG_SetSoftMinGfxclk;
 		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
 		break;
 	case SMU_FCLK:
-		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinFclk;
 		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
 		break;
 	case SMU_SOCCLK:
-		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinSocclkByFreq;
 		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
 		break;
 	case SMU_VCLK:
 	case SMU_DCLK:
-		msg_set_min = SMU_MSG_SetHardMinVcn0;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn0;
-		break;
-	case SMU_VCLK1:
-	case SMU_DCLK1:
-		msg_set_min = SMU_MSG_SetHardMinVcn1;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
+		msg_set_min = SMU_MSG_SetSoftMinVcn;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn;
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0


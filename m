Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D27EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B75B112B00;
	Mon, 22 Apr 2024 13:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lq5e9XQE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5179C112B03
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vplo0iDUG9x42Y9QKMVYbPNmG7lFQ2goi9LTDyqLFL0VQ1snZ0e1SoPLHtCP1Ozlrkyj/cBZf4JX74+BCqx7haZWWqkU9V0x+52eq0s+dgcee48fxOiaK629spMH8Cu01qliRZY1ORTsEfnGSZZ1ElCQlAg/g6P/yNj7RPoY9jfeFVYkFGIveE0Boz4bkB3a9xbm37SBVJqrJjK49YeuZBDXxuFxthAxHTLGufoCy3qQVTkxu9h6d1AFC3CgkkxAEPNcRBXKbX3BMORoU2+xOVW7zhact3L6qmr3/tgeIfazb+PhykGbAk4HSNnO89WVh8nXmxeWg2T/jqzAyH0xgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngTDNtw60xsPxo6roZfSnkC7cYTh6nYxgtxoE2EVZZI=;
 b=Cg1t4cMLGVyNAYSkbrKvefygJ6SOditfYSeB1B6c6Ti8JGZKW6gTqbJLXAltXl8yzvhQzbsCQCrTh3jkUemEC/FLWC5a987INYuQb15EtzdgXK/9/tLMzDixx1TMb7UMogW7B8dY4US3DY+p8hZujqEUBSu1PUAMV99uqA0OnZYcgJUFIk0XDqTdBGGtl0ts8Eb4e2zSilmvTnIKQ4OP/kiL1qNn5h2B6zaxrxZx67/M//M0bYRwUMP1dJNYufBeegcKofEEiYheSSPSyLdPq6pXa+aWPoD7WK4h3TyPwxHRC9F4AQ7OXkCfe9vfSdhYZCpTsin31+gy34PV5fmPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngTDNtw60xsPxo6roZfSnkC7cYTh6nYxgtxoE2EVZZI=;
 b=Lq5e9XQE+Xp7j2usB7e6hbkn5krt3faE8gTtn925KTqNRbZj0zvTHGCLkwzIN7XXkMLA/lLdYlJhFp9oAjbYgB2eQWsKEUjmf7Dlu+wNThHfvBqrLSn3DklPgrW97Gy0XcnF6nmydp2UvrXBZx6oGC0g+wrcuiWjmm1xmjM/UBM=
Received: from SJ0PR03CA0137.namprd03.prod.outlook.com (2603:10b6:a03:33c::22)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:52:18 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::f7) by SJ0PR03CA0137.outlook.office365.com
 (2603:10b6:a03:33c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 13:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:52:17 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:52:15 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Mark Broadworth
 <Mark.Broadworth@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Add fallback configuration when set
 DRR"
Date: Mon, 22 Apr 2024 07:51:30 -0600
Message-ID: <20240422135157.3341796-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f0f7ef-e1d6-41a5-872b-08dc62d36cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wNuanbWQ5Tg0YnlsWG6cxDibVAcU/pceEe2z/hAj6B2O6DfON+X9DwRrbK/s?=
 =?us-ascii?Q?4ShFtWFtIo2MSHcLKHvSBYuFyi3odrRbxc/Rrl4qwoD8+5hXjCIc5oaDOVTP?=
 =?us-ascii?Q?isAVgVC1hYMAhCvg4VTv6gdtMho3ldsb6pPatiZhBCN5x1MDrcjtKsACbo6i?=
 =?us-ascii?Q?8bCJj43s5r3aJGKkm0RvasMkKpuB8ST+0YYknFOznk+8n7T4hBHu1u/ZJmDb?=
 =?us-ascii?Q?g7FyFdPFRBE3VYjY3jABnDy9o/XCTugN78Ccm2dqImQpmm4B4o98CulD0B17?=
 =?us-ascii?Q?EAgjbeyMfNtzZ5nkiwYPajlwNEGFWy9Ou5c6aLQqmc9WA24j2gHPikAlDuZC?=
 =?us-ascii?Q?z+duRfAp48HpNvGVsTqzJTKde1/+Y1zSjTTHC25V9AsY61b8N2uAv/AwFU1h?=
 =?us-ascii?Q?xtliVWVAawSom06oArI6c+FgzjoOd0QjKjZ/oT0EkDikjjFLYTxihpFEUhDG?=
 =?us-ascii?Q?O3PnyGP70TN8wb/S+iaQcSEh5Dfero7FjDlyrYSa095ARzLtoJAf3aDf4GtN?=
 =?us-ascii?Q?vGbWWBbTMWCi5pfYILEieQ2uqdd1fR/GGSNDyGEHACI6gWT4ZUjJYEHxiNUF?=
 =?us-ascii?Q?F1T1DTDtp6c2fJ4WrZO8tBxrN97vu+akCEh+fEo4W2rzc0GXxHYjmtrhrmG+?=
 =?us-ascii?Q?rLWIghtKMFV3EZc2VtWG1OzOLecc0gB/uypQBAO7JB0AVlehTThHYecIngKc?=
 =?us-ascii?Q?TIl2wC+j+Qm4SKyJEHdiba6l+AIc5ThJbru7zxmymg0xF0JKyMpvKRNK1ulx?=
 =?us-ascii?Q?4Hy0WgCPimx2xUmFB/AyaxqRpqlc3OSSazPYpGKSVRJ9/L83QD3NGaJ6kNgG?=
 =?us-ascii?Q?8PHGO+ZtXYFqc0mUw9JWLUbfDs1oOlcaRqsxcsyKwvZn4yabAiuOy2fFcaFc?=
 =?us-ascii?Q?s0h55mng5PuJQ/EIxeo8wE6mdf/ddYwAhC0tGjmj41WA+22hoTJdOIiw/8+f?=
 =?us-ascii?Q?plPwYS4LCIgDZuPhDGgreK4x1sXFFp1nKe7c0vwKcnkYcnI20D1yhbajbBww?=
 =?us-ascii?Q?NN/BRg0pj+qQLiPpm0Jhgcj8jtQz6xnMuDip0Ow1kjBKLt7RvmNnUr1IsdVa?=
 =?us-ascii?Q?UNc4y25gssIYXR0d2QUtElpXlFP5UDFwbcz4KXpv+yz7XIjmhgyL8VF2df5h?=
 =?us-ascii?Q?GI1M72sOS4GIigTBKEO0+FXzmUb/uxpMMBuIWL1WmR1AStktNdPirDGWimWX?=
 =?us-ascii?Q?GWEvGmXMQXSTh3sm5pDep9JTprlEXFNyRXwtsSwRSxbaUNfyrwnTLBm3Jumu?=
 =?us-ascii?Q?ypAU2ZMSJEEcunO+tkAL8sXCKrPv+GdL58iEj3L4mdaj4CxazXSscJ7pgX/2?=
 =?us-ascii?Q?qMa/95SuiGx99P3z3EhvCTnbczuElgoWM79/JusO9MciQflrlSkejo/s7XjY?=
 =?us-ascii?Q?XpUJuboB+7Z6eG2FH5txGHH1/Nv1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:52:17.7722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f0f7ef-e1d6-41a5-872b-08dc62d36cb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
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

This reverts commit 5ea4581611d14a6a0e8df40965802ec7bee9c671.

This change must be reverted since it caused soft hangs when changing
the refresh rate to 122 & 144Hz when using a 7000 series GPU.

Reported-by: Mark Broadworth <Mark.Broadworth@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c    | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index c4f0e1951427..52eab8fccb7f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -293,16 +293,9 @@ static void optc32_set_drr(
 		}
 
 		optc->funcs->set_vtotal_min_max(optc, params->vertical_total_min - 1, params->vertical_total_max - 1);
-		optc32_setup_manual_trigger(optc);
-	} else {
-		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
-				OTG_SET_V_TOTAL_MIN_MASK, 0,
-				OTG_V_TOTAL_MIN_SEL, 0,
-				OTG_V_TOTAL_MAX_SEL, 0,
-				OTG_FORCE_LOCK_ON_EVENT, 0);
-
-		optc->funcs->set_vtotal_min_max(optc, 0, 0);
 	}
+
+	optc32_setup_manual_trigger(optc);
 }
 
 static struct timing_generator_funcs dcn32_tg_funcs = {
-- 
2.43.0


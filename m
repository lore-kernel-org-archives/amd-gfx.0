Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8403DC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 20:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B9110E977;
	Mon, 13 May 2024 20:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ACFZgre";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B812210E977
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 20:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uhs0Am+YAw0+Vw7rFIqwAjaUCflINkqigdXWRkz1ZIGyxDxnXxPg0Mq1GK0fCdO+1y68khkPUZNOANBfl4j2kFcwtI8cQh6cJlz1Rq/fv9WmsK0KCXymSfz5z5FUzmpdVaGICfl0IyrR3s8TfZjKeONqBBmIbt0OvihMS8i9sBuqOQDGjyOIMz+UiA3+T27vM9mTUuBtfTM/Ik3ketAupFMciE4T88SjrfUfpsQxY+iz5eSrifkAHE82ufWs2elMKSyJS0OE1pwzZhpZ8ACL7lGqdCK1JYO4E/YILZgTL2uE0pV9iaMQuu0GZVQEUJ12uvM3cagdEEXZpBUXdCDxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG0MM6IgFCg9YS9qeOB9txi6R6fc6892ijI+YlMQSBY=;
 b=TlFP7DCjpBJgBJ0rvKS8/MimcafImXx+2xq5jqI4y/OZQl1pGwFbnSDhEyjtKqCIydQx3tgDgHgAk/MwXx77OsSF7IBdzYptdM+QK+wlLIKC3E7BjqDJskaHzPPX0998SoyaWawXFQmlhFkuodQIR7YDElDp95qBUp2Ln2vCeH5vbU0/SUikNWkXJcDLleD+4EwzBPk9BKZv/cG+q4nUtiJvP5AkUAdqXRUTnKJjsCjVET/ByPh1gd+R75DjHqp6FMuCJc6SnbESqZLdsIrzMJCDrySVcCLj6H8f8OYfFVtGRNt0x3XZrkkz9wCFwCsSwxkHFcWp4M9dqZDOkLm1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG0MM6IgFCg9YS9qeOB9txi6R6fc6892ijI+YlMQSBY=;
 b=0ACFZgreXosQC2CjxP4oX+GSi0X8FcCaAUOPog1FIVjD3B6xpIbU0HmvzJaez1qqPz2n9K29AA5l4kUyF0K5zUG+nLQkw44xOMO3jlSDsTZ8G5E3aia/Tcra5rH9pGi133f/gF542CNoQlAoUn5tNakL/7ERf0ULfJ7+6D1ZPkY=
Received: from BN8PR16CA0010.namprd16.prod.outlook.com (2603:10b6:408:4c::23)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 20:49:13 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:4c:cafe::1c) by BN8PR16CA0010.outlook.office365.com
 (2603:10b6:408:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 20:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 20:49:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 15:49:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/radeon: apply state adjust rules to some additional
 HAINAN vairants
Date: Mon, 13 May 2024 16:48:54 -0400
Message-ID: <20240513204855.151186-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: ff95d2c9-689b-48ec-3888-08dc738e2588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dWzMWa/iNdWCyYf9ChdvViI8BWWhNeRsr1DGeRKdLyiD6zc/jqgReLPKI5L4?=
 =?us-ascii?Q?/QkdbTsA1OHyhTP1TtZeDMiyWhcfiKgn0fCHxEWNkodGCxhGn7SIW906HLap?=
 =?us-ascii?Q?LNo2Kxzf4DzsB5LiZ/uJQfd+sga0vTWPZz3ujWGwzaKHlwHHENarTMbWDWih?=
 =?us-ascii?Q?SRBnStdZBy0pIT5WfIO8ykNt/SugzQytxoYWOqaccZJqyS+uOTIvbtRaJbnZ?=
 =?us-ascii?Q?mgLGLSEDaOP9ltzynAKdUPqjR826UKFQa3/in9wxTmYcrv/RVaPuQlKOS9fm?=
 =?us-ascii?Q?PITU1Ei9KJdXf24LhiNPp0R9V0IpORF7zVWhl+N9J+5vyPwJc+Mzx0mdqHUd?=
 =?us-ascii?Q?OTt2DpLP47RZPPxokZAjeRvTGUt18Uj4ZKoMCzOx6vprpyXNlCdpaqKTTSdb?=
 =?us-ascii?Q?BdVt6onFVrX/AQ8GiaYipO4ZObi+J0F4pWuepZHbF3fv7IkpWeW/UD0KEWlc?=
 =?us-ascii?Q?C0oeu3cNKkxE6NaR9yMh7pj8DgyxSPFGCatwgToIB2rwrGys7o/g7+AZkdG4?=
 =?us-ascii?Q?HuhHmAD2Jbk4Mx5xR4LvoZ1FDRthYZ2niS7MARKcV/OIyy6qcxP0h6loFTvl?=
 =?us-ascii?Q?hZwe99sDWvnRI1d7HUz2Q9tAJ3e+FbS7f5tkUFwAm2AFZBc/E62XxRuaR3XR?=
 =?us-ascii?Q?90fm8bLJfaVUEsI/whNHXSBG8XO3tR6sQihn5i/mf0XuE3w3alM/kB2GUe3E?=
 =?us-ascii?Q?QHTDY3CGOrfdyDehxN6PfCLd+mvH5hcn9itwh+2GqJDSC/TvtEBHq08O1UeU?=
 =?us-ascii?Q?xxpDy/eIxufL0AgkrqF20T2SwQ5A9jQ01lq2gbsgSeJNQp75AIkh9G4/NWZm?=
 =?us-ascii?Q?S2GHkH1IcGaK05El7C1wili1lzh7v5v1kSYU9ZdMwYvIYB3gwh5BmvgsZ/Ae?=
 =?us-ascii?Q?AZxKzrpU3oWwSxi2986iT/92MABoh0XTDdPUViuRvkmQ3IY4CfVUoZ9vDQls?=
 =?us-ascii?Q?C6EsYLmiyPNcYYtv6vfhSeQTOH19ayactB33143Nc9U5UG+/i70YiWx1iMuN?=
 =?us-ascii?Q?G61+DwgY4YefVwn+L8Tnj5feSBQtuRSc0fUWCThDcyWRAm7Wx4rjXih0D412?=
 =?us-ascii?Q?PQ5BDugcTUvjWJt4NADsts7p1czFc+yJeRr0NzjJtasNX+1sKCWTIY2PLWo3?=
 =?us-ascii?Q?rAznAU2rUSnbgfpqNG0lxgqIwDLb1RA2s5yfSE/MTNBHl06IrQWb5axp1Z8k?=
 =?us-ascii?Q?hP9mxY2jTN6ROQEguscEu7KqUH7pcMOhrzTslNuNbhhrqdc+IZsPPnWOsoik?=
 =?us-ascii?Q?Ewf/BNtMya8JUU7134k0/as7V5gPuUMfm5k9r8iHexjWeAxky9imz/EIA0Nn?=
 =?us-ascii?Q?S0JiWq0aI6VstM5OvJ8Sf5Fq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 20:49:13.0752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff95d2c9-689b-48ec-3888-08dc738e2588
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776
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

They need a similar workaround.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1839
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 9deb91970d4df..5db16c20bd173 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2915,9 +2915,11 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
 	if (rdev->family == CHIP_HAINAN) {
 		if ((rdev->pdev->revision == 0x81) ||
 		    (rdev->pdev->revision == 0xC3) ||
+		    (rdev->pdev->device == 0x6660) ||
 		    (rdev->pdev->device == 0x6664) ||
 		    (rdev->pdev->device == 0x6665) ||
-		    (rdev->pdev->device == 0x6667)) {
+		    (rdev->pdev->device == 0x6667) ||
+		    (rdev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((rdev->pdev->revision == 0xC3) ||
-- 
2.45.0


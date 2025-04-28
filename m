Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEAEC36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 05:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B4710E370;
	Mon, 28 Apr 2025 05:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BkaYNI8D";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE06B10E370
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 05:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGPFx+H4dxLPqLWfGkMo4CmH4RkJ7HC4ue1PxZ1KDPcWh9fdtnGlbNFMuV6oX+bgHc2qBVMbYw+zm4UKKml87FbxLhW/+3kJ9lcNp7+pXvOulBbB5XcCRhRH+TSKoi/nH4A8CsfH2PSEAFV+smK/ESS2NW72bNm52qgt3bb851RD4LrXHlK1F3+OWLW/FL+7envV74jzBvO594kqx9CcFJGMVfOEUL1aUsdg1Dd98DXKIhHlAepyY02xiZI8dqPUz3LERLvuITMWkhx6yWdTcolbHsOb2Q9BMOzCWHSwLNb0RJxVBjLAA+Jo4Uz1vVupDMGBErp7lPxbmasXdg7JQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy8QAvLh0CmRhjv1YcujlMf2GQZEABI/vYKdsw4IoHs=;
 b=oOM9FDtqsD1U9+6t8Q85dEbwizkxU14Dvfx+rfKe/o+RX04Z1lQbf3RgFFuSR9sxBVQUtkDWLmQnyggEgI/zpfm03rHr0WD6cS7TwUByUYt2hW4t2abb/W/f+h108hD3oNXjImOZsNR9qlq4muV7NnRgPbbxMrl88FaNTV8VL/zjdJuvDL95xt/aBOwtpdVe/hNrqeCeN241ysKygVL5OivfWHYQzkyZHNpSBoQu/NU2rw825R/H69XuWZVNZj4/pvLxbNJApD6DDc1Enr894xoNEV8hKZ04VQ/rsPLtzivS0mHAD4UxsRZapNEN06LEa1vTZHqy/KOB7y96PV1z0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy8QAvLh0CmRhjv1YcujlMf2GQZEABI/vYKdsw4IoHs=;
 b=BkaYNI8DSkTIzYRFqJ24ZvhFhpPk3FWpsPqtY/DQZmhbPTo+Yqsqr2ETHIdWRAvmLNXi3zN3F6j2+GGdJI1VWb483Lg4yXi8sCcb7ZBDdJuOT5jYB6oAEteoVuFnJIB/4wo7NDXTZCozuMZxcEeth5s723H8uK5ynGJ8HRMMwCY=
Received: from CH0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:610:b2::9)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 05:03:31 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::87) by CH0PR13CA0034.outlook.office365.com
 (2603:10b6:610:b2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Mon,
 28 Apr 2025 05:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 05:03:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 00:03:28 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amd/pm: Fix comment style
Date: Mon, 28 Apr 2025 10:33:11 +0530
Message-ID: <20250428050311.946659-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 242a3891-ac4b-4c0a-09d7-08dd861204b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LIXOQyS8TP0VdIcXNA+dii2N6eLgGzqhImC+X7486j2zlnko1HWkMYIVTeoH?=
 =?us-ascii?Q?9vmL/OslL0BkJrfIDeqZcv3CzL8nci/nVPuAXd3ncimiZh4774yI4PQKvq51?=
 =?us-ascii?Q?YRbeM6YEw0e2UeLAx/qD9NOkYZt9aP0D8d0m08TtKewh6b2VX+XOlbNRRiqE?=
 =?us-ascii?Q?vt3xrSYM+MqCspsQl3BzVjg9AY1tXcDdvn5a7dtcdZdqNSK6n7xJ2IUDHozo?=
 =?us-ascii?Q?YLyKzld3CakicKMGaqkfwMa7wNIECLPU5K6nFRAj9Coi4UfgM2CXCL/ln/du?=
 =?us-ascii?Q?4Dp75gt9YvBX7ejUJ1SMeNyf/+TeuxrRhKoLeSz2saHbGdcxRys6Jhi4Uty+?=
 =?us-ascii?Q?5o+PrJzZV/2c4qlVViW5FDz9G+ZJU+P2JzghBHxbTY7O3sHD4eaOQRUO4PUz?=
 =?us-ascii?Q?SuX9mIZ9fSAFiK/6ItNgx00rU7PnWX+lY+It/V4je64rHYLu7CGXzdEfXYGC?=
 =?us-ascii?Q?bAVEW7s9Xu80XrwC3GyxJ1zb3b02TCn0J1cjMlxZ7YnAi6OL5W9QU/BVguLt?=
 =?us-ascii?Q?dqDHmxkAT0yO0FskwTovOiFkwtqhRLWAf6G30DY69oFoOoq+IK9mghrKHHVF?=
 =?us-ascii?Q?Pp1HCD+SGO088UPP5Tl8bYysSDb2INCgqVxoYwDF3hJLOUJoyu+jCInpLLDl?=
 =?us-ascii?Q?BBORtRUy9MpWxUooj5EdV8OrP9cNe4uMwDSTAHOX5lyTgyX6G1dA/qN8Dvcr?=
 =?us-ascii?Q?lyo/qt8q+5I8eu0+t6yZGHwyzWMXnMoP4CG/oynXOgSX1u0EXf5RWl09j53U?=
 =?us-ascii?Q?UDPdNNUxy47HMsn7us4muo3QevGu9h3e0qndwXeV7+T/Ud8HnmFbxMJc6KJ0?=
 =?us-ascii?Q?O5L2v0pUWyJu5lH9cyHBhXcHXBNaHl/fQm0ZAb3AMBsL1mQ5iauyYsqauroy?=
 =?us-ascii?Q?RCC1wBDbOWIU93TecPzqGXXG3iQCi3tloqXu1bFdHGo8D/u2s7IxAEdO1UDm?=
 =?us-ascii?Q?5RX1i0UbCYQyXTkcI0dBFgF40JCOr5/dI1mGwCkLFivUinpofP8J878spJT2?=
 =?us-ascii?Q?9zCVhn1kEtEmko1x6PzKKqnQ3flZ3hf3mu6SOwf78UfJBX+szjKIYFLwyytL?=
 =?us-ascii?Q?+C8Bjjf3ZyOx8yMdyXj1dLPqfsSNHAlu+q3PBlBx4jY+ZS8wUNdyI5DkliTL?=
 =?us-ascii?Q?p0omKzXG2S/VP3wT2PBbymXvktxS23FdBgqSqQvBEis9tSxP+3kNOIIqqg4t?=
 =?us-ascii?Q?ycYcgcYXKwZ1FRw/2Wy3TKJOhsnEYmQqK+AkFBKrs4rlIFc9mkYkHtpp19cN?=
 =?us-ascii?Q?iOVi8Ek0TxsRfPfudeR9KlkJcJn4Yp6czaY6cINmaVzupRdoK/5cqJd7B98G?=
 =?us-ascii?Q?UCFdNkAP6p7CtQ0mstTAVRCcJgU2crD5fAtyVyoNYZrxqxvsF3Ol/ptS+BF0?=
 =?us-ascii?Q?vhEdJtybvIpqdwvSBoiccLW3/ENksONg3aVcI3c6rKaZ5PMLDEfz/Jzih0hz?=
 =?us-ascii?Q?HAVmeqbaOHInEJ1K9wTe6y7YSDvw5Wmx+DudayODlfwaECD1MA1YlZLZizPQ?=
 =?us-ascii?Q?C3wmJubZPJ5AcLoAtARqvHVAu8IPaCQ5YwgtUTCPmKTtiVqn5OKjmXsLIw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 05:03:30.2229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 242a3891-ac4b-4c0a-09d7-08dd861204b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954
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

Fix code comment style

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504271422.D6cqMlZ0-lkp@intel.com/
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 453952cdc353..9ad46f545d15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1347,7 +1347,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 		*default_power_limit = power_limit;
 	if (max_power_limit)
 		*max_power_limit = power_limit;
-	/**
+	/*
 	 * No lower bound is imposed on the limit. Any unreasonable limit set
 	 * will result in frequent throttling.
 	 */
-- 
2.25.1


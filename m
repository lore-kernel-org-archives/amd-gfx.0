Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C56C25B78
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 08:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7128E10E54B;
	Mon, 13 May 2024 08:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ui8As8F6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8231F10E54B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 08:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVLXExr+6G2RHAzsizaRIUTmHyZFWUALk17xymjVY70FJP08YHdydxZa28Z6ghY8gZS1D9j36/XbA3c6RQnwma3s8yllmxpyk12WBolgrAGP4i7BBZzsfqdZnntmcW9I6FwCL2RfeZTPKXwmFCc/Q/fVum86qZSRuAGERM77ii9/leoLU2liraBg026FbI2aRZhHZdYUY37OCdQOId+KljyQQfUKyYVR+N5dTKddfFhUEUcYnzbNMmnJGTLs/nrFbV8vMOtpzXxItK4CaPM8TjyHFnmQP2aqjNwz4A4plqWivp54BlT7ViN+HVNdECnCt/Nln+yW3eXBcHKJYaV79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LXyMl8mlhoBk4Pzle4mFQzUhyK6dgpeMaaIcu0MZSU=;
 b=gjEIN6gbsxfoW1q0mbQnDObtLeNUXzlzlpFgsbCk7wWnZDGMj/3wdKJaI4yGOC1b6vN+el6QKOSc7IWbF2GjNE+D8eANk8Uw0l4iMNZ9faOmqQQOB6qvqd1txUeB7WdP415adcLIgoqtHxuouW/rGHStRyq6VFB5rl50QRC1/hNqHGl8nZ2EzcGfUVNdfuoR1Icxoip/nM2XeIqBRsArMnERFBpTbGFrXf3Uy0Bkv4l8U9JUDFp4neTNCJaC69PLVZ3bB+DBg18dnI/Kk7YCejVdF4Qph2OUIYao7aw3yWbIOLwM2xxS/EEeqwYoIru+QC1syGtwfkNHNdiT9xE4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LXyMl8mlhoBk4Pzle4mFQzUhyK6dgpeMaaIcu0MZSU=;
 b=Ui8As8F6PqO4I0jvi/8Xv6kK/mR20XNxO9YKaclR07UcGxzpKaY/4SYHCgi/amTN9dmAt+PS4rI9tZ6XyktvpcZ63nZtnA7S7lugZgsKJeIe4vWLqPQ8bo9jZkLphEftzr20/Tipa01haoxOS1usUJYa92rLcqUnbpTMj6pwI5o=
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 08:56:49 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::a6) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 08:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 08:56:49 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 03:56:46 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Remove dead code in
 amdgpu_ras_add_mca_err_addr
Date: Mon, 13 May 2024 16:56:16 +0800
Message-ID: <20240513085616.584249-5-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513085616.584249-1-Jun.Ma2@amd.com>
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 447a6104-98d5-41c5-6742-08dc732aa01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t+mv/iXLgk/5pMR8OaqfiYhWH/3Tsa6xv4cYv5t5ZMG6XLO0hnGSMgd7GdXM?=
 =?us-ascii?Q?2KkgN7anIxA0DH+OIaSsG3ZyOny6RR2ExRBR+rS5csax+esn6bPX6Ktv7ccC?=
 =?us-ascii?Q?51cFtN3rvy8TpUiGCVC8c+wuWY6N99AfkgHkbzN7y/kA7hj+DwBgYfzmUlCL?=
 =?us-ascii?Q?Ke0Rd1vJU4UgvYEPDOycqqTpbN8VOKac+z2ZK5oF5aw+7+X9jHbVmXJz4oal?=
 =?us-ascii?Q?JeFRC58lSVRIVU2LJJp4qRQfTeLTZ7QxuqQVPVM3Hw1wkhdfv64zO1CTJRyy?=
 =?us-ascii?Q?P5P07+Fl3D3HniSSw9HagY1WBb86nK6z80ldvLE28QH2o8/S1CZyh1e0xhfJ?=
 =?us-ascii?Q?G7DRNqGRap/732wMUoV7M8D6ytRku2Zjn7gYD0EPxSeJsG8hHt8TDB/LgG+7?=
 =?us-ascii?Q?99iKOVfx6n0Axu0bfubIk0YdKLD1noPqR6W/WuoGU9vGoQ979wy0mjxZLgd0?=
 =?us-ascii?Q?P8MU1LQGIWHTX6oFOh6I+oSIc9rFglXZuEZNutE3tDMHq6pLa9oLH6qhQw3l?=
 =?us-ascii?Q?xwsbhOeY3inkE9pD5qAlVA9TzCgfVAb/iO1cswZdvmhG2tgpL+1rPgrjBRPH?=
 =?us-ascii?Q?MRC9spta6gBVJ3iTKyiMPrXhGtOrqpEZ4j1pazQ94aGsJzJUingKneyQhgk2?=
 =?us-ascii?Q?HH6E763fx0EgtYqmU9vy9jTVR17ubkNOG2v2QLGwn7UNnnDC9MBOVzVmwbrb?=
 =?us-ascii?Q?DOUgkKx+xq8leK9GhYk+71Fxy/9MYjjguVRoHwMccovq2iFdRYoX2wQeS++p?=
 =?us-ascii?Q?v4wSseUG6QVAdCy7M6nDDyF7lr5SHpOVUn9wJCYH6R6AvsIUKcL2XHOrmBBF?=
 =?us-ascii?Q?r7EIWeZimrDmH669dtJzHpHXsKHDcGYPUd1J665ID75OQjxAki8A2eoccXP5?=
 =?us-ascii?Q?6lmSyooRiqIpK3UcC0skp9BqXpt8vzxoBj0SZncVV2seG+p+Y3DWB1eFc3iM?=
 =?us-ascii?Q?qjvOX+i9XtB+692bGxr8LEPggGwUmYmnJq1plno+vmksgcTJZzbP0K/qq8Sk?=
 =?us-ascii?Q?notLWZozFC2qzBMUSAzHjPHJdQ0Txi9/jbBnX/qAb6N/1+y51vuq3/1M3zcV?=
 =?us-ascii?Q?KAjpK/NjBUrjpAz8W/lX+YoYcC2rXU0kAU1cIA/jJHqXjCMupNuEm0+N3aqz?=
 =?us-ascii?Q?uJEl5+8IeL4KHM1MP21wXsoU5dqBEA/tr3h0+7C7Cb43AyPf5Io60GiVF3DF?=
 =?us-ascii?Q?f7dihl+jxNlSwMWZ07zWXp76ep9MhUus3N8vS+0Olupookxl7Y0AsbqW1rqT?=
 =?us-ascii?Q?HZoRPq1HnoqsRUMG3aaWp3f04BtBNz998FYDcNZGG94NxzQps2aLzQ+Q0sGr?=
 =?us-ascii?Q?FC7dB7VR6eE+shEGrX2EelQmOKidj8jKRXygdoN6B92ArT/PWPu+Dsu8e9eP?=
 =?us-ascii?Q?g9/EzmY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 08:56:49.1088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447a6104-98d5-41c5-6742-08dc732aa01d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
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

Remove dead code in amdgpu_ras_add_mca_err_addr

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6da02a209890..0cf67923c0fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4292,21 +4292,8 @@ static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_d
 
 void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info, struct ras_err_addr *err_addr)
 {
-	struct ras_err_addr *mca_err_addr;
-
 	/* This function will be retired. */
 	return;
-	mca_err_addr = kzalloc(sizeof(*mca_err_addr), GFP_KERNEL);
-	if (!mca_err_addr)
-		return;
-
-	INIT_LIST_HEAD(&mca_err_addr->node);
-
-	mca_err_addr->err_status = err_addr->err_status;
-	mca_err_addr->err_ipid = err_addr->err_ipid;
-	mca_err_addr->err_addr = err_addr->err_addr;
-
-	list_add_tail(&mca_err_addr->node, &err_info->err_addr_list);
 }
 
 void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info, struct ras_err_addr *mca_err_addr)
-- 
2.34.1


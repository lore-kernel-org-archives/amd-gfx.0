Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF8AC282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 20:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 001AA10EA84;
	Thu,  6 Mar 2025 20:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aC11iohO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1344610EA84
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 20:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9sLq1zwLh2wCMRRBg46zhGpPJrHDoXdMvBU6oG3wT6Bw6GOg3vcdA7YxKF/Nq7sZcqbrZb9dfF9U6IptQGhTl8R4wbSx5o2lWtcH5ZxZ6GiY6ZO33PzmKW8xmnGWnxRoM/Z72oXiFEz0RZbhLPENvI8sumOIAub7EdJC6N/KhhwFhtZomeyR9p1/oP6iK6y8m174wQ+BBKJNwRNYpJ6IXz1z9Oohtsa7FVOFCjWMLynzGjjTyYPUy9vWF8ey3anvoAtLkbFSNpQEIUTPR3FRPbr1Y+DDI0Fl3Z3yttlp78XTWBhdMaX3eeg4x8qIIRbC3hRBhJpYTe2/DzHNlxO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM0NAonT/BW8fqpajdP0q1DhSKGqFKhDCFGRWzbkwQY=;
 b=EeYs1EavtcXGtp+R7tIr6UQEHEXJswFuxrUErBJ7Wv7Fabj83W7HlKVEEuTUXnnS2pS+E51Hq5PhicOQTvbR2U8komyIVVmo/kx113V5xkufS0AgWP6b+83E7Q8wRx8/oJBf+3QozfSDhq5Np7/wB1GfJAvSQdkwQzv8Z70TWphbSXVxHbfbgKh6xLD20hmfBEtLAsnmTXU+aV2+zW6EKv1O2AwaLo6NOYRg2OiJ5tixFzx547lFk/DWq+5CRFuPybxhT2BDawpKOQzMqeQUFU04LKI+En+QHPYWN73a9Jj8DxSQKKkQ3Vv115R1M0vOaStZvmt/NLv1DcmCxZIG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM0NAonT/BW8fqpajdP0q1DhSKGqFKhDCFGRWzbkwQY=;
 b=aC11iohOQ5IeOc05TfbW2t631Ql8sdNZirW8ok5rvrViJa+iCvYAzBn/ucCpJC+ZLGpZZ5R1zcRbNFmYL0D3m6QiXbGNrdOeA4Pspw87yd66f7CdT2wEJKxDl9NZxwZd3nEZjpZrL9usrei/6J0sj9SQNm9vdmGU5qsAe9czKkE=
Received: from DM6PR07CA0124.namprd07.prod.outlook.com (2603:10b6:5:330::34)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 20:38:59 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::b3) by DM6PR07CA0124.outlook.office365.com
 (2603:10b6:5:330::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 20:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 20:38:58 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 14:38:57 -0600
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: clear F8_MODE for gfx950
Date: Thu, 6 Mar 2025 15:38:07 -0500
Message-ID: <20250306203807.6372-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bf0d68-dc52-46d7-cc93-08dd5ceeeb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2QtsOPSx/dytB8t3DtubYN8+QTi81JkNbIahu0dP8F4O3qqVLYaMPcXSeDB4?=
 =?us-ascii?Q?5uIXb1xSxnRu8nlQ8pefvQhqDsq6retpps1/3VOWBkDzRyZxIx2IwOSd+8U6?=
 =?us-ascii?Q?FfRWI6PjUtbR4mU/J18X5EFOnJp05qsW1JpQmgtFMNMH6toW1vhjMwdx1K6A?=
 =?us-ascii?Q?dQmAZs5+TMkh3llgQHhR4tWL9KedBYXKvAqkTjuXxV+xvIDQs6Hobm+mWaV7?=
 =?us-ascii?Q?nsmz1uMXH3AICH4cvxrF1zRq/LSeIZMctnVgFcdi5tP0+QKuWRDi458wj4pq?=
 =?us-ascii?Q?mrMjQbPWQigdrFk5e/k9ikzl6tPnBSCdG782ZnBZDwzj4NBonXNklNeBWogR?=
 =?us-ascii?Q?t4Tyo9Fl6tE9AuGa4TQoZIuRQlH+NFjXcl4G1xi+c/IYYwGly9+FlakKYCp6?=
 =?us-ascii?Q?OE+dO9gJD8/rDqLr/Ac9yu2bFdVOj5h7BGDDw1sCKzuVR1Sz6bmHLl0z3nFQ?=
 =?us-ascii?Q?gl4Nzsk/airswdRm/8Q5ZSDzG9+j/AZ+sivnvOydmsNUI3Ldu2Xf1Vt9cSoQ?=
 =?us-ascii?Q?bqnKZVHatF7sioSleslHt83besLKkibMOMAnCUgrVwuNQjExMIB6XDXYenOW?=
 =?us-ascii?Q?sb20z36m8h3Xj1xvxS3hgR62RB0PMUsYNSWckyx/o6RYJO3MI7adpViU7c28?=
 =?us-ascii?Q?euBN24rnNxOXs753RxJaOMW5TcbFFbDgyP0AF9/yr1tk3Wsudcovxa5GRa96?=
 =?us-ascii?Q?V7gjdaBR3wQPPDPe886QRx4uGu0VMWtQPPY0oSC6UZbMu4wYgWVGK5ZuxzwU?=
 =?us-ascii?Q?ztAwg51AodwGGjiyEyjJJ+FB1UwUH2W5nwTyI3XEclFiP6K+jbphSiKicM2o?=
 =?us-ascii?Q?Lpnt1UEHC0ZK3eeQWCmm6u+ID4J2KDpkn67Zs55tK1D+M9QfVGs3265Y7sT0?=
 =?us-ascii?Q?6nljQ249pzokRQH2VidafBwy+WgymgyBXWvth+2pTl/9IwpNyLEnXzOd71tV?=
 =?us-ascii?Q?sO2it7yXI5qeOuIagMYtr8TE1mi1lKWoqugB9s109CEncqZmdT+SGlCq0Xpy?=
 =?us-ascii?Q?D7xDhdXD42wQN9SR0Tj3cuLcz9aMt6XgcGa+9Wo86HaxL4DisqxmfVY90DWf?=
 =?us-ascii?Q?rdsDY6cno7tcvxzpwp4xoTcqe3f6Fhoqm8NSq4OPdGstKjogn3EjRoiaDFLJ?=
 =?us-ascii?Q?J5wsVqRJ4PjeCz4P2u0yrgYr1o3hl11x1cBQ+RYuxuzNtDAx6ZSh7Gg337GA?=
 =?us-ascii?Q?0Ii9qeZKqC8LahpP2sdqexUNeFbABo2qVwdhNIUoUT+2Wt8DlK+2d3GONFQY?=
 =?us-ascii?Q?48Ra7ujGT+5VdWHGHrcA99Z6Q4fb+I4djz0+SV8+jKxgmzBDefhVjFapVx2h?=
 =?us-ascii?Q?Orls9bn2Og6tx4720rNk+zN/u/UkWmWQRZ4Vkbh1WwbAw/W8/JAS52opy4KR?=
 =?us-ascii?Q?i0rpaLrwfP9TOSB1Zbp3wm1DNZVYbK0Np5jE+BlwxHi/2Q3kTYiCEZRNII1r?=
 =?us-ascii?Q?8B6+VvCeKPNlWZ19XCto88lCmgD8tSEHJz0fgHe4mo2bKNI+Vnplj3L8qYYW?=
 =?us-ascii?Q?FZF1j5x0VVQ4Zpo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:38:58.0096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bf0d68-dc52-46d7-cc93-08dd5ceeeb9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801
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

From: Alex Sierra <alex.sierra@amd.com>

Default F8_MODE should be OCP format on gfx950.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 67137e674f1d..210bcc048f4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -64,8 +64,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
 		if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 3) ||
-		    KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4) ||
-		    KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 5, 0))
+		    KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4))
 			qpd->sh_mem_config |=
 				(1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
 
-- 
2.34.1


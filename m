Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A920CF649D
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Sep 2024 10:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1C210E144;
	Sun, 29 Sep 2024 10:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRYpoNYf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2CC010E111
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Sep 2024 10:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTm9UtS8VDJzJhKQVDMsCWp3AjXug3jIHmXwbFqIqYobgAEBCvrWcMdNzRLpolsx0TZWcykRuuBVL0QEAxPnX5HNX+vPhzg+jIA8icfOMTCsQe03hPmRV9jrXHe8iMOPJ32dM455Hsd2qW3E7GIa9plmcTZbUuasnTSxXjspcqMIKC/elXkMa9HKNRLxvXkfuV0h5BntIdELw85TFkisRy9n/7ivVgyaweFi1vBsh1sbEDo20VQ0TvYW7gopC8iVeL0jb7xitBfw/Nalt8W0pY+ZD0SZCor2rcKuBEDrRAJuVRqCzeG4CSAfc84rSrBl58FOdZqmyRvoR/qUQzh8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhhQEudBm8Sp60D2o7Q9iOrPZ09PSJoiNhEWmY+4cMY=;
 b=qiEixXfZ33kphxlEqqw0nH8B4NJuguXkwrJ2ZUaBdxIbjBFPfM65gsBxROU9QbpG8VDpWrcUW4JmVLffmyJzZKdHs3mTQRmZvhrIT2zv2Rafmn6UhlLu+N4nMJE6Lmeh59Oi4Pz1tUHmN1I2Xyjeo6J/7YWx7FgKkHlo8olJxXFYc39xZX3OkizgNDqP+Rz6qITI06WC6pZnaKXBdvBE5H9h3+KKyRigAZSjTLW/ufoIwcql8RoSwh8yssozCUDgFq5JrB3X1qj9Fbg7rcvDdZbNXltcWm+v1HjdHvisOKFjTh/BBAUcSGh6Jm0Nl+wAWZ3Z8l0ij1rzfYU+w1jeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhhQEudBm8Sp60D2o7Q9iOrPZ09PSJoiNhEWmY+4cMY=;
 b=mRYpoNYfrsdmXmyc0+g24g4di4JXv7v/7hbuuKTKYHU3qhLtDjuUcIvV4INkdpln1o6sVQ78XffsCbx27/8oib2eSAIm2rxn8sqTJkAJCj2ZC7ldQ0XVxv9TZ98w3q6dktkuPpvc+DS14xx5Q+5n1uOKoyYRcFLhmGr45RetQg4=
Received: from SA1P222CA0167.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::15)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Sun, 29 Sep
 2024 10:49:14 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::e8) by SA1P222CA0167.outlook.office365.com
 (2603:10b6:806:3c3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Sun, 29 Sep 2024 10:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Sun, 29 Sep 2024 10:49:13 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 05:49:11 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: update smu_v13_0_6 smu header
Date: Sun, 29 Sep 2024 18:48:54 +0800
Message-ID: <20240929104856.46010-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: fbeee906-bb73-4d7a-c70e-08dce0745b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wZc8avcRettuyW3+vApVkqaSBOQdwIj4dqBja/VRYA1ISMqW7E8x0DAFWbuI?=
 =?us-ascii?Q?T5fF+yLHAsnzisBp8h2nMq/+GemAOnsGSOhCkmupnX4+bqCs2o0NcQH3d2nn?=
 =?us-ascii?Q?wEPPNnJgNyqU/aNKLklmB2C2rQUPpn+kSoNFSv4diWUZlYNPNbbr+K1C5Xnm?=
 =?us-ascii?Q?nVZv2NYw6VtRTDAiNqTFdtj/2vP8R012gQAAV2W21lVQP+n+AxoZuoaPhS6u?=
 =?us-ascii?Q?BefsGUvG1z1xeDJ6arv9RLIhymhxkKQ7lnWXShXvAdylg/agwVR9SnBXApyb?=
 =?us-ascii?Q?NeielTEAJ2wDTOh1JRd1drK3KnSBgFWcgWhLNKA4jiUdrAHluqWkRLT4iVGv?=
 =?us-ascii?Q?bHSlAKIIm2a5aSzquV6s4stuETR4m3/+KBfe7XUwDFXbWfXFmX0fmZCELSIJ?=
 =?us-ascii?Q?6yxny+HHomVbc9/EICGMVXUeMw9ioZffKUwCeJzbVG4pLvvEDEudp8NFD8A+?=
 =?us-ascii?Q?7RGA8mDAS0GGOSK2/uLhqi4SZ/QgSV9/xcfoUyHn7GoqkVTX/51vQQbiCxde?=
 =?us-ascii?Q?IYGWRUUM3YeIKHyF+hI48YSytp8HBk1aXbm9DyBmHS5UhkZafHaXEcpbphSL?=
 =?us-ascii?Q?CZFL7TSTIU9RT8HSyp9P7y2MtGBbuiLTj10yiLelTPAOTI2F6xrzZTLhknyX?=
 =?us-ascii?Q?awxhQyxorbE68HpWXE6Yj96NpcbO+hu6gR2oAj8Xh0Pkib6LTrVkJHMP2BaP?=
 =?us-ascii?Q?lWraXO8So6ckELQWjABkKR6BqQxcBHnBUZV5AV64gqORcomt84j+QcmDkqFp?=
 =?us-ascii?Q?a2+MySRInWEFjQT3OuD4nUqOIgS4XcBLyVfA8OZLjK8F0HxD3X5Q7FRRYzJN?=
 =?us-ascii?Q?rhct2Y3Q6gukO+cqDne0kZFIbVBy9Ws+b2h5WnjnjQFrY7iovEX1z3L46GHG?=
 =?us-ascii?Q?7BAo2EsK5k2E1qN18/GSNR5Zm9kJNBYGo/XpEYlXd1Z1ZwxmdO2yK8grDyRa?=
 =?us-ascii?Q?mcNN/M/Ld8gW4B45Pu0128lq0p7BeDgZ1f+PJf8VDaERJr+zvpNUjaaBoKpm?=
 =?us-ascii?Q?cqaiIFpkRCDnDJ+BYiGR3h+gJU4u65WfsbdkV/66EX4LX1MMIjaXCl2iaJ4R?=
 =?us-ascii?Q?8HfhlulpeRDm3PFr1DjC10mKPfx41kB6KZTeSOdoRxqoEx87dOcRrB10QgUU?=
 =?us-ascii?Q?aTVdj6HpwbC/YyUHsbx31LGyEMaYQgo8OotjipRRPAh4VssE2KrbnUeQyadT?=
 =?us-ascii?Q?ERPyz/SHJ4mNrb52TrdtR2BgGa9pbZbZppr9cbBBI6s5+44pDcTAF5+rJ76l?=
 =?us-ascii?Q?vvxzKoC9Eg/hI/N8sNyC8Vs5kFdRVjw5AzHsnIhFq1oS/wCusPwRSfv+nEn9?=
 =?us-ascii?Q?/tVyuOHZJ8AKdE+lTO564tqrxAGYH1DUCtCGAKvgW++Z6hUzGx71FydBrK6g?=
 =?us-ascii?Q?zKNXnXus2ED/9DHyAUhv5luKntAgz0mubET5fLoqerdTrVu5YsP9JPycdKD+?=
 =?us-ascii?Q?/AeyHO7KG/Xp+b1fUzRr8ddiJULSamXp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 10:49:13.6881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbeee906-bb73-4d7a-c70e-08dce0745b9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

update smu header for sdma soft reset.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 41cb681927e2..147bfb12fd75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -93,7 +93,8 @@
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SelectPstatePolicy                0x44
-#define PPSMC_Message_Count                         0x45
+#define PPSMC_MSG_ResetSDMA                         0x4D
+#define PPSMC_Message_Count                         0x4E
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.25.1


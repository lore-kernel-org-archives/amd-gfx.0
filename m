Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68444C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB51B10E32C;
	Mon,  3 Jun 2024 08:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sp0ZYZjm";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC2C10E32C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJKeqml/PAPCoVo5B6y8L1KGJBK/HvrZU9OkJoFt5yA0pzBM9WsDoouaLl9pnIeA57w3CdRT9cwIl/jrmJ0E9r2OwzUBEtZ/A+B3C+SZ3ExF5sZF/Sr4HULIJhVkFqCJw8l8lNB+fRK6595k0bwsckw3KcF37FdadZd+NW/bOpBA8KNwxqDSS76EUFQE2MjdGkpJrLBAhzWv6ET+7zfDhAH+u/ZFQVJOA+O74dU2GtFFFDTYohS/aoBxaXCj+ddIMbS665gQwv5LtSkUodbYfQEJopLf0fu3Ie4YW+YynEtIHCGUcqiJkmpx9bfRWTGsXObl8izEjx9MkTqD16UF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unQjhbm9EtkcJKUiUEb5oUGVG1+2WfXn037jgV3xyqA=;
 b=YIn3RnP3j4nkaKhutvnfqykcVBsaBV9Zc88bRJhQ/hC2ZFnvCkKONwvxWUWfJ8J8mmlvHAkHyYXt/S2fBXDut7X9jLUYlwqOjQMm54F8El1RVKdIs2f2/T8WGrIhhAQWPuFqm3o2LEKdW8+b/TxkLlH5at2arkqoOD3S9pmV7dfd7O+LlyaGRmkhQIEpkLF76ayEikEI+1woMt1Hc0+k0G2LYiJOfrrZYcfRuHaPdf2+Sa9x/SYZ8NrQxzqBts1ID0Ut4aLyc+wvK44827uteX4R0guvTIRMlQDMHQpcIoNRur5Kf52+8nT+lwOZynmEg2EQru8bwWkldOCySqCK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unQjhbm9EtkcJKUiUEb5oUGVG1+2WfXn037jgV3xyqA=;
 b=sp0ZYZjmC50M4C/Y9+iC4LD0ccPLP9ImAXHj+p+LqWWLgwMUHPVRxo9CcISuHn8T/ppsc82jnz9B2Cf/O2xDALLcWWkbED+dVMSdGLx8DdpB4BTmSjn5AelQXy9lTvFhQcankoaPXD5zSBzPt8QZr+OhrBUDuArxEYO0XAlY7tk=
Received: from BYAPR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:74::28)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 08:49:39 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::e0) by BYAPR05CA0051.outlook.office365.com
 (2603:10b6:a03:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 08:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 08:49:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:49:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:49:35 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:49:28 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 10/12] drm/amdkfd: remove dead code in kq_initialize
Date: Mon, 3 Jun 2024 16:49:27 +0800
Message-ID: <20240603084927.2570235-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8bd7d9-4a47-4a65-d9f6-08dc83aa1a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w/RBgT1C2Sx2MB0kCDFS8Q4DnKTd6eIq04draoT751OG3mZnNFRw+iiST10w?=
 =?us-ascii?Q?4vRHf5cwm6fKT1zVKpF8VCupAdennTKwAbAF7g53t/q4k2UTb2FPNZktVwwx?=
 =?us-ascii?Q?jdi0M8pFjavGq4ckJ687wf0tWC6EoTTvF5UL9Z8tKX2S4UA9IZhWh1yXqWNr?=
 =?us-ascii?Q?dNRWuPq2jbnsuIrDnHVMijNb93sMhBWAXB1HKHiKDWxiCwD/wGb/ZRI/mUcC?=
 =?us-ascii?Q?j64FVp011mCHP+3sM7DW+2HiX7K7TvXBbUOzAbWnr4aoteq49YqxMVmSoyKm?=
 =?us-ascii?Q?6M84ORJW5dFxvtDsVWP1HZjvlaO8iLCCUBAbBWwIBfST25Y+SvaWUVVwzQ8P?=
 =?us-ascii?Q?C3kicismi//iwrsK0przIcjrieyXWlQK/VWT+7jQqzzTtnFLxd2q/xfHcae3?=
 =?us-ascii?Q?xaB7E+7uMTVwoO9+lVJRkvBptYBFvpEHU+NzCNmtK4FOer2G+kSl5PaL2zjI?=
 =?us-ascii?Q?y433yVe26m4RqE5jBCIB4KYgceI02kpbpshhIxJWnJHWL42e+JVjT78w7fhe?=
 =?us-ascii?Q?LqD2Oj7BHrDKx/Ob+nqBhPv2Njhxw6m2CQWapkiYkuE3EAwnvcb+oGdZgnzX?=
 =?us-ascii?Q?MZtYPNWztQGYvJxE6QQETq1uPxRM9t3zD5Id313lX530v+anKO2xMXY7ZckT?=
 =?us-ascii?Q?txpP2sm6q3afSy65nXvz59TZ5nsZdgIRctlhkaNpmjVMGYaqbfPseFrNbTV7?=
 =?us-ascii?Q?iw+GqT9dCslNZgBAi1oWyWbJNl9z2DwuSfJ33gc7eLgW31yOezdqpVtmhDi4?=
 =?us-ascii?Q?E53Xqe2Q2SUFc2E9PiveLPmmQclcunxPCawulObWkFl7xIfBKgaYVHtj4p2l?=
 =?us-ascii?Q?LqajJ4q8I8RpScf3c09gq4vjUDBumHJ+ZC/25/GzW7/pQqX+4qgGo0IyUC09?=
 =?us-ascii?Q?3eJV8dOC1gjT3pymr+xWMEzaQS0tKz54Y0gL2nHsrfwxldTOTw0DmEsiDuMz?=
 =?us-ascii?Q?4fabt6Kkstn4S99eRCXBw8lN4eI4mOYoksfxaZMH30Wv4s7QzQj1sEn5MeXj?=
 =?us-ascii?Q?E7XtxIx2SYcOMgHAacQP8SCUG1chdkn5ak5341rJSLAXdSdsOuOMCAQIb8AU?=
 =?us-ascii?Q?5vO2pKyhP3In+uQmK4mbHSBgRGjhCSGZHV9ko/sjZN4usXGxUTGiI8yHLCgZ?=
 =?us-ascii?Q?aVzP52Yd5AWGR3fE/joW2OBs7mjsiyYCb4r9oZZValL9z3l39kDLSSPzeE07?=
 =?us-ascii?Q?azAhBVsvYNW/28zeNfvelIeMt3lhvzKF80wJXrenCY0ELxoie6zfj/U4Ocf9?=
 =?us-ascii?Q?Uhz8UtKNFIVCwcFi5A71VpTb3JDGME1t9x+m+i6I4zVejxEJl2Qyvq7ETMEB?=
 =?us-ascii?Q?zQhcNCG3E8e8G6fzbE65wa6LkIquejkuxa9XOyIZA/Sja25vlOyFzeW5r4j7?=
 =?us-ascii?Q?yoJClVtoPF1HKPMWlOPRSi5v+6Og?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:49:38.6669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8bd7d9-4a47-4a65-d9f6-08dc83aa1a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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

The queue type can only be KFD_QUEUE_TYPE_DIQ or KFD_QUEUE_TYPE_HIQ,
and the default cannot be reached.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 32c926986dbb..3142b2593e2b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -67,9 +67,6 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 	case KFD_QUEUE_TYPE_HIQ:
 		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 		break;
-	default:
-		pr_err("Invalid queue type %d\n", type);
-		return false;
 	}
 
 	if (!kq->mqd_mgr)
-- 
2.25.1


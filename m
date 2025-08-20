Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86F8CA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 14:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 785F610E060;
	Wed, 20 Aug 2025 14:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nk30vMSd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A09F10E060
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 14:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rx8wjPbCUVm3b1sY74ZwvtPRZMDfaGpT5NrZxhGOjrwOZ30PqK8sy9xZVryUU6H1bgAJtDRtcriH7Wy7ehv+nXh+QE4jYyA1dCPZSMPjPZAZ9kwGAR5l3dqWskvxYxkSLwDOjlgcAMLTRRX4V+Z2fo8DIOWDEmPXT4AZ9MmzCIzaxij6WX5rdNuPMg5KcQFgI432apriIY375ewJCpwXviIzYomDgr3Yo3QqU0KFO9/A/tVqVxfGPqGrchzCKyP6WxyS1ZpuUvpoyfZYDtI0YoXsA32HcB/Mf2U0Z/JFcFOuFQqcpMNETB/wOz/8Krn0SRd9o50CE5gNAh1mH/DVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/k0RnBgqZjOQVtj3JnrqzMI25WLGHKdfq/etYzC8KQ=;
 b=IRN6GK/oJf2/i/Bzvpi/qL9KDsmXrzkilyjpE1a4qGNK9lQHq45JgPdA27YcWpzpzlpQMkkeocxRqdG7tNVPmNF0PGj7lZJOpANw2U7Tn3SLHJrtzLKK6lklvV1/S3xrQ3LiAsPFlsdtbAfD7Qi5/xt32xddkFgkm/KTbdgQy0wGx71V3Osul6cA/sXebV/YC/2aZznN8sPa2i3AjY1S5dzJTahx3PZQx9AwEmsj7SvtP7zJLAWwCpWm2OHhdnE1dfZlKG/5l8jzKVO6ZzTTubg1eO+B3uBLHiMjqAcqrpUlXTJ0k/AautvGPl6bcodf7VVroQp7mZQleWaCnsOXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/k0RnBgqZjOQVtj3JnrqzMI25WLGHKdfq/etYzC8KQ=;
 b=nk30vMSddHL1QVS0tRiUJ1rPWqRzeGVVTxmgS0va18MmhI6BqcQZmugHb3opED9u1TjosIs/J3z/J4ZLaEue1Zmi2z3JxKjpI9jT95Y0yGcj4Ia6yj5P52Pidtp5XWQT4TqXyAUmhnS8Kw83nGttgNqhwoPRuqrdSjCMACa623E=
Received: from BYAPR08CA0046.namprd08.prod.outlook.com (2603:10b6:a03:117::23)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 14:50:51 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:117:cafe::8c) by BYAPR08CA0046.outlook.office365.com
 (2603:10b6:a03:117::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 14:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 14:50:50 +0000
Received: from sclement-U2202a.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 09:50:49 -0500
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Sunday.Clement@amd.com>, <felix.kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Allow device error to be logged
Date: Wed, 20 Aug 2025 10:50:32 -0400
Message-ID: <20250820145032.2150006-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bd9022-fde1-45ec-9c63-08dddff8f4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yWJzepefMD+X2IG+5ugznX28+Fq2rv11hlgDMZhFd1PPyz28tr17mdWYf6A2?=
 =?us-ascii?Q?AZTfQz2sZmOi0JJlwHLAoeNip4fBkUPaAIG5s8r7+FzJ1u0Ys9T+exdHpD41?=
 =?us-ascii?Q?2HJTnsNzcxA1BuCZY7nJGtrM0U4ttIDFuyLnw89REjKWSBfI2waXW7ggzprz?=
 =?us-ascii?Q?LWKZ0zORIcOtEg26H0onO3X7oaAC1HR/HVlRBTrETnsBVEXTHB7hfnlzKaAS?=
 =?us-ascii?Q?QwNXvQHB1IzDBbbKqFcYNhQhUXalDRcOHvp2bsBEYGXtYo4lvOm++Vv9EQGy?=
 =?us-ascii?Q?/b7FK0ER1+Sfw06PJYTUEb4rFslzITjqVURPHvw2C2/qQs6D+J22Rj0Et+gR?=
 =?us-ascii?Q?5W1SeQGX2ootjXC1grhXRwPrNWApLWVN+1cBx/7RICckYGi6ndwGOcTeFQKJ?=
 =?us-ascii?Q?Xy/4oaxzB8O7GzK0+obVHTqcUUY74H/G46pDUGwORTVgC140COQHK8gHyECV?=
 =?us-ascii?Q?K1TYcFGMOWfx2SEM7wzAcBPmVcOkuAkwoWbrEe7eZp2UVBYliBwS8flvUk4N?=
 =?us-ascii?Q?1Bozwas5qGPw1S/M+prj4MIud0urPX4O6b/CBmVuyryHSYOeIxmG+5Sn+yCa?=
 =?us-ascii?Q?BnobbTDEv3855C6YFRRM7LeC1xNTipF8p8KgDf7jkhK5ZdvumcsP5uuLVTKe?=
 =?us-ascii?Q?JmdU75yJHUhuJRYN1AupBtWWyrer/jgN473KDR6ZVSy8sjhbHsfzRj6P5UPK?=
 =?us-ascii?Q?C86CpDzkW//JGMfyDu800I2AfVfDyEkXJtNH0F2eh+ldNZ9TAg/MVT4vkv75?=
 =?us-ascii?Q?FGFa1muM6QwMDfeZsNwwgzDW2huS4YiHRLMFgIy9kNyBddNDaXtvv5Vn89Ki?=
 =?us-ascii?Q?rYa5OrItg+khjLjBOGs/9UOQLxN2OPQ1AL954JwtlsSisl8+jXHFqLd86Q3j?=
 =?us-ascii?Q?6Lznet/MV5ErG98wu+mjV3gGaSiWkDtL8GzKaqmmXR6s7JZHMTFnGqgtUfdw?=
 =?us-ascii?Q?GglKJPbEepPfRUBNrucnVTKFjkk6uNmzxXaNoUXLdPog4hNr1wgR2y7dtiAj?=
 =?us-ascii?Q?24QrUnkU9FoqmV5ZkHhJIM+zCjbWsxlNhFxY6M1bRDQ0xa1HpPZhGqf0pY0j?=
 =?us-ascii?Q?tnlfEtJIEliIPdKubnJyatx4kXFvqW96D2n7zVKmsmI8FR0CdN88iqYEb+8A?=
 =?us-ascii?Q?kwn66si+bhO2NamjuiUvzh5Uzew+6ABt6liy5nlZ290OXlA/FWpzqADOD17z?=
 =?us-ascii?Q?GIbb5vFCIP38cokNWGXUFOvY0dM/jNkJnTMSQOjpnmY1+v1WFIZ1LwlqDdwl?=
 =?us-ascii?Q?V++abUKrQxMMUaZE9Ai2D4D530oFRBzzpPGeKQsV4+exiofk9jJ5KIdQq2u6?=
 =?us-ascii?Q?cmTcBJEbIjB/2hfdpXJ0HTqnLbEmYsTni+SwgnEay4uDJsuxjykVgqIGYRRN?=
 =?us-ascii?Q?n0hIHZQQW6CsrJuX579s6QRNpY9WasjXX6sRT5kAca7lg27i76G0YdPCmvAw?=
 =?us-ascii?Q?F/fQkjQF+tyGeYUWtfGv8efZzCVnVuPZCdsFTP6vDewNlfdvcfOT6LFTWptT?=
 =?us-ascii?Q?Fhj11IvlaG5m8j/9aLa0TGbGZ6y5JJ99N+Pb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:50:50.6448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bd9022-fde1-45ec-9c63-08dddff8f4c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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

The addition of a WARN_ON() check in order to return early in the
kq_initialize function retroactively causes the default case in the
following switch statement to never be executed, preventing dev_err
from logging device errors in the kernel. Both logs are now checked
in the default case.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 2b0a830f5b29..fb3129883a4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -46,11 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 	int retval;
 	union PM4_MES_TYPE_3_HEADER nop;
 
-	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ && type != KFD_QUEUE_TYPE_HIQ))
-		return false;
-
-	pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ,
-			queue_size);
+	pr_debug("Initializing queue type %d size %d\n", type, queue_size);
 
 	memset(&prop, 0, sizeof(prop));
 	memset(&nop, 0, sizeof(nop));
@@ -69,6 +65,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 		break;
 	default:
+		WARN(1, "Invalid queue type %d\n", type);
 		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
 		return false;
 	}
-- 
2.43.0


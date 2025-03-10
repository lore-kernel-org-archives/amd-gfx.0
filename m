Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1B4C28B28
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 03:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0877F10E394;
	Mon, 10 Mar 2025 03:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S+XQ7tDg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19B310E394
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 03:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHa7xqiUeTaCLhVwSLuO7jgWO3cx3gXmL5gIz+ql3r2vfGS9UYuA9uJjjZW66xvdjO1OZZvGwrgEOlTFioXgpjWjWnbncQ82fCV+/RwiXnrC3lE19/7Xp1gPWpCt4oMsMilyaMetHU5dwZo5JXTwgNZhXkm6qxQJ9t5vn5LTvjH32MKLCUfoiMFmkjMv/+wdH6Osb71kxLT7wbYd9mgDqxiMr3gtKKtfL+GAyOGDVRKGCDpY+3yKHUOrPz/nK0/zCxm2C5ADY44djI33+xqcC23J0t0nyrtOhaMaV7YuJPC4ut/gW7sjxRMPUYnLesNg0RCpSbVNdOc1+OCMRjvE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsMqQhxtFgRzyMee5KxjdTuwc1VjVB7AGMHX/eSqvKw=;
 b=yTBW8zs7+S4zWnj8j+koci5xDJT08krmYcj6xqJRYB+lz09QUq613cflqpcStYp4Ol9Q86OpWwQY8W42elICFmii5Kf+LQN+eJ4Wp2nq0lLgkqPfGlbQ9ugFLSFh4iz6MpoANIk+ObJEjNQFtR/6aZokvqTqP5ZKlmZXRatv6tj644tQWJbh/Q6SCn/gI/DdWOzdJHjMV66rMJ4I/8K1D7NY9Otfe2pm6ZF1q+l23YjpkO9JybJqPbFdvXj+BkUBptVcCENNHcmpK0mXLDB0zUQJiGxHimaYStBz1y0zfaAJLvVEORy2mATV8Sb+5YlTPbiYi11alOzZfjdAjJa55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsMqQhxtFgRzyMee5KxjdTuwc1VjVB7AGMHX/eSqvKw=;
 b=S+XQ7tDgvOnzxmZOuxfBHPEYcaVjNYJtfi0cJGt5+xlmD2fdJmr/H4YM8PDqEHn84t4cfGoezi8VF3vehow1J8M+CHxia7QAmo5fRfvQKGTwTHcXxgP9gpqifVwgMjemd5RKvrJ4leaOJRCfLQSdALJBEreXgaeXW4xrO1SDOOo=
Received: from MW4PR03CA0136.namprd03.prod.outlook.com (2603:10b6:303:8c::21)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 03:02:18 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::b7) by MW4PR03CA0136.outlook.office365.com
 (2603:10b6:303:8c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 03:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Mon, 10 Mar 2025 03:02:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 9 Mar
 2025 22:02:17 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 9 Mar 2025 22:02:16 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
CC: <zhenguo.yin@amd.com>, Yifan Zha <Yifan.Zha@amd.com>
Subject: [PATCH v3] drm/amd/amdkfd: Evict all queues even HWS remove queue
 failed
Date: Mon, 10 Mar 2025 11:01:04 +0800
Message-ID: <20250310030103.709524-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Yifan.Zha@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ed85f9-f1cc-451e-3a27-08dd5f7ff836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HVeMwbpu2lSMha24NReu7QUfu3N7eC7aTaHHGkcW7MUiW+OMW10iks0w21zH?=
 =?us-ascii?Q?UsYXiX98D3MSLzzBekA9xHrs7aa25Wg7bAjvA0FPOy+eAgTNLF4Kki002qoN?=
 =?us-ascii?Q?rlsiWYiJvqhC20n1M/rqoUTVCmnG8xqhz+SXVyGh8gKOSvOh8tCetQA/QQF0?=
 =?us-ascii?Q?0b5C4h1vr+sCPaWAhrPVQMy/AEaSANSblPfunotHm1idRfrMxGZQtBU/l3ZB?=
 =?us-ascii?Q?pKTRr5W3WBYrXlJaOH1KHSHv9Ev/SDpG5YQLc5lLTzWFVHJOvjxnjsutX4pl?=
 =?us-ascii?Q?XWwvLNpr8SZpP2rYgMecMhIBZJso1e6lCPvm6xRCdSnCTbQw8xzg9i8DjGsO?=
 =?us-ascii?Q?wO1gsmg2SwoFYflrTxkzMksTY/7w8dxY4uHxqfJQLRdAZbTmKM38Y5SfNgfY?=
 =?us-ascii?Q?zPZTguZo5eJHbLi3ZBgRu7xabinvnIhvTxWKn5rBp8qYwQWyOkJq3WtE9kyF?=
 =?us-ascii?Q?fKJQBJ4r+WwKnv6+pvXrAewcYg9JKH1DAcxEPJnLCbaJpkuasq90ek5ofYae?=
 =?us-ascii?Q?CYIrmHVDTOqyr65Sp/ey3voof0vncof/DctpwkqHKXZsP1QYrzBHYheTJx2x?=
 =?us-ascii?Q?GjRG3m8DEch6YOUFQud/OjKgzjRJGgPSN+pXEXQ1taawZs6FBoRE2Y1SVEqC?=
 =?us-ascii?Q?vMR5Wb9v7Ac8PDQl86K/OYgDq8g03IhvC53nfQ3z528gK+04iojXM8Xzqpts?=
 =?us-ascii?Q?epygol8VmO4Vc6iKHJz1CjGlqh72Oh7weNFSzaMvE4KtnCecqpOIBOjjO4ht?=
 =?us-ascii?Q?dldiAWKUNtMZ4RPTxmbLrIruKjjgo3pdFnwNcLFSfdZuZBp6QlpXCwYPAY3v?=
 =?us-ascii?Q?O6kCh9r/RzX4Y486pqngpdj2xnYWsb+VX9g5lDYoHNySia6XkZJh/be6bKku?=
 =?us-ascii?Q?gMzcpz9tX9t08l3d/jNWbGslk1CY2mdmSQGpoIK3yYmtFwJ8RMardeOlHvBM?=
 =?us-ascii?Q?iPrGIwveDY7jwg73M5Of5pvsCNijL9kcWT+6s51ee0dnLdx5QYFCIbG2l5Vb?=
 =?us-ascii?Q?vXAxH6fLB127R2Aiz0mcNgjKqcflXnCPFaw6YWYCYSmPNadSx2w2mnbmuC6a?=
 =?us-ascii?Q?VTB02VIn7ALgvqEwzcdWT2J6mln/oNzPO/useOqMtYeODyelYzm4J0edg69t?=
 =?us-ascii?Q?YGJa3PN6QcEQ+v/r+HvMYngJfr7QLhqtR9n9cseY9H2zWmLJDuPPOd6Tp7Ct?=
 =?us-ascii?Q?/oiW+0DBrBZcvxFS+jSVOdGsUzhBlilrUt9aYfKMBdFKyxXSUjSTypx+f2qn?=
 =?us-ascii?Q?/q1ps643n/a47pEQQBpxIojXvsq9HDAEkhqiguk5U2ygwh1/Gs3pHIbIF95u?=
 =?us-ascii?Q?nTm6r5aQOJ+Ch+8cRJ7rAVjkr07lp2zGOz6dsOvwHa1rrEVZv4Vm2Pux1/sB?=
 =?us-ascii?Q?rQfuEbWbWGVzuuIu8nz/0kk4YoJ/KchSd5ETPous8orpL8TvYuEo22lFTFqe?=
 =?us-ascii?Q?Pnpit7/P3j1vfyVtRA/4PbKG0omNKQBQRPY3nZqR88qCruMtcdrXZBmwmhTj?=
 =?us-ascii?Q?+IdOSVYjxfV6b58=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 03:02:18.4704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ed85f9-f1cc-451e-3a27-08dd5f7ff836
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

[Why]
If reset is detected and kfd need to evict working queues, HWS moving queue will be failed.
Then remaining queues are not evicted and in active state.

After reset done, kfd uses HWS to termination remaining activated queues but HWS is resetted.
So remove queue will be failed again.

[How]
Keep removing all queues even if HWS returns failed.
It will not affect cpsch as it checks reset_domain->sem.

v2: If any queue failed, evict queue returns error.
v3: Declare err inside the if-block.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 885e0e9cf21b..2ed003d3ff0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1221,11 +1221,13 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		decrement_queue_count(dqm, qpd, q);
 
 		if (dqm->dev->kfd->shared_resources.enable_mes) {
-			retval = remove_queue_mes(dqm, q, qpd);
-			if (retval) {
+			int err;
+
+			err = remove_queue_mes(dqm, q, qpd);
+			if (err) {
 				dev_err(dev, "Failed to evict queue %d\n",
 					q->properties.queue_id);
-				goto out;
+				retval = err;
 			}
 		}
 	}
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305DCC02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 20:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B786410E9F3;
	Thu, 16 Jan 2025 20:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H80Kn0Aw";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAF110E231
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 20:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=linJr+zw6jKxqFfEbxIedRbkz+QjJwpcXRjZvDH7odtunqgxjmpdNPrrhErxj8o6ao2w00kSI2XzHUFKhhKi0c6CTP/N3m5vTR0FTBSH/Lm1ppBIuUxpoFYiYIoV5qFpBZUOzYnx0r/LiOju1//9WedyXnP1PC4UbANypRZWardm+60vyPzJKXcG09VftKjGeoGdA6OtSl7wxaDszaOrYSNh2cu9n6bR8FB1QUUjAm/MaFeOtrsK0Gu5YFHnuscNrblS37aoHZF4KsQgWVpm7HXJv4OjNfFh6Qb4Dul8MQyu4WdDQCJzoEu8NOWST/oECT+1sywJHDM5UyQmkieHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbxoou06zKBt5HEuDRDdl8VxAepOJvZTdJkw7Jl7VOA=;
 b=I8k+EQCRoyyuFJ3uudPTY1ugJ8i378HdZ+u0p+oS1kLC+vsYEIwlQcD+E5We5RioMdhv5Zx4DikMm93J8nOCTfbw5dAtLnekw9+Bk6TNuRentgAAvG5wEi2pMI5QVC0bwhqu1scx8bElBZBKSAp6difd1gK9xOkjvP6vGVMPPRUTJvn56UiyorNdhc78u+QI/oo/+xX1b5l+sKzU9nch+LztZ4cGKpQ6dp/Zy5q/Hyzvyb32dgyutC0H6Xm0HO530GAajLafvIzLT0dx46AryPoknCLO3fM0zdopm+nFRm5FDQZlmN2fe9CjIfVQb0MLsPL0QHJ/pneUJi3BVE2KzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbxoou06zKBt5HEuDRDdl8VxAepOJvZTdJkw7Jl7VOA=;
 b=H80Kn0AwEeGDhuhT+jxaIuHnT1V79VgBo1Ne0I3UXw/94BBeSQFr3SZXW4jthTKDYkCRIog2ZNZYvxzFprs4yGh4eQRKGPZUf5pFR0Z5RHsDmiPqNG78/TM6PeyTg3M+pLLCaVOoyTszG3S4SLlkGOBPNNkRp6jxyEievhb/BI0=
Received: from MW4PR02CA0028.namprd02.prod.outlook.com (2603:10b6:303:16d::7)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 20:41:25 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::6e) by MW4PR02CA0028.outlook.office365.com
 (2603:10b6:303:16d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 20:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 20:41:23 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 14:41:22 -0600
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>
Subject: [PATCH] drm/amdkfd: Block per-queue reset when halt_if_hws_hang=1
Date: Thu, 16 Jan 2025 14:40:59 -0600
Message-ID: <20250116204059.618389-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 39354ec4-0ae3-43b5-d28a-08dd366e2436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R5wncypYV2oQv1KVfbqUXJFq0kmh5p+yQNRllWTZQZLT1Uf809GInSWOe+ZR?=
 =?us-ascii?Q?0i1XvnMUuzen8asA35V3JxAofwP0noEqvu42E3siFuoDg6oybvRhjTErIFSs?=
 =?us-ascii?Q?mAcKnZlGdH94yHFehI3lBpmVT2NuZviMEiEELzRKjS19XQc6vnnE9X/UT6Pp?=
 =?us-ascii?Q?ijYnBeQaqKLd+Il1tR80xPF7u/4mn2FtZJkybN/nJsmolz1m2nPCUHypfVfb?=
 =?us-ascii?Q?1MROy1CLAffEdRvXvNpfX59z5m7veN3HM+J9J+JJM12+XbLOSS3kq2+iTmQS?=
 =?us-ascii?Q?iZz34457AU+9/b1lulabaNSzqQCw+3Xufw2arOUf+mQnNYDhF2J4e3zI0w6M?=
 =?us-ascii?Q?BMCbcGDtUEZj6u96bY8pniVZdoTX6Co385MKa3CtXx2svg5yerUZK97U2P5X?=
 =?us-ascii?Q?r15Th3Lk7DIAqO3+X2Z3ReDvX6PYFkQo9/FHWVT6ZWuUOUku/9oTfXTmaDvp?=
 =?us-ascii?Q?G4UngsmF0nnHEutWR6vDt8hS+9+MKVNT02Ak3BGCaErdtuznxQzdkmfuIh8J?=
 =?us-ascii?Q?bwgUmV90ltqJ+TJi7ak+XV7RB7XwXQ6OuLNL3TW2znYDyqFX2EFxERdMQakK?=
 =?us-ascii?Q?QzZDPyJdWw6Yx6D5KBoIZLnqkw7zPDSq7FQKhWvgK2VuJWk1C+O2wKgTEFVZ?=
 =?us-ascii?Q?6ggO2anrFjCvlFuC/yAb1wh0lW2yRnlB+UQBKbnt3+skjzQro5fGGcPNhGv6?=
 =?us-ascii?Q?Gzx0PfYkegIVTe5Od/DnGVXtnr9z1L39vMvRn/xRCpBI69bFujaweiqKZQ5N?=
 =?us-ascii?Q?eHmOHfiHlQZwMGIHwl9N53wd0yhQvL66gjUL2pb9YxmldrtopRtWtZVGCh98?=
 =?us-ascii?Q?kRPY/7o2Y/Znh+XWaDPuxIRCTXiU0nJDf8T/DMxybTwuzm7qte8wNJs5gVW8?=
 =?us-ascii?Q?q6KYvOzj9c22qjkWTnNJ3mx98vtmKv6G1IIuy0/R78kw9+tD6fkYHItNzfIq?=
 =?us-ascii?Q?YXEf1UncycK8/xDjQajRLvPwGm4UMfCme+UP8b4Yw2eTwXV0QZ1we3KgBHg8?=
 =?us-ascii?Q?AXmGVtifxUYwlTIEvEipNTi7yE3H/8tOPVBaZrJP4Gi766Yx1aSChHzZS5yA?=
 =?us-ascii?Q?Zs/HtiyWmZ4+P2qvpghusH3eOMgdT4RJ3FSGD8iXNVeoMOj6bIcvo9Eqkegl?=
 =?us-ascii?Q?b1RrqwXKYH5jJXX98addveBliOtPRf2XHaGx9D2dctJQGHXFfBjLPTu5259k?=
 =?us-ascii?Q?eHi93BNPFgZzRfZ7NayBX+4N0kalL9BpnSc8WNmk/NBFGVvMDWkKo2hK9SoM?=
 =?us-ascii?Q?hQ0JH0pnzQ35FjQuORJ8QpJ2oxMLtD3eRWLI862cgyUbq8CHnm5W6Q4tcLht?=
 =?us-ascii?Q?BG5/BN/XbO1AK4qz3nN0ljlhJ/04TJa5nVQF3Q6bQaOWBkCcGAwgyfd+b613?=
 =?us-ascii?Q?OKvYiuPrYq8Za2OSl3LIUA5987klFrI2hTwF5gvave+gMKs1ksssluBmOqfo?=
 =?us-ascii?Q?G/EINYQkrEq9T52/MLM3PbpiQu8hw5KuwJOaVxvjG4jSoY1JdC2UPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 20:41:23.6790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39354ec4-0ae3-43b5-d28a-08dd366e2436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

The purpose of halt_if_hws_hang is to preserve GPU state for driver
debugging when queue preemption fails. Issuing per-queue reset may
kill wavefronts which caused the preemption failure.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f157494bfdb1..195085079eb2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2327,9 +2327,9 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	 */
 	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
+		while (halt_if_hws_hang)
+			schedule();
 		if (reset_queues_on_hws_hang(dqm)) {
-			while (halt_if_hws_hang)
-				schedule();
 			dqm->is_hws_hang = true;
 			kfd_hws_hang(dqm);
 			retval = -ETIME;
-- 
2.34.1


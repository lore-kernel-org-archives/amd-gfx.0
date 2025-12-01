Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0097DD116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 21:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908A810E492;
	Mon,  1 Dec 2025 21:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BOwAVkve";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5939510E492
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 21:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qaKe7i2GiHRw3551H3LZ3mCDz+93M+8VNQsRw05kc2F96FrW9RTFgZGfa2Dv31z/hAvVik+Jwry6Erk4cuRL1Yvj8TQKC+QTc0ykEVzc5b8CUR43jK91++oFe0/UTJeS7Vig2GiD+Y0MOQPDut8qcjwVycolilLSBXiQixcYp31FPUdGab2Pv5dRq0k9tXQtwqNueeLEma/x+uqwVmsJQb/6jXbIHLC7W4CEq+hQ+TKquhqPEhkxRShqrh5vXQznsUZMk7otH6LivM6eQd8Z+3wA5X0EMxxnYVPqKIl+Mq9nSQX6mPQ9Haf5OwfmSHjXC2WMficfJ65DdRPFc9liZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojqRM3bH9cDIRePFwYWX7zGJmFd4aftjWpRo8tGjeAs=;
 b=d0tg6uCDIS2aZNxY/VoJ7b3dJeCzVbhU6bjbpR0KZ8uMQX8GdZlVvosboTUrk0N86A/FkSe2o9m5ZgPZhdDigZxUXZ7rx2S+I9G2WIrkFg13qUnwwyqWpLL7XzvV2MfjuKzoYUQF+cbHfrP1y1DYI31kf3YrR9yR8CwPRIivWDZhOOhoQT91y7WTVN4VD4nbYH78FDxgYrYk6j9fxor86OcZtD62ogbU99N5QO0WLswz8FQ3JRo9JOtWvR3aUtIuItbOfAltTJDGeK41F04UmUdpwO2IrSycDtxW4TOqL+BZ1loixnL9T/gQstpz8YhXc4MRHV6RvB0YqeN7tHi+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojqRM3bH9cDIRePFwYWX7zGJmFd4aftjWpRo8tGjeAs=;
 b=BOwAVkvePiyhKqxz5kLW/jr9y9n2uRcjYOTVcC0Y+7b3/ozQFST0SmNSllp/+PsuusyWPqC7I9VbcVUNheHEjVoxhTVJBTfPHYdMc4d/24y20Y6mVDNT3WN06W3DZi4MY9OgsWdIFrlRVDFOCzcDjuPLjxwvjjaZhUR9IzUJljc=
Received: from MN2PR17CA0019.namprd17.prod.outlook.com (2603:10b6:208:15e::32)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 21:02:42 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::9c) by MN2PR17CA0019.outlook.office365.com
 (2603:10b6:208:15e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 21:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 21:02:41 +0000
Received: from BDCBKOCOLOS01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 15:02:39 -0600
From: Brian Kocoloski <brian.kocoloski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, Brian Kocoloski <bkocolos@amd.com>, Brian Kocoloski
 <brian.kocoloski@amd.com>
Subject: [PATCH] drm/amdkfd: Fix improper NULL termination of queue restore
 SMI event string
Date: Mon, 1 Dec 2025 16:00:08 -0500
Message-ID: <20251201210008.40096-1-brian.kocoloski@amd.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c46d4d-43ba-4fb2-81f0-08de311cf7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NzNTWkaAeOEKCNVcQD/ZeIdBi5yZIB8ufvmvrEePN83Z0DpEy1y+CCcrzSgk?=
 =?us-ascii?Q?1d4AhswyRVdvZHV/8exj4uqkQnONEWp2NvIypRQxbuGKOq+5/toRajz+K6pR?=
 =?us-ascii?Q?vyMSD1QGArspHouLonhxSmho9tRBTfcKujSOBdDTkFHRX7D2FILIKO4C/7d3?=
 =?us-ascii?Q?AkfRLw73qbiQ5/yI2iDOhJcj6chg8TFur/m4627IZzUh3nsSA+pX12zB0lZl?=
 =?us-ascii?Q?mgfPAXJGVt5WzRNBMQeILHbJXZGku+oIH65smJ5J2sWb4WW4XTSuqETLCJI6?=
 =?us-ascii?Q?/OF1zuhVuwGVzD2lOTcOBXGtQAtTCb5Pmbf7rtP53BLD21DUsfFgJ8gpreEL?=
 =?us-ascii?Q?vCVGzUNzKeUCLOmvxa/krhX730CCp38pRBHqzTzP0TblsYgHxnsj5J/hzIPV?=
 =?us-ascii?Q?JDdjPjZDzNgK98p8EHTteQL5PJvH2D8NZevoeooGozNLV5PvGKqUJT+Aoier?=
 =?us-ascii?Q?45PgOd9b2bqoOT6lacxPBl9Or761ZJAyYHARVGOLLRwLwwtnw/QwAMVs6Mvv?=
 =?us-ascii?Q?fwa7qmV+bat5ZaTuvl2S8vGDGtX7tj2avvIWveL1cvyOaUmD5qrYsfcuQixs?=
 =?us-ascii?Q?ZFQ/4RNEzblDL4c4rxyaMbXzHXoj7rGsa3fEuKm73XVUqvzQQRi9A9xwWJuR?=
 =?us-ascii?Q?0ijOthX4s+VuWrprnVGL7ScF73aEe0YiMAKHY9jh3LBvkLJ2MMOJrrLN+FWi?=
 =?us-ascii?Q?kg8TKy8WMzGcLP6OeW43zWzg48K++W5V7vzbF9qzQQ8rHB6JuOHTm5cQIVW7?=
 =?us-ascii?Q?B6lqLbWy80ZQxG0Cqnv7HATAg7ZNbNc3TK01B6TGEnAs7Hjc43Kb9cv+lWvk?=
 =?us-ascii?Q?E4rTC0Qi0Ak8Z2j/lKZ01sMaoSzOWxO1uYe0p55wtQOx4JNEpTkKqN98i31S?=
 =?us-ascii?Q?kNH+B2sqV94npaDEGikqNreELGlZZLOnTC7lp9//2MxySee+Zes69Mk/03Em?=
 =?us-ascii?Q?CcyRKzxjVaZGWuyiwxo2rte/pyxwmD3xZzCHGOm04zSBp4K+j+l5h8vF4Pbs?=
 =?us-ascii?Q?55fsa4n8RdKC9AMhQ0KvI+//ymTc5RKhyd2TGu+nLIs1bBEH9thJ4wx/FcH+?=
 =?us-ascii?Q?Dd3K3NcdMVmxPgBJTl7l/3ku45Q0frajAXHWFphjggHeEwQJwCLAZgUdA+PB?=
 =?us-ascii?Q?Lc1aha4diFos//7hZczZX2G/dXkn0eZfMnf4qi1JPp95K8rFqhuu3nFkXBLR?=
 =?us-ascii?Q?G2x9BE+KwRQor2pvXgZBLhU+isbCXPrx3vN4Be9N4IhiccvGuA1hP9EpojtE?=
 =?us-ascii?Q?hBU3nXaj26SKAkGTN56/BX7JI0rmi5kY+IDn4cjxqecDXb2bybZzk5+BshmQ?=
 =?us-ascii?Q?yQUkDlPl13Ciqk2WLAeOxSb05EjkmrJmpLFJuaiUgmQMLv60hVeZ87B82l1W?=
 =?us-ascii?Q?MmkYln4DOGjV9oXUEMqtSeBfior0iytBMupn/iig0RtZb6SmXxjeyua6DiYe?=
 =?us-ascii?Q?ctZokhmpW83iS/3/wJqtCJTv9++xC05W6pXvu1g5jrf2Iffo98w6xKrWIABL?=
 =?us-ascii?Q?ML/v1kM03+5fJ5nuh3lNFB4KQgjbjtcxlFt2Nd+WC8W+BV5LWRlJ42Kt648Z?=
 =?us-ascii?Q?MNlkElD/4J+pr4OzkC4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 21:02:41.6936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c46d4d-43ba-4fb2-81f0-08de311cf7ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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

From: Brian Kocoloski <bkocolos@amd.com>

Pass character "0" rather than NULL terminator to properly format
queue restoration SMI events. Currently, the NULL terminator precedes
the newline character that is intended to delineate separate events
in the SMI event buffer, which can break userspace parsers.

Signed-off-by: Brian Kocoloski <brian.kocoloski@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index a499449fcb06..d2bc169e84b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -312,7 +312,7 @@ void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
 			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(), pid,
-			  node->id, 0));
+			  node->id, '0'));
 }
 
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
-- 
2.39.5


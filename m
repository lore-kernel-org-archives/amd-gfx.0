Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025EBCCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 19:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797BE10EC7E;
	Fri, 10 Oct 2025 19:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WbdJomdc";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FEA10EC7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 19:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhI14KQGHB5rwwVW/NRAodj1HR3/Sxaal7+VEd6voE4sA6A1IQtLb0LB6b54drZbIRAshCnOx7pD0wZ50nZhJuCLbWnMvKs5NjY4YZYEkvQLdtmRLaTUVxjPP9GpsZNaYjHNayV+mDkJVX9x8im4G1ZKpKANnjIH3rdRVFITZWoKVttA9tNh6gslod0HlI7jSIcw48PnwX8MAmpGU6gwkql47jYeJvFhJgp6nCMejcU1+TDQ3TC5Q34OgGcVimoc0nRTWWDZhQ6bDa6drdsRmX52K2JDh8q+tXmXOBPUYQ7cbxcCBJp0XFL3DsNHz9IVphOWSvRG79eB9hiSaRLAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhisflb7T95XvzVk1Rv6WAqyJ8rmw6kamnogIwRcMzQ=;
 b=LRTHd32xlM0ppyU4hzWY9Ta4Wfb1bHZXSHB0vLa6FYF3c0Z7sLKW7aGKFzoty+UJT5aazBWYk0+dqWVrxHxNSL/DqcG5+xKb/k5mQzOmveQhee8f9/iEuhwxrwoXUbfOPX6VV2ecvOl9eZMJEvs8sBTkP0m1i00mN8JNL2SNklF4NCC1CphH2cLCnpUUeRYTJaXDpk6eWOl141A9ZVILMzN9KfdEcOmQxq/nSez/5OL9ozedpGAoCWRbvkyK+YA48DT3M/Q8P9pSLy6SefVp4vkJKjh40YcSUgJ5MusAg6sjtQZpJ22BzDef3J+eaDOVY647EbDQE9hhuoKMEk8bfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhisflb7T95XvzVk1Rv6WAqyJ8rmw6kamnogIwRcMzQ=;
 b=WbdJomdcHieTrE9rmmuNO4dA1UdsQtMUTQEjNQUA0tDNqoTx1Gan9nlQ2kgpmq0YORAXnAYzAt0Scf2vshbTdzPW3Ad7zDkuze7WTNtUc99//B5HVJGs5ENDZwEFFtdZcJ3QPthRtETtKTGFEONoT5f4zORZ55ec2tWvxXxVaG4=
Received: from CY5PR15CA0193.namprd15.prod.outlook.com (2603:10b6:930:82::21)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 19:34:40 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::35) by CY5PR15CA0193.outlook.office365.com
 (2603:10b6:930:82::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 19:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 19:34:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 12:34:38 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix false positive queue buffer free warning
Date: Fri, 10 Oct 2025 15:33:48 -0400
Message-ID: <20251010193348.23271-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: ee80d5e8-2654-48c6-12ae-08de08340dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?illj3DcN/mbCNVl2K7FkfZ9HxKXtgbgeUgn4miJk7vvm1ppbNf9kZUkwlnVm?=
 =?us-ascii?Q?gaGaj83cb1aLBcrfgWsr4A9CDfNu/VGr3orX/xNHgd74vrgpflow+hIxU56F?=
 =?us-ascii?Q?qMWC49nB1tposotztGFA2A/3jKIy0NMjG7sy017v2YgyNVJ4fugCJCP/5vo1?=
 =?us-ascii?Q?tTtDoqO2vlyYV6WzPFVPqJvT0YscY4b9WaXLckVryzggLJgByQe21WQhtbPj?=
 =?us-ascii?Q?m7H9PixN+Dzp5h6UFflHFVBVCprdHSFRW4jss/pJIMeTZ+dfwE4fcBK7FwWE?=
 =?us-ascii?Q?Gxzw0KT1+RXQuXjtIQWFNtswHKuTmgcFRJyV9+jVLKrIXGgW6lfHLP9Wr1rx?=
 =?us-ascii?Q?ycNb/1w8/V17YgWBs/aTB3CQHK1KJUZ0+3boEeJiqjY/0dMIohFPMv9masIr?=
 =?us-ascii?Q?GdlK2Q3Wjyrp+KJp0ZDodwmtY/c1fn4GP0cjEyprQ5wl25fuElc6VVhyo187?=
 =?us-ascii?Q?FITcD3FVK+wL+SkUQspmMtKfs66WI1mWxyBLIGJ9BUPCBSxr0Rf9MPp7/zn3?=
 =?us-ascii?Q?RsdX+ezU623Ws0anmY1Be00ne701/6ozj+8mWPGWHMFqQ6ewoaJCvEptep+K?=
 =?us-ascii?Q?VtH4T8YCthQxbhuzUbYspyP0GUjwVM4eiz5WatLlrqdwjYSsmioYLjcMzXj/?=
 =?us-ascii?Q?m52R91ApArdLKRXHt69f065J1SA4DFM6mvWgL37/5PI3Kw52cely3EQQIoxh?=
 =?us-ascii?Q?+joN2lEY9SzVSiPQCnxU7G+ABte8wg2vA9OyLTx8tU8Ek4/IgPydCw9VKi56?=
 =?us-ascii?Q?EryE3qf7adKJbwDIy+VP4tM/kZhIqxAMmoXPUlVjv35vUcUeJmQgm5aJSoRD?=
 =?us-ascii?Q?dKioHzwVppiUdRT3iZZF0vgXlvh5djf35CegWbm7v3FAO6ko7Bz+mX55F9ah?=
 =?us-ascii?Q?kuq30Ok29yO/1Nj5uw/WOZCENZ1VDOnnWAM2vyMVXmJBY2XmlMDJ1sBC1av0?=
 =?us-ascii?Q?aRq5SotyQaUU8SEwep2/tlcF5lAlSV/KwXH5iHQCx4oTCRjuiz+Sd06EAQ01?=
 =?us-ascii?Q?l1LJrVeqSxEIlqPi8LQgl7sGx/i6Jxq2rli/mHKMlVhKLPLcdYcOHBPy95rP?=
 =?us-ascii?Q?Wbh1d32mcbGKDOPO9LnQVPgeS4DkdM9hqovU84E/BukXvkUSk4YoXtwX4OjW?=
 =?us-ascii?Q?vU/euX1zuv4/89FpBkENG00dnszxy+ipIGB0JK5Hs/THApc86WqjwQkQVoQJ?=
 =?us-ascii?Q?7gjUeMYeSjh1SGEMHJJdiiT49MpANl5ELXyyHACo0VhwMJbVV9R4MZFjFdeS?=
 =?us-ascii?Q?Cvgu6/eOAjt9wXpLQKgQuygcDEzHv1lbdG2Hs4Srah+0Hi752e2Mnbf5JKJ/?=
 =?us-ascii?Q?gcfOJW0QqiRPoreGooOzED3NN68TVWPBgnFaSWKoBM8/qZ9GgP15i2i3ZpD7?=
 =?us-ascii?Q?pwJDzgsQPm5mS/Vr1a4PnxxKDoXfUcU3QNWG8gBj17rVll0/RNvrhxyX1Da1?=
 =?us-ascii?Q?+P3BhnE/DNw+IzRQvH91KAce7sH1YaIlSWqk9mXOHdb3YgNAoUqmGFLjyckS?=
 =?us-ascii?Q?WKlfo8Z+Dqb4atOOOsuDoNB8eB8AnScNPgPMyGLcDuf54oCongnzPro8BtOL?=
 =?us-ascii?Q?G3byDWm7dlz1rMbwBwc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:34:39.4193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee80d5e8-2654-48c6-12ae-08de08340dbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
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

If active queue buffer is freed, kfd_lookup_process_by_mm return NULL,
means process exited and mm is gone, it is fine to evict queue then
free queue buffer CPU mapping and memory from do_exit.

Only show warning message if process mm is still alive when queue
buffer is freed.

Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 48c9a211e415..9174f718482a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2487,17 +2487,26 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	bool unmap_parent;
 	uint32_t i;
 
+	p = kfd_lookup_process_by_mm(mm);
+
 	if (atomic_read(&prange->queue_refcount)) {
 		int r;
 
-		pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
-			prange->start << PAGE_SHIFT);
+		/*
+		 * Evict queue if queue buffer freed with warning message.
+		 * If process is not found, this is free CPU mapping from
+		 * do_exit, then it is fine to free queue buffer.
+		 */
+		if (p) {
+			pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
+				prange->start << PAGE_SHIFT);
+		}
+
 		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
 		if (r)
 			pr_debug("failed %d to quiesce KFD queues\n", r);
 	}
 
-	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
 		return;
 	svms = &p->svms;
-- 
2.49.0


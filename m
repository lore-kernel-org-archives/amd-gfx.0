Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B60CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6537B10E339;
	Thu,  6 Nov 2025 06:08:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RcUWB1mE";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010044.outbound.protection.outlook.com
 [40.93.198.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E5710E337
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB275QHIDEIa2Ltnrf8aYtzcGBYx9NCfdsEiFIjJ8ajC4yjIaLtw6RXJAvT3xYYxT5xpzBX91o4B9AnjM3kexDVrg8VVTYh7pfFJwM3ed+DOL/kYhVDus3/trPI7Wila80RZ3XGG7GkbdWg4cneW/pWS03B926AxWWPpFyIHnuS1zSsQB9nwWATfTBLBSlWISZIELJuX2hqy6lShyYa0ApltIj78JK9biCLZXc6eHVI41IL/RRHgeDl3uy0l68xB4tOtjFPm9N+HnRgmqXLVXEACQoQBWQmLu6dfrPBHfMpkGChxZ0vtTYqS5h3GYe4kP207m+qgfc5yHAlffockjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErIyOEds1cS2YnbwMAfHz9eNzCGz8gTtCackS0P24JQ=;
 b=RDqIMbLxBufwweEbG+kQvXBeTUTpIz1XNzDP7ISj8x1Vy4VhP8veu/cJNcii3rBDwRrQnYz7BpjHP0f0eIi7usBuSaIBnMp9QfWEQc2WSvUM0m5xJTxzdccRfy8KpF3GFSwr6wNGGYPwtTFDcYti+/1FJ5CcQVbnEAX3wKj5PFuoKpoFqiPOQu0oBk2soG4xmSoT+0lgGKOikoTSgkPzYggKQk5vkQm2EkuV4EZfgSEw8jbqFlK2ES5aQeO1+elr3JWLhFaDP8C8NK0IacRZK3g4BUKSAmYGqa+wdh8Kjtmg714AKaau3JLG1mI2RyfsQA3lx4bKihM5/htzOmxQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErIyOEds1cS2YnbwMAfHz9eNzCGz8gTtCackS0P24JQ=;
 b=RcUWB1mEANKBALVZEw3F1ntH3IVTXm3kA3v4IKjR/9PE0BQwB8Dm6B6IUTjm0LwSbunK9Oqi1ttiqyixvfRoTw9VHiZj5XoX7H4mHhQCeRv+kXPskc4FGZY2GNXaCaXS1EOymgC1EfjnfnRd70nAsQFiKvE7HDAQnyyGo1qMJXY=
Received: from SJ0PR13CA0125.namprd13.prod.outlook.com (2603:10b6:a03:2c6::10)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 06:08:14 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::14) by SJ0PR13CA0125.outlook.office365.com
 (2603:10b6:a03:2c6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.5 via Frontend Transport; Thu, 6
 Nov 2025 06:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:13 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:11 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 05/18] amdkfd: destroy kfd secondary contexts through fd
 close
Date: Thu, 6 Nov 2025 14:07:26 +0800
Message-ID: <20251106060739.2281-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c57bec-2fff-4535-eca3-08de1cfadee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ogr8txjEOG0hyddxIvC+B84Xk1plENbcA+WXBx4syXb7DpPlhL+MJWb76DjE?=
 =?us-ascii?Q?0tmY6oDMGuyQjFd/9Kmn/srAbjaSFhjDKSOtyZzZpcxzh3i9iKT9p5NXvRJZ?=
 =?us-ascii?Q?83Wd83GRh6aAI40X+cNqPeo509rDe4cXhgUQTjyJYDc8zfxFAyKksN2YgEPq?=
 =?us-ascii?Q?cm3F81JrSEZR5UWBAFheQdbe0HNjxe9ojsCSDSYA0x96B9aL3x7RwvWJTJWV?=
 =?us-ascii?Q?szJ8VoeFK0QV77eabgINvHfJpCvuDY/Dgf9zN13PjY8L5vl26lZBTqa0NT0l?=
 =?us-ascii?Q?zXdhZN2BJEuO7AOufEEm4IZGeCL1wZ/2gR7VbfPKb7bYBhKrwnBqQjQMav8D?=
 =?us-ascii?Q?zYUI5ZCi9jpTkhiGeQ5TeErPETJR9m2UjS2gBQez193jgn79GF9AoXzbLwGR?=
 =?us-ascii?Q?h2+2zvr3wiziPPxQ956SOAacpErPL9AGhItexanMCxqcBbyG3UlC9010G3ah?=
 =?us-ascii?Q?lSDGed07c86pXamvXwwMsY7mjSF3TJ/s0mcDcGZ4u1J61RNROqD6MQ/LSCTM?=
 =?us-ascii?Q?+KTIv0F1Cmq24cBJSUZqF8EUw/W5EJUziriWFfD0S3uTvG3Onj8Z47qvbn3c?=
 =?us-ascii?Q?46V2kY8Dw4CAGzrFmX6WjDY8bbpWssxWLflyiD5hBCCziomQN/ISZERK+ZwC?=
 =?us-ascii?Q?XT5K2Pc+E60d9gCEKN6V8+82LgnNz3K38oehqqelEjZums9zSKm+ADljxY+g?=
 =?us-ascii?Q?/0KeahXMaDgNMF91tnEobqKi5O3002T6ag7SyBXhrvDWkWj47FJVJWsRvQ4x?=
 =?us-ascii?Q?JIUh7dzs87rpihyPoMIz9VNdhAPQvT2Owha7OJE1EakFekgY39de4idgu9TW?=
 =?us-ascii?Q?OZPzkHfJfxdfXsSXQyYJZwiMuB54pd5nrByUDpxE+Cl/uhLtQx8QliAaZXti?=
 =?us-ascii?Q?U015kdcoaKe3XYhLtkl6ZpnSF9HXxCavk+TntG5B5o06JCSdZyb1cK6JesBh?=
 =?us-ascii?Q?yEoUcXd2Jh8TdNQFFAzNFOhwYCnhLYmgfZB+CDs4BdqvRWtcmdOlJYZ21mX+?=
 =?us-ascii?Q?AovP2tK0kZkqnXrSC36ChxYzJDY2wrKBImxRcDHSF1/AEzp4bPr/V86bmq9e?=
 =?us-ascii?Q?NnPxMw1FPxT8aiIcvI2NsA+goDJ0U9zwG5YfIDOB08AMXkgpR0r+yrBMDy9o?=
 =?us-ascii?Q?8ngl0o3eVxeDoV1XdFtWDuoxpcSDWKSKrOuQEi/lm/G9hR849b6QAlvFDFr6?=
 =?us-ascii?Q?raJ159Yr4SbhEVsQB9iIOUYehZz7MHdthVILfiQ9w96ME9jitrUjVXInJ2wu?=
 =?us-ascii?Q?0k7DUv//o7CquU7yjiA4M5iVwuU6pAcDfMzRalPIvoAOkAMBiqt+QzrmplGH?=
 =?us-ascii?Q?/KBdo8uNy9/eWXs6s0SWsVlLxPEfh5W0aDUNlfrxqwWeOiNKOe5zsOpdp08d?=
 =?us-ascii?Q?SG+Tg3KAekiRh9kcl07/3BZ8hxOLXVrnepDo9xar7mt2lG16+gIjqt4KbWfd?=
 =?us-ascii?Q?bPPkGR5LeOG6b/fHcW11VtTJZzRzvXw/lEs0T/m2+DY3uRIL9w7IZ0XrVE/J?=
 =?us-ascii?Q?ZtSXBq1mkbB4bh/eF27216v7I3/SGJnuPyDj653mroMRF2lnEuN8hUL74HeI?=
 =?us-ascii?Q?sYOiq0aUFVusz3vHJo8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:13.8728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c57bec-2fff-4535-eca3-08de1cfadee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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

Life cycle of a KFD secondary context(kfd_process) is tied
to the opened file. Therefore this commit destroy a kfd
secondary context when close the fd it belonging to.

This commit extracts the code removing the kfd_process
from the kfd_process_table to a separate function and
call it in kfd_process_notifier_release_internal unconditionally.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  9 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 41 +++++++++++++-----------
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 0f0719528bcc..158e75975557 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -164,8 +164,13 @@ static int kfd_release(struct inode *inode, struct file *filep)
 {
 	struct kfd_process *process = filep->private_data;
 
-	if (process)
-		kfd_unref_process(process);
+	if (!process)
+		return 0;
+
+	if (process->context_id != KFD_CONTEXT_ID_PRIMARY)
+		kfd_process_notifier_release_internal(process);
+
+	kfd_unref_process(process);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index cfedc0c5892c..919510f18249 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1096,6 +1096,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported);
 
 int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
 			  struct vm_area_struct *vma);
+void kfd_process_notifier_release_internal(struct kfd_process *p);
 
 /* KFD process API for creating and translating handles */
 int kfd_process_device_create_obj_handle(struct kfd_process_device *pdd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 83fe571b801c..995d27be06e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1235,10 +1235,30 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
 	kfd_unref_process(container_of(mn, struct kfd_process, mmu_notifier));
 }
 
-static void kfd_process_notifier_release_internal(struct kfd_process *p)
+static void kfd_process_table_remove(struct kfd_process *p)
+{
+	mutex_lock(&kfd_processes_mutex);
+	/*
+	 * Do early return if table is empty.
+	 *
+	 * This could potentially happen if this function is called concurrently
+	 * by mmu_notifier and by kfd_cleanup_pocesses.
+	 *
+	 */
+	if (hash_empty(kfd_processes_table)) {
+		mutex_unlock(&kfd_processes_mutex);
+		return;
+	}
+	hash_del_rcu(&p->kfd_processes);
+	mutex_unlock(&kfd_processes_mutex);
+	synchronize_srcu(&kfd_processes_srcu);
+}
+
+void kfd_process_notifier_release_internal(struct kfd_process *p)
 {
 	int i;
 
+	kfd_process_table_remove(p);
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
 
@@ -1272,7 +1292,8 @@ static void kfd_process_notifier_release_internal(struct kfd_process *p)
 		srcu_read_unlock(&kfd_processes_srcu, idx);
 	}
 
-	mmu_notifier_put(&p->mmu_notifier);
+	if (p->context_id == KFD_CONTEXT_ID_PRIMARY)
+		mmu_notifier_put(&p->mmu_notifier);
 }
 
 static void kfd_process_notifier_release(struct mmu_notifier *mn,
@@ -1288,22 +1309,6 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 	if (WARN_ON(p->mm != mm))
 		return;
 
-	mutex_lock(&kfd_processes_mutex);
-	/*
-	 * Do early return if table is empty.
-	 *
-	 * This could potentially happen if this function is called concurrently
-	 * by mmu_notifier and by kfd_cleanup_pocesses.
-	 *
-	 */
-	if (hash_empty(kfd_processes_table)) {
-		mutex_unlock(&kfd_processes_mutex);
-		return;
-	}
-	hash_del_rcu(&p->kfd_processes);
-	mutex_unlock(&kfd_processes_mutex);
-	synchronize_srcu(&kfd_processes_srcu);
-
 	kfd_process_notifier_release_internal(p);
 }
 
-- 
2.51.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B709BC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EE710E803;
	Fri,  1 Aug 2025 08:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HG1sMnYd";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F6510E801
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9EIN29ZdAO5xCoZXTDXry3n53gfNzz46BdQqz5wimp9YHQiWqI5VKrpGc9ZCi6HyU9X7DHVzl/vEjKa9LiiOrjPXiLKcKg9NewUbiEvpG4aLybAhIvtA1tZPXvwaTMj6fBaKi98CLDOqp4hxWIZl6T2Qx2usD8/0UhnKOVF4QhIpO/NlS1B4Fw2vLRieJh5PgTqbCXD7I3fhA6JPcKJ+Ry8IvapvA3W8mwZo3VpdQOpsaO97WXEb8YC0HNm93+XDzdFy9CDCyqOx5lOQudJ81HFBM6nj0z47MGIE1HVefZCLpYuD7QmohTFj9FbZRFml+Apybi6Q0nyfw9tOz0eqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHlszyu7GS5b8gXq5cfa6FYHLG1h0Bc8WclpNIJ0bSo=;
 b=Qq9TbF271LrGc0tysraiOVM+0kqJOggAUCp/dXZ60ZMoSHE/YZ5boZ/eK0EVXDpvhqnRx8CWktnJpjbR/cOVT5cIIsV/fLr3gU56ymfZb6lZmHIGr7jkNznthOX+EURWqmqlz3ne7v5n5uvVuWWE3P4TpFlO9DeaA34sZ4O02Z2ga6gT01JTQUki0Jy5ySW8QCf5cW4vXWd0/12gfyfFqcDK/jW1kNhXkrgU81ANaOxfyXE5Gc+hdMpxoyQ1Hyat2ThTs/z+VaSn09o+nNG8DMfPbjCouLwobHdVdM4WjoHqMBqVYJwHGJTg5eqyQp782E3ytciUZqWqrYIB8h1fKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHlszyu7GS5b8gXq5cfa6FYHLG1h0Bc8WclpNIJ0bSo=;
 b=HG1sMnYdHZfU1HJA4FjCtuCMdVMISZFcSehwnlYaoAx8dJszVKZHrJAE1uOfvpqAYfnDFSx9n2y/mpQd9LTJ9VdHZU9sqre00em/9N6He+c/ehOKPjXS8AN+FffiFZxfV7f50a0G0i+vAoKvZr5iNqrjrXVfDBhQXk9e5qFNTFU=
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 08:56:28 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::b5) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 08:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:27 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:25 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 05/10] amdkfd: destroy kfd secondary contexts through fd
 close
Date: Fri, 1 Aug 2025 16:55:51 +0800
Message-ID: <20250801085556.8504-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250801085556.8504-1-lingshan.zhu@amd.com>
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c01be7-d030-4e1f-60e4-08ddd0d94d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l1PbfHVWvmn3QZfZEpEu2O6L77H9NhcM8HZyZhczVtsD7XdG3//DSg/Pw/3Q?=
 =?us-ascii?Q?/gAGZSjxV0q74WYIWppdrNewHcVR5RbfwYgB1iebwJB4CfES3CuIkcdK2Q44?=
 =?us-ascii?Q?Q3hR2/yLu9kpd6Y2iHLu7xkTcTB9XsilkO2aIDwPhQQ0zGEaB6QKlAuIbh6v?=
 =?us-ascii?Q?vpea2SCpMX3qyxsAhRTMqOXne/mDBMxxIEjqdnhAxG2rUHW8R+f4jOsrIcTJ?=
 =?us-ascii?Q?I29HxFBgA2Ykbq5yVW6AuNV0EDRphgvy8d+I85/zp8bLcXOkHkMEuE1fvboH?=
 =?us-ascii?Q?EUOpwUaPYsgC9MvATkgj47i0V/MNfJU+uGmHMWynqn6SOXvFt5sERvblK1Se?=
 =?us-ascii?Q?yfA5BYrDlLpDO6aPu2nKxUYibG1SqBu1qWRYNsb9QQx2ylIfhc1W71EQ9nl0?=
 =?us-ascii?Q?O02C1JJoR9e190oMIha40354ykMsl5Qs4y9PhbhuE6Fxrp/y6WEB7gG1B1Dg?=
 =?us-ascii?Q?D1Uj/jB4hK1qMR5YrOTgUY+nF/4mSoefqYBgu5RXrGJgQSWbMh4pKAVov3HZ?=
 =?us-ascii?Q?AQPd2y3Na7NWu7OCDYTgt7K6Qu+nWwhj0Ka3KBkshEWvU7y8soXg0d+B3/30?=
 =?us-ascii?Q?XcNYpiBz7y+ZeZekTy0rG0SCMH0iFQ1qAaeBQsRZID6jIC5CSdUmhJwtGvjb?=
 =?us-ascii?Q?5DnmPBAiBn8t/JzMiOb6ZUneiOFleWu+BTjgpa1Hsu9equMegdPyNGgJX/aC?=
 =?us-ascii?Q?uWFZyUZINTcxmaYZ6WYSdIN86QuOZA60NIZ6gDjlozMh6mRzDCHsKMT+pp+q?=
 =?us-ascii?Q?BZa+ZyCXOpjahpMs9dPqDDdaaTVGB4Yxc6Jr9HG2B7mjAHOzyY5lU1zZRAoo?=
 =?us-ascii?Q?pqCjctCm3aSN8xMXP3O/sQAfBgXAJfhbyk6AtHvZXHQYMTkStlWG3u6hk6QO?=
 =?us-ascii?Q?lErp98OjrY0avDGQYmQMBhis/Uebk9IfR2BeXbaxz7XQMh1Jj+ZSjIiq7b6V?=
 =?us-ascii?Q?kQ4+NywN/nxUiPBK/Yk1xi8U6yNj+eHuOJ7R74YocHZo/XzrmJFDYGRUwGHw?=
 =?us-ascii?Q?B1C1hiDykVLo3Mi0eaQLuoPwejDUTQPC1yn0UH7PV4Q4VKJ2wk4pEcj1Zd8q?=
 =?us-ascii?Q?dMsmZ7it+b4tXa+toLJIeo8aS8k5XDo70/ZOMbCqeS7NzFR73Up2yHQJGFLB?=
 =?us-ascii?Q?40aygXzpgkJm0A82uex+P03ylSSWTzUHNEfQxDKhIl0NNTibIOpGKDsPG5Le?=
 =?us-ascii?Q?eI1THMHQI/yALg/I/NJZKIQp3NVb+aCIoX1QiXynuMHjY/dyTX84LNNx22io?=
 =?us-ascii?Q?PmnyKFOt1kzRm5FFxhq/6e9ClTILCS5/flwEGEtEvePmZMBYH8GLl2CLwwrp?=
 =?us-ascii?Q?pvfNQkA8052q31tZWfftgle+h5kLgsj73VAOtGwH03GdJTYi9VbXqCrKV2ez?=
 =?us-ascii?Q?KUrb3SegtazrpkaLWDoX0FMKDBiZLQ9Dk7n6q68L3QCo7j7XzV4/NmImQSQS?=
 =?us-ascii?Q?Rh+DE7r9u7maciP9U9PGp0uILKwXEyg00VHTluB64DMM6k0WYHCXofJUgJh2?=
 =?us-ascii?Q?ewYO6EFFMyZuiCYYNYiBoP++WxJK+rArs5IV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:27.8603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c01be7-d030-4e1f-60e4-08ddd0d94d4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067
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
index a2149afa5803..ec9bc359d5be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -165,8 +165,13 @@ static int kfd_release(struct inode *inode, struct file *filep)
 {
 	struct kfd_process *process = filep->private_data;
 
-	if (process)
-		kfd_unref_process(process);
+	if (!process)
+		return 0;
+
+	if (!process->primary)
+		kfd_process_notifier_release_internal(process);
+
+	kfd_unref_process(process);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index bf4a8972e3bf..de701d72aa5c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1082,6 +1082,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported);
 
 int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
 			  struct vm_area_struct *vma);
+void kfd_process_notifier_release_internal(struct kfd_process *p);
 
 /* KFD process API for creating and translating handles */
 int kfd_process_device_create_obj_handle(struct kfd_process_device *pdd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d8535cd47850..440fde75d1e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1233,10 +1233,30 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
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
 
@@ -1270,7 +1290,8 @@ static void kfd_process_notifier_release_internal(struct kfd_process *p)
 		srcu_read_unlock(&kfd_processes_srcu, idx);
 	}
 
-	mmu_notifier_put(&p->mmu_notifier);
+	if (p->primary)
+		mmu_notifier_put(&p->mmu_notifier);
 }
 
 static void kfd_process_notifier_release(struct mmu_notifier *mn,
@@ -1286,22 +1307,6 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
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
2.47.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82114C83F26
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 02:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2733110E408;
	Fri, 25 Jul 2025 02:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IM1JLNB3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60BD10E408
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vog4YX8BhwjMURZQgRhFvdT2qTSzz0MZCaI2CWBhGodJO0El6BLEHJXG8vKdNN94TSC3aykTTWQc338B8ig1Bb3GK3iouIqpRTOKeHPJMftk92Frl9xanwKajiSF3GWbezvnDPHLmXT10tBchDLiqPIiBBYWxR9mttaAhzV/t2KpM5hdcPPGsMFXFzBZOVfk5QbxPRBmxKivgHlx0HWowa8f6c397zGsGn2AlnxaikKsWYJFq4gF/bpoKBS1/x/fIc3eBbvBL2fPVGXr3cEOnKI4wXH3i/HQYfIxktIfbaPdPGl+Oat2H2Z/F1C793A0I/d8x961MtfE+2Y4WiZ95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaglUIcgKVFa+twzfu+dSwcC7VoncM50RcVqTzNNocQ=;
 b=Z+9XFVTxwbZ1OSyI0gykPt/ELQxfpN1hK4Bk7STEQKZyTYq3hcLFTHScP/aXd3d+Kl1/MAQiiNn/8wSJUOYGJDWhEHAp3VqX1XZJPnDankx3+HQCJQEgP/yGJ5NK4bWaW45d8xPGetnzVRhxdng4JdJpMtihhbr2nV6VDV7IND+aA0ZjLYJr+fFNQJUy9h5h6qD+pgY1RDCBr5jiauIIbGuo6G3Dzp6c0nYbMCnUcfbqrWcgBaYcXf9y/YpWVGV/nW0qitdFDX8tKaaEWiaG+EafzrtdLIWHDxNipSk1uD+kACP2YWZkZfSMm1qlnEcslp3NrYDsJNbg9FuLDYsX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaglUIcgKVFa+twzfu+dSwcC7VoncM50RcVqTzNNocQ=;
 b=IM1JLNB3ao45+iKzBSAVFTWKtIhEpjFVjt1FEF4oV50mud7qplnpZu3b2M1OZPPT/Y+SQ2dlWTvPFiN7SH/vnPsCEu4Z3Cw4zng5Ppue3ZGSdmU91Pwh9DfjJ4fBYDokS4A9yFHmYKlldrcaSyw82Hbyun8TIDSsg5hlVUjescM=
Received: from CH0PR03CA0093.namprd03.prod.outlook.com (2603:10b6:610:cd::8)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 02:43:40 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::1d) by CH0PR03CA0093.outlook.office365.com
 (2603:10b6:610:cd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 02:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 02:43:39 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 21:43:37 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 5/9] amdkfd: destroy kfd secondary contexts through fd close
Date: Fri, 25 Jul 2025 10:43:12 +0800
Message-ID: <20250725024316.9273-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250725024316.9273-1-lingshan.zhu@amd.com>
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 13382ca5-d8b6-4d34-caad-08ddcb251006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PYnha/y4miJrP4OvXBQOdQfxJb+RNlNJRFd8cYL0FEKoQJPP1RFCYey2gX3z?=
 =?us-ascii?Q?YGBZ0uaNXrnHMZJ+JK0WFCFDiQ0NEbKg9LytmpDROs94yzaNcIDP0MibzvBZ?=
 =?us-ascii?Q?hNxwHTXygFrq/fB4iZ7BL2CZCN2+BVG+1y9QhoCM3O1J6k1JfIfdfHQ2I0KD?=
 =?us-ascii?Q?UbTPZVIiLSaQliULZJkPgjHj29hBv71RcDGRh4nacxpY0HjBDO76vg4Q2aHx?=
 =?us-ascii?Q?GfwRkSo0DhUVZ/VeqKSIA6K47pxYkk3BGjaeUoE50CdsLsuwJylA041YBSLu?=
 =?us-ascii?Q?AkQtuwdOgNGnJxOPOFbC94X+NJfLkUcig50b6b9ROf8uBiwH6SvGOFwWIrpA?=
 =?us-ascii?Q?fS/ANc/tzzLMY/69dk/iuM9teLsq94CJiio6A49Ca4T2xB/Os8FCuMYevU9W?=
 =?us-ascii?Q?p85vWNCRLgGEQPfzk+hrQv4cYbUCmgMBwF0IfhzUa4ENACDCGBDtrYpuk9AF?=
 =?us-ascii?Q?KfM2vSrO4sOljieidXbuorZlV/gjjRocv3phZbO82QLBzTjgS9kSyVPgTzGx?=
 =?us-ascii?Q?X4NM5vSCgNX0TI3R3Py3iqGQta7OI6COyw/ae4xDms5wA7/dobJgqh8dufuR?=
 =?us-ascii?Q?JE46eYuwIYsryWtznLEqtt/md/2Loq+r9Ae02Zi2U2kaFf0iHpfZQrVgAtMg?=
 =?us-ascii?Q?NW+7iUNVGdo7tHsoCnuS0JN260416quHcfejDOyf25YWXLfYXG2EiECW9cOh?=
 =?us-ascii?Q?s0BHfHXJ6Iq4BjZ2C7HeRdXYdkHlAf9igyKVLCzj9fCqJpcbKkKcaoxDbJdq?=
 =?us-ascii?Q?z/BDS2PX1ASMPmhUoAokBLoN3r3XqlrCbuiBtjZ+t8bJDWLNUnS1SykDfTHm?=
 =?us-ascii?Q?2aUtMAUadccwcN96NvqKOilm0cDMeI5dEy4HQc5jdMXkr9Bq6TtQe1ilV/eJ?=
 =?us-ascii?Q?h3JqwM/f08YhmPgKWw4FL533e5rJ4eGqI7AsW5aame6WY9U5jl5WV1fXxDKo?=
 =?us-ascii?Q?0o4wsEp5JLtU/VO2cDRVtrXVEUJtwZZvNpVrodg2NT1kMXqwoe1ceqhlWNXG?=
 =?us-ascii?Q?zcb4QloS4VO3V6VHYKxdWeyo0ynVOM1zkrYiKT4O2yGVrjymmSanqVw0qiFP?=
 =?us-ascii?Q?qZw3rnuSo6H8iwFwK420H6Ms++wdLSdBDL3rLOCDo2aX47haGMq9pewIIMqK?=
 =?us-ascii?Q?uCIjivzeikx8J7CI875DQeeGj4PcYqT8iGktgS2Os+weOuJYS9MCE6EXTehp?=
 =?us-ascii?Q?ZvUxWsRqqoccsttFzsUIgZxuJvyX30B5cv/QC/xCX5DdFE5gY0vEkNT3v5Jd?=
 =?us-ascii?Q?LLpjxDHMsAWoWl3EjAFFjdK7xE7guFuuXTM7e1ueqMsL2vAJ1UgMofd0g7ZF?=
 =?us-ascii?Q?8N0o56kqsNru/Hi3HF88IxEijxhMHU0zbgFVk2z/aDkpIIK/TiiSsfFLftWZ?=
 =?us-ascii?Q?ocx8IfYdJsjfZ1pZk7RIVciVhxgs7AFFgpPSzdK6Ii3WR4x36EQLwk6zb8u+?=
 =?us-ascii?Q?TYJtEFQlNd9kHp0gPaHWbjPNQwrBls5SN9C5hmpsNa262m5rDwt0n6ujqsxS?=
 =?us-ascii?Q?UttQF1hGk9ZSnZgUI1DXPboq8q9ciDjlda1n?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:43:39.9040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13382ca5-d8b6-4d34-caad-08ddcb251006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
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


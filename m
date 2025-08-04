Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CFAC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E1610E43B;
	Mon,  4 Aug 2025 11:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O/+cRT/X";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF1910E43B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyVNn6xhah6YqXmsnB/NH0IXcFKSoHHB5uVSp8+e2OcRl76dsQo2BiuLMZrnh8663JkJsynZEt9Zwq1IhmGxYnsJ5gMA/VRu1TCIRLYrF8pRj+kwq0l00g61CXSeh9SzLDJ/q2FooAhxL+kKf8GpBwPoUW0ovgrokHL1U0zJWkzGpZ61XXCAp9btxALhqQcrofFTvePiMG2ZGbxryorh0lafy0CBbjWWchKAVrmDFB5byPG+aJ4ihiumPrmtoksjkR7tVH+l30vG8qPzVkODzp3M0/vtiloGeBHSsL5Ew60fNTrUweNvYVewbXJlz1gFKF0j2cpfPnJXNWfnkwB4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg02tWCSkfp3X3Mc9JaeJ3e/3MoTxoEzz5lXkjA2RkY=;
 b=oqQpYDxS6k9QcsE24m2/GKWqnyFYX/6eM46y9Zf/TohVYnBI1P/wXPo+5OqlzS3udkz9SASYoCMDklKKjIkIsldhLbcfoozEgmUkfRycvJ+4UmAAUYCRTbz7xkaujJmwtz69xzqy1osrrzYcLBaKwz111DSMswH4ZFIi+5ULYuOT9pngigYPEqnECHo70nkBoxEj48Lz25lYexz76hX7G8zd7ahpKIdIAtDrPBYN/EP67geBhAuEufTLdeCNn+zd2uXNAW7NEoJ+sMao8xeckFz/zNaU0UiiCp6l6a2eGMLeuVCWS/eAH/7hsfQXkdg3yEcWmO+Maq5hH1+CuPZVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg02tWCSkfp3X3Mc9JaeJ3e/3MoTxoEzz5lXkjA2RkY=;
 b=O/+cRT/XYUZVUpLofwBNfapGGsksX56k3Wvu0zJ+8wZHIjfoScG/aVDZS2G01UHS5NdaKQYyt5KD2/3Emf0Az4d6X+ILKumyPP8g5GIwz7etobMnngGtNUM1AEx0LaxqstQWUXL1nDAfarSBqL0JTjC6niktJixbh3aBlw9UKJs=
Received: from MW4PR03CA0335.namprd03.prod.outlook.com (2603:10b6:303:dc::10)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:06:37 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::ae) by MW4PR03CA0335.outlook.office365.com
 (2603:10b6:303:dc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 11:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:37 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:34 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 05/13] amdkfd: destroy kfd secondary contexts through fd
 close
Date: Mon, 4 Aug 2025 19:05:42 +0800
Message-ID: <20250804110550.261311-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b9e5d9-bf81-462d-2e30-08ddd346fb43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MxrQgj80XVFMHBpvEe7gswpwWC/cNTcfE5V0oCJFruJVQ7+tXwfA8nGP4SCg?=
 =?us-ascii?Q?Eo5jiRX9Y6FGnho5/ogawEEP5FxVQ75PFcCYnE9AU9E5DbaYKwy/gJqS26RP?=
 =?us-ascii?Q?fpE4UQC8kQFH0/CIBSXGxw9cbAi2qmH77R436Tgmmaf4B4vQzkQIGBXEL0xO?=
 =?us-ascii?Q?SWlYcYByDisz0n6Ihl55GG0Pne5k+DAk5P/8VX4Kf9HgYG5MQ7eLHQouCRsM?=
 =?us-ascii?Q?eigKDUZOLw8OAvRF2AINXi5yLo5iQzkPgcRbpODbcoxkt8eJX0/Y4V4cfvpf?=
 =?us-ascii?Q?zmcImB73eVZQe0Ei/NmZltRC+Rn1Xko/F3V2kkhrGxA+WkFkyuqbv8UU7kwY?=
 =?us-ascii?Q?mXyjsYR8+u+7wzFj/xsESO3qLe9xPaa4bvwgS6La5u4nDjhaXvUr3OxXglDm?=
 =?us-ascii?Q?9BrSD/XtCkmxrRglZ+EgFaqL6PMK50iCaid+fJ+EqK1S7wve9AjMcPKjmUp/?=
 =?us-ascii?Q?TgtOW6aeC07UcCMp40sIh3XybJSTs5QvPzp9hHhYmQWPSL1Ap5k2ok8C3E53?=
 =?us-ascii?Q?FRejhOaThxifaq2GC2oLht1oKpbLte9s852h2kYorvuncrL9pn8w9BkdGR48?=
 =?us-ascii?Q?PI8i3KmrVSz3B/pw//n9vsPnaGJnNWy83PVEdK7qPZTjQ1cBfjn0Yqrqfh3p?=
 =?us-ascii?Q?WEg0IEsDkjxHiQD24uW+TdPHSpMzaG7VHzrRLMsWCTbWP3PvJdh+GxsJBq17?=
 =?us-ascii?Q?3tCHqDeDoDzpW/JeewoqGLzjTRkQ0xi6/FD7hM+MPn68KfGf5Z3GQf0pI2EW?=
 =?us-ascii?Q?Tm+yS38vojWrjCswoCRhV+UEMIAhWu3anVhcP/RrW2RJg8uwdf2JL5j9D6HD?=
 =?us-ascii?Q?doz+xip1GRwMC7mIXteiURgy6eDgjaPnnAybj0zuMrIhtj+HQbqma9nES77Y?=
 =?us-ascii?Q?Sb3nXfvwSHa/UyEuC+N8men+TMcwp83WLfnv3uUNUeOl21TuIDbdqLgxhKvL?=
 =?us-ascii?Q?LtaS/TI45RkhaOSgumlGpMAMCyIlWp1u7f77G56JjvL9zmB09SP7RTYErJUW?=
 =?us-ascii?Q?vbaJbctr3QKI9Yd317d7/KdG+78tbMawzBAeKFgonRg0/L87KEYNl5TGKwB4?=
 =?us-ascii?Q?8yz2Un7Xur3p+GdoTcSNr1Sc7Qz38/WvjCaMlBwUmSr5ZbfyTQQpVjEJWHl3?=
 =?us-ascii?Q?vwFFdevffXnuDPyO71Diu3xmWdyQS7TgbLniAKsp903vgBPvFm2rWSxZbMpC?=
 =?us-ascii?Q?4M7aBJhG5cfbvfroBVEbwQtMAh8QJUvL6MxtybjjEg2zGEJEslzOrgrjuTEg?=
 =?us-ascii?Q?BEdIgXPQmmdwWw6B3RhjzG2QPdEoqIz4Ccbs9pmJoXRLxP1O33Un4OocOL0W?=
 =?us-ascii?Q?VWm6BtdAsuwlhwgwcnIoseWqWMxde9zRaMY9iDHB6Vms92H3znNE7Bou0N4n?=
 =?us-ascii?Q?qAaeKGRDTQ2kfji9+sgES9JITjQX55cGz45e0u7gwVVIWxn0QBKHaRfdvOas?=
 =?us-ascii?Q?gS0v8bzq9vye9HmKK87blq0bNesuJqw4/ZGlbLgVrHXVlJ3ol5yfYBpF/+7P?=
 =?us-ascii?Q?+XJ33Q/UJf+CckKbMlr2HFXjUYD+R+T4o0Ov?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:37.1788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b9e5d9-bf81-462d-2e30-08ddd346fb43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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
index 828a9ceef1e7..e8c6273de99b 100644
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
+	if (!process->primary)
+		kfd_process_notifier_release_internal(process);
+
+	kfd_unref_process(process);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 0818705820c6..d1436f1f527d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1085,6 +1085,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported);
 
 int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
 			  struct vm_area_struct *vma);
+void kfd_process_notifier_release_internal(struct kfd_process *p);
 
 /* KFD process API for creating and translating handles */
 int kfd_process_device_create_obj_handle(struct kfd_process_device *pdd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index bce7e35a15c9..5d59a4d994d5 100644
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92532C87FCC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 02:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191AE10E403;
	Fri, 25 Jul 2025 02:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KjEsmNqK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 734CB10E403
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuSwpmKvLZ+uPRKhFTJvozXjnjHW64NlDftwMGr4JtA7eMulF6dBOBXiRAEzTOhDvOVEUjQDSrCkD75xz+rPmDMh3k16ri76o2tgbaxoXzKzhvE8tfXeOS9QplJUu8TLYkcfPOvUfJlMFlpQ4HShBkuvsvybWE3GL8Eix+dBw33tEagtUy8DlBhkyuIxVZ1zKnEjg3PVFSQMPs5naTGeTXOPQE4s0HxPBoe0zXglCwfltCcVFmxnlxvb88stuCFTaGzUO2HHbSWy7cml4BldOVFA7qszQx/VaHT/UvEbDvfrN9yHwhQCaUvNUyEfMYt24QAH0JE0PJAIvF+PZslCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdVME6OApozAcqVOUvWCG5zvkUHnpDyj2nkAczqstoA=;
 b=hs6kvgI0/H5cgCriy89w3ezIgR6NZKBINkDfthIrEH82//1K3KwwYVaYso/nePHmHIeDVbquxD3D8h1FRk10OSm8qlEuP6gM/e2eKEO6YExvgPrv/hKCxWllgutAx3FUwPbI3IoPQ23CLbbDBQzbmZpOl8KQX/UK7PJwcgUEsY9Ukj4sW420VV9G0Czhsmz3tFG+NtPWhuRnC0vhDWp/YaZ0C1T9UoMy3l6beI7NPMqJ0J0s2PhOdhVclIfZbs38q2UaN7EoFE6eePMlOVHz0OLijEqyacOFMOXw+NjbbJsIVlHO29XUHnSKEiUDPvWviNHSr6LQRkMGn+YkJp1tUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdVME6OApozAcqVOUvWCG5zvkUHnpDyj2nkAczqstoA=;
 b=KjEsmNqKCjiLmzPqYszPCGosLbDf0u9UPbkD3rRAjYAF8Sw7X8yEve6cwM/V7UeDo6CK3LhX6xVyz9r83Wiv63R8ys/oV56K+YpMWWvEBkvbgRjqQiw8iN4Wwdlz6CVeGfJB52dXNfr3dzepGgl2QQz8b/6FBRzQTnj6E5Y3F/I=
Received: from CH0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:610:cd::11)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 02:43:34 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::20) by CH0PR03CA0096.outlook.office365.com
 (2603:10b6:610:cd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 02:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 02:43:34 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 21:43:32 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 2/9] amdkfd: mark the first kfd_process as the primary one
Date: Fri, 25 Jul 2025 10:43:09 +0800
Message-ID: <20250725024316.9273-3-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2c1038-77a9-433a-816d-08ddcb250cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?44MEHr05fIz3qp3ntLPDviCMJ8Hd87w7MZExFcBxnJ+IvA8KyDKAIfX74k4g?=
 =?us-ascii?Q?dbAI54E0ut8rfLuNPJAlbephtn7hiTrbIWA1L3cO1N94mTUqWs2oxRp7qmXU?=
 =?us-ascii?Q?Vkq5ZI/os5bgbRqbgRz0hz8gTMWQqu6T15ivvlJo8LM3oXHZTsT4AUdK9VNF?=
 =?us-ascii?Q?AKSDOrzQBp/qNCx9U5LFG/JEsZfTFq8fpmFSm5OcVGEtF58D2C3hqp/E7qFE?=
 =?us-ascii?Q?kffvSYYmq/3gCbeBMKVIDDb8encXZ/S93e8RsEWFqGLiVKlMfigqArft94wt?=
 =?us-ascii?Q?rmD9Lml6MJZC1VyE9K5H5TwmB2kWAwUucP4rwtLpF+LuQs2wmBtwKnT4UTd2?=
 =?us-ascii?Q?XqPtDQ/YINQusWHq8jQDHXjNykCJIdYVr4+eLWL0dyKgwWdTg22WJJZD3gDx?=
 =?us-ascii?Q?iaY7+hquf9Zzfpo4XAT1FGbFBRNRrWPRwntHgCx/EndmmnNDQekU9oyuDQ4C?=
 =?us-ascii?Q?it2Nf7pmg7gWtOqZ7OdpC4umOUjr72Wy67CbXxwKwdVM10ZfLhvDlAs8E2T3?=
 =?us-ascii?Q?uVnLg8rb7j405J1LdvzxxLmYmUJBiRyDng1Ot/pS4h43OjFRHrDxA437h7Mj?=
 =?us-ascii?Q?EsvRXC6hQYzzdOik/Q8s3Y2yVwqdd5bpbPLXDlL650X7r56BvoZJ2amQApx3?=
 =?us-ascii?Q?qZT4gK+t4VqHsaTk4I9fuSlQ/Q/O7xZz+pGx1pLkgflaJ9SMpida9eVf/BMv?=
 =?us-ascii?Q?I1JeOFx7+4ba6VLh4u77671Fhp0PLsCQm6viYW0VAgEzL1OuJcuxMV3fJ2Re?=
 =?us-ascii?Q?kCS5M2zY4XOblMM0OkwRSKy9iT2z6AyjheAujLLEc+Kk1g+NjozMlUS7hPwu?=
 =?us-ascii?Q?j3IoXm5im3+jUD04i9zuaVn6ldaL0gkibaWuq3wfd3vZUrDOhVYCGEQ2h+5C?=
 =?us-ascii?Q?4O88osH+wjlJ+2NQEnMTd/IV3x+PB0pB9rVWS1pux9kvugoogGXrcnudyztR?=
 =?us-ascii?Q?YQg7JOHFGiFE/k4C1mcWTjZ/Ua6FYF2ONyqONmUBZMZnCirmOLGFWQ/Ya71P?=
 =?us-ascii?Q?tlFHCRuzMn88vbLMXg0c0/Rs9Svw4pp32+Uf6w/KgpTD9lhWi1EfNlpGlNPI?=
 =?us-ascii?Q?J/WWgyM078Y1356W5bhHuAgUEO6xNKuPNSsCn81j5bbIql+Lc5zVAxK79Jke?=
 =?us-ascii?Q?GTs6HTeThZTxUIzrdv6kdhncIyoARcOJ1XWievypa7j50ujc6rzbTT0VYQKS?=
 =?us-ascii?Q?umpGJE+9UfXM8jMOqAIMSq6/FMct5JyLEeFaTUOuupp3eJDY2aV95b/LRmfU?=
 =?us-ascii?Q?YhGt8oR39oUDgnlrDMf3SI50cX8ykGlIbeqFefhJK0j6kGZL7voizKSDlXiZ?=
 =?us-ascii?Q?sjSwmpq8KtCNpU3pzJRNMxk8rf5fyykoaO1v1cw0Wvvp5rZHtWxWmt83uTPb?=
 =?us-ascii?Q?XAeARqVVO4y2cKNGk9JVisrLMBrT85XlC9cPU3ptHYfOpLvVwgwSl65MJZ1s?=
 =?us-ascii?Q?67DUcXTmNTbhUMIYFgL0sCsfxNvgXJaTtJxMX0OxvKjUzDZ+pdAkKhhvI5pt?=
 =?us-ascii?Q?oDTHT1/5bTTd4G8Hq2ZTJ1jxZ7in1wGe8i4f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:43:34.3782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2c1038-77a9-433a-816d-08ddcb250cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
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

The first kfd_process is created through open(),
this commit marks it as the primary kfd_process.

Only the primary process should register the mmu_notifier.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 20 ++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 38a20ba61e24..8149ce0639c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1006,6 +1006,9 @@ struct kfd_process {
 
 	/* if gpu page fault sent to KFD */
 	bool gpu_page_fault;
+
+	/* indicating whether this is a primary kfd_process */
+	bool primary;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 722ac1662bdc..955ca8725bc5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -68,7 +68,7 @@ static struct workqueue_struct *kfd_restore_wq;
 static struct kfd_process *find_process(const struct task_struct *thread,
 					bool ref);
 static void kfd_process_ref_release(struct kref *ref);
-static struct kfd_process *create_process(const struct task_struct *thread);
+static struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 
 static void evict_process_worker(struct work_struct *work);
 static void restore_process_worker(struct work_struct *work);
@@ -867,7 +867,7 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
-		process = create_process(thread);
+		process = create_process(thread, true);
 		if (IS_ERR(process))
 			goto out;
 
@@ -1510,7 +1510,7 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
  */
-static struct kfd_process *create_process(const struct task_struct *thread)
+static struct kfd_process *create_process(const struct task_struct *thread, bool primary)
 {
 	struct kfd_process *process;
 	struct mmu_notifier *mn;
@@ -1526,6 +1526,8 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	process->lead_thread = thread->group_leader;
 	process->n_pdds = 0;
 	process->queues_paused = false;
+	process->primary = primary;
+
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
@@ -1569,12 +1571,14 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	 * After this point, mmu_notifier_put will trigger the cleanup by
 	 * dropping the last process reference in the free_notifier.
 	 */
-	mn = mmu_notifier_get(&kfd_process_mmu_notifier_ops, process->mm);
-	if (IS_ERR(mn)) {
-		err = PTR_ERR(mn);
-		goto err_register_notifier;
+	if (primary) {
+		mn = mmu_notifier_get(&kfd_process_mmu_notifier_ops, process->mm);
+		if (IS_ERR(mn)) {
+			err = PTR_ERR(mn);
+			goto err_register_notifier;
+		}
+		BUG_ON(mn != &process->mmu_notifier);
 	}
-	BUG_ON(mn != &process->mmu_notifier);
 
 	kfd_unref_process(process);
 	get_task_struct(process->lead_thread);
-- 
2.47.1


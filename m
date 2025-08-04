Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B9EC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4C910E43E;
	Mon,  4 Aug 2025 11:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nxD2GF99";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7349F10E43C
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkhC636FdLyapCLEjbb536IJ/gWv81k7L6MOE/l2BoxR66uIkqaVgk/04XQ91TkXwlE3Sg2Qixz6CfDlOYMy/Gorr8mCwvAJJblMesgAjMDtVQ4/Mo7mMYfr6RBA1oGK7MEOmRTrZM/G/OxAYDk2ExIDi6aEYOBMguO4Th0Y/aYgGhST7eqfRoVMDhoSTH7m/+KB+HFjeeL6F8uRriwVjSQ3OeiRs1rxb1lDwA49Dq1xZF1tokb3SgqUySu+Tyx9TIrCs2uQJ0QoKPH6I5ZZ3a3c25hFWuMOxJnqiGb/yXq2BrslxxgniQHYlDZ7cr6ROAgn+t7B4t9nHU2d8D9XmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RseaeAtf99dQCAxa70jMuoECCHTelgy6qdtVoEJUW4=;
 b=BbfwozAvH7Rh7nI4j3a0BobP6eQ1QIqupya5IVCnCUTmKe+75ogUY5swU8jRLjPaMCBYsnw4t0MDX9urSZJT5hErpWuQSeTgeKEYPOoQIBQwH1jkQw+Pq+ac3rZV45ryXDaSE6j+U9y16BedHWK0cej4BQq1N4K6wBxJgrc/HtQiCXbV11e44DA5OeI4Y5o7cZS0FwJllvokLPIisqGdsEGU0+rvXQ47l7LDmmHajQ/TnwUxNLn03Y1C3j1e8oRIzEcI2ZfHLnDD3x888AmQZZkB2We2+tfLEPRKsAkSiev6D4ySl6Iq7jq7sHKzzDddF8CrcMVHXo0/QbA+YchJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RseaeAtf99dQCAxa70jMuoECCHTelgy6qdtVoEJUW4=;
 b=nxD2GF99HeVZdfd4AB+qNJJr4YIcmXJqpynxXOFkmsJHgww8rQV1cajyEeiL3s7Ahm1AbjVuazz6Eee0GAE1WF69Ul3WjwaVu8HqGYPik8VyjzXqx5Ndb+Ao18MLw1PNPY1t/4TaYPgbQmpZ76IBBoWDfeEwuSFrYNTGS2O3xEA=
Received: from SJ0PR05CA0076.namprd05.prod.outlook.com (2603:10b6:a03:332::21)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:06:42 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::1e) by SJ0PR05CA0076.outlook.office365.com
 (2603:10b6:a03:332::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.12 via Frontend Transport; Mon,
 4 Aug 2025 11:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:42 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:40 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 08/13] amdkfd: identify a secondary kfd process by its id
Date: Mon, 4 Aug 2025 19:05:45 +0800
Message-ID: <20250804110550.261311-9-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d92d76-dbaf-47f8-4e3b-08ddd346fe35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K89EwzlUJYL3A8kC4FRQ4TjUOXwaRqvtw/CxzbFaoNWhj7H40cRZQbgmAOBR?=
 =?us-ascii?Q?4W/YMO1dO/PpmSTz73kPC8pX4P2Y4x8A2c2AXU1Hf60py1XElisWLq397nN8?=
 =?us-ascii?Q?+1ZYjVvYaOZs2TjAaJseEMisNdQfW00q9QnLLBLPIMjI++wsmHxcyQ8eCjvS?=
 =?us-ascii?Q?Avr2L+03Vl0EhSMET4OOxSILYfcBX5ejS5H0/UHbxpzTCdMesE4G8kCv0785?=
 =?us-ascii?Q?uCd3GtV1mszmIq24aK9Ce5f51Dgd0OP/gAM+Yh4Zu9QcpAO2fGUiLa12QsWo?=
 =?us-ascii?Q?bJoczfeMH9De8+oYVSp7eoBl2CX+AinTPTGPNQ63+KQcQRKbdry0VeP3E/15?=
 =?us-ascii?Q?NgCpMuHI/jg/nM4eFD5oeyqiZotBzvzajiHxNAw9JJfIcc+l4L3a0AHsbfHb?=
 =?us-ascii?Q?7+H25i1XfsapKi30iYwQjXaElUbvj2eM/Zyv/6rl63D5ZezI0Cod3tGl10EN?=
 =?us-ascii?Q?M1emcNEN5LCRB+hmSE+uSrSrTU14NV0/MMvtAnAhPP1Y/U6S9BKqBBLSObPW?=
 =?us-ascii?Q?E/ovCDBOkOLXWK/3qVKevArMd8rnI5/+UAiss0XBl402vP7Xj9g8Y4nds6Bg?=
 =?us-ascii?Q?mTV+CdfuWckWo203iznLb4ZAB6gTCBvKLO3evkcffNyaRe3XNGXX02rPc8Mo?=
 =?us-ascii?Q?HS/Xf2UF8pdGDz1IxZQy3fjk0MaIQ9Iv6e813vgtJ3H/M5E0dFi5a6fMdvor?=
 =?us-ascii?Q?dPGw+Xf5ULE5p2ICw2Nyb5pJDYD7TD875ZuOM/8l3i3KBzg+151EzcJ8BhAs?=
 =?us-ascii?Q?du4VFF3A+Bxf55sifX94aC2N5U3AvSE89sSX5RFJXlmH+cWxCuVyXrW9+Ujn?=
 =?us-ascii?Q?F0Ru1TOiZRjJCTWGy0qghzwyW5REtq/3ZSPp8HbHbDeO7UwGwFRMjCsDDWuy?=
 =?us-ascii?Q?daC05FVOmO8pN1P9Uc6VrD41Ao1EaBt6rKGIHljGJRHvTEX7DHdz1BEAY48t?=
 =?us-ascii?Q?AqoYli/xy1JbFmmeQEZk7p25WO/HpCxnj6pNXp61+hOlPVhVDGaCBDM2TdDL?=
 =?us-ascii?Q?s5Iv+9QzO6AYs3Pvf77AoHHPHHGZjakCHFCEWcoWglQI/e5UrLdL0J3hO+jJ?=
 =?us-ascii?Q?/2vMpdtPwn34G5LP05AJkU89cS4wswJrzP8hPVVwMFhAffJ7DHat4qF/6QMK?=
 =?us-ascii?Q?Ur+fxDV3IPAtB7rDNrPkAOf/hmyJ80AeXV9qWCskLAR0Dz4FXNKFFo8+g7A9?=
 =?us-ascii?Q?OdyVxQRXvCvZ/qEB/NasJpJDtkk204DBD5q7Kmev5Y/3Ilg9nI1XtSJX4BTm?=
 =?us-ascii?Q?wdtDtLS6zJq5Io2UYZcPHOcQqwI7KbDUQ5kwGUMqgBlHgwaquTRUmAGzgzlq?=
 =?us-ascii?Q?QJAf1fniqrlu3jMKKJ/5CTTqkNPhwOfaNgWfRIHuotwBH8B7aXxKR4UZhbvy?=
 =?us-ascii?Q?fb9DijbGpQpPg9OCQh6jM2GMun72kxbO9JXxH1u80Tj9T54WonwhcR8iPi/7?=
 =?us-ascii?Q?fJANo4admmYDilLckA3FVVPGANW/+01Ol1V7cEW7pbegNB5NSGmKLNZ9YVWT?=
 =?us-ascii?Q?dhCgyXEHeO9p5H/G+BR5G/OZ5CPgn5UMzq3T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:42.1225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d92d76-dbaf-47f8-4e3b-08ddd346fe35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

This commit introduces a new id field for
struct kfd process, which helps identify
a kfd process among multiple contexts that
all belong to a single user space program.

The sysfs entry of a secondary kfd process
is placed under the sysfs entry folder of
its primary kfd process.

The naming format of the sysfs entry of a secondary
kfd process is "context_%u" where %u is the process id.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 83 +++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d1436f1f527d..d140463e221b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -998,6 +998,9 @@ struct kfd_process {
 	/* Tracks debug per-vmid request for debug flags */
 	u32 dbg_flags;
 
+	/* kfd process id */
+	u16 id;
+
 	atomic_t poison;
 	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
 	bool queues_paused;
@@ -1012,6 +1015,9 @@ struct kfd_process {
 
 	/* indicating whether this is a primary kfd_process */
 	bool primary;
+
+	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
+	struct ida id_table;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5d59a4d994d5..8e498fd35b8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
 
 DEFINE_SRCU(kfd_processes_srcu);
 
+#define KFD_PROCESS_ID_MIN 1
+#define KFD_PROCESS_ID_WIDTH 16
+
 /* For process termination handling */
 static struct workqueue_struct *kfd_process_wq;
 
@@ -827,6 +830,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 
 int kfd_create_process_sysfs(struct kfd_process *process)
 {
+	struct kfd_process *primary_process;
 	int ret;
 
 	if (process->kobj) {
@@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 		pr_warn("Creating procfs kobject failed");
 		return -ENOMEM;
 	}
-	ret = kobject_init_and_add(process->kobj, &procfs_type,
-				   procfs.kobj, "%d",
-				   (int)process->lead_thread->pid);
+
+	if (process->primary)
+		ret = kobject_init_and_add(process->kobj, &procfs_type,
+					   procfs.kobj, "%d",
+					   (int)process->lead_thread->pid);
+	else {
+		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+		if (!primary_process)
+			return -ESRCH;
+
+		ret = kobject_init_and_add(process->kobj, &procfs_type,
+					   primary_process->kobj, "context_%u",
+					   process->id);
+		kfd_unref_process(primary_process);
+	}
+
 	if (ret) {
 		pr_warn("Creating procfs pid directory failed");
 		kobject_put(process->kobj);
@@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 	return 0;
 }
 
+static int kfd_process_alloc_id(struct kfd_process *process)
+{
+	int ret;
+	struct kfd_process *primary_process;
+
+	if (process->primary) {
+		process->id = 0;
+
+		return 0;
+	}
+
+	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+	if (!primary_process)
+		return -ESRCH;
+
+	ret = ida_alloc_range(&primary_process->id_table, KFD_PROCESS_ID_MIN,
+	     (1 << KFD_PROCESS_ID_WIDTH) - 1, GFP_KERNEL);
+	if (ret < 0)
+		goto out;
+
+	process->id = ret;
+	ret = 0;
+
+out:
+	kfd_unref_process(primary_process);
+
+	return ret;
+}
+
+static void kfd_process_free_id(struct kfd_process *process)
+{
+	struct kfd_process *primary_process;
+
+	if (process->primary)
+		return;
+
+	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+	if (!primary_process)
+		return;
+
+	ida_free(&primary_process->id_table, process->id);
+
+	kfd_unref_process(primary_process);
+}
+
 struct kfd_process *kfd_create_process(struct task_struct *thread)
 {
 	struct kfd_process *process;
@@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 	if (ef)
 		dma_fence_signal(ef);
 
+	if (!p->primary)
+		kfd_process_free_id(p);
+	else
+		ida_destroy(&p->id_table);
+
 	kfd_process_remove_sysfs(p);
 	kfd_debugfs_remove_process(p);
 
@@ -1549,6 +1616,12 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 	process->queues_paused = false;
 	process->primary = primary;
 
+	err = kfd_process_alloc_id(process);
+	if (err) {
+		pr_err("Creating kfd process: failed to alloc an id\n");
+		goto err_alloc_id;
+	}
+
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
@@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 			goto err_register_notifier;
 		}
 		BUG_ON(mn != &process->mmu_notifier);
+
+		ida_init(&process->id_table);
 	}
 
 	kfd_unref_process(process);
@@ -1619,6 +1694,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 err_process_pqm_init:
 	kfd_event_free_process(process);
 err_event_init:
+	kfd_process_free_id(process);
+err_alloc_id:
 	mutex_destroy(&process->mutex);
 	kfree(process);
 err_alloc_process:
-- 
2.47.1


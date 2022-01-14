Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E92C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C840D10E207;
	Fri, 14 Jan 2022 20:33:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCE910E207
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCSogdLO1R20k2jHVZD9TfyG9RqjysCPYFTZh0G21G7bxBjjflEdnQoqEbrF8bEiiaBVMYSp/GmZHYFI19JwP6kOBjU4MXjDxCbvsRSooexcmNM9Jt96xXd1pp6e9m//Z7fUxHR+pRRd2p2KZjXQ9awrcZfZuRBVqYMxxJBlMpUvBnqr1t2eU7ipvBKvtUeqE1BnlRIMTvuqZtAt39uW/nM98k4y3ErB6hsgZGmEghstahNxB6N+uPnlyTXPQARXufktgGpO8AEFKqlfisRj/Ej9YjXw+YFn8335Uq8b8/HTT4oeVPzmE3CnASH6qXTDOLN4qMofEnYpg7V/52AD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFU4SKcG0ONj9N+vju8i9lkhO6yAPwxpvSZWHlv/YJ0=;
 b=Rt62okwaey0T9B4z6zp0/Ouh4GnfuRDVpOmHzFsKy+8Wfi8D+UQy7KXz8iYBpU29aRjggBTh7/mGwA0dMrU/3oKhaQEnIuPuUCnhONxdKLnlY9sURI6UeDfrPfLvbIt3KYEVqO8y7JBGKzk7NeNGeVYze4UvBKMIaDU4CznhD6RLvO9CVaCGHHM9jJPrCe8QLAIdvQNZrAwVAAsdfbkfsOt5ZebLv2AdC9OdBT1eWyrQmwDvMD02jsfAfBU1iOAKvtzcwcpfFmAgiO+lw8CLnaUgqIYmAIhrlSAuz4FldtXewxM1sVFzQTD3bJbXdN4Z3OoXjH1WYCAg64tCEns80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFU4SKcG0ONj9N+vju8i9lkhO6yAPwxpvSZWHlv/YJ0=;
 b=XmSsC51mD4Hu6ROYZSgNHyCK0GgbjMKoTvC4EFTalaqEbPquF5idNchHNAHl8UdespCZriq9lGPlRTtCFGBNcKPHYiQCy/TS7CEREeglEWz9WAzy+q5bBUzxze32s6kbr1Q2Fspa2C97mIgeZ0l+DLbt05r79qYcl/vq4fIoV3c=
Received: from BN9PR03CA0852.namprd03.prod.outlook.com (2603:10b6:408:13d::17)
 by BN8PR12MB4771.namprd12.prod.outlook.com (2603:10b6:408:a5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 20:33:22 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::a7) by BN9PR03CA0852.outlook.office365.com
 (2603:10b6:408:13d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 20:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 20:33:22 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 14:33:14 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdkfd: enable per process SMI event
Date: Fri, 14 Jan 2022 15:32:54 -0500
Message-ID: <20220114203256.19821-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220114203256.19821-1-Philip.Yang@amd.com>
References: <20220114203256.19821-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc33c038-875e-4379-d5ad-08d9d79d1bf4
X-MS-TrafficTypeDiagnostic: BN8PR12MB4771:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4771D16ACC699B5CA220C1CBE6549@BN8PR12MB4771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBRZZmIqro0/1LhxDAeorKceWkhd2+0uNQ9ysHg7v1dbLYnI0PPUGFMyc3kl1ajwNmhBCsv80iWb6vYvx7nUZN2zP+mUDDQbItxBW68L8qYUEyCEziG+lcSmjslviaRulp/ztqSq2UILvqU1jQ1jeF+1xP2/MprcZ1/OHMv9QlyJLCmY4GHCONYLieccGbzha8lBSWHVANqWeW6wc+g/1Gq3nb9REPw3/98/7YhPairN7PFcrdWhHPXjceYWqbJk5Ej/mpV7pkzxleBN1NoiKNE0xqv7EXFFjCsEsRewxxKEa64BBQ9U24UH84DXXjLxV/AScQsbHLIFEqgdPlN+H215Bg1+0cGaIa3k8Gu+eNl2zdAzorJvXzH6oI2EHvEaKlqIplMF8sF12gj6WRQEGLfXQx3v64+b08fMYN/GvFfHGwWgGCJlvwMoDC+VyzfxXHoQLhNjkV4trsOIhzFx9PwQsu0Pub2AeXxHcIYRR1CGpGPB59xDGGnG76E6lMTxQxlyXIntSNoOut4kqgGidNbAl2SCfdc2lxF4UitWk4FEkn2r/7mSwriqLZ8CsD79tRfcei8WBiu1pI9TyGHGN2OdxIveInQlPNqapmYmpjMoZWuzaKOsLJLpE3ImG0Ff6oYfrEbSPpQTJuZ9kbqpxhzFtJ7PYGAGTXn3KNVQEd4FGO35kTNqyHP0615s5I3cb2t1Fjqi1Xm0wzjHQMJqNFM8+icgL744mqTShl+du3D6DtzCZj0CVgVf1DGptoJSgdkKb92xrcGAycTff4NZycR9Be6QgUuZo5xlFhXjj2Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(83380400001)(8936002)(6666004)(1076003)(40460700001)(47076005)(82310400004)(7696005)(8676002)(5660300002)(2616005)(86362001)(6916009)(70206006)(426003)(26005)(16526019)(336012)(2906002)(186003)(36860700001)(508600001)(70586007)(54906003)(81166007)(4326008)(356005)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:33:22.7878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc33c038-875e-4379-d5ad-08d9d79d1bf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4771
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Process receive event log from same process by default. Add a flag to
be able to receive event log from all processes, this requires super
user permission.

Event log with pid 0 send to all processes.

Define new event log id, migration trigger, user queue eviction
trigger, those new event log will be added in following patches.

Update kfd_ioctl.h version.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 28 +++++++++++++++------
 include/uapi/linux/kfd_ioctl.h              | 27 ++++++++++++++++++++
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 7023fa21a0a9..5818ea8ad4ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -37,6 +37,8 @@ struct kfd_smi_client {
 	uint64_t events;
 	struct kfd_dev *dev;
 	spinlock_t lock;
+	pid_t pid;
+	bool suser;
 };
 
 #define MAX_KFIFO_SIZE	1024
@@ -150,16 +152,26 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
-			      char *event_msg, int len)
+static bool kfd_smi_ev_enabled(pid_t pid, struct kfd_smi_client *client,
+			       unsigned int smi_event)
+{
+	if (pid &&
+	    !(client->suser && client->events & KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESSES)) &&
+	    client->pid != pid)
+		return false;
+
+	return client->events & KFD_SMI_EVENT_MASK_FROM_INDEX(smi_event);
+}
+
+static void add_event_to_kfifo(pid_t pid, struct kfd_dev *dev,
+			       unsigned int smi_event, char *event_msg, int len)
 {
 	struct kfd_smi_client *client;
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
-		if (!(READ_ONCE(client->events) &
-				KFD_SMI_EVENT_MASK_FROM_INDEX(smi_event)))
+		if (!kfd_smi_ev_enabled(pid, client, smi_event))
 			continue;
 		spin_lock(&client->lock);
 		if (kfifo_avail(&client->fifo) >= len) {
@@ -202,7 +214,7 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
 	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x\n", event,
 						dev->reset_seq_num);
 
-	add_event_to_kfifo(dev, event, fifo_in, len);
+	add_event_to_kfifo(0, dev, event, fifo_in, len);
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
@@ -225,7 +237,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
 		       amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
 
-	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
+	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
 }
 
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
@@ -250,7 +262,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
 		task_info.pid, task_info.task_name);
 
-	add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
+	add_event_to_kfifo(task_info.pid, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
 }
 
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
@@ -282,6 +294,8 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 	spin_lock_init(&client->lock);
 	client->events = 0;
 	client->dev = dev;
+	client->pid = current->pid;
+	client->suser = capable(CAP_SYS_ADMIN);
 
 	spin_lock(&dev->smi_lock);
 	list_add_rcu(&client->list, &dev->smi_clients);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index af96af174dc4..bbbae8ad9721 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -32,6 +32,7 @@
  * - 1.4 - Indicate new SRAM EDC bit in device properties
  * - 1.5 - Add SVM API
  * - 1.6 - Query clear flags in SVM get_attr API
+ * - 1.7 - Add SMI profiler event log
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
 #define KFD_IOCTL_MINOR_VERSION 6
@@ -459,10 +460,36 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
 	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
 	KFD_SMI_EVENT_GPU_POST_RESET = 4,
+	KFD_SMI_EVENT_MIGRATION = 5,
+	KFD_SMI_EVENT_PAGE_FAULT = 6,
+	KFD_SMI_EVENT_QUEUE_EVICTION = 7,
+	KFD_SMI_EVENT_QUEUE_EVICTION_RESTORE = 8,
+
+	/*
+	 * max event number, as a flag bit to get events from all processes,
+	 * this requires super user permission, otherwise will not be able to
+	 * receive events from any process. Without this flag to receive events
+	 * from same process.
+	 */
+	KFD_SMI_EVENT_ALL_PROCESSES = 64
 };
 
 #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
 
+enum KFD_MIGRATION_TRIGGER {
+	MIGRATION_TRIGGER_PREFETCH = 1,
+	MIGRATION_TRIGGER_PAGEFAULT,
+	MIGRATION_TRIGGER_PAGEFAULT_CPU,
+	MIGRATION_TRIGGER_TTM_EVICTION
+};
+
+enum KFD_USER_QUEUE_EVICTION_TRIGGER {
+	SVM_RANGE_EVICTION = 1,
+	USERPTR_EVICTION,
+	TTM_EVICTION,
+	SUSPEND_EVICTION
+};
+
 struct kfd_ioctl_smi_events_args {
 	__u32 gpuid;	/* to KFD */
 	__u32 anon_fd;	/* from KFD */
-- 
2.17.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2040AECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A64810F318;
	Mon, 29 Aug 2022 14:31:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A75010F2EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nzveul6ALoHNAy76IszErleI2HMjThgOa7K9cFRg57XoVMB7XQOdmLaFwW34PySM/RdLqM7JgKSiPg2idT0JmqLfplO9S/ERFPS1Gp9aDo5xHNVxe9nJFNhcEfFUFmAjZKtbKam4Wccff447J9ArfgVIPjzhJVioPzN/b9ETkE/aZPohfvk1IdE0QqBxD9libzwFW77c0YO2GBlKAX26nakWkaeYj1RXpnXRDCSQmmS9QLtncrpP5CPt7SQ0nOFeD4HnbrU6PWHG5qI/TGluuYsn5PeAddcQRA10LY35WAja/CODT6kM6PNfDDW8Ub1yPpV05eQhU7fS5B7zbgUREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya9tw59Kie7WA8calVrrkPOjrIxn4i7bfvo3teUliCo=;
 b=cG7XrxmwSG60Y3eJfNhKefYQDaLO19ZN0IrJGsMkiSU5S97snJf4mh/+5W2hZxaWNVHi0CUcYI+CT0xgje6MdM9dlFOETmdc3VL6myMD/ePdIlIwjdpMvuAXuWNnLlv2Jaf41oAPFh/5j3tQHt1+MwpEyERhZVsjyZsXIg9Fq6ATKl4WDaegQFB705N9ybjm6E4APt7L6JdFK9QmPv4f6RN7cp6k59vW+Zqb92vQLzLJW2z7BxJtcncvE+DnZ27BLcL5W5jKU42Dty69oXP2pcHxcMesvppZWuSp0ElCVvpomSN64K04R2W+Fus0Zzb4DT7a4Qa2wXVBZfOEe+BJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya9tw59Kie7WA8calVrrkPOjrIxn4i7bfvo3teUliCo=;
 b=nvw1g5oWD5wI3g3W0/ywF1QsThdUHhdW2DB6IJpSZz/yAV3ufAvL0P2mgq7BqJ2o0ieMQ2mXbuPQIiq1VHCO2fzsEJ5Auz8Hc61NEbbyIs/jNvhC0scphmY/XUMyJqSNgz0iuUEgbQjsBfRQ7+5FdKKqQqsEq+/l7FLv/xDO/J8=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 14:31:12 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::43) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:11 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:47 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/29] drm/amdkfd: add raise exception event function
Date: Mon, 29 Aug 2022 10:30:11 -0400
Message-ID: <20220829143026.1509027-15-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3392171-2ca4-4961-ff40-08da89cb1f2d
X-MS-TrafficTypeDiagnostic: DM8PR12MB5414:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EEJCyPEbVNds6rWSeIROx/T3yB0V/tk5iEm8qT23X6fcIzxlt3P4iiYELDMyTfzoflmCARQowVsz9rNHHvwQ3v9AZsqTvzov7+bOnAMOPKE4j46MWDDC3LuHMjmQcipuymPZXvCPoG7aZfTw6MQVImlmRbssGGdD/FDNv6qmYAS+bsdYpE5I7nH5llcyYEhmaXYT5qG82KH9dN5vfOUrTVUdLtQdcaqGWNMiNbDrUaNLnv6SUj8jnHjFS5X7zh/rjAZmAq8zP/4Yt/8OgzV/A2HbOU5x1MS2yoZ8M5+BjAV1d0HArGIQZEhDWEP/oAfhylGJpPFAnSOlpf+5RZPnGg8/GP918bQNmcq5THRTzhr+21RQFxGacC5ohOuhexcCVN+/bpPOx+Hj6Doydc8ztW0CPgPee4KWGshEv1y1RCIa3JTBeXtHRedLG5/AAhyZDXVwgzb5kjnbWxvC+LHDVhjiQ1EByED1RY3e4FIQWhvetwlRM5uJ5Bt7BPAyhjJvL/SnWp5xQMVXFNCXJz/HE4Z7Pl7UD2j1iLqxdadA/8JAf1kSmVlMo8eieTHqRzxdFxYnzcKnNFuUaWR3seopPXHunXmuQCUC4CKHtWryn94bSHaoPD1kcUXOi5EN8lik46cYmJQTD69iEjHc2N5W88gDi4GsuiekXRaqqE2oZrlJViMXGff+gr0/EAcOPLdnqbzkqVhZfidLjG4rUnA9cejwcb/g6h8I5f37MSFR7pkKZgPvthpbBg2ew88MnI8NlrTW+AnJETubEv1/FC84gLKRd042Bsy4EpZrW+qH0reWvzJlJ1mq0TR90T8ChNf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(6916009)(5660300002)(8936002)(8676002)(4326008)(36860700001)(426003)(1076003)(2616005)(47076005)(44832011)(70586007)(316002)(54906003)(2906002)(36756003)(86362001)(478600001)(6666004)(7696005)(41300700001)(26005)(70206006)(82310400005)(356005)(81166007)(83380400001)(186003)(336012)(16526019)(40480700001)(82740400003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:11.8946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3392171-2ca4-4961-ff40-08da89cb1f2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Exception events can be generated from interrupts or queue activitity.

The raise event function will save exception status of a queue, device
or process then notify the debugger of the status change by writing to
a debugger polled file descriptor that the debugger provides during
debug attach.

For memory violation exceptions, extra exception data will be saved.

The debugger will be able to query the saved exception states by query
operation that will be provided by follow up patches.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 90 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h |  5 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |  7 ++
 3 files changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index f5a5d17cde14..b7a4b2ec5b36 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -38,6 +38,93 @@ void debug_event_write_work_handler(struct work_struct *work)
 	kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
 }
 
+/* update process/device/queue exception status, write to descriptor
+ * only if exception_status is enabled.
+ */
+bool kfd_dbg_ev_raise(uint64_t event_mask,
+			struct kfd_process *process, struct kfd_dev *dev,
+			unsigned int source_id, bool use_worker,
+			void *exception_data, size_t exception_data_size)
+{
+	struct process_queue_manager *pqm;
+	struct process_queue_node *pqn;
+	int i;
+	static const char write_data = '.';
+	loff_t pos = 0;
+	bool is_subscribed = true;
+
+	if (!(process && process->debug_trap_enabled))
+		return false;
+
+	mutex_lock(&process->event_mutex);
+
+	if (event_mask & KFD_EC_MASK_DEVICE) {
+		for (i = 0; i < process->n_pdds; i++) {
+			struct kfd_process_device *pdd = process->pdds[i];
+
+			if (pdd->dev != dev)
+				continue;
+
+			pdd->exception_status |= event_mask & KFD_EC_MASK_DEVICE;
+
+			if (event_mask & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
+				if (!pdd->vm_fault_exc_data) {
+					pdd->vm_fault_exc_data = kmemdup(
+							exception_data,
+							exception_data_size,
+							GFP_KERNEL);
+					if (!pdd->vm_fault_exc_data)
+						pr_debug("Failed to allocate exception data memory");
+				} else {
+					pr_debug("Debugger exception data not saved\n");
+					print_hex_dump_bytes("exception data: ",
+							DUMP_PREFIX_OFFSET,
+							exception_data,
+							exception_data_size);
+				}
+			}
+			break;
+		}
+	} else if (event_mask & KFD_EC_MASK_PROCESS) {
+		process->exception_status |= event_mask & KFD_EC_MASK_PROCESS;
+	} else {
+		pqm = &process->pqm;
+		list_for_each_entry(pqn, &pqm->queues,
+				process_queue_list) {
+			int target_id;
+
+			if (!pqn->q)
+				continue;
+
+			target_id = event_mask & KFD_EC_MASK(EC_QUEUE_NEW) ?
+					pqn->q->properties.queue_id :
+							pqn->q->doorbell_id;
+
+			if (pqn->q->device != dev || target_id != source_id)
+				continue;
+
+			pqn->q->properties.exception_status |= event_mask;
+			break;
+		}
+	}
+
+	if (process->exception_enable_mask & event_mask) {
+		if (use_worker)
+			schedule_work(&process->debug_event_workarea);
+		else
+			kernel_write(process->dbg_ev_file,
+					&write_data,
+					1,
+					&pos);
+	} else {
+		is_subscribed = false;
+	}
+
+	mutex_unlock(&process->event_mutex);
+
+	return is_subscribed;
+}
+
 /* kfd_dbg_trap_deactivate:
  *	target: target process
  *	unwind: If this is unwinding a failed kfd_dbg_trap_enable()
@@ -50,6 +137,9 @@ static void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int
 {
 	int i, count = 0;
 
+	if (!unwind)
+		cancel_work_sync(&target->debug_event_workarea);
+
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 1053b7ca24c5..a288ca1941a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -28,6 +28,11 @@
 void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
 					uint32_t vmid,
 					bool stall);
+bool kfd_dbg_ev_raise(uint64_t event_mask,
+			struct kfd_process *process, struct kfd_dev *dev,
+			unsigned int source_id, bool use_worker,
+			void *exception_data,
+			size_t exception_data_size);
 int kfd_dbg_trap_disable(struct kfd_process *target);
 int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 			void __user *runtime_info,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6360b365973c..40a695619eab 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -493,6 +493,7 @@ struct queue_properties {
 	uint32_t ctl_stack_size;
 	uint64_t tba_addr;
 	uint64_t tma_addr;
+	uint64_t exception_status;
 };
 
 #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
@@ -783,6 +784,11 @@ struct kfd_process_device {
 	uint64_t page_in;
 	uint64_t page_out;
 
+	/* Exception code status*/
+	uint64_t exception_status;
+	void *vm_fault_exc_data;
+	size_t vm_fault_exc_data_size;
+
 	/* Tracks debug per-vmid request settings */
 	uint32_t spi_dbg_override;
 	uint32_t spi_dbg_launch_mode;
@@ -918,6 +924,7 @@ struct kfd_process {
 
 	/* Exception code enable mask and status */
 	uint64_t exception_enable_mask;
+	uint64_t exception_status;
 
 	/* shared virtual memory registered by this process */
 	struct svm_range_list svms;
-- 
2.25.1


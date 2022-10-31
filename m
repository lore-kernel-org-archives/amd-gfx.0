Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF61ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 476D310E2F4;
	Mon, 31 Oct 2022 16:24:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7286710E2EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTm8yioZVRlHe/TgqsCFOdaDzniOWBbdSv0y1kPpv4V5Y0hbqLWyGlWTDRFZo8hy/ohjSie2ADi2rDVj4xUkmTly5rJSFXDr2SRoVpQ0X/FJwoN347zXkZmn92rCASYunAbE0a0acu7tMmKpZI3z5T/vM8l3IGR8gqGkHYftxwsgxTpg7P5nkXtjKaft/3QUfGo5P6wwLkNcE57nZHBRevS4CeVwAPtHNEiDdr6gi+0sLFy0TaTCbQyIgAvYtj40ueHo9ksgFtrfVO2z8Mbc8Z8cBgG+ulKH1UeKr3pzKKHQjeYqxBW9jqlE7XBrnrm3J71AJwG7x1jbI4Q/gv/G6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya9tw59Kie7WA8calVrrkPOjrIxn4i7bfvo3teUliCo=;
 b=FQSxnHGazkUTUrVNkIkbHo2zPJ2pBhDQRKZC+vLn0PIfAqBpMvgAfzjVj8RP3CgldC0Gi4FicnJh2WcljOnIbhm5MoGC1HAn4tP6UqHfEjzmvA8rtttAT4IsO9rSWRRIACvi2gQWiPz1D8CtmdMCJzNxnlly0+k0JlFb1rMsRwjKmXFmfCQyIUdQGd5ovq0mC8qSYXTmOxHRv9jFbl4abunNAGUGdHsSyYMUex7BKa0tYIey7i8ijwU9b+sdCzUENIlHUOdVU5O5VkySk1ftuhGxPeV+rfGEh0ekJ+xFQ88tzXKxbKGggZNbcRb48S0OnUY2WRXWXK7P3G7XFDBpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya9tw59Kie7WA8calVrrkPOjrIxn4i7bfvo3teUliCo=;
 b=GsOe7aECsggtfUxgexP5tclOleJ3PYhWFFnlQnZ/YfVTwJNuPcroFAfmCp/PYrKYbYhWHfWjJqFffhN/PYVMlWIPZnbTwzXpjMyL5ufDCVV0v0iI/dv9Rve8Ol7iHbDwskI8XLTRvWl1NldTPqcF6Y6e4DkHgd0mClA9eZGCcro=
Received: from MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 16:24:30 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::c8) by MW4PR04CA0110.outlook.office365.com
 (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:29 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:26 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/29] drm/amdkfd: add raise exception event function
Date: Mon, 31 Oct 2022 12:23:44 -0400
Message-ID: <20221031162359.445805-14-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: fe69afec-d543-4898-3071-08dabb5c630f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrPlDISuxxcCiCsWMGRDF0WQbU/kxyN19bhL8ePrnVmQa5llhsTn1sVcCLXXssYO9DtVHIS/C4QL+nFM+ToIhoFcJfRiFtDl/eF3kbAyd7phrTznOsy7QdSJQzSidz4lJOzG6qa2iUD+wtKVCpRxpngaxBUKU/HJIycIGJBBf5v9exJkTeGjD0YzVRIpmIlL0GrlqFUJBxrJa8qQtNoKyg/ttYj63LX7WflgLj5k5axXeXygd7P5OAZmda5rtvyssvIg5X23hqjs3ZLY5CSVKlngPAzvEvH7FpV7/S8nFqeWhH8VUWdovaXTHHNSth+sk1jB4NMfDlePK8UqgE1+lDSl9xrM3TjjZGJiB0ILf8MdHeE5GixT5R1cxnHjb/Y2PgYBXkzn7wKo/hMGbiqISACw8k2tPAIjH5DLJb8kH/khqEtFacUoYcAHvNjE6w0220PWIzTQru4FgGJfiBCgtsIWM//O/he4DJbe3yAoqFwODzgGA/7iZrbkanlZI4IqT9/tWwFydSEHK0i7op+5otf1rKx4/inOI37dK0cYubX21tHe/p6uUHrIcKkT4H/FtMYlqtQED7iit0ftX7J/PNP7v+lgh9IHKm+yd0UjkybdIFCrHe2ZcyvvtfjoeQS6HwhkNMZymmBdqKSLDPpeZscdF0T+N+nnYuXYRML9JEOpYHfEYQUbUeepl8i3gOqtFYujxwcSVWOqbywUO/pQC4LQ8aygp/dhJcosNfykI0Kjo3YK6uSrnj81PJVSWxT83w7CndMEAgsRp7iH1fENPSGj027qPneWihf7oIRIDfa+m9XgI4W55+uKYbawiY9z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(82310400005)(478600001)(82740400003)(6916009)(86362001)(44832011)(70206006)(4326008)(6666004)(83380400001)(70586007)(36860700001)(40460700003)(8676002)(8936002)(1076003)(16526019)(316002)(186003)(36756003)(47076005)(81166007)(426003)(2906002)(356005)(2616005)(26005)(41300700001)(40480700001)(7696005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:29.8265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe69afec-d543-4898-3071-08dabb5c630f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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
Cc: Felix.Kuehling@amd.com
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


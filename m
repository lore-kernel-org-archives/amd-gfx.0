Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47257ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267DE10F2EE;
	Mon, 29 Aug 2022 14:32:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6AA10F2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwAxikLFb7TIrce5EF6tKH8uy9U/ips3gggsogdTrqskBP0O0yIG+TSp6gqosqWCx0HwAmisB1Z5HGKWR6bVaGCQpt1Fm58TGB8aEH0HBBv52ONxYZ0VHYzEYAUd2wn0dmsOLYdF4DkIcRiVZzyjnfmk0dFV5UM9AxgfAg8cdrAyT4XPnKjetL5hwvCQkVwukGefy1lG3sEV5GRpQ+pG+e+tgsBJd7wh7cSG96nq3CpTtVz7IFi8HIUEBL8e25Mxn0ulRNR5GmeS1xw/s7en8EkK1qVnWsdKvSouMkJ7o6VBi2Gj26VhGZfTcKyYy1fXVYh+wQxaWyPFdXdANmlUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6MEXOalha/+tGOAHoqT3Ha1Fwr5wk0VW1EpXHMnfMo=;
 b=jfNsHdvkKeono3T4GHvt3DjBa2wDvT9vX8aZ6uRAwyzX7je0g8QBz6d9xO4RvcTExZ59WWCsgDNMJbos7HjzDINljtL/vi5TO4HG+z3TLaJ+XdBh4swIXjl0fnlCyYIHRxuriRqPvJlWl9pDPEx6x8JWP3RuTOy+0Vx3cOkD/9KTNqYUP/n1KvZ7pBUaFw9+67SaKwlnZrZEi1uhkwx+Ea74Ydb2/m5kFgZs2gT5+BqCnhVUrobndxzc5ls/myyJZiGTJBcQ//knR9ceQaftHMiUnVhdAHRFWou5/EE1cmZmcfgsQvy5l56AYPJxBk/tYkzGh1oc6sIn01OKNjv9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6MEXOalha/+tGOAHoqT3Ha1Fwr5wk0VW1EpXHMnfMo=;
 b=ictmf//Mga9DrrZ3rwk2uebVtO8w5ZR4U9RoERbUkcfkltGddj8ZBBelrKLRUbAxkPwW3RO51twdoHQ9IysHbZeHWxaaXCF9Rsc9Pv9zDojiFpRy7Cduwxbj4F+I6OEm1yuctY1v5SqO/JzilEJAx9jt50BY57VqsFdEXkkcNfo=
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 14:31:18 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::a5) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:17 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:31:12 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/29] drm/amdkfd: add debug queue snapshot operation
Date: Mon, 29 Aug 2022 10:30:24 -0400
Message-ID: <20220829143026.1509027-28-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57480b6e-94c0-4c15-e288-08da89cb22a6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bD5vvZI0Oc7nXSSz1ys0ZmiI0V8uaSWsdy0405ZQ0s83lrNDJSsVV+1oASNlxFxmg1UwKp3C7WyAHZ4PVVIzrMkOwLK2GIvlowGthab4TfCBljFhvf4D15WzbigQm13N2YkBoz/5r59mmJTt2lbxUh78rzk3lVkGLNR6NaH+MQ8tmEt1iT4Z0QUUYCVrjWuHMOyUlZTYk+/UpwNvzcO+IKuIbXX7aCoxcIod6CZEw9RstzVfhBM9eNt1/FYy9dg6NuEJbD0nlbDaG/SVbH4Po67iCGNR+wa+kRUJmjKhDiBm5LbORhUwHJPF9PJgGvtTXgjxgz+O7OXDPV53pYcMqgLRLmfSfSxdse9NPB7lk3X8kl5H+dpCyLWvvBNg28K9hgXmaPxuvI70d3QQKVpbxa/HHb1RYJabsv0shxhLQBi7Ve29PhIwy0sDI+x+NmUwV8RFXDdSzNM5LCBbTSM2TzhM9SFizYDIcLZEz2luLXqbZ/XETTC7Ttw3QjF6AY8tHPx65uS4m/ZxktqA/RcSinUEhEBnd0RoIEYXPpmleEcmgFpBmN8I1ERZBJxRsq/0AXTjC4indvUmpvL2t1sEo+W+Dck3WojfUFvNiBxiPKPEGzaumgJSY2cozHwvRe5G2JRWXmkIyMdQ44rjxuRjW/VEpDrxNFzEfz7IH1/tzIhKmg9ZUUyaUKIffr5SBWhpqR4EjqXqUBr/jkVr9cliIxmZcN7QGGDWhqosKF4ML7fUNKn4W7Dr32IET/mNA7tKlKyPGnfEs41qdJs4NZJ55+vipCFcnX+X1S0wM/SE354=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(40470700004)(46966006)(36860700001)(81166007)(40460700003)(5660300002)(8936002)(41300700001)(40480700001)(16526019)(186003)(47076005)(7696005)(2616005)(86362001)(1076003)(426003)(6666004)(44832011)(83380400001)(2906002)(336012)(26005)(82310400005)(36756003)(316002)(70586007)(478600001)(70206006)(6916009)(54906003)(82740400003)(4326008)(356005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:17.7200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57480b6e-94c0-4c15-e288-08da89cb22a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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

Allow the debugger to get a snapshot of a specified number of queues
containing various queue property information that is copied to the
debugger.

Since the debugger doesn't know how many queues exist at any given time,
allow the debugger to pass the requested number of snapshots as 0 to get
the actual number of potential snapshots to use for a subsequent snapshot
request for actual information.

To prevent future ABI breakage, pass in the requested entry_size.
The KFD will return it's own entry_size in case the debugger still wants
log the information in a core dump on sizing failure.

Also allow the debugger to clear exceptions when doing a snapshot.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  6 +++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 41 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 40 ++++++++++++++++++
 5 files changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1017bf076e1f..eac1813b4b78 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2930,6 +2930,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				&args->query_exception_info.info_size);
 		break;
 	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
+		r = pqm_get_queue_snapshot(&target->pqm,
+				args->queue_snapshot.exception_mask,
+				(void __user *)args->queue_snapshot.snapshot_buf_ptr,
+				&args->queue_snapshot.buf_size,
+				&args->queue_snapshot.entry_size);
+		break;
 	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
 		pr_warn("Debug op %i not supported yet\n", args->op);
 		r = -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 492dd7d9fcff..97f5459c01f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2953,6 +2953,47 @@ int suspend_queues(struct kfd_process *p,
 	return total_suspended;
 }
 
+static uint32_t set_queue_type_for_user(struct queue_properties *q_props)
+{
+	switch (q_props->type) {
+	case KFD_QUEUE_TYPE_COMPUTE:
+		return q_props->format == KFD_QUEUE_FORMAT_PM4
+					? KFD_IOC_QUEUE_TYPE_COMPUTE
+					: KFD_IOC_QUEUE_TYPE_COMPUTE_AQL;
+	case KFD_QUEUE_TYPE_SDMA:
+		return KFD_IOC_QUEUE_TYPE_SDMA;
+	case KFD_QUEUE_TYPE_SDMA_XGMI:
+		return KFD_IOC_QUEUE_TYPE_SDMA_XGMI;
+	default:
+		WARN_ONCE(true, "queue type not recognized!");
+		return 0xffffffff;
+	};
+}
+
+void set_queue_snapshot_entry(struct device_queue_manager *dqm,
+			      struct queue *q,
+			      uint64_t exception_clear_mask,
+			      struct kfd_queue_snapshot_entry *qss_entry)
+{
+	dqm_lock(dqm);
+
+	qss_entry->ring_base_address = q->properties.queue_address;
+	qss_entry->write_pointer_address = (uint64_t)q->properties.write_ptr;
+	qss_entry->read_pointer_address = (uint64_t)q->properties.read_ptr;
+	qss_entry->ctx_save_restore_address =
+				q->properties.ctx_save_restore_area_address;
+	qss_entry->ctx_save_restore_area_size =
+				q->properties.ctx_save_restore_area_size;
+	qss_entry->exception_status = q->properties.exception_status;
+	qss_entry->queue_id = q->properties.queue_id;
+	qss_entry->gpu_id = q->device->id;
+	qss_entry->ring_size = (uint32_t)q->properties.queue_size;
+	qss_entry->queue_type = set_queue_type_for_user(&q->properties);
+	q->properties.exception_status &= ~exception_clear_mask;
+
+	dqm_unlock(dqm);
+}
+
 int debug_lock_and_unmap(struct device_queue_manager *dqm)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 12643528684c..094705b932fc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -297,6 +297,10 @@ int resume_queues(struct kfd_process *p,
 		bool resume_all_queues,
 		uint32_t num_queues,
 		uint32_t *usr_queue_id_array);
+void set_queue_snapshot_entry(struct device_queue_manager *dqm,
+			      struct queue *q,
+			      uint64_t exception_clear_mask,
+			      struct kfd_queue_snapshot_entry *qss_entry);
 int debug_lock_and_unmap(struct device_queue_manager *dqm);
 int debug_map_and_unlock(struct device_queue_manager *dqm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ba08d1b5153f..de5ae385edbf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1302,6 +1302,11 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 		       void __user *ctl_stack,
 		       u32 *ctl_stack_used_size,
 		       u32 *save_area_used_size);
+int pqm_get_queue_snapshot(struct process_queue_manager *pqm,
+			   uint64_t exception_clear_mask,
+			   struct kfd_queue_snapshot_entry __user *buf,
+			   int *num_qss_entries,
+			   uint32_t *entry_size);
 
 int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
 			      uint64_t fence_value,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 77a6a03c949a..9dcacd2726b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -566,6 +566,46 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 						       save_area_used_size);
 }
 
+int pqm_get_queue_snapshot(struct process_queue_manager *pqm,
+			   uint64_t exception_clear_mask,
+			   struct kfd_queue_snapshot_entry __user *buf,
+			   int *num_qss_entries,
+			   uint32_t *entry_size)
+{
+	struct process_queue_node *pqn;
+	uint32_t tmp_entry_size = *entry_size, tmp_qss_entries = *num_qss_entries;
+	int r;
+
+	*num_qss_entries = 0;
+	if (!(*entry_size))
+		return -EINVAL;
+
+	*entry_size = min((size_t)entry_size, sizeof(struct kfd_queue_snapshot_entry));
+	mutex_lock(&pqm->process->event_mutex);
+
+	list_for_each_entry(pqn, &pqm->queues, process_queue_list) {
+		if (!pqn->q)
+			continue;
+
+		if (*num_qss_entries < tmp_qss_entries) {
+			struct kfd_queue_snapshot_entry src = {0};
+
+			set_queue_snapshot_entry(pqn->q->device->dqm,
+					pqn->q, exception_clear_mask, &src);
+
+			if (copy_to_user(buf, &src, *entry_size)) {
+				r = -EFAULT;
+				break;
+			}
+			buf += tmp_entry_size;
+		}
+		*num_qss_entries += 1;
+	}
+
+	mutex_unlock(&pqm->process->event_mutex);
+	return r;
+}
+
 static int get_queue_data_sizes(struct kfd_process_device *pdd,
 				struct queue *q,
 				uint32_t *mqd_size,
-- 
2.25.1


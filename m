Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296B0FA3741
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0E410E2FC;
	Mon, 31 Oct 2022 16:25:06 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7717F10E2F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boETXngZhgwvP2bz5/ZCLO4XYeRGtG/C/1/89ckqtj11VZkbBFE7oSBDXjjGBK8rBQCixZdrN1sTCEEYKaoiGwNflSAPJfduODFzVTLTlj1sxT2grDYEfIMw/a/fyVAbPigJQ48FbypS0Yt50waUeqSx2nbsiN3EI1XbakwHn0jjXsObPwIDGzA91JDAEPg7RHlW20nsKmpeqkJfU9u0I4Ygg1Lrg5npQNyX35ofCVxEJQQO9H3GC2mUcfgehRKZXB0WvYZJyjzP0LctIdPIhaG2bIdrLjvJZfT3zD411QpgdslDbgis9vZz3NbyD12Kb55D8dRMLgRMHWRWFOcUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUY+6x6QcTK3bZVMZt/3QC2kBsJQuInWiAR0T21xTjI=;
 b=kc6cCOsDvktG1lCIqXfwc/Par150jrk9u1FMbPVY/f14C+rGrdrFf3zaXDvhzA1CwAJpYbnBjaLRuZX+bsjKDhifR2aVQuI6IfJQKu5ZR02iH75BXdIGkYAwmzbfcxQ181ylrvuKRVhXlqlLNkt6Ry9C2/gP+BT1FQ8BAVQlMqIbm+Ze//y4vryyIYtI280NnM+YvUOXKvAFAT24WzEh5VMLa5/8kr2WWageP1N1YrQIP1OGnipalDTEn2mtnDxhH/oSQIe0RicPGhPbArswWDCyzUowyXfYvEyszMgGtaAgVn3WfOcwMeFOKuyTnyKwIaC1rOl5ORGCShXRduAKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUY+6x6QcTK3bZVMZt/3QC2kBsJQuInWiAR0T21xTjI=;
 b=NYjm5tIZSrqycPwQduzbAn4doXo4Sb7yCoWvWjm45Vf0cXV3ZPFIkrTZKVqZdzOQqcuBjQoLFB+aEw5B2cveXkl8GwIp25GZ/MGYI89Kt7QyLgqOFP8+7GHy+C12JvdRQ6Xc8UJ+YQ8trgXE1I2Pu457dPsbGzJSxuf+g1Y4RVA=
Received: from MW4PR04CA0161.namprd04.prod.outlook.com (2603:10b6:303:85::16)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 16:24:34 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::5) by MW4PR04CA0161.outlook.office365.com
 (2603:10b6:303:85::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.21 via Frontend Transport; Mon, 31 Oct 2022 16:24:34 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:30 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/29] drm/amdkfd: add debug queue snapshot operation
Date: Mon, 31 Oct 2022 12:23:57 -0400
Message-ID: <20221031162359.445805-27-jonathan.kim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|SA0PR12MB4528:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5ae9f3-0481-4963-07ae-08dabb5c65bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZheTgss6F3cvhUXa7m1ElAAl3NpyYcjKOz7njcH+CpBSWmpuy3zu9tqQfPdg9KIkvf1P8XvLfgmk1FLpl0xdx49SvnRUhcGf/AKm2GnY1gIqXnRax1mmAl6GuUHqGs/1fw0Wo9Iwh8PgYuc4KKLHa/tVKP+FEWXOSgkaeRCL0a70nKTSiQK7QelwwZTfm0zrJhaLL4cOxki+mgFvD5Vhfw91SbCTcbme4ZccN9qH+nLW6P1klMV/f17jIrA5GVmKtI0UuDRZx3hcbtssJaIMu8VBtD62A6WMOF1KcRLtRr2kqfvloG9Po1accidj+2zTR9LWY43JuZHrQreiV4W/nPZKj9O9PN79AHutA+DOEElOpASndOc4QsClPxKRMGNTxqEjZBpUhkRjyWox4v097e467DI+RbCNtFjMP79G5qM/qtD5SAMpjvk5bHrslk00wX5KQWi+g5RQfWmPOlEKAijRAP839RMP3elbd0+u7D/vgP0KzR4lBcoaVmPf9CH0C5zDfB/GoIOX0iwOP86U1MnfAsir/4/orP/9LaetrREMez/sMe/R/JloslDaC6RbMvkFB+i6jshP3sSsaNIbYiwXcRxRx+J9l/PNze5k+kPUFhYP7Ei6C9Pge8oA/BAnRYOioS6mvwtb51BGToIOyXjFseGTYqsAAt9rfiTIlx2+kcjPuFiLQyLEiGsSjZ/mA8CoFlOhhqirYWNYd0PC8sOzp1epmKcw75iqUULR0gqtOWKmONS29F7i7sIUlGWV78z+7rBICIiquvcwhNtUB0fmbb9Nlrnv+HbNuzD2wM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(44832011)(82310400005)(2616005)(81166007)(356005)(16526019)(1076003)(4326008)(40480700001)(8676002)(6916009)(70206006)(70586007)(40460700003)(6666004)(316002)(36756003)(8936002)(5660300002)(7696005)(26005)(86362001)(41300700001)(186003)(336012)(47076005)(2906002)(83380400001)(426003)(36860700001)(82740400003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:34.3147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5ae9f3-0481-4963-07ae-08dabb5c65bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
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

v2: change buf_size arg to num_queues for clarity.
fix minimum entry size calculation.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  6 +++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 41 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 40 ++++++++++++++++++
 5 files changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 2c8f107237ee..cea393350980 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2961,6 +2961,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				&args->query_exception_info.info_size);
 		break;
 	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
+		r = pqm_get_queue_snapshot(&target->pqm,
+				args->queue_snapshot.exception_mask,
+				(void __user *)args->queue_snapshot.snapshot_buf_ptr,
+				&args->queue_snapshot.num_queues,
+				&args->queue_snapshot.entry_size);
+		break;
 	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
 		pr_warn("Debug op %i not supported yet\n", args->op);
 		r = -EACCES;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 589efbefc8dc..51f8c5676c56 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2950,6 +2950,47 @@ int suspend_queues(struct kfd_process *p,
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
index aee4fe20e676..ebd701143981 100644
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
index 15db83c9a585..30df1046c30b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -569,6 +569,46 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
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
+	*entry_size = min_t(size_t, *entry_size, sizeof(struct kfd_queue_snapshot_entry));
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


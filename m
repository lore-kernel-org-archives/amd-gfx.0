Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB13ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D1D10E300;
	Mon, 31 Oct 2022 16:25:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E7F10E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBf+UQ7jGgSGyIDPdrUueqRmyfeojZLf8Ssk149Q4B+8nnpQcqTYKG1/X8dVgYJFs3W0cJoNhpqwHn1mb9e4ja6oNPq4nB3Fxq5uxza8MfQ9BPaIPTJWu+53RLWESQ0RYb1aPAAd+djZgPXWLX2h/zOQI9FUmj823ROjkyU2H91WLop9HYbsfiBYHDvipJLwLfxilRvZ6/vmpkd3dIHOwfNXRkx832mxMClMkxFkYgQ/qSgbgmQWu70cXyqfUocuRtIUWaRwNvW65H1h20S9hTKiItfN+H8q9IVL7370LAmjc1/jsAulAWpL50CD1jMs+seG9gzxsCLW8VdPaofXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUYSgD98xjBQ/rsndAyZ6QZlKfl/Lqh3M50atTviA1c=;
 b=HmI7UYrzAOqBBY/O56zdbWGn7bvz8ivRflAzUYdXJmCdSALhrAJtqffcB8XwjRylY+VlE4fW3UW78D0Ggfeb0VdDHK/D9JhYkEXUtFynLhmRkH7dWhqFKKa8B/tM7KBV44OVM7Op97Vl+G1MYnFMGoGXuuwRDAtwZBQnjgt5JLLtyjlVALX31C8ZLdgMGyLS0CfreV0h8+vK5rluIvZnTZFRtmdMhsCIEcOxS1AGKUWWYRQDaQ5i/l3clTEfpsVbY7B9AX2YBC00JkPvY5CJGocDlKtruIWxsI8V2LjjWadWwDg+OCB8uLraB9bR9kF2XfjjjVgO1QRQuTH5GudBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUYSgD98xjBQ/rsndAyZ6QZlKfl/Lqh3M50atTviA1c=;
 b=rZclge6M41LQeVMYSOMPvpiRJFHkB5zKzt93Vn+Yy/nuVpKYsQpL5dPk09Poq0JgZoDriX973OYqWGLi7UW1zWvpm+RHPBF05n72GzhTELW2DLSu9ipVcH1inSX2xnNZ9s9Oxo+II58lGMLqcxnbOnf0eWpfN1QTpGg0zC6rVY8=
Received: from MW4PR04CA0178.namprd04.prod.outlook.com (2603:10b6:303:85::33)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 16:24:29 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::d6) by MW4PR04CA0178.outlook.office365.com
 (2603:10b6:303:85::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.21 via Frontend Transport; Mon, 31 Oct 2022 16:24:28 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:25 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/29] drm/amdkfd: prepare map process for single process
 debug devices
Date: Mon, 31 Oct 2022 12:23:41 -0400
Message-ID: <20221031162359.445805-11-jonathan.kim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 41948b84-64d2-417b-63e4-08dabb5c627e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCeSjHE2CXzadrZuLGQz/kpwrN8A51dFmmWbdPQY9P5YGqOSzGRhjNJ23xe5ai7YJCADkWhMdSFkohX10pf9G6gJqEwK/UCTIlgcgo//w8M6vLURib2N18eFJHG9AM3CJghwMcX5y63Wa+a1vo1usc0aEUriXqM21Yrtm/dxSsk9++EHR3I+sFZMYlAkDQ2pF40VAKmnjWkzv/xPD3eLfElqcykLqO4+2HNxVp4TJQ9UFMb+79BkDfYYlQ/Obd+AP0YMyJGeJ/Qh7u9Ix1K1ws2JUW47vIxiLpSpaPgyQUDayFtB+oQtaMAfxcvZZzYaPR2bCMWvKHCN9SxNFXGI3FkV7RWLYVL3XvC30capjJYvK2/LwFWFJn1xsNFjSm4xR9usuJA0AwJRd1asU44vdzgrKxU4Wvi3mwnQJE++sgFN93d/1p8T9aFTQYj7L7aquk5/+zaEgSplh2wV9xjlBTyZL4lf+cVzG1d/lutImBRbkn7FTLQOK4lYTM21N45KvdQUsi1Fondu1liN3VOPS7QTTxPTR51Ia5yTJRczZQXPjZOT8Ulrab+fYvnclsF1xU4oPlrvnsoselLH3gG2KrMrKQdaK6eekzboStLPQ1zlz3utKhZr/XiBubYzYZ85cbFxSLMJPnrPoa4EjUclG5u7Z4ziO9EK5vqs+7sOwPYKoojifuPCEmPcxfvxB1SOqLzZ6FIrA/fkAeYblXWdPQJmhm+uG3eOVWLT+lgWdkgsqEJV/p5iXm+GsWxjBLwuyYEuhI4jeMI/BFLOgm5B0A8YEKLIEg1KSH1OoLrPGZzptzDZE6m94m4HdSiowIGQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(86362001)(47076005)(83380400001)(426003)(36860700001)(82740400003)(5660300002)(8936002)(356005)(44832011)(8676002)(81166007)(2906002)(4326008)(478600001)(70206006)(82310400005)(7696005)(70586007)(6666004)(336012)(2616005)(16526019)(186003)(1076003)(40460700003)(26005)(6916009)(41300700001)(40480700001)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:28.8775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41948b84-64d2-417b-63e4-08dabb5c627e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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

Older HW only supports debugging on a single process because the
SPI debug mode setting registers are device global.

The HWS has supplied a single pinned VMID (0xf) for MAP_PROCESS
for debug purposes. To pin the VMID, the KFD will remove the VMID from
the HWS dynamic VMID allocation via SET_RESOUCES so that a debugged
process will never migrate away from its pinned VMID.

The KFD is responsible for reserving and releasing this pinned VMID
accordingly whenever the debugger attaches and detaches respectively.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 101 +++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   5 +
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   9 ++
 .../gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h   |   5 +-
 4 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index fbcf4ee07936..62bb92ef1acd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1492,7 +1492,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	dqm->active_cp_queue_count = 0;
 	dqm->gws_queue_count = 0;
 	dqm->active_runlist = false;
-	INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
+	dqm->trap_debug_vmid = 0;
 
 	init_sdma_bitmaps(dqm);
 
@@ -1935,8 +1935,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 		if (!dqm->dev->shared_resources.enable_mes) {
 			decrement_queue_count(dqm, qpd, q);
 			retval = execute_queues_cpsch(dqm,
-						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
-						      USE_DEFAULT_GRACE_PERIOD);
+						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
 			if (retval == -ETIME)
 				qpd->reset_wavefronts = true;
 		} else {
@@ -2465,6 +2464,98 @@ static void kfd_process_hw_exception(struct work_struct *work)
 	amdgpu_amdkfd_gpu_reset(dqm->dev->adev);
 }
 
+int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
+				struct qcm_process_device *qpd)
+{
+	int r;
+	int updated_vmid_mask;
+
+	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
+		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
+		return -EINVAL;
+	}
+
+	dqm_lock(dqm);
+
+	if (dqm->trap_debug_vmid != 0) {
+		pr_err("Trap debug id already reserved\n");
+		r = -EBUSY;
+		goto out_unlock;
+	}
+
+	r = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
+			USE_DEFAULT_GRACE_PERIOD, false);
+	if (r)
+		goto out_unlock;
+
+	updated_vmid_mask = dqm->dev->shared_resources.compute_vmid_bitmap;
+	updated_vmid_mask &= ~(1 << dqm->dev->vm_info.last_vmid_kfd);
+
+	dqm->dev->shared_resources.compute_vmid_bitmap = updated_vmid_mask;
+	dqm->trap_debug_vmid = dqm->dev->vm_info.last_vmid_kfd;
+	r = set_sched_resources(dqm);
+	if (r)
+		goto out_unlock;
+
+	r = map_queues_cpsch(dqm);
+	if (r)
+		goto out_unlock;
+
+	pr_debug("Reserved VMID for trap debug: %i\n", dqm->trap_debug_vmid);
+
+out_unlock:
+	dqm_unlock(dqm);
+	return r;
+}
+
+/*
+ * Releases vmid for the trap debugger
+ */
+int release_debug_trap_vmid(struct device_queue_manager *dqm,
+			struct qcm_process_device *qpd)
+{
+	int r;
+	int updated_vmid_mask;
+	uint32_t trap_debug_vmid;
+
+	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
+		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
+		return -EINVAL;
+	}
+
+	dqm_lock(dqm);
+	trap_debug_vmid = dqm->trap_debug_vmid;
+	if (dqm->trap_debug_vmid == 0) {
+		pr_err("Trap debug id is not reserved\n");
+		r = -EINVAL;
+		goto out_unlock;
+	}
+
+	r = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
+			USE_DEFAULT_GRACE_PERIOD, false);
+	if (r)
+		goto out_unlock;
+
+	updated_vmid_mask = dqm->dev->shared_resources.compute_vmid_bitmap;
+	updated_vmid_mask |= (1 << dqm->dev->vm_info.last_vmid_kfd);
+
+	dqm->dev->shared_resources.compute_vmid_bitmap = updated_vmid_mask;
+	dqm->trap_debug_vmid = 0;
+	r = set_sched_resources(dqm);
+	if (r)
+		goto out_unlock;
+
+	r = map_queues_cpsch(dqm);
+	if (r)
+		goto out_unlock;
+
+	pr_debug("Released VMID for trap debug: %i\n", trap_debug_vmid);
+
+out_unlock:
+	dqm_unlock(dqm);
+	return r;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static void seq_reg_dump(struct seq_file *m,
@@ -2565,8 +2656,8 @@ int dqm_debugfs_hang_hws(struct device_queue_manager *dqm)
 		return r;
 	}
 	dqm->active_runlist = true;
-	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
-				0, USE_DEFAULT_GRACE_PERIOD);
+	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
+			USE_DEFAULT_GRACE_PERIOD);
 	dqm_unlock(dqm);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index fb48b124161f..0cb1504d24cf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -250,6 +250,7 @@ struct device_queue_manager {
 	struct kfd_mem_obj	*fence_mem;
 	bool			active_runlist;
 	int			sched_policy;
+	uint32_t		trap_debug_vmid;
 
 	/* hw exception  */
 	bool			is_hws_hang;
@@ -281,6 +282,10 @@ unsigned int get_queues_per_pipe(struct device_queue_manager *dqm);
 unsigned int get_pipes_per_mec(struct device_queue_manager *dqm);
 unsigned int get_num_sdma_queues(struct device_queue_manager *dqm);
 unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm);
+int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
+			struct qcm_process_device *qpd);
+int release_debug_trap_vmid(struct device_queue_manager *dqm,
+			struct qcm_process_device *qpd);
 
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index f0cdc8695b8c..363cf8e005cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -34,6 +34,9 @@ static int pm_map_process_v9(struct packet_manager *pm,
 {
 	struct pm4_mes_map_process *packet;
 	uint64_t vm_page_table_base_addr = qpd->page_table_base;
+	struct kfd_dev *kfd = pm->dqm->dev;
+	struct kfd_process_device *pdd =
+			container_of(qpd, struct kfd_process_device, qpd);
 
 	packet = (struct pm4_mes_map_process *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mes_map_process));
@@ -49,6 +52,12 @@ static int pm_map_process_v9(struct packet_manager *pm,
 	packet->bitfields14.sdma_enable = 1;
 	packet->bitfields14.num_queues = (qpd->is_debug) ? 0 : qpd->queue_count;
 
+	if (kfd->dqm->trap_debug_vmid && pdd->process->debug_trap_enabled &&
+			pdd->process->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED) {
+		packet->bitfields2.debug_vmid = kfd->dqm->trap_debug_vmid;
+		packet->bitfields2.new_debug = 1;
+	}
+
 	packet->sh_mem_config = qpd->sh_mem_config;
 	packet->sh_mem_bases = qpd->sh_mem_bases;
 	if (qpd->tba_addr) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
index 795001c947e1..bb6edbc27de7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
@@ -146,7 +146,10 @@ struct pm4_mes_map_process {
 	union {
 		struct {
 			uint32_t pasid:16;
-			uint32_t reserved1:8;
+			uint32_t reserved1:2;
+			uint32_t debug_vmid:4;
+			uint32_t new_debug:1;
+			uint32_t reserved2:1;
 			uint32_t diq_enable:1;
 			uint32_t process_quantum:7;
 		} bitfields2;
-- 
2.25.1


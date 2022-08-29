Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F641ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DDE510F2EB;
	Mon, 29 Aug 2022 14:31:15 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D1C10F2EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3lVZGikCbMrb+owkRxDqPMLoeDPGS+5fS+axgAnkMJUuo7IvrVfP3nV4mY19Tp7DzjHw7LaVeru/gmnRjbGzrCrOXuCSemXBxPbhgfTOG9bV1vbbgSYOv7BI0Xb3JOKScgwJcA4TYbmsRtvgyiuA1DCQJ34JGu74RO2FrDv2BpknJtf7ynIYi1k9CVnvde0UaKxh4uMkqD2ZZlRYVfAbUEmPmCPJUVm65fA794+7nBlp3SKzNMZecwRBud1r+B6q+j8RvMcvxI39rwbiFOZSdUzi9uAqGVqCTqzTt61NIkxDdQ0nBRcd8r334xwIw4hEuYi1H0yagKx114xqQL9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie8iN3irlKykrbZZx4lil/53QL++pbe7jSg/WshPf1o=;
 b=JCSJ44h1getkPQNdtX8F/V7FqHDm3FyT6WRQw6Ns/PIYOznR2w/4VyjhDn7wF58lM/irREpBDOpQ/7ujWzhdLum5iL+8lnA76fuXFQnLOBJEK9WrKejCRFjx9sGHlPzWJJMecQoDd+p80xrye1c9XyIM3IMKFufwRmNf6yhHCp+kZzifj0fLTz4t7eWFd+F/IDm1yxe00OjefPqEPtH+dNAYb1hXQXsXnENicZkbLIPx2IVtCgDwP+D3wN4/H88llgZsqHdwBtT5ft64eqqEMhYLEJ4f8ipyoplOil+pqOaeB6bmwACXn81CuBym3+0vKmDIP7lmRzGKTSS2K9W2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie8iN3irlKykrbZZx4lil/53QL++pbe7jSg/WshPf1o=;
 b=KB/rJJwI9zsKovVc8t0xd9Y9ZG4ZKSYBNAHB1DsMje/UVrJawktpL+Vp4VgLnqr56kO1IrNdVMKXsPZ5h3hyorPcLn+ELdlp1WE2yCK6YPzTM6YPCq/pw2lLGD/AuLebSgz4uTnHStMCFkco5S1LXv3RWX/Gehmdhvhcoi+MiYc=
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by BN8PR12MB3156.namprd12.prod.outlook.com (2603:10b6:408:96::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 14:31:10 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::83) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:09 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:45 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/29] drm/amdkfd: prepare map process for single process
 debug devices
Date: Mon, 29 Aug 2022 10:30:08 -0400
Message-ID: <20220829143026.1509027-12-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5338b923-0a40-48f1-7acb-08da89cb1d9d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3156:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9WY0RSqPete+rWqxo5mckiUmtHsmPfGqbHgiY0sHcXS8Af3IBUFmCrKAhkJ1pFMxnBcdYYqYUaESdbiA7WRJFjyCJsM+8ZQ6+OGMJwkPHCrvhNz3sLsxd5SUGEg0Qelpb+D1NFIluEDOWs9uYCGQFHuKdW0BK8GKaDdTunnP9Wx4iaPIRttiymdUDCmADD4GYgOz/MbgJgZyDvexpUJzBYmxHTgmbdIYDcOlvRhjA0/MgCaGdMino47NGy723ob2nRR5y78QIiQbngIyUPr4/y45TGobIdfNLpPlJoBoEJUzcKhFPAS5X6QDpDYQUY4UOFMJrbLoPc7Efd32VmlvVu/PwAnvdDZqJD0yG1W2EkjE2KI/Y+MCuSS7GKeWCuxsWxvPXgBiVbICvTzjiHxqsTFi5Tipz+sH4OpDGJEPo7Zhn+O3oGcZzKxP0A0WNTEtj1iIyxdTOYpCp+DHqIJbJfDjOK29GM4HV1Hw1eJTTii5Bl8jwMV8nU0irLkNxFphO+4khQIwq19JEcZAEnOW5fGpR+Dir0eH42dvLbNT+LC36GJnjHLBQymRR0gRwaN7nD5Ir6/oIthYW/7Db56QpH0tnhIp4KJTpnRfjeNP5GFPJPswLTSe5yZQP7U9hMI4F9BEtCMLh76H/2d8vjZ6xMh3ufgb+UY0aFMvk7ravAw1NXW3pdVqvCOuNhgW9KGEISXB8iRaHY8ORLc0lDz1QTar2iURRAD8AmbebM4yH0Mn+NruX1TLDTUaqpsbtJnI0EXGl0s6n2UmsRe7e7PoTqud8HawhiRo4G9gVzNWCqdW9jir4NFnnDBo53nmj/Q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(36840700001)(40470700004)(82740400003)(5660300002)(8676002)(36756003)(356005)(6916009)(4326008)(316002)(70586007)(70206006)(86362001)(36860700001)(81166007)(41300700001)(83380400001)(6666004)(8936002)(7696005)(26005)(16526019)(478600001)(54906003)(47076005)(40480700001)(44832011)(40460700003)(186003)(1076003)(2616005)(426003)(336012)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:09.2854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5338b923-0a40-48f1-7acb-08da89cb1d9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3156
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
 4 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index fc4362506119..254434371951 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1495,6 +1495,8 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	else
 		dqm->xgmi_sdma_bitmap = (BIT_ULL(num_xgmi_sdma_queues) - 1);
 
+	dqm->trap_debug_vmid = 0;
+
 	INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
 
 	if (dqm->dev->kfd2kgd->get_iq_wait_times)
@@ -1936,8 +1938,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 		if (!dqm->dev->shared_resources.enable_mes) {
 			decrement_queue_count(dqm, qpd, q);
 			retval = execute_queues_cpsch(dqm,
-						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
-						      USE_DEFAULT_GRACE_PERIOD);
+						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
 			if (retval == -ETIME)
 				qpd->reset_wavefronts = true;
 		} else {
@@ -2466,6 +2467,98 @@ static void kfd_process_hw_exception(struct work_struct *work)
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
@@ -2566,8 +2659,8 @@ int dqm_debugfs_hang_hws(struct device_queue_manager *dqm)
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


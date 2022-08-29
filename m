Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E73ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C6410F317;
	Mon, 29 Aug 2022 14:30:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F3E10F300
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn1Th2fjbukxHbcnqq/oTYVV235blpU4VPSHLEkG8Dz8NM9/rUcUG3UQzPIGY4PgD4pOfG2f1BHBXRSCuBbgO8mxXMojMSwKfUdFCHAEwt664dA1Jgq57JodE+5Y+MIAaoLIIwYiY+O8oLxiY+nqvZa1Np7QCIO+bG+edWrsx9RhjLm3OzDxSVsYvSf3SW3cMPc98T60wzwK4diyhltXqk/efDAmvcn6MUc3Xn2UNxWBIUHt3tL43X8K2CXAsFdMQXPNTMp7hKJyKrQfcdQwxZYDqC8QQHMmv3OqXgrYEQK0aRgnTCy5Fmd5hYL0ODvmhq7yKNnx9AjH/2BX0wr3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTgMdkwfL6y+epxgaBYYTeebc/cCLAEWAJRFWTtmJ24=;
 b=Zln+mUORbWryXAttYQ0OWl9qbGjJOS28c5qjJLh7mRGpyNraBH+3YvUqiOf1BX5SWA/9hPh+nfZd8AAAGt+a0UpddGnpYeceJPUCRf39roFyRZQBGGZQLay3xPCs7j88XFwv/41I1b99VggAJ6uPUi3bCinolPNsFH/HGR2d5mSxlSDxhHSxFbNmEX9LmzU5M/EiYRGIBUkeRB4863dyd1hLbN4yPifFpYOQ0EvvbFxbKjonJ0Mau3SGqIi06eTktg+GxUpDukibOvNxK2Hlpn+IP4/vd1EJDV3knpCZxd4p8eYgpwRGmOeUbo2XBGLxp3yOuRUidvVN/eHO2NRkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTgMdkwfL6y+epxgaBYYTeebc/cCLAEWAJRFWTtmJ24=;
 b=kj9TQznGLJLuVmKSBzsz3D9NZBJr6hk7rZpIT4wKUTSk0v8JP3vo85jmp97dZ81JxP6ijsGZi4KavlNlsTvPheNGWaR2CNiuN71W9bdOhS16CQm+xiq3IbiVV+jPqPMMIgtoQadauuG8pJHeg1IzXsW0YefBB5aWGgD60i+MeRI=
Received: from MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 14:30:49 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::42) by MW4PR04CA0110.outlook.office365.com
 (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Mon, 29 Aug 2022 14:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:30:48 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:43 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/29] drm/amdgpu: add gfx9.4.1 hw debug mode enable and
 disable calls
Date: Mon, 29 Aug 2022 10:30:04 -0400
Message-ID: <20220829143026.1509027-8-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a965b025-dae8-4f64-9f53-08da89cb1179
X-MS-TrafficTypeDiagnostic: DS0PR12MB6461:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFpSQvRM8XEQpeGZ5+LdqIfP+ywf9hCj7IWqGdwi2SD64QJbwPO1sSCZoSIOlZ29J2su98NXkNovpcx+5KkEn6lxzpfJoZEnwQZGb01CFDAo8DIr/DffsFcYYLX4Jo/9wdOESYpFPIkDQsgt58OntZQKehN+gD90jF93TnilIKytj08Rw36N2M2TaIc8qFEPlHeAMyMTdGnALUb1i7UgQ9Yl0pmiZ/Y1Mi2gExKSl3D9wTLIql86w95CZmLPTofhd9UcPf+gB6lUAr5bd/szuLb+RlmjIbH817fw1imvs+Tuv1Ec6xgqTWc8dRsbeySfkMS514aiTADbtpI6BZcDH3TcZaKOGIWlPNs8ITZqCA4MoL4NTD7e4VXpcqUNh26AN+ScoBPdif9ljOAgbgoaAu5iWgVoLe3TFt1YAKVbGurCb2ZKCORuDVslNos/r5PuwdhUwdFS84XTighFt4FMsJpvhfNC0xf1Dlcw8eaeQCpJi4Pbm1oRFPj98eWluSWdst67vsQPSXiXmXH7t2zGYODkpZUppswkG2b9D8E+AlIliisuOvnZnsDVc7LMsndS+mvSOVV8ibpYxWAiY8snOzWG4ZvWhcOSlP4ZhspgKbO4U8bb4uWvwu6guQvpZa0ABdj7lSIaECyWbFfXwKhTFEOU3+Ei3gs55rMg6wzmhrqoDrHLdO0m+l99ZVALnVqDUgc2tsBYPXhinTykAn5Hg4/zWqPMtc7bhDV1FJq40ecos6upH9RHVlTMHaY5CvWK9pmGXxM45ASAkhBC0WBuE7GMshVnuNhkfMTU8MAJaYghUdwGaAFBc+tHU/Dm1eZT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(40470700004)(46966006)(356005)(26005)(41300700001)(7696005)(6666004)(86362001)(82310400005)(478600001)(40460700003)(36860700001)(426003)(47076005)(16526019)(336012)(186003)(1076003)(81166007)(2616005)(83380400001)(82740400003)(44832011)(2906002)(40480700001)(70206006)(5660300002)(36756003)(4326008)(8936002)(8676002)(70586007)(316002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:30:48.9177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a965b025-dae8-4f64-9f53-08da89cb1179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
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

On GFX9.4.1, the implicit wait count instruction on s_barrier is
disabled by default in the driver during normal operation for
performance requirements.

There is a hardware bug in GFX9.4.1 where if the implicit wait count
instruction after an s_barrier instruction is disabled, any wave that
hits an exception may step over the s_barrier when returning from the
trap handler with the barrier logic having no ability to be
aware of this, thereby causing other waves to wait at the barrier
indefinitely resulting in a shader hang.  This bug has been corrected
for GFX9.4.2 and onward.

Since the debugger subscribes to hardware exceptions, in order to avoid
this bug, the debugger must enable implicit wait count on s_barrier
for a debug session and disable it on detach.

In order to change this setting in the in the device global SQ_CONFIG
register, the GFX pipeline must be idle.  GFX9.4.1 as a compute device
will either dispatch work through the compute ring buffers used for
image post processing or through the hardware scheduler by the KFD.

Have the KGD suspend and drain the compute ring buffer, then suspend the
hardware scheduler and block any future KFD process job requests before
changing the implicit wait count setting.  Once set, resume all work.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 105 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
 4 files changed, 110 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 79bb6fd83094..ce53a0f9e0b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1036,6 +1036,9 @@ struct amdgpu_device {
 	struct pci_saved_state          *pci_state;
 	pci_channel_state_t		pci_channel_state;
 
+	/* Track auto wait count on s_barrier settings */
+	bool				barrier_has_auto_waitcnt;
+
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 4191af5a3f13..13f02a0aa828 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_arcturus.h"
+#include "amdgpu_reset.h"
 #include "sdma0/sdma0_4_2_2_offset.h"
 #include "sdma0/sdma0_4_2_2_sh_mask.h"
 #include "sdma1/sdma1_4_2_2_offset.h"
@@ -48,6 +49,8 @@
 #include "amdgpu_amdkfd_gfx_v9.h"
 #include "gfxhub_v1_0.h"
 #include "mmhub_v9_4.h"
+#include "gc/gc_9_0_offset.h"
+#include "gc/gc_9_0_sh_mask.h"
 
 #define HQD_N_REGS 56
 #define DUMP_REG(addr) do {				\
@@ -276,6 +279,104 @@ int kgd_arcturus_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
 	return 0;
 }
 
+/*
+ * Helper used to suspend/resume gfx pipe for image post process work to set
+ * barrier behaviour.
+ */
+static int suspend_resume_compute_scheduler(struct amdgpu_device *adev, bool suspend)
+{
+	int i, r = 0;
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
+
+		if (!(ring && ring->sched.thread))
+			continue;
+
+		/* stop secheduler and drain ring. */
+		if (suspend) {
+			drm_sched_stop(&ring->sched, NULL);
+			r = amdgpu_fence_wait_empty(ring);
+			if (r)
+				goto out;
+		} else {
+			drm_sched_start(&ring->sched, false);
+		}
+	}
+
+out:
+	/* return on resume or failure to drain rings. */
+	if (!suspend || r)
+		return r;
+
+	return amdgpu_device_ip_wait_for_idle(adev, GC_HWIP);
+}
+
+static void set_barrier_auto_waitcnt(struct amdgpu_device *adev, bool enable_waitcnt)
+{
+	uint32_t data;
+
+	WRITE_ONCE(adev->barrier_has_auto_waitcnt, enable_waitcnt);
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return;
+
+	amdgpu_amdkfd_suspend(adev, false);
+
+	if (suspend_resume_compute_scheduler(adev, true))
+		goto out;
+
+	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CONFIG));
+	data = REG_SET_FIELD(data, SQ_CONFIG, DISABLE_BARRIER_WAITCNT,
+						enable_waitcnt ? 0 : 1);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CONFIG), data);
+
+out:
+	suspend_resume_compute_scheduler(adev, false);
+
+	amdgpu_amdkfd_resume(adev, false);
+
+	up_read(&adev->reset_domain->sem);
+}
+
+static uint32_t kgd_arcturus_enable_debug_trap(struct amdgpu_device *adev,
+				bool restore_dbg_registers,
+				uint32_t vmid)
+{
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
+
+	set_barrier_auto_waitcnt(adev, true);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
+
+	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
+
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
+static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
+					bool keep_trap_enabled,
+					uint32_t vmid)
+{
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
+
+	set_barrier_auto_waitcnt(adev, false);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
+
+	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
+
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
 const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -294,6 +395,8 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base =
 				kgd_gfx_v9_set_vm_context_page_table_base,
+	.enable_debug_trap = kgd_arcturus_enable_debug_trap,
+	.disable_debug_trap = kgd_arcturus_disable_debug_trap,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4e9cbbab0fef..8763fd1a7381 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2602,8 +2602,8 @@ static void gfx_v9_0_init_sq_config(struct amdgpu_device *adev)
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 4, 1):
 		tmp = RREG32_SOC15(GC, 0, mmSQ_CONFIG);
-		tmp = REG_SET_FIELD(tmp, SQ_CONFIG,
-					DISABLE_BARRIER_WAITCNT, 1);
+		tmp = REG_SET_FIELD(tmp, SQ_CONFIG, DISABLE_BARRIER_WAITCNT,
+				READ_ONCE(adev->barrier_has_auto_waitcnt) ? 0 : 1);
 		WREG32_SOC15(GC, 0, mmSQ_CONFIG, tmp);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 751b9f8972f3..9e2a0615647f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1951,7 +1951,7 @@ void kfd_suspend_all_processes(void)
 	WARN(debug_evictions, "Evicting all processes");
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
 		cancel_delayed_work_sync(&p->eviction_work);
-		cancel_delayed_work_sync(&p->restore_work);
+		flush_delayed_work(&p->restore_work);
 
 		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA46C48BC1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF36112CAF;
	Tue,  6 Feb 2024 15:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wmY0nCRq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22158112CA2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhQWC5f+X+oq1HbmhWTfhXB8QcEiJ4K4F5D9Bpxd/mIWya6Nt6bsnnQfudOmhn5itUNsJSy6DaMFAPhIisW84VMVH6KEG0jOlTBl4uTPJkMjTd5QyCbPWi4Zv5WiPnGf5FTZURpIc2EdYjbzNhxsf8LyHAqSe1NVxK2hlOS+JAZZxtF/wtOCnNDZFT114rCY7el2dCWjCPzSF8Z7KzXjeHcpRfrMkd5KrTlhfWtnricBxVNSzkyBdQuw5duLrGHrnWSbBn9IloOWjeJlY1Q5BTNcdjuo+gPljDE8TbLgIgoSHO0SsyGgtCZWg3TXMiH/MFQ9pD0GXhydcBMx/JTvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGqhSL/S9Qlob3VVaMi875KTpuICsMjIC5dyVkpiAAM=;
 b=HXMHPIZEjorl954xMlyGSi4/iMezpTMkZfsvLOz2V+Xj2div7/OicilvM9+l4nEhB4BzRxbPgifhMSnfB87ij6uhmm+oXa3kXuz+wkidHntSMoL4a080pY0ymKaGmlUieBMyiAGH/bhX5rpC/eoZE7BqMKlY814SlLPTdUtkzjwXizNTE9BEjCAq4U5opZJuSCyU3CMsh1goHnf/1463oHG8Bcd3fIo1g14cHQYZNPnYu909ySGdOtvYE5jXVpSeNflAuFLPYCpeHxBRVz/wJMJ+rSOrZc1LflwVKBHbNkZgUx3G5PBHE1WDyK5dx//PFH7h7sV0iCpo4XEB1qNqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGqhSL/S9Qlob3VVaMi875KTpuICsMjIC5dyVkpiAAM=;
 b=wmY0nCRqzcG+hEhcYivDlQ585nBO9pq2RW1FwhCCAp9m9Rb15GbNX/zTs3Zuxcl4c/itUWP2lthd0QTjiuvNr+M/Gd8EybyTe934+aPuG9Y0UroyEahxNIq5qBlK30IP7QHxK3AZ/aD201dsOSCAZidqh3xc/hQGM6T+Y41xhJE=
Received: from SJ0PR03CA0216.namprd03.prod.outlook.com (2603:10b6:a03:39f::11)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 15:59:45 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::33) by SJ0PR03CA0216.outlook.office365.com
 (2603:10b6:a03:39f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:45 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:42 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>, "David
 Yat Sin" <David.YatSin@amd.com>
Subject: [PATCH v4 23/24] drm/amdkfd: Set debug trap bit when enabling PC
 Sampling
Date: Tue, 6 Feb 2024 10:59:19 -0500
Message-ID: <20240206155920.3171418-24-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1fade7-759d-430e-99dd-08dc272ca37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbx4FSNrOPg7or88OOi4wb0gYUa9RUDCi+Ihp68MbXKAZh0dD1qDBJB2zs6lUS9YXw7g/2X4TguUTu9uq+SXVxF7lbyL3PmxPci0MF6Xaf2I9t7aKLDTuZNkJz3h3FWJA/sUD6oR8dNdvZALxroTfOIjZn9E5AhW5LTtq2Xqk+W0G+8XGIMbsQWZrkm8BXd7+rvqEhYh4ZbheA+/O4UfvkQTStlxMQwg2zLqpnI5vVamzSovkji1tGVfEona5aXic7Rc6+K3sT3FfuW0rbXVq8qif5Bb8A1phji0vJAUN7DQSaEFPzNjVzLtcFpKENmmeafUCHY4Q8BJMYljMpnEAKYUA46p5wAMUpzUrufmSTCyXys/788Nme0ieoLXCWNMsoxPWKTmpSjz8k0OjaChuP/JDAy3jLykNQtn7kr6kMZo9+NMNyMe39/sXuwmfklcIFDA5S+UhLJcQN/+simfkcVjre+6KttV1Og4FoYrd8jnI8QKZMI7BKo9cTB/3PzZe+eJ6NprLAmlSjtYlrY+dPjcWC00XOgrlNwycHCKlsRlP24NkzpZWi8IPag59gBHMagmiCcwCWImJuoEotJz2fDXd6e3wpPHyIbSX2T75LUyhiGWNpn9+ECmJKcYddNpMkkyMadp1A773wCEmRpzwe534/p0um+BTRWCCc2f/IGvlMIMd/5sasx+g4b9s4Nn4yg1HypV+dOpmjYOKdmEYf48mYNc4Ku8Y77C6pLw3ZFTRY1FF1Gv/TEE+MlATdnSqQyu+HnpGH3/FwQpPEr9wA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(7696005)(26005)(8936002)(426003)(6666004)(47076005)(336012)(8676002)(2616005)(1076003)(16526019)(5660300002)(6916009)(4326008)(36756003)(2906002)(70206006)(54906003)(70586007)(316002)(41300700001)(86362001)(478600001)(81166007)(40480700001)(40460700003)(36860700001)(356005)(83380400001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:45.3479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1fade7-759d-430e-99dd-08dc272ca37d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
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

From: David Yat Sin <David.YatSin@amd.com>

We need the SPI_GDBG_PER_VMID_CNTL.TRAP_EN bit to be set during PC
Sampling so that the TTMP registers are valid inside the sampling data.
runtime_info.ttmp_setup will be cleared when the user application
does the AMDKFD_IOC_RUNTIME_ENABLE ioctl without
KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK flag on exit.

It is also not valid to have the debugger attached to a process while PC
sampling is enabled so adding some checks to prevent this.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 30 ++++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c       | 26 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h       |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 13 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  3 ++
 5 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d9cac97c54c0..bc37f3ee2c66 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2804,26 +2804,9 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 
 	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
 	p->runtime_info.r_debug = r_debug;
-	p->runtime_info.ttmp_setup = enable_ttmp_setup;
 
-	if (p->runtime_info.ttmp_setup) {
-		for (i = 0; i < p->n_pdds; i++) {
-			struct kfd_process_device *pdd = p->pdds[i];
-
-			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {
-				amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
-				pdd->dev->kfd2kgd->enable_debug_trap(
-						pdd->dev->adev,
-						true,
-						pdd->dev->vm_info.last_vmid_kfd);
-			} else if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
-				pdd->spi_dbg_override = pdd->dev->kfd2kgd->enable_debug_trap(
-						pdd->dev->adev,
-						false,
-						0);
-			}
-		}
-	}
+	if (enable_ttmp_setup)
+		kfd_dbg_enable_ttmp_setup(p);
 
 retry:
 	if (p->debug_trap_enabled) {
@@ -2972,10 +2955,10 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		goto out;
 	}
 
-	/* Check if target is still PTRACED. */
 	rcu_read_lock();
+	/* Check if target is still PTRACED. */
 	if (target != p && args->op != KFD_IOC_DBG_TRAP_DISABLE
-				&& ptrace_parent(target->lead_thread) != current) {
+			&& ptrace_parent(target->lead_thread) != current) {
 		pr_err("PID %i is not PTRACED and cannot be debugged\n", args->pid);
 		r = -EPERM;
 	}
@@ -2985,6 +2968,11 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		goto out;
 
 	mutex_lock(&target->mutex);
+	if (!!target->pc_sampling_ref) {
+		pr_debug("Cannot enable debug trap on PID:%d because PC Sampling active\n", args->pid);
+		r = -EBUSY;
+		goto unlock_out;
+	}
 
 	if (args->op != KFD_IOC_DBG_TRAP_ENABLE && !target->debug_trap_enabled) {
 		pr_err("PID %i not debug enabled for op %i\n", args->pid, args->op);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index d889e3545120..8d836c65c636 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1120,3 +1120,29 @@ void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 
 	mutex_unlock(&target->event_mutex);
 }
+
+void kfd_dbg_enable_ttmp_setup(struct kfd_process *p)
+{
+	int i;
+
+	if (p->runtime_info.ttmp_setup)
+		return;
+
+	p->runtime_info.ttmp_setup = true;
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {
+			amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
+			pdd->dev->kfd2kgd->enable_debug_trap(
+					pdd->dev->adev,
+					true,
+					pdd->dev->vm_info.last_vmid_kfd);
+		} else if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
+			pdd->spi_dbg_override = pdd->dev->kfd2kgd->enable_debug_trap(
+					pdd->dev->adev,
+					false,
+					0);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index fd0ff64d4184..d7ce0b119dd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -90,6 +90,9 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 
 void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 					uint64_t exception_set_mask);
+
+void kfd_dbg_enable_ttmp_setup(struct kfd_process *p);
+
 /*
  * If GFX off is enabled, chips that do not support RLC restore for the debug
  * registers will disable GFX off temporarily for the entire debug session.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 783844ddd82f..4777cfefbb08 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -24,6 +24,7 @@
 #include "kfd_priv.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_pc_sampling.h"
+#include "kfd_debug.h"
 #include "kfd_device_queue_manager.h"
 
 struct supported_pc_sample_info {
@@ -312,6 +313,14 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	pcs_entry->pdd = pdd;
 	user_args->trace_id = (uint32_t)i;
 
+	/*
+	 * Set SPI_GDBG_PER_VMID_CNTL.TRAP_EN so that TTMP registers are valid in the sampling data
+	 * p->runtime_info.ttmp_setup will be cleared when user application calls runtime_disable
+	 * on exit.
+	 */
+	kfd_dbg_enable_ttmp_setup(pdd->process);
+	pdd->process->pc_sampling_ref++;
+
 	pr_debug("alloc pcs_entry = %p, trace_id = 0x%x on gpu 0x%x", pcs_entry, i, pdd->dev->id);
 
 	return 0;
@@ -323,6 +332,7 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
 	pr_debug("free pcs_entry = %p, trace_id = 0x%x on gpu 0x%x",
 		pcs_entry, trace_id, pdd->dev->id);
 
+	pdd->process->pc_sampling_ref--;
 	mutex_lock(&pdd->dev->pcs_data.mutex);
 	pdd->dev->pcs_data.hosttrap_entry.base.use_count--;
 	idr_remove(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, trace_id);
@@ -381,6 +391,9 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (!pcs_entry ||
 			pcs_entry->pdd != pdd)
 			return -EINVAL;
+	} else if (pdd->process->debug_trap_enabled) {
+		pr_debug("Cannot have PC Sampling and debug trap simultaneously");
+		return -EBUSY;
 	}
 
 	switch (args->op) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 372727b5d945..cce99478118b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1021,6 +1021,9 @@ struct kfd_process {
 	struct semaphore runtime_enable_sema;
 	bool is_runtime_retry;
 	struct kfd_runtime_info runtime_info;
+
+	/* Indicates process' PC Sampling ref cnt*/
+	uint32_t pc_sampling_ref;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
-- 
2.25.1


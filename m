Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A61ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A396410E2ED;
	Mon, 31 Oct 2022 16:24:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E9610E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfeUKVRYyVpqQK3vZq3kOBEK96nD7LX8XkTtzotqlIy2DuFE5PLjrNsxabtr59ECoM8jAIYIuKvrJYV2ePXecPKbUwqoKREhZQ0B7yuJ9trCyIIi2LjHLJEO1D4+MXXfWdBpqxHAzcZUVzTzn9VNVCVREKbp6oLUkG5Iz2SWNw/Y444ovEmA2jAmoIUcPYuHSFwwskZa8JJpt0szo0yYSeah1XNbDhWt01tcRqrspkwM570YkIrcWDu/UfKnll0a+MlqgEG6XRGmhPoi04R1BopF4mZZuQQb3JSPquga/+VMdADS28qF/qcRM/WjVtO3vc1pVh/sU4YyTtWehZsTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjoBTxMI5efEfOdquhiS7hCvKeiockjzNDYlj6wr2I0=;
 b=kWs8CPFiORlPXUdA1oT2wu4sB2p/KyfmXGc9FS4D9nPBo/e3OAvqb35YDaDmcqRMWVod1Zb7tvjEAoGijkgz9Ud1sJ0SGj4VV0Z2hZrS0bSjSiKOu0kuc4xHA+SPoFzBNnSxGI7qNGUGdo0u9lyWqOj7eRdCI4wrG3MUW+X9y5MczupfAfhv5e7iqDATHQDdptu8J2ik1iWT/Te+s5QRKq4LzP1ByhNCzWHruUPNAQWn8xWG+TreWdRJp7NlQ9PMiSJ6llZQuuCFNdL2cYjPJVuECUAm7N2437fRS8YTlrjpcGvEt2YgR/zgnDtD7r1A/q+xJHenk/jPg3ZC/OsfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjoBTxMI5efEfOdquhiS7hCvKeiockjzNDYlj6wr2I0=;
 b=UwwuVe0yIs/8AQjY+cDBgfzltpccFWOZiYlMC9ygOftuFpeXRT+Oh51Wqxfp+jnuMHh5JHDFsJrpDF1BgXBhgOwAQKHhk88/+G6z1oDXFbLM7tJ5KD8AimeWrts2rjp7T+YP7gzO/9CZOOA3C/HLqSipF11p4fcaUOx1HKvEjXU=
Received: from MW4PR03CA0214.namprd03.prod.outlook.com (2603:10b6:303:b9::9)
 by CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 16:24:32 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::61) by MW4PR03CA0214.outlook.office365.com
 (2603:10b6:303:b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:31 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:27 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/29] drm/amdkfd: add runtime enable operation
Date: Mon, 31 Oct 2022 12:23:46 -0400
Message-ID: <20221031162359.445805-16-jonathan.kim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|CH2PR12MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e26e4b-0fb7-41ae-6424-08dabb5c642f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/IklrJrROofm8w/cyw02YEn2SfKeChOuziszapZVlYXCMmSkfUpTjG+r3cJ5m5e5FWKqbn9mEYCh0aak7mlI13bu7kwpghECWlEDM4gQVM9WJYPDl0LoF9f9pnUeH1bNE6eP5PumY7138x0F8LIIkK7+rYSDlZn/mfEQ7cbEH7HOEXyto/jqDP17vFwOp9KrIX9+1JwTc6jWdqFlbLBJH0dYkBnoJHRNpAM4cCuF+hFdjDwHbTnenLw74khmQVgB0pBKzAhuWHhGMdJAx6a0ty6xhJB4HUgbxNlcoVZ7bEF3A2zK+6l/CijODaYHFk3cVxesKRZfotgBsS1jPDHTB/q7p0rodCpQ8uqURltwIhJxzfhs6CO4tGyk3rY9cRPRBOENnfYs0M7ekkcHpf8QM6f8Q247xraBtr8BbqirZ12vhw1t0QLYHRw3Sv1r1ejVyOVDyijsLHDkmbhCxMsZiW2FSY0vsJqdS5Xqn2To1fawqW1oGcVdO+Px4pACV/SLXijT6c8AlDtfsFo2k676dUisG+2O9dhWMHut11D/Dp0+X1M3wkBl2LsIbHhnItNCvPWUtVWp5hltlXu9vrlTOaEbufeyo7bxPlwEADAkjf2PYOfiaESvmLudccNWvhNMzZ6JnbBFzHzsA0CmLE9Rmr1I94lfXoQVmZp1wk3K16T4hWs7hQEyI/6APukWrNv519fsUv+7QVCv7xXlcVuqD8STEEpwUT4oEyy7SN7+XSoBd+Qfbf60enu8LMpfHgVEh7VoPmqYH7AmTgL/kaO+2qJQFmSOpwQCnauLZHAv10CwDVpPS4nA+vRh+UKfW4ECg4Kh22zm0M6EogH/oyOpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(356005)(81166007)(82740400003)(70206006)(70586007)(4326008)(8676002)(41300700001)(82310400005)(6916009)(316002)(44832011)(36860700001)(40480700001)(86362001)(2616005)(8936002)(5660300002)(16526019)(426003)(36756003)(1076003)(186003)(47076005)(2906002)(336012)(83380400001)(6666004)(478600001)(7696005)(40460700003)(26005)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:31.6996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e26e4b-0fb7-41ae-6424-08dabb5c642f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
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

This operation coordinates the debugger with the target HSA runtime
process.

The main motive for this coordination is due to CP performance overhead
when enabling trap temporaries via SPI_GDBG_PER_VMID_CNTL.Trap_en.
This overhead is unacceptable for microbench performance in normal mode
for certain customers.

ROCr allows the user to bypass trap temporary setup through the
HSA_ENABLE_DEBUG environment variable.  As a result, the debugger has
to consider two scenarios.

For the first scenario, if the runtime enable of the target has already
occurred prior to the debugger attaching, then the debugger will go ahead
and setup the trap temporaries whether runtime has requested them or not.
The debugger will be able to query the runtime status on attach.

For the second scenario where the debugger spawns the target process,
it will have to wait for ROCr's runtime enable request from the target.
The runtime enable request will be able to see that it's process has been
debug attached.  It then enables the trap temporaries since it now
knows it's in debug mode, raises an EC_PROCESS_RUNTIME signal to the
debugger then waits for the debugger's response. Once the debugger has
received the runtime signal, it will wake the target process.

In addition there is an additional restriction that is required to be
enforced with runtime enable and HW debug mode setting.
The debugger must first ensure that HW debug mode has been enabled
before permitting HW debug mode operations.

With single process debug devices, allowing the debugger to set debug
HW modes prior to trap activation means that debug HW mode setting can
occur before the KFD has reserved the debug VMID (0xf) from the hardware
scheduler's VMID allocation resource pool.  This can result in the
hardware scheduler assigning VMID 0xf to a non-debugged process and
having that process inherit debug HW mode settings intended for the
debugged target process instead, which is both incorrect and potentially
fatal for normal mode operation.

With multi process debug devices, allowing the debugger to set debug
HW modes prior to trap activation means that non-debugged processes
migrating to a new VMID could inherit unintended debug settings.

All debug operations that touch HW settings must require trap activation
where trap activation is triggered by both debug attach and runtime
enablement (target has KFD opened and is ready to dispatch work).

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 144 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   1 +
 4 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 4b4c4200d8fb..27cd5af72521 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2655,11 +2655,141 @@ static int kfd_ioctl_criu(struct file *filep, struct kfd_process *p, void *data)
 	return ret;
 }
 
-static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, void *data)
+static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
+			bool enable_ttmp_setup)
 {
+	int i = 0, ret = 0;
+
+	if (p->is_runtime_retry)
+		goto retry;
+
+	if (p->runtime_info.runtime_state != DEBUG_RUNTIME_STATE_DISABLED)
+		return -EBUSY;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		if (pdd->qpd.queue_count)
+			return -EEXIST;
+	}
+
+	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
+	p->runtime_info.r_debug = r_debug;
+	p->runtime_info.ttmp_setup = enable_ttmp_setup;
+
+	if (p->runtime_info.ttmp_setup) {
+		for (i = 0; i < p->n_pdds; i++) {
+			struct kfd_process_device *pdd = p->pdds[i];
+
+			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {
+				amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
+				pdd->dev->kfd2kgd->enable_debug_trap(
+						pdd->dev->adev,
+						true,
+						pdd->dev->vm_info.last_vmid_kfd);
+			}
+
+			if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
+				pdd->spi_dbg_override = pdd->dev->kfd2kgd->enable_debug_trap(
+						pdd->dev->adev,
+						false,
+						pdd->dev->vm_info.last_vmid_kfd);
+
+				debug_refresh_runlist(pdd->dev->dqm);
+			}
+		}
+	}
+
+retry:
+	if (p->debug_trap_enabled) {
+		if (!p->is_runtime_retry) {
+			kfd_dbg_trap_activate(p);
+			kfd_dbg_ev_raise(KFD_EC_MASK(EC_PROCESS_RUNTIME),
+					p, NULL, 0, false, NULL, 0);
+		}
+
+		mutex_unlock(&p->mutex);
+		ret = down_interruptible(&p->runtime_enable_sema);
+		mutex_lock(&p->mutex);
+
+		p->is_runtime_retry = !!ret;
+	}
+
+	return ret;
+}
+
+static int runtime_disable(struct kfd_process *p)
+{
+	int i = 0, ret;
+	bool was_enabled = p->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED;
+
+	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_DISABLED;
+	p->runtime_info.r_debug = 0;
+
+	if (p->debug_trap_enabled) {
+		if (was_enabled)
+			kfd_dbg_trap_deactivate(p, false, 0);
+
+		if (!p->is_runtime_retry)
+			kfd_dbg_ev_raise(KFD_EC_MASK(EC_PROCESS_RUNTIME),
+					p, NULL, 0, false, NULL, 0);
+
+		mutex_unlock(&p->mutex);
+		ret = down_interruptible(&p->runtime_enable_sema);
+		mutex_lock(&p->mutex);
+
+		p->is_runtime_retry = !!ret;
+		if (ret)
+			return ret;
+	}
+
+	if (was_enabled && p->runtime_info.ttmp_setup) {
+		for (i = 0; i < p->n_pdds; i++) {
+			struct kfd_process_device *pdd = p->pdds[i];
+
+			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev))
+				amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
+		}
+	}
+
+	p->runtime_info.ttmp_setup = false;
+
+	/* disable DISPATCH_PTR save */
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
+			pdd->spi_dbg_override =
+					pdd->dev->kfd2kgd->disable_debug_trap(
+					pdd->dev->adev,
+					false,
+					pdd->dev->vm_info.last_vmid_kfd);
+
+			debug_refresh_runlist(pdd->dev->dqm);
+		}
+	}
+
 	return 0;
 }
 
+static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, void *data)
+{
+	struct kfd_ioctl_runtime_enable_args *args = data;
+	int r;
+
+	mutex_lock(&p->mutex);
+
+	if (args->mode_mask & KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK)
+		r = runtime_enable(p, args->r_debug,
+				!!(args->mode_mask & KFD_RUNTIME_ENABLE_MODE_TTMP_SAVE_MASK));
+	else
+		r = runtime_disable(p);
+
+	mutex_unlock(&p->mutex);
+
+	return r;
+}
+
 static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_dbg_trap_args *args = data;
@@ -2721,6 +2851,18 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		goto unlock_out;
 	}
 
+	if (target->runtime_info.runtime_state != DEBUG_RUNTIME_STATE_ENABLED &&
+			(args->op == KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE ||
+			 args->op == KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE ||
+			 args->op == KFD_IOC_DBG_TRAP_SUSPEND_QUEUES ||
+			 args->op == KFD_IOC_DBG_TRAP_RESUME_QUEUES ||
+			 args->op == KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH ||
+			 args->op == KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH ||
+			 args->op == KFD_IOC_DBG_TRAP_SET_FLAGS)) {
+		r = -EPERM;
+		goto unlock_out;
+	}
+
 	switch (args->op) {
 	case KFD_IOC_DBG_TRAP_ENABLE:
 		if (target != p)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 87a23b1d4d49..ae6e701a2656 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -176,7 +176,7 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
  *				to unwind
  *		else: ignored
  */
-static void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count)
+void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count)
 {
 	int i, count = 0;
 
@@ -238,7 +238,7 @@ int kfd_dbg_trap_disable(struct kfd_process *target)
 	return 0;
 }
 
-static int kfd_dbg_trap_activate(struct kfd_process *target)
+int kfd_dbg_trap_activate(struct kfd_process *target)
 {
 	int i, r = 0, unwind_count = 0;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 8aa52cc3af17..e31c9bb0e848 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -28,6 +28,8 @@
 void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
 					uint32_t vmid,
 					bool stall);
+void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count);
+int kfd_dbg_trap_activate(struct kfd_process *target);
 bool kfd_dbg_ev_raise(uint64_t event_mask,
 			struct kfd_process *process, struct kfd_dev *dev,
 			unsigned int source_id, bool use_worker,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b69f2f94a50e..9690a2adb9ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -943,6 +943,7 @@ struct kfd_process {
 
 	/* Tracks runtime enable status */
 	struct semaphore runtime_enable_sema;
+	bool is_runtime_retry;
 	struct kfd_runtime_info runtime_info;
 
 };
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3A3ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5A810F323;
	Mon, 29 Aug 2022 14:31:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0DF10F2F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5TTjvEq/445gmWhSc4UrlrAqlJnT6PHuy28LAkr/HRfzW5Lkh62tpqOboQWdSzfpLwbTSVblxvbXtZJ15HCdKai0JtH+uZi/QFLPMPuo/+7Dp6QUe52gjFRpJ793FANsc6Eu7RnrXeMaUt7cje14azy4rT8tO2GvVU6rS61WwPgndS7v0adAiFencsnPPY+I2fvt1vrqUr4WOJWte9uDSMKawRsrqoFzqcDISzDMWPtjDXDwN6t/SQPUePcL6tyouyySj7r9RFE4Y0VyiUOFsuGwA3d5BP3I+inDnWyLoprFhhRAVSbB6bp6IhQZ6K8FVrbm2M4wT/rFMZkAUiikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vw2QPY5XeEk4yiv72n44W9Jffh4ParlCHoDgzj/JxQ=;
 b=OKfM+0XhewVCkspA3mSFAK0F18oIUpPm5A/2rMFLHbB0Swe38lBslRqvyq+8pcXTVWouh17auY040jv6CC1qmUsaL1iHAf5/zJfA4dK92bpMVOT2VA5+lexBULAma2XdXEPWIPdoym5K3hILt5IbDa4wYZ6i+fLy1KvLVw29m6Jf/oHF2+1SHCul2kM7j3d7dW6OAR/XLr0iuU2zxQ3z4R5IKIGMiW3SdpQ6Fh0h05WaZM026iOWtuRRWTNhLMuMN4cJluhTb74YflL2Gi4wLT5ZFNEeGxmtm7V85t94jE1kfKdFDd27SQdEQ81J5+hmuysVipKLdkeyK+xHT4Wn5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vw2QPY5XeEk4yiv72n44W9Jffh4ParlCHoDgzj/JxQ=;
 b=WLPR6KPvB1UcEFePgTFfOjuDlj5y+xQI/e80lXBVoid9xk+Bd0XHRfstG2NwvKrbRbyRydh48oJsM07zo9wAiDylxnqhR7ngWOWaWHOuYcQW6FN9iS2TC+HR4I6IpkRVaahJaXlQ05s0r40gwLP6upUUkg3KI6XRvOs5AkjrJ4M=
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by MN2PR12MB3533.namprd12.prod.outlook.com (2603:10b6:208:107::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 14:31:14 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::2) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:13 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:47 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/29] drm/amdkfd: add runtime enable operation
Date: Mon, 29 Aug 2022 10:30:13 -0400
Message-ID: <20220829143026.1509027-17-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a454a02-ef35-46c6-2e86-08da89cb2035
X-MS-TrafficTypeDiagnostic: MN2PR12MB3533:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+o2gFiy2cVQVMoPX9qu88RIrY4ysl0kV+KljvwCy3kXLbyiUdUfu5f0L8Vr09h3Fsipet1t7cRmT3wvJ7VMyGd+zzZAgj90JWBocANb7eKR17CqDjDtXkDsnibuolotZT0DIjY8ji8kiritV0x2gA6FZfsjT9rQRl2r3y+QGAWA9JA2ZXsfcGEoUyyUjOkqoXr2wvMvUOZCFOTuwimGVWJKeDvIUZX3MQapekA/O6bXOubSKq2hfbXghPJCmfoJ4RuabKRMQ7XI6ScvVDrNomdOwfVWCAgheIwLJPNKtY2Qtd0MnOnMN7KRpLk5ueTMxSjIEVwGfDnqY7aOLPbElu8eNzd0nFD1sS59y5cCV+2jvL4k6+DYBJs8sECUZsD5UvJ9njG5cTKPlCq8/dAs/PIbZIms5nBbgU1IYiIxH7yJGdt2YOBMr4bmYaGhpxZxGgxgZArlV5pAO+Tb8L0+EMQv9zP38ged7dXQijZg0BNJWGbux7nzbHIgGy/z65l8ihRcfePhb3FfCOuAMY/pkkv+d0CA7YMMzAKgagwCo+dc6d1gO/laRKfaHbVoy3YUfp1Z1CzQRIG78lwbfe1WkSC+xHcejko4FT6VoLQ81O8cMjK8yH5SvBJCm7pgXzL8Q19PYmU8ItvuoGAVSXu/Kh9xIEJkKyrH4RruMKjnzrq+3h0VRZp9VHuQBEjo0sap27IHftZPn9F4hpcM3zpkiKdjTXpW/aZYDweaoTlEq5a5Rx3yT2xPY3uxeTh7xruusO7x/bEX9QA6D06zCmQT1LhOxFp4jBJ2JEqTBXixThSu69R/zLKUPIhQUEfGOGHG2Y5J636Yk3ViNbHy0Eou8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(40470700004)(46966006)(70206006)(44832011)(8676002)(316002)(6916009)(54906003)(82310400005)(70586007)(40480700001)(40460700003)(36860700001)(8936002)(5660300002)(2906002)(356005)(81166007)(4326008)(82740400003)(36756003)(7696005)(6666004)(26005)(86362001)(478600001)(2616005)(16526019)(41300700001)(186003)(336012)(426003)(1076003)(83380400001)(47076005)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:13.6194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a454a02-ef35-46c6-2e86-08da89cb2035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3533
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
index 8e25f47d7028..166b671d20fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2625,11 +2625,141 @@ static int kfd_ioctl_criu(struct file *filep, struct kfd_process *p, void *data)
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
@@ -2690,6 +2820,18 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
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


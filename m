Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3D6C0502F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC7B10F32B;
	Mon, 29 Aug 2022 14:31:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDA910F2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEGiYrh/9/DwSdYavzwlIIz5lmjI0clvmlS0oTGJomymZfG8Sj6MbSI1h7rDmJ2zO/FlzS6sugi57H6yPEaA79PlAkix4tqFpgAcU6ajrTGi2dekm0koE8VwL2g8SsNQ+OQImQhEn16c+BwWJvs5sj5C9WjPgHukVND7h/zdQmzZdA7XhY2MOSwyRITQt496zay3cnTUIwUfrV1Ky/j1dkhIAHc6gij2UlrzKCMbQyN4SuRrvrCYnJ5Q6uW9bXxTl8mlWeKsmZb6I5OcmQHkwEg0yBAy4g318jIFU45E3jGmfOcbKceNjjo3gHtyg0Hs3yFfbCMoVzFjCs/yudr2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAAckY0SaFaNkzesPVAdC9tRpHzPuIQkZ1+OX2TVOhI=;
 b=Fm1VP7Uvpax0WuIO3lJrnvW46RVYLt1GnRYFBb/2MYXMV4TJu9DE7gU+0Oanc8vacy2nn1HiyZL8gMVi84eD15EjceuF4ejzqNI1xK3Qy9koGE7TLqN5s8w7feK+x8fKR4/r7D0dlNRCxp4KoRVPTW3pSMT5kDpcyPcZsI4xDUUX66RvaKAP7bp1QLONOD/JPttPRdXQXxzBnsgyUI8oeIgvNo8X4Up6yMb4amTWQotgL9xkMWLeSYLzx5Tzhk2qsZVlg5z7/D5zcYw2fZ/kYkZrN/XArWUV1IQdVXIYKUEhBZYcwASbHxJSjVewHTJxf2A8ohteEATEIMHbrV9FAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAAckY0SaFaNkzesPVAdC9tRpHzPuIQkZ1+OX2TVOhI=;
 b=EEfAlGwk9XZJpNCMshiHYQgoqjOEkbaQjOm0jeWaup44aJZqVS3/1Dva1GpLcP8vG9ipUSPi2s1KI7VAiNmJ79gcExtijaE2JGQN6ItuVZytWnEMGcWGS3gUOBzW3Nv3xnXaooKuPNn/9irvjfJMBOyvL41kelZBSpW4SZOsXhU=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by BY5PR12MB3891.namprd12.prod.outlook.com (2603:10b6:a03:1a3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Mon, 29 Aug
 2022 14:31:11 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::cf) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:11 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:46 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/29] drm/amdkfd: add per process hw trap enable and disable
 functions
Date: Mon, 29 Aug 2022 10:30:10 -0400
Message-ID: <20220829143026.1509027-14-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7421283c-23e1-483f-e2ff-08da89cb1ebe
X-MS-TrafficTypeDiagnostic: BY5PR12MB3891:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWVsBIZxAcr31q+shW//dJCPQskqUF+6soJeVvB26woAarMhwsfkFMTOBXC2Hkg61cGHA4B6bdxrxUu/fIRe0K95o/I5Q2z35V8+tV8Euj7xgaY0G99W/0Jfj6FtC8zQtQC8gpUNO85YhBbLmvFg8FhkiPqB3yoPAmk3vQvmhGP8FuZR9+ARaEdYBt69aq95IKoPIhVVCDZfeWH60atBM0MjYG6kGGWgYKNHNAWeAiQ8CTbM/7g3TMZr1gBJg0zhfaZcGO7ry/h57wa+jWiTVDC00Kfdm633N4PTEURNoyy4v1JxdNNCBwd+KiL+eLjhPBlb7C+nDLjjWqhWHCHPee4FgjRNx5a7UkK0WZx77/Yqan5V9anZ3MXZB+8tVZuBzQZQoPYrnLRZBAPcSnTCDeIuTdTZMqTN3W0CLIB5pzeF+G60EdNsG5eGtMDtW0kKx9TqziUIK4kQ4fS8dsSvU49P++FriWseJbVSdGMblhSiUZwtDMnNl3v6RDTiI+mCz22/Fsf0hTTvBBKQYGVda5ZMqTEtKjU4o79iuldhu4WvPk/tZHlOjJAwCxLTQuktrYZRrM9uy3kqHNanUrux1zFxDb5gxew4IqZMyeW0bLtN8fL91SLgqzGHUIBMuN20ALlmsp8Jt/SHUf9JSRnrxAsW66rBkNxTL5W/YxyAgn5bWpQeegiblW8qPz8drmw+ZHXg7OmcPO3q4BLNzd7xeQXxyFqdG2t1XZJOwr/seSSY87+ad4/VtrguOzDRb7kTJtD53vOgSIPN9EBPVy2CSDk/57Gc9IQuDul2pVaRKwQEoqgs/W/QPG1Rmaorgpyl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(40470700004)(36840700001)(46966006)(41300700001)(7696005)(26005)(478600001)(1076003)(6666004)(83380400001)(426003)(47076005)(186003)(336012)(16526019)(2906002)(2616005)(8936002)(44832011)(5660300002)(40460700003)(40480700001)(82310400005)(6916009)(316002)(54906003)(36756003)(4326008)(8676002)(70586007)(70206006)(356005)(30864003)(81166007)(86362001)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:11.1664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7421283c-23e1-483f-e2ff-08da89cb1ebe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3891
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

To enable HW debug mode per process, all devices must be debug enabled
successfully.  If a failure occures, rewind the enablement of debug mode
on the enabled devices.

A power management scenario that needs to be considered is HW
debug mode setting during GFXOFF.  During GFXOFF, these registers
will be unreachable so we have to transiently disable GFXOFF when
setting.  Also, some devices don't support the RLC save restore
function for these debug registers so we have to disable GFXOFF
completely during a debug session.

Cooperative launch also has debugging restriction based on FW bugs.
If such bugs exists, the debugger cannot attach to a process that uses GWS
resources nor can GWS resources be requested if a process is being
debugged.

Also multi-process debug devices can only enable trap temporaries based
on certain runtime scenerios, which will be explained when the
runtime enable functions are implemented in a follow up patch.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   5 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 134 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  23 +++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   9 ++
 5 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 9ecc93d5fbba..beb26c93d920 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1442,6 +1442,11 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
 		goto out_unlock;
 	}
 
+	if (!kfd_dbg_has_gws_support(dev) && p->debug_trap_enabled) {
+		retval = -EBUSY;
+		goto out_unlock;
+	}
+
 	retval = pqm_set_gws(&p->pqm, args->queue_id, args->num_gws ? dev->gws : NULL);
 	mutex_unlock(&p->mutex);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index f967f89903f7..f5a5d17cde14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -21,6 +21,7 @@
  */
 
 #include "kfd_debug.h"
+#include "kfd_device_queue_manager.h"
 #include <linux/file.h>
 
 void debug_event_write_work_handler(struct work_struct *work)
@@ -37,8 +38,59 @@ void debug_event_write_work_handler(struct work_struct *work)
 	kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
 }
 
+/* kfd_dbg_trap_deactivate:
+ *	target: target process
+ *	unwind: If this is unwinding a failed kfd_dbg_trap_enable()
+ *	unwind_count:
+ *		If unwind == true, how far down the pdd list we need
+ *				to unwind
+ *		else: ignored
+ */
+static void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count)
+{
+	int i, count = 0;
+
+	for (i = 0; i < target->n_pdds; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+
+		/* If this is an unwind, and we have unwound the required
+		 * enable calls on the pdd list, we need to stop now
+		 * otherwise we may mess up another debugger session.
+		 */
+		if (unwind && count == unwind_count)
+			break;
+
+		/* GFX off is already disabled by debug activate if not RLC restore supported. */
+		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
+			amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
+		pdd->spi_dbg_override =
+				pdd->dev->kfd2kgd->disable_debug_trap(
+				pdd->dev->adev,
+				target->runtime_info.ttmp_setup,
+				pdd->dev->vm_info.last_vmid_kfd);
+		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
+			amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
+
+		if (release_debug_trap_vmid(pdd->dev->dqm, &pdd->qpd))
+			pr_err("Failed to release debug vmid on [%i]\n", pdd->dev->id);
+
+		debug_refresh_runlist(pdd->dev->dqm);
+
+		count++;
+	}
+}
+
 int kfd_dbg_trap_disable(struct kfd_process *target)
 {
+	/*
+	 * Defer deactivation to runtime if runtime not enabled otherwise reset
+	 * attached running target runtime state to enable for re-attach.
+	 */
+	if (target->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED)
+		kfd_dbg_trap_deactivate(target, false, 0);
+	else if (target->runtime_info.runtime_state != DEBUG_RUNTIME_STATE_DISABLED)
+		target->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
+
 	fput(target->dbg_ev_file);
 	target->dbg_ev_file = NULL;
 
@@ -53,16 +105,88 @@ int kfd_dbg_trap_disable(struct kfd_process *target)
 	return 0;
 }
 
+static int kfd_dbg_trap_activate(struct kfd_process *target)
+{
+	int i, r = 0, unwind_count = 0;
+
+	for (i = 0; i < target->n_pdds; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+
+		if (!kfd_dbg_is_per_vmid_supported(pdd->dev)) {
+			r = reserve_debug_trap_vmid(pdd->dev->dqm, &pdd->qpd);
+
+			if (r) {
+				target->runtime_info.runtime_state = (r == -EBUSY) ?
+							DEBUG_RUNTIME_STATE_ENABLED_BUSY :
+							DEBUG_RUNTIME_STATE_ENABLED_ERROR;
+
+				goto unwind_err;
+			}
+		}
+
+		/* Disable GFX OFF to prevent garbage read/writes to debug registers.
+		 * If RLC restore of debug registers is not supported and runtime enable
+		 * hasn't done so already on ttmp setup request, restore the trap config registers.
+		 *
+		 * If RLC restore of debug registers is not supported, keep gfx off disabled for
+		 * the debug session.
+		 */
+		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
+		if (!(kfd_dbg_is_rlc_restore_supported(pdd->dev) ||
+						target->runtime_info.ttmp_setup))
+			pdd->dev->kfd2kgd->enable_debug_trap(pdd->dev->adev, true,
+								pdd->dev->vm_info.last_vmid_kfd);
+
+		pdd->spi_dbg_override = pdd->dev->kfd2kgd->enable_debug_trap(
+					pdd->dev->adev,
+					false,
+					pdd->dev->vm_info.last_vmid_kfd);
+
+		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
+			amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
+
+		r = debug_refresh_runlist(pdd->dev->dqm);
+		if (r) {
+			target->runtime_info.runtime_state =
+					DEBUG_RUNTIME_STATE_ENABLED_ERROR;
+			goto unwind_err;
+		}
+
+		/* Increment unwind_count as the last step */
+		unwind_count++;
+	}
+
+	return 0;
+
+unwind_err:
+	/* Enabling debug failed, we need to disable on
+	 * all GPUs so the enable is all or nothing.
+	 */
+	kfd_dbg_trap_deactivate(target, true, unwind_count);
+	return r;
+}
+
 int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 			void __user *runtime_info, uint32_t *runtime_size)
 {
 	struct file *f;
 	uint32_t copy_size;
-	int r = 0;
+	int i, r = 0;
 
 	if (target->debug_trap_enabled)
 		return -EINVAL;
 
+	/* Enable pre-checks */
+	for (i = 0; i < target->n_pdds; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+
+		if (!KFD_IS_SOC15(pdd->dev))
+			return -ENODEV;
+
+		if (!kfd_dbg_has_gws_support(pdd->dev) && pdd->qpd.num_gws)
+			return -EBUSY;
+	}
+
 	copy_size = min((size_t)(*runtime_size), sizeof(target->runtime_info));
 
 	f = fget(fd);
@@ -73,6 +197,10 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 
 	target->dbg_ev_file = f;
 
+	/* defer activation to runtime if not runtime enabled */
+	if (target->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED)
+		kfd_dbg_trap_activate(target);
+
 	/* We already hold the process reference but hold another one for the
 	 * debug session.
 	 */
@@ -82,8 +210,10 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 	if (target->debugger_process)
 		atomic_inc(&target->debugger_process->debugged_process_count);
 
-	if (copy_to_user(runtime_info, (void *)&target->runtime_info, copy_size))
+	if (copy_to_user(runtime_info, (void *)&target->runtime_info, copy_size)) {
+		kfd_dbg_trap_deactivate(target, false, 0);
 		r = -EFAULT;
+	}
 
 	*runtime_size = sizeof(target->runtime_info);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index b7ecd603f277..1053b7ca24c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -40,4 +40,27 @@ static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_dev *dev)
 
 void debug_event_write_work_handler(struct work_struct *work);
 
+/*
+ * If GFX off is enabled, chips that do not support RLC restore for the debug
+ * registers will disable GFX off temporarily for the entire debug session.
+ * See disable_on_trap_action_entry and enable_on_trap_action_exit for details.
+ */
+static inline bool kfd_dbg_is_rlc_restore_supported(struct kfd_dev *dev)
+{
+	return !(KFD_GC_VERSION(dev) == IP_VERSION(10, 1, 10) || /* Navi10 */
+		 KFD_GC_VERSION(dev) == IP_VERSION(10, 1, 1));	 /* Navi14 */
+}
+
+static inline bool kfd_dbg_has_gws_support(struct kfd_dev *dev)
+{
+	return ((KFD_GC_VERSION(dev) == IP_VERSION(9, 0, 1)
+			&& dev->mec2_fw_version >= 0x81b6) ||
+		(KFD_GC_VERSION(dev) >= IP_VERSION(9, 1, 0)
+			&& KFD_GC_VERSION(dev) <= IP_VERSION(9, 2, 2)
+			&& dev->mec2_fw_version >= 0x1b6) ||
+		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0)
+			&& dev->mec2_fw_version >= 0x1b6) ||
+		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)
+			&& dev->mec2_fw_version >= 0x30));
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 7c983f5f2d6e..cba9968adcd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -36,6 +36,7 @@
 #include "kfd_kernel_queue.h"
 #include "amdgpu_amdkfd.h"
 #include "mes_api_def.h"
+#include "kfd_debug.h"
 
 /* Size of the per-pipe EOP queue */
 #define CIK_HPD_EOP_BYTES_LOG2 11
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 2a38b3d8f8dc..c92da9b998d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1161,6 +1161,7 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 					struct mm_struct *mm)
 {
 	struct kfd_process *p;
+	int i;
 
 	/*
 	 * The kfd_process structure can not be free because the
@@ -1178,6 +1179,14 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
 
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		/* re-enable GFX OFF since runtime enable with ttmp setup disabled it. */
+		if (!kfd_dbg_is_rlc_restore_supported(pdd->dev) && p->runtime_info.ttmp_setup)
+			amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
+	}
+
 	if (p->debug_trap_enabled)
 		kfd_dbg_trap_disable(p);
 
-- 
2.25.1


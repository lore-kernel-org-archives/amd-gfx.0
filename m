Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF01ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AA3110F2FC;
	Mon, 29 Aug 2022 14:31:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5305710F2F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxppD15xs0FNxHcKIN2xQFtUKNLDMi7/B+vignz/tOO9Y6C1FoNRzFA0qba5EM4jd4n4T+Gk0og/+ML4SWoJOTymNQnBapexqW6nYEsjlXnSMtfHdMbAOGvml9xusai7PzIJAnhq3lZyUN6LGVE4l+eA2gsH6w/CHJ8lxMplz9g6fiIPrCzdoDLg8sfnMF3PNEIVT7rVKv5HFaeS6XlsxqiVCmdPTN2U3CVxOy8uAiPy39u1O0lyF76KaZdqH/unDONLLo0+W8d3J7+wbGnUhry4mr7Ry6Php2tIchgod4/Y8HMrCCi6SS0tpbp5V6POb4cvX/PjHgtXmunnvRWXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH0w0mgpl+x1XpgyYaBxQeaH5YjJqw8m8aBIf3ZUZsA=;
 b=NSdaxkkKBc337/byMDxqKfsvPdSeVBHXeVdQmlR/sNNi8lepqkIv/9egs+/Du6aLh4neGWv9JGpPq8756n2kjmBIg9c2Z9PvuJ8uJbkG15+tYrTECUvsq+1AwxI5LoVA4Oxgdmu5Qu26+yN68OenAe3FLqgVC/Zts0/c2GBF0Q4VfNdKmTdd/B9dGbS/pnrf5TDsyOsSagW2lUFBAklTWzbcBp71ElQdf0tAkpl4qSswFhuPcDvhWJEC96938gdQDlgf/+jZwOaLhY6yKFxQqjQkBAvX4gODLcp+1XJ180VWBGnswBdv49ubPIcztkRqshx8QlEtR7ZKOyhFe2qP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH0w0mgpl+x1XpgyYaBxQeaH5YjJqw8m8aBIf3ZUZsA=;
 b=1X3ZI9U2+WnpfN1T1/z+WCtv4ePug06nqOBxdx6GT6L3Es988KGgNFyF9QDjpvnTGxj1H7vufYurpLkhz/0RCWsC+7sYPZZJZPllHUYJtzQ7hjVN0tHaQgqFr+sMPwf9rs3qS40AGse0+wdAUqXqp9VMcC8iuIOx0c8TpASEknI=
Received: from MW4PR04CA0320.namprd04.prod.outlook.com (2603:10b6:303:82::25)
 by BN6PR12MB1732.namprd12.prod.outlook.com (2603:10b6:404:107::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 14:30:46 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::7c) by MW4PR04CA0320.outlook.office365.com
 (2603:10b6:303:82::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Mon, 29 Aug 2022 14:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:30:46 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:41 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/29] drm/amdkfd: prepare per-process debug enable and disable
Date: Mon, 29 Aug 2022 10:30:00 -0400
Message-ID: <20220829143026.1509027-4-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 054c1d55-66d1-4165-584b-08da89cb0fd0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1732:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdImsOwPfE/lqf6aRUp9jBTKPYPfIhHwyqd9CCTmWEFy0GHZ5YXOx7x4lCYqLZj+lsI+qTvTuwv8Zo9F/xFk7nv9IPRU8qSrXoVr5WMg+LBIMwdzARS9FqOnPMUjRNP67LnC9LVXJ/s4KdUv3lnjoLhFjz/UJLyjJYH9DQa94D9QK35UI9jDD5NGhVmOA0eox6OVRKZStW4W36349QJqThq129ZAfg4aK2cwj6pLkKBulyffaYCjWH+Kgr9u4ucq6bZrt7K50iym1rhmqWHewY3K+hmpqjT2E67/5MuyoiNiUasuDktT6UdXoDq0yxz7AHhfWudSZS210B0r2en7f24svJQs5XVtqZwehu4OKXm/5OnKiR5AgyWj25zr+rp0o9muS5Gn2w27CPQFPzsinN9NaDD4rPp49fNL0Kpv5BXiaXIRJrj//6fZwFWRC7/ncC5lqr7J4mZQ/7jOE0pE/ZEwDKbkt7KfDdqMS+Mo2d9+baqhqiggR2e4RyKNn6dUaase02ZdWl7e8YiouJh5syfudxDXztK6p2BleiEkbvMPm3ScJEc/4CY7xRFS0AU+B3VO/gYAqptXuKx+iHXHLhtVdbsyjm2Dz8YthMe4EVq6FlJtA9Amj8LNObMUpoSCZASi+u4Ji834dHlsGxRuYgbcCcl5F3jFytPAqyHMfSReEzBCvudp3M24fpYuAeUL5bcU4QR/CCxCq0Xp1QuQfGD3naYnc292yXt79VJXjIb5aNPDaAvBQ3u/Yasc4sBwZWi+6zQUS+QLxsLoG9NYvRpV8Sj5kQVM2+qPtJAkDpI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(40470700004)(46966006)(40480700001)(36860700001)(356005)(40460700003)(82740400003)(81166007)(54906003)(8676002)(4326008)(70206006)(70586007)(41300700001)(5660300002)(8936002)(478600001)(82310400005)(86362001)(45080400002)(316002)(6916009)(336012)(186003)(426003)(2616005)(47076005)(1076003)(16526019)(30864003)(7696005)(2906002)(6666004)(83380400001)(44832011)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:30:46.1306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 054c1d55-66d1-4165-584b-08da89cb0fd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1732
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

The ROCm debugger will attach to a process to debug by PTRACE and will
expect the KFD to prepare a process for the target PID, whether the
target PID has opened the KFD device or not.

This patch is to explicity handle this requirement.  Further HW mode
setting and runtime coordination requirements will be handled in
following patches.

In the case where the target process has not opened the KFD device,
a new KFD process must be created for the target PID.
The debugger as well as the target process for this case will have not
acquired any VMs so handle process restoration to correctly account for
this.

To coordinate with HSA runtime, the debugger must be aware of the target
process' runtime enablement status and will copy the runtime status
information into the debugged KFD process for later query.

On enablement, the debugger will subscribe to a set of exceptions where
each exception events will notify the debugger through a pollable FIFO
file descriptor that the debugger provides to the KFD to manage.
Some events will be synchronously raised while other are scheduled,
which is why a debug_event_workarea worker is initialized.

Finally on process termination of either the debugger or the target,
debugging must be disabled if it has not been done so.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile           |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 87 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 91 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        | 33 +++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 24 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 34 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 65 +++++++++----
 7 files changed, 308 insertions(+), 29 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_debug.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_debug.h

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index e758c2a24cd0..747754428073 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -55,7 +55,8 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_int_process_v9.o \
 		$(AMDKFD_PATH)/kfd_int_process_v11.o \
 		$(AMDKFD_PATH)/kfd_smi_events.o \
-		$(AMDKFD_PATH)/kfd_crat.o
+		$(AMDKFD_PATH)/kfd_crat.o \
+		$(AMDKFD_PATH)/kfd_debug.o
 
 ifneq ($(CONFIG_AMD_IOMMU_V2),)
 AMDKFD_FILES += $(AMDKFD_PATH)/kfd_iommu.o
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f6f4a348b94b..9ecc93d5fbba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -44,6 +44,7 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_smi_events.h"
 #include "amdgpu_dma_buf.h"
+#include "kfd_debug.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -142,10 +143,15 @@ static int kfd_open(struct inode *inode, struct file *filep)
 		return -EPERM;
 	}
 
-	process = kfd_create_process(filep);
+	process = kfd_create_process(current);
 	if (IS_ERR(process))
 		return PTR_ERR(process);
 
+	if (kfd_process_init_cwsr_apu(process, filep)) {
+		kfd_unref_process(process);
+		return -EFAULT;
+	}
+
 	if (kfd_is_locked()) {
 		dev_dbg(kfd_device, "kfd is locked!\n"
 				"process %d unreferenced", process->pasid);
@@ -2622,6 +2628,9 @@ static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, v
 static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_dbg_trap_args *args = data;
+	struct task_struct *thread = NULL;
+	struct pid *pid = NULL;
+	struct kfd_process *target = NULL;
 	int r = 0;
 
 	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
@@ -2629,9 +2638,70 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		return -EINVAL;
 	}
 
+	pid = find_get_pid(args->pid);
+	if (!pid) {
+		pr_debug("Cannot find pid info for %i\n", args->pid);
+		r = -ESRCH;
+		goto out;
+	}
+
+	thread = get_pid_task(pid, PIDTYPE_PID);
+
+	if (args->op == KFD_IOC_DBG_TRAP_ENABLE) {
+		bool create_process;
+
+		rcu_read_lock();
+		create_process = thread && thread != current && ptrace_parent(thread) == current;
+		rcu_read_unlock();
+
+		target = create_process ? kfd_create_process(thread) :
+					kfd_lookup_process_by_pid(pid);
+	} else {
+		target = kfd_lookup_process_by_pid(pid);
+	}
+
+	if (!target) {
+		pr_debug("Cannot find process PID %i to debug\n", args->pid);
+		r = -ESRCH;
+		goto out;
+	}
+
+	/* Check if target is still PTRACED. */
+	rcu_read_lock();
+	if (target != p && ptrace_parent(target->lead_thread) != current) {
+		pr_err("PID %i is not PTRACED and cannot be debugged\n", args->pid);
+		r = -ESRCH;
+	}
+	rcu_read_unlock();
+
+	if (r)
+		goto out;
+
+	mutex_lock(&target->mutex);
+
+	if (args->op != KFD_IOC_DBG_TRAP_ENABLE && !target->debug_trap_enabled) {
+		pr_err("PID %i not debug enabled for op %i\n", args->pid, args->op);
+		r = -EPERM;
+		goto unlock_out;
+	}
+
 	switch (args->op) {
 	case KFD_IOC_DBG_TRAP_ENABLE:
+		if (target != p)
+			target->debugger_process = p;
+
+		r = kfd_dbg_trap_enable(target,
+					args->enable.dbg_fd,
+					(void __user *)args->enable.rinfo_ptr,
+					&args->enable.rinfo_size);
+		if (!r)
+			target->exception_enable_mask = args->enable.exception_mask;
+
+		pr_warn("Debug functions limited\n");
+		break;
 	case KFD_IOC_DBG_TRAP_DISABLE:
+		r = kfd_dbg_trap_disable(target);
+		break;
 	case KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT:
 	case KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED:
 	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE:
@@ -2645,7 +2715,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
 	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
 	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
-		pr_warn("Debugging not supported yet\n");
+		pr_warn("Debug op %i not supported yet\n", args->op);
 		r = -EPERM;
 		break;
 	default:
@@ -2653,6 +2723,19 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		r = -EINVAL;
 	}
 
+unlock_out:
+	mutex_unlock(&target->mutex);
+
+out:
+	if (thread)
+		put_task_struct(thread);
+
+	if (pid)
+		put_pid(pid);
+
+	if (target)
+		kfd_unref_process(target);
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
new file mode 100644
index 000000000000..f967f89903f7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "kfd_debug.h"
+#include <linux/file.h>
+
+void debug_event_write_work_handler(struct work_struct *work)
+{
+	struct kfd_process *process;
+
+	static const char write_data = '.';
+	loff_t pos = 0;
+
+	process = container_of(work,
+			struct kfd_process,
+			debug_event_workarea);
+
+	kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
+}
+
+int kfd_dbg_trap_disable(struct kfd_process *target)
+{
+	fput(target->dbg_ev_file);
+	target->dbg_ev_file = NULL;
+
+	if (target->debugger_process) {
+		atomic_dec(&target->debugger_process->debugged_process_count);
+		target->debugger_process = NULL;
+	}
+
+	target->debug_trap_enabled = false;
+	kfd_unref_process(target);
+
+	return 0;
+}
+
+int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
+			void __user *runtime_info, uint32_t *runtime_size)
+{
+	struct file *f;
+	uint32_t copy_size;
+	int r = 0;
+
+	if (target->debug_trap_enabled)
+		return -EINVAL;
+
+	copy_size = min((size_t)(*runtime_size), sizeof(target->runtime_info));
+
+	f = fget(fd);
+	if (!f) {
+		pr_err("Failed to get file for (%i)\n", fd);
+		return -EBADF;
+	}
+
+	target->dbg_ev_file = f;
+
+	/* We already hold the process reference but hold another one for the
+	 * debug session.
+	 */
+	kref_get(&target->ref);
+	target->debug_trap_enabled = true;
+
+	if (target->debugger_process)
+		atomic_inc(&target->debugger_process->debugged_process_count);
+
+	if (copy_to_user(runtime_info, (void *)&target->runtime_info, copy_size))
+		r = -EFAULT;
+
+	*runtime_size = sizeof(target->runtime_info);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
new file mode 100644
index 000000000000..b2217eb1399c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef KFD_DEBUG_EVENTS_H_INCLUDED
+#define KFD_DEBUG_EVENTS_H_INCLUDED
+
+#include "kfd_priv.h"
+
+int kfd_dbg_trap_disable(struct kfd_process *target);
+int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
+			void __user *runtime_info,
+			uint32_t *runtime_info_size);
+void debug_event_write_work_handler(struct work_struct *work);
+#endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e83725a28106..cfb08db293eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -977,6 +977,14 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		goto out;
 
 	pdd = qpd_to_pdd(qpd);
+
+	/* The debugger creates processes that temporarily have not acquired
+	 * all VMs for all devices and has no VMs itself.
+	 * Skip queue eviction on process eviction.
+	 */
+	if (!pdd->drm_priv)
+		goto out;
+
 	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
 			    pdd->process->pasid);
 
@@ -1098,13 +1106,10 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 {
 	struct queue *q;
 	struct kfd_process_device *pdd;
-	uint64_t pd_base;
 	uint64_t eviction_duration;
 	int retval = 0;
 
 	pdd = qpd_to_pdd(qpd);
-	/* Retrieve PD base */
-	pd_base = amdgpu_amdkfd_gpuvm_get_process_page_dir(pdd->drm_priv);
 
 	dqm_lock(dqm);
 	if (WARN_ON_ONCE(!qpd->evicted)) /* already restored, do nothing */
@@ -1114,12 +1119,19 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 		goto out;
 	}
 
+	/* The debugger creates processes that temporarily have not acquired
+	 * all VMs for all devices and has no VMs itself.
+	 * Skip queue restore on process restore.
+	 */
+	if (!pdd->drm_priv)
+		goto vm_not_acquired;
+
 	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
 			    pdd->process->pasid);
 
 	/* Update PD Base in QPD */
-	qpd->page_table_base = pd_base;
-	pr_debug("Updated PD address to 0x%llx\n", pd_base);
+	qpd->page_table_base = amdgpu_amdkfd_gpuvm_get_process_page_dir(pdd->drm_priv);
+	pr_debug("Updated PD address to 0x%llx\n", qpd->page_table_base);
 
 	/* activate all active queues on the qpd */
 	list_for_each_entry(q, &qpd->queues_list, list) {
@@ -1145,6 +1157,8 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 	qpd->evicted = 0;
 	eviction_duration = get_jiffies_64() - pdd->last_evict_timestamp;
 	atomic64_add(eviction_duration, &pdd->evict_duration_counter);
+vm_not_acquired:
+	qpd->evicted = 0;
 out:
 	dqm_unlock(dqm);
 	return retval;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index bf610e3b683b..3ea61fa1db52 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -886,19 +886,48 @@ struct kfd_process {
 	 */
 	unsigned long last_restore_timestamp;
 
+	/* Indicates device process is debug attached with reserved vmid. */
+	bool debug_trap_enabled;
+
+	/* per-process-per device debug event fd file */
+	struct file *dbg_ev_file;
+
+	/* If the process is a kfd debugger, we need to know so we can clean
+	 * up at exit time.  If a process enables debugging on itself, it does
+	 * its own clean-up, so we don't set the flag here.  We track this by
+	 * counting the number of processes this process is debugging.
+	 */
+	atomic_t debugged_process_count;
+
+	/* If the process is a debugged, this is the debugger process */
+	struct kfd_process *debugger_process;
+
 	/* Kobj for our procfs */
 	struct kobject *kobj;
 	struct kobject *kobj_queues;
 	struct attribute attr_pasid;
 
+	/* Keep track cwsr init */
+	bool has_cwsr;
+
+	/* Exception code enable mask and status */
+	uint64_t exception_enable_mask;
+
 	/* shared virtual memory registered by this process */
 	struct svm_range_list svms;
 
 	bool xnack_enabled;
 
+	/* Work area for debugger event writer worker. */
+	struct work_struct debug_event_workarea;
+
 	atomic_t poison;
 	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
 	bool queues_paused;
+
+	/* Tracks runtime enable status */
+	struct kfd_runtime_info runtime_info;
+
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
@@ -928,7 +957,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev);
 
 int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
-struct kfd_process *kfd_create_process(struct file *filep);
+struct kfd_process *kfd_create_process(struct task_struct *thread);
 struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
@@ -1055,6 +1084,9 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 				  uint64_t tba_addr,
 				  uint64_t tma_addr);
 
+/* CWSR initialization */
+int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
+
 /* CRIU */
 /*
  * Need to increment KFD_CRIU_PRIV_VERSION each time a change is made to any of the CRIU private
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6c83a519b3a1..751b9f8972f3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -44,6 +44,7 @@ struct mm_struct;
 #include "kfd_iommu.h"
 #include "kfd_svm.h"
 #include "kfd_smi_events.h"
+#include "kfd_debug.h"
 
 /*
  * List of struct kfd_process (field kfd_process).
@@ -69,7 +70,6 @@ static struct kfd_process *find_process(const struct task_struct *thread,
 					bool ref);
 static void kfd_process_ref_release(struct kref *ref);
 static struct kfd_process *create_process(const struct task_struct *thread);
-static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep);
 
 static void evict_process_worker(struct work_struct *work);
 static void restore_process_worker(struct work_struct *work);
@@ -798,18 +798,19 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 	kfd_process_free_gpuvm(qpd->ib_mem, pdd, qpd->ib_kaddr);
 }
 
-struct kfd_process *kfd_create_process(struct file *filep)
+struct kfd_process *kfd_create_process(struct task_struct *thread)
 {
 	struct kfd_process *process;
-	struct task_struct *thread = current;
 	int ret;
 
-	if (!thread->mm)
+	if (!(thread->mm && mmget_not_zero(thread->mm)))
 		return ERR_PTR(-EINVAL);
 
 	/* Only the pthreads threading model is supported. */
-	if (thread->group_leader->mm != thread->mm)
+	if (thread->group_leader->mm != thread->mm) {
+		mmput(thread->mm);
 		return ERR_PTR(-EINVAL);
+	}
 
 	/*
 	 * take kfd processes mutex before starting of process creation
@@ -827,10 +828,6 @@ struct kfd_process *kfd_create_process(struct file *filep)
 		if (IS_ERR(process))
 			goto out;
 
-		ret = kfd_process_init_cwsr_apu(process, filep);
-		if (ret)
-			goto out_destroy;
-
 		if (!procfs.kobj)
 			goto out;
 
@@ -864,16 +861,9 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	if (!IS_ERR(process))
 		kref_get(&process->ref);
 	mutex_unlock(&kfd_processes_mutex);
+	mmput(thread->mm);
 
 	return process;
-
-out_destroy:
-	hash_del_rcu(&process->kfd_processes);
-	mutex_unlock(&kfd_processes_mutex);
-	synchronize_srcu(&kfd_processes_srcu);
-	/* kfd_process_free_notifier will trigger the cleanup */
-	mmu_notifier_put(&process->mmu_notifier);
-	return ERR_PTR(ret);
 }
 
 struct kfd_process *kfd_get_process(const struct task_struct *thread)
@@ -1188,6 +1178,28 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
 
+	if (p->debug_trap_enabled)
+		kfd_dbg_trap_disable(p);
+
+	if (atomic_read(&p->debugged_process_count) > 0) {
+		struct kfd_process *target;
+		unsigned int temp;
+		int idx = srcu_read_lock(&kfd_processes_srcu);
+
+		hash_for_each_rcu(kfd_processes_table, temp, target, kfd_processes) {
+			if (target->debugger_process && target->debugger_process == p) {
+				mutex_lock_nested(&target->mutex, 1);
+				if (target->debug_trap_enabled)
+					kfd_dbg_trap_disable(target);
+				mutex_unlock(&target->mutex);
+				if (atomic_read(&p->debugged_process_count) == 0)
+					break;
+			}
+		}
+
+		srcu_read_unlock(&kfd_processes_srcu, idx);
+	}
+
 	/* Indicate to other users that MM is no longer valid */
 	p->mm = NULL;
 
@@ -1200,11 +1212,14 @@ static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
 	.free_notifier = kfd_process_free_notifier,
 };
 
-static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
+int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
 {
 	unsigned long  offset;
 	int i;
 
+	if (p->has_cwsr)
+		return 0;
+
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_dev *dev = p->pdds[i]->dev;
 		struct qcm_process_device *qpd = &p->pdds[i]->qpd;
@@ -1233,6 +1248,8 @@ static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
 			qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
 	}
 
+	p->has_cwsr = true;
+
 	return 0;
 }
 
@@ -1375,6 +1392,10 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	if (err)
 		goto err_event_init;
 	process->is_32bit_user_mode = in_compat_syscall();
+	process->debug_trap_enabled = false;
+	process->debugger_process = NULL;
+	process->exception_enable_mask = 0;
+	atomic_set(&process->debugged_process_count, 0);
 
 	process->pasid = kfd_pasid_alloc();
 	if (process->pasid == 0) {
@@ -1422,6 +1443,8 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	kfd_unref_process(process);
 	get_task_struct(process->lead_thread);
 
+	INIT_WORK(&process->debug_event_workarea, debug_event_write_work_handler);
+
 	return process;
 
 err_register_notifier:
@@ -1899,8 +1922,10 @@ static void restore_process_worker(struct work_struct *work)
 	 */
 
 	p->last_restore_timestamp = get_jiffies_64();
-	ret = amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
-						     &p->ef);
+	/* VMs may not have been acquired yet during debugging. */
+	if (p->kgd_process_info)
+		ret = amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
+							     &p->ef);
 	if (ret) {
 		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
 			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
-- 
2.25.1


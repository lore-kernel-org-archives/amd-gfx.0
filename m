Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D264C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 13:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8448D10E140;
	Tue, 15 Sep 2026 13:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="miK4nm4Y";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3948610E140
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 13:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4r1GPSCNQ+NG0VTmiAVh6TrvBYletPXP4rsItRLXWMYHKKsSL8ss5ryFDzqLD9fIdVRmyhXKClQIdoKJ4JfPYLLbi1EfmLCzyYoeNOEzMXFadouM64fqJafOZZrJiVEr/rp+MHNJClaAV0qLPopXvdELx/Pc6dg6v0lNMmP0k4zk9MLfnyzcCoIuBcpFoBKpG2vuMwWZ8NbKJIexeb1EcklK1eNrhSsQEauVHJbQ59Ili2MJkeJMZMjM6fnNg7gSSVijFsLL7ybCpNauZvg6B65ieHtXdapmQP2GjCMUevjrYgR9uDF9gPy7NFGvOVTRDoTDF4bF4zVWbURLV8o1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umE2l/i2WTCRu7uMS1FBmOoD0TpsySw11z0XAgFGe+0=;
 b=R6DzyKzzsL9Gq53aHGZ13+/5uyssu9CSIJbJkw1wyRlTYq/GEUK9IifnzPMea4xJVHsydsXtQYztjs4x+nr2IuHsVp2W/PX2cg3+oqhllH/aAIk4AkSWcVzolcCS9IWgRgJ6h5oBe57JG83We69yHT9EzKBn+hx8FfneetQOcwSSqgJqTP7OQ6MfyveMVy2ZqQbMduxzjjEzQX/2B6QKWEeNW0uqoa9xdUliiEu9JLojjB3vyEGtWt9bEKiIaJd95lD9QesU2QkQbunvGU7gUwXC/fcKnmrb3eQ5Zg+A75sdXyiqYshVhomvCzYwPoVxneYtM+eKyD36+9TdDpTuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umE2l/i2WTCRu7uMS1FBmOoD0TpsySw11z0XAgFGe+0=;
 b=miK4nm4YyyJqmoErmRkujPJcYldFTaBAd94ve5Bsr1+J7LMOHcnihwTruIsyHNW90eDRm9kGyATHyzJgPEZV2b9VmTN62drRmfscs0PVDiccN/SZhpuV+X6ETaxqkM6Cjf5pRT6cWHrWnF0bm5QqeoqThS9ksr9Z/IbVs9sBFoA=
Received: from CH0PR03CA0257.namprd03.prod.outlook.com (2603:10b6:610:e5::22)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 13:23:16 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::62) by CH0PR03CA0257.outlook.office365.com
 (2603:10b6:610:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 13:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 13:23:15 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 08:23:14 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
 <harish.kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>
Subject: [PATCH] drm/amdgpu: preempt KFD queues before taking the reset domain
 lock
Date: Tue, 15 Sep 2026 09:22:39 -0400
Message-ID: <20260915132239.1788233-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e1941d-9044-4218-b8b8-08df132c7fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Cs8vhpYUmNX0UhXGD6y18P90btKAuoFIhQrvANYCG0lwyyazNyziZc6Liba8Qzm41mKMYcyMmmsZTqYRyiDIGAz0yCwalkys5hAyQh7pWadmzYbd7wRoREFLsMAH7/e3T/Ti3A5nSzlZMrDODDHPVApJtDwfjmDHmYfAd6IO7YdqE+UBeYQSSZF+szEIWPbdaJFR/PSSoOT12jzyo7uqQ1C7Iqfk7HsIp7uEz7NQDjCYJ1eKPijcLktGQ+49hvGFLT9gNANl+6VXi/fouCQRiBtN93MtFNWVDg6V0Hj7eud0EIONEs/r7l/aYsYgH7u0vj/QLSWQSxwF41Rg698h8YRND5vPDwwXaqe16tZGwONkHOH+AQVZH+tXUgAT1mFWitfx5kpwjBBPa39uhye3XWSgK8NSvtx/3xP67b4n+Q0gb0/hSIpSPWaiHzn4yLFa2rnEkElzUDBHF1Ev2mLpC3PFdSw/MHQUGa4z9C65FfKFY9DPlpiHm56VeqbmlF4qNrev3fFD0Wjvdmm8WgAI7NJTvmLvLYt4gTGvhAqUPTPqCVSMk5Rx+h/pwojbIqtITXKakJtKojaUfwLcCQtUv/dy+IcdfpDQn4e8hHhp4zwno1rCW/cTqYRXokYRe053UMlQyUGbAW3Zu9NKOB0pAXiXF8cDF/tMhULMeSbRfDgicO0giB7+olxRNyk2sAseXaSfRTk7fsAK4ElMBMpUYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B8b5M2JggTfHXMBJTrye4NT8U2JG11wiWsJ0KNc/uZGiD3j1/mxYNB9w5jc5GRtFh2eRqWeEGSNbA6szLfWaVH4dUkwjrCtaQh7/SggOeRdB1AvjjZMY4nvm4rBTEtXjar+ENuFKAkphBCAW/b8PLVQxWORajSKwWp0hNPmeFwvpTZazLRIDAJIG4SLXOGL1krn9xwyCDQvKwF/k1XAqgeyu2Pb3rJKizPqQUpR6kO0JmyeJkQgF2w2sSI5kK4SL5TmWBLLUN7P6jp+cTC94YYQzzCgHxLLVj9D5qkkZWrBfEft5A2bMtkgLfE0x2y0yI+BCoyMrE0ajvbvk4KnBRR/OG4Z9gDJIHzpuk9Fr9Vr9ZGRjuxA/Ab+dkzNDaQU3a4HoWCV0dlwVh6wueyT1uwA8LsnwtGpMor6yTt8uyBdSwZTDwFCJjEoQoWzUbIIO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:23:15.1777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e1941d-9044-4218-b8b8-08df132c7fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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

A user-requested GPU reset issued while several processes are using
the device can Oops the host during munmap():

  amdgpu: Faulty UTCL2 client ID: SDMA1 (0x101)
  amdgpu: RW: 0x1
  BUG: unable to handle page fault for address: 00000000000132e8
  RIP: 0010:free_swap_cache+0x5/0xb0
   free_pages_and_swap_cache+0x3a/0x60
   tlb_batch_pages_flush+0x43/0x80
   zap_pte_range+0x80d/0xcd0
   unmap_page_range+0x2c6/0x4f0
   do_vmi_align_munmap+0x3e8/0x5b0
   __x64_sys_munmap+0x1b/0x30

amdgpu_device_gpu_recover() locks the reset domain before
amdgpu_device_halt_activities() reaches amdgpu_amdkfd_pre_reset().
amdgpu_device_lock_reset_domain() holds reset_domain->sem for write,
so the down_read_trylock() at the top of unmap_queues_cpsch() always
fails and it returns -EIO without ever sending the unmap packet.
stop_cpsch() still clears dqm->sched_running, so the driver believes
KFD scheduling has been stopped while the user queues are in fact
still on the hardware.

The application then takes its reset errors, exits, and munmap()
frees pages that an SDMA user queue is still writing into. That
corrupts the mm bookkeeping and faults on a bogus struct page.

Draining adev->sdma.instance[].ring does not cover this case. The
faulting engine runs in the process VMID and is fed by a user queue
that only the HWS can dequeue.

For a user-requested reset the GPU is still healthy and the queues
can be preempted normally, so quiesce KFD before the reset domain
lock is taken.

Only AMDGPU_RESET_SRC_USER is handled. A job timeout, an MES or HWS
failure and a frozen PCI link cannot preempt, so hang recovery is
left untouched rather than delayed. A RAS-triggered recovery can run
with the GPU still able to preempt; it is not covered here and needs
its own change.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 472e96ae884e..2a1243a2e578 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5308,6 +5308,30 @@ static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
 	}
 }
 
+/*
+ * unmap_queues_cpsch() needs reset_domain->sem for read, so KFD must be
+ * quiesced before amdgpu_device_lock_reset_domain() takes it for write.
+ * Otherwise the preemption silently fails and SDMA user queues keep running
+ * while userspace tears its address space down.
+ *
+ * This is restricted to a user-requested reset, where the GPU is known to be
+ * healthy and the queues can still be dequeued. Other sources are left alone:
+ * a job timeout, an MES or HWS failure and a frozen PCI link cannot preempt,
+ * and adding a preemption attempt there would only delay recovery.
+ */
+static void amdgpu_device_kfd_quiesce_pre_reset_lock(
+				struct amdgpu_reset_context *reset_context,
+				struct list_head *device_list)
+{
+	struct amdgpu_device *kfd_adev;
+
+	if (!reset_context || reset_context->src != AMDGPU_RESET_SRC_USER)
+		return;
+
+	list_for_each_entry(kfd_adev, device_list, reset_list)
+		amdgpu_amdkfd_suspend(kfd_adev, false);
+}
+
 static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *adev,
 						  struct list_head *device_list)
 {
@@ -5613,6 +5637,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Cannot be called after locking reset domain */
 	amdgpu_ras_pre_reset(adev, &device_list);
 
+	amdgpu_device_kfd_quiesce_pre_reset_lock(reset_context, &device_list);
+
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 
-- 
2.43.0


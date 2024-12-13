Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6ADE7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 20:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A6110F0CE;
	Fri, 13 Dec 2024 20:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oqzLz+oQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25FD610F0CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 20:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOceYsIq68UIkScOH99S6bysdmvPVOfys+lFYk0EhT/4e6G3uDkrWQSfIms0CwI3jo9S/ohMJFhOk/o4cBd84sxDME6gVcdRJa6oIMU1fhyK15fdtjnMqXDyyP4c67Rd8s0WxxWiQsSasftZIXSn3xSeMXTb+OCuOI3bjn2r/NeVoUy8d1QR2Rcq8sYTbdd+TK/FTF3TPeQ+kkwT9q6/QygGxJ7SlS3BnUUk4G6qaVAKR1cfjBR7T31FAPVdKrIvi6wKOGu+P+aJLDJbWZR+g9golE2DPdj0Ye9+n85AhQJwK8jj9sgNoW83z68Fg5IGh6BmOh+7UGH9uY3ZgmY7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOrdXYbEcV6lYlHld2k+jZHUOhpBb65HYoJDCyoabF0=;
 b=qin5IWB3W/TXoP6jx0WX23Ns2WhqzrlwlMsbt+pdJ1tEG2GEcJIbxqmb5Th5F/k+uw1/bBEE9rs83WVGbTMUjG+EUtegLuPspZmsMDy/8NPszMMHeVZWhPpnxeKgQYlM9xluZ1oa0qJ0l0Sn4BPPg273bxiSmC5JiXDqGy89JX7ioLTogKHD+evM9eBurfCqB0nph8VG0X0bcSNnH6bBuz5DxWfzrG8/K4Rp11Fnaz0ttSJsJwr8eKpVTv5EZlbiuryALuzagzjTJO9SmGFQKo+EGq9Ni0Xr3MMUNPcQDchzjw0AO++yUDEP6ZDxz60eFRzl/Z3cEGh3JCVRLhQbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOrdXYbEcV6lYlHld2k+jZHUOhpBb65HYoJDCyoabF0=;
 b=oqzLz+oQ+gqAQVLP0Yeg0ZXzmzO/CKv70ZHTxQmQLo3NSw9jH9fCKL4BIiocUOeenQyEGQoet4NaFsh7Q++E0RH4guxv3/bU26MOJI421c+330ysLmooRLrBG2HUViP1KcO2OsDs3OrzmdgLID6291S9pU5N8rYvOmQWQnUzBrU=
Received: from BN0PR04CA0195.namprd04.prod.outlook.com (2603:10b6:408:e9::20)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 20:34:07 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::f7) by BN0PR04CA0195.outlook.office365.com
 (2603:10b6:408:e9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 20:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Fri, 13 Dec 2024 20:34:06 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 14:34:05 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <jay.cornwall@amd.com>, <Hawking.Zhang@amd.com>, <flora.cui@amd.com>, "Philip
 Yang" <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: Optimize gfx v9 GPU page fault handling
Date: Fri, 13 Dec 2024 15:33:28 -0500
Message-ID: <20241213203332.18165-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213203332.18165-1-Philip.Yang@amd.com>
References: <20241213203332.18165-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 7912133e-275a-4d45-9111-08dd1bb57db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KQYN/w46ryhKvcjaJqtSfiHxHQZRF/u8zm3ybN0BjIhkO9RwT40oelFuginY?=
 =?us-ascii?Q?JIoQ5Apb86ilomFw6CfygUFh5G94ZuofbsR/CX3Zxemm+XEh2TmaUm61ExuI?=
 =?us-ascii?Q?bfv4lVOWT9tHIH0kefEDR9Q8i/vP5U51UTZ+vQtt6Rlk5GEcShxfIgY++mCo?=
 =?us-ascii?Q?b0yu3Hkd1Q8rrpDrgNcQIVIFosjgdUYjgP3zW6gFlm7fhU/3txarc4HulPel?=
 =?us-ascii?Q?8UZwbzYZNgfRKsp7zx3EXkT94LRGeaK8kJysp3ITKkOoMp87AcOgSeN8TJK2?=
 =?us-ascii?Q?yro7gyvuJdqHZAoM+FR580MSBGO2iX5UcFPvgfq1y5CEMDRs5JIs0EeeLrVZ?=
 =?us-ascii?Q?ILN5X4hhPE1e0Bt7o1M8N+3Bj6DU1wEx0KhP38zMVmFnEXuRhYIGZ56S5/s8?=
 =?us-ascii?Q?mjXWm+NBeVEM8aCMX4H1AbtC2qBHieP8dPvbL09YPXJq/ii52mlhYthoK39k?=
 =?us-ascii?Q?UZzSr0m6F6AbDs/6ZpPqBYxsslHDTG0lMHRB860vICYxoDGG+81Yh3qVQa92?=
 =?us-ascii?Q?On/XbS5t0zpQohJUXy+XRurkLeNaxZXqYdsIJRqhZBKZQPLPoJtbNqbXhZ+c?=
 =?us-ascii?Q?5Coc1LxKRfppinMndwiA5NIsNJpNZu0GbOp9UUETY4keJhM0pk0+AXFKAmMj?=
 =?us-ascii?Q?ovZSQsyNbN1vKcSVs7NgZTkBXCMAjs8Kexq5g+y7vEC3kyXWPuY7twP3oFf/?=
 =?us-ascii?Q?y0P8aIYJ6sL4IM1xEAY5qZnl01Gl2i8P6RpGd0sc1IdolyJfdmLbv7pbWJwj?=
 =?us-ascii?Q?GNsaxeQxbkhsSXHaOwJdCExW0eU+IW2KxbrUfn7YgiEjbnldk05T52nqXkzM?=
 =?us-ascii?Q?yz4iF+bh/2kDC73BjdYasnucmOoHOSZcBW3eD9BBMekS+xn5dUQG/hIQznWy?=
 =?us-ascii?Q?6gmZdZOfnrgPwEpF9AvMuIQ8jRMTo5V3nybYd0GE3BB0UWQ3GXI9Y8Vpxqyh?=
 =?us-ascii?Q?JeR1lSIaf7CiNp5fBi051cQ7yw8RkfIoJrEFJ/B08qiQ4J+NeUYC06VuI+5D?=
 =?us-ascii?Q?BaGWWaASlPQHSW2Q0CJO4iuXS7My7AFZ5icgVnwHJSFNmCu1r3uH6u2QRzys?=
 =?us-ascii?Q?RfMzF/rBatoiu9RUKe+ThuagfrKTkcqOKIjRyQOXxzHdgkXx8qlnUcBUk3IE?=
 =?us-ascii?Q?NOdFdxqW/ATtUVKnHbdyOJckFLAXB6v9299345q7mCaGiPgM5stIgGcN9ynS?=
 =?us-ascii?Q?Y8X/Rz0LYFVRlSU0+76CoMx3enWdxV66AF8GZqQayOypGtF4uvmJlLfIzpKe?=
 =?us-ascii?Q?PBqgi/2iamK5mWAZ8SjcqFAsxmTccuccmgpT51kkNV4pyDuwF+9BsP4siLlg?=
 =?us-ascii?Q?b2PJloRSDolYoSgN9GNt5eR3eLZvp1RtWkyALK0hUdJeumMA2MMWbvIQ+pNB?=
 =?us-ascii?Q?r0veRAOcM5hjarJ1mLZloaH9rEkbAv7v2RPKYVKJ3O7LO3b5RQ+90ZdEW+Zs?=
 =?us-ascii?Q?CQXLuBnf7risWX9XrtOeb2ap27eBaXcW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:34:06.8131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7912133e-275a-4d45-9111-08dd1bb57db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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

After GPU page fault, there are lots of page fault interrupts generated
at short period even with CAM filter enabled because the fault address
is different. Each page fault copy to KFD ih fifo to send event to user
space by KFD interrupt worker, this could cause KFD ih fifo overflow
while other processes generate events at same time.

KFD process is aborted after GPU page fault, we only need one GPU page
fault interrupt sent to KFD ih fifo to send memory exception event to
user space.

Incease KFD ih fifo size to 2 times of IH primary ring size, to handle
the burst events case.

This patch handle the gfx v9 path, cover retry on/off and CAM filter
on/off cases.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 10 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 67 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  3 +
 5 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4b80ad860639..6065ae83790f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -433,6 +433,9 @@ void kgd2kfd_unlock_kfd(void);
 int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
 int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
 bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id);
+bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entry *entry,
+			       bool retry_fault);
+
 #else
 static inline int kgd2kfd_init(void)
 {
@@ -518,5 +521,12 @@ static inline bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
 {
 	return false;
 }
+
+static bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entry *entry,
+				      bool retry_fault)
+{
+	return false;
+}
+
 #endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 48f1b9cf1f88..7f5aa1684533 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -64,6 +64,7 @@
 
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
+#include "kfd_priv.h"
 
 /* add these here since we already include dce12 headers and these are for DCN */
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x055d
@@ -623,6 +624,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		}
 	}
 
+	if (kgd2kfd_vmfault_fast_path(adev, entry, retry_fault))
+		return 1;
+
 	if (!printk_ratelimit())
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index ac0fdaa1ea23..9b49563f2c42 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1521,6 +1521,73 @@ bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
 	return kfd_compute_active(node);
 }
 
+/**
+ * kgd2kfd_vmfault_fast_path() - KFD vm page fault interrupt handling fast path for gmc v9
+ * @adev: amdgpu device
+ * @entry: vm fault interrupt vector
+ * @retry_fault: if this is retry fault
+ *
+ * retry fault -
+ *    with CAM enabled, adev primary ring
+ *                           |  gmc_v9_0_process_interrupt()
+ *                      adev soft_ring
+ *                           |  gmc_v9_0_process_interrupt() worker failed to recover page fault
+ *                      KFD node ih_fifo
+ *                           |  KFD interrupt_wq worker
+ *                      kfd_signal_vm_fault_event
+ *
+ *    without CAM,      adev primary ring1
+ *                           |  gmc_v9_0_process_interrupt worker failed to recvoer page fault
+ *                      KFD node ih_fifo
+ *                           |  KFD interrupt_wq worker
+ *                      kfd_signal_vm_fault_event
+ *
+ * no-retry fault -
+ *                      adev primary ring
+ *                           |  gmc_v9_0_process_interrupt()
+ *                      KFD node ih_fifo
+ *                           |  KFD interrupt_wq worker
+ *                      kfd_signal_vm_fault_event
+ *
+ * fast path - After kfd_signal_vm_fault_event, gmc_v9_0_process_interrupt drop the page fault
+ *            of same process, don't copy interrupt to KFD node ih_fifo.
+ *            With gdb debugger enabled, need convert the retry fault to no-retry fault for
+ *            debugger, cannot use the fast path.
+ *
+ * Return:
+ *   true - use the fast path to handle this fault
+ *   false - use normal path to handle it
+ */
+bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entry *entry,
+			       bool retry_fault)
+{
+	struct kfd_process *p;
+	u32 cam_index;
+
+	if (entry->ih == &adev->irq.ih_soft || entry->ih == &adev->irq.ih1) {
+		p = kfd_lookup_process_by_pasid(entry->pasid);
+		if (!p)
+			return true;
+
+		if (p->gpu_page_fault && !p->debug_trap_enabled) {
+			if (retry_fault && adev->irq.retry_cam_enabled) {
+				cam_index = entry->src_data[2] & 0x3ff;
+				WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
+			}
+
+			kfd_unref_process(p);
+			return true;
+		}
+
+		/*
+		 * This is the first page fault, set flag and then signal user space
+		 */
+		p->gpu_page_fault = true;
+		kfd_unref_process(p);
+	}
+	return false;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index e7412de9a0ac..8e00800f3207 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -46,7 +46,7 @@
 #include <linux/kfifo.h>
 #include "kfd_priv.h"
 
-#define KFD_IH_NUM_ENTRIES 8192
+#define KFD_IH_NUM_ENTRIES 16384
 
 static void interrupt_wq(struct work_struct *);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 800e4ae5b573..e529fdc1b422 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1003,6 +1003,9 @@ struct kfd_process {
 	struct semaphore runtime_enable_sema;
 	bool is_runtime_retry;
 	struct kfd_runtime_info runtime_info;
+
+	/* if gpu page fault sent to KFD */
+	bool gpu_page_fault;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
-- 
2.47.1


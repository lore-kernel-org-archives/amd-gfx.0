Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D47EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 16:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C0910EC12;
	Wed,  4 May 2022 16:19:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EAC10EC09
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 16:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVxZOpk8Nf02D0MdYiP6kNXtaSni0KjY0AF0V+ex8VRBSgSK9wZFoPY/kJk3BYiJ/lfouZCm+/4l15V4YCboV9oOMoCPgnh1rSlFUNwgH7hfoFiybzS4As6tPD0+EYLd6Cet6Qqm1vlZEy08k4lsKk8lep68WWkyBJT9QKene1tTuusZVo3H4fhIHePByZWkMmn6qCcuGXy6auOva31S1O7i1hskuKuV29uoZLf+jFjkUKPwVNybkUAabs2s2Y6bbyRNUf0kNWLLZhsjaT/RHhhDW+mTv11xoZilAZ+6J3JSbZpV4JYoq/fjW3u9cnbg9Kz09bfTh3bwJwIOJXFsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVDVPgvqXYKZ0kgRwCcY2RE59x05J8ijmNSba0AeZ/w=;
 b=P/PE59drSE52oOqcDbKx6tF3pHtHrxnUz+Bw2wvYnB2b6V5Bw2c+UjVYo/Bx1OZ89+45AvS8n2MUwYCWNIWbjfBHDAc2TK7RfK4iOWCFiqgReHhS+D2tCBv5ROdosnD6+JmCze2CuUopfsGT8melgRvnefUwBL6rJSg+rtkN/6OLf7AQV8EmVoiL9nPtAW3ydovRxaJ7et31o5WNmkZaWaI1N+uxVZlCjeWBr/BqZeED7i2YaqsF5j4BD9/dKuv6apVNupcL6zLRNUvyUb63vlyv7vDWv29IaFezegOGT101v4a4uj0AI0bO/5VLckXbBc1f5sB9C8rn42E4BaFSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVDVPgvqXYKZ0kgRwCcY2RE59x05J8ijmNSba0AeZ/w=;
 b=DZuQ8Oay1FcMfqIJymq7TN+7DnhnJJHXHvhFEmhUgzmrVgCZjTns6HJHQGGYMeUZhjTpW8J8FnBAEnw5d7qFk1Kgur38XN4fz5JPKslmsN83/LmAEmgSAOj7c0cVuzZriR3T6kekdipqE2+NNgXqAxLwil7uC6D1/oYSTvdX9M0=
Received: from MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35) by
 DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Wed, 4 May 2022 16:19:02 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::95) by MW2PR16CA0022.outlook.office365.com
 (2603:10b6:907::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Wed, 4 May 2022 16:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 16:19:02 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 4 May 2022 11:18:51 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Date: Wed, 4 May 2022 12:18:41 -0400
Message-ID: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b6f8ef1-af5b-4720-a601-08da2de9cd55
X-MS-TrafficTypeDiagnostic: DM4PR12MB6184:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB618425E84D01758FD1573796EAC39@DM4PR12MB6184.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dXZC3Pr3RMGJZJ+3FYEUh9iFbm+t/Kn06cpZGRFvDnqlSiWJ4KAU2ADhhxuiQGkI2qJn6PR/6LULDIpyjX8q6qxBEi6epqtmfzFzirbc60Dsrh2N/XLcuhlopK5D9k7JjRKlEvl+Zr5BaZB9CDOYjBgU2NO1niInNFxuXueoKvrACzO6ur6xAwVayhRd/RYptLZ1tMVgfPC8pz9GzJjrvJM+weNJGQQa5OsZD+y2VpjoGakkviXzGa2Xr4+P9+E+mIm1OW2BdviNrAbHlJKesyAIfDYXRwa+GJA2yNijUAtSBqIitxjmdsb592dJ6aTeAkHHY+iTJ6uzNsYGK7JbjyXy5tm3goSVsx6FsJFhjAUHyWvRZiRn3jw0EC7fHTxVm/ncQuHg10PL5EAc0JbqKP71CfEsdP9MfeES+SgC4/yhl0l+EDyYS20s/iQXk8YmfzFt0n3ua+SxRLO8D5IiajHNdpLn1A8f9rZASsELLuUwjUHeGHfA6xPpephTseTnia+/OpeTkCL0b6p1FI8z9mX7CKReFtOzABbvwVOfSMQoprgDe2zlrFBk/Q4wXoK00eTwnnioBAVe7glXTfFxbcAFkS4VvzDUJsOBszvKGgw7+tq6LOg3PAx+ilwamVcXtzdyyt4UkFGb4EANeJJqBhWem42VFk0c4np4hiJDNGN1evzc7S1vFHUHbAXBkQsL+vQZzhMXSKB0yDK03Wrsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(30864003)(356005)(54906003)(26005)(5660300002)(82310400005)(6916009)(7696005)(47076005)(81166007)(83380400001)(40460700003)(36756003)(8676002)(70586007)(70206006)(4326008)(86362001)(6666004)(44832011)(2906002)(336012)(36860700001)(508600001)(316002)(426003)(16526019)(186003)(2616005)(1076003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 16:19:02.0043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6f8ef1-af5b-4720-a601-08da2de9cd55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
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
Cc: Bai Zoy <Zoy.Bai@amd.com>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Problem:
During hive reset caused by command timing out on a ring
extra resets are generated by triggered by KFD which is
unable to accesses registers on the resetting ASIC.

Fix: Rework GPU reset to use a list of pending reset jobs
such that the first reset jobs that actaully resets the entire
reset domain will cancel all those pending redundant resets.

This is in line with what we already do for redundant TDRs
in scheduler code.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Tested-by: Bai Zoy <Zoy.Bai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 73 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  7 ++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  7 ++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  7 ++-
 8 files changed, 104 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4264abc5604d..99efd8317547 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -109,6 +109,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 
 #define MAX_GPU_INSTANCE		16
 
@@ -509,16 +510,6 @@ struct amdgpu_allowed_register_entry {
 	bool grbm_indexed;
 };
 
-enum amd_reset_method {
-	AMD_RESET_METHOD_NONE = -1,
-	AMD_RESET_METHOD_LEGACY = 0,
-	AMD_RESET_METHOD_MODE0,
-	AMD_RESET_METHOD_MODE1,
-	AMD_RESET_METHOD_MODE2,
-	AMD_RESET_METHOD_BACO,
-	AMD_RESET_METHOD_PCI,
-};
-
 struct amdgpu_video_codec_info {
 	u32 codec_type;
 	u32 max_width;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e582f1044c0f..7fa82269c30f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5201,6 +5201,12 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 	}
 
 	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
+
+	/* Drop all pending resets since we will reset now anyway */
+	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
+					    reset_list);
+	amdgpu_reset_pending_list(tmp_adev->reset_domain);
+
 	/* Actual ASIC resets if needed.*/
 	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
@@ -5296,7 +5302,7 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 }
 
 struct amdgpu_recover_work_struct {
-	struct work_struct base;
+	struct amdgpu_reset_work_struct base;
 	struct amdgpu_device *adev;
 	struct amdgpu_job *job;
 	int ret;
@@ -5304,7 +5310,7 @@ struct amdgpu_recover_work_struct {
 
 static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
 {
-	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base);
+	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base.base.work);
 
 	recover_work->ret = amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
 }
@@ -5316,12 +5322,15 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 {
 	struct amdgpu_recover_work_struct work = {.adev = adev, .job = job};
 
-	INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
+	INIT_DELAYED_WORK(&work.base.base, amdgpu_device_queue_gpu_recover_work);
+	INIT_LIST_HEAD(&work.base.node);
 
 	if (!amdgpu_reset_domain_schedule(adev->reset_domain, &work.base))
 		return -EAGAIN;
 
-	flush_work(&work.base);
+	flush_delayed_work(&work.base.base);
+
+	amdgpu_reset_domain_del_pendning_work(adev->reset_domain, &work.base);
 
 	return work.ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index c80af0889773..ffddd419c351 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -134,6 +134,9 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
 	atomic_set(&reset_domain->in_gpu_reset, 0);
 	init_rwsem(&reset_domain->sem);
 
+	INIT_LIST_HEAD(&reset_domain->pending_works);
+	mutex_init(&reset_domain->reset_lock);
+
 	return reset_domain;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 1949dbe28a86..863ec5720fc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -24,7 +24,18 @@
 #ifndef __AMDGPU_RESET_H__
 #define __AMDGPU_RESET_H__
 
-#include "amdgpu.h"
+
+#include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/kref.h>
+#include <linux/rwsem.h>
+#include <linux/workqueue.h>
+
+struct amdgpu_device;
+struct amdgpu_job;
+struct amdgpu_hive_info;
+
 
 enum AMDGPU_RESET_FLAGS {
 
@@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
 	AMDGPU_SKIP_HW_RESET = 1,
 };
 
+
+enum amd_reset_method {
+	AMD_RESET_METHOD_NONE = -1,
+	AMD_RESET_METHOD_LEGACY = 0,
+	AMD_RESET_METHOD_MODE0,
+	AMD_RESET_METHOD_MODE1,
+	AMD_RESET_METHOD_MODE2,
+	AMD_RESET_METHOD_BACO,
+	AMD_RESET_METHOD_PCI,
+};
+
 struct amdgpu_reset_context {
 	enum amd_reset_method method;
 	struct amdgpu_device *reset_req_dev;
@@ -40,6 +62,8 @@ struct amdgpu_reset_context {
 	unsigned long flags;
 };
 
+struct amdgpu_reset_control;
+
 struct amdgpu_reset_handler {
 	enum amd_reset_method reset_method;
 	struct list_head handler_list;
@@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
 	XGMI_HIVE
 };
 
+
+struct amdgpu_reset_work_struct {
+	struct delayed_work base;
+	struct list_head node;
+};
+
 struct amdgpu_reset_domain {
 	struct kref refcount;
 	struct workqueue_struct *wq;
 	enum amdgpu_reset_domain_type type;
 	struct rw_semaphore sem;
 	atomic_t in_gpu_reset;
+
+	struct list_head pending_works;
+	struct mutex reset_lock;
 };
 
 
@@ -113,9 +146,43 @@ static inline void amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
 }
 
 static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *domain,
-						struct work_struct *work)
+						struct amdgpu_reset_work_struct *work)
 {
-	return queue_work(domain->wq, work);
+	mutex_lock(&domain->reset_lock);
+
+	if (!queue_delayed_work(domain->wq, &work->base, 0)) {
+		mutex_unlock(&domain->reset_lock);
+		return false;
+	}
+
+	list_add_tail(&work->node, &domain->pending_works);
+	mutex_unlock(&domain->reset_lock);
+
+	return true;
+}
+
+static inline void amdgpu_reset_domain_del_pendning_work(struct amdgpu_reset_domain *domain,
+				  struct amdgpu_reset_work_struct *work)
+{
+	mutex_lock(&domain->reset_lock);
+	list_del_init(&work->node);
+	mutex_unlock(&domain->reset_lock);
+}
+
+static inline void amdgpu_reset_pending_list(struct amdgpu_reset_domain *domain)
+{
+	struct amdgpu_reset_work_struct *entry, *tmp;
+
+	mutex_lock(&domain->reset_lock);
+	list_for_each_entry_safe(entry, tmp, &domain->pending_works, node) {
+
+		list_del_init(&entry->node);
+
+		/* Stop any other related pending resets */
+		cancel_delayed_work(&entry->base);
+	}
+
+	mutex_unlock(&domain->reset_lock);
 }
 
 void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 239f232f9c02..574e870d3064 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -25,6 +25,7 @@
 #define AMDGPU_VIRT_H
 
 #include "amdgv_sriovmsg.h"
+#include "amdgpu_reset.h"
 
 #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is sr-iov ready */
 #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is enabled on this GPU */
@@ -230,7 +231,7 @@ struct amdgpu_virt {
 	uint32_t			reg_val_offs;
 	struct amdgpu_irq_src		ack_irq;
 	struct amdgpu_irq_src		rcv_irq;
-	struct work_struct		flr_work;
+	struct amdgpu_reset_work_struct flr_work;
 	struct amdgpu_mm_table		mm_table;
 	const struct amdgpu_virt_ops	*ops;
 	struct amdgpu_vf_error_buffer	vf_errors;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index b81acf59870c..f3d1c2be9292 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -251,7 +251,7 @@ static int xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
 
 static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work.base.work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
 
@@ -380,7 +380,8 @@ int xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev)
 		return r;
 	}
 
-	INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
+	INIT_DELAYED_WORK(&adev->virt.flr_work.base, xgpu_ai_mailbox_flr_work);
+	INIT_LIST_HEAD(&adev->virt.flr_work.node);
 
 	return 0;
 }
@@ -389,6 +390,8 @@ void xgpu_ai_mailbox_put_irq(struct amdgpu_device *adev)
 {
 	amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
 	amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
+
+	amdgpu_reset_domain_del_pendning_work(adev->reset_domain, &adev->virt.flr_work);
 }
 
 static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 22c10b97ea81..927b3d5bb1d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -275,7 +275,7 @@ static int xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
 
 static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work.base.work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
 
@@ -407,7 +407,8 @@ int xgpu_nv_mailbox_get_irq(struct amdgpu_device *adev)
 		return r;
 	}
 
-	INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
+	INIT_DELAYED_WORK(&adev->virt.flr_work.base, xgpu_nv_mailbox_flr_work);
+	INIT_LIST_HEAD(&adev->virt.flr_work.node);
 
 	return 0;
 }
@@ -416,6 +417,8 @@ void xgpu_nv_mailbox_put_irq(struct amdgpu_device *adev)
 {
 	amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
 	amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
+
+	amdgpu_reset_domain_del_pendning_work(adev->reset_domain, &adev->virt.flr_work);
 }
 
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 7b63d30b9b79..1d4ef5c70730 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -512,7 +512,7 @@ static int xgpu_vi_set_mailbox_ack_irq(struct amdgpu_device *adev,
 
 static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work.base.work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
 	/* wait until RCV_MSG become 3 */
@@ -610,7 +610,8 @@ int xgpu_vi_mailbox_get_irq(struct amdgpu_device *adev)
 		return r;
 	}
 
-	INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
+	INIT_DELAYED_WORK(&adev->virt.flr_work.base, xgpu_vi_mailbox_flr_work);
+	INIT_LIST_HEAD(&adev->virt.flr_work.node);
 
 	return 0;
 }
@@ -619,6 +620,8 @@ void xgpu_vi_mailbox_put_irq(struct amdgpu_device *adev)
 {
 	amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
 	amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
+
+	amdgpu_reset_domain_del_pendning_work(adev->reset_domain, &adev->virt.flr_work);
 }
 
 const struct amdgpu_virt_ops xgpu_vi_virt_ops = {
-- 
2.25.1


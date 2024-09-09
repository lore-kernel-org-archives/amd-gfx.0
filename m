Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4018ECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CEA10E68A;
	Mon,  9 Sep 2024 20:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tAMdUfT1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BEF310E696
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8QQdJj5K7j0OPDGmrkNsUrr/YDPAD3PuxGXpiaNoM5SxRGNeG5wD2/qqgwCrshnWbXiiWWo3oIoidERqZDS+OUcAMlKPCs5syAoEUSlB3STwKgGPbO8KG5xtUo1+ieLzMdERMcsspVr/JkQB0YqNt1/ej/ebtcoRpv6VDa/GOW92Ey4wjAnvlQ8EudQuMZbnlQCxW2cCkJbAuZvz60u6o+EOPd111LfH2bCFOBkMxe62pt70LKLoBYCrp2N2S/tHFDhFMJJR4r4xs2aJrJFSTnaYBobd/2oWqC67rlJH4c4A75zOxaIXw4b4AGFiai1sfQKeIuC4mhEiQ5K77Fk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdDeZEBO1jY18XhblSTsYlgNhXXLO+XVCVLb+cuPfN4=;
 b=Zl5UMshdETMA3XvRrtEbk0vcDiTnWIuOX7D3Vugkgnf6C2Eqq15T1e+JvKr/0rfe8NHWQ5cV6zkUSe+Yz6RVLRuqXH4E9GvkHZmGg9+lDTcuEP062fWOSdB3Y693q2T2hA8hj0UZh+gcJriKwCTfz9YjToTe9bW83BCp7vYnN13yRCmdTtiQPmzBcrOLPv5b6BKNkawdxKf/6XlXLAgFMBkynsr3w77U/DwRATEKOzYSifkC3NElanElhCTl+Vfjknd2KZWV9iqLAlE9hP92Puab0wQyri7twUrE69ouejgIS1NMRH3rKZgQS1GxWl4Uh273Au3s+m/5L+psuINAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdDeZEBO1jY18XhblSTsYlgNhXXLO+XVCVLb+cuPfN4=;
 b=tAMdUfT1PW1IHKbyckHpVMpBq+7miF8TrcRYeXIdpfj6pXtFgGIkybUg9dLECdQBARSAFaAA0bxpsAk17qvDgv7/o2i/rBdN1MpgPD8vuZ5jdT3VK+cEJLnG5qgIiVigZbArohhZAlR9Ywcd/IDVkIDikiRlg4CZzl2z1FEoUxI=
Received: from MW4PR03CA0316.namprd03.prod.outlook.com (2603:10b6:303:dd::21)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 20:07:24 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::16) by MW4PR03CA0316.outlook.office365.com
 (2603:10b6:303:dd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Mon, 9 Sep 2024 20:07:22 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:20 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v11 23/28] drm/amdgpu: suspend gfx userqueues
Date: Mon, 9 Sep 2024 22:06:09 +0200
Message-ID: <20240909200614.481-19-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dacb78-7f91-444d-1309-08dcd10b0431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iYQ14FWDbrr7Q2MA6KuhgfM+ucCxvd2m2nE7mqA73/nB+DuhwiIY1tLBeQcd?=
 =?us-ascii?Q?suDODUpi6hYaHxBsKUBIG6KzsPp4pKIEH+ljdII1Hj0vXtjgaDH2/MMTeRKD?=
 =?us-ascii?Q?eYt794MuTunP6SHbsIIzIgCvFvN07AgIDcWbdWSQ9YBFfMQM8wOLkhLh2VPh?=
 =?us-ascii?Q?YJ9CkS8XENHHUSqP66kuwil6/aPMcqH1GDgDx6FeG/7rC1k47b/72jhJTPPc?=
 =?us-ascii?Q?J0mqendKUD6R6bchA33miL5euJ8FuBLH6RmGiooK7FWQdJj/mprgbslCrx/D?=
 =?us-ascii?Q?17YPhWWvYfu1/Zi2C0cZeFABizNyMr5QwTmh4XRMlx3w1pilHS/fDB1hARpr?=
 =?us-ascii?Q?cr1m115BruTfhYCDl77kjf0Xodk0tKKMM9mK5Nz8jgPfojrzVoQ7tpzptewZ?=
 =?us-ascii?Q?gnT9exTCWlJPLvEFsz8HHj/7v/3ERnzKd1dam0nMMwjru46rcVQPfk4AzZsn?=
 =?us-ascii?Q?nEIYXejE+tuYifoXrU/phF2CkeVMMAyLG2T2Auzy9fomxKU0z+n6ZKGr/tgG?=
 =?us-ascii?Q?jeD5NObJKIUxW0HImjLqHatQU2KLC5YzaUkdw5rFIMFg4VtwV9FZmiR1dvQ/?=
 =?us-ascii?Q?QypIrmKk7/jsSqCb1zwHMVuix7gc9ov44KdQWRGuxMjVEdgFTZnuqRze6KvS?=
 =?us-ascii?Q?vIUvsK7g2XTrERD1rpjQrNR3JjQPJCEKuP1nqXrh4ZScUGpV9Wgawhlao79L?=
 =?us-ascii?Q?0yTmH1epgQsLImoqwsQgkgiEL3RdhPCFbACagxLC2sHJGNg0bCYs7VcmiMqY?=
 =?us-ascii?Q?L/2oc9Q9DbrZ73VQmVnR2hZZN6d4jOATSsxY1wSOxME82KdKWPnuOdVqNIax?=
 =?us-ascii?Q?Zkjvz0fSv83kyhGvE7jeKiaA57DrONpJ5PP/mubdJvI0sJ9oRRQSQnmAasBF?=
 =?us-ascii?Q?t3vxSRwloC5At5v3rXBWaVjgKu5avNRSzfByny31Z3TyABIyBElRrjXw9kvs?=
 =?us-ascii?Q?IXOt/cRBDQe5Uq12AcNKwljrl7Z/MNNlhAetRzmmM7Hrhtcez5SzJ7rmKpvw?=
 =?us-ascii?Q?JDge5AQXPo1Tg48dL95Z9iAXgvqjmcItWssPYw9VLtvezXeaVUm74pBLAPD3?=
 =?us-ascii?Q?BLlVQl04tVKeelGNZqUAXwZ+qCpJ8Q6/qYAssumu24U5L8V1W4QMCNAzM1Ro?=
 =?us-ascii?Q?IKfR8INkZGIXv6cXoY2OC629eAdAH7znIGvwoziQpoW4vDpoBE+HHAyplBXc?=
 =?us-ascii?Q?wnQDCeW3wML67xZSRyeUSuvDoq/dnKjYqGOQUpTnuAl+oueijttoz4xuQn8o?=
 =?us-ascii?Q?wFAbO8ULDmFPFY5NUO5Z7XpElGwxMZsz8pYFh/BGDbVf0bJSwNMhS0oUSk2m?=
 =?us-ascii?Q?9mWvPRcdQf18oQ8P5jb3/qKMBwiJzLgSZgk9cnQHKYCj0shB4Dx4AdbMN8C3?=
 =?us-ascii?Q?dAGkQWiSpw9Q0NX8x2/wKvUbGhK1idF4B3G4nczBngFvO/ODXMSncnwf+Mn2?=
 =?us-ascii?Q?QWQHcXkL1/yHfV5dxfrznrDMIU1tq2yT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:22.3375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dacb78-7f91-444d-1309-08dcd10b0431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
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

This patch adds suspend support for gfx userqueues. It typically does
the following:
- adds an enable_signaling function for the eviction fence, so that it
  can trigger the userqueue suspend,
- adds a delayed function for suspending the userqueues, to suspend all
  the queues under this userq manager and signals the eviction fence,
- adds reference of userq manager in the eviction fence container so
  that it can be used in the suspend function.

V2: Addressed Christian's review comments:
    - schedule suspend work immediately

V4: Addressed Christian's review comments:
    - wait for pending uq fences before starting suspend, added
      queue->last_fence for the same
    - accommodate ev_fence_mgr into existing code
    - some bug fixes and NULL checks

V5: Addressed Christian's review comments (gitlab)
    - Wait for eviction fence to get signaled in destroy, dont signal it
    - Wait for eviction fence to get signaled in replace fence, dont signal it

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Change-Id: Ib60a7feda5544e3badc87bd1a991931ee726ee82
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 149 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 100 ++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  10 ++
 6 files changed, 272 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 2d474cb11cf9..3d4fc704adb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -22,8 +22,12 @@
  *
  */
 #include <linux/sched.h>
+#include <drm/drm_exec.h>
 #include "amdgpu.h"
 
+#define work_to_evf_mgr(w, name) container_of(w, struct amdgpu_eviction_fence_mgr, name)
+#define evf_mgr_to_fpriv(e) container_of(e, struct amdgpu_fpriv, evf_mgr)
+
 static const char *
 amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
 {
@@ -39,10 +43,150 @@ amdgpu_eviction_fence_get_timeline_name(struct dma_fence *f)
 	return ef->timeline_name;
 }
 
+static void
+amdgpu_eviction_fence_update_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
+				   struct amdgpu_eviction_fence *new_ef)
+{
+	struct dma_fence *old_ef = &evf_mgr->ev_fence->base;
+
+	spin_lock(&evf_mgr->ev_fence_lock);
+	dma_fence_put(old_ef);
+	evf_mgr->ev_fence = new_ef;
+	spin_unlock(&evf_mgr->ev_fence_lock);
+}
+
+int
+amdgpu_eviction_fence_replace_fence(struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_eviction_fence *old_ef, *new_ef;
+	struct amdgpu_bo_va *bo_va, *tmp;
+	int ret;
+
+	old_ef = evf_mgr->ev_fence;
+	if (old_ef && !dma_fence_is_signaled(&old_ef->base)) {
+		DRM_DEBUG_DRIVER("Old EF not signaled yet\n");
+		dma_fence_wait(&old_ef->base, true);
+	}
+
+	new_ef = amdgpu_eviction_fence_create(evf_mgr);
+	if (!new_ef) {
+		DRM_ERROR("Failed to create new eviction fence\n");
+		return ret;
+	}
+
+	/* Replace fences and free old one */
+	amdgpu_eviction_fence_update_fence(evf_mgr, new_ef);
+
+	/* Attach new eviction fence to BOs */
+	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
+		struct amdgpu_bo *bo = bo_va->base.bo;
+
+		if (!bo)
+			continue;
+
+		/* Skip pinned BOs */
+		if (bo->tbo.pin_count)
+			continue;
+
+		ret = amdgpu_eviction_fence_attach(evf_mgr, bo);
+		if (ret) {
+			DRM_ERROR("Failed to attch new eviction fence\n");
+			goto free_err;
+		}
+	}
+
+	return 0;
+
+free_err:
+	kfree(new_ef);
+	return ret;
+}
+
+static void
+amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
+{
+	struct amdgpu_eviction_fence_mgr *evf_mgr = work_to_evf_mgr(work, suspend_work.work);
+	struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_bo_va *bo_va, *tmp;
+	struct drm_exec exec;
+	struct amdgpu_bo *bo;
+	int ret;
+
+	/* Signal old eviction fence */
+	ret = amdgpu_eviction_fence_signal(evf_mgr);
+	if (ret) {
+		DRM_ERROR("Failed to signal eviction fence err=%d\n", ret);
+		return;
+	}
+
+	/* Cleanup old eviction fence entry */
+	amdgpu_eviction_fence_destroy(evf_mgr);
+
+	/* Do not replace eviction fence is fd is getting closed */
+	if (evf_mgr->eviction_allowed)
+		return;
+
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		ret = amdgpu_vm_lock_pd(vm, &exec, 2);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret)) {
+			DRM_ERROR("Failed to lock PD\n");
+			goto unlock_drm;
+		}
+
+		/* Lock the done list */
+		list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
+			bo = bo_va->base.bo;
+			if (!bo) continue;
+
+			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(ret))
+				goto unlock_drm;
+		}
+	}
+	/* Replace old eviction fence with new one */
+	ret = amdgpu_eviction_fence_replace_fence(fpriv);
+	if (ret)
+		DRM_ERROR("Failed to replace eviction fence\n");
+unlock_drm:
+	drm_exec_fini(&exec);
+}
+
+static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
+{
+	struct amdgpu_eviction_fence_mgr *evf_mgr;
+	struct amdgpu_eviction_fence *ev_fence;
+	struct amdgpu_userq_mgr *uq_mgr;
+	struct amdgpu_fpriv *fpriv;
+
+	if (!f)
+		return true;
+
+	ev_fence = to_ev_fence(f);
+	uq_mgr = ev_fence->uq_mgr;
+	fpriv = uq_mgr_to_fpriv(uq_mgr);
+	evf_mgr = &fpriv->evf_mgr;
+
+	if (uq_mgr->num_userqs)
+		/* If userqueues are active, suspend userqueues */
+		schedule_delayed_work(&uq_mgr->suspend_work, 0);
+	else
+		/* Else just signal and replace eviction fence */
+		schedule_delayed_work(&evf_mgr->suspend_work, 0);
+
+	return true;
+}
+
 static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
 	.use_64bit_seqno = true,
 	.get_driver_name = amdgpu_eviction_fence_get_driver_name,
 	.get_timeline_name = amdgpu_eviction_fence_get_timeline_name,
+	.enable_signaling = amdgpu_eviction_fence_enable_signaling,
 };
 
 int amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr)
@@ -59,11 +203,14 @@ struct amdgpu_eviction_fence *
 amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	struct amdgpu_eviction_fence *ev_fence;
+	struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 
 	ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
 	if (!ev_fence)
 		return NULL;
 
+	ev_fence->uq_mgr = uq_mgr;
 	get_task_comm(ev_fence->timeline_name, current);
 	spin_lock_init(&ev_fence->lock);
 	dma_fence_init(&ev_fence->base, &amdgpu_eviction_fence_ops,
@@ -143,6 +290,8 @@ void amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
 		goto unlock;
 	}
 
+	INIT_DELAYED_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_worker);
+
 unlock:
 	spin_unlock(&evf_mgr->ev_fence_lock);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index b47ab1307ec5..712fabf09fc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -37,6 +37,8 @@ struct amdgpu_eviction_fence_mgr {
 	atomic_t		ev_fence_seq;
 	spinlock_t 		ev_fence_lock;
 	struct amdgpu_eviction_fence *ev_fence;
+	struct delayed_work	suspend_work;
+	bool eviction_allowed;
 };
 
 /* Eviction fence helper functions */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e7fb13e20197..88f3a885b1dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1434,6 +1434,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
 	struct amdgpu_bo_list *list;
 	struct amdgpu_bo *pd;
 	u32 pasid;
@@ -1466,6 +1467,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_bo_unreserve(pd);
 	}
 
+	evf_mgr->eviction_allowed = true;
 	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 614953b0fc19..4cf65aba9a9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -455,10 +455,18 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto exec_fini;
 
-	for (i = 0; i < num_bo_handles; i++)
+	/* Save the fence to wait for during suspend */
+	dma_fence_put(queue->last_fence);
+	queue->last_fence = dma_fence_get(fence);
+
+	for (i = 0; i < num_bo_handles; i++) {
+		if (!gobj || !gobj[i]->resv)
+			continue;
+
 		dma_resv_add_fence(gobj[i]->resv, fence,
 				   dma_resv_usage_rw(args->bo_flags &
 				   AMDGPU_USERQ_BO_WRITE));
+	}
 
 	/* Add the created fence to syncobj/BO's */
 	for (i = 0; i < num_syncobj_handles; i++)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index ba986d55ceeb..979174f80993 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -22,6 +22,7 @@
  *
  */
 #include <drm/drm_syncobj.h>
+#include <drm/drm_exec.h>
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
@@ -282,6 +283,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
+	uq_mgr->num_userqs--;
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
 }
@@ -369,6 +371,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 	args->out.queue_id = qid;
+	uq_mgr->num_userqs++;
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
@@ -402,12 +405,109 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+static int
+amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	int queue_id, ret;
+
+	userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
+
+	/* Suspend all the queues for this process */
+	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+		ret = userq_funcs->suspend(uq_mgr, queue);
+		if (ret)
+			DRM_ERROR("Failed to suspend queue\n");
+	}
+
+	return ret;
+}
+
+static int
+amdgpu_userqueue_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct amdgpu_usermode_queue *queue;
+	int queue_id, ret;
+
+	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+		struct dma_fence *f;
+		struct drm_exec exec;
+
+		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+		drm_exec_until_all_locked(&exec) {
+			f = queue->last_fence;
+			drm_exec_retry_on_contention(&exec);
+		}
+		drm_exec_fini(&exec);
+
+		if (!f || dma_fence_is_signaled(f))
+			continue;
+		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
+		if ( ret <= 0) {
+			DRM_ERROR("Timed out waiting for fence f=%p\n", f);
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+static void
+amdgpu_userqueue_suspend_worker(struct work_struct *work)
+{
+	int ret;
+	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, suspend_work.work);
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+
+	/* Wait for any pending userqueue fence to signal */
+	ret = amdgpu_userqueue_wait_for_signal(uq_mgr);
+	if (ret) {
+		DRM_ERROR("Not suspending userqueue, timeout waiting for work\n");
+		return;
+	}
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	ret = amdgpu_userqueue_suspend_all(uq_mgr);
+	if (ret) {
+		DRM_ERROR("Failed to evict userqueue\n");
+		goto unlock;
+	}
+
+	/* Signal current eviction fence */
+	ret = amdgpu_eviction_fence_signal(evf_mgr);
+	if (ret) {
+		DRM_ERROR("Can't signal eviction fence to suspend\n");
+		goto unlock;
+	}
+
+	/* Cleanup old eviction fence entry */
+	amdgpu_eviction_fence_destroy(evf_mgr);
+
+unlock:
+	mutex_unlock(&uq_mgr->userq_mutex);
+}
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
 {
+	struct amdgpu_fpriv *fpriv;
+
 	mutex_init(&userq_mgr->userq_mutex);
 	idr_init_base(&userq_mgr->userq_idr, 1);
 	userq_mgr->adev = adev;
+	userq_mgr->num_userqs = 0;
+
+	fpriv = uq_mgr_to_fpriv(userq_mgr);
+	if (!fpriv->evf_mgr.ev_fence) {
+		DRM_ERROR("Eviction fence not initialized yet\n");
+		return -EINVAL;
+	}
 
+	/* This reference is required for suspend work */
+	fpriv->evf_mgr.ev_fence->uq_mgr = userq_mgr;
+	INIT_DELAYED_WORK(&userq_mgr->suspend_work, amdgpu_userqueue_suspend_worker);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 37be29048f42..8b3b50fa8b5b 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -27,6 +27,10 @@
 
 #define AMDGPU_MAX_USERQ_COUNT 512
 
+#define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
+#define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
+#define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
+
 struct amdgpu_mqd_prop;
 
 struct amdgpu_userq_obj {
@@ -50,6 +54,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj wptr_obj;
 	struct xarray		uq_fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
+	struct dma_fence	*last_fence;
 };
 
 struct amdgpu_userq_funcs {
@@ -69,6 +74,9 @@ struct amdgpu_userq_mgr {
 	struct idr			userq_idr;
 	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
+
+	struct delayed_work		suspend_work;
+	int num_userqs;
 };
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
@@ -86,4 +94,6 @@ void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userqueue_update_bo_mapping(struct drm_file *filp, struct amdgpu_bo_va *bo_va,
 				       uint32_t operation, uint32_t syncobj_handle,
 				       uint64_t point);
+
+int amdgpu_userqueue_enable_signaling(struct dma_fence *f);
 #endif
-- 
2.45.1


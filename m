Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C56C982FA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C77C10EA45;
	Mon, 21 Sep 2026 20:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DW+4AF8u";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B3A610E986
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INtPeGV76N9vPaczLYU5ibXmB1mRr8pFnAXTf45duy8AhlQFzDKpbC72y7a0Mg8bnuZIAB4QcSerr1X5OcX22deEKC8My3D4nTtW64P5CBsb3VijlNwoUOcqgSXuglP8PsqF3OLEo4nzniyLdnjn2MZ/1dBsYlWIttQBZDkDYfIEsgN7kfMtU8nH9fGyLkQjzfobCxoBFYDo46UhX5ThO322B0xADNtyYAxHVVByj3TnfbMfGKxm9RZlFyYrK8eYzdOHrrU/TO4spgfKcpf8eeAre1QEUVwSKarFD90zkDxqydwYGd/PtzRk6u0J5jwfHXfaZcemgxTARbUHbjHusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zz4Gdtk2RuTkTFq6Vd8DXSF0DBeJIYO3j+L7bSBR6mQ=;
 b=bMDVTD637Ns2lpSD8SJEKNzp506vtNBpaihWtrxI0h2mQtEgsSSDqMaC1reAk9LU/760L7dfTEJRfAtOOWbHzosp2SfzLS3gJd8unu+6ubNvzpDI2OzIvGUy6z2IYzES1Dj4sTM4xse2xObYCRpwm1rR1/Im1f2YaLzztJgsO7NJAs0J0mxmritr7jYUmuC90ziehPnvJ1FZkHFdmTfqdxeV6GyEFdpPt7xvSDBuRER0cZUfYVIdgTtokHhjcmPj5Q5Uq2Ev4zssftF2AtVcalYomh4EE5kePcepeozUROaC0U743dLvpMa4mbSFobRTTBWy7OYpKXdvNHFyNG01pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zz4Gdtk2RuTkTFq6Vd8DXSF0DBeJIYO3j+L7bSBR6mQ=;
 b=DW+4AF8u3RxQSvdjMLYj4bacOGWN6goQ4uHtVCGhC06146Ddmu9f08iCtWyyn4Uh0IDhcHhsw011kuESohnBv+k/6Qv8HbAJ785zFT5axFlctlq27Sq58D6ucvkCskuJlWwwAP+hYtsICDTqM1XRC0kH9bPbHlJ9EECt5VYhXEY=
Received: from BN9PR03CA0218.namprd03.prod.outlook.com (2603:10b6:408:f8::13)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:27 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::3b) by BN9PR03CA0218.outlook.office365.com
 (2603:10b6:408:f8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:03:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:22 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:21 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 07/12] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_RELEASE
Date: Mon, 21 Sep 2026 16:03:08 -0400
Message-ID: <20260921200313.865829-7-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921200313.865829-1-James.Zhu@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b34300-2dea-4065-ba64-08df181b6477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Px+Ldds5Ura2aR9tcVvPxsreeEljCSdFzd5/uY640d9zv6n0qq9WJATchMjPyzJhf8exVvyd0Gi0VQR2hiBfFPe4kpPRvNnZwY+pydecaXVAGWSxdE8q4gfBMVFomoPOVlUJr7GqT2XByLM/3H9pur+pkuQROyCdVXmwP7tUH+cKSJSWj8Y4MW7vbVT9wWF55Nwb5Kydj3+S6IQFtmwbP4kGsntB/v7wGVmGvczGSSQbdnVg/E9g8PreHL2GFMdrst/t726+0c5+62zagqubuPK2NRGmDQe7oIfYrU1t76CVJTYBD1gdY2Xyp0394IyU3feESIzOFPSXCeQ20Fn4EZEuMQYWSoHtUSUVh7NjWWde2jc7U6wKeEIiLrGokcMYWafiBsuJ6W6cOJLcIFwTXaWLxQHPlctItgsJWcvbFiD1/D+bcCByZ2ZTqZu4PaPf0d7kp7fdc4ngkSGbncW8LeMCloK8mF58xLP9yfSScNFCSQmxOkeruPlfIr8fYlKCBO3w7TsgzODQbqiHE493Si4MYOS9RWMBZCrVTk1U92AI3ZsXj1mxDPmD6XzgSGUmObHAbaosbTpnCUH78OPgbN8hfEOEqgZo74IjnQLgClVhK4X3ZxGE+q+u1mNlHv8mmbHiBGTvyW5MbE/L7TMXLS5cnvOWkBdrcNExLI+yKDkvL5PW1ZX69xEfXQ8hMViCVwNgg04f6x2YDWJsBs9iNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KiUgh3gi5kyT8nVf9xb7KlPLsHNm67yHhyx9bSqOoqKb6X4Pqd/dXdkUZj9FvsTFqfxx6Rl/0hqhejfLbpXTMOoAV+W57GDrFo9f3dg/JZTbjoDAnt17UQ4L4dLsVm2wkUbuMg+dWYXL/XRhchmXGybjnvinYbGxolp6VLUrIDOJZTdaFguleecy+7d84T5NAd1u7vuEEMm3Z0sYEdkQx2/iLNTtLG30baBwW/eDNtETQ0TqbbQHvt7ID+Hp1Tx5yJwwMmmYvlwRDmfSjjTIOSlT6QJAELL/VwqUkXB7hg37nZKl/X14wIyUxPkqW6gAi60qoxis/IlX6y91ZFgpzIOOI8IzWwpMcybPxF73dwnIZeg7xLd1y5DMKhLjH49SJU7ZNzQhcj3oi65WFUXo4rR7HpURqEF6d5jUyUVW0zsnJeC0oGhIyvZII4xyT8DG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:23.8173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b34300-2dea-4065-ba64-08df181b6477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
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

Implement AMDGPU_SPM_OP_RELEASE so userspace can end an SPM session and
return the partition to an idle state. Only the owning drm_file may
release a session; any other caller gets -EPERM.

Ownership is validated under prof_xcp_mgr->mutex, then the releasing flag
is set and spm_buf_wq is woken while the mutex is still held, so a thread
blocked in spm_wait_for_fill_awake() observes the flag and returns instead
of touching a session that is going away.

Stop hardware SPM and free the per-instance ring buffers for every XCC
instance of the partition, using the xcc_mask cached at acquire time so
the teardown loops always match the instances that were actually set up.
Both loops run under spm_worker_mutex to lock out the drain worker, which
would otherwise keep updating rptr after the reset and read the ring after
it is freed. spm_cntr and lead_thread are cleared under spm_irq_lock
before cancel_work_sync(), so a work item that is already queued bails
out; the lead thread reference is dropped only once the worker has
drained, because the worker dereferences its snapshot in get_task_mm().

Add the active_waiters counter and the waiters_done wait queue to keep
spm_cntr alive across the unlocked sleep in spm_wait_for_fill_awake().
A waiter increments the counter under prof_xcp_mgr->mutex before dropping
it and decrements it once it is done touching spm_cntr; RELEASE waits for
zero before kfree(). After waking, a waiter revalidates teardown state,
ownership, spm_cntr identity and the releasing flag, returning -ECANCELED
on any mismatch.

Register amdgpu_spm_teardown() as the XCP teardown callback so that device
or partition teardown also sets releasing and wakes blocked waiters.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 200 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |   3 +
 2 files changed, 195 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 43b8970f1673..b3132f9a8c0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -21,6 +21,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/sched/task.h>
+
 #include "amdgpu.h"
 
 /*
@@ -36,6 +38,7 @@
 #define AMDGPU_SPM_META_SIZE		0x20
 
 static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
+static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
 static int amdgpu_spm_set_dest_buf(struct amdgpu_spm_mgr *spm_mgr, void *data,
 				   struct drm_file *filp);
@@ -66,8 +69,7 @@ int amdgpu_spm_ioctl(struct drm_device *dev, struct drm_amdgpu_spm_args *args,
 		return amdgpu_spm_acquire(spm_mgr, filp);
 
 	case AMDGPU_SPM_OP_RELEASE:
-		/* Implemented in a later patch */
-		return -EOPNOTSUPP;
+		return amdgpu_spm_release(spm_mgr, filp);
 
 	case AMDGPU_SPM_OP_SET_DEST_BUF:
 		return amdgpu_spm_set_dest_buf(spm_mgr, args, filp);
@@ -172,6 +174,8 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	mutex_init(&spm_cntr->spm_worker_mutex);
 	spm_cntr->xcc_mask = xcc_mask;
 	init_waitqueue_head(&spm_cntr->spm_buf_wq);
+	atomic_set(&spm_cntr->active_waiters, 0);
+	init_waitqueue_head(&spm_cntr->waiters_done);
 
 	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
 	spm_mgr->spm_cntr = spm_cntr;
@@ -258,30 +262,174 @@ static void _spm_stop(struct amdgpu_spm_mgr *spm_mgr,
 
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
 {
-	/* TODO */
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct amdgpu_device *adev = prof_xcp_mgr->adev;
+	struct amdgpu_spm_base *spm;
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(inst >= MAX_XCC))
+		return;
+
+	spm = &spm_mgr->spm_cntr->spm[inst];
+
+	/* ring_size is cleared on acquire-failure and prior release,
+	 * so it doubles as the 'allocated' sentinel for this early-out.
+	 */
+	if (!spm->ring_size)
+		return;
+
+	amdgpu_rlc_spm_release(adev, inst, drm_priv_to_vm(filp));
+	amdgpu_bo_free_kernel(&spm->spm_obj, &spm->gpu_addr, &spm->cpu_addr);
+
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	memset(spm, 0, sizeof(*spm));
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	--spm_mgr->spm_cntr->spm_use_cnt;
 }
 
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
 {
 	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct amdgpu_device *adev = prof_xcp_mgr->adev;
+	struct amdgpu_spm_cntr *spm_cntr;
+	struct task_struct *lead_thread;
+	unsigned long flags;
+	u32 xcc_mask;
+	int inst;
+	int ret = 0;
 
-	/* Full teardown lands with AMDGPU_SPM_OP_RELEASE. Re-check ownership
-	 * under the mutex so a close and a concurrent device teardown cannot
-	 * both release the same session.
-	 */
 	mutex_lock(&prof_xcp_mgr->mutex);
+
+	/* Ownership check + snapshot + release flag + wake must be atomic
+	 * to prevent double-release UAF. If spm_cntr is already NULL, a
+	 * concurrent releaser has already won the race.
+	 */
 	if (!spm_mgr->file) {
 		mutex_unlock(&prof_xcp_mgr->mutex);
 		return 0;
 	}
+
 	if (filp && !amdgpu_spm_is_owner(spm_mgr, filp)) {
 		mutex_unlock(&prof_xcp_mgr->mutex);
 		return -EPERM;
 	}
+
+	spm_cntr = spm_mgr->spm_cntr;
+	if (WARN_ON_ONCE(!spm_cntr)) {
+		/* Invariant violation: file set but spm_cntr NULL. Clear all
+		 * session state, including the lead thread reference, to
+		 * prevent a permanent wedge and a task_struct leak.
+		 */
+		spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+		lead_thread = spm_mgr->lead_thread;
+		spm_mgr->lead_thread = NULL;
+		spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+		if (lead_thread)
+			put_task_struct(lead_thread);
+		spm_mgr->file = NULL;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Wake waiters while still holding mutex. Waiters in
+	 * spm_wait_for_fill_awake() will drop and reacquire mutex
+	 * during their wait. The active_waiters counter prevents
+	 * spm_cntr from being freed until all waiters finish.
+	 */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	WRITE_ONCE(spm_cntr->releasing, true);
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+	wake_up_all(&spm_cntr->spm_buf_wq);
+
+	/* Use cached xcc_mask from acquire to avoid error handling */
+	xcc_mask = spm_cntr->xcc_mask;
+
+	/* Stop hardware SPM for all instances and free their ring buffers.
+	 * spm_worker_mutex locks out the drain worker, which would otherwise
+	 * keep updating rptr after the reset and read the ring after it is
+	 * freed.
+	 */
+	mutex_lock(&spm_cntr->spm_worker_mutex);
+	for_each_inst(inst, xcc_mask)
+		_spm_stop(spm_mgr, adev, inst);
+
+	for_each_inst(inst, xcc_mask)
+		_amdgpu_spm_release(spm_mgr, inst, filp);
+	mutex_unlock(&spm_cntr->spm_worker_mutex);
+
+	lead_thread = spm_mgr->lead_thread;
+
+	/* Clear spm_cntr and lead_thread under spm_irq_lock so the work
+	 * handler can detect release in progress and bail out. Must be done
+	 * BEFORE cancel_work_sync() to ensure racing work sees NULL.
+	 */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spm_mgr->spm_cntr = NULL;
+	spm_mgr->lead_thread = NULL;
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 	spm_mgr->file = NULL;
+
+	/* Cancel any pending/running work. If work is running, this waits
+	 * for it to complete. The work handler will see NULL spm_cntr and
+	 * bail out early.
+	 */
+	cancel_work_sync(&spm_mgr->spm_work);
+
+	/* Drop the lead thread reference only after the worker is drained:
+	 * it dereferences its snapshot in get_task_mm().
+	 */
+	if (lead_thread)
+		put_task_struct(lead_thread);
+
+	/* Destroy the worker mutex only after cancel_work_sync() has drained
+	 * any in-flight work handler, which may still hold it.
+	 */
+	mutex_destroy(&spm_cntr->spm_worker_mutex);
+
+	/* Drop the mutex only now: a new ACQUIRE could otherwise queue work
+	 * on the shared spm_work and have cancel_work_sync() eat its drain.
+	 */
 	mutex_unlock(&prof_xcp_mgr->mutex);
 
+	/* Wait for all waiters to exit. Correctness relies on every waiter
+	 * checking 'releasing' flag so active_waiters drains to 0. This is
+	 * guaranteed by current code (spm_wait_for_fill_awake checks releasing),
+	 * but future code must maintain this invariant or this will deadlock.
+	 */
+	wait_event(spm_cntr->waiters_done,
+		   atomic_read(&spm_cntr->active_waiters) == 0);
+
+	/* Acquire spm_irq_lock before freeing to ensure no waiter is between
+	 * dec_and_test and wake_up while holding the lock. The waiter's
+	 * spin_lock will either happen before this (waiter will complete before
+	 * wait_event above returns) or after kfree (safe - waiter won't touch
+	 * spm_cntr after releasing the lock).
+	 */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	kfree(spm_cntr);
 	return 0;
+
+out:
+	mutex_unlock(&prof_xcp_mgr->mutex);
+	return ret;
+}
+
+static void amdgpu_spm_teardown(struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr)
+{
+	struct amdgpu_spm_mgr *spm_mgr = &prof_xcp_mgr->spm_mgr;
+	struct amdgpu_spm_cntr *spm_cntr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spm_cntr = spm_mgr->spm_cntr;
+	if (spm_cntr) {
+		WRITE_ONCE(spm_cntr->releasing, true);
+		wake_up_all(&spm_cntr->spm_buf_wq);
+	}
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 }
 
 static int spm_update_dest_info(struct amdgpu_spm_mgr *spm_mgr,
@@ -358,6 +506,7 @@ static int spm_wait_for_fill_awake(struct amdgpu_device *adev,
 	int ret = 0;
 
 	rem = wait_event_interruptible_timeout(spm_cntr->spm_buf_wq,
+						READ_ONCE(spm_cntr->releasing) ||
 						READ_ONCE(spm_cntr->are_users_buf_filled),
 						timeout);
 
@@ -400,6 +549,7 @@ static int amdgpu_spm_set_dest_buf(struct amdgpu_spm_mgr *spm_mgr, void *data,
 	struct amdgpu_spm_cntr *spm_cntr;
 	bool need_schedule = false;
 	bool drained = false;
+	bool did_wait = false;
 	u32 started_mask = 0;
 	u32 xcc_mask;
 	u32 ubufsize;
@@ -452,6 +602,11 @@ static int amdgpu_spm_set_dest_buf(struct amdgpu_spm_mgr *spm_mgr, void *data,
 	 */
 	if (user_spm_data.timeout && READ_ONCE(spm_cntr->have_users_buf_cnt) &&
 	    !READ_ONCE(spm_cntr->are_users_buf_filled)) {
+		/* Increment active_waiters while holding mutex to prevent
+		 * release from freeing spm_cntr before we enter the wait.
+		 */
+		atomic_inc(&spm_cntr->active_waiters);
+
 		/* Drop mutex during wait to allow concurrent operations on other XCPs
 		 * and to prevent blocking device teardown. Safe because wait condition
 		 * (are_users_buf_filled, releasing) doesn't require this mutex.
@@ -461,6 +616,7 @@ static int amdgpu_spm_set_dest_buf(struct amdgpu_spm_mgr *spm_mgr, void *data,
 		dev_dbg(adev->dev, "SPM waiting for fill awake, timeout = %u ms.\n",
 			user_spm_data.timeout);
 		ret = spm_wait_for_fill_awake(adev, spm_cntr, &user_spm_data);
+		did_wait = true;
 
 		/* Re-acquire mutex */
 		mutex_lock(&prof_xcp_mgr->mutex);
@@ -487,6 +643,11 @@ static int amdgpu_spm_set_dest_buf(struct amdgpu_spm_mgr *spm_mgr, void *data,
 			goto out;
 		}
 
+		if (READ_ONCE(spm_cntr->releasing)) {
+			ret = -ECANCELED;
+			goto out;
+		}
+
 		if (ret == -ETIME) {
 			/* Copy (partial) data to user buffer after a timeout */
 			schedule_work(&spm_mgr->spm_work);
@@ -565,17 +726,40 @@ static int amdgpu_spm_set_dest_buf(struct amdgpu_spm_mgr *spm_mgr, void *data,
 	mutex_unlock(&spm_cntr->spm_worker_mutex);
 
 out:
-	mutex_unlock(&prof_xcp_mgr->mutex);
+	/* Decrement active_waiters after all spm_cntr usage is complete.
+	 * Use spm_irq_lock to coordinate with release's wait+free sequence:
+	 * - Waiter: dec under lock, then wake (if last)
+	 * - Releaser: lock, check counter, unlock, wait, lock, free, unlock
+	 * This ensures the releaser cannot free spm_cntr while waiter holds the lock.
+	 */
+	if (did_wait) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+		if (atomic_dec_and_test(&spm_cntr->active_waiters))
+			wake_up(&spm_cntr->waiters_done);
+		spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+	}
+
+	/* Schedule work while still holding prof_xcp_mgr->mutex to prevent
+	 * amdgpu_spm_release() from racing and clearing spm_cntr before the
+	 * work item is queued.
+	 */
 	if (need_schedule)
 		schedule_work(&spm_mgr->spm_work);
 
+	mutex_unlock(&prof_xcp_mgr->mutex);
+
 	dev_dbg(adev->dev, "SPM finish to set new destination buffer, ret = %d.\n", ret);
 	return ret;
 }
 
 void amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr)
 {
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+
 	amdgpu_spm_init_device(spm_mgr);
+	prof_xcp_mgr->teardown_cb = amdgpu_spm_teardown;
 }
 
 void amdgpu_spm_mgr_release_owner(struct amdgpu_spm_mgr *spm_mgr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index eaeb880e209c..760fc04e7a6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -62,6 +62,9 @@ struct amdgpu_spm_cntr {
 	wait_queue_head_t spm_buf_wq;
 	u32   have_users_buf_cnt;       /* Updated under spm_worker_mutex; read locklessly via READ_ONCE */
 	bool  are_users_buf_filled;     /* Updated under spm_worker_mutex; read locklessly via READ_ONCE */
+	bool  releasing;                /* Set before teardown to unblock waiters */
+	atomic_t active_waiters;        /* Tracks threads in spm_wait_for_fill_awake */
+	wait_queue_head_t waiters_done; /* Signaled when active_waiters reaches 0 */
 };
 
 struct amdgpu_spm_mgr {
-- 
2.34.1


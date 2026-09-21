Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846DAC982F0
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A2010E873;
	Mon, 21 Sep 2026 20:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JPv3R3HZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012045.outbound.protection.outlook.com
 [40.107.200.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F3D10E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfML1YIAJ1cxXJ7fldhIEtqQYSVs3XhP4L5Use+XcLXf8NoZbhdPwPvW04RKnV2i3Z7Fjy8YN+B/o9+syL5e+fxZiDaOYpKOea6y9C1EPFsw8HapzNVWGBGuhpKheKh0vr4hFdOILgTjVehfOf9EJMJeC9NtFfZ/NHcsvHkuZhmJCsLj/6SXHvPpGq5zP2WNv49OXfamJpgXdR3V0srIBFdULPClo2STqWyDqddyYgwrH2/A1zgRZ4zOIjn3zTPir/f600xaB0pMlkNurMLASHAihoKTi+OIB5UQyN9gMd5oDyKNe+DwZy9xSZr5EdVg8CrSYU7NFItzZ/mKMO03JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+BcQpXcCuLlyeEhKAJaUWrp2Wkc0Af37771OO9HQio=;
 b=OdIn8nPUTvJbvgZ8H28R5jptnBFLpk1KEJFkhnjO5sUjRpy+DL7cTwGZwScuiEohF4Yj96dEZW5qLwwKjJeq6i1gXPHMMZopKXW4Rj/bTovEvlLKBA1EgcjIJnEFEGTEXM1oaQButjni5lJ0Z7hN2kmnlxkHOknBioQdUAx1kaZxKtIiSyMCZXjh035KLefMvXBtDfI7C+dI8baCHdDWL82FtdnROCHTsG4/z3woE5QdlmaDtRssGlx13oe+rkd7o2kBmd2VnHWS4EFhF+WsjdTQTUyhZGbPnIAs1cV4xNPUhNCYyoAYwqShl+E62Ca0Q2d/rHWKuNgW8jXIwS1m8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+BcQpXcCuLlyeEhKAJaUWrp2Wkc0Af37771OO9HQio=;
 b=JPv3R3HZmoqCdVrQGwe8kzwpgvIVFanSJvmit1RmlVXJqDVC0pKN8I1R7xLY2yRg/5EVggMelV8RiOU+CvUu712qtXGhbY5csVR0JgodlvtmMOGey0QIO36wO/xttpihreJhkl1V99rkJMNlEQQC8V5c1sagxyrqePlYvSkT5lA=
Received: from CP5P284CA0024.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:94::11)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:24 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10d6:103:94:cafe::a4) by CP5P284CA0024.outlook.office365.com
 (2603:10d6:103:94::11) with Microsoft SMTP Server (version=TLS1_3,
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
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:21 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:20 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 05/12] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_ACQUIRE
Date: Mon, 21 Sep 2026 16:03:06 -0400
Message-ID: <20260921200313.865829-5-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: bf23fde9-fee9-4aba-209c-08df181b642d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|18002099003|22082099003|11063799006|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: n39E8V8C62vnQqcqYJHQMwhVJT8cMkJ8BlVTIxR4ClHM8aPisNtI9DbiYdX+x/0C9W55oDWnVg+zOP1EZIdPAnd8pA6CaXN3B8DOhamI3ptGrnzdR5lhUVmwVmqWQ7eNF4Npa2Xn0CDR8D0qgcSUETfs9EGIYZwv8MFCf5YIYIYpyqgeEMLHQAPf4fAjfNI7cgHNki83xI/T3PwdG06eD1+CQ+KcoRdsGwMnbxaZXdRPeUBv+ooH9lQtAzk3BrA3KEFniXaHq3mNgh0IOCRKTboIyieQiZEjmblZbXcDUpk+WY6GA8izFyRgmIZlll91dL4YJPGUcvazr+pbob97RdJVPdIHrm3cPMzufv0p5tVF/V0DGvDOdyCY7oJ4bGn4vlMCWwXJw/2SFigLp31d7q3AY7VRYI7KYsUX5yCE7AQJQ1P/lYAXxYCbAMtBCTZiZ0XW+Z90E37z5ASoccac3EIdUyXG9++a76mAEfitlC/XIISpLIcUOP83L/Yexbm32E+CEHzuPTd7/cs9h1Jdz+9kAPsEnykrW55bBRwN9Ur/GCeGFNvqANydgTrym2vjl1321aulmit/YhD2RHUfzbm5A3QHdlFLnjkNDapt4HFQhLdQo1ydAUPxq7OfGDKCiHJaJ7AMtpXfu1VkRF2lnIGaxNAk3D6huAiYJZWx9bDWjZWnkegCoPvxcEX6hGTpS07whCfLJj963B7AX+kxqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HllLX/zsHt7Um7faTtSPoMyiHRXpk3QMHosbTlBtqe+fGUtMhhGr+9BS0bLfdxo5K79cFyps9d4ZNEU3CeNTgh3+jru4OEx+8B8ESnMk+oNr7CMh+p/0K+a2M/fLoz92yjQJ5P9y6EN2xghKZ/xLmN80UIZQpaBCNCd05ppqJ6HRuSu/YQLHKZBUuzRKOoSilUpTUCsLqkGoaIhpt9XeSmHGMHwX7MWbiujoNJxKLxsA9xuhTb2hNCDZ0LKc4KkXLJQf7XI1WrtlJfkuSFlAIN+1H48ZkGiYRLqx4kSHvMuS4dApDh1TYP2Zbqb5ORZRezoNe4tZK7T8YQyRT1N9numglHiY5SLcGNa7fGPAgKk3n0xlq3eJp5has7c0SuLnP5ACOGIP49Y7ouAoa91hXYMEc0qv8HIa0mUc6GYBz6giQcCoW+EZbpljf3ARlQai
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:23.3356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf23fde9-fee9-4aba-209c-08df181b642d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
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

Implement AMDGPU_SPM_OP_ACQUIRE to allow userspace to request exclusive
access to the SPM hardware. Only one drm_file can own SPM at a time; a
second acquire returns -EBUSY.

On acquire the driver does more than record ownership:

 - allocates the per-XCP SPM counter state (amdgpu_spm_cntr) and records
   the owning drm_file and the calling thread group leader, pinned via
   get_task_struct(). The matching put_task_struct() runs on this patch's
   acquire-failure path;

 - for every XCC instance in the XCP's xcc_mask, allocates a 4 MB GTT
   ring buffer BO (amdgpu_bo_create_kernel(), AMDGPU_GEM_DOMAIN_GTT) for
   the SPM data stream, reserving the trailing 32 bytes as a metadata
   area (usable ring_size = 4 MB - 0x20);

 - calls amdgpu_rlc_spm_acquire() per instance, which allocates a
   reserved VMID (amdgpu_vmid_alloc_reserved()), programs the SPM VMID
   into the RLC and programs the perfmon ring registers (ring base, size
   and read pointer) via KIQ.

On failure at any instance the acquire path invokes the per-instance
release helper for every instance in xcc_mask, drops the task reference
and frees the counter state. _amdgpu_spm_release() is only a stub in
this patch, so the per-instance hardware resources (ring BOs, reserved
VMID and RLC perfmon programming) are not torn down on this error path
yet; only the task reference and the amdgpu_spm_cntr allocation are
cleaned up here.

A new per-XCP mutex is added to struct amdgpu_profiler_xcp_mgr to
serialize acquire/release against the shared XCP SPM resources. It is
initialized once for the device lifetime in amdgpu_profiler_device_init()
(alongside adev/xcp_id) so it stays valid for teardown paths such as
amdgpu_spm_mgr_release_owner() and amdgpu_spm_mgr_fini(). The existing
spm_irq_lock spinlock continues to guard spm_cntr publication against the
interrupt handler.

AMDGPU_SPM_OP_RELEASE and full teardown of these resources land in a
follow-up patch.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 151 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  28 +++++
 2 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 06747dd22b85..36a2d2d1f0ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -23,22 +23,36 @@
 
 #include "amdgpu.h"
 
+#define AMDGPU_SPM_RING_SIZE		(4 * 1024 * 1024)
+#define AMDGPU_SPM_META_SIZE		0x20
+
+static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
+static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
+
 /* Check if the calling file owns the SPM session */
 static bool amdgpu_spm_is_owner(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
 {
 	return spm_mgr->file == filp;
 }
 
+static void amdgpu_spm_work(struct work_struct *work)
+{
+	/* TODO: dump spm ring buffer to user buffer */
+}
+
 int amdgpu_spm_ioctl(struct drm_device *dev, struct drm_amdgpu_spm_args *args,
 		     struct drm_file *filp)
 {
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_spm_mgr *spm_mgr = &fpriv->prof_xcp_mgr->spm_mgr;
+
 	if (memchr_inv(args->reserved, 0, sizeof(args->reserved)))
 		return -EINVAL;
 
 	switch (args->op) {
 	case AMDGPU_SPM_OP_ACQUIRE:
-		/* Implemented in a later patch */
-		return -EOPNOTSUPP;
+		return amdgpu_spm_acquire(spm_mgr, filp);
 
 	case AMDGPU_SPM_OP_RELEASE:
 		/* Implemented in a later patch */
@@ -49,11 +63,144 @@ int amdgpu_spm_ioctl(struct drm_device *dev, struct drm_amdgpu_spm_args *args,
 		return -EOPNOTSUPP;
 
 	default:
+		dev_dbg(adev->dev, "Invalid option: %u\n", args->op);
 		return -EINVAL;
 	}
 }
 
 static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)
+{
+	spm_mgr->spm_cntr = NULL;
+	spin_lock_init(&spm_mgr->spm_irq_lock);
+	/* spm_work lives for the device lifetime; initialize it once here so
+	 * it is ready before any interrupt can schedule it.
+	 */
+	INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);
+}
+
+static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct amdgpu_device *adev = prof_xcp_mgr->adev;
+	struct amdgpu_spm_base *spm;
+	int ret = 0;
+
+	if (WARN_ON_ONCE(inst >= MAX_XCC))
+		return -EINVAL;
+
+	spm = &spm_mgr->spm_cntr->spm[inst];
+
+	/* allocate 4M spm ring buffer */
+	spm->ring_size = AMDGPU_SPM_RING_SIZE;
+
+	ret = amdgpu_bo_create_kernel(adev, spm->ring_size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_GTT, &spm->spm_obj,
+				      &spm->gpu_addr, &spm->cpu_addr);
+
+	if (ret) {
+		memset(spm, 0, sizeof(*spm));
+		goto out;
+	}
+
+	ret = amdgpu_rlc_spm_acquire(adev, inst, drm_priv_to_vm(filp),
+				     spm->gpu_addr, spm->ring_size);
+	if (ret)
+		goto rlc_spm_acquire_failure;
+
+	/*
+	 * The first 8 DWs of the buffer are the Meta data area (RLC writes
+	 * the wptr there); the ring itself starts at AMDGPU_SPM_META_SIZE.
+	 */
+	spm->ring_size -= AMDGPU_SPM_META_SIZE;
+
+	goto out;
+
+rlc_spm_acquire_failure:
+	amdgpu_bo_free_kernel(&spm->spm_obj, &spm->gpu_addr, &spm->cpu_addr);
+	memset(spm, 0, sizeof(*spm));
+out:
+	return ret;
+}
+
+static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct amdgpu_device *adev = prof_xcp_mgr->adev;
+	u32 xcp_id = prof_xcp_mgr->xcp_id;
+	struct amdgpu_spm_cntr *spm_cntr;
+	unsigned long flags;
+	u32 xcc_mask;
+	int ret = 0;
+	int inst;
+
+	mutex_lock(&prof_xcp_mgr->mutex);
+
+	/* spm_mgr->file is the single source of truth for the busy check: it is
+	 * assigned last on the acquire success path and cleared on teardown.
+	 */
+	if (spm_mgr->file) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
+	if (ret)
+		goto out;
+
+	spm_cntr = kzalloc(sizeof(*spm_cntr), GFP_KERNEL);
+	if (!spm_cntr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	get_task_struct(current->group_leader);
+	spm_mgr->lead_thread = current->group_leader;
+
+	/* Initialize the per-session worker mutex before the acquire loop so it
+	 * is ready before spm_cntr is published. spm_work is initialized once in
+	 * amdgpu_spm_init_device().
+	 */
+	mutex_init(&spm_cntr->spm_worker_mutex);
+	spm_cntr->xcc_mask = xcc_mask;
+
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spm_mgr->spm_cntr = spm_cntr;
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	for_each_inst(inst, xcc_mask) {
+		ret = _amdgpu_spm_acquire(spm_mgr, inst, filp);
+		if (ret)
+			goto acquire_spm_failure;
+	}
+
+	spm_mgr->file = filp;
+
+	goto out;
+
+acquire_spm_failure:
+	/* Iterate all instances in xcc_mask; _amdgpu_spm_release uses ring_size
+	 * as a sentinel to skip instances that were never acquired.
+	 */
+	for_each_inst(inst, xcc_mask)
+		_amdgpu_spm_release(spm_mgr, inst, filp);
+	/* Drain any pending work before dropping lead_thread and clearing
+	 * spm_cntr. Nothing can schedule the work during acquire, so this is
+	 * defensive ordering.
+	 */
+	cancel_work_sync(&spm_mgr->spm_work);
+	put_task_struct(spm_mgr->lead_thread);
+	spm_mgr->lead_thread = NULL;
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spm_mgr->spm_cntr = NULL;
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+	mutex_destroy(&spm_cntr->spm_worker_mutex);
+	kfree(spm_cntr);
+
+out:
+	mutex_unlock(&prof_xcp_mgr->mutex);
+	return ret;
+}
+
+static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
 {
 	/* TODO */
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index 59fa641ebb86..d59c3d93a64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -27,9 +27,37 @@
 struct drm_device;
 struct drm_file;
 struct drm_amdgpu_spm_args;
+struct amdgpu_bo;
+
+struct amdgpu_spm_base {
+	u64    gpu_addr;
+	u32    ring_size;
+	void   *cpu_addr;	/* Metadata area (first u32 = wptr) + ring data (u64 array) */
+	struct amdgpu_bo *spm_obj;
+};
+
+struct amdgpu_spm_cntr {
+	/* Indexed by XCC instance id (from for_each_inst or xcc_id parameter).
+	 * Each spm_mgr/spm_cntr is per-XCP partition, and spm[] tracks each
+	 * XCC instance within that partition. Array sized MAX_XCC to handle
+	 * the maximum possible XCC instance ID.
+	 */
+	struct amdgpu_spm_base spm[MAX_XCC];
+	u32 xcc_mask;  /* Cached from acquire; avoids error handling in release */
+	/* Protects dest-buffer state and worker operations */
+	struct mutex spm_worker_mutex;
+};
 
 struct amdgpu_spm_mgr {
 	struct drm_file *file;
+
+	struct task_struct *lead_thread;
+
+	/* spm data */
+	struct amdgpu_spm_cntr *spm_cntr;
+	struct work_struct spm_work;
+	/* Protects spm_cntr publication and the SPM state read in the IRQ path */
+	spinlock_t spm_irq_lock;
 };
 
 int amdgpu_spm_ioctl(struct drm_device *dev, struct drm_amdgpu_spm_args *args,
-- 
2.34.1


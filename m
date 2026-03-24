Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE447FEC11B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F32F10E326;
	Tue, 24 Mar 2026 21:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tg4crVXH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EF610E326
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxYaxe7sHugh/y9Qjfaawv/ZWkrXIK9JtJSFW8BNJFBFhDtRf1PUnYvIxDvWUAc/x6qth+nm9pW3eAXNoHG4EnKvB7U2u2tHwgtmkACzb9+1oIWjYai0vW4OQ+eyRmEgAr/1oR4apGHbnCSxbUzPYC7wLSmdHsalSBwCqDNcQvCWboGBBpZpKC7wEpIN7DAU+V9QlQ5zOwVqnR+Cyho/4NzuM/qRqByrj/cKqFWhxZPNjHKrX836uK9P/DMANOLYO4+PNEQQQI/FJQ5EVq/Z6aorcOD+GS+aVTu3JtRS6A63llLJKrUKq49VzpaRFdUpB3gsbbzC+KebHJbtpBQbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV5ZZDgs5q7DG3EKF/m4ky6dpGpmHFBydSSOwhay+tA=;
 b=afkFwND8xcU6/1TI21KUv9FePkICbUZrcE1PE3tt0ezqdDgUsoO26wOfzeEDlcQyj+PnwwO4y8Vvhyddewb8y1IFuAPGJTh26+pJazRJ6pJZRKM2qNVvOpq9A6U0r6nx9e2PJ+pLzBkXRX5ybDUOQ11rV6oCOlYa+Z94MCJQ7x6m3lCknLziha+rL9m2DpLGZu7iPGGca3X30H67bWh3F6ock5FpPN1w+EpPMsMUVq/bx0tJX2jfozG87YanUL7ryYH2pFsgU/qcXX+ICg57P9OGDhRH6cQLVv18dGESEN0uCQlDKig4UweGS3VlWkgCue5MqyywLPLr1HCVNTSL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV5ZZDgs5q7DG3EKF/m4ky6dpGpmHFBydSSOwhay+tA=;
 b=tg4crVXHp14DzIQ6CVAji7mY6iDlQHE2oljcL0xiBN5Q7aqPqPMMtv5LrOlPlFweAjW7F+91qsXiKMaWS1+aPZvimcwE3n5r0P08Cw7bfR2iL5l1sNxlGC7GqTUyxnGxQYazaCOjcFkJjW/INoIL6cQQxX4u4t1UtCNJ2ykBBsY=
Received: from SA0PR11CA0206.namprd11.prod.outlook.com (2603:10b6:806:1bc::31)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 24 Mar
 2026 21:20:57 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::5) by SA0PR11CA0206.outlook.office365.com
 (2603:10b6:806:1bc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:56 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:45 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 10/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_ACQUIRE
Date: Tue, 24 Mar 2026 17:20:23 -0400
Message-ID: <20260324212030.822932-11-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 763e4c5c-5116-4558-3376-08de89eb3cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4pBhdYX5ySw0rJN5pQeI7JPVOWHnMNidUBWWULmGd1ZqIASIqxWlF+zQ1jHUmirKM2ea+mNKyS2Nt9I6pEaxJZSHkI+wb4jtxw/BLDvAFSKM4E8OJTMAuxG5KI5cy78kH2tEksVWgeVXuiqr96LKBefJFZZtfSsrHgc5y/WuXscd/KBB6ei/+6FC0taslMNN+xa+8MewEF1tW+8WMIwwbTHu6YWYN501R2lzYWpXdxpM4Yxvv/b+Kpc2gAKe1bolUscit3wtHGTnBkwlKqXHpksE3zidPrjvg0cgIWdoTAhyZsghzeG/Bl+CZk2cGVKDjNm/8tDXuMSi6upKtWk3eXGyMOqKRhQ2hNJwz865mEZfKfdCc77Ka78uPemLywkMcGRO0rV3Q5QX3L3Um6hu4Vf5XZm3MOzRvHqmvYoPK5mi4ME9Jwx6IDDUghLe5j8hk5jl/lFEoUpSf9K/yGgOIQaVbJQ7NB1MAbNjlUP9RVc3j4Ipjqr5Ch3xhbnF7AJMlYqQv46dygQa53MugTSF2LyC2oDdCNPspsMA73KU4mN+zoy/NNTajH5KIFcmMo9owgUww9566g92loV4oMjyUScoGsGnE6kYtCGo4hUoZ75NheqYKzWZaFdImmwJ+fI73cyyaIcDIeP2Uz+63IkoHV4wtddI5iaATLCW4aqwImoDi9q5wOv2amMLDnBnWrz3YU/SkFwkq7oS19E1fdbLyCkikz8oEgBcAvamAkXpvDBTxkeCy789yoYqsARjg4EQm7JIY3VIaYvuMC3Hwiq9Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xh+4lzABnqXNey6dPFEv8AslEpXqKeh1JviRAb4JR5s1RDyj7qakHEUMp8hT5fpF+LT2HRBIYlkX1e0Ed+CCcFbSIbma5LxQ6LNsKVFXxjPhgdgD7/UU4M8DPdB8DFK2wcwO+oJX4NM/cuDjQfKFPYUwMv03FM5iWQfzwHGCQ07ron84aB8JbcoGxd+PUQY6xXVAuN/uUK05yBZXz/DTa3jLLNGCc7D/I2zKLy6/6BdlHf8FPoeER6MaL/u9ULUiq13LPVX3zmqaw+4bdwWCbkSRqbHgQJePV724ylPaAlcIgiy5nrYBvvpAaFI+VKBrqPv2h2I99vDWf2oAKxf4VdN1znA1RnDBHq1+ttOYVnDBBcUxX62ndcXfhSaU6TGfrhmYBL2S+KuKrk14IsqABTaHanx+Rj2tFV3y0Pj0aNYWP6+IU6QAUPvdPN5FqPxK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:56.5729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 763e4c5c-5116-4558-3376-08de89eb3cf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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

to implement AMDGPU_SPM_OP_ACQUIRE, which grants a process exclusive
access to the SPM hardware on its XCP partition and allocates the
per-XCC ring buffers used for streaming performance counter data.

Data structures:
  struct amdgpu_spm_base (amdgpu_spm.h):
    Holds the per-XCC ring buffer state: GTT BO handle (spm_obj),
    GPU virtual address (gpu_addr), kernel virtual address (cpu_addr),
    and effective ring size (ring_size).

  struct amdgpu_spm_cntr (amdgpu_spm.h):
    Contains an array of amdgpu_spm_base[MAX_XCP] (one per XCC) and a
    spm_worker_mutex to serialize worker operations. Allocated on first
    ACQUIRE and freed on RELEASE.

  struct amdgpu_spm_mgr (amdgpu_spm.h):
    Extended with lead_thread (the acquiring process's thread group
    leader), spm_cntr pointer, and spm_work work_struct for the deferred
    ring buffer drain worker.

ACQUIRE flow (amdgpu_spm_acquire):
  1. Takes the per-XCP prof_xcp_mgr->mutex to serialize concurrent
     ACQUIRE attempts.
  2. Returns -EBUSY if spm_cntr is already allocated (another process
     holds SPM).
  3. Allocates spm_cntr via kzalloc and records current->group_leader
     as lead_thread.
  4. For each XCC in AMDGPU_XCC_MASK(adev), calls _amdgpu_spm_acquire():
     - Allocates a 4 MiB GTT ring buffer via amdgpu_bo_alloc_gtt_mem().
     - Programs the ring buffer into the RLC hardware via
       amdgpu_rlc_spm_acquire(), which also reserves a VMID for the
       caller's VM.
     - Subtracts 0x20 bytes (8 DWORDs) from ring_size to exclude the
       hardware-defined metadata area at the end of the buffer.
     - On failure, frees the GTT BO and clears the spm_base entry.
  5. Initializes spm_worker_mutex and INIT_WORK for amdgpu_spm_work.
  6. Records the drm_file pointer in spm_mgr->file.
  7. On any per-XCC failure, rolls back all already-acquired XCCs via
     _amdgpu_spm_release() (stub, TODO) and frees spm_cntr.

amdgpu_spm_work (work_struct handler):
  Attaches the lead_thread's mm_struct via kthread_use_mm() to enable
  user-space copy operations, then detaches and releases the mm. The
  actual ring buffer drain to user space is a TODO for a later patch.

Three new navigation macros are added in amdgpu_profiler.h:
  - to_prof_xcp_mgr(x, y): container_of from a member y to
    amdgpu_profiler_xcp_mgr.
  - xcp_to_prof_mgr(x, y): container_of from prof_xcp_mgr[] element to
    amdgpu_profiler_mgr.
  - mgr_to_adev(x, y): compound statement combining the two above to
    reach amdgpu_device from any embedded manager pointer.

AMDGPU_XCC_MASK(adev) is added using GENMASK() to safely produce a
bitmask of active XCC instances from NUM_XCC(adev->gfx.xcc_mask).

In amdgpu_spm_ioctl(), the per-XCP spm_mgr is now resolved from fpriv
using AMDGPU_XCP_ID() before dispatching to sub-operation handlers.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  13 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 114 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  17 +++
 3 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index ea62a4dee364..587adadaedb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -27,6 +27,7 @@
 
 #include "amdgpu_spm.h"
 
+#define AMDGPU_XCC_MASK(adev) GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0)
 #define AMDGPU_XCP_ID(x) (x == AMDGPU_XCP_NO_PARTITION ? 0 : x)
 #define fpriv_to_prof_mgr(fpriv) (&(fpriv)->userq_mgr.adev->prof_mgr)
 #define fpriv_to_adev(fpriv) ((fpriv)->userq_mgr.adev)
@@ -34,6 +35,18 @@
 #define prof_mgr_to_adev(x) \
 	container_of(x, struct amdgpu_device, prof_mgr)
 
+#define to_prof_xcp_mgr(x, y) \
+	container_of(x, struct amdgpu_profiler_xcp_mgr, y)
+
+#define xcp_to_prof_mgr(x, y) \
+	container_of(x, struct amdgpu_profiler_mgr, y)
+
+#define mgr_to_adev(x, y) \
+({	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(x, y); \
+	struct amdgpu_profiler_mgr *prof_mgr = \
+		xcp_to_prof_mgr(prof_xcp_mgr, prof_xcp_mgr[prof_xcp_mgr->xcp_id]);\
+	prof_mgr_to_adev(prof_mgr); })
+
 struct amdgpu_profiler_xcp_mgr {
 	struct mutex                   mutex;
 	uint32_t                       xcp_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 6ff88dfabf1c..e58b89ccd83f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -30,10 +30,28 @@
  */
 
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
+static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
+
+static void amdgpu_spm_work(struct work_struct *work)
+{
+	struct amdgpu_spm_mgr *spm_mgr = container_of(work, struct amdgpu_spm_mgr, spm_work);
+	struct mm_struct *mm = NULL;
+
+	mm = get_task_mm(spm_mgr->lead_thread);
+	if (mm) {
+		kthread_use_mm(mm);
+		{ /* attach mm */
+			/* TODO: dump spm ring buffer to user buffer */
+		} /* detach mm */
+		kthread_unuse_mm(mm);
+		/* release the mm structure */
+		mmput(mm);
+	}
+}
 
 static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)
 {
-	/* TODO */
+	spm_mgr->spm_cntr = NULL;
 }
 
 static void amdgpu_spm_release_device(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
@@ -41,6 +59,94 @@ static void amdgpu_spm_release_device(struct amdgpu_spm_mgr *spm_mgr, struct drm
 	amdgpu_spm_release(spm_mgr, filp);
 }
 
+static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	int ret = 0;
+
+	/* allocate 4M spm ring buffer */
+	spm->ring_size = 4 * 1024 * 1024;
+
+	ret = amdgpu_bo_alloc_gtt_mem(adev,
+			spm->ring_size, &spm->spm_obj,
+			&spm->gpu_addr, (void *)&spm->cpu_addr,
+			false, false);
+
+	if (ret)
+		goto out;
+
+	ret = amdgpu_rlc_spm_acquire(adev, inst, drm_priv_to_vm(filp),
+			spm->gpu_addr, spm->ring_size);
+	if (ret)
+		goto rlc_spm_acquire_failure;
+
+	/*
+	 * By definition, the last 8 DWs of the buffer are not part of the rings
+	 *  and are instead part of the Meta data area.
+	 */
+	spm->ring_size -= 0x20;
+
+	goto out;
+
+rlc_spm_acquire_failure:
+	amdgpu_bo_free_gtt_mem(adev, &spm->spm_obj);
+	memset(spm, 0, sizeof(*spm));
+out:
+	return ret;
+}
+
+static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	int ret = 0;
+	int inst;
+
+	mutex_lock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+
+	if (spm_mgr->spm_cntr) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	spm_mgr->spm_cntr = kzalloc(sizeof(struct amdgpu_spm_cntr), GFP_KERNEL);
+	if (!spm_mgr->spm_cntr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	spm_mgr->lead_thread = current->group_leader;
+
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+		ret = _amdgpu_spm_acquire(spm_mgr, inst, filp);
+		if (ret)
+			goto acquire_spm_failure;
+	}
+
+	mutex_init(&spm_mgr->spm_cntr->spm_worker_mutex);
+
+	INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);
+
+	spm_mgr->file = filp;
+
+	goto out;
+
+acquire_spm_failure:
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev))
+		_amdgpu_spm_release(spm_mgr, inst, filp);
+	kfree(spm_mgr->spm_cntr);
+	spm_mgr->spm_cntr = NULL;
+
+out:
+	mutex_unlock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	return ret;
+}
+
+static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
+{
+	/* TODO: */
+
+}
+
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
 {
 	/* TODO */
@@ -52,9 +158,15 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+	struct amdgpu_profiler_mgr *prof_mgr = fpriv_to_prof_mgr(fpriv);
 	struct drm_amdgpu_spm_args *args = data;
+	struct amdgpu_spm_mgr *spm_mgr =
+		&(prof_mgr->prof_xcp_mgr[AMDGPU_XCP_ID(fpriv->xcp_id)].spm_mgr);
 
 	switch (args->op) {
+	case AMDGPU_SPM_OP_ACQUIRE:
+		return amdgpu_spm_acquire(spm_mgr, filp);
+
 	default:
 		dev_dbg(adev->dev, "Invalid option: %i\n", args->op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index dc55d2a8f016..9db89fd6154d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -24,8 +24,25 @@
 #ifndef AMDGPU_SPM_H_
 #define AMDGPU_SPM_H_
 
+struct amdgpu_spm_base {
+	u64    gpu_addr;
+	u32    ring_size;
+	u32    *cpu_addr;
+	void   *spm_obj;
+};
+struct amdgpu_spm_cntr {
+	struct amdgpu_spm_base spm[MAX_XCP];
+	struct mutex spm_worker_mutex;
+};
+
 struct amdgpu_spm_mgr {
 	struct drm_file *file;
+
+	struct task_struct *lead_thread;
+
+	/* spm data */
+	struct amdgpu_spm_cntr *spm_cntr;
+	struct work_struct spm_work;
 };
 
 int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A1BC982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57CEA10E91B;
	Mon, 21 Sep 2026 20:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rNEHiDmQ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE35410E873
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Al2RFcGTSyWeL5cPU6Koyipoock8ea74CNbPrPOwAg3+dTO29B6UXUxdrxoGGRVz7Rqif549qUBUNnzjxrL+qosqvc/IPYOM1f2F2tBR286d6llrNhayTFeLBairxTfQ7lKUyXKsiJotiXMspPbLcNODM4SPD98sn4ZNR4h4JNrb0uJTq0j1APXA0jJcZfD9DfzxndK0bapUNjxE3HILC+kztu4nfKWawo5FD+eYmc+6zQfrWik56sNQcG8SMiF02vc+PEhS4x++hJYq3TRksww9KFJKafq0v5kRqbLbBve6cFq+D0um/RrFqLxSR+rZa+mEPnh6fJr9H/XUqHG6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+Q6UzPeGroWQwRff8yXbRIx7M2DUXS/KW5emRBBen4=;
 b=bwm+cwjrE/UIXycrN4j0Csual7bw4Ukx8Jz1IAMoFA3pelTI0rNqe6d8dnypw4tKuMkZ3+PcMg/Hl2D671cKhHFDiZHk+/UxJyYPZVBm9wxbGQeaikLrY5aesfHm6dYnun7cCBwZJqXGQp8yN1GwAMq/7uxSr3DmrDUZDB1CIcI/RWcXMOtxEMWaJH8yfKwp+sxVt6YkZ+kFyErNoFPFE645Zx6EKfcvz4lBuPk5puj9pw3VKqE9Gugy6G2sq2/aJp+BVvt+pUmyD8fpoEj2RijNinGCPT1igMoFXacY3jTdyFFWGNfeqm/Uhdexads3hqnBlwGvT7r/t5qKuhsuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+Q6UzPeGroWQwRff8yXbRIx7M2DUXS/KW5emRBBen4=;
 b=rNEHiDmQAE98Aowax6Cq0QyoEpEKD3LWcVwkdNC3b/vn0dzctQG/hfdPRMZPI1TX+mNC0wWoE0WESagETV4nztn0s/d5CfC7vmEr6cbFjkToF/txZZvnjCBU9XVwlueePU69uqI6gn3O7X0LNSllAEascTt+7IbNREuntJMo4lI=
Received: from BN9PR03CA0430.namprd03.prod.outlook.com (2603:10b6:408:113::15)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:24 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::8a) by BN9PR03CA0430.outlook.office365.com
 (2603:10b6:408:113::15) with Microsoft SMTP Server (version=TLS1_3,
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
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:21 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:21 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 06/12] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_SET_DEST_BUF
Date: Mon, 21 Sep 2026 16:03:07 -0400
Message-ID: <20260921200313.865829-6-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 374fd3d5-60f0-4554-b57c-08df181b6457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|11063799006|56012099006|3023799007|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cKjWBSaTiPgIWHwpSeNE8FUiZ8c1MKEnc/j5tFYJbg3anPFdr1HP6fhn20F1S2rVDwA7AEj/64Z22q6ls0qlX8i4oXZuKDEULdCS+rx7Rn2cXh4M7Rocq3lZDj45EsKTXLcQHa6lhUfaoUXYDctEM/U1HH+622lZKTUJqwd5k3iuJtw7OiCLJsEEs9HpKi0IGSq8eJbdR8A0w9I8GY8dfLfd/4SyEJZvtGTpeGCi9vZfdvMa3qPDmTDsD2d30k7Nq5L8b8kU1YRXp5urC1EZThdXbYO5f5J1DNSC4Kc0m/YSoDcubpiiZZBgBJtr+D6iSJ09ghwipTfCq+hdZYadaAkFg06HwrcxXjKvcr5kkuMFFVCwMHURkT9d9fRPjRpj7UoM8JLNTve1L28/BD5rRRZsThOIz9ST7q8PpEnW3AOyn7Sj6iGaXKcsDpCbaPJOwH/OZRHUJhWZB9YhUG/A8kK0R2gAaDMPZwWqKRVVNauB0okLztHlkbstdTOb8IRzCnZdPKwQjl/kLkDDGUScUwuYHFqMmm6QDYJQ6/zJJFy5LsjxANW18tzUTx8F/vl/5uM4+TToY1UuPM/KepfQEQuEr1i2Yt1N3yvdKFITLv8Xx2pEtwN55Bbmp9GaSpxBNqUV4bkXhrbLddPuYSLl2BzKZFaU3c8u5DSf/bIWYaVSWIDNnjPbbe1bQrkyL/TGs2q0nvmlZsv1AbquAEUheg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fWk8VlvxPLGnGWS3qHf5fAODCLUbPPbyfHOPVNGroXoFJX7PFoo2ewqQlXJmD4YGp4yhnSrKDNlO5mYllBZTd+2rpDKWdzHNhZsg/E4kwWRWj4XzdoC8zm4hS0OAQxLizxIwXgkdwmIX27YifFKp8NDG5mJLA3GDLUNyJStiUbteWJIxe72jw76AYatNLjIearHx+Pe/BCHvp/5gxQVW7nCG2h657dK2X1BXxWNRP3JDktpLpDOLn0FlHOZz5xFmd2SM4OI7ZrhR7OmRvgTIGOFVi7qM+8Dvi0iT06Bo38yONCrtpkDhKv6V9dvmZBmHiSIV30dNCLPACAH0GOVDwq1VI15zxTSzTT5Lmga8ojYBOJbQ0aqZwZ032bhSZHr01yHPQfePtklEykXbrJAW8hAjmU9hdvKpIsmpWqfGtTuazPSvbVU3C8iaIVbf2iiD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:23.6138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374fd3d5-60f0-4554-b57c-08df181b6457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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

Implement AMDGPU_SPM_OP_SET_DEST_BUF, which attaches a user destination
buffer to an acquired SPM session and (re)starts the hardware monitor.

The buffer is split evenly across the XCC instances of the partition,
each chunk rounded down to 32 bytes and prefixed with a
drm_amdgpu_spm_buffer_header (SPM version, bytes copied, data-loss flag)
so userspace can interpret each chunk on its own. Passing dest_buf =
NULL detaches the buffer and stops SPM on every instance, so the same
operation also serves as the stop path.

Ownership is validated before any state is touched. The optional wait
for the previous buffer to fill drops prof_xcp_mgr->mutex so that other
XCPs can make progress and device teardown is not blocked, so ownership,
teardown and session identity are re-checked after waking.

If starting an instance fails, only the instances started by this call
are stopped again. Partial state from earlier instances is not rolled
back, so userspace must treat any error as fatal and release the session.

Also add amdgpu_spm_interrupt(), the ring-buffer watermark handler. It
runs under spm_irq_lock, records data loss on pre-GFX12 and schedules the
drain work directly on GFX12+. It is wired up to the IH by a later patch.

Note: in this patch the wait condition (are_users_buf_filled) is only
cleared, never set. The waker and the condition setter arrive with the
"implement data dump from spm ring buffer" patch, so until then the wait
can only end on timeout or signal.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 387 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  17 ++
 5 files changed, 410 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index fd87075962f9..dceee30091fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -487,6 +487,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		priv_inst_irq;
 	struct amdgpu_irq_src		bad_op_irq;
 	struct amdgpu_irq_src		cp_ecc_error_irq;
+	struct amdgpu_irq_src		spm_irq;
 	struct amdgpu_irq_src		sq_irq;
 	struct amdgpu_irq_src		rlc_gc_fed_irq;
 	struct amdgpu_irq_src		rlc_poison_irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 79641e537fbb..36b7dbecc8b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_rlc.h"
+#include "amdgpu_spm.h"
 
 /**
  * amdgpu_gfx_rlc_enter_safe_mode - Set RLC into safe mode
@@ -852,3 +853,8 @@ void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgp
 
 	amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(xcc_id));
 }
+
+void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
+{
+	amdgpu_spm_interrupt(adev, xcc_id);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 18b925a0d164..64a4bd36b02c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -391,4 +391,5 @@ int amdgpu_rlc_spm_acquire(struct amdgpu_device *adev, int xcc_id,
 			   struct amdgpu_vm *vm, u64 gpu_addr, u32 size);
 void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgpu_vm *vm);
 void amdgpu_rlc_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id, u32 rptr);
+void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 36a2d2d1f0ed..43b8970f1673 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -23,11 +23,22 @@
 
 #include "amdgpu.h"
 
+/*
+ * SPM revision change log
+ *
+ * 0.1 - Initial revision
+ */
+
+#define AMDGPU_SPM_MAJOR_VERSION	0
+#define AMDGPU_SPM_MINOR_VERSION	1
+
 #define AMDGPU_SPM_RING_SIZE		(4 * 1024 * 1024)
 #define AMDGPU_SPM_META_SIZE		0x20
 
 static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
+static int amdgpu_spm_set_dest_buf(struct amdgpu_spm_mgr *spm_mgr, void *data,
+				   struct drm_file *filp);
 
 /* Check if the calling file owns the SPM session */
 static bool amdgpu_spm_is_owner(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
@@ -59,8 +70,7 @@ int amdgpu_spm_ioctl(struct drm_device *dev, struct drm_amdgpu_spm_args *args,
 		return -EOPNOTSUPP;
 
 	case AMDGPU_SPM_OP_SET_DEST_BUF:
-		/* Implemented in a later patch */
-		return -EOPNOTSUPP;
+		return amdgpu_spm_set_dest_buf(spm_mgr, args, filp);
 
 	default:
 		dev_dbg(adev->dev, "Invalid option: %u\n", args->op);
@@ -161,6 +171,7 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	 */
 	mutex_init(&spm_cntr->spm_worker_mutex);
 	spm_cntr->xcc_mask = xcc_mask;
+	init_waitqueue_head(&spm_cntr->spm_buf_wq);
 
 	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
 	spm_mgr->spm_cntr = spm_cntr;
@@ -170,6 +181,7 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 		ret = _amdgpu_spm_acquire(spm_mgr, inst, filp);
 		if (ret)
 			goto acquire_spm_failure;
+		spm_mgr->spm_cntr->spm_use_cnt++;
 	}
 
 	spm_mgr->file = filp;
@@ -200,6 +212,50 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	return ret;
 }
 
+static int _spm_start(struct amdgpu_spm_mgr *spm_mgr,
+		      struct amdgpu_device *adev, int inst)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct amdgpu_spm_base *spm = &spm_mgr->spm_cntr->spm[inst];
+	unsigned long flags;
+	int ret;
+
+	lockdep_assert_held(&prof_xcp_mgr->mutex);
+
+	/* Set flag before enabling hardware to avoid dropping interrupts.
+	 * amdgpu_rlc_spm_cntl() will reset SPM and wptr will become 0,
+	 * adjust rptr accordingly.
+	 */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spm->is_spm_started = true;
+	WRITE_ONCE(spm->ring_rptr, 0);
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	ret = amdgpu_rlc_spm_cntl(adev, inst, 1);
+	if (ret) {
+		spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+		spm->is_spm_started = false;
+		spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+	}
+	return ret;
+}
+
+static void _spm_stop(struct amdgpu_spm_mgr *spm_mgr,
+		      struct amdgpu_device *adev, int inst)
+{
+	struct amdgpu_spm_base *spm = &spm_mgr->spm_cntr->spm[inst];
+	unsigned long flags;
+
+	amdgpu_rlc_spm_cntl(adev, inst, 0);
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spm->is_spm_started = false;
+	/* amdgpu_rlc_spm_cntl() will reset SPM and wptr will become 0.
+	 * Adjust rptr accordingly.
+	 */
+	WRITE_ONCE(spm->ring_rptr, 0);
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+}
+
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
 {
 	/* TODO */
@@ -228,6 +284,295 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	return 0;
 }
 
+static int spm_update_dest_info(struct amdgpu_spm_mgr *spm_mgr,
+				int inst, struct drm_amdgpu_spm_args *user_spm_data,
+				struct drm_amdgpu_spm_args *user_spm_ptr)
+{
+	struct amdgpu_spm_base *spm = &spm_mgr->spm_cntr->spm[inst];
+	unsigned long flags;
+	int ret = 0;
+
+	mutex_lock(&spm_mgr->spm_cntr->spm_worker_mutex);
+	if (spm->has_user_buf) {
+		struct drm_amdgpu_spm_buffer_header spm_header;
+		u64 __user *user_address;
+		bool data_loss;
+
+		/* The interrupt handler sets has_data_loss under spm_irq_lock,
+		 * so read it under the same lock and report one consistent value.
+		 */
+		spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+		data_loss = spm->has_data_loss;
+		spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+		user_spm_ptr->bytes_copied += spm->size_copied;
+		user_spm_ptr->has_data_loss |= data_loss;
+
+		memset(&spm_header, 0, sizeof(spm_header));
+		user_address = (u64 __user *)((u8 __user *)spm->ubuf.user_addr -
+					      sizeof(spm_header));
+		spm_header.version = ((u32)AMDGPU_SPM_MAJOR_VERSION << 24) |
+					AMDGPU_SPM_MINOR_VERSION;
+		spm_header.bytes_copied = spm->size_copied;
+		spm_header.has_data_loss = data_loss;
+
+		if (copy_to_user(user_address, &spm_header, sizeof(spm_header))) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		/* Commit state changes only after successful copy_to_user */
+		spm->has_user_buf = false;
+		WRITE_ONCE(spm_mgr->spm_cntr->have_users_buf_cnt,
+			   spm_mgr->spm_cntr->have_users_buf_cnt - 1);
+	}
+	if (user_spm_data->dest_buf) {
+		spm->ubuf.user_addr = (u64 __user *)user_spm_data->dest_buf;
+		spm->ubuf.ubufsize = user_spm_data->buf_size;
+		/* reserve space for drm_amdgpu_spm_buffer_header */
+		spm->ubuf.user_addr = (u64 __user *)((u8 __user *)spm->ubuf.user_addr +
+						     sizeof(struct drm_amdgpu_spm_buffer_header));
+		spm->ubuf.ubufsize -= sizeof(struct drm_amdgpu_spm_buffer_header);
+		spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+		spm->has_data_loss = false;
+		spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+		spm->size_copied = 0;
+		spm->is_user_buf_filled = false;
+		spm->has_user_buf = true;
+		WRITE_ONCE(spm_mgr->spm_cntr->are_users_buf_filled, false);
+		WRITE_ONCE(spm_mgr->spm_cntr->have_users_buf_cnt,
+			   spm_mgr->spm_cntr->have_users_buf_cnt + 1);
+	}
+out:
+	mutex_unlock(&spm_mgr->spm_cntr->spm_worker_mutex);
+	return ret;
+}
+
+static int spm_wait_for_fill_awake(struct amdgpu_device *adev,
+				   struct amdgpu_spm_cntr *spm_cntr,
+				   struct drm_amdgpu_spm_args *user_spm_data)
+{
+	long timeout = msecs_to_jiffies(user_spm_data->timeout);
+	unsigned long start_jiffies = jiffies;
+	long rem;
+	int ret = 0;
+
+	rem = wait_event_interruptible_timeout(spm_cntr->spm_buf_wq,
+						READ_ONCE(spm_cntr->are_users_buf_filled),
+						timeout);
+
+	switch (rem) {
+	case -ERESTARTSYS:
+		ret = -ERESTARTSYS;
+		/* Subtract elapsed time from timeout so we wait that much
+		 * less when the call gets restarted.
+		 */
+		timeout -= (jiffies - start_jiffies);
+		if (timeout <= 0) {
+			ret = -ETIME;
+			timeout = 0;
+			dev_dbg(adev->dev, "[%s] interrupted by signal\n", __func__);
+		}
+		break;
+
+	case 0:
+		/* Timeout expired */
+		ret = -ETIME;
+		timeout = 0;
+		break;
+
+	default:
+		/* Woken up before timeout */
+		timeout = rem;
+		break;
+	}
+	user_spm_data->timeout = jiffies_to_msecs(timeout);
+
+	return ret;
+}
+
+static int amdgpu_spm_set_dest_buf(struct amdgpu_spm_mgr *spm_mgr, void *data,
+				   struct drm_file *filp)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct drm_amdgpu_spm_args user_spm_data, *user_spm_ptr;
+	struct amdgpu_device *adev = prof_xcp_mgr->adev;
+	struct amdgpu_spm_cntr *spm_cntr;
+	bool need_schedule = false;
+	bool drained = false;
+	u32 started_mask = 0;
+	u32 xcc_mask;
+	u32 ubufsize;
+	int ret = 0;
+	int inst;
+
+	dev_dbg(adev->dev, "SPM start to set new destination buffer.\n");
+	mutex_lock(&prof_xcp_mgr->mutex);
+
+	/* Check ownership */
+	if (!amdgpu_spm_is_owner(spm_mgr, filp)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	spm_cntr = spm_mgr->spm_cntr;
+	if (!spm_cntr ||
+	    !spm_cntr->spm_use_cnt) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Use the xcc_mask cached at acquire time rather than re-querying it:
+	 * spm[] was set up against that mask and spm_use_cnt counts exactly its
+	 * instances. Re-querying could return a different mask and desynchronize
+	 * the per-instance chunk size from the instances iterated below.
+	 */
+	xcc_mask = spm_cntr->xcc_mask;
+
+	user_spm_ptr = (struct drm_amdgpu_spm_args *)data;
+	/* spm_use_cnt is guaranteed non-zero by the check above */
+	ubufsize = user_spm_ptr->buf_size / spm_cntr->spm_use_cnt;
+	ubufsize = round_down(ubufsize, 32);
+
+	memcpy(&user_spm_data, user_spm_ptr, sizeof(user_spm_data));
+
+	/* Only validate ubufsize when dest_buf is provided (non-NULL).
+	 * When dest_buf=NULL (stop/unset operation), buf_size=0 is valid.
+	 */
+	if (user_spm_data.dest_buf &&
+	    ubufsize <= sizeof(struct drm_amdgpu_spm_buffer_header)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	user_spm_data.buf_size = ubufsize;
+
+	/* have_users_buf_cnt and are_users_buf_filled are protected by
+	 * spm_worker_mutex. Use READ_ONCE for lockless reads to avoid races
+	 * with worker modifications.
+	 */
+	if (user_spm_data.timeout && READ_ONCE(spm_cntr->have_users_buf_cnt) &&
+	    !READ_ONCE(spm_cntr->are_users_buf_filled)) {
+		/* Drop mutex during wait to allow concurrent operations on other XCPs
+		 * and to prevent blocking device teardown. Safe because wait condition
+		 * (are_users_buf_filled, releasing) doesn't require this mutex.
+		 */
+		mutex_unlock(&prof_xcp_mgr->mutex);
+
+		dev_dbg(adev->dev, "SPM waiting for fill awake, timeout = %u ms.\n",
+			user_spm_data.timeout);
+		ret = spm_wait_for_fill_awake(adev, spm_cntr, &user_spm_data);
+
+		/* Re-acquire mutex */
+		mutex_lock(&prof_xcp_mgr->mutex);
+
+		/* Write back updated timeout to userspace before checking
+		 * cancellation conditions, so userspace always sees the
+		 * remaining timeout regardless of which error path we take.
+		 */
+		user_spm_ptr->timeout = user_spm_data.timeout;
+
+		/* Check if XCP was torn down while we slept */
+		if (READ_ONCE(prof_xcp_mgr->torn_down)) {
+			ret = -ECANCELED;
+			goto out;
+		}
+
+		if (!amdgpu_spm_is_owner(spm_mgr, filp)) {
+			ret = -ECANCELED;
+			goto out;
+		}
+
+		if (spm_mgr->spm_cntr != spm_cntr) {
+			ret = -ECANCELED;
+			goto out;
+		}
+
+		if (ret == -ETIME) {
+			/* Copy (partial) data to user buffer after a timeout */
+			schedule_work(&spm_mgr->spm_work);
+			flush_work(&spm_mgr->spm_work);
+			drained = true;
+			/* This is not an error */
+			ret = 0;
+		} else if (ret) {
+			goto out;
+		}
+	} else if (!user_spm_data.timeout && READ_ONCE(spm_cntr->have_users_buf_cnt)) {
+		/* Copy (partial) data to user buffer */
+		schedule_work(&spm_mgr->spm_work);
+		flush_work(&spm_mgr->spm_work);
+		drained = true;
+	}
+
+	/* Drain before stopping: _spm_stop() clears is_spm_started and resets
+	 * rptr, so anything left in the ring is unrecoverable afterwards.
+	 */
+	if (!user_spm_data.dest_buf && !drained &&
+	    READ_ONCE(spm_cntr->have_users_buf_cnt)) {
+		schedule_work(&spm_mgr->spm_work);
+		flush_work(&spm_mgr->spm_work);
+	}
+
+	user_spm_ptr->bytes_copied = 0;
+	user_spm_ptr->has_data_loss = 0;
+	user_spm_ptr->timeout = user_spm_data.timeout;
+	for_each_inst(inst, xcc_mask) {
+		struct amdgpu_spm_base *spm = &spm_cntr->spm[inst];
+
+		if (READ_ONCE(spm->has_user_buf) || user_spm_data.dest_buf) {
+			/* Get info about filled space in previous output buffer.
+			 * Setup new dest buf if provided.
+			 */
+			ret = spm_update_dest_info(spm_mgr, inst, &user_spm_data, user_spm_ptr);
+			if (ret)
+				goto start_failure;
+		}
+
+		if (user_spm_data.dest_buf) {
+			/* Start SPM if necessary */
+			if (!READ_ONCE(spm->is_spm_started)) {
+				ret = _spm_start(spm_mgr, adev, inst);
+				if (ret)
+					goto start_failure;
+				started_mask |= (1u << inst);
+			} else {
+				/* If SPM was already started, there may already
+				 * be data in the ring-buffer that needs to be read.
+				 */
+				need_schedule = true;
+			}
+			user_spm_data.dest_buf += ubufsize;
+		} else {
+			/* Lock out the drain worker while SPM is stopped, so it
+			 * cannot write a stale rptr over the reset.
+			 */
+			mutex_lock(&spm_cntr->spm_worker_mutex);
+			_spm_stop(spm_mgr, adev, inst);
+			mutex_unlock(&spm_cntr->spm_worker_mutex);
+		}
+	}
+	goto out;
+
+start_failure:
+	/* Stop only instances that were started in this iteration.
+	 * Partial state (bytes_copied, ubuf, has_user_buf) from earlier instances
+	 * is not rolled back. Userspace must treat any error as fatal and release
+	 * the SPM session.
+	 */
+	mutex_lock(&spm_cntr->spm_worker_mutex);
+	for_each_inst(inst, started_mask)
+		_spm_stop(spm_mgr, adev, inst);
+	mutex_unlock(&spm_cntr->spm_worker_mutex);
+
+out:
+	mutex_unlock(&prof_xcp_mgr->mutex);
+	if (need_schedule)
+		schedule_work(&spm_mgr->spm_work);
+
+	dev_dbg(adev->dev, "SPM finish to set new destination buffer, ret = %d.\n", ret);
+	return ret;
+}
+
 void amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr)
 {
 	amdgpu_spm_init_device(spm_mgr);
@@ -243,3 +588,41 @@ void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
 {
 	amdgpu_spm_release(spm_mgr, NULL);
 }
+
+void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
+{
+	u8 xcp_id;
+	unsigned long flags;
+	struct amdgpu_spm_mgr *spm_mgr;
+	int part;
+
+	if (WARN_ON_ONCE(xcc_id >= MAX_XCC))
+		return;
+
+	part = adev->xcp_mgr ? amdgpu_xcp_get_partition(adev->xcp_mgr, AMDGPU_XCP_GFX, xcc_id) : 1;
+	if (part <= 0)
+		return;
+
+	/* GFX inst_masks are disjoint per XCP, so exactly one bit is set. */
+	xcp_id = fls(part) - 1;
+	if (WARN_ON_ONCE(xcp_id >= MAX_XCP))
+		return;
+
+	spm_mgr = &adev->prof_mgr.prof_xcp_mgr[xcp_id].spm_mgr;
+
+	/* Watermark threshold is triggered.
+	 * Pre-GFX12: HW interrupt only sets has_data_loss flag; drain work is
+	 * scheduled by the 100us polling thread in amdgpu_spm_monitor_thread.
+	 * GFX12+: HW interrupt directly schedules drain work as polling is not needed.
+	 */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	if (spm_mgr->spm_cntr && spm_mgr->spm_cntr->spm[xcc_id].is_spm_started) {
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0))
+			spm_mgr->spm_cntr->spm[xcc_id].has_data_loss = true;
+		else
+			schedule_work(&spm_mgr->spm_work);
+	}
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	dev_dbg(adev->dev, "[SPM#%d:%d] ring buffer stall.\n", xcp_id, xcc_id);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index d59c3d93a64d..eaeb880e209c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -29,11 +29,23 @@ struct drm_file;
 struct drm_amdgpu_spm_args;
 struct amdgpu_bo;
 
+struct spm_user_buf {
+	u64 __user *user_addr;
+	u32 ubufsize;
+};
+
 struct amdgpu_spm_base {
+	struct spm_user_buf ubuf;
 	u64    gpu_addr;
 	u32    ring_size;
+	u32    ring_rptr;
+	u32    size_copied;
+	bool   has_data_loss;
 	void   *cpu_addr;	/* Metadata area (first u32 = wptr) + ring data (u64 array) */
 	struct amdgpu_bo *spm_obj;
+	bool   has_user_buf;
+	bool   is_user_buf_filled;
+	bool   is_spm_started;
 };
 
 struct amdgpu_spm_cntr {
@@ -44,8 +56,12 @@ struct amdgpu_spm_cntr {
 	 */
 	struct amdgpu_spm_base spm[MAX_XCC];
 	u32 xcc_mask;  /* Cached from acquire; avoids error handling in release */
+	u32 spm_use_cnt;
 	/* Protects dest-buffer state and worker operations */
 	struct mutex spm_worker_mutex;
+	wait_queue_head_t spm_buf_wq;
+	u32   have_users_buf_cnt;       /* Updated under spm_worker_mutex; read locklessly via READ_ONCE */
+	bool  are_users_buf_filled;     /* Updated under spm_worker_mutex; read locklessly via READ_ONCE */
 };
 
 struct amdgpu_spm_mgr {
@@ -67,5 +83,6 @@ void amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_mgr_release_owner(struct amdgpu_spm_mgr *spm_mgr,
 				  struct drm_file *filp);
+void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id);
 
 #endif
-- 
2.34.1


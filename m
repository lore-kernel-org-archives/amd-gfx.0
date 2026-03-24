Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71713FEC118
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4DF10E5A1;
	Tue, 24 Mar 2026 21:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sauxaAFW";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B66B10E326
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5QaCAihn3NbWgmhgvDob5x3HQeQvBTsbkXB/7evhnmjFck7RymGTzq24Rzp/JFuAXjKqv8dOJaboOpHBkaU1G4P4h+GKItrzxAG9rF037/98ePM+0oigyh9tbqBjZ9Hj8T47djtZADi2oGzZxcEDBERITGqBWlZ7wY9exDJle/gtziXICHn3sU4UhQ9729t53AuyJLYtDmwm/V+w+6ljAt95Aj3sXifgQCK4ogJMD2ln3svaSMvM/2oyN06Z0fymnLu4HebzCQNKuvctDiTI/GswuMso+WUuADWtk0dCHFgC3g+W/zChNanRdjfVqFc289X2/uWu11whw+jaxWJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXwuUziEgTxpmbyzxbNi3YqGFMvhJqCVk9sxNlMh44Q=;
 b=t0eA6zLNKdag9P52HDF0iW3LtVyHWs/CcFWShLqACpk0043DBGa702fRzwglTOzXju60DQP9B7AKoJKDSrtlqM1KlpW56W30Q5Jonq9vkK3c8vNfRY+ka/GtJ8rb/J9YkjJj56c09RvirklndMlqXj0qOVNCilf87+3lSOYePN6Q+Cdul79UQfQOqRHGAfdw8wbTpCmN13Ya5jYZFI5y3Izx9iLEkt64Cf9bGY4mDScoHGCFaFPHoiY+U0YK51QU9YxI9H7yQOm9YOfr64i4YAvxLHzV9kidNhTVgj/XtvjPxTcJbYDZXdXMIHJOYocBC8E/Lz6p0y8Fs6npXjNgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXwuUziEgTxpmbyzxbNi3YqGFMvhJqCVk9sxNlMh44Q=;
 b=sauxaAFWW9iWF7J5iWg99407rsutV+f0/ga3v8Bv261CEp9dxJaErXWoCa9MB5kzGxzPYtTZlofoktoRWmclxUYk8EKL84MCwsCk6fYknqoi+ePJfQ3PNXrQrdCCIIdHV5yZKxSjZOJ+g5o4tWecELF0E7rPaT5Zdpw0xmucyjI=
Received: from SA0PR11CA0186.namprd11.prod.outlook.com (2603:10b6:806:1bc::11)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:58 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::24) by SA0PR11CA0186.outlook.office365.com
 (2603:10b6:806:1bc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:58 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:46 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 12/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_RELEASE
Date: Tue, 24 Mar 2026 17:20:25 -0400
Message-ID: <20260324212030.822932-13-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: bb088c3a-98ed-4777-e612-08de89eb3ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: R0wJA0oW9v7tck6h6x4C1G0ltDembhepRyy/i++q2myOQKUkTPM5R9IGDkWpQ7ZchpZR07kOo4llQOIknAXmBUcCdm46U3HHM0mhrV+0yiM20v/F6w3LMTVWidIe2GdENKW6fLcE1LJw7smdJimDZyp01jhVunDzgc6fXxwJ91OQ7A6OtD8JqPXhlfHYZnNV5nSp4QyZqab5IAoDdsGqjVLLWUWEkx77+0UEzTWI6xqf1HlYUHCF3zlNgV0ZhuqTZNps02shkFo6IzYQzVnfvPkr/MRFehiTlzsbYo5pwtGKJmuAeyC1Sd+tDIB8vZz9f1rOk9te8AzHkJEibEWVaS8CAqoFDEKHN1g9kk7Hfq97qDiQg2BGyW+vm5GruTvEnTcJd92W2H7jsdCNCMuEg4sL4aS6YsYldMSGnhpk4NRl/Z+fmC3zEjNTzIl+p+1WByWEIpmWgCgKl5gKR4sPJQsXed4O8oamFFoBcHGcgxvrpFs2UW50yUrqG5zL37LdqG8Zxshg3IquMoDJAM8UwnLVE9gJCDuHNWJJNtZFnoXYEDir7DxOUxBNDM7q57m3MXFkYxyC8ndy/CnnlEBzEfD6ssxLpRnc9B2ljlt7vRp9Khfy/SY9R3VdotrcZmv/iZt26y7vNF2D7968YyPYlKDumpIKFoDE4V23CIwJEF2psg2kk52AwJnU14sU0NIWSeRoVaIbh+crBqk6ugIJHG2dR7bhaFjnAmtHzTfUm4NpNaz4kzfB7HZrWGRlYk399tdmcHco1y5yuOgLuThdhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DW8ueJWT+vT+FANza8nFFrNX2oGB4GYhstW3nTRLTGuP6ujHuq69BKeO2JX/y67RcGZQFgmR3guM6sgItPVvlhEyxGhXcwkCFnqAE2Q+tRof7gRPljUyKqrK/qtmVu/Le37oD0hBruoshst2wDtGBCr8F96lbJ5pV9ZNQ5II5vqR46Ga3JzLjsB3cehbpaP7AWvs1SYmKdpZzZ90DprFN2AVaHZfNrd5Qff8Aj4lAvfS8uuEiZRKYbymb3Y6wHqccJi6nWGVPngxqIixwz0C2Y4ET/8ht4FHGAAcreQiOs9/zOH84AN+KPNi2/iC2YF6evPoW/GvmJz4kjGeiXTu8f3pHkyN/eqsZ226+AtWk5gqkUI6y67y6rPLugAABCQc4/tXDOncvxs7cHAceFdFXq1ZLZ5kWGi/1n8aumCF+X7Fl4xJgK5pn8aeo3QXU4o9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:58.0778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb088c3a-98ed-4777-e612-08de89eb3ddc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
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

to implement AMDGPU_SPM_OP_RELEASE, which stops the SPM hardware, drains
the work queue, unblocks any waiting SET_DEST_BUF callers, and frees
all per-XCC ring buffer resources acquired by AMDGPU_SPM_OP_ACQUIRE.

_amdgpu_spm_release(spm_mgr, inst, filp):
  Per-XCC teardown helper. Skips silently if the ring buffer was never
  allocated (ring_size == 0). Otherwise:
  - Calls amdgpu_rlc_spm_release() to stop the RLC hardware, revert
    the SPM VMID to 0xf, and free the reserved VMID on the GFX hub.
  - Calls amdgpu_bo_free_gtt_mem() to unpin, unmap, and drop the 4 MiB
    GTT ring buffer BO.
  - Under spm_irq_lock, zeroes the entire amdgpu_spm_base entry to
    prevent stale pointer access from any concurrent IRQ path.
  - Decrements spm_use_cnt.

amdgpu_spm_release(spm_mgr, filp):
  1. Takes the per-XCP prof_xcp_mgr->mutex to serialize against
     concurrent ACQUIRE or SET_DEST_BUF calls.
  2. Returns -EPERM if the caller's drm_file does not match
     spm_mgr->file, preventing one process from releasing another's
     SPM session.
  3. Returns -EINVAL if SPM was never acquired (spm_cntr == NULL).
  4. For each XCC in AMDGPU_XCC_MASK(adev): clears is_spm_started
     under spm_irq_lock, then stops the hardware via
     amdgpu_rlc_spm_cntl(stop).
  5. Calls flush_work() to wait for any in-progress ring drain to
     complete before freeing buffers.
  6. Calls wake_up_all() on spm_buf_wq to unblock any thread sleeping
     in SET_DEST_BUF with a pending timeout.
  7. Calls _amdgpu_spm_release() for each XCC to free per-XCC resources.
  8. Calls amdgpu_vmid_free_reserved() to release the GFX hub VMID
     reservation on hub 0.
  9. Destroys spm_worker_mutex, frees spm_cntr, and sets spm_cntr = NULL
     under spm_irq_lock to prevent the IRQ handler from scheduling new
     work after the memory is freed.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 56 +++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 896a0fef576c..d4af195bbcd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -150,14 +150,61 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
 {
-	/* TODO: */
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	unsigned long flags;
+
+	if (!spm->ring_size)
+		return;
+	amdgpu_rlc_spm_release(adev, inst, drm_priv_to_vm(filp));
+	amdgpu_bo_free_gtt_mem(adev, &(spm->spm_obj));
+
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	memset(spm, 0, sizeof(*spm));
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 
+	--spm_mgr->spm_cntr->spm_use_cnt;
 }
 
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
 {
-	/* TODO */
-	return 0;
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	unsigned long flags;
+	int inst;
+	int ret = 0;
+
+	mutex_lock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	if (spm_mgr->file != filp) {
+		ret = -EPERM;
+		goto out;
+	}
+	if (!spm_mgr->spm_cntr) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+		spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+		spm_mgr->spm_cntr->spm[inst].is_spm_started = false;
+		spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+		amdgpu_rlc_spm_cntl(adev, inst, 0);
+	}
+	flush_work(&spm_mgr->spm_work);
+	wake_up_all(&spm_mgr->spm_cntr->spm_buf_wq);
+
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev))
+		_amdgpu_spm_release(spm_mgr, inst, filp);
+	amdgpu_vmid_free_reserved(adev, drm_priv_to_vm(filp), AMDGPU_GFXHUB(0));
+
+	mutex_destroy(&(spm_mgr->spm_cntr->spm_worker_mutex));
+	kfree(spm_mgr->spm_cntr);
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spm_mgr->spm_cntr = NULL;
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+out:
+	mutex_unlock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	return ret;
 }
 
 static int spm_update_dest_info(struct amdgpu_spm_mgr *spm_mgr,
@@ -365,6 +412,9 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
 	case AMDGPU_SPM_OP_ACQUIRE:
 		return amdgpu_spm_acquire(spm_mgr, filp);
 
+	case AMDGPU_SPM_OP_RELEASE:
+		return amdgpu_spm_release(spm_mgr, filp);
+
 	case AMDGPU_SPM_OP_SET_DEST_BUF:
 		return amdgpu_set_dest_buffer(spm_mgr, data);
 
-- 
2.34.1


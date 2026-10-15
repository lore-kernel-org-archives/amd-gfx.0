Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598D8CC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 07:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D363610E9EC;
	Thu, 15 Oct 2026 07:22:11 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AE310E9EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 07:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytqWTyHc5LvZkCx+Da5HOQj6JNuSPZGjXsMM0PnqqVaUucE2NVHHp2+l+6hQmbns3q60BOVSIqfE2PB3RT4ke5ccMuLW8XOnk+ww0JI1ioKhW6YPsVGOIAXNpWWyIx/cmUznY5mDi0Y2f28899NcrLWQn5PViwhej5tcNusSIFMSpv9ULTJF5X66NwitsWK1Q7AMgTAAO2fTTX1Ehc9dDiOLM0TrtLwKLRAW7CBxJ62WUEanNGbuX6uH2PpY1CGMz5r0vbYS55Iqvd1QIaVliQWgtFs5nH3DK3WNfI1R5242p5/MdR0l0Bm6Q7lmYR7+ygOmg7MCsTwUaWspetIJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qb7Xf+Lou+p7q2Ym/2KC4z00RoOh0x2PiAzLwX2d/A=;
 b=sJTb0MVzsGauadyGmSFtKpmm5R53wuAgP9UYvffoRhszx9ASTAvuIcZtyZr3ANq+twCJZ58TN0eH2dwrkhOIb/pqfgmlCiFBIwliKIbOwaozgpzIBzN4zj+4UQavBeV6Y2FAFMcxZSuLh1/GjrllLE54QDYJwZ3QYCT7AvpdN0MxU8AUoOnoNMnzFF/Bihatyf2xb3UKvU5k8sQLr/xUmhoMIZTrKmRn5guoVsNquO4ZmXhnkqlPj6me9ZPtSlPr+tNUM0f351TBUrBnz97uWfxCK/zamfvmbv8yzvfD/5MbBfv9pWJta0PJVQjPUGmIptcGJ2VYZlwDp2eEMkFtCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qb7Xf+Lou+p7q2Ym/2KC4z00RoOh0x2PiAzLwX2d/A=;
 b=GQj/2BSr1vw8SKlCRqt2za6ZE2ENTP7kX8hPvEZGHKkWXH1wmHRfd9El3N8cvERl6EOaK1SIYCZ7jyIbo4TfSjPj8mAQ42YS3jqpA+/baPYOmNmkjlgeJL4QX+Hq6nnkSxttxYCtTK+/m5p+erLF5SiJJDTaxKdhnBlra78xZhA=
Received: from BN1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:408:e2::19)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 07:22:00 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::52) by BN1PR13CA0014.outlook.office365.com
 (2603:10b6:408:e2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 07:21:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Thu, 15 Oct 2026 07:21:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 02:21:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 15 Oct 2026 02:21:49 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: map the seq64 memory when restoring user
 queues
Date: Thu, 15 Oct 2026 15:19:30 +0800
Message-ID: <20261015072150.3414162-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d39c1ac-3744-482f-f777-08df2a8d000a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: e5IqGDBb9N3QhpZnoe6xpxbHXvdwalGfQiO+z96QhyNiFBBtX7HImlvbDnf98TGvVcuf7Vt0tdnzda/3c1yr9VXYDoUwwLaa1zZSu6VOVLSi5kF++ZKPQSSHZSpwd2hr//vR5opoHIEOIOgWAawPB2p0yD8ygmYgk5shtuKLlX/nKRDcwn4wV/uGV77RObjA64jTEglLI1bw475fXXZubIwvnA1UVw4Dvg09oII4Pn9ZZMedGBuzxq5fh/512DAFX23W2HTTTyI+ptGxHe45Q/YHaj0mQVLZ552H1TKWG2pDIJsGWFbw39DH2SxHxT8/9jYvrBE4K2yTkAo4ukfhKp4SMBthVuGZTcaMZe0nbfBiGktHoIlXuB+mpOT7ifAH2RXMdS0+Xr9ahWJcMSZ6UI1Dtn8+oTXtIQRWUQg6dVvKxTkavD+mm1scG5pIUV4MdJGlNdJ+1DafZ1dZwfknaZbzMq1YfSep6VBbK3bOmtJIGaRPXQSV9/S242U3bDOIXVNWwwNv0TdUKpCAvN5evOyFR5N2b9xG9uVXq5YUDtJIqoZpP3YzQe1NOAYnYuAal5xl5I15pfg21CzycOFYgfuI8mwL1q7QlKT0gqOKD8TTnScOql9SAhZZrzHTm69RhMPrIwpGpo8MEL5yIMaA5RdLFUMX+k/wucYiByoMDRIri0oz/A0hdiNMw8iIh9g9aicoTeI8UFf3/+cHqX1YhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ru3Aqe5uqZpATHY6d3ZQeatlqV46h0jLsO8IPsp/lyyoyzeDJWzB/AtVLIG7SB/kyHseYh8CSnmtrPk5sfly5i12EXWuWPDi1zHGMezaPzTrzTpn0dlm6QV5xxha7nXk5FszFvkHpmYcxKdk3WAFewp6IMGAo0HtzYYKEvO3vPIIs+L9qk7nQB8El/fEXgs5Lyix9EdncSV2y1c8GYDqaE87Q7ShD8Fv+GaeTcDn3zFNRSTiB9y/Wplw7DC1aRTFvmsv9v5HtyJNRriRhTCodaAkJm6x4ZEJKFwtTWr44u+PG8+6VCrPLbyDkY4bQKz8nWAzwDvFERm4wKCsOK7Ew9QQ/JmBT3FS/8qEqH4KWuk8MjJvvF3YAUaS/+joQdhWnWCQaq1crD75gjseklRbiZevonRamibUfXhMORqw1O6fMtKJA31xeJQFKjAi9TeE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 07:21:58.8934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d39c1ac-3744-482f-f777-08df2a8d000a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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

Since the seq64 mapping of a VM only gets its page tables updated by the
CS ioctl, a process which only uses user queues never has its seq64
memory mapped. USERQ_WAIT hands out the seq64 address of user queue
fences for the GPU to wait on, so a queue waiting for an earlier job
faults on it and hangs.

A GFX user queue waiting with FENCE_WAIT_MULTI for the
already signaled fence of its previous job (va 0xffffffffffc00000 from
USERQ_WAIT) never gets past the wait:

  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:24 vmid:8 pasid:13)
  amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: CPG (0x6)

Update the seq64 mapping where the user queues get their VM restored,
which also happens before the first queue of a file is mapped, once the
page tables are validated again, and wait for it like for the other
page table updates. Only do it when the PTEs aren't there yet or were
cleared, so that restoring after every eviction doesn't write them again.

Fixes: ae05e3f3d02b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4dca1ab48410..94b9e6890f91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1070,6 +1070,12 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		if (unlikely(ret))
 			goto unlock_all;
 
+		/* The pinned seq64 BO only needs a slot for the rearm */
+		ret = drm_exec_prepare_obj(&exec, &adev->seq64.sbo->tbo.base, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
+			goto unlock_all;
+
 		/* This validates PDs, PTs and per VM BOs */
 		ret = amdgpu_vm_validate(adev, vm, NULL,
 					 amdgpu_userq_validate_vm,
@@ -1140,6 +1146,18 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	/*
+	 * The seq64 mapping is kept up to date by the CS path only, but the
+	 * queues wait for user queue fences through their seq64 address. Its
+	 * PTEs only need writing when they aren't there yet or were cleared,
+	 * e.g. by amdgpu_vm_handle_moved() after a VRAM loss.
+	 */
+	if (!list_empty(&fpriv->seq64_va->invalids) || fpriv->seq64_va->cleared) {
+		ret = amdgpu_vm_bo_update(adev, fpriv->seq64_va, false);
+		if (ret)
+			goto unlock_all;
+	}
+
 	key = 0;
 	/* Validate User Ptr BOs */
 	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
@@ -1203,6 +1221,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	 * it explicitly (as the CS path syncs it) before restarting queues.
 	 */
 	dma_fence_wait(fpriv->prt_va->last_pt_update, false);
+	dma_fence_wait(fpriv->seq64_va->last_pt_update, false);
 	dma_fence_wait(vm->last_update, false);
 
 	xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
-- 
2.50.1


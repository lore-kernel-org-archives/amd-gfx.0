Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A922ECD5BAF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 21:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E07D10F411;
	Thu, 21 May 2026 21:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gUHV5VaQ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1113010F411
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 21:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQGZkyP8yBBv0VIHSLadW6DD5eEil3UyZ19H+0qujmoX7k99ajbdU5FO/30wGc039f+3qy/HIdu8lEts7y7nT+9WIpYGrRz4g0aKUPBjQF07+7yzgMSeukTuYm0Od96XAm8ZB+McUu6IWnm+TUFnlc1E4ZQx4pvXvL/24kUXd/nEqOs1uxpFfUKWSqUPzZ7R2w8X/3BYV1JmENHXFOUCxXN+K5FEuM0jSccl7VCfZurcf6qP5fFInAAUyuHixtUDiaoRjRlve9BlASwnovGJT8wwRH4Hx77V82ZsQOAaNARS/jXA3ocyBSF0jSbQJw9Ej/k6cDfrlji4UriLnejSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZP870GiS1VE7z5XQHZV+3Nc/4uZFsksYYffT+hhGSg=;
 b=Sd29vH2fefzofkLLpx7oG2SXwUkahL5Ab9Fe7x3Gh5ZcMmYkg5fBuqiuzyTgiQCcP98ckDDK1//BKylxkXGoMfPYo4v3fH1mR+jpDsWG8dP/r2O0asOjRMcklVyw1+q+oJUoWXaCY40QbJLf7QKpFMR1+ChYFrbwoxrNmOEhiV6toeCC9X5pgoWTY60oBWWHzgBxD3lxsTHJqQaAFBoxE/gpNyjcEIAAgq6uxOaho6J4PTf8dRqGwIIqLp5ffykAAipUEyFE5A5jymTuOsVWinWtsnnNMSNWYccXzZldTpKQupoAmSNQ2ASuxWM1UGfu08jElIU3HN0ukDMelpbxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZP870GiS1VE7z5XQHZV+3Nc/4uZFsksYYffT+hhGSg=;
 b=gUHV5VaQm40WDZ494pdRsSC2OeflxxytY+ZWQPa/5khKgV5OXGD3swoIjOl0gVB6OlCFSFm2rK0bQ9P2h7GXE2ZAi996OJO4LwXH6EKhrNfmNOYOu3uuFv1bl712SqYlBcZ4pVFdPEesjiAxwwyHhnu1lD2MwSMUz9JtFDIpD98=
Received: from BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::13)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 21:42:12 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::9a) by BL1P223CA0008.outlook.office365.com
 (2603:10b6:208:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 21:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 21:42:11 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 16:42:06 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Bing.Ma@amd.com>
CC: <jamesz@amd.com>
Subject: [PATCH v3 12/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_RELEASE
Date: Thu, 21 May 2026 17:41:51 -0400
Message-ID: <20260521214151.1936004-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-13-James.Zhu@amd.com>
References: <20260324212030.822932-13-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: a5988ebb-cab6-4015-c77f-08deb781d0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: wedY5eptvADsZWkPLkRGjGRmrWxij3NWoE7QjldLhTgU02SuGLpK8TC0vYPbBdu/ev7jfnylQ/CivF7jsG6b3Syl6WpYMndJeYEasb0ENf0dyDssZ5gUAmh+vO24NVX6wflKvVYGPj7ZFoSZSazVmJ+RtoxDURwRflX7TC//iMY9340QygAVDJFiodfTbhqvS4Zrr/0VWpFvPBAR/mrynybJCrJz3+HfxlHdplgtFqPV/VfyPzSvaOw4K8ATTfVDT74kcwyQbPM3g7MEw2dZ4iioTGydnxxEKOMMmCEAXLrkVmW1mWSBZut5rGK2DX4Ao/Mh4qcaqtIN1VSv5Y1HL6fQL02bPnN7ERYqGXa7xKgq5KsC0FqElLT3s/1MRKat8Qt2+OzIBX71wuTUWgpUZBj8vF5pXlQ0be+qG/NHfQ8+GXL3AA5Kw1fiYnXhmPixhFVY9seQ+alaqKCy/Kp2+NBba4XvMNJnJuDpZlbA6LRnBrJO9OY+ArJngkBdZJ6bbDiafoo8Fhs/mPSP6EhJURos6+sDVI3fFcvAGKKo1hQNiv0ch9iFwFTKBSx0WQWgUgqiggPPvRP8prBlAs2BCQwaDjXeOi/kLlqgRrjG6r4w5iZVYyxaHWfnWR+015hntXVwHIp2x6ZlPvGQ4TbintAyjjbS5N0XZxgWGDaRHAHJcIHJevyLmSESFWQ1qpQ8ULeo69c/t0qXBu9Bpi1xZAIym6YZj8GhvYG4gMPGG7o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /uhxgH/lzqj5z+sNiXc4R9cegPCWZrm9H2Ap0tOPk2yb7zWClzLUo5VgQgFtGEb3V+3MZ3xlUW4Xdsj+h6xoi0Ud1GWxGWvebjUggvwJ0ViQWZJUHVDnQGiRrd+Jza7G1uFlpowBt8jEsGqwftCG9hZvlzljJTd0g4o6Bm11kBspm3Lj4jCpzvzpVvDLVHmnpAhEpNxSYNXy2MHgaVqdCBYfrgs9bAl1wOEv0yAkhbbUEPFtdJxC4ws5ZhpDm3YHZJQaD3odZ+tqq87iBx3JWtr+ZXke4upfIxT02EQ2qkUo164VHPfxlzXn3/I/V4Z4pzFasJAzOquoj97jgHBj+hskU/PcYCG+UknLRruAKIZzZD5sFJvNwQFg6UjFeCDI3Ak+b0CvmqZVLCKn/B7ggDo4pqAwLBZLA2EZWZrwdO56dWuikFvlo03SAfTd0h31
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:42:11.7153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5988ebb-cab6-4015-c77f-08deb781d0f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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

-v3: use _spm_stop

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 56 +++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index be3f86fcf7e4..fb53bfc22bbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -190,14 +190,61 @@ static void _spm_stop(struct amdgpu_spm_mgr *spm_mgr,
 
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
+	/* Stop monitor thread and hardware SPM for all instances.
+	 * Monitor thread is shared across instances and stopped only once.
+	 */
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev))
+		_spm_stop(spm_mgr, adev, inst);
+
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
@@ -392,6 +439,9 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
 	case AMDGPU_SPM_OP_ACQUIRE:
 		return amdgpu_spm_acquire(spm_mgr, filp);
 
+	case AMDGPU_SPM_OP_RELEASE:
+		return amdgpu_spm_release(spm_mgr, filp);
+
 	case AMDGPU_SPM_OP_SET_DEST_BUF:
 		return amdgpu_set_dest_buffer(spm_mgr, data);
 
-- 
2.34.1


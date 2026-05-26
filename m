Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAE0CD5BD0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B856910E68D;
	Tue, 26 May 2026 14:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2+l3CAlV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F71E10E690
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjVGYBPHL0uNzXZTeoSVjzExnuB9z0JF4OGp6JoeM819BAmv7eEEcv2RifJR5Hghq9hDQXhuGlhPo0ZSvg2UP3voCePd8NwbhMgHCJ+97rjtZA1lNXdnjxZYDBepFbPQ9FDLI+gOohP6tnMoI3IUwZz19GnOYfth2Ul+nNQ6cYyeI9e3hVyI2OCg+tn3ONr5yHR3e1V7llahcgCcWVgn169oS8+0/xPNQwBkcwY7u0q5TZJMso9EUqOgXyXg6AbENEqq8YsEdam1g6/4nlrhrLbz/6eFnuWDDCqhagIhkzbIW5ci6OcgyJZdle7cx9N32fqSXlSe3S/B/6gLZS8T7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZP870GiS1VE7z5XQHZV+3Nc/4uZFsksYYffT+hhGSg=;
 b=NP8FQ8yRkhY8r7p7Vczh92IWzczCeNYfNGJQeOLF06cjq6wtYqR0r7pI46YoIqFjJU2llRre/NPEz1EuNPwicrP3VpX4qPvO9K7eAUVbFZSJ/hO24LnIo5rmvIjjHoDc4MxUNWN9Sr6ZNAWWi31fh5QUtWJRcjcrfvlfMN7hTt/yGMzc/ftFSEMD4r1kEMr6YaZPP9Cx1o01n9KDKyVaQ6LVae91IUn/BJWM/KCKzMlNoKkfwsc47gXjUYTuLFH2vncz+mzw0JGDaK3mb40LnUVwVLn9xMdt6XiDSLYg0ro1taY6g9mLC8IOQTEGlT0N9a1hgWkhh2hld1xVYLArNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZP870GiS1VE7z5XQHZV+3Nc/4uZFsksYYffT+hhGSg=;
 b=2+l3CAlVnIS4O80fuN8AHgVGaN/7qZBSqHQzkXbfUmcWWL3Fr1aV1uG93cHG1OFg6FWCAsElkKBUdzPIA/Wp1m4R1j0MZhSRDHDPW2mkEDl2b/Cs/nF9UGxqftYVBJdTlkCNxIokOiV9cldSXwY1NUwYkR8NLWHi41ralVrG29s=
Received: from BN9PR03CA0675.namprd03.prod.outlook.com (2603:10b6:408:10e::20)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 14:12:03 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::34) by BN9PR03CA0675.outlook.office365.com
 (2603:10b6:408:10e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:12:01 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:53 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 12/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_RELEASE
Date: Tue, 26 May 2026 10:11:24 -0400
Message-ID: <20260526141129.592886-12-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a8a030-dafd-4ad1-7c70-08debb30c1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: mUiseakZ+bAv99uw/KbbaDwuq4bKDrtOdyk+gr7ThQK05kWffBsPme+hGjmz+9qWOYBI6birxBGA0fK4ukDXvePlY3PfIQi79xZ40M60WS3+HmdC/aU+ES3DKX+EVCvVCtK2k/+urO9bQoYFKyKEl85jeS9/s+E/3+7pqrenxb1XB//Xil/Ox/b3Vh9sx38KGUD7J1IH/9GsOWYRD+OwUVibKeT90DEmxcRwwz8ppZi0CsmZZDhCEaZ7iyNgx/6qIUEJbAyZAf06bVL+GKTXOf6qLg7VhEO31FUh5PlJUZqmAoxE+YZhUd+sg58DlVHRAHM8woW3m1cmFTkSk8274wr5hTEiuLWPIslKIISpnLvEEbhKXQ0b/UTri++ZKrE77betLfKKNtKifk6zSj+vyZyI/OHhYPOo0NsfdR0sbuHiYR7xWw6nAS7RUxe7Khi/YvoDFtLz6FaF/L15W5PGwluvjORG9+ydV+NSrzL2XjRk3l/wcoQUDPOHRfcWWCsLCSJSHA5NibsHc9vUkLR9LxWNGrV+IPe+FUlXO0agtUE8gBPcqzMDOhdatgSSVAIzV6jLE/z0apd635DaA4b4+cH3pORORZDEJe44RhNRi9HLI5zCt+zVOlpQpArlo3L/UJD6G0oKnuaPB87dg0w936vob2alD8xtvOWg6ouVuFizf7nOWGDInTbILYGGkBsOsSR/MNwAhavkQT66UBSTipP3+jDT9l4nqJmp+tPrg7Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MtaN6xIaOlwpbseFBcsaxPdGQXOlTgBmBgh2dd8r0F8pIE1AcsTsP5r309uMZkJ8jE1Ww7TaJalATn5rzvN9oB1RIjPQ2raKF593lOHWNg7crr+sUM7RHxXe6qfwV8aVwuMjAvtNFqOb1qNjQ/T6cy5WNhIvk1scyTCYjDn/WczAwAtvr97cUUjWvhuk9OSmX2qwMEBouIC7p4MklKFd47eVIlKNOn5Kw89PJ0EaDUKze/OU2dhCfKBTgG9lvpANhd2Qy4L3jqHCpZ/fZhq6t+Nh6YxvseWQ9ko7oaoDsYQZupPShJu7HNThsQ8f4TYAbYQhwLLLe65nht37GPsNIAgQW8KgxqeJX1dYsB0TAEmH5qP+Zv+lzSUtar7V0ocGESzk8dh4k5V9/LxX/q0PjD+KKDTEYEnC4SOf/xp3bDOq+4G+JUvVKGhD6sN3a/LT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:12:01.4112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a8a030-dafd-4ad1-7c70-08debb30c1a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
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


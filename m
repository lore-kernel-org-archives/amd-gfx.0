Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3770EFEC119
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE7C210E482;
	Tue, 24 Mar 2026 21:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oXSAidyz";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C8610E326
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5zFG+NnAf+WTKqZaPyosbb8IFeGMlPgdEoZ8ad6ZmIXs/Pg3rQeergYgpYKRQOAX93kntYOe3uZlg1RDSbLIEsF9mZc5uOE5SlAMd1aiBHHfAwEbcO3Q3QNOI5zWC1YMFFWwE43P6yg5T8EtkVVA+/TCpoDP9RhGqC2bUhtNiketI/veaQPVdVxgsTrhAlMS5KHqCY8p8PrzRbzCzH0fpyjEy9DwO7/nJqoM2rx8xCse41lFyicLLzoGub2y/fLsSGOvaaSVUv0C2ngI8K5U7ffWVW6waJNRNPzoa4WUu4b9i9M3/8B3sQpzkpB/wiwLTMAl7IiO0rVjCRp06KKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi/Zfzu5ZyIXaAbZ/hRQ0yqfYcRKvOy/2zrPiblM0AI=;
 b=LCxaaRI5jW8loRwnXDmLCx/iWXzqKnqDasn/c6cZVp5zs96RyGHPyAEz6Wr+lHuP5Ems7bkg4EUxDCp9V0X/wmqYpyYxZ3wasfA3ANzlvgh9DdIhmsnOestzHewNuCVaPwg5/lJIsrZRi1m8SsP2u80ROGwuzXYSnngpEGNRMY+PvbJ0pQx/FPWNADYha+uN+vs/pkrBUo/ZLZE0iGrBk/DGhSFxgsnGEkouk7z1x9KegbPD5OqVLXk1cNov17q3efagY9dzCVbsQ/bUfh5iKQwFw2txcfDh5trtZaEfZwyTwAiC7GAngdjwsTFN5GouotwQL2cfOz6Z9mFLmw2klQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi/Zfzu5ZyIXaAbZ/hRQ0yqfYcRKvOy/2zrPiblM0AI=;
 b=oXSAidyzI5Wruk3zn8wHYSb1AGmDGdTUPPkPYrB7MvPZOAQPtb7QpSOYDJQh7j0tH7mXw0nqwVeBQgBABJJamq1YUKETCmlgeL1Rhq07+PUcK8mJlnAJIq3fXN2KUGzKGm0hUDU7TC8kbOtXGqsUTnIztDs4+7zrCxeF5p55E2E=
Received: from SA1PR03CA0013.namprd03.prod.outlook.com (2603:10b6:806:2d3::9)
 by CH1PR12MB9720.namprd12.prod.outlook.com (2603:10b6:610:2b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:57 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::25) by SA1PR03CA0013.outlook.office365.com
 (2603:10b6:806:2d3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
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
Subject: [PATCH v2 11/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_SET_DEST_BUF
Date: Tue, 24 Mar 2026 17:20:24 -0400
Message-ID: <20260324212030.822932-12-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH1PR12MB9720:EE_
X-MS-Office365-Filtering-Correlation-Id: 351f2d28-15a0-479f-ed9d-08de89eb3d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nM3EweNk5dTAyyD2tUA7XHAswDe2MYDFcrlp1MLN/hk2G0Uqua5JE//xPB2KLLWXEFcaiXnvy9twfaz3IxevDsvUSb7G5LBgk4UQ4G0M4vpqOSLpqoHtK6wPAuI1ENAhoulgsPdag0aaPuoysmrCvXQzS+mxB7S00dtMG5e7p3aoNphxDhvR26yOCwhpXrZg7KdWUA8bfKOmokksDpbJsPGo8255lpQ5PwUPgjW8MxEzlzzMwvEOTALbN4URrAQKoSrN8lkzCY1bzZAh6lBWrK8J/7iBp+0c8i9DMLTXs+tqajB1hNYdXMSI2yFERs8QVocymtZ9cS+cA1pIV85pe5WxJ2m0uk9U/4FoqO7vWu69O6XYIDa1egsBuVcxOCm/IDE3OOXPKrwL0bUz9hIiCgOY9C/6wdAutyYswTIwvqI68mnKvEgKr5sqniiUY9TErfsVjNaf61FbwBKSil5mUN/xTabvGUnGfwYEqoufAXL9EvJTEeFpiV1IDOX54syw8isUQLpU6cfPR6UJBg1ncW1vwnzYJAgMaZ8DHWfDr3yV4GaC77ZZZd9HUh0hURj2I3z37pLksNhH3ykNksoT5uoTSO+xfieOvRLmfNd+j/UnG1rHcn4rsqKXaKCrgZCensKfahPZbJFyrXFBUnegCO42vJFNNiMyvJX5Hlg7nJn3MPe55lBF40BEpOk29iyhoegl7g1/4YCM+0kxlZjlP9FHhVCQ1QRzR7mESLmKWmljFSApTf5oBH3zrulpruXyMHqQ3DHpvifqLw3g/zf0Qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E/l1PRTeFeCOrp//CTSzJf31l2YbRUAkb2ma5aWeXXKPIvXtJwF5KulJrem0jRCy9cEB3NGFlMQPHejkj7mzV8LD5T+L0uG5704fJTQTvqhcgFV2/phG4Vcey36cq7uGjOpPrbTNBq/xpP3/fFAFe0C797DaEQFRwzqiGX7XU8ZAiarqkCoL6vVl/p16FIM2Mmed50rlhcNpyZV6+hrrI1fLuk8vnT/7rNe0j8phrKMydjJNN4e6pqX0OLLlR1QnBsGUrLbZz3xoq2Ai+teiN45JdJ4ygZWzpQVjsC3spU/2jglcaqmwszRtYNrek6JXJeBFCzkdaLRlpZcYhFJE83secAfgtgPA+FpJT+FQBWlbUgp/1AuLuwHzaGTBBEIGNcHBLw90adX9nBR0xsP6fuCiQ0jodGGzMsnSTdXNJE5+7WkPI6MJ3Kcq0tceSS/u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:56.7596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351f2d28-15a0-479f-ed9d-08de89eb3d0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9720
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

to implement AMDGPU_SPM_OP_SET_DEST_BUF, which registers a user-space
destination buffer for SPM data streaming, optionally waits for the
previous buffer to be filled, and starts or stops the SPM hardware
per XCC instance.

Data structure additions (amdgpu_spm.h):
  struct spm_user_buf:
    Tracks the current user-space destination buffer per XCC: the
    adjusted user_addr (offset past the drm_amdgpu_spm_buffer_header)
    and remaining ubufsize in bytes.

  amdgpu_spm_base extended with:
    ubuf (spm_user_buf), ring_rptr, size_copied, has_data_loss,
    has_user_buf (buffer registered), is_user_buf_filled (buffer full),
    is_spm_started (SPM HW running).

  amdgpu_spm_cntr extended with:
    spm_use_cnt (number of active XCC ring buffers), have_users_buf_cnt
    (number of XCCs with a registered user buffer), are_users_buf_filled
    (true when all registered buffers are full), spm_buf_wq (wait queue
    head for blocking on buffer fill).

  amdgpu_spm_mgr extended with:
    spm_irq_lock (spinlock protecting is_spm_started and ring_rptr
    against concurrent IRQ handler access).

SET_DEST_BUF flow (amdgpu_set_dest_buffer):
  1. Validates spm_cntr is allocated and spm_use_cnt > 0.
  2. Splits the caller-supplied buf_size evenly across all active XCCs
     (spm_use_cnt), rounded down to 32-byte alignment. Returns -EINVAL
     if the per-XCC slice cannot accommodate a drm_amdgpu_spm_buffer_header
  3. If timeout > 0 and a previous buffer is still being filled,
     blocks on spm_buf_wq via wait_event_interruptible_timeout().
     On -ERESTARTSYS the remaining timeout is computed and returned so
     the syscall can be transparently restarted by user space. On
     -ETIME (timeout expired), the work queue is flushed immediately
     to capture any partial data, and the call returns success.
     If timeout == 0 and a previous buffer exists, the work queue is
     flushed immediately without waiting.
  4. For each XCC in AMDGPU_XCC_MASK(adev), calls spm_update_dest_info():
     - If a previous user buffer was registered (has_user_buf), writes
       the drm_amdgpu_spm_buffer_header (SPM version, bytes_copied,
       has_data_loss to the reserved header slot just before ubuf.user_addr
       via copy_to_user(), accumulates bytes_copied and has_data_loss into
       the ioctl output args, and decrements have_users_buf_cnt.
     - If a new dest_buf is provided, advances the internal user_addr
       past the header, records ubufsize, resets size_copied, has_data_loss
       and is_user_buf_filled, sets has_user_buf, and increments
       have_users_buf_cnt.
  5. If dest_buf != NULL and the XCC's SPM is not yet started:
     calls amdgpu_rlc_spm_cntl(start), resets ring_rptr to 0 under
     spm_irq_lock (since amdgpu_rlc_spm_cntl() resets wptr to 0),
     and sets is_spm_started. If SPM was already running, sets
     need_schedule to drain existing ring data after the mutex is
     released.
  6. If dest_buf == NULL: stops the SPM hardware via
     amdgpu_rlc_spm_cntl(stop), clears is_spm_started and ring_rptr
     under spm_irq_lock.
  7. After releasing the XCP mutex, schedules the work queue if
     need_schedule is set.

amdgpu_spm_interrupt() stub is implemented: resolves the xcp_id from
xcc_id using amdgpu_xcp_get_partition() (defaulting to 0 on non-
partitioned devices), looks up the corresponding spm_mgr, and under
spm_irq_lock schedules the work queue if SPM is active on that XCC.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 217 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  18 ++
 2 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index e58b89ccd83f..896a0fef576c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -29,6 +29,9 @@
  * 0.1 - Initial revision
  */
 
+#define AMDGPU_SPM_MAJOR_VERSION	0
+#define AMDGPU_SPM_MINOR_VERSION	1
+
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
 
@@ -120,12 +123,16 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 		ret = _amdgpu_spm_acquire(spm_mgr, inst, filp);
 		if (ret)
 			goto acquire_spm_failure;
+		spm_mgr->spm_cntr->spm_use_cnt++;
 	}
 
+	spm_mgr->spm_cntr->have_users_buf_cnt = 0;
 	mutex_init(&spm_mgr->spm_cntr->spm_worker_mutex);
 
+	init_waitqueue_head(&spm_mgr->spm_cntr->spm_buf_wq);
 	INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);
 
+	spin_lock_init(&spm_mgr->spm_irq_lock);
 	spm_mgr->file = filp;
 
 	goto out;
@@ -153,6 +160,197 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	return 0;
 }
 
+static int spm_update_dest_info(struct amdgpu_spm_mgr *spm_mgr,
+				int inst, struct drm_amdgpu_spm_args *user_spm_data,
+				struct drm_amdgpu_spm_args *user_spm_ptr)
+{
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	int ret = 0;
+
+	mutex_lock(&spm_mgr->spm_cntr->spm_worker_mutex);
+	if (spm->has_user_buf) {
+		struct drm_amdgpu_spm_buffer_header spm_header;
+		uint64_t __user *user_address;
+
+		user_spm_ptr->bytes_copied += spm->size_copied;
+		user_spm_ptr->has_data_loss += spm->has_data_loss;
+
+		memset(&spm_header, 0, sizeof(spm_header));
+		user_address = (uint64_t *)((uint64_t)spm->ubuf.user_addr - sizeof(spm_header));
+		spm_header.version = AMDGPU_SPM_MAJOR_VERSION << 24 |
+					AMDGPU_SPM_MINOR_VERSION;
+		spm_header.bytes_copied = spm->size_copied;
+		spm_header.has_data_loss = spm->has_data_loss;
+		spm->has_user_buf = false;
+		spm_mgr->spm_cntr->have_users_buf_cnt--;
+
+		ret = copy_to_user(user_address, &spm_header, sizeof(spm_header));
+		if (ret) {
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+	if (user_spm_data->dest_buf) {
+		spm->ubuf.user_addr = (uint64_t *)user_spm_data->dest_buf;
+		spm->ubuf.ubufsize = user_spm_data->buf_size;
+		/* reserve space for drm_amdgpu_spm_buffer_header */
+		spm->ubuf.user_addr = (uint64_t *)((uint64_t)spm->ubuf.user_addr +
+					sizeof(struct drm_amdgpu_spm_buffer_header));
+		spm->ubuf.ubufsize -= sizeof(struct drm_amdgpu_spm_buffer_header);
+		spm->has_data_loss = 0;
+		spm->size_copied = 0;
+		spm->is_user_buf_filled = false;
+		spm->has_user_buf = true;
+		spm_mgr->spm_cntr->are_users_buf_filled = false;
+		spm_mgr->spm_cntr->have_users_buf_cnt++;
+	}
+out:
+	mutex_unlock(&spm_mgr->spm_cntr->spm_worker_mutex);
+	return ret;
+}
+
+static int spm_wait_for_fill_awake(struct amdgpu_spm_cntr *spm_cntr,
+			struct drm_amdgpu_spm_args *user_spm_data)
+{
+	int ret = 0;
+
+	long timeout = msecs_to_jiffies(user_spm_data->timeout);
+	unsigned long start_jiffies = jiffies;
+
+	ret = wait_event_interruptible_timeout(spm_cntr->spm_buf_wq,
+				 (READ_ONCE(spm_cntr->are_users_buf_filled) == true),
+				 timeout);
+
+	switch (ret) {
+	case -ERESTARTSYS:
+		/* Subtract elapsed time from timeout so we wait that much
+		 * less when the call gets restarted.
+		 */
+		timeout -= (jiffies - start_jiffies);
+		if (timeout <= 0) {
+			ret = -ETIME;
+			timeout = 0;
+			pr_debug("[%s] interrupted by signal\n", __func__);
+		}
+		break;
+
+	case 0:
+	default:
+		timeout = ret;
+		ret = 0;
+		break;
+	}
+	user_spm_data->timeout = jiffies_to_msecs(timeout);
+
+	return ret;
+}
+
+static int amdgpu_set_dest_buffer(struct amdgpu_spm_mgr *spm_mgr, void *data)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	struct drm_amdgpu_spm_args user_spm_data, *user_spm_ptr;
+	struct amdgpu_spm_cntr *spm_cntr;
+	bool need_schedule = false;
+	unsigned long flags;
+	u32 ubufsize;
+	int ret = 0;
+	int inst;
+
+	dev_dbg(adev->dev, "SPM start to set new destination buffer.");
+	mutex_lock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	spm_cntr = spm_mgr->spm_cntr;
+	if (spm_cntr == NULL ||
+		!spm_cntr->spm_use_cnt) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	user_spm_ptr = (struct drm_amdgpu_spm_args *) data;
+	ubufsize = user_spm_ptr->buf_size / spm_cntr->spm_use_cnt;
+	ubufsize = rounddown(ubufsize, 32);
+
+	if (ubufsize  <= sizeof(struct drm_amdgpu_spm_buffer_header)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcpy(&user_spm_data, user_spm_ptr, sizeof(user_spm_data));
+	user_spm_data.buf_size = ubufsize;
+
+	if (user_spm_data.timeout && spm_cntr->have_users_buf_cnt &&
+	    !READ_ONCE(spm_cntr->are_users_buf_filled)) {
+		dev_dbg(adev->dev, "SPM waiting for fill awake, timeout = %d ms.",
+				user_spm_data.timeout);
+		ret = spm_wait_for_fill_awake(spm_cntr, &user_spm_data);
+		if (ret == -ETIME) {
+			/* Copy (partial) data to user buffer after a timeout */
+			schedule_work(&spm_mgr->spm_work);
+			flush_work(&spm_mgr->spm_work);
+			/* This is not an error */
+			ret = 0;
+		} else if (ret) {
+			/* handle other errors normally, including -ERESTARTSYS */
+			goto out;
+		}
+	} else if (!user_spm_data.timeout && spm_cntr->have_users_buf_cnt) {
+		/* Copy (partial) data to user buffer */
+		schedule_work(&spm_mgr->spm_work);
+		flush_work(&spm_mgr->spm_work);
+	}
+
+	user_spm_ptr->bytes_copied = 0;
+	user_spm_ptr->has_data_loss = 0;
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+		struct amdgpu_spm_base *spm = &(spm_cntr->spm[inst]);
+
+		if (spm->has_user_buf || user_spm_data.dest_buf) {
+			/* Get info about filled space in previous output buffer.
+			 * Setup new dest buf if provided.
+			 */
+			ret = spm_update_dest_info(spm_mgr, inst, &user_spm_data, user_spm_ptr);
+			if (ret)
+				goto out;
+		}
+
+		if (user_spm_data.dest_buf) {
+			/* Start SPM if necessary*/
+			if (spm->is_spm_started == false) {
+				amdgpu_rlc_spm_cntl(adev, inst, 1);
+				spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+				spm->is_spm_started = true;
+				/* amdgpu_rlc_spm_cntl() will reset SPM and
+				 * wptr will become 0, adjust rptr accordingly.
+				 */
+				spm->ring_rptr = 0;
+				spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+			} else {
+				/* If SPM was already started, there may already
+				 * be data in the ring-buffer that needs to be read.
+				 */
+				need_schedule = true;
+			}
+			user_spm_data.dest_buf += ubufsize;
+		} else {
+			amdgpu_rlc_spm_cntl(adev, inst, 0);
+			spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+			spm->is_spm_started = false;
+			/* amdgpu_rlc_spm_cntl() will reset SPM and wptr will become 0.
+			 * Adjust rptr accordingly
+			 */
+			spm->ring_rptr = 0;
+			spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+		}
+	}
+
+out:
+	mutex_unlock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	if (need_schedule)
+		schedule_work(&spm_mgr->spm_work);
+
+	dev_dbg(adev->dev, "SPM finish to set new destination buffer, ret = %d.", ret);
+	return ret;
+}
+
 int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
@@ -167,10 +365,13 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
 	case AMDGPU_SPM_OP_ACQUIRE:
 		return amdgpu_spm_acquire(spm_mgr, filp);
 
+	case AMDGPU_SPM_OP_SET_DEST_BUF:
+		return amdgpu_set_dest_buffer(spm_mgr, data);
+
 	default:
 		dev_dbg(adev->dev, "Invalid option: %i\n", args->op);
-		return -EINVAL;
 	}
+	return -EINVAL;
 }
 
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr)
@@ -189,5 +390,17 @@ void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
 
 void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
 {
-	/* TODO */
+	uint8_t  xcp_id;
+	unsigned long flags;
+	struct amdgpu_spm_mgr *spm_mgr;
+
+	xcp_id = adev->xcp_mgr ?
+		fls(amdgpu_xcp_get_partition(adev->xcp_mgr, AMDGPU_XCP_GFX, xcc_id)) - 1 : 0;
+
+	spm_mgr = &(adev->prof_mgr.prof_xcp_mgr[xcp_id].spm_mgr);
+
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	if (spm_mgr->spm_cntr && spm_mgr->spm_cntr->spm[xcc_id].is_spm_started)
+		schedule_work(&spm_mgr->spm_work);
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index 9db89fd6154d..5eed6aa6482a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -24,15 +24,32 @@
 #ifndef AMDGPU_SPM_H_
 #define AMDGPU_SPM_H_
 
+struct spm_user_buf {
+	uint64_t __user *user_addr;
+	u32 ubufsize;
+};
+
 struct amdgpu_spm_base {
+	struct spm_user_buf ubuf;
 	u64    gpu_addr;
 	u32    ring_size;
+	u32    ring_rptr;
+	u32    size_copied;
+	u32    has_data_loss;
 	u32    *cpu_addr;
 	void   *spm_obj;
+	bool   has_user_buf;
+	bool   is_user_buf_filled;
+	bool   is_spm_started;
 };
+
 struct amdgpu_spm_cntr {
 	struct amdgpu_spm_base spm[MAX_XCP];
+	int spm_use_cnt;
 	struct mutex spm_worker_mutex;
+	wait_queue_head_t spm_buf_wq;
+	u32   have_users_buf_cnt;
+	bool  are_users_buf_filled;
 };
 
 struct amdgpu_spm_mgr {
@@ -43,6 +60,7 @@ struct amdgpu_spm_mgr {
 	/* spm data */
 	struct amdgpu_spm_cntr *spm_cntr;
 	struct work_struct spm_work;
+	spinlock_t spm_irq_lock;
 };
 
 int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
-- 
2.34.1


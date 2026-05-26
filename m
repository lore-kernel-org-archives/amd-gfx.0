Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1724CD6E43
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D2F10E688;
	Tue, 26 May 2026 14:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V7nyh+lY";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5193110E671
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5RT3zYLGGW9Qo+5RidwDXQIA/+Op9oCHXnSz6mwIC9koi1Elqnm4dkig0md/PhyrL1puRy6yOIhARZ8/K4LVrARrLpkrAOGOnFvK+qZngM0ED0rxcO8cxCYibnzVR5UUgFkjjc6gJI4sPgoxUDhKktjEUvJ5Xb9XbMJFJq34n31zd1+tIgo9wBFO+EI93WxWZi1dfssV4yC06I64gf/X0nG0taLzJh6r7UgaioYkFn2lS4cNvsXrHiFRe0q0/TZiVxl6vMrwSthL7RvGcTZW3xssAXZkxWT2bvmBht5dv335Tmsl5OjA9tFRfSXkluxVLlz6JyAMR4uUpeHo1S/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1FB/8gMX5m+1JsvKxiIjgFnwMVLRDKddubX5UXNgkE=;
 b=JAxqudZ6noLiPzKjPpVMIWlSm4r8qMEDOy01onnul9R8/jPn7kCxAXKIgwByjVEigbdFf7bNiGtlSouyRG8d1zyv5Feq+OYsBVfaQjvVTqvsAjnYFyboi5Q+hlhalgvQxVIT7X5/baNbADAUHdIAYg8uJdecuBHHNG2bgFT/yA1U8fQXHnE9ifSSBDlrBur79VuvB6avsnt6hsGIseGik41CYDnVm6e0+ZZMM2VzzH5lqB9Fq5V8d0Gf3nk37c15IKc5QsFMXX8i4NfbcFKqyVjV8fha7VcV5IRBQcrk5sB9wRyCGiLaSfxrdCQoj5JoJuFAXNRE2KtxFUl+ZkvI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1FB/8gMX5m+1JsvKxiIjgFnwMVLRDKddubX5UXNgkE=;
 b=V7nyh+lYjvWtQo0/fAO/goDqxqBUYNwoZsCHEuh4THlt7CLI0jKBlwd+BCoAaLBMl4QfeFx6H0Vl4fpY7ZQwqTxIHXFpJQL492tRPFztplTYLvUHv7p8QCHZkEb4OD+D3fC7m1OtGXMGVDi1wyXIljK91P3zSjERcYHOmdv39co=
Received: from BN9PR03CA0681.namprd03.prod.outlook.com (2603:10b6:408:10e::26)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 14:11:59 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::7b) by BN9PR03CA0681.outlook.office365.com
 (2603:10b6:408:10e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 14:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:11:59 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:53 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 11/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_SET_DEST_BUF
Date: Tue, 26 May 2026 10:11:23 -0400
Message-ID: <20260526141129.592886-11-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec6bee2-d8da-4efc-5398-08debb30c083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|22082099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: ROt6zx7TQ5yglH2x+06wX6SQtpnwDKnPKTfWNzsxRml8fjeN4lKepv1AQX/LhrMChlogunLaLbsiYPCsa7uw1LNeaOchvbPl8IWbaknSdnO8Nr4YaaFCSaHDAXBAVoW1LjuG11ac6gcRoOaiSqMXPNB9GV5/ntwUY1x6MyyDrMLJX7JKpwaaeg8ApYpTG6EnnfmAJqx9c3FeRT083/Kh5D6gaXSg7qzk/EuJlLQr+mWf4ADQahmomAdOGEpkBmgiEVuSh1X3CByHCoYHjDiL7VV2+/tXn9qEhvPpf+fts5JS06TZhSOLxFNvyKE/6tigY3JCvnwB5OsH75KSOikwyZcRAesaT9ktdiXHBQ0PVhMrKexux9sTCMKovaZnH0Zfxf6pw8E9uSu87Zgq9O8/bbYlqLG1PWpXwedHeC2RfUZpbkyDPx+TTcGmcchezWXt3wc/pr6ll3jqF2xBTVG0BM9BdiWuHx6UQJZcYau4uZYmb4/wrHH+dMWhSXJ/sc/41ZiJ2DrBnivHUJohNThfBBortSGhLe+zOw2o5itK7Va5XQwgq5/7U3Na+er31FCg47m6hddJAj5L1p6Kk2BAxltHeIPD9+UeCHc6eYRWAb3MYtT42jWDADaohzOLEPSladQzuKf8/ykDhHQrR7ZhNWovOX6Y7qW7k1LJMfcCPONtkgks9Nh9VAYFIxAT66So4Dw/1JR16izHE4BIz8uVvpQoDshEoleMp+SxCKkjeTI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IoXJTpUEY2FsB/LuM/czULTq8NZefhjmAsVDRFqJ8ecS86Oa8vonsGVx6uCa4vAYy2tlJf3InzG5Qs4lbznLWr0NfL0iZYChaXPhTmWsfjHSq/sDKTSh2EMinQvTiSxM6mUqGGUCX/P6cacQ+CBbDJHHpgNYE/nQVGgMSeXhdUGfp4c9mG60uRWrnqprIAfURoiNm8wNhcCL1lx1B4gr0oG+oUmAns3SJ+gU84PLJmD7FVQWWu0ZSVpVZ41AHbo8G/5RCZunyMqI2nmsR6c018rIJ9cqTTYij5dJf8WwqB1ubFqNDyDo1h3YscVzWiA+22VmPCOxx68D2MMlfYTnjWlaNXKHlLyszV9cYpKCMtfD/2uW7se7waF4HvRnuB2/57pL14nVq8TYxsD6CjQ4vaOk1QRBux3BoiPolou7z5Pa+z9lsOJPFxsqWVPKywr5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:11:59.5427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec6bee2-d8da-4efc-5398-08debb30c083
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105
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

-v3: add _spm_start/_spm_stop to improve code organization and readability

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 244 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  18 ++
 2 files changed, 260 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index e58b89ccd83f..be3f86fcf7e4 100644
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
@@ -141,6 +148,46 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	return ret;
 }
 
+static int _spm_start(struct amdgpu_spm_mgr *spm_mgr,
+		struct amdgpu_device *adev, int inst)
+{
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	unsigned long flags;
+	int ret = 0;
+
+	/* Start hardware SPM first */
+	amdgpu_rlc_spm_cntl(adev, inst, 1);
+
+	/* amdgpu_amdkfd_rlc_spm_cntl() will reset SPM and
+	 * wptr will become 0, adjust rptr accordingly.
+	 */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spm->is_spm_started = true;
+	/* amdgpu_rlc_spm_cntl() will reset SPM and
+	 * wptr will become 0, adjust rptr accordingly.
+	 */
+	spm->ring_rptr = 0;
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	return ret;
+}
+
+static void _spm_stop(struct amdgpu_spm_mgr *spm_mgr,
+		struct amdgpu_device *adev, int inst)
+{
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	unsigned long flags;
+
+	amdgpu_rlc_spm_cntl(adev, inst, 0);
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spm_mgr->spm_cntr->spm[inst].is_spm_started = false;
+	/* amdgpu_amdkfd_rlc_spm_cntl() will reset SPM and wptr will become 0.
+	 * Adjust rptr accordingly
+	 */
+	spm->ring_rptr = 0;
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+}
+
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
 {
 	/* TODO: */
@@ -153,6 +200,184 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
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
+				ret = _spm_start(spm_mgr, adev, inst);
+				if (ret)
+					goto out;
+			} else {
+				/* If SPM was already started, there may already
+				 * be data in the ring-buffer that needs to be read.
+				 */
+				need_schedule = true;
+			}
+			user_spm_data.dest_buf += ubufsize;
+		} else {
+			_spm_stop(spm_mgr, adev, inst);
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
@@ -167,10 +392,13 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
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
@@ -189,5 +417,17 @@ void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
 
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCB8CD5BAB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 21:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E7410F40D;
	Thu, 21 May 2026 21:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CkWkUYoa";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9F410F40D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 21:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIMXhgS/Wyr0vaSwSKdl/L45KXSt+j1xL3LWUFCYp77Dg4xchuAaWKIGqkTgk0S/PUweGUQediAN5DnWhIHY9cSWgZfekZsS2DCzGZQPIYd1rTl3LjScXebmJ6+Bjfo6e230bbuRSlC33nARoUP9x/UfWVkvPPUlVWV10o0qtj52CY1z+8mj7nSjinjBw+z/ejUtcOj9q+tJ8/kaVYxDpKj4bnM62pS951Bb24ZeePoF6SEah3bEGRo1x5R45sBE49CUmsx1Svv0OI+pCEOrtFwgzs289lB4dvM5B87lS4uvbAit/qpTo40fqB5csEGuSJQFMEmmtfKNlFjOI5xxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1FB/8gMX5m+1JsvKxiIjgFnwMVLRDKddubX5UXNgkE=;
 b=XuDrhHzp2CxWZWHBrTAL72sk3QMOME8fsuGVS5hHXxS/rUPY7l0HOtGUC4bTxjqaI/LqLrqNR9MJBThGu+dHtMcKdLpWHBgfhgMNgOhDPBD1fd1bN6uLseh2gcaOa6MfVTYtbz3qQTgZ1qU15/lxZi5hGTo8JW77axPYGS4iT4XHQ8S2Hm9EKiRsDdN1ZCUPjFrB7MU3lgFJ98DYliOWkFJkc+HEblWGo8IlHu29vl94VemyqUy+WOEyf4RdWEg+/t+NGdnFC0pRRA1fR/2959r7y7TcPMchSjiCkjtp25xdgwKdkqz7PxHUmhO83gAAFQQJIhAawJGzgCvUxhHFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1FB/8gMX5m+1JsvKxiIjgFnwMVLRDKddubX5UXNgkE=;
 b=CkWkUYoazhpfg9RpqHrPlM/veIh+YSZmX3LK5mux+p54gpk7EGgqYkAMyREdmEs08IUsKOLpHWJfF/bsEqgVDm48xvrh/4qYb7gFkvYbvxPVqp3mG1H+JIdvvuxu02TKQqnJ271bwjcMML0oPidk/4lSf7RFP9SDn6gGWm/7Sa4=
Received: from IA1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::9)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 21:41:25 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:461::4) by IA1P220CA0003.outlook.office365.com
 (2603:10b6:208:461::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 21:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 21:41:22 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 16:41:21 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Bing.Ma@amd.com>
CC: <jamesz@amd.com>
Subject: [PATCH v3 11/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_SET_DEST_BUF
Date: Thu, 21 May 2026 17:41:10 -0400
Message-ID: <20260521214110.1935408-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-12-James.Zhu@amd.com>
References: <20260324212030.822932-12-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 372ec33f-7ea2-42a4-9000-08deb781b39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|22082099003|56012099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: 5lG+/dCgzY7TIeKafSi7k3SVygfRfk9/oQVx+zxmkUtyUZMfaa+qVYP0fzgeD7PurpRmbh9t+w25E5/xmuWpq/sY8nUFxCXyZ2YWi3YN6X0lSmFwpANX29Xn5lcrlTXOESN33cqqo0QNif15ozPFuXMZ2yK9e0iy7yoDUmt7mZ8SMZP3tMwQ14EAt5rwOEUq+11gj1SgupTpCKmIkHomLI7bs+J2YsSnyGoxCYIRnM7xX9C3iGULJtbK2zoWycJ05CEc2ay9Amh8RvXCkmby6oUSr7XijlxRn1ldwz1gFqzlWVdotGI6GtqEKg9iRG5q+sT/GjP5TGF7Q4J4/FXO3ct+1AgKAMmu/PDaABOP4ryrYRZievXB5UncrR+nj9xPZaEPv8wHezIBOtxK/4p6ljsP4k3PjtFnLd1InuG+3juHJ+vdeWy3gFidPCunRHEaKEhc7JE7PX4zQrpPcLUFH7ziStqLh/OHEXNIcQwbBwIgiPxdc+cm4AWKMDzliex2nO6Z1WUtYfrb5OE/WYPuxqCmezC6KFVFtdPppA1F2S11jkzsvX5i2U+NXLwZww0kD9xkfJRd1fTBv/MxHHet8VDX3CL1ZAemlzHmXK4kRO0l/EXhsBKklMwl5D6CT2wFi8vDeZrq07alkKp0k/EqdBmzW36C5WxAzSKm4kZoTpUX2VrwURQaUmoaR6AST4OXcDGk6oIqwV5KldBD4R0ZTo1WAd6uXCGc718BFX+KrWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(22082099003)(56012099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KcG4F7Puw0YdhugejZ6zUTu3RxUCizoFoBhy16t43WBHXpg1/AWxUM0utHYnxFrHNXntZrhtcw8yP7fr1DXJELx1qUDG5cHx5Lpp98+TYuZveFzbko1aPp0vgc+9kFPmXqLdurdXyW+bXzYbOL4jDfcBIKrXIjczMpeZMSje67oqawU2QvccHFnJfitaZC2n8nm1abgk1Rv79HD+I+m3D982Km58BAJdNpBuLIwFl4mJYPCZ4i+IX5MQ0Slwxabqw4DFS0jGLjohSYqurlFwxPu77uJD6G1fCWs7xYQ1aeyjB0iUH0/irr65yYdCN0KToLFd21ESlhTVJcWtqHgK1nAlYXHr6j0J5PYi3hrsEVVtEBCRJT0kZ+vVUfm2tqSARaO0jJch4zj0r7N9zwwT4y4x0xwwwT+lUteHrpySowTuj+oFxF6Z4wPT9rknrFwL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:41:22.4877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372ec33f-7ea2-42a4-9000-08deb781b39d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
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


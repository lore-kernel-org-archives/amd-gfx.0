Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ACDCD5BAB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 21:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58BB10F412;
	Thu, 21 May 2026 21:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rVZaPRxa";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013022.outbound.protection.outlook.com
 [40.107.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5045910F412
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 21:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Th+CCOh4pvPwQsGEXO9nKNwypE1AKY1Ak1d9zU21hz/5n8DI91FgW/s3+uKky4R9/dpriMTO/0ylxQvTCAsbIxyHhW3jQR8dXL9weh/5MpHHJVVypNDBk2CsoNlReqIIqo4k2oqm04e/HGcU6wIbdf9ux0E00h7IRfQvFallqaIP6li3728OAABJbGcrEns9TrxJF7rvcXlZyLD1xb51pqe7zQVz1agXgEhDECgZ07uJdfEWpj5O7Zu9a12KJu/vfEhx2vdnb/0Ck74M/c+gfyrmbKApoNfEXxvwVPcZTLFZfTxnB9RIe4S4zFsYohh6L3SbRRxw2u5edgPrf9J1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk8LfImObALAzFCgHDFREHaVM3/4JTFk+Y4aSLEG7F0=;
 b=XohArjirzFuNqmSe8aOlL0TJCxssbCmio1PdqCJOSI9RulVT+x8po8QFWIh7yGn43TWgvqtROlgn4jVaOoY/ofcbGcsSOgkP9ZYm0yc6xFulZv4xdelS+7Et2h1KhIKN0b3YDVnwPwCgrRFjr3mqb+Pr7oYpVpRO4pLMBkSEQyx5YzbcwoZ1p3qG/Mj/0gVsV4TvixbUYLHbqXUUS8zHdtgvva59uZ/hdp1attzIEcikgz0Vd74xAWkmyr9lAvO87IUgbVKEmGxMG2oyW7wrAb2DG/U/+vqNOLFlQuELos5dM9bNRE3gCKRKhogjoUrKs9BHS7EiDiM6WA+TDafGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk8LfImObALAzFCgHDFREHaVM3/4JTFk+Y4aSLEG7F0=;
 b=rVZaPRxafkphS6FqfP0JHoIJjU76rYNeJWjnahMCT/kpGRkUErMduIabSbacJWEsk8ffRrF3SHYUhlcneCa6Cudf/r0jaudVV8/TRUCxZnTR5b9GqLDkL1Ch1d97+J0/IaJbSn8p1aQdywt7h3yRovgfHyeZMOz/vZT+/xyHf54=
Received: from BN9PR03CA0551.namprd03.prod.outlook.com (2603:10b6:408:138::16)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 21:42:46 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::8b) by BN9PR03CA0551.outlook.office365.com
 (2603:10b6:408:138::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Thu, 21
 May 2026 21:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 21:42:46 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 16:42:45 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Bing.Ma@amd.com>
CC: <jamesz@amd.com>
Subject: [PATCH v3 15/17] drm/amdgpu: workaround for hw stall issue
Date: Thu, 21 May 2026 17:42:35 -0400
Message-ID: <20260521214235.1936566-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-16-James.Zhu@amd.com>
References: <20260324212030.822932-16-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8152c101-c9ef-4589-d662-08deb781e567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|6133799003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: XOTfd9kQYUFpWeChneUVNROyHGM2DcsCPTamH+rx2JU/qGM/jIsYgcEPq4/l9RO+V6595YofatMQldYcaTH/xnEQg/g8N+nCEzUCNKZKSQ3wePCazikG4QxOEKuzul4CGvDtHG+jX6AeIZjiDhG+meBk/RzDv0XVvIDqr4nGKNG7HlPlqYwWR73fjn92NhEVOFhKM47vztqjq1OxUV+pIATPPju/43YVQKxuzMbJZ5JAxWmSBA8y0QnieJQbZNzn2XdKUqQZA5AqhC7pNSwKYgZ/0QZHJgDXNc58wTVpTHM/JrCRhlJDlal5tmRlzZkTeSVQUCFZbtJzKJwckiGPq5Php4LzbTPmRNKmqzEFix5WskLBtN04tv/KjH3fhiCSk/AAB8zaR3vg6sf+tiQVQmaeuGqXXk02XaW+/Z0WU4WMWyK8BVJxKYxLUZ/2pvJGrTdoNcjferZ4FcU03mXcXM6jEWJZCJTfhmZdRdS2weAIZOiidW4z61Wq+XhZDzQiCmb2rmMYeSYAF5yn4DA2FKnUS1tWkftI9ZTP+gqmk1NpbiwdsVqB4nLYHsoHlkwM8TzM34l20nBURKQD9HBTTNVBs1RAynokXVhLn0eN65wsCcqDW/uY68fdoRwq0b0LxzfY3OV2ecgViJHfOzROGsPAzwGHW/PaUpJX7kdORMMv5cSu9sFlwBQ5cOqoEDOKGV1QtCgi/Ybe4VRnAVxNtdI1dAe8t1xKrmVECjwItjY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(6133799003)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o37c09qEzbrryXcdAzt5m8N3lM6DqifSHyXwKgUsySavM5PZRDh1vQ1TVZlJcRkc5zsXiSs+9tvs//0MkrskuDKSo0lShR4/7P75+wK9MsVrpE8bnQjEvjtQpiP+bIhqKuseR7PaqgN0dO1rZC+AwmAZqPqfe+kkB59KQupmbLLSyijBVHb3GlxNzZqG+8Fu8GyRqP8lf+F9QeXPflrNGfXyqAwloTbNogujyP/HhACrY8OkfSHGyxCVlncmuz+Euv7SLsbDQooSwZ2evMpRhPW2xGDkLIV12phOU7JVPkiyDsOfULts6HhIp6J9x08sHlMIhcrbTv0Q68RS0qloyWxvRLOt3yfo9PvoWYVSx+ZvIXySgKPrPpXae8RqK+3LhsNfaV+WqJiCV+5DlpKTE0rXDmDNacu+INylIXZb0ys0+azpaB6sPuIRw7iwIpRW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:42:46.0207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8152c101-c9ef-4589-d662-08deb781e567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
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

When RLC_SPM_PERFMON_CNTL.PERFMON_RING_MODE is set to 0x11, the SPM
hardware is designed to fire a warning interrupt when the ring fill level
reaches RLC_SPM_SEGMENT_THRESHOLD, and stall only when the ring is
completely full. A hardware bug causes both the stall and the warning
interrupt to trigger simultaneously at RLC_SPM_SEGMENT_THRESHOLD, resulting
in an unexpected early hardware stall at interrupt time, which causes data
loss before the ring buffer is actually full.

This patch replaces interrupt-driven ring drain scheduling with a software
polling monitor thread to avoid triggering the premature stall.

Software polling monitor (amdgpu_spm_monitor_thread):
  A kthread named "spm_<render_index>" polls each active XCC instance
  in a tight loop with usleep_range(1, 11) (1-11 us per iteration).
  On each iteration, it attempts to acquire spm_worker_mutex with
  mutex_trylock() (skipping if contended) and for each active XCC checks
  whether the amount of unconsumed data in the ring exceeds half the ring
  capacity, computed as:
    (ring_size + ring_wptr - ring_rptr) % ring_size > (ring_size >> 1)
  This condition fires only once per rptr advancement (guarded by
  warned_ring_rptr != ring_rptr) to avoid redundant scheduling.
  When triggered, schedules amdgpu_spm_work to drain the ring and logs
  a "soft interrupt" debug message with the current rptr and wptr.

warned_ring_rptr (u32, added to amdgpu_spm_base):
  Tracks the rptr value at which the last soft interrupt was issued.
  Initialized to ~0U (U32_MAX) on acquire and on each SPM start/stop to
  ensure the first polling check always passes. Updated to the current
  rptr at the start of each ring buffer read to suppress duplicate
  scheduling for the same rptr position.

Monitor thread lifecycle:
  - Started lazily on the first SET_DEST_BUF call that starts the SPM
    hardware (dest_buf != NULL, is_spm_started transitions false→true).
    Only one thread is created per SPM session regardless of XCC count.
  - Stopped on SET_DEST_BUF with dest_buf=NULL (SPM stopped) and on
    AMDGPU_SPM_OP_RELEASE. spm_monitor_thread is initialized to NULL
    in amdgpu_spm_acquire() and set back to NULL by the thread itself
    on exit.

amdgpu_spm_interrupt():
  - schedules amdgpu_spm_work directly. But when detects affected hardware
    via ip_versions[GC_HWIP][0] < IP_VERSION(12, 0, 0), the polling thread
    is responsible for all ring drain scheduling in this mode. the hardware
    interrupt only sets has_data_loss=1  under spm_irq_lock (indicating the
     ring reached the stall threshold) and logs a debug message.

-v3: signal_pending using current instead of spm_mgr->spm_monitor_thread to
     fix race condition issue
     use _spm_start/_spm_stop

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 102 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |   2 +
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index cbe7a2b61bb8..d4b6408f818d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -38,6 +38,77 @@
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
 
+static int amdgpu_spm_monitor_thread(void *param)
+{
+	struct amdgpu_spm_mgr *spm_mgr = param;
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+
+	allow_signal(SIGKILL);
+	while (!kthread_should_stop() &&
+			!signal_pending(current) && spm_mgr->spm_cntr) {
+		bool need_schedule = false;
+		u32 inst;
+
+		usleep_range(1, 11);
+
+		if (!mutex_trylock(&spm_mgr->spm_cntr->spm_worker_mutex))
+			continue;
+
+		for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+			struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+			u32 warned_ring_rptr;
+			u32 ring_size;
+			u32 ring_rptr;
+			u32 ring_wptr;
+
+			if (!spm->is_spm_started)
+				continue;
+
+			ring_size = spm->ring_size;
+			ring_rptr = spm->ring_rptr;
+			warned_ring_rptr = spm->warned_ring_rptr;
+			ring_wptr = READ_ONCE(spm->cpu_addr[0]);
+
+			if (need_schedule || (ring_rptr != warned_ring_rptr &&
+				(ring_size + ring_wptr - ring_rptr) % ring_size >
+					(ring_size >> 1))) {
+				spm->warned_ring_rptr = ring_rptr;
+				if (!need_schedule) {
+					dev_dbg(adev->dev,
+						"[SPM#%d] soft interrupt rptr:0x%08x--wptr:0x%08x",
+						 inst, ring_rptr, ring_wptr);
+					need_schedule = true;
+				}
+			}
+		}
+		mutex_unlock(&spm_mgr->spm_cntr->spm_worker_mutex);
+		if (need_schedule)
+			schedule_work(&spm_mgr->spm_work);
+	}
+	spm_mgr->spm_monitor_thread = NULL;
+	return 0;
+}
+
+static int amdgpu_spm_monitor_thread_start(struct amdgpu_spm_mgr *spm_mgr)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	char thread_name[16];
+	int ret = 0;
+
+	snprintf(thread_name, 16, "spm_%d", adev->ddev.render->index);
+	spm_mgr->spm_monitor_thread =
+		kthread_run(amdgpu_spm_monitor_thread, spm_mgr, thread_name);
+
+	if (IS_ERR(spm_mgr->spm_monitor_thread)) {
+		ret = PTR_ERR(spm_mgr->spm_monitor_thread);
+		spm_mgr->spm_monitor_thread = NULL;
+		dev_dbg(adev->dev, "Failed to create spm monitor thread %s with ret = %d.",
+			thread_name, ret);
+	}
+
+	return ret;
+}
+
 static void amdgpu_spm_preset(struct amdgpu_spm_base *spm, u32 size)
 {
 	uint64_t *overflow_ptr, *overflow_end_ptr;
@@ -122,6 +193,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr, int inst)
 	if (spm->ring_rptr == ring_wptr)
 		goto exit;
 
+	spm->warned_ring_rptr = spm->ring_rptr;
 	if (ring_wptr > spm->ring_rptr) {
 		size_to_copy = ring_wptr - spm->ring_rptr;
 		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
@@ -246,6 +318,7 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct
 	 */
 	spm->ring_size -= 0x20;
 	amdgpu_spm_preset(spm, spm_mgr->spm_overflow_reserved);
+	spm->warned_ring_rptr = ~0;
 
 	goto out;
 
@@ -290,6 +363,7 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);
 
 	spin_lock_init(&spm_mgr->spm_irq_lock);
+	spm_mgr->spm_monitor_thread = NULL;
 	spm_mgr->file = filp;
 
 	goto out;
@@ -324,8 +398,21 @@ static int _spm_start(struct amdgpu_spm_mgr *spm_mgr,
 	 * wptr will become 0, adjust rptr accordingly.
 	 */
 	spm->ring_rptr = 0;
+	spm->warned_ring_rptr = ~0;
 	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 
+	if (!spm_mgr->spm_monitor_thread) {
+		ret = amdgpu_spm_monitor_thread_start(spm_mgr);
+		if (ret) {
+			/* Thread failed to start, revert state */
+			dev_dbg(adev->dev,
+				"Failed to start SPM monitor thread, ret = %d\n", ret);
+			spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+			spm->is_spm_started = false;
+			spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+			amdgpu_rlc_spm_cntl(adev, inst, 0);
+		}
+	}
 	return ret;
 }
 
@@ -335,6 +422,9 @@ static void _spm_stop(struct amdgpu_spm_mgr *spm_mgr,
 	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
 	unsigned long flags;
 
+	if (spm_mgr->spm_monitor_thread)
+		kthread_stop(spm_mgr->spm_monitor_thread);
+
 	amdgpu_rlc_spm_cntl(adev, inst, 0);
 	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
 	spm_mgr->spm_cntr->spm[inst].is_spm_started = false;
@@ -342,6 +432,7 @@ static void _spm_stop(struct amdgpu_spm_mgr *spm_mgr,
 	 * Adjust rptr accordingly
 	 */
 	spm->ring_rptr = 0;
+	spm->warned_ring_rptr = ~0;
 	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 }
 
@@ -633,8 +724,15 @@ void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
 
 	spm_mgr = &(adev->prof_mgr.prof_xcp_mgr[xcp_id].spm_mgr);
 
+	/*  watermark threshold is triggered */
 	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
-	if (spm_mgr->spm_cntr && spm_mgr->spm_cntr->spm[xcc_id].is_spm_started)
-		schedule_work(&spm_mgr->spm_work);
+	if (spm_mgr->spm_cntr && spm_mgr->spm_cntr->spm[xcc_id].is_spm_started) {
+		if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(12, 0, 0))
+			spm_mgr->spm_cntr->spm[xcc_id].has_data_loss = 1;
+		else
+			schedule_work(&spm_mgr->spm_work);
+	}
 	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	dev_dbg(adev->dev, "[SPM#%d:%d] ring buffer stall.", xcp_id, xcc_id);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index f00a4751643e..db440b2e11f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -41,6 +41,7 @@ struct amdgpu_spm_base {
 	bool   has_user_buf;
 	bool   is_user_buf_filled;
 	bool   is_spm_started;
+	u32    warned_ring_rptr;
 };
 
 struct amdgpu_spm_cntr {
@@ -53,6 +54,7 @@ struct amdgpu_spm_cntr {
 };
 
 struct amdgpu_spm_mgr {
+	struct task_struct *spm_monitor_thread;
 	struct drm_file *file;
 
 	struct task_struct *lead_thread;
-- 
2.34.1


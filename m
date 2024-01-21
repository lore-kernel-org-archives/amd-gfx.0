Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1709C47258
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jan 2024 00:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED49B10E033;
	Sun, 21 Jan 2024 00:20:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA00D10E033
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jan 2024 00:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh3fbEMTUWEkRh0fcVXnhirrgL5y5laUrctnvzB+q6i9EGtav9GY7j4kR5mPe0BPma9geyPXOmvIzgCLm+ITROsjIXQMEbM3BidrJ9BwgAbyQCY8ffkRyDS062zYF1QF8GGzqo5rqlEyRJvhHWFxMfw4C7vZLl3iCOrjyn49Dpat2eTazgsvk5blTLWC7fYPsA66+cfwjNXJK3u+NaByqtlQju/5LlFIGsW/jSY7hvKoEVsYTsZn8SEgcsjeqDvKd/DzS6vANzP38DhIrx/fEcDZqbsKi/+Lk+SURPTxeJFbr4w2fkw5oqcnAoxkMqQD8jTNJsjyZiNimRVzkMTtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3WUpnNhUgITlVOzye0AAYEX/JM7vojEr48NFUJ1J4c=;
 b=E5Z0g9QRu9VvT+vw43XMQM76+YoInnU2ZaFLrAxklEG6EjInr7j6ZavQPp3HfN1/WNmOycBC4S3DiOh34weigxo05NKAvwtdZjytrtSSAHTQSrmKuG5RD6r1RfD3DVB9EY3bSgv+YpU7IFQgquin40Fx9Vq32hch+9MR62FFu/1+XzGTG7rjboaOuJTgroZhnAOBrOIbF8sAvWYMfJmIQaohGdSr5xfsztVagOqYEE6B6zbKZ4AGqnhRIk7B3PbtnHvcYJHCtLLJwyrl+eECkvt1U5J/LL1yXbO0/2KMvfimZyK5pGsymU3hhQq6K/r5t76J11WSr/appVCz6jySng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3WUpnNhUgITlVOzye0AAYEX/JM7vojEr48NFUJ1J4c=;
 b=xeyxn5KBuoVdGZRVdZyPcormM11ITNL0v0x10DFgNgCsnfH5AjW0mwfu770IdiHK40BSa36a8S10hARpptpawBbAx38yE8LsVSCfsHy0rTakL/XPKlhV8nJXDzUu4wzJLxbvzwpWv8MuwsroLO/KKdCbiWOr/KyAEawCwboL88o=
Received: from BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Sun, 21 Jan
 2024 00:20:00 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:14b:cafe::fc) by BYAPR06CA0050.outlook.office365.com
 (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29 via Frontend
 Transport; Sun, 21 Jan 2024 00:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Sun, 21 Jan 2024 00:20:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 20 Jan
 2024 18:19:58 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 20 Jan
 2024 18:19:57 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Sat, 20 Jan 2024 18:19:57 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: check flag ring->no_scheduler before usage
Date: Sat, 20 Jan 2024 19:19:51 -0500
Message-ID: <20240121001951.75950-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 0057d0cf-f538-4995-eb4a-08dc1a16b4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dF0BoHqL+HfF70oyQ3LlC6wH4lrpAgr0YhYodhAoWVtYHO0aX5MlPuF7m+klsbdj0jweA0QkKtyj/J4cWEn80hhNRPhsRZ4lP1LJzT/b0BpYyiiGtRivBSoCeNGGWvLb6xNCcnCC9rzldRdbvUbhIW/DhtzgWPhZAt88UHvrpi7A4JziWbCKukePQ2OybX9yFT58r10ZmVgj2OjlrQUzz8prw2BO2iprP1BiqFf5ggoYW0GNmQPKh3MGhv5WWxc7X4MiVa5KeM5/Z4xqgvw3BrDA75MwNjlGDhN8NyDw4WOcvbI+GEfqhTIxFcAWgrgWc4P3F8T+XFZNP+8GDDr+3/J2FzjJ2VIdxal2GUFJ5t/0BeHNQjN6qy6nZH2XeW1DEax9QdjXT4Wuw0Kxz5vOR2cwlnGlH1fcnPDrqqveCLdmzM+JQjpSXzQwXyQVA17berf9ROR+WUCw04RD2JAz3kxLIHSwYXcNN/zJv845YEpLhKpVK6mItG+Lzooebmrqhc1i0A3PRN1FUG9MYEQRjBxxbC7ra/KXurzkkJuXRh/Cm0ts76tBdIkltDCINO2B4WtYGftofa7baD6KyrPqAnX5donbCN7Cb0VwLlY4IhKtAs8s4dI/PRQvtEaucS7d45wnIblALpw7Gjupwhh7hh/3n5kfAt+FKW8XUmt4p3YmVLBr6bw7Kb4ShNa05gWFKGBONkwVqWf3QmVGim4k8Dtylfu5anSJngErdSHSVS08eHzKvUqFMLzawImhVufPXzFj0+GWi4Hk1Mgw83SNrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(83380400001)(41300700001)(478600001)(36860700001)(81166007)(40460700003)(40480700001)(82740400003)(47076005)(356005)(426003)(26005)(336012)(6666004)(7696005)(316002)(86362001)(2876002)(2906002)(36756003)(8936002)(6636002)(8676002)(110136005)(4326008)(70586007)(70206006)(5660300002)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 00:20:00.0777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0057d0cf-f538-4995-eb4a-08dc1a16b4a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

   The issue started to appear after the following commit
 11b3b9f461c5c4f700f6c8da202fcc2fd6418e1f (scheduler to variable number
 of run-queues). The scheduler flag ready (ring->sched.ready) could not be
 used to validate multiple scenarios, for example, check job is running,
 gpu_reset, PCI errors etc. The reason is that after GPU reset, the flag
 is set to true unconditionally even for those rings with an uninitialized scheduler.
 As a result, we called drm_sched_stop, drm_sched_start for the uninitialized
 schedule and NULL pointer dereference is occured. For example, the following
 occurs on Navi10 during GPU reset:

 [  354.231044] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
 [  354.239152] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
 [  354.246047] RIP: 0010:__flush_work.isra.0+0x23a/0x250
 [  354.251110] Code: 8b 04 25 40 2e 03 00 48 89 44 24 40 48 8b 73 40 8b 4b 30 e9 f9 fe ff ff 40 30 f6 4c 8b 36 e9 37 fe ff ff 0f 0b e9 3a ff ff ff <0f> 0b e9 33 ff ff ff 66
 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
 [  354.269876] RSP: 0018:ffffb234c00e3c20 EFLAGS: 00010246
 [  354.275121] RAX: 0000000000000011 RBX: ffff9796d9796de0 RCX: 0000000000000000
 [  354.282271] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9796d9796de0
 [  354.289420] RBP: ffff9796d9796de0 R08: ffff977780401940 R09: ffffffffa1a5c620
 [  354.296570] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 [  354.303720] R13: 0000000000000001 R14: ffff9796d97905c8 R15: ffff9796d9790230
 [  354.310868] FS:  0000000000000000(0000) GS:ffff97865f040000(0000) knlGS:0000000000000000
 [  354.318963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  354.324717] CR2: 00007fd5341fca50 CR3: 0000002c27a22000 CR4: 00000000003506f0
 [  354.324717] CR2: 00007fd5341fca50 CR3: 0000002c27a22000 CR4: 00000000003506f0
 [  354.331859] Call Trace:
 [  354.334320]  <TASK>
 [  354.336433]  ? __flush_work.isra.0+0x23a/0x250
 [  354.340891]  ? __warn+0x81/0x130
 [  354.344139]  ? __flush_work.isra.0+0x23a/0x250
 [  354.348594]  ? report_bug+0x171/0x1a0
 [  354.352279]  ? handle_bug+0x3c/0x80
 [  354.355787]  ? exc_invalid_op+0x17/0x70
 [  354.359635]  ? asm_exc_invalid_op+0x1a/0x20
 [  354.363844]  ? __flush_work.isra.0+0x23a/0x250
 [  354.368307]  ? srso_return_thunk+0x5/0x5f
 [  354.372331]  ? srso_return_thunk+0x5/0x5f
 [  354.376351]  ? desc_read_finalized_seq+0x1f/0x70
 [  354.380982]  ? srso_return_thunk+0x5/0x5f
 [  354.385011]  ? _prb_read_valid+0x20e/0x280
 [  354.389130]  __cancel_work_timer+0xd3/0x160
 [  354.393333]  drm_sched_stop+0x46/0x1f0 [gpu_sched]
 [  354.398143]  amdgpu_device_gpu_recover+0x318/0xca0 [amdgpu]
 [  354.403995]  ? __drm_err+0x1/0x70 [drm]
 [  354.407884]  amdgpu_job_timedout+0x151/0x240 [amdgpu]
 [  354.413279]  drm_sched_job_timedout+0x76/0x100 [gpu_sched]
 [  354.418787]  process_one_work+0x174/0x340
 [  354.422816]  worker_thread+0x27b/0x3a0
 [  354.426586]  ? __pfx_worker_thread+0x10/0x10
 [  354.430874]  kthread+0xe8/0x120
 [  354.434030]  ? __pfx_kthread+0x10/0x10
 [  354.437790]  ret_from_fork+0x34/0x50
 [  354.441377]  ? __pfx_kthread+0x10/0x10
 [  354.445139]  ret_from_fork_asm+0x1b/0x30
 [  354.449079]  </TASK>
 [  354.451285] ---[ end trace 0000000000000000 ]---
 [  354.455917] BUG: kernel NULL pointer dereference, address: 0000000000000008
 [  354.462883] #PF: supervisor read access in kernel mode
 [  354.468029] #PF: error_code(0x0000) - not-present page
 [  354.473167] PGD 0 P4D 0
 [  354.475705] Oops: 0000 [#1] PREEMPT SMP NOPTI
 [  354.480066] CPU: 1 PID: 11 Comm: kworker/u64:0 Tainted: G        W          6.7.0-991912.1.zuul.e7596ab24dae4bb686e58b0f1e7842da #1
 [  354.491883] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
 [  354.499976] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
 [  354.506855] RIP: 0010:drm_sched_stop+0x61/0x1f0 [gpu_sched]

  The solution is every place where we check the ready flag and check
 for ring->no_scheduler. The ready flag serves the purpose in case an initialization
 is failed, like starting the worker thread, etc.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 14 ++++++++------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 899e31e3a5e8..70bbf602df34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -292,6 +292,8 @@ static int suspend_resume_compute_scheduler(struct amdgpu_device *adev, bool sus
 
 		if (!(ring && drm_sched_wqueue_ready(&ring->sched)))
 			continue;
+		if (ring->no_scheduler)
+			continue;
 
 		/* stop secheduler and drain ring. */
 		if (suspend) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index e485dd3357c6..35132aa2c0f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1678,7 +1678,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
 			continue;
 		drm_sched_wqueue_stop(&ring->sched);
 	}
@@ -1694,7 +1694,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
 			continue;
 		drm_sched_wqueue_start(&ring->sched);
 	}
@@ -1916,7 +1916,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 
 	ring = adev->rings[val];
 
-	if (!ring || !ring->funcs->preempt_ib ||
+	if (!ring || !ring->funcs->preempt_ib || ring->no_scheduler ||
 	    !drm_sched_wqueue_ready(&ring->sched))
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2df14f0e79d8..894b657df1d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5052,7 +5052,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
 			continue;
 
 		spin_lock(&ring->sched.job_list_lock);
@@ -5191,8 +5191,10 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
 			continue;
+		 if (ring->no_scheduler)
+			 continue;
 
 		/* Clear job fence from fence drv to avoid force_completion
 		 * leave NULL and vm flush fence in fence drv
@@ -5658,7 +5660,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
-			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
 				continue;
 
 			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
@@ -5727,7 +5729,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
-			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
 				continue;
 
 			drm_sched_start(&ring->sched, true);
@@ -6082,7 +6084,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = adev->rings[i];
 
-			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
 				continue;
 
 			drm_sched_stop(&ring->sched, NULL);
@@ -6224,7 +6226,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
 			continue;
 
 		drm_sched_start(&ring->sched, true);
-- 
2.25.1


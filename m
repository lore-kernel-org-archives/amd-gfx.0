Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D6BC47422
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 16:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B7B10F904;
	Thu, 25 Jan 2024 16:15:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A942510F904
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 16:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=El1mzGAjjU03mju3Tt5jgBmpYEyQB37JtfLGL5RD/ReYZGJ2DnFX4RTkUtgp0PaA48zGuWwov7MBbX/FRVV43j1cAKwRIK29m4FKAtJzQq/kj5dmF6SAf89wjb/pqKCnQZGyeAwAMVS0MVIEndvzMGu/IPR1tHlBtkpZcrO5bzPjBEby9rTVtl3simsKWf5/GvbOp3ZXSqzy0pbOs/me1Q4gClM0q8lONhgbls6vKMns5VHiQ8p3fIYr637pcop2TxDYjTt7lg/OBBwrQ1Jz6dAGGqzZHPMkVc72ucoroUHmgOJxBAuN0GpixqleFO4qL9Jf3OeuGaBWF87L72uLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3m0X/GM0MyEppIfZcNHLElA17CFlHrC+N0tKNNDmNLs=;
 b=oZ1CN6MDBOJDtdIn0FXSxXVn+5Y+e2Mnbt81bd1d2Rk2IA5lPOVSXUqnayold9MeRCrecJAIZQeyDmUg8uD+qz0dS1CDF+yjHU6Z4K2cJ0bwWrmf7SiE642mFRFd5AhUVHgug0fQqGRepdDwKZGKKaFpJ3Nsako/QIbER/M/SR1jN1k7i+mwGhw0Xjtq5qO8SNNx1aLM+oV3fRBavtccgtPOxJvMrRpi8nJ7AvkdtUBrt4sbnqxvZdpoCrpJw7NK1CrGtv8+Uy5oatsjcqxgHNLLwcs5j+SUOLlaJilGL5L4kRcTb+EjM2DexbQVCr10fdzUpbo/CBZ+9bk9w1YEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m0X/GM0MyEppIfZcNHLElA17CFlHrC+N0tKNNDmNLs=;
 b=XUj/Db7nBpHv8oXG25dJhtp/+mbH9a+pB1heXuNUSEvbJHhYwHQFCI60w8Ku8J4npWyf7a4HJdVir3TCgdoKbvAC+ixayRNBvHX24gbHP7rIaP0r4usGwvBI65YlrKVRdfI1ULnFuCK0BGZ3bHSQwcN+G7AxkynCzb/ocLRfczU=
Received: from MN2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:208:178::29)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 16:15:33 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::94) by MN2PR19CA0016.outlook.office365.com
 (2603:10b6:208:178::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24 via Frontend
 Transport; Thu, 25 Jan 2024 16:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 16:15:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 10:15:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the warning info in mode1 reset
Date: Thu, 25 Jan 2024 11:15:14 -0500
Message-ID: <20240125161514.436188-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 188dd12b-024b-4a27-1139-08dc1dc0dbca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vO5IrIc4GgF91O5jx+5yrTHzlsV2GLvNOdN9/Lx1vxfWHg8hu6PnCRZzwLoxUMEaui7z+jVB+SkeD57cQRL2XG25lsJ24JWxWcdojqLRj+S458zV4CTQ/PJqRhbv+bjLSHRtVctoy/pInbBIerb32o6PapBupnaIKFFny710lasak6wb4N7NRc3KUA3hJWEEtqLSj53EhFWCQ4YwpdvW3jv4qiErELaYbtl2qzEuiaCXdgJ1Grlp2QmSFf8yL6WnyI11YTpnfDKy7yJxultW+pCzPL6k7e8rD/v8pv75O5I9xhfSCx1NRAiZ+6PlAV1b1nbrdWyK/odAMdmw6aReUT/HsP+nnmVIQBwIFpOwD+2xRvrRP4EIMd/45f7/zcpT+GacSmyNMXhCxODMN8JVapFmm4+grIkHDzmr8axAbkd/QSFiuT2MaVANbDOc/zH6wdwT7CIx7A6b4PuXK1/10SHs0J1QJDikNxbnWtn/5CPhYP9r9ZLgfRoVu17ydZPzz4aK3AkBzORvxWTcfI6gtNcTUurrZyF/gMbUx0Yv5lAMXIxNFUJEz649++EJmcKPrwIcSYGQw/9W7u2K+U+SyBaitEAGC4JGDcgkN2MNtTSGO6fPBFuZTDEZoIraMgrY946eCtHYWZ5KA+OR5ys29/NwBoHxHyEO3op/1N9c7i6o1l0yLNiFDt4xf0B2+WIKm80sVKQUSgIsEa9OwZwlGAk7sYPzw/1yCIjfJ6Y/Cvjq67neAxp4o72HEH7buqlr20sO2OT2Mn+h5Usy8R1KvUX2KeFAQ8ueqLTS14A7k2TI7Aon8XfmyowAEsix06yI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(36860700001)(8936002)(8676002)(4326008)(316002)(5660300002)(70586007)(86362001)(6916009)(2906002)(70206006)(54906003)(47076005)(36756003)(6666004)(82740400003)(356005)(81166007)(16526019)(83380400001)(7696005)(478600001)(2616005)(426003)(336012)(41300700001)(26005)(40480700001)(40460700003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:15:33.7678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188dd12b-024b-4a27-1139-08dc1dc0dbca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ma Jun <Jun.Ma2@amd.com>

Fix the warning info below during mode1 reset.
[  +0.000004] Call Trace:
[  +0.000004]  <TASK>
[  +0.000006]  ? show_regs+0x6e/0x80
[  +0.000011]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000005]  ? __warn+0x91/0x150
[  +0.000009]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000006]  ? report_bug+0x19d/0x1b0
[  +0.000013]  ? handle_bug+0x46/0x80
[  +0.000012]  ? exc_invalid_op+0x1d/0x80
[  +0.000011]  ? asm_exc_invalid_op+0x1f/0x30
[  +0.000014]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000007]  ? __flush_work.isra.0+0x208/0x390
[  +0.000007]  ? _prb_read_valid+0x216/0x290
[  +0.000008]  __cancel_work_timer+0x11d/0x1a0
[  +0.000007]  ? try_to_grab_pending+0xe8/0x190
[  +0.000012]  cancel_work_sync+0x14/0x20
[  +0.000008]  amddrm_sched_stop+0x3c/0x1d0 [amd_sched]
[  +0.000032]  amdgpu_device_gpu_recover+0x29a/0xe90 [amdgpu]

This warning info was printed after applying the patch
"drm/sched: Convert drm scheduler to use a work queue rather than kthread".
The root cause is that amdgpu driver tries to use the uninitialized
work_struct in the struct drm_gpu_scheduler

v2:
 - Rename the function to amdgpu_ring_sched_ready and move it to
amdgpu_ring.c (Alex)
v3:
- Fix a few more checks based on Vitaly's patch (Alex)

Fixes: 11b3b9f461c5 ("drm/sched: Check scheduler ready before calling timeout handling")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |  2 +-
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 899e31e3a5e8..3a3f3ce09f00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -290,7 +290,7 @@ static int suspend_resume_compute_scheduler(struct amdgpu_device *adev, bool sus
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
 
-		if (!(ring && drm_sched_wqueue_ready(&ring->sched)))
+		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
 		/* stop secheduler and drain ring. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index e485dd3357c6..1afbb2e932c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1678,7 +1678,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 		drm_sched_wqueue_stop(&ring->sched);
 	}
@@ -1694,7 +1694,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 		drm_sched_wqueue_start(&ring->sched);
 	}
@@ -1916,8 +1916,8 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 
 	ring = adev->rings[val];
 
-	if (!ring || !ring->funcs->preempt_ib ||
-	    !drm_sched_wqueue_ready(&ring->sched))
+	if (!amdgpu_ring_sched_ready(ring) ||
+	    !ring->funcs->preempt_ib)
 		return -EINVAL;
 
 	/* the last preemption failed */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1a04ccba9542..7ff17df7a5ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5042,7 +5042,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
 		spin_lock(&ring->sched.job_list_lock);
@@ -5181,7 +5181,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
 		/* Clear job fence from fence drv to avoid force_completion
@@ -5648,7 +5648,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
-			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
 			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
@@ -5717,7 +5717,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
-			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
 			drm_sched_start(&ring->sched, true);
@@ -6072,7 +6072,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = adev->rings[i];
 
-			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
 			drm_sched_stop(&ring->sched, NULL);
@@ -6214,7 +6214,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
 		drm_sched_start(&ring->sched, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 45424ebf9681..9ae386e9d41d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -634,7 +634,8 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
 		DRM_DEV_DEBUG(adev->dev, "ring test on %s succeeded\n",
 			      ring->name);
 
-	ring->sched.ready = !r;
+	if (!ring->no_scheduler)
+		ring->sched.ready = !r;
 	return r;
 }
 
@@ -717,3 +718,14 @@ void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring)
 	if (ring->is_sw_ring)
 		amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_DE);
 }
+
+bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
+{
+	if (!ring)
+		return false;
+
+	if (ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
+		return false;
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index bbb53720a018..fe1a61eb6e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -450,5 +450,5 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
-
+bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
 #endif
-- 
2.42.0


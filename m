Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B04ECD5BB4
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225FB10F495;
	Fri, 22 May 2026 00:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/5tADLp";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBB010F487
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVIPPhep6c8GUPePgWbZ/LkG9YtMQKIR+T23gKG3frAEpt9hZz4S4SvGb6FW9D4zAPcN3CosaudTIe1FQp+JPAWBzM4wox1Kkq6nQsqDx0pfo50A9sCzkD4F+b9sijxyTfsRv/Tu6ZWukA597CqJvd7aUp8ADvKVQstcGEN8s03G9/C+LkaYhq8UXkQVo085wchZn66QpYUR6jNSHmwEWi67vhvf3Idj05QGRa3DyXlTLqmr7MuaAdej1+pU6CiwBY6gtoxRDRNExe10+nIHNMkcBbW6XvOSJ3mVJE1RKJ50J39V4xpFrCXYRf1G+foRTVuw1jxNSkWWor3uCrjlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rejPUbSGxiZi6M6em/YVn0Z6pR7OCNTZuExn/+RS3o=;
 b=LauPbxB2CS3AJCQ6AS60TOP7bTymv8Vo6vVzlZoxlm+Qa3XnRGaGOFsjN1nqpTrpiA+5KMSWuslWzoj21/ju340a2FKKNJv9sn+rbE/AOOslO/f21369ejr6dIK+frKIVpVcwttEybbfbWOfvKnZOrQYrxZMS9ZGZmyATNLccj/ucCKNvN6rtKIewCeMLBDdSSc+E038fwdXPgQ9O5mazPIQ7ytOnAUa3NHdNlouZtzXZoI291ps/U2V31CFFp7a2lUkB+f7mW3d/5uweu3BE0w+JggJy0RTQai1vEfcpSP/bqq9r3UTD0KzgF8+Sub+Mk/UlJ6lxr4WquutRVWACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rejPUbSGxiZi6M6em/YVn0Z6pR7OCNTZuExn/+RS3o=;
 b=W/5tADLp+wZcFegICqBrvCrmdmL3G++QYuIIIkJXcQTvYnZvnCoM4aNu+Zqw+hVuU8by4GH57+mnQtP9FvHBOj0vBDmO30oLyD5P5sNXhZ84TJp4h+ZAyDg64pI/HZyFd7zpyEuqwkUtaXiaYLAndGfQZv4rez5vCV0I83UMBJI=
Received: from DM6PR21CA0025.namprd21.prod.outlook.com (2603:10b6:5:174::35)
 by MW9PR12MB999208.namprd12.prod.outlook.com (2603:10b6:303:301::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 00:22:25 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::21) by DM6PR21CA0025.outlook.office365.com
 (2603:10b6:5:174::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.9 via Frontend Transport; Fri, 22
 May 2026 00:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:23 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 38/42] drm/amdgpu: use a single entry point for mes compute
 reset
Date: Thu, 21 May 2026 20:20:44 -0400
Message-ID: <20260522002048.98506-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|MW9PR12MB999208:EE_
X-MS-Office365-Filtering-Correlation-Id: d73ba33f-59cd-4062-096d-08deb79832be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8QkPJDsOxoH057Mdo5Xu+RQyRs0JooINRwmL/PV/U20MdfPRzY5nM4AOayMuc4LbJ5YJlaBNj5RikSJl8fIElxbyj3IMTnfA9kFVWXjK0dldVy5knoDRRHecrd/yl1/QqWuQopnt/1GWXQRKESWi51bem8xH9evILZWSIu+8xusUdDGFh13EE4iheRTpycMO5wbrZbZ6BwhX4za+nrYInsuAZFODzqWn0COF59sJRNY9Svmm52RDPA6QPLZPwsJ9tf+XhsX3VHqKImPDr+HKB6p+X42nMrFZOkdlWY/nsgBTJEJsxdaYA49h6SAQI+ngIeCHeSmE+AMkhACVwWZgX/l6fshZhmAspEGBe03VrfQdQHUwpjYnJdzZo7GwqSVtUhpA5SgrBFsfNTuARfKyjUsnZiDDvIFfEWd3+xmfBcg2o70JtNF+6szYFtnS/PfD4/bl18EvG+UHAJcSizofwDa3SFikPxAlsgmO/beK1i/+oZ6ZRN1d3kt7pE2en+mQ0T42TvG0PzJ4BW675Fhsjp6SQpPQOzGE73CQIpu9Bq63HKpGJVIPMpfEy129pavwsuOa/ZcjUVVFR5nniGAmZrHu5Q4VflP3rJrPOzYmIDd8X1jzDJXGCp8jauj7fk3lk2tJyHN+TofXpZY1D+Lr6o2I4MO2i2p6MGXmasbkzf2ey1xRJutyB6FWVNsaAVvc7rs9NTBA1ljmV5QqnfPAM5O6ocALQs9fqVFG0Ch/GzI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5tex4sKQZ5U9LvnTxNW71Olhgm8wZ4NF/Aap+BoLJluxj2YtDLlRQHiXU1MgPUymxNCbtAFicDkMQQdu8ZZlMdez3SLqRZ5OxumfLPwKR3jG7R36Hu6q2dfh1MA5yZQZyuNqqKWEMHoNQgHaDqDRZWQK43zqQ4ca0Uk9QFqnYvnth6LwkeuqOgyWnwO2XN01tVdDcBtf1bbKfzgnVwwsMqyXjUNT/cTxClVWynAYv79HcWosPo4wWmatf7ih8r3/hd+SSyj2gyAfTy+/xsaSOJtwlwtfR5FR2Xhx+5URrmBfjuYURzuk97zEh/rEqkaXkf8+kwM5FJ52A1JMpfFJFyW+8UA4+h0BQfJpWeRA3vvH064EeJvlCbw8IIlvOesgcUu8XvXXu/NIqaLAiC61G6E2R7g+dfvRQ6TKyfVDJa2a8N/8EEUfI3D1CtHqaBB6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:24.6835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d73ba33f-59cd-4062-096d-08deb79832be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999208
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

When we reset MES queues we need to coordinate across
KGD and KFD.  Use a single function to handle the
queue resets across KFD and KGD.

v2: squash in fixes for userqs

Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
Co-developed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  3 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 75 ++++---------------
 5 files changed, 22 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0c9d370341a97..94cceafce51e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -138,7 +138,12 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 
 	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
 						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
-		int r = userq_funcs->reset(queue);
+		int r;
+
+		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
+			r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, NULL);
+		else
+			r = userq_funcs->reset(queue);
 		if (r)
 			gpu_reset = true;
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 32e01eb311c3b..d707ca106823c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6795,9 +6795,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 
-	return amdgpu_gfx_mes_reset_queue(ring, vmid, timedout_fence, use_mmio);
+	return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence, NULL, NULL);
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 247bcb7034e19..82b362f3651af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5231,9 +5231,8 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 
-	return amdgpu_gfx_mes_reset_queue(ring, vmid, timedout_fence, use_mmio);
+	return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence, NULL, NULL);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 5e6a146109fc2..0ce59fcb411bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -205,7 +205,7 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 			  unsigned int db)
 {
 	struct amdgpu_usermode_queue *uq;
-	bool use_mmio = false;
+	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 	unsigned long uq_id;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index babf53b7b1bb2..885bf98407842 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -412,7 +412,7 @@ static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
 	struct kfd_process_device *pdd;
-	bool use_mmio = false;
+	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 	int r;
 
 	pdd = kfd_get_process_device_data(q->device, q->process);
@@ -447,11 +447,8 @@ int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
 static int reset_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
-	int hqd_info_size = adev->mes.hung_queue_hqd_info_offset;
-	int num_hung = 0, r = 0, i, pipe, queue, queue_type;
-	u32 *hung_array = dqm->hung_db_array;
-	struct amdgpu_mes_hung_queue_hqd_info *hqd_info = dqm->hqd_info;
-	struct queue *q;
+	unsigned int num_hung = 0;
+	int r = 0;
 
 	if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
 		r = -ENOTRECOVERABLE;
@@ -467,51 +464,9 @@ static int reset_queues_mes(struct device_queue_manager *dqm)
 		goto fail;
 	}
 
-	if (!hung_array || !hqd_info) {
-		r = -ENOMEM;
-		goto fail;
-	}
-
-	memset(hqd_info, 0, hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info));
-
-	/*
-	 * AMDGPU_RING_TYPE_COMPUTE parameter does not matter if called
-	 * post suspend_all as reset & detect will return all hung queue types.
-	 *
-	 * Passed parameter is for targeting queues not scheduled by MES add_queue.
-	 */
-	r =  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
-		true, &num_hung, hung_array, ffs(dqm->dev->xcc_mask) - 1);
-
-	if (!num_hung || r) {
-		r = -ENOTRECOVERABLE;
+	r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_hung);
+	if (r)
 		goto fail;
-	}
-
-	/* MES resets queue/pipe and cleans up internally */
-	for (i = 0; i < num_hung; i++) {
-		hqd_info[i].bit0_31 = hung_array[i + hqd_info_size];
-		pipe = hqd_info[i].pipe_index;
-		queue = hqd_info[i].queue_index;
-		queue_type = hqd_info[i].queue_type;
-
-		if (queue_type != MES_QUEUE_TYPE_COMPUTE &&
-		    queue_type != MES_QUEUE_TYPE_SDMA) {
-			pr_warn("Unsupported hung queue reset type: %d\n", queue_type);
-			hung_array[i] = AMDGPU_MES_INVALID_DB_OFFSET;
-			continue;
-		}
-
-		q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
-		/* skip queues not owned by KFD */
-		if (!q) {
-			continue;
-		} else {
-			r = reset_queue_mes(dqm, q, queue_type, pipe, queue, hung_array[i]);
-			if (r)
-				goto fail;
-		}
-	}
 
 	dqm->detect_hang_count = num_hung;
 	kfd_signal_reset_event(dqm->dev);
@@ -529,22 +484,18 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
-	r = amdgpu_mes_suspend(adev, ffs(dqm->dev->xcc_mask) - 1);
-	up_read(&adev->reset_domain->sem);
-
-	if (r) {
-		if (!reset_queues_mes(dqm)) {
-			r = 0;
-			goto out;
-		}
 
-		dev_err(adev->dev, "failed to suspend gangs from MES\n");
-		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
-		kfd_hws_hang(dqm);
+	if (!reset_queues_mes(dqm)) {
+		r = 0;
+		goto out;
 	}
+
+	dev_err(adev->dev, "failed to suspend gangs from MES\n");
+	dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
+	kfd_hws_hang(dqm);
 out:
-	resume_all_queues_mes(dqm);
 
+	up_read(&adev->reset_domain->sem);
 	return r;
 }
 
-- 
2.54.0


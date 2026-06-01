Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0D9CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4668112DDD;
	Mon,  1 Jun 2026 05:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TEfTgI5i";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4A1112DDD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxKjIHueVcXal1Qu6PRJB2eze4b9xLgtDuXuCodktQ68WIhQvboCTLHminLJNqgObvV1cxOUO+ZUdRwNHxb8kjdHjgz6QheoU2gaaz8rptTCz6mbq1zStpmiWWHRgol7+mSc2kRufyas7uEY04GLb+jjK5mMvC7Oh+y3SdTPcJ3kH1CJjdlrjyCTPmrlLM8fBtGp0M/LIzpHAcgAgdyUXl4wsSoFVANn0fw6SWh4cP5bhtENwu9K6eEk63nSu2b1D30SJ+q5Vsji/75Bcksx8hVCwQbsDB+1AfQiCA0ODlsqFaGKG2XQor8CUL9Kdk0e8o15C7LuxKmfUc0D5XQjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EBSLV690R/IlfO7jmdy9DGfLtjnNPhkWCIV9txfi+Y=;
 b=ULxpi8Q/LeeENJT1PV13NbL5qdK/AnPeN6CxKUju7fM5HbVfNTkGsOypIE0cS3whE8TjMbD7XZbJAH4FnBDnlHoPHGN2jr10IdpNaREb0alOL0CIM2GzNUblpZpOA1AlJBDesDwhsnZfrQ+J9Dmef6QFXeafFk71G82KllgSSksWZKODdLjXt+AfuBj1pmnsXHsKQLXpAAaLj3CUefHGFFuX9tz00xH9I6PpctA1BA1q1DJYBRIz1zcfu/4vTTKf+goX5L2GnBchlNqjd+gN2h5a8Dy7xX9gSgXj/y7ZQVzpRElmKo3G+CtOiq2I7qm6x+kOe2+mCmkeOgwud6u0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EBSLV690R/IlfO7jmdy9DGfLtjnNPhkWCIV9txfi+Y=;
 b=TEfTgI5iVUidwHQQstDYQsapZjsFtGTZRUPRS091N0+/lKfubdkYDQ0CYHVOVRndlbpTx/GM65bNFk9ASjQsuh7nyjAT3xjfrjJax+vRlSqIh0wNYdGxwp/cd+ArDDW4hj28HOvqjLeWRgnedE1CXReLFhSYq68hueWWqXBTOn4=
Received: from DS1P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::14) by
 DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 05:55:15 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:8:454:cafe::43) by DS1P222CA0001.outlook.office365.com
 (2603:10b6:8:454::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 05:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:55:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:55:14 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:55:08 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2 38/42] drm/amdgpu: use a single entry point for mes compute
 reset
Date: Mon, 1 Jun 2026 13:49:24 +0800
Message-ID: <20260601055034.3700921-38-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 227d758d-260d-4afa-f941-08debfa25a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ChozeCIy41xuLrird6APy1caGdPEpycqOdPWEm/IaNLZRri9eBAA3gFHibSHvrJIEuXdQkTu+fLklie8bmpuHlZBZhX4AlO1BMpwFEteuq1O947YFsxVRziOIXf/cXyoqgL6JCw4cFZtdf34vxElmebo2Hy8CI8fedB6VCHikLJV42yoG5+STlI6QAgaaherEkN/+OxwpL7NzcmS5aFJq4/3l2X9DWt+flPUhrZ50KxxVsUfH6OrDG0GSdiPRipaiT7o5wY2n3ZBnQHNb4n0ndqSc5R3Qkf6eG1TMjB7je08gQciTdD8N4Ehrc1gMEFQEB28qdUY7YTg/OqN8ukcYKETv7lj8x5b2GldiSttn4pUc+0slySn21Y24FNFgeyhxlujmlAL056rC6kJpGWCzRmZQ7E0P13lodQpONMgdoNXruJi1MtR8lO6oVGN8a/eL1s9Wjg62NqldU0DYo4XqlGwmo3Qz7TV15+/Mq5OJikTunlznbx4mqaHZyezKmpbc9ksDBVhVX3jpSZeSIccSwXGkjI9ltbK5dbMUvKngke+Vf/gmpQrnVERv/a8QHFoSWBNJcIb66u7/bTQr8MY9B+3ey6e7DphNf5ejAz5oS+V0I9dYfrkO+ugTY58xXJK+1AX4hLdmEx1e53uMaZkHabutsAuvTuiMP2y/QZaBTKOpcZQ1Y/6CCuBVmiY9e13ApJnGeMvOkGyiqM4+9HTEKAdyph4t7GjC4wXfg97b88=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y27XyhZqfs1K9Rd87tGmEU4lnFIAbMg41vp/JqkRnl1GxZ09ga8/QcqWEd4VpEOCqnJuoNw1WBte0YhWXvkBM3OFV0BJO9V+cEevcqpsOmFLD698tdhecen5oQNCng66CB98TcY04LNcoUm/1dH8rAMg6e9kBOCFm22roBVVHcEnTs54QNN00dZDNcqJpPBB0P/dHqx7XFCGPiX6iCKOkHkhP5nLsHGRjHM2xICwbOtNAtzjLAsPnK5SJquD5hUnyBXAb4g7LlEr1DmSgxNY3FPlRrXuDdyYdvw/14zZVbA1EmoK1xJFp7dNS25VwDsgwlvDsP5FMlsHZCHVlf5T2edx5+exJt/NUb0iu+ZGwCUSj25cfkhwsCcRuo+jvmzcuVuhiNwF1PfPXRewVHyVZ0XnJP0LvF49CK98xnr6d6hDv/tj/AiYzSf2wqDkRfOT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:55:15.3368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227d758d-260d-4afa-f941-08debfa25a51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

From: Alex Deucher <alexander.deucher@amd.com>

When we reset MES queues we need to coordinate across
KGD and KFD.  Use a single function to handle the
queue resets across KFD and KGD.

v2: squash in fixes for userqs

Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
Co-developed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  3 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 75 ++++---------------
 5 files changed, 22 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0c9d370341a9..94cceafce51e 100644
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
index 32e01eb311c3..d707ca106823 100644
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
index 247bcb7034e1..82b362f3651a 100644
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
index 5e6a146109fc..0ce59fcb411b 100644
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
index babf53b7b1bb..885bf9840784 100644
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
2.49.0


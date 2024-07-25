Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D08C49EA1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81FA410E857;
	Thu, 25 Jul 2024 15:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E12dPkC7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E90E10E851
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vImkz+OR9xhkYqIByhAxtD0Om+QeUuG6PEVVWAwF+syKOnf9DpVmrlyiM0CsVOCboJqwChhfguugYtKthJPU4W0m484yzOiFrOEgAPXyhVIiDj28GzgKIQmZ1QfJM0PDiburBDIj5sHMxc7oeZp2rIMCDI0y2K1ZYkyAu/HhM2sT5VzRvS6Za07SCiQE5Ut6NVGKHIXqFZ6NX0NIIiRi2CWlTOBV4BAUjbkF6LIPYBWivrZArc8mEx7w0e9Uea0AyODJAp/wqR/RwaiS4ue9DhqG9PnMmKV8banm73rK/cdrXkQP7hatiucjnHR50p0fnAzKkhFuW+543RongRddoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEMP5cOEo92TVZtnxLdXKhkYwfg+KS9/HjwIy5gkE9Q=;
 b=ontFrJ9QuQTeBhb1NYBVASJIv/SYeYARuHXMTxA4XKKxjDDdrf0c3Kp42GFQm3wn9aMd4fwNkFcFUd8WGf4Tn49GJD8/03yYL0K1NruARKQhMZq1ic1jvS3qFv7DbmyqnNh/4hw9pr+L/7cAd+ehLS7RlIdnZvUcQUpP5xRSsBmcVl+UXHkXDG0qGLsfzp0Nn7MZWAu27/dRW3qgePEyD6fXszDr0kPd4bFC6zfqE137LGSJSyFsY0r7WoPnuthTfdK0vbviLTQxqj29kgmWPWCE6nvLUxZjPpXlVOYDJW6W168pGOhMhMF9O2ZohYUNfwzD3I04OGObbmffRoRNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEMP5cOEo92TVZtnxLdXKhkYwfg+KS9/HjwIy5gkE9Q=;
 b=E12dPkC7VT8HXHX/XL4mFmtpFLF0Tk5mC0OZhrdTV8wE7QvYgHaZBDYgb4vyDjTzu8SKj974ANE7KCXPBMfK0SnKJ1k5bUrdj/03rWCndxeuY6YP6h92ErroHYlixFKxWlgFE2WdtpRlgOIMkAuC1IE+gCbHSaktbPhAge0v37U=
Received: from PH7P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::7)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 15:01:21 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::73) by PH7P220CA0034.outlook.office365.com
 (2603:10b6:510:32b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Prike Liang <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/53] drm/amdgpu/gfx11: fallback to driver reset compute
 queue directly (v2)
Date: Thu, 25 Jul 2024 11:00:15 -0400
Message-ID: <20240725150055.1991893-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b3015d-2216-485f-ebe1-08dcacbaa4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1sFuSYD74HUdIiO+2qs0apqbYzwl2kg4H0JFLYNLBuKo2pWq+Oi4ZNWxdsEC?=
 =?us-ascii?Q?uEdqln1WhpsfpS3kcowaJKWuZOo2V7SbkdAUAbEuBw9xsGRN2G8vcYmgW1VE?=
 =?us-ascii?Q?JpfuSdKAUtK7phuP54lLSaeCD1PHj/BpBy7udfV4WO18+7E8cnDgAqj+lpnr?=
 =?us-ascii?Q?GrtOhvXxyVwmC4rqhSoBvTMOWUId1CcFF5CBOKjGk1I3SW/nqrP4otn53emD?=
 =?us-ascii?Q?7JxyvpNnIRkRoNzNQXbMqDr9KJc2Xqp0Ir9BAQlaRtMIIEOg/GuN0VrcNojA?=
 =?us-ascii?Q?eUDT2Hp0ydDm866IjM7a36OkQETidv1R+Gk+bnwbNRagKZMq9PaJjxuTIjS0?=
 =?us-ascii?Q?ZCR/7lIXYXJChtef348btVVhFE/+Yw8Py8rCLWueVR4gbPUCt1oeabVOgWpA?=
 =?us-ascii?Q?eEFiixRvSChPGU40CHhyXOJzwqEJbXYmAQQeSd59DO4FOSD8Aq7TecHNLJV1?=
 =?us-ascii?Q?jaIRhGDSLKHaL8f9W9fRD5gA5hsYiYsUGHpQa0vGPiIXp5gOr1zmbHazYrv2?=
 =?us-ascii?Q?2Vwruu+T15BdSCkQhVvwSJlMvu8adOelFb5xpYebWaMPJJhrCnDANfOh7o5B?=
 =?us-ascii?Q?zdXMCC7A0ZWqEbrqtKqIyu4lrzHomc/HHOxd5nTCARtmHg4ZnudFepgESvhQ?=
 =?us-ascii?Q?CmEYrT4R0WkWN/1E2Vn8xnrW47hzcH3+CLuAij9ltdB5rEQ7Q7arUoe8s34S?=
 =?us-ascii?Q?5ZNwiSQNMyjwQk3+RQYosSkZtBxWt4DUMuSs+ocU2G1W3GDxSu38RhJPTRZA?=
 =?us-ascii?Q?G4EVp2ASwIY5um6b2jY6+dYT1OCxfggU+HwIkAyNIS7ULzPGv4FdzBzYGjbK?=
 =?us-ascii?Q?hz1BBtA7rR6l3Ayy2prLpuRSdNvTn5jsliqU7+No9v1NKHpSsqiwV+9E8CWZ?=
 =?us-ascii?Q?o6ZKUdEZ5XrB9WwZFKcTOAiodPxx2CZJLG2CGJiEExW9vwWoKI30e97XnLKY?=
 =?us-ascii?Q?rDlVFqsxEtHMYSeQdUAzdAhQUm/Z2gQUFDEIXQF426l3+3sdUBCZ+9ueepY2?=
 =?us-ascii?Q?17LybODwSHfXtiv6Xn5KIkbdyyAKqwXYf8iVGPxaa9NDPX6WTAFo2kzd5ez6?=
 =?us-ascii?Q?9zBNSibgGZ+YO+osFztUylyecDp9GSmRSvcppl51MU1/sSdOpVLQp4mkl7Za?=
 =?us-ascii?Q?IXWSTkw7uIufcILNRG9+HWHCDC7ploues+MoeJ4wI6iFnT3MYLQnYbMypy4K?=
 =?us-ascii?Q?CQ+X0+oJ0ZsqeDQHnDOHLlGeX3kBN8pkx0ZhcnFs5mE2P/8Ku+en4+t7TsCc?=
 =?us-ascii?Q?XctCUZgk1lAhvHm5K6BMa9lewtdP2tS8l8yX7Co7oCJnrP4mAT7f51CsgEdy?=
 =?us-ascii?Q?DUMLkIF2H9DRGdQpJX+mMcTVVjN+pJSLWOJIVVVVddtbMAO2DB7xQvTzEY1z?=
 =?us-ascii?Q?oXY6ZzWKKgvId7vXZfOaf/kAFT25niF4wyc/67sL8eAWjspruVI81GejKq0Y?=
 =?us-ascii?Q?soVTYTudoWeRgThAvZ6awJcqcJvhbNNx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:20.4477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b3015d-2216-485f-ebe1-08dcacbaa4a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
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

From: Prike Liang <Prike.Liang@amd.com>

Since the MES FW resets kernel compute queue always failed, this
may caused by the KIQ failed to process unmap KCQ. So, before MES
FW work properly that will fallback to driver executes dequeue and
resets SPI directly. Besides, rework the ring reset function and make
the busy ring type reset in each function respectively.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 84 ++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6436f7d680da..d1c369972371 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3966,13 +3966,13 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
+static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_gfx_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -4008,7 +4008,7 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v11_0_gfx_init_queue(ring);
+			r = gfx_v11_0_gfx_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -4303,13 +4303,13 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring)
+static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_compute_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -4373,7 +4373,7 @@ static int gfx_v11_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v11_0_kcq_init_queue(ring);
+			r = gfx_v11_0_kcq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -6520,18 +6520,76 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
-static int gfx_v11_0_reset_ring(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
+	struct amdgpu_device *adev = ring->adev;
 	int r;
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid);
 	if (r)
 		return r;
 
-	/* reset the ring */
-	ring->wptr = 0;
-	*ring->wptr_cpu_addr = 0;
-	amdgpu_ring_clear_ring(ring);
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v11_0_gfx_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		return r;
+	}
+
+	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	if (r) {
+		dev_err(adev->dev, "failed to remap kgq\n");
+		return r;
+	}
+
+	return amdgpu_ring_test_ring(ring);
+}
+
+static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r;
+
+	gfx_v11_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
+	WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v11_0_unset_safe_mode(adev, 0);
+
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v11_0_kcq_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r) {
+		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	if (r) {
+		dev_err(adev->dev, "failed to remap kcq\n");
+		return r;
+	}
 
 	return amdgpu_ring_test_ring(ring);
 }
@@ -6737,7 +6795,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
-	.reset = gfx_v11_0_reset_ring,
+	.reset = gfx_v11_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
@@ -6775,7 +6833,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
-	.reset = gfx_v11_0_reset_ring,
+	.reset = gfx_v11_0_reset_kcq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
-- 
2.45.2


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3035CD31A29
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 09:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49A110E5DD;
	Wed, 14 Jan 2026 09:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fT+X2mu+";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013013.outbound.protection.outlook.com
 [40.107.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7181610E39D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 09:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZeWoe+3pJhsyek9f2MV6KA7OydnAr4DljFy7T6/oQGMOMQ98ogcx8qOCOBea+m13X7LOninHti7zGJff7Ce3GhfTJY5+4v0X55Qycfq+gc85xi8N28dYr/Db4HCZ21zZYRz2INNPWhGvy0fAndR96ZrgGjpzeDvej3KQMW5uVHhXvaVJYQnbO0xxvmwv9/8Wa5YQbePP9n+Z7SUbl2+k5mRZYM/XRAXa91JOW3GdL3IYKEPD8xklTx4a4wAo14Ju9UL/dSP8tDUWkh/658a+UK09N7BUs4i7PyjZNY0FU4BfDFpx9xfjRcJaE6shNqjOiLnq9DHO7yRj7ZWDI6B6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5QeGyxTjQzUbuKga0jrSnbIWXrAy66MQ0az95wVCKk=;
 b=NnsqQbPdPNjU1xQurIBAASfoMk/OdIC4WVy5URL+VTTsrLs6IRFJHDTsqNb+jrsxN43iK3hWseAYoImk/miowSicSn7m/cGwEqzOIgImUw74SSCpQRHVKJ0XL++ZMbYx8FrHZDp3NQn8tSUtnLP77uEDkdjSosaFCjaREAVtXHG6NabrkqJ9dWD1BcMU1EZVdGos5M9eF18JX9kdFZKRzbecOQPTQIiAaQRF8io4wfA6h0tueU+HiqJMnE6KTbB8PF/+tA1lhouAdfvIR+APFvn6lNKMsmbJgrosKV+HJ+hjFi4jDlekrCC9SahHYGGwUnqKq3i1IxNJbFScqyq7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5QeGyxTjQzUbuKga0jrSnbIWXrAy66MQ0az95wVCKk=;
 b=fT+X2mu+/7nxvsCvfun9VP6usC0wqnksg4PXy4IDEXPVydzj5Us4Sa0hyoHx4+lldL4s/sHmHoQF/knVxjdcWCy1XjjYwipXkNtdUGDbBr8UPdk/6ZfZNKF+G0h4c6Slj7UDeCOe2Kt9qzltzzrFLWQ3scPSzhMSQRhcyd2sQbU=
Received: from CH2PR02CA0026.namprd02.prod.outlook.com (2603:10b6:610:4e::36)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Wed, 14 Jan
 2026 09:01:44 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::c2) by CH2PR02CA0026.outlook.office365.com
 (2603:10b6:610:4e::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 09:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:01:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 03:01:43 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 14 Jan 2026 03:01:37 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/vcn5.0.1: rework reset handling
Date: Wed, 14 Jan 2026 16:59:22 +0800
Message-ID: <20260114090056.356633-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260114090056.356633-1-Jesse.Zhang@amd.com>
References: <20260114090056.356633-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 8609d247-8bc9-4f84-1ca1-08de534b8a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tXvgpkiU9WbslGEMWYvKmmcUvgZgSM1YgMCGxeCkKYyZZ2eCuvtW9+bPFl7A?=
 =?us-ascii?Q?EuzeEfogU+VtVxaIrRyy1zgS93XLzafeNi3L9qF0d4X5o1kO1ie5MnQMwXqU?=
 =?us-ascii?Q?4q1XIAgj9VpObxTKGx2GabwAdCPvUomdZqzCtGy4aDnqzkW44EMo/kY7Q4q3?=
 =?us-ascii?Q?25OlE5PbVLKK2ahA1PAyKHeiSApdyzaTy7Rd4YNDUi71bf6hNCI7Jjaoo8rZ?=
 =?us-ascii?Q?RKdBUXTM5gon3KsD3qL1DfFGPSkKgId3wS4ahMlnBL5fW89C2CA2RRltvMhb?=
 =?us-ascii?Q?NpjQa5ufGdlPm0e5RG4N4qAwkhzBOKwIxInFv+T7DEfgUK5stNTR0weJRAMF?=
 =?us-ascii?Q?hWWuZmOyg8x4VGYaeDf496tPQjfP/+ttJlcXpA3H5BdRe76t7u+lENE9doPM?=
 =?us-ascii?Q?pl5aoeZw/eOC+lbynjZI4hbpgAodHiKR0HjhZlQAtUXZ2TaFvglxRMeu13j0?=
 =?us-ascii?Q?016napQdnM/TgvQ3TWrFVXF7DdDtoE+aiBqx6SK0gWWbIRMibInwk0qEp1bs?=
 =?us-ascii?Q?UPYBnH0aXZfyK5+zp6Cf7y4yV2udnKSePkYYNoHzO8+WHx7TeA7JY/ocMFLT?=
 =?us-ascii?Q?oSLk+MvqV34LV5YdauY+SN9O+4z69H5KgHYGn8wFdzl4kQBoACYaaR6sXW6p?=
 =?us-ascii?Q?wHKBGHDO0qkbEvU0QBW571+lo4h9mGQUfoJi5EWOivTKMd5AoffcKC7Ci9zv?=
 =?us-ascii?Q?PwmKF8x9iv5McEOEAoB4z7uAE3qxIVxaMlxhB4J7AENBPZ3ZMn3jlQuIP/M/?=
 =?us-ascii?Q?FY/f6wsepHabT9dFf1KQsYLmnWOnoTl5XwEyDEK5rDzNG+TuVaKH6UDaE4mx?=
 =?us-ascii?Q?sX9nQ05XzZuiWksvElIEBVcaosDdkZ+fFJwDRw5A4YDzJ+xS7TT7F4+eDL/a?=
 =?us-ascii?Q?dRERxBLGswKUob0Tkb8dXq2vyM5phSir7v76rnC+wj/dJR6OedWh9ZoqnDGM?=
 =?us-ascii?Q?B+o6L2d8QS8qOQsLD8J1pZu45OSZV8W0eeD/uic4hjNTt1NO1ZlA+j9lzOML?=
 =?us-ascii?Q?iRmyUJ/gr1syO+utLM1CoAvlwYAmBCBdoVx3KQCXR315KQL1akL7nkSVPxT/?=
 =?us-ascii?Q?YymRobFU3nFRmYvAE6m+dU549MBMaKi+i2l8TGpMgGTwBMgtvPIr5uzZwIYk?=
 =?us-ascii?Q?LTfUIDadooxo9FA4/x0zQZRbWKKhv4IR5rQQ/Ej8xxUB110CzrmBsTA06PlB?=
 =?us-ascii?Q?D9B46n2qmL6sBmvjlIVjjKQc805ZiK3E7aRxatNRq3F/JQ/O6i7okHvJOzPa?=
 =?us-ascii?Q?unTuDxI/AZ2IJVfFkqn6Dt5jogqPnNIpF6n5J5p/+W0pdtHyO+XQNY9EH23t?=
 =?us-ascii?Q?DkW8h+3w2PrVv2hKBbglwNgxcRvOaz7+umNvSw53SLlLht+blK+RX2SHzCPV?=
 =?us-ascii?Q?mQUL1YD6zJkiLf7f7w57ApyuKXElGsAZaP7DfJLzg9QmyVr9DEMmZTqYMO0I?=
 =?us-ascii?Q?ktBA75HDQgRAsRSag6MmeoRrufT9QWrs3PaMGoDeIS3oielENUQZnQVK67em?=
 =?us-ascii?Q?b/Hg44afyuuHK6DiNc2eoM1Rku6ccfQDWvm5bX5d21oOTEdDKoEb5kWd30TX?=
 =?us-ascii?Q?woBC9l1hOkqEmeDb6sQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:01:44.0587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8609d247-8bc9-4f84-1ca1-08de534b8a49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751
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

From: "Alex Deucher" <alexander.deucher@amd.com>

Resetting VCN resets the entire tile, including jpeg.
When we reset VCN, we also need to handle the jpeg queues.
Add a helper to handle recovering the jpeg queues when
VCN is reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 41 ++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index ab0bf880d3d8..edecbfe66c79 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -844,10 +844,19 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
+
+	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
+	mutex_lock(&vinst->engine_reset_mutex);
+
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	mutex_unlock(&vinst->engine_reset_mutex);
+	return r;
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 8bd457dea4cf..0dd841c2b0e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -609,6 +609,32 @@ static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 }
 
+static int vcn_v4_0_3_reset_jpeg_helper(struct amdgpu_device *adev,
+					int inst)
+{
+	struct amdgpu_ring *ring;
+	int i, r;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		ring = &adev->jpeg.inst[inst].ring_dec[i];
+		drm_sched_wqueue_stop(&ring->sched);
+		amdgpu_fence_driver_force_completion(ring);
+		if (ring->use_doorbell)
+			WREG32_SOC15_OFFSET(
+				VCN, GET_INST(VCN, inst),
+				regVCN_JPEG_DB_CTRL,
+				(ring->pipe ? (ring->pipe - 0x15) : 0),
+				ring->doorbell_index
+				<< VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+				VCN_JPEG_DB_CTRL__EN_MASK);
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
+		drm_sched_wqueue_start(&ring->sched);
+	}
+	return 0;
+}
+
 /**
  * vcn_v5_0_1_pause_dpg_mode - VCN pause with dpg mode
  *
@@ -1310,6 +1336,8 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 
+	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
+	mutex_lock(&vinst->engine_reset_mutex);
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
@@ -1317,13 +1345,22 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 
 	if (r) {
 		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
-		return r;
+		goto unlock;
 	}
 
 	vcn_v5_0_1_hw_init_inst(adev, ring->me);
 	vcn_v5_0_1_start_dpg_mode(vinst, vinst->indirect_sram);
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	if (r)
+		goto unlock;
+
+	r = vcn_v4_0_3_reset_jpeg_helper(adev, ring->me);
+
+unlock:
+	mutex_unlock(&vinst->engine_reset_mutex);
+
+	return r;
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
-- 
2.49.0


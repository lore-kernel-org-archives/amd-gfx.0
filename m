Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDD7C83F22
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6D410EADD;
	Fri, 11 Jul 2025 22:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FSedlWcd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1737510EADD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPXII1O3MgwI00qEfbpbKoqGkYuc1BFpsQP6PaEHsGlO3nyGyoOhwm1NoLiOl/p6TYrdckTOGADpz+Y2nvMkePof86E4KUDo6odxsv1vxQLuCMrN2FMkaHsnF5ED51nLm6p3QT21csksijAEiqUm9RHxqqWSYSvYHgsgMVR/wUWuFFIMPnYq19Xl6YNhBGRJcZNs6tidmFwztGE/FnrTZktFXwHelAsqUQv0tHYmDe8Y6n6lmWE5pXwUC5fRuL2Acl71xwxN+Wzx5nzcAtCPs5fouNKXYctKQYnMxQtaSe0zqKa5hYOCLSNDveG5EfqK9WfJihfpcct8PMieLcfZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Mys9yEAYb/9N5Hh3CnzQOao1cyAX7HFlAOTcdk+IjE=;
 b=Sf/lJAnTdC6MDzCG0FKOG291U9GYYbvyIygtaugCEAFpzVGBsS3BVLDuKmNifslzLkrIRGWvx5UHrdbKFUkklILNarYzq80cPC9x0qJuS1Sr/7pI6jxCXjBrVAHanFhfS2uJvVsiT6lH6dfAXR2l+Qm+S++fezYiyiJHrvxq2gCau/7nNALGA2/Oa4otX9HO5WpLJ8kpxkxCYroOjIFgsr6W1kJKuBBzT3ksiGc1hPfYcP8eHn8BNDXgbNOeU1F+bRROvMYwZf/UYqtIDCm8RF9TDNq8efjAbGMPS29u29QIrLqhrrYr8qQALkRp4HfARSrrg/Y6/d+BBTrx+Qk6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Mys9yEAYb/9N5Hh3CnzQOao1cyAX7HFlAOTcdk+IjE=;
 b=FSedlWcdt3jsOOmTaYEAfPrfYpFEAdOSKCT/+60/1A2AsxgkSHxI4Kn9rWYZxnPjvoP38k+AYb+l2GpIgfRDJEv1hEWaIl6g9Ut032L0G+6Dc++sYHocWmN+fEksve8E6U158feA5rniNpVuDOxPwFLA7l4kQl6c1Rf5AQKm0Yk=
Received: from BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37) by
 IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 22:40:43 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::87) by BYAPR01CA0060.outlook.office365.com
 (2603:10b6:a03:94::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/33] drm/amdgpu: clean up jpeg reset functions
Date: Fri, 11 Jul 2025 18:39:57 -0400
Message-ID: <20250711224024.410506-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 9747130f-90ea-4372-8323-08ddc0cbf858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DXGsRKpQLdGrS2frHddEVWT6iLnceGDPXNH5NNUzEH52ht2EDXoFomWoAB34?=
 =?us-ascii?Q?XsEMm0pG1NWs8jxxJ4QryhMx+3mD5zdDGqAAiRwhzgYqQLpzK3xXGzxW8WUA?=
 =?us-ascii?Q?uW1ZIX8uy1iHbCwEazgbY8V/7b44wHnBXfaqsrfgzdgIHpA0cYOPwuwf61eq?=
 =?us-ascii?Q?kHkTD8ytqYJjx17Lxx177SsGLMTK19fJQ3mlbMek2687O8b/uexSy7L9UpW+?=
 =?us-ascii?Q?CQryebny0YmabieoyN5ehRjKsOwehV7rXi6zYHPBvIztjPOYN38FPdmbnbaG?=
 =?us-ascii?Q?9ZqR9bZ419SI9bC+s/pKj2aD78GQPuijjLCosgBM4S//S5ZkNjj2s6DPkkvR?=
 =?us-ascii?Q?ukzwQ1wUngAalosJIHOhrqXe9ICozwmz+40Lhi7gW9aJf04Da3Mi2C1pGuqT?=
 =?us-ascii?Q?O3WxxX352D9iun4YBng3QIF/cMRHI/6/SAv2EhDp3shi5AnLlXTb8gzj+X9N?=
 =?us-ascii?Q?eWqcijzXctm4OMxTZ9z372dCFqojpk4i+6mmCr7HKEIuLZHTRFoYFp8nB40h?=
 =?us-ascii?Q?FrS3H+F5v4qcPUkZZkc59xhRfYbRyftfxF/FiaWz+xGpw526jGSrrMX0Gq1E?=
 =?us-ascii?Q?f1n4UB7PdwYl/qw1yfAsLEQ863SDvuWocCe0q4cvJbUGshGuwNaG5E/chDUt?=
 =?us-ascii?Q?6OD9qaz2yOiAoqlxoXqCN/zsz7jfcDI3FQjA5opC36gncxWsqb8JA2luIwdp?=
 =?us-ascii?Q?X+4dw3fbt7d9pe1nGQTXXDWOjAsri2YnTZ4iLp5Y0LmQzpMnMkTfPsfhOSfW?=
 =?us-ascii?Q?YxxOasjVQGEZ8wJQlQzE/h6POWadHH0WJZlu6DxT5zp2Sfu4xgGtj89grKw9?=
 =?us-ascii?Q?xJU1ztkoO6v5pkHzNdKkXdvU88VimaNZ3vxm0YJZjKxNN5znw7iWDid4wEbT?=
 =?us-ascii?Q?jcPF5TY/mCcRBwv1EJrzoZnR1Yc8uBaucwWmRDGv2YkynFZizPN+UfkdCxvt?=
 =?us-ascii?Q?+typDncpMU7F26wFyN3KvjTccWDzPJGtYhJGb8IGQsSu36Pe9nhg2gC3Poo2?=
 =?us-ascii?Q?xdDu6oQsf34Shd+dyq2oi/W54K2EL6xTOea481cElpBOhgVQkfbRRtFyzza3?=
 =?us-ascii?Q?g7j12xrpM3lj+JXXBLZInDeob5L3wss0HqDkN7NWQ2JRd+sz3ZC2f3E0Aur0?=
 =?us-ascii?Q?uVPC+dyi8w9aXxLKXm8gy2yCSDUaQhymRm/ZEG1+8nMreIVmkxDiKCZvtL1z?=
 =?us-ascii?Q?GVP7sw19VAUp5CjqV2Ffvc8slpGZD9MM6+zeLk7qxIVLFFcI/SN002y3lo+s?=
 =?us-ascii?Q?wxEThUC+eR9ukHk7udkpdvgOj40IMJFkn1EIkmGtJT+z2HNLmJ+YDD0W2ko7?=
 =?us-ascii?Q?mIB0oEvTguUTvd/zFCLvoGKn3mqr3qb5VaRjhGDbBC8Jg/RSbxUdS4Jl4Iy0?=
 =?us-ascii?Q?rvWagtsAdXZmLugVmjCgxt4Njb2nZ1vUpudyMV+SdAj0wWhPR1dMI6ToyGFl?=
 =?us-ascii?Q?sdYAIKjQOoyjbTbE/ni3wJZvFcLzNP9pMAlUXQAnLCbM5KCukZLQzqNry0us?=
 =?us-ascii?Q?2E9O8KWXwBEW1VWFk22JkU8uB8OR7Db1JHw6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:43.3040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9747130f-90ea-4372-8323-08ddc0cbf858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
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

Make them consistent and use the reset flags.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 7 ++++---
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 5ba1c5ad9a5e1..0b56cb67e8f1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -118,7 +118,8 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+	if (!amdgpu_sriov_vf(adev))
+		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
 	return r;
@@ -770,6 +771,9 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
 	drm_sched_wqueue_stop(&ring->sched);
 	r = jpeg_v2_0_stop(ring->adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5be9cdcae32c1..3d0e61f9f2854 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -167,7 +167,8 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+	if (!amdgpu_sriov_vf(adev))
+		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
 	return r;
@@ -649,6 +650,9 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
 	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 5428930eafa3e..5d54c882d889c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -132,7 +132,8 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+	if (!amdgpu_sriov_vf(adev))
+		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
 	return r;
@@ -561,6 +562,9 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
 	drm_sched_wqueue_stop(&ring->sched);
 	r = jpeg_v3_0_stop(ring->adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 78fe1924f3cb7..5485e983a089f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -143,7 +143,8 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+	if (!amdgpu_sriov_vf(adev))
+		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
 	return r;
@@ -726,8 +727,8 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	if (amdgpu_sriov_vf(ring->adev))
-		return -EINVAL;
+	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
 	drm_sched_wqueue_stop(&ring->sched);
 	r = jpeg_v4_0_stop(ring->adev);
-- 
2.50.0


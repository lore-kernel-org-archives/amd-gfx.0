Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39C5C25B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 05:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE05D10E8AD;
	Tue, 28 May 2024 05:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MWUfpuQ8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362F610EB5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 05:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMA0drEdnh+c7IhSUMwbZv2Uo98bZbsLGIO0pmTz/tT8qF++FXez0JqU0VH6Px0bvsgcJPo46zcyVeZWIsCPOkdh3x3xZZChQ9Tf6YHA5K6AYWAo1AnpMi4K/1qpJMIFU5SfozCeMl7Gr3y4CZf+ox+M5bfSxkAOXp/VKg2CVHm62OgmpBh9YOCIDO/zUyLneliGEEYbA4VXelpN0yZ6SS9Nx+z3KbEatu9IYy1KkBATT+MlXtB9XstDgASBkcXn4xk6fyt0+lDZMZviDwSrZFtczSC8vuUh+ROU1kP1huny7lnGDwMvqz/ILglxBLQ9lc3KEd/JtEvOtrbJ1Be3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7oL68s1giYuYcG9hFIELscZn/Afza6enKQ2HbcmNsM=;
 b=IfYikTA0jw61DDT88Gu2wKuOlamRkqMDE66CH7HHOzFnQunh4s2Orhl2EKTf1urt5CfK8dkOAttvegAGnlyWyxRAZyRYeAJbW0aHQJH88vRAcEVQQpocQrNZ+plvicRd2yt8ct4YcA2Fc5WrLgcFmtto709v36yaTdJGIGD3w8tsjEqN2H0f/Wzb4d6kyFglEDM7KHaNSLktOaH5vauU+lkNRq9n+Dhdgwopq/TGY3Ptm/mjqygSFJYVHC1p6Zj1ll70osPqzFxvAPCYc9OOgQ0pizdcaKm3XvbnRRmbg3wXk0RnDFCwD7SFZG3FpHmC3P4X1zbaFqCaL/RKg4RIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7oL68s1giYuYcG9hFIELscZn/Afza6enKQ2HbcmNsM=;
 b=MWUfpuQ8UUbxPbgMJWhMpsHphv+N9b3SdEIyzwTakWPth4w8F+rcyuPd6dsPa2HAmje6ecK4znaZ8jIXTmGpWYVTFmHJsxTW35IATdoHi0/JPO5uINVJhc1D2Ba/dOQ1iLKVeidEUAu9YzfKqJ2zK1LW++XccmEpe4dJpBjP23U=
Received: from BN9PR03CA0928.namprd03.prod.outlook.com (2603:10b6:408:107::33)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 05:57:40 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::33) by BN9PR03CA0928.outlook.office365.com
 (2603:10b6:408:107::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 05:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 05:57:39 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 00:57:37 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Estimate RAS reservation when report capacity v2
Date: Tue, 28 May 2024 13:57:21 +0800
Message-ID: <20240528055721.27848-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c156cf4-7be5-4fb8-4e7d-08dc7edb1511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZK2lbSKzoc+ww7OMvUHRdloOJxPtgRE3XQ1ld94J6WIl3sBUFh07hs693ItU?=
 =?us-ascii?Q?ZLl6LTLBjfv/SwfRRCneSTjvWIGvQ8Qc5RAgyhbAFGMJCHsqRbO7VRMbu4ac?=
 =?us-ascii?Q?Mlvf4TSPwo2Z+XpeKfswGh9KJ7zE6LJvbylI+Dx684e+lGKLvP0CgVNxHMmv?=
 =?us-ascii?Q?fhWEZz0UURecOJ6h/AmwPgBH74WFitmXqxni7OQwvyvi0FKFqyJs3B6Vx9wO?=
 =?us-ascii?Q?NNhu5tCUvoxZz5fVIf4X79ch92hotzsg+IgwZcVG7L5Lwt8Gy8gDUK2gEKWo?=
 =?us-ascii?Q?I32WGkXhUt35T6q+c1B+7iHDZl9c9sAzC6RlBaLLgMJljIGrLWLgI1iNZdbE?=
 =?us-ascii?Q?tkE0KsTa8DYkZARXhv1z82QuX3wKhFI1dm/pbyqLcLjomjkhP0amF8Z55RDg?=
 =?us-ascii?Q?Se0YegI5d+tBQdMsX1vQy8TiMhfrsc2z3BAc2AZwSq8hEkGPEzMaq5/xh4Tq?=
 =?us-ascii?Q?9f9ffit1wcMD820moGNNXYW5pMTVU9+JqV4ueuSyldX9b55W2dwfyjxzGRcV?=
 =?us-ascii?Q?7EeSn39dH01EK9vYHY9ox8Ax6h+PcesNspwirEbsM4qpnW41Ep4GHwvZxU4I?=
 =?us-ascii?Q?f1RnP8q0vbQSYlrF0+0zt7anTO6pqs1sgy+QhxctqB/ZRoxhykMVBtvADdYj?=
 =?us-ascii?Q?U989bWHXK04CiaKgN0xSsESCf4YxLLWmZIEwRSFuAA8iMUIdDBN9MzIMe/Gb?=
 =?us-ascii?Q?wU9FH8j2cfOnJdqApNo3gVRNo78caZFSgGfTBPxQ1ohxsQO9LPbzK2bsUaSp?=
 =?us-ascii?Q?9NfJNg5QssS7TNEWLVDetSNPEhO3jSOQAjyKcTT7yuCM0GPIBaPKeTJB7byA?=
 =?us-ascii?Q?kO776zngVMA6nK1Zl4xgJmJLNRD0EnTN2G6VfyNWyrWNAc2pvOwIT03kqtEy?=
 =?us-ascii?Q?tFQKheILUmI1VZkeKCjKdmboseaCkJT1jieqWbK9+29plpP2BrardvIEINt7?=
 =?us-ascii?Q?sIZT8uUev+4VcaZbEpt5Ndp7VOSfCPtCl/BOMVLHO78nzttfxxhaBMdHxk8b?=
 =?us-ascii?Q?Y7XYNmiPjn+jlHpvCd6eWP1OTPWtjoGXej3Xc0xd5zTuN785lsQZU7AlFMQt?=
 =?us-ascii?Q?J5AWo1OApLxMIijH9DUWlbo2DdcrfqkeMG6vhxLHgucAj0XeVaKprEUiDzXs?=
 =?us-ascii?Q?4iDIfn7S5/DdfFWLCdvUZ9otTnQacDgIEw/66RCRtKfmuD92wVO6H4aqB/6c?=
 =?us-ascii?Q?xWyyUTFI1Np6dtITC/Y9JlRdSGuhllkeq9HdLuuz+qsnKuQ3BZbM2tuQdxcE?=
 =?us-ascii?Q?Ww8qkzN4Z4mS5nI/gKs41eiC345VaLoNkJzo1EWuPcJNcQyMgMRgSxYjFyjR?=
 =?us-ascii?Q?BZK6oXx4acMvC+lSzBiSPg5Jb8ydDwRZTgjfAzgGiMJCtuoxXYRMMIDDtADu?=
 =?us-ascii?Q?n+XZTK9Cxdu61FkM0kwjWukI3X5I?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 05:57:39.5692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c156cf4-7be5-4fb8-4e7d-08dc7edb1511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
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

Add estimate of how much vram we need to reserve for RAS
when caculating the total available vram.

v2: apply the change to MP0 v13_0_2 and v13_0_14

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  4 ++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e98927529f61..ad813772f8a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -173,6 +173,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	uint64_t reserved_for_ras = (con ? con->reserved_pages_in_bytes : 0);
 	size_t system_mem_needed, ttm_mem_needed, vram_needed;
 	int ret = 0;
 	uint64_t vram_size = 0;
@@ -221,7 +223,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
 	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
-	     vram_size - reserved_for_pt - atomic64_read(&adev->vram_pin_size) +
+	     vram_size - reserved_for_pt - reserved_for_ras - atomic64_read(&adev->vram_pin_size) +
 	     atomic64_read(&adev->kfd.vram_pinned))) {
 		ret = -ENOMEM;
 		goto release;
@@ -1694,6 +1696,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	uint64_t reserved_for_ras = (con ? con->reserved_pages_in_bytes : 0);
 	ssize_t available;
 	uint64_t vram_available, system_mem_available, ttm_mem_available;
 
@@ -1702,7 +1706,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		- adev->kfd.vram_used_aligned[xcp_id]
 		- atomic64_read(&adev->vram_pin_size)
 		+ atomic64_read(&adev->kfd.vram_pinned)
-		- reserved_for_pt;
+		- reserved_for_pt
+		- reserved_for_ras;
 
 	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 		system_mem_available = no_system_mem_limit ?
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ecce022c657b..f28bf5765380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3317,6 +3317,24 @@ static void amdgpu_ras_event_mgr_init(struct amdgpu_device *adev)
 		amdgpu_put_xgmi_hive(hive);
 }
 
+static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!con || (adev->flags & AMD_IS_APU))
+		return;
+
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(13, 0, 2):
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
+		con->reserved_pages_in_bytes = AMDGPU_RAS_RESERVED_VRAM_SIZE;
+		break;
+	default:
+		break;
+	}
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -3422,6 +3440,8 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	/* Get RAS schema for particular SOC */
 	con->schema = amdgpu_get_ras_schema(adev);
 
+	amdgpu_ras_init_reserved_vram_size(adev);
+
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
 		goto release_con;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6a8c7b1609df..bd61f77a7134 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -64,6 +64,9 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_FEATURES_SOCKETID_SHIFT 29
 #define AMDGPU_RAS_FEATURES_SOCKETID_MASK 0xe0000000
 
+/* Reserve 8 physical dram row for possible retirement.
+ * In worst cases, it will lose 8 * 2MB memory in vram domain */
+#define AMDGPU_RAS_RESERVED_VRAM_SIZE	(16ULL << 20)
 /* The high three bits indicates socketid */
 #define AMDGPU_RAS_GET_FEATURES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
 
@@ -541,6 +544,7 @@ struct amdgpu_ras {
 	struct ras_event_manager __event_mgr;
 	struct ras_event_manager *event_mgr;
 
+	uint64_t reserved_pages_in_bytes;
 };
 
 struct ras_fs_data {
-- 
2.17.1


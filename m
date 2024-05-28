Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38131C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 02:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65EC910F73D;
	Tue, 28 May 2024 02:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gFiSb6nb";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5020C10F309
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 02:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkYwtGLJWMtNCxZOVbIde2mlQU9MsGZTYzo7YaQuwtDeM/KWs1bs6xsEIDnR6+EYCbCnCTRna4Jc4GscJGeoH1JlizrQJWRw7SVC0ZZp+ELwcHd7bfdS+Di6lBM86dAk4Wjyp6SUzOpQIA0QZ+LoFHdCHUy9z3x1KS4SV60QaGjt3YWqpugQSQGi846BiY/qXGG0juezq9UKbWvF5CWUZM9KHdBYs6BSDsvO8XRl97tp+ahGEvZSr7oruu3a2dWSgwKNKwNMa4aNrlpdtBCKPqyyCWYDO6HDK4qc5HI0SecQe5rGHtsnKBpotJIJ69mewtRoAc9xO5x9iI6G5KaXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNn3+/EW+CH2UehEb1fLM/RKG6ZIncBrB6WTjMH/h3w=;
 b=i7Xsl/oOAymYJ1DSnlwDAR5QNAoG6qTjOW2EUfeZIjW2DkGb3qr26cY2d35uwNYk6S9tPymhGSTA7X38+Uhnx0oWY5xKjfEMw2/i1L/EROWrYg6kelwte8b59gLRkdgKsta60tKWYlE8mTl97g+jzZfJmmsOtXUZ7g3xHYIEbIx1Sr0sUpuyal3mQ5XwiCZhLjdmKUVz//py6d5ojxjgvG8mKQhpEDE2VaNpkSOnLQg/Bw6SaJGtJsiWI65wBMIrRuxsAdrmXn3B5EfyjzoneStTjJcx99Pbf0vzZ8D8ecqA+kws+MxI1ky5QGzt5qbfIa37I1deA4FpCqg9z6NxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNn3+/EW+CH2UehEb1fLM/RKG6ZIncBrB6WTjMH/h3w=;
 b=gFiSb6nbvrcmW9uDBX1M/HtHTB+XcnbqepHUIX/6HPf+8O9bFZ06Hmj0ZjP/AtPMDXEcH0CpnKzScUpAtNk4Qf1yAS22q/r+dgpiNPNXEIaxtFzPt7Qcn9d8kwe/YYosGrzNZtRnWBl4E/atUta2vMVZKh32XGOtxzR9EVW1Ghs=
Received: from CH2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:610:38::35)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 02:22:07 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::f8) by CH2PR05CA0058.outlook.office365.com
 (2603:10b6:610:38::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16 via Frontend
 Transport; Tue, 28 May 2024 02:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 02:22:06 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 May 2024 21:22:02 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Estimate RAS reservation when report capacity
Date: Tue, 28 May 2024 10:20:51 +0800
Message-ID: <20240528022051.27099-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: b15cd7ee-ebd9-4794-fa5e-08dc7ebcf87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DmvJkh1gkudWj3jpB3m1VU2shWiswGTtrDa0/WFyGqzyGKs6nBoXzjEnCz7M?=
 =?us-ascii?Q?LF12GWyZ6UwAr6/CGSiSR1ltFO17++1Jeed0jOwtmyJA7LxkQSYNgiy8kUd9?=
 =?us-ascii?Q?SILBDV1vdj21QyMI6F7+09yTlsb94/+eND3Kn5VG8rgLMu8/QQwyjU5U3QpA?=
 =?us-ascii?Q?VxD0LDGcsNeQbRSoGx3u5p0/hE0O6oCPYKYHYCtHn/zuxNPWRRd7VCE5VYpn?=
 =?us-ascii?Q?uXKHwv1BDjumqFzgoJYUR6k0wlaqDxTg1mq23KykmJmebOwuExIryp0xxjA7?=
 =?us-ascii?Q?k4DGK+duUdFZoxA3dxSsPTeUyjZw2Ep62lboGoLuytjiYU0avWn16OXGIk3k?=
 =?us-ascii?Q?18B8ao6ercNNumdT45bm2ntGpmIp+F8VERsagki1uCzAbJz5Vbz1EvnZQV1X?=
 =?us-ascii?Q?ci7A5NRSED22k7WO0gbZZczOl+Cbv0N4oGTAVAKv7kdAjNtigs3sWHCGMGXE?=
 =?us-ascii?Q?dU1S89GraDxRwxfZrM6aguwAXzRyzF68JMvzO+DTAbiCHs4Vd6TaigIykkfZ?=
 =?us-ascii?Q?Xy5aBfwKelRTP5BR6zHCxUvgevwiSXLswZdDhxZT0h3A/wKBFkJf8+PBfzER?=
 =?us-ascii?Q?fIA3gqUc9rAsAE83ysyvNcfHpldQVtVY/E18mHuJ9k8fmRkCmC87kqlH6O+c?=
 =?us-ascii?Q?nyqFLL8K6LcdoSuWXFp8cvXeowI+deB+iQDO6jvmDEqGD1Ros0GCYtPzBNJN?=
 =?us-ascii?Q?1Eo64DaNigaFoiouctF6DbsUmg5Fw94KzLoPmfAIe6SJ9kD9jQgO82/4ajXo?=
 =?us-ascii?Q?HFaarklu/mJfePE8vfCB9mBGNLIKNqSdkZyIB40JhdDJNA8nS+f9NRA5+6H8?=
 =?us-ascii?Q?VJK50qkMIPgnmUZldv5EVamm4vPuff5oe8Ug6YM7gz1ys67ch6/wiFqNpIfX?=
 =?us-ascii?Q?MTsL3NOx7+dD3nkaZh10XfOztiqbigTVpw1EXDI+NcY67dUcxf13cANFJ6hJ?=
 =?us-ascii?Q?5jMM3sWKu8Xu5gLsn9NTujM2rvmJE+v1bjEcWttg7gGu+lJI+XCJi7jP+9Pq?=
 =?us-ascii?Q?NlcCkMn77k9BWuOJLd4MQQ/IkfxF72rLSCeFBW2toW4ZpujvkZbJjGh+DfE0?=
 =?us-ascii?Q?8rQCG/KeWUzH/o8/O9+lk1yNwWbZuLI6ZlupkaBafvHbt1MJAgwfepCaA90m?=
 =?us-ascii?Q?ns1kchcjK4a/KgX8GaWKIAvDQCfto5BUJG7IU4eIo8IqGoFeMwhlPsmFn8CD?=
 =?us-ascii?Q?Q/C3eHERCXaBsgmL7OHVDoTk20aDuuJKHr4iMfTfGZUxbZzHdcfBQP5zoD9r?=
 =?us-ascii?Q?yzaXZyADwB4t4lJKICHmSFSjtBTCFLdy4XfXJr5cpW1imYhVRRWEm4C08u8Y?=
 =?us-ascii?Q?p6WJK82t0aKqoINtKptSdMrkJ/H4X6RvgGPqs4H1v6TJ2KeYgDvaGRtoeP5k?=
 =?us-ascii?Q?R5/T812PH7bYNW24cPUC/e1scozU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 02:22:06.6903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15cd7ee-ebd9-4794-fa5e-08dc7ebcf87a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
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

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h        |  2 ++
 3 files changed, 27 insertions(+), 2 deletions(-)

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
index ecce022c657b..a6334e0e62dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3317,6 +3317,22 @@ static void amdgpu_ras_event_mgr_init(struct amdgpu_device *adev)
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
+	case IP_VERSION(13, 0, 6):
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
@@ -3422,6 +3438,8 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	/* Get RAS schema for particular SOC */
 	con->schema = amdgpu_get_ras_schema(adev);
 
+	amdgpu_ras_init_reserved_vram_size(adev);
+
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
 		goto release_con;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6a8c7b1609df..bee622c4268a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -64,6 +64,7 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_FEATURES_SOCKETID_SHIFT 29
 #define AMDGPU_RAS_FEATURES_SOCKETID_MASK 0xe0000000
 
+#define AMDGPU_RAS_RESERVED_VRAM_SIZE	(16ULL << 20)
 /* The high three bits indicates socketid */
 #define AMDGPU_RAS_GET_FEATURES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
 
@@ -541,6 +542,7 @@ struct amdgpu_ras {
 	struct ras_event_manager __event_mgr;
 	struct ras_event_manager *event_mgr;
 
+	uint64_t reserved_pages_in_bytes;
 };
 
 struct ras_fs_data {
-- 
2.17.1


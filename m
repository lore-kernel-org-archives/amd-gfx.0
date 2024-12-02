Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2077AE69E97
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD25410E870;
	Mon,  2 Dec 2024 21:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dbr4Uvs0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 148BE10E86E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAHUBNtKPrPNS0qM33zvtgA74hQwRMhKayq7DzoCLOoXRTbwN0IN6QmEBTmefdknpVuZ9DvOpPoJI76tj93c2IrYeeSc/JV46z9Xmnj6FlcDCUG6jKkFwZcA1u4/Nx5fuwKzFbGC2Fz+kud+7528+cedLsdVdj7702GeR+n7ZvjZg+50EmVXFJ/ftFqlqCTWTDYl7VCFm5q4mzq2EBBAtePrZFnnLuaZvWC43/c7eFPJjmmmnygkDmwRuzima9uxLPjuixFJ9b7C8bJeiL202767M5pJNzO1bRcNQQCAhAbSjK4MKCVjXfmphuuaxmCYsyJqty0gMgMXWpqbmWozbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/XHXzg/Gbcjs3/JN9lXCrjZ/JkDErcmG1MfFAeOd7U=;
 b=Px6xjWWUTBuuFz1HIm0gLVySRpHFaJ341cKWKveqN3JLswV7OHDAWrhWfUk/LEi3RiRjpvnfXulpafWpURd2/6n8Z9eKQMaUS/gLMJ2y82M0t4zAhmolC8zm7P8OiGVHbecKR/4Pw26EjElPE42eC5zD+xKNLjUWod2qaBvjYCt70SM+gYBj9J240nPRC6tULeFzmTS4noVNQ6WP++1bYcoI3Rlu0Q/2KNSSK0Mm/InUwbukYH9ke2dxU4xdrC5mhy4ES3cX6KgGQ4iSnsXdPuQtve06yTTuEV98OAZrJOiT5KyisTT86QGAHn75d9UEdEsHBRiimxUfh3UtCCaqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/XHXzg/Gbcjs3/JN9lXCrjZ/JkDErcmG1MfFAeOd7U=;
 b=Dbr4Uvs0CN429QDQ1qFRBR6ewkVEICP1HFEEFhw78ikH8mo26lOtlPkoja9dF9Fl8AJF+CPvgGu57pVA6ssYCKCl6+Aey41EsF0/9E1d+dN7Mq5uas5FM9cZCcME9DovHbI+VE5zNcGzY4AivXwmduqnw8vocLY0kIQqxAvPT7s=
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 21:50:13 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::b6) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 21:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 03/11] drm/amdgpu: add initial support for gfx950
Date: Mon, 2 Dec 2024 16:49:44 -0500
Message-ID: <20241202214952.1125211-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202214952.1125211-1-alexander.deucher@amd.com>
References: <20241202214952.1125211-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d055128-49f8-4e56-5a86-08dd131b4d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o7Pj4s76AliER38DwFyFKqDmeS1uFbM5rJEh3ENDg85d6C2Hs/PptIb/Zorw?=
 =?us-ascii?Q?Z17Z8kvYO3XVt8A4wz28KpgUGeeDk02JGYEG51vLCEwMTl3Q+KviSGR0yag9?=
 =?us-ascii?Q?Edh3qqYCLUw8xYPQmlLXhtzceEyyuTiAanWjzidsScHTlFpRG7ngMRQiKR8+?=
 =?us-ascii?Q?MR2USpPh5Zin6FCMFw0s1zv0wLLBP/l+RVRI34TV4NRfzTS9Piik5dfA0mz4?=
 =?us-ascii?Q?EyriTeB8gdK/eXWm4QFOI8U4+9qIcWADpRtjmN9bMKoRcNRtKFjP+1yOYbUn?=
 =?us-ascii?Q?ksoK1ckmXUq7XUP9y3K79E+yeMIUch73m8n1OlOdhnfwWvhU9Xm/7BdfhF14?=
 =?us-ascii?Q?KsxKzFOIJfmdsmjEg6jn6EgD3J1X2PDXj7uWevwvVln0ETtWU+Q38ble3uwB?=
 =?us-ascii?Q?evkgAOcmAf4DrSF+f9DOrfj2cfueDdGr/Mo3cxxwG6tk7y97xV9/jgbKUCQs?=
 =?us-ascii?Q?6/lO5KrDn90178AC12Z2Ald2fk/i1GC4C94RcUJlxIT1ZqUSwdf9ZfqxF3m0?=
 =?us-ascii?Q?Mo2Oyr+CfW60ox0EfcgHZqvZiELNu+DeaEE9fljtDNipi/AMCKxVZ0Yo9LPc?=
 =?us-ascii?Q?wUCw9SlKRqaUhAflVcleQ61OsrB1GUbXUyYs8GLB2oFoGh1mw12IDeqZk0lB?=
 =?us-ascii?Q?C719x0I6ZI17oJ1CHBLKgJGvOFzEioC1wGHYgKgT6ERG8Q04UAodzsETYohG?=
 =?us-ascii?Q?FGqOwBHqNWvBRxSTHLL5zS0sVKoiS1XY8uU++3s4wfZud8hhrWy11JknYOzF?=
 =?us-ascii?Q?F7Ql3xnsfCvsFSudtiYiKPCszRXe4ghUNiEDRD9rY7gom36ntOHV0l7sxZhI?=
 =?us-ascii?Q?IoFDUFi0MywiLNHv6KR0G1zRV74lp6EqSLK0ax57EpE8rGWgs7aIMYjF+yIC?=
 =?us-ascii?Q?VYsTCgwRKtQdT3bM8Zc4Ilasa/5dKeozApO9EYNpg8Dn3IHHljT4sTXp6suE?=
 =?us-ascii?Q?jb0A+ILH8QCpstMrplY+MOecHXrXabMFCw9y1MDFz3nWCj4pMAQFnHGbxqHJ?=
 =?us-ascii?Q?Dp++PBGlf+2yajE8sWlK/4D02dAo9Sq0EUlZe52dNqw+iyVu77YY48dfHxdv?=
 =?us-ascii?Q?I95UUnTRxNWJDlVtdEw+kLqTSJUeZ1GC2ysmhXBFv1JosKma2gr2kM8IkdKd?=
 =?us-ascii?Q?ATRcemDUyF0ANCzadyWzS47h1zmHjlYhr5mx5hPhbtxT2xGbg5S/WfDQGVx3?=
 =?us-ascii?Q?sfVblSx5FON+P0kqRHGaRgZZxLEL0/+XHlhuQiyMieHular5LwyAUqV93VRt?=
 =?us-ascii?Q?7fcvOZBNg8gLCt8FY00/22FdpBdEgyEmeOREdBTzGnXr0kvuPfyiOMx81ifJ?=
 =?us-ascii?Q?xV8Y1MpvSb/rPdBILBxfhhzR3jSxPtKxO133q6BgUqGxHmDt88UppJEAbxkv?=
 =?us-ascii?Q?0mH+JSxV8dcl3TaeX+RQRjoIN16aQaoRPMhICgWSl6ycffmGzDTjlztsjwVE?=
 =?us-ascii?Q?DaAJ0cLFJoqAo93xOHp5/4rtFRTBR3J4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:13.4667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d055128-49f8-4e56-5a86-08dd131b4d1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
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

From: Le Ma <le.ma@amd.com>

add gfx950 basic support

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c      |  4 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 30 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  1 +
 7 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0d1a59138e7e6..745d173838f6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1400,6 +1400,7 @@ static int amdgpu_device_asic_init(struct amdgpu_device *adev)
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
 		amdgpu_psp_wait_for_bootloader(adev);
 		ret = amdgpu_atomfirmware_asic_init(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b8845c74ec009..2d0bcd85cb490 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1836,6 +1836,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 2):
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
@@ -1890,6 +1891,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 2):
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
@@ -2184,6 +2186,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		amdgpu_device_ip_block_add(adev, &gfx_v9_4_3_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
@@ -2405,6 +2408,7 @@ static void amdgpu_discovery_init_soc_config(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		aqua_vanjaram_init_soc_config(adev);
 		break;
 	default:
@@ -2652,6 +2656,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 2):
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		adev->family = AMDGPU_FAMILY_AI;
 		break;
 	case IP_VERSION(9, 1, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9f922ec50ea2d..9ff6cfacfd34c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1762,7 +1762,8 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 
 	if (!adev->bios &&
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)))
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)))
 		reserve_size = max(reserve_size, (uint32_t)280 << 20);
 	else if (!reserve_size)
 		reserve_size = DISCOVERY_TMR_OFFSET;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 15689ca219757..b755de502da5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -931,6 +931,7 @@ static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -4860,6 +4861,7 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		/* 9.4.3 removed all the GDS internal memory,
 		 * only support GWS opcode in kernel, like barrier
 		 * semaphore.etc */
@@ -4873,6 +4875,7 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		/* deprecated for 9.4.3, no usage at all */
 		adev->gds.gds_compute_max_wave_id = 0;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index ed8e130c7d195..5470cef7e9bd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -368,7 +368,9 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					amdgpu_ip_version(adev, GC_HWIP, 0) ==
 						IP_VERSION(9, 4, 3) ||
 					amdgpu_ip_version(adev, GC_HWIP, 0) ==
-						IP_VERSION(9, 4, 4));
+						IP_VERSION(9, 4, 4) ||
+					amdgpu_ip_version(adev, GC_HWIP, 0) ==
+						IP_VERSION(9, 5, 0));
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL,
 					    i * hub->ctx_distance, tmp);
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1475d03ebb057..1f95a5b15ea2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -645,7 +645,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		soc15_ih_clientid_name[entry->client_id]);
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
 		dev_err(adev->dev, "  cookie node_id %d fault from die %s%d%s\n",
 			node_id, node_id % 4 == 3 ? "RSV" : "AID", node_id / 4,
 			node_id % 4 == 1 ? ".XCD0" : node_id % 4 == 2 ? ".XCD1" : "");
@@ -795,7 +796,8 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 {
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
 		return false;
 
 	return ((vmhub == AMDGPU_MMHUB0(0) ||
@@ -1182,6 +1184,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		break;
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		/* Only local VRAM BOs or system memory on non-NUMA APUs
 		 * can be assumed to be local in their entirety. Choose
 		 * MTYPE_NC as safe fallback for all system memory BOs on
@@ -1273,7 +1276,8 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	 * memory can use more efficient MTYPEs.
 	 */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3) &&
-	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4))
+	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 5, 0))
 		return;
 
 	/* Only direct-mapped memory allows us to determine the NUMA node from
@@ -1549,7 +1553,8 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
 		adev->gfxhub.funcs = &gfxhub_v1_2_funcs;
 	else
 		adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
@@ -1790,6 +1795,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 		case IP_VERSION(9, 4, 2):
 		case IP_VERSION(9, 4, 3):
 		case IP_VERSION(9, 4, 4):
+		case IP_VERSION(9, 5, 0):
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
@@ -2068,7 +2074,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) {
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) {
 		gmc_v9_4_3_init_vram_info(adev);
 	} else if (!adev->bios) {
 		if (adev->flags & AMD_IS_APU) {
@@ -2152,6 +2159,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
 				  NUM_XCC(adev->gfx.xcc_mask));
 
@@ -2218,7 +2226,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_gmc_get_vbios_allocations(adev);
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) {
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) {
 		r = gmc_v9_0_init_mem_ranges(adev);
 		if (r)
 			return r;
@@ -2248,7 +2257,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) ?
+		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) ?
 			3 :
 			8;
 
@@ -2261,7 +2271,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
 		amdgpu_gmc_sysfs_init(adev);
 
 	return 0;
@@ -2272,7 +2283,8 @@ static int gmc_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
 		amdgpu_gmc_sysfs_fini(adev);
 
 	amdgpu_gmc_ras_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 5721ccda79058..8fad6b02c8df9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1177,6 +1177,7 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 		break;
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		adev->asic_funcs = &aqua_vanjaram_asic_funcs;
 		adev->cg_flags =
 			AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_CGCG |
-- 
2.47.0


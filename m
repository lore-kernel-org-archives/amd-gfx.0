Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DEFC282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 17:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E80D10E4BB;
	Mon, 10 Mar 2025 17:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pbE2jqN4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D97D10E4BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 17:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4M8TDUOQP9zn5EIpLQ+h6TnD27ydohcQL5h9B7atnjpzUWU20ImaoSD18LfpLRU//4frz2CdEpKx1mWslaWAbezSXPtE9MP+pov1usgmNClzB/1ypwIoJa3FZEkl7/B0ozGflGu69BfY/4A+LDIj1maJJwWNPmfCN54gtK9eKT9vsqsbGov17DYIyqaTC7RZod8+9wwnhA197v84jZOn2rnlIYuomc9dlzmVC7xeKBo99vYhImkV9MGJHtmZnsk+MWUECsAiBUtqe7iVg5qt5U01XXSQsWR659JjIJotvfjC2eZCGljgI9FQG0SbQkiLpQymmlqduAMg/Qgx7UGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHvHOijXqFK/GT/z5UCFSprESwdM4nHC1JJtsds7IDY=;
 b=EfwXAWW+AAFIvmz9QS/Xg5dK75gMBnl683W64YHnCg75bMaD8GmqOtBNwdDWTyGWQqVDMGKuUPr4fyWYSS4GhjYS+vsd1IrHeX6Jme3UoPv4oKcLUbaRBKP+Gq+5aaLBr2camkNOf5EdACGgMp2aIiS9/KyLFBTgs7QagM1TpO2yGoG5SSsuc4UAoTvDXuX0VReAYFYS/1JByodSK9B4Vygi2tl8myN2rIfSMLCrUHBV3F9sbGO8Cq1RQFvLOH/rI6BZNzD1jba6EDDXIFCe/dYZ5AnzpjrQJvbfc3OozR8jyha2mauntdqH6kIB9BFq9wrXsDnTm9E0y2SbRyZyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHvHOijXqFK/GT/z5UCFSprESwdM4nHC1JJtsds7IDY=;
 b=pbE2jqN4bvyERMBn2soUL6TqeM9fN6VZgf9lPZFXZurT6XxsqmC7RGmqt7WGDL/1aqSYBH0G/al+9ty55KwJeVOBm2OGzazzfQzSry36pka40LqiJLZWDKl4waAe8ExHsM5OAxXdf/kwD9tDCSdpJQA7OQz5OfxvBU8bInI8108=
Received: from DS7PR03CA0055.namprd03.prod.outlook.com (2603:10b6:5:3b5::30)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 17:00:56 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::c4) by DS7PR03CA0055.outlook.office365.com
 (2603:10b6:5:3b5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Mon,
 10 Mar 2025 17:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 17:00:56 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 12:00:55 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix MES init sequence
Date: Mon, 10 Mar 2025 13:00:37 -0400
Message-ID: <20250310170037.62136-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5136a9de-458f-4258-3dee-08dd5ff51fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EsdBdKC6RdlH3COrCmxQjaxqL3dbb2URsuluafV84WvkoerdlA0svt9aXnTU?=
 =?us-ascii?Q?/dfGrcG3Qqb+zBt77fZRCiU/VEOx/cLPzQVTSuV4ylm4yWD945EVOC/xPuIJ?=
 =?us-ascii?Q?5hn4ZpBp5O16EpziHJ97tOehx7CPQXFA7BnknRjIHySl3K6677eJ9ZJnF7/y?=
 =?us-ascii?Q?vMIc11uRj5UPe94ficQScS7b9BOuOuKvAwbW2FiVzr4ZAgRJHvJ2/Jmz0S8i?=
 =?us-ascii?Q?aNzZ0TKFCdplEPBkoUlRIeahPX4hJoAPauT/8cKFIKMGA4ya7a+ceHqsHzDn?=
 =?us-ascii?Q?oZ+XmrD1ULikdd63wJ7jdy9E/q/vC/l4oDt7Ix7oGf04/XjcC5wdnHoSSw2S?=
 =?us-ascii?Q?9X0Kqnmm/LAEXBv90jUYmEpdN+abvtV39wN11qVMMz9/iWgeUQCpDgVWQ51D?=
 =?us-ascii?Q?DJ290iG7gEnRXcPwFA0aajtezxMNPYQigEGBgR4Q6ECQy97VG6Ijja5mueUx?=
 =?us-ascii?Q?ZF63p1MlZkY0VADYLYb66wdT/Edl1YoDiZLOySYTfpb94YDpzkAN8UbjIuiv?=
 =?us-ascii?Q?QeT49QdHFUlF5jMnHntmdvaDyReq6tH3u/jXuPrOXAA8mtEuqtLLingsrukr?=
 =?us-ascii?Q?kMtbdxv7hXO7xosqCmqHKSKEwZPEd+e+YeSKMeNkJWIIXBrV4mJok6as1GYF?=
 =?us-ascii?Q?fN2+Yw3TZ7EAnfQPOV6WTGCjwsBQLszXyqprLBA9QL3Kkuol4gfGyG6rRe5q?=
 =?us-ascii?Q?obAKWIqZfpdW4qsEqZO1YMrIq02nBJigl7iSoejWKHFFhKFyjcQXT2euaJp4?=
 =?us-ascii?Q?CVdJhWNqM+Mjz0wLNFmy4tb3s6t81YmQCAVmXDVEtUeE0567DL3ZqsYuq0xx?=
 =?us-ascii?Q?xBhS3u5Nyh7taNbu72b+3whBuAmnZYnQYAfTznfYeTTk2mOcCU7hcvAS/dsI?=
 =?us-ascii?Q?ySVvJKf8NSvY2GKN4hpwJwJ0YJTHKWNof/e4hsdNunesEoTeEBlpDV4mFpQk?=
 =?us-ascii?Q?4H7VpK015JSvEE0C7ZzDTMD8jTx+atpae7cdoUD2wciqKrBsTyNzbmDnNifu?=
 =?us-ascii?Q?Lf3I4tMlclE8l0hn0deEEkjepjVoTZ7B2vJp6jXDPAkrHpscrPz+9TA+6LK4?=
 =?us-ascii?Q?g5ALTCe267wGjx6h+RLVnRQLhn5wjKyOytuxY1vTNM2WEhLTTdp8QkPdJ9ke?=
 =?us-ascii?Q?AEaclYZBZe8lknF4+vQCMkBTRI64M8n1z6QMXcW0+Pz41pWXZCHd4Lxu0KGH?=
 =?us-ascii?Q?+ntzFmqLuiPC0aLTXub9iuJ9gTaU9jhJXPV/0ULY39+FQQOeDa4YtmZH9fbK?=
 =?us-ascii?Q?3A4c8jazMDpcQwy3u0fcjAdhu0lsGESdOXdtIZNv/jw1uRyqKxY6MnK96KpM?=
 =?us-ascii?Q?A95lMfCqJaEQTlMQx5muWBszRpEVq1YzYnBKM8TxE8erF04A+6+cHjQovUjF?=
 =?us-ascii?Q?QM81nTYt049lxCtRHpr9Pbn4ZW/DoCJYAwOAx9lVixnb+zicsDHcJ+T0z0w9?=
 =?us-ascii?Q?7x4HYlVINxcPFppm2FGQrFK1pEqXlOLiWYm3nC/lbjouI6MDvRMCcqJNaFdT?=
 =?us-ascii?Q?z4P0ylpm50Y/BXA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:00:56.1110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5136a9de-458f-4258-3dee-08dd5ff51fdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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

When MES is been used , the set_hw_resource_1 API is required to
initialize MES internal context correctly

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h  |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  6 +--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 52 +++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 40 ++++++++----------
 4 files changed, 48 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 4391b3383f0c..78362a838212 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -143,9 +143,9 @@ struct amdgpu_mes {
 	const struct amdgpu_mes_funcs   *funcs;
 
 	/* mes resource_1 bo*/
-	struct amdgpu_bo    *resource_1;
-	uint64_t            resource_1_gpu_addr;
-	void                *resource_1_addr;
+	struct amdgpu_bo    *resource_1[AMDGPU_MAX_MES_PIPES];
+	uint64_t            resource_1_gpu_addr[AMDGPU_MAX_MES_PIPES];
+	void                *resource_1_addr[AMDGPU_MAX_MES_PIPES];
 
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index ab7e73d0e7b1..980dfb8935b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -614,10 +614,10 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->decode_usage = 0;
 
 	vf2pf_info->dummy_page_addr = (uint64_t)adev->dummy_page_addr;
-	vf2pf_info->mes_info_addr = (uint64_t)adev->mes.resource_1_gpu_addr;
+	vf2pf_info->mes_info_addr = (uint64_t)adev->mes.resource_1_gpu_addr[0];
 
-	if (adev->mes.resource_1) {
-		vf2pf_info->mes_info_size = adev->mes.resource_1->tbo.base.size;
+	if (adev->mes.resource_1[0]) {
+		vf2pf_info->mes_info_size = adev->mes.resource_1[0]->tbo.base.size;
 	}
 	vf2pf_info->checksum =
 		amd_sriov_msg_checksum(
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a569d09a1a74..299f17868822 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -751,10 +751,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
-	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
+	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr[0];
 	mes_set_hw_res_pkt.mes_info_ctx_size = MES11_HW_RESOURCE_1_SIZE;
 	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =
-		mes->resource_1_gpu_addr + MES11_HW_RESOURCE_1_SIZE;
+		mes->resource_1_gpu_addr[0] + MES11_HW_RESOURCE_1_SIZE;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
@@ -1392,7 +1392,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int pipe, r;
+	int pipe, r, bo_size;
 
 	adev->mes.funcs = &mes_v11_0_funcs;
 	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
@@ -1427,19 +1427,21 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (amdgpu_sriov_is_mes_info_enable(adev) ||
-	    adev->gfx.enable_cleaner_shader) {
-		r = amdgpu_bo_create_kernel(adev,
-					    MES11_HW_RESOURCE_1_SIZE + AMDGPU_GPU_PAGE_SIZE,
-					    PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_VRAM,
-					    &adev->mes.resource_1,
-					    &adev->mes.resource_1_gpu_addr,
-					    &adev->mes.resource_1_addr);
-		if (r) {
-			dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", r);
-			return r;
-		}
+	bo_size = AMDGPU_GPU_PAGE_SIZE;
+	if (amdgpu_sriov_is_mes_info_enable(adev)
+		bo_size += MES11_HW_RESOURCE_1_SIZE;
+
+	/* Only needed for AMDGPU_MES_SCHED_PIPE on MES 11*/
+	r = amdgpu_bo_create_kernel(adev,
+				    bo_size,
+				    PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM,
+				    &adev->mes.resource_1[0],
+				    &adev->mes.resource_1_gpu_addr[0],
+				    &adev->mes.resource_1_addr[0]);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", r);
+		return r;
 	}
 
 	return 0;
@@ -1450,11 +1452,8 @@ static int mes_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe;
 
-	if (amdgpu_sriov_is_mes_info_enable(adev) ||
-	    adev->gfx.enable_cleaner_shader) {
-		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
-				      &adev->mes.resource_1_addr);
-	}
+	amdgpu_bo_free_kernel(&adev->mes.resource_1[0], &adev->mes.resource_1_gpu_addr[0],
+			      &adev->mes.resource_1_addr[0]);
 
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		kfree(adev->mes.mqd_backup[pipe]);
@@ -1643,13 +1642,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	if (amdgpu_sriov_is_mes_info_enable(adev) ||
-	    adev->gfx.enable_cleaner_shader) {
-		r = mes_v11_0_set_hw_resources_1(&adev->mes);
-		if (r) {
-			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
-			goto failure;
-		}
+	r = mes_v11_0_set_hw_resources_1(&adev->mes);
+	if (r) {
+		DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
+		goto failure;
 	}
 
 	r = mes_v11_0_query_sched_status(&adev->mes);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 96336652d14c..abe8592170b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -687,7 +687,7 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_1_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 0xa;
 	mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =
-		mes->resource_1_gpu_addr;
+		mes->resource_1_gpu_addr[pipe];
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),
@@ -1530,21 +1530,19 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE)
 			r = mes_v12_0_kiq_ring_init(adev);
-		else
+		else {
 			r = mes_v12_0_ring_init(adev, pipe);
-		if (r)
-			return r;
-	}
-
-	if (adev->enable_uni_mes) {
-		r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_VRAM,
-					    &adev->mes.resource_1,
-					    &adev->mes.resource_1_gpu_addr,
-					    &adev->mes.resource_1_addr);
-		if (r) {
-			dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", r);
-			return r;
+			if (r)
+				return r;
+			r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
+						    AMDGPU_GEM_DOMAIN_VRAM,
+						    &adev->mes.resource_1[pipe],
+						    &adev->mes.resource_1_gpu_addr[pipe],
+						    &adev->mes.resource_1_addr[pipe]);
+			if (r) {
+				dev_err(adev->dev, "(%d) failed to create mes resource_1 bo pipe[%d]\n", r, pipe);
+				return r;
+			}
 		}
 	}
 
@@ -1556,12 +1554,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe;
 
-	if (adev->enable_uni_mes)
-		amdgpu_bo_free_kernel(&adev->mes.resource_1,
-				      &adev->mes.resource_1_gpu_addr,
-				      &adev->mes.resource_1_addr);
-
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		amdgpu_bo_free_kernel(&adev->mes.resource_1[pipe],
+				      &adev->mes.resource_1_gpu_addr[pipe],
+				      &adev->mes.resource_1_addr[pipe]);
+
 		kfree(adev->mes.mqd_backup[pipe]);
 
 		amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
@@ -1760,8 +1757,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	if (adev->enable_uni_mes)
-		mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
+	mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 
 	mes_v12_0_init_aggregated_doorbell(&adev->mes);
 
-- 
2.34.1


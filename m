Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C43C282DE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 00:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502DC10E4F2;
	Tue, 11 Mar 2025 00:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZXD746Qr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8790010E4F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 00:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8BtT2rbbSbIb0VqefRIdtp44JjOSw9KbuN6SYjfbj/4i69JK7ynHv7ZvmaAH9umr2bTzDLMpneOSi/EBIU3IgX/qh2/duF28uwZW7w+HJsisOqsqeGNkptG7/vEiPtTy1R1mH9Sb71z/Z6+ToAcmHmztLhfLH/cjRJgMPxmttnwLcYDr8JB3KJY/KEBWsEEWvGsixrwQa5oICk6C0xU7rruizjsAT5ld9koUCe7ytr0ugarPgThjvQUuo+nRVgw/fr09BJAviCx/Joa2gegAgw8jw1KI/VMaXJOPQ7GHqU9G4krLxuM1+mtRDKxHknX7fXKRuoFxeTzi0+UFDiRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmRJy7DoLIy2UCj366O0/aDDKtg4BM9Vcza51mIjFpU=;
 b=xEZWtiAanlbCvAEvBuh34HJkaMazPgLImo79hOM4n+ad9jkMnzDiEWdZYjj5DDa4TEDo4iOTnyN9ABt0XMN/tnCqN0TjBPqL0o2mxNuKy9WeQJdss2hYMTJrdYT95yXP8NvWJReEgV1fkoo+t3IZ7pVbS1aD3GpyHTDXM2DyBA8e7tiNv7310JtCqd6sh+hJsT3QWzbA6UphZTcKzu4HgQRpIE+Zd90jbsziITD2rZxmrMKBXfu8LUi5Ql4wgZVDmGKpJ+jHc6K58orBzILuKjnzpuzg05ZGM2EWBOZ16DULfUr2MDcmweK/RCh4Yrr8Qghf1pxkCQRXT6BNKG+dSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmRJy7DoLIy2UCj366O0/aDDKtg4BM9Vcza51mIjFpU=;
 b=ZXD746Qrn2W8lIljIdoTDuCqDPAltDk1QaunxvZxUxKiPJUsy7ubhL7cngxc74q1tct+hSXHEfj8z1Mbz8w31QGqm9lGod0YSlayg7tY+6NhPLFlpIG4aNAgboa2Qz/cp1N0AsD7uCZ0cNDWdPsey/X3jM73VGfTLLvJbMQn8U4=
Received: from CH0PR04CA0094.namprd04.prod.outlook.com (2603:10b6:610:75::9)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 00:46:09 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::1a) by CH0PR04CA0094.outlook.office365.com
 (2603:10b6:610:75::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 00:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 00:46:08 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 19:46:08 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix MES init sequence
Date: Mon, 10 Mar 2025 20:45:52 -0400
Message-ID: <20250311004552.167172-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a73f605-392c-4bae-7a4e-08dd60361d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dW53Lwvh0ryeeXTGDtjNhLYdcVoll5XpmWrcbuIxQAJguwnmYe6rRcRUEmC+?=
 =?us-ascii?Q?tW/T6B2CurOs8zF2EeSakTVHMwUutGGiNiF8Eh6R5qTiBAKwLH0kByr7KQ/0?=
 =?us-ascii?Q?K3ZHl8fMMBaU1JSNPHa2WuECDKzyAsk+7mmQ7V4VlAqLkqy/mhQi+r6AKEcg?=
 =?us-ascii?Q?LP4Avx2riU6acKzSzhkjgWAXKXosns4hFeZMLj1ip1eneBftRREVYe5CMaO2?=
 =?us-ascii?Q?/+C5NKsc/8+ktJjDLmgJ1ki5mvzlf7e1K8NP/d06PIe4V+ESobEhPWLfFZ0a?=
 =?us-ascii?Q?bBIRMCDQc7nRU5SLT0a9TtnoHXxxjcWkeBczYBrBXPuX6vE3uV+8IM2DOsRl?=
 =?us-ascii?Q?FosC8E6gVPHmW/RiUYqCDd5AN551qmR+ULGGCNMddaQ/U3vWH+T1cKYS13ha?=
 =?us-ascii?Q?rYLsAEt8nMSoxDGfOIOZ/2h9D7i81lnbVegCD5kHUofx5R0YRk6MlVHvcpJ2?=
 =?us-ascii?Q?jEjm/s3t/YHcUHucBN+SeWoxUG1xR1YN7qMPRx/eKtIRgXnLF9tXRLNN21GY?=
 =?us-ascii?Q?Tc9ynf94oc7Jbt7V+h1KCqJjZH7F6dkwLADRVTu3N983yNA98fR0DZ5KNxmt?=
 =?us-ascii?Q?kxx+pp8lqUQt36aTtheYf5C6ByFLs5cvj4R8tELaalnZ/khQLGJ+WKaTbxKg?=
 =?us-ascii?Q?a/4WkT8Fuf5LygXEgQTKuJXojPYXOkCcvCPO34IVCp02CK0o2a04sS/+1cRZ?=
 =?us-ascii?Q?c2Fp9q7evUnc8WmnVNw5vUog/vIUaLwF/FnfFTG2ysfmtxRZZfDfBjtTDvty?=
 =?us-ascii?Q?KVFfC3h4Qw14+HGAzD0k8gleQJU4UT4jQGYGEvCtkI4iLJmhoXy9CcB2FHLh?=
 =?us-ascii?Q?5x8SRUNbtL2SmpCl1PEO4jqGnkT+4BXyK918lF4sP22HCEuUS0Zfsy7U+3LI?=
 =?us-ascii?Q?KtARG5HD/IF/6j73qK4ViVZULZ3Uxj6LQpxJvHvASHZD82gKDjqeYt+M09L2?=
 =?us-ascii?Q?L9WAyDA4lLnmKYJpDT64rY/RPRdbF8PctlFPVF2d2xE2g+FiCvG6Xt6NkueU?=
 =?us-ascii?Q?VELbj9d5UBCvdm+JArKbS+mS023lsd+IpAH6Fzt+p0EV4WC340iGxkuW0o/U?=
 =?us-ascii?Q?34QI5+HXyeUpXSR7Gu01+3c/lcOz/XurRoPYhPOG5RbaurYlpBpv6IkWGl/H?=
 =?us-ascii?Q?m2Owa+3AfT3ArqPElhCRNH2eU/AU4zEN6Fk4nUvulP/u32FkfeZCXL95acNe?=
 =?us-ascii?Q?xNPZQREUVrNh82vpDe3hc+MvGcNHBMSgB911rSbLcPq7wtxOF98QwULQLz63?=
 =?us-ascii?Q?j34suz2Ju+yUw0TXbAfA5IDP+/qSmqhdcrSW+zF2Ol6D2FkNFBgvY+dFalg7?=
 =?us-ascii?Q?vJwyeh+zrwT8oHLFU3THJgKulPhlZ9pIxJCWpZaHrzT5iI7apgsJLoN4YooQ?=
 =?us-ascii?Q?n2Q3bD8WxAA5i+rxVotb4owRi+ZO0noM1Um8420dLEC71Od1ZUft6jc1gm8S?=
 =?us-ascii?Q?J/JJOrlENCJ4iOJvc/Ag/neIkoMV+vPubxBG/Kb+fS8WYoRHmSsBrYaqKEQC?=
 =?us-ascii?Q?8GzxzVuoXlzkGvA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 00:46:08.8578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a73f605-392c-4bae-7a4e-08dd60361d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  9 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 59 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 43 ++++++++---------
 4 files changed, 57 insertions(+), 60 deletions(-)

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
index ab7e73d0e7b1..0bb8cbe0dcc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -614,10 +614,11 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->decode_usage = 0;
 
 	vf2pf_info->dummy_page_addr = (uint64_t)adev->dummy_page_addr;
-	vf2pf_info->mes_info_addr = (uint64_t)adev->mes.resource_1_gpu_addr;
-
-	if (adev->mes.resource_1) {
-		vf2pf_info->mes_info_size = adev->mes.resource_1->tbo.base.size;
+	if (amdgpu_sriov_is_mes_info_enable(adev)) {
+		vf2pf_info->mes_info_addr =
+			(uint64_t)(adev->mes.resource_1_gpu_addr[0] + AMDGPU_GPU_PAGE_SIZE);
+		vf2pf_info->mes_info_size =
+			adev->mes.resource_1[0]->tbo.base.size - AMDGPU_GPU_PAGE_SIZE;
 	}
 	vf2pf_info->checksum =
 		amd_sriov_msg_checksum(
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a569d09a1a74..9cec2bb2f9ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -751,10 +751,13 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
-	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
-	mes_set_hw_res_pkt.mes_info_ctx_size = MES11_HW_RESOURCE_1_SIZE;
-	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =
-		mes->resource_1_gpu_addr + MES11_HW_RESOURCE_1_SIZE;
+
+	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr = mes->resource_1_gpu_addr[0];
+	if (amdgpu_sriov_is_mes_info_enable(adev)) {
+		mes_set_hw_res_pkt.mes_info_ctx_mc_addr =
+			mes->resource_1_gpu_addr[0] + AMDGPU_GPU_PAGE_SIZE;
+		mes_set_hw_res_pkt.mes_info_ctx_size = MES11_HW_RESOURCE_1_SIZE;
+	}
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
@@ -1392,7 +1395,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int pipe, r;
+	int pipe, r, bo_size;
 
 	adev->mes.funcs = &mes_v11_0_funcs;
 	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
@@ -1427,19 +1430,21 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
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
+	if (amdgpu_sriov_is_mes_info_enable(adev))
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
@@ -1450,11 +1455,8 @@ static int mes_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
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
@@ -1643,13 +1645,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
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
index 96336652d14c..61e07a4f7168 100644
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
@@ -1528,23 +1528,22 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE)
+		if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE) {
 			r = mes_v12_0_kiq_ring_init(adev);
-		else
+		}
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
 
@@ -1556,12 +1555,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
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
@@ -1760,8 +1758,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	if (adev->enable_uni_mes)
-		mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
+	mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 
 	mes_v12_0_init_aggregated_doorbell(&adev->mes);
 
-- 
2.34.1


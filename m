Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30D8D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 07:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FB310E2DE;
	Tue,  9 Dec 2025 07:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Px9PGVX";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44E710E2DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 07:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgCVoxgsBspkV5KwvGIGVpmMAjXI7iWZ64pHi0wAPIj60E+ELbmP+MIzvpr+AplL8AAxoCUtjPby/cjxkm9L3J3b/Z9g4nsV3eMH+/tzDnvmL6g5YKrqDB5cH+MiyhScLxvaaIdw+xt77uwhAnTcMGV636v0Q66gpcVAHitofMclwsbhzeJcfqZynGW3LnAxRzFkYAPkGxF43zB5DDXAXtc9FrZWlljouBSelOvMMG8ZjDoe4ydhdCgt19s2Px6Oip8HpWhnZ9g9+5AvHxb+9Qmisj+s2RZ7W58PjsxqgJOJvDvxWKla6xRVrX5yf3lgRC77Eo0eqavDLqtkDMZtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xPRZoWV2dzlmUOjSXYzHN/2PHpEjo8o3InzszYPvzE=;
 b=Otx+t9Xm+AcppvWOwKxPBlVFGkAf7i3ZRQpI98s1mCEN3AFMyDxRX3IGX4NUBf28EQGPEo7ShANYgDFIUvu03ONLtj/p8JiFFur2/Ylz8/nA7NkpuMFE0JsMkWUytrFNOb2V/fsKIkC7C/zgkw5YkjRIEqjF/LWxs6u5teI5WqlOtnl42G9RglHJsDJJt+wOf02qwz4O1kj3+G+TegvF+igHT/Reg9/B6uCdAHVmoVZBuwZul7WMP87pHMgGsRzfD6lSHLi49jM6mMqZBunStonn0Ed4Lq4ooVyYEFoZSA+Dm57q5zmDrJ0TKFP4Mi1P+Qf7Lbf6wyIFdy9rW+IE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xPRZoWV2dzlmUOjSXYzHN/2PHpEjo8o3InzszYPvzE=;
 b=0Px9PGVXHIIo6DokJenxPc9+B8Zj0u2SjbpTARnqwiSm4AU4GHBzeWEnwJv8EtPTUsze7MVbBfdQlDwmxCmEBCRJlEKA2Piifoxi9uk/fHsneGgwygLYe0VcSdK9bvK4X4RP6QssDCL5c1+cTa5Xhon4J7XSry5/gD+jP4nu1o0=
Received: from SJ0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:a03:331::9)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 07:49:41 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::ea) by SJ0PR03CA0064.outlook.office365.com
 (2603:10b6:a03:331::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 07:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 07:49:41 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 01:49:40 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: Add vram_type to ras_ta_init_flags
Date: Tue, 9 Dec 2025 15:49:12 +0800
Message-ID: <20251209074912.530424-2-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251209074912.530424-1-candice.li@amd.com>
References: <20251209074912.530424-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 96432ec0-5dda-4456-30ae-08de36f782d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BoJfWl8gIMA3z4WOi6HNJh6lyAeXXt2JvKMLooW/sbQUEHCZaYFLoqEoj6YV?=
 =?us-ascii?Q?c/M73iHII/kvXFOvy+pneIvUV+tpCT8fghiOIGdJ7yHB9jZ98g45VxZJHNAX?=
 =?us-ascii?Q?j/2FsMfwDI+IhiEoCMyXDIgd6qAq84lZ1m3cnZqs3VIy2CTJ8Gx0QMI/MAb8?=
 =?us-ascii?Q?nz8vzdKgY3b6ypLBGkzc4BdU3dht7Zc68BX3g1RwLjHEYa9Ejk7h2SCVAli+?=
 =?us-ascii?Q?d6jdLPj1M4l9q1nutCA7zfdfn+j8/y+Uo1nQN+y+8TRbblbSCrqxc5f1icPm?=
 =?us-ascii?Q?ebeolPmyEWX0l/qKrD0PWch0dQuOo6k22REpWnoQuA1qR4o99VXaO993mYnq?=
 =?us-ascii?Q?W86CvPa9V9y+wpzcWsuD+N0upTrdCOFF+Xh5WaCXK6mKRRw+PZgV9pISXc6f?=
 =?us-ascii?Q?3Ltch6OiT7Sjdy96gzaEodVqNZxPzSgxMf+0fbf70Ju8TGl8WuMumGK7k/cA?=
 =?us-ascii?Q?vHOUM1ssbMJc6SJCXAr/iLdzfyjTlQiERM9CJuPYx/BO+l+ljdEGAih/ZRL7?=
 =?us-ascii?Q?HrcyTX3KHOdJa6qD6Napl8ygXNqpMr+CByro3YYgadlyeZ9ZRnnQ5J4cpp6H?=
 =?us-ascii?Q?B8uDhIE981E4lmCm/oD8Hm18lxTGcMC48nPGpIfygNoEABH9IKcNKVfbcMTR?=
 =?us-ascii?Q?7EIHVm92vcTXZfrouyHB1enyF5oD0fXcBe/1hFZkO1YEw1bfUThyqYhKwwmA?=
 =?us-ascii?Q?dNSnWrMCZk5+LMCdQ5yFd6dL8Vryn3QnNC5c8KL00vSoMiPmljfj2+FRYrHg?=
 =?us-ascii?Q?TrXtaf+Z0dK+ByAKFqjcRMKI5Ui4euGUn/Gup0iUH5tTnpLOOQwlMVShfAaU?=
 =?us-ascii?Q?2P7RJmtWL4hsu/XYL62MryJ6PhXFx3zSs7+HVFl+I+CmuTWKD84N2jT+EwA9?=
 =?us-ascii?Q?RTqKZDL1rpokwrnEPuKKH/7mccKmo2SGrbtI5C3dAogUVjkjwHibBFBYS2XE?=
 =?us-ascii?Q?5jzeDalYY+nwFRXrcOR1KfJC7kLhd0+Ox1DT99EXsDX/k/kS11GJqAx7Yvtd?=
 =?us-ascii?Q?K6kO5Nm28KyG/tquKDZjAfWOPgpvArwgzhHfqc72yj+puF+djyfj6B9ickNz?=
 =?us-ascii?Q?9f0mF8HqppDk94bZeNHSsbn5/l9K0XzXaQMARjp+tiQtDYLTKLr47oYvoK3C?=
 =?us-ascii?Q?andgA7z/Gkv5YDdmBvTiTrTMYGWHK3dkWDl6CmN5RwFS1euSLIldxBd3Sl+d?=
 =?us-ascii?Q?bSt0iv8MfjNTlstl8pOdDwX3XGwGGBRqx/ghMVil/5kA/x3FnQooOiysr8iC?=
 =?us-ascii?Q?ZV1CD1S0jQ+7Mate3G2vuR0GsmA2qZWYrmdS2B1Z55bJ9aB7PuOFA6WnswOy?=
 =?us-ascii?Q?XmIzUiRnqgVEuqQdmNYGKFoMD3s9/oWyMfWmwJesBJSg0rBpCHMz/pxChUBd?=
 =?us-ascii?Q?FPD2IS/7li4ghKl83pL7aoyce73tcdZwcxU26COuBL7/kI/ZRDyo+l5F6FuM?=
 =?us-ascii?Q?UJtmVjOcyd5uEpYc89XX6czSgx0O93PlEOE6Qp4TR44bDRByUhJfLK4uVPN8?=
 =?us-ascii?Q?AOONzfzmV9EyG0q+TLMyUgSxjxf/hijG6E69c/GwuqdcUbHMusrSGwg9dRY3?=
 =?us-ascii?Q?zqPgwfnYzoPFZQ+12hQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 07:49:41.1361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96432ec0-5dda-4456-30ae-08de36f782d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589
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

Add vram_type to ras_ta_init_flags.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 1 +
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c        | 1 +
 drivers/gpu/drm/amd/ras/rascore/ras_psp.h        | 1 +
 drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h      | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 923bddd0af3a28..b86638fe0f32cf 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -216,6 +216,7 @@ static int amdgpu_ras_mgr_get_ras_ta_init_param(struct ras_core_context *ras_cor
 	ras_ta_param->channel_dis_num = hweight32(adev->gmc.m_half_use) * 2;
 
 	ras_ta_param->active_umc_mask = adev->umc.active_mask;
+	ras_ta_param->vram_type = (uint8_t)adev->gmc.vram_type;
 
 	if (!amdgpu_ras_mgr_get_curr_nps_mode(adev, &nps_mode))
 		ras_ta_param->nps_mode = nps_mode;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
index ccdb42d2dd6052..5d556e2a7000c2 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
@@ -507,6 +507,7 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 	ta_init_flags->channel_dis_num = ta_ctx->init_param.channel_dis_num;
 	ta_init_flags->nps_mode = ta_ctx->init_param.nps_mode;
 	ta_init_flags->active_umc_mask = ta_ctx->init_param.active_umc_mask;
+	ta_init_flags->vram_type = ta_ctx->init_param.vram_type;
 
 	/* Setup load ras ta command */
 	memset(&psp_load_ta_cmd, 0, sizeof(psp_load_ta_cmd));
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.h b/drivers/gpu/drm/amd/ras/rascore/ras_psp.h
index 71776fecfd6649..347f5334c3f346 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.h
@@ -51,6 +51,7 @@ struct ras_ta_init_param {
 	uint8_t channel_dis_num;
 	uint8_t nps_mode;
 	uint32_t active_umc_mask;
+	uint8_t vram_type;
 };
 
 struct gpu_mem_block {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h b/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
index 0921e36d3274e8..e910a75b302297 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
@@ -167,6 +167,7 @@ struct ras_ta_init_flags {
 	uint8_t channel_dis_num;
 	uint8_t nps_mode;
 	uint32_t active_umc_mask;
+	uint8_t vram_type;
 };
 
 struct ras_ta_mca_addr {
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B773C3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 05:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E5E10E160;
	Thu,  8 May 2025 05:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="su/tdX30";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413CA10E2A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 05:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3XTHoxDtaei1dFgO6aw9NkSRxhXfW9dcnYwBmep2YZQD1QYyEtjDUMBjB1s3x1U45UOOdHtA3Rzb91N/aDeez/xLwOx36cVxCY7iZS7ESqPez3H+jbZ9yGJv7ZIlVIVhN2fIAnObzHqdu4VMnfGKRg9byK4zHvL6HtPOwgjG6uBaio1MSWoxiSE5PLPDi6TCV5ARenuqUMut80Sk4wv2vk7J/xOhU8zcqhiA7kWp8PgkeLpwW/AjZ04R27Oyx4M73Q0t6zU22X1Z4l6h5HwmGOMHO6LXQxgI5S0EMOQQbL2RbHXTYeuBfAepjo5MwiRJEtJPvSHTKg75X4gKOcWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUyCcAg/wohKBNxzIKLFlctS8l0Tu7XvXPwC5X2+1Uc=;
 b=KLsEsExO+1m79dWmuD0XTfDhsCFFgluvoWw61mCiwnNhxS2pyPF9DSDN8xGiOCUQk8+2bHZeSz5c4bJrSWDwe+Urf+XNh2ny7QLV5XZbg5bCVDDuLCmhIRB8cuFZ6WIUWK7T7yAIhdYAxrl5JZXduJ6OghUISLN4lfE3ATOkXDb0p/U1pwL8X6AK4oV662QLBrf2w6eDBGz6pXJA90b3pQGwLvr+PMfdCA7ss3CTP9bdpVTUkarNT+dfmmrZAmNtehfAt7ctdmuYd5bUD4M3DUOAwDYZ+II450SLcJ4+jfka0PdB5qI5onx2KzqXfr+5dt9x1Lpk5Kkes7AM+iWTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUyCcAg/wohKBNxzIKLFlctS8l0Tu7XvXPwC5X2+1Uc=;
 b=su/tdX30XszqI2qjvIqZwP8nGpEB2G1I9C8xUoi/h6rvnMfuj2q+9/92LfXjvkWSD6BWPj4Lu71Y6omd+vITvpFcXI2++cEAgqmBawpoeXzaQoozK3jJHDvcbOMWOOAvK7EEX0WTWkxGhyrzvZQavyqovdJVkbINHyiGqOZHPks=
Received: from BYAPR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:40::36)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 05:10:14 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::f2) by BYAPR04CA0023.outlook.office365.com
 (2603:10b6:a03:40::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Thu,
 8 May 2025 05:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:10:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:10:11 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:10:09 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v4 5/7] drm/amdgpu: remove cached gpu addr:
 ta_mem_context.shared_mc_addr
Date: Thu, 8 May 2025 13:09:24 +0800
Message-ID: <20250508050926.228674-6-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508050926.228674-1-guoqing.zhang@amd.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3693e1-4749-40dc-7f72-08dd8dee9d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n1kEHKxRt0qhBoeTSGbZ/7zZO00kP2F5QWncaujFDPPrn4Pn/fBMqbdR4vzi?=
 =?us-ascii?Q?ZhkO8yeBYnpxW84J7kJaQi8ePnYLg0uRS/Ba2TDpY1JnY4P7hHSPmBDQsn4t?=
 =?us-ascii?Q?MhmXrKLGTcBGmm3Qd29vKQCnh9Rivfnf+icfNls+hSP0U0pqa20wk27ruhWs?=
 =?us-ascii?Q?ZgUCpie0TYYBfgBPFlAlPYBPfnlD3C9uzqnEyJI3NK4oLANGrizL6Kkvx+6x?=
 =?us-ascii?Q?7azOrGyh/YLHxMIxEWY7HXO0etVEK9UCCUvDkrxe1SMl15IvEpUk1FFu/KL7?=
 =?us-ascii?Q?o8wHYgIFmN6jTvnMt6bZoJJbs1LWF7fn91GvuDjmBevaKil07JV2qhoFMwLv?=
 =?us-ascii?Q?wEGfyhjXmzBgCcQRmdCgxyRY+xYw7u/U0lt6plsDd4gTgsAe18PzW32cK7i3?=
 =?us-ascii?Q?WZRRgzzpRfHPACbCQ5rhM3Fk9NL2XIbYgydt6y5Dr1kk3l+PeTFlt0w7f9qJ?=
 =?us-ascii?Q?4bXlRU5U7zwOVHeVpT5P8SWPKxyWJX5sHhvpw62q4Q5iSkBMxrN13yYywqw1?=
 =?us-ascii?Q?GShpWojr3Va/DXPzd5OpcHUJFBM+dJt8SXMbi41qjS1mvN6HkChzbvfPou7D?=
 =?us-ascii?Q?CZYaG5bwiSyPKuH8WIeAiYAtbrF9ZBd0Gk0gs+IiDxyYA1m3dKek1CJDBaxY?=
 =?us-ascii?Q?2ln3kS3PDWbZLvc8CBUH8GgJRDDtG9C69xMgx3nc7bAQe1IjzGkUUMT8hElK?=
 =?us-ascii?Q?CS/LhbvlkfHuFNDazFS+GeKPfrMyok/w6CmYd6GIG+YPUKfTMUKWVoP6vSAK?=
 =?us-ascii?Q?uI1zpqPiO72DAhyhbWslHmO6Avl7eRm3NS8kqaVlcosz6nnBOZukuQDwcHPe?=
 =?us-ascii?Q?v4ZzL8GZz1USvce1qZ1di7zWaD2Yh5OW0GL8bT5W/ii+nAMaWj1+bHo+05yb?=
 =?us-ascii?Q?ZqODxhHqc5o2E5yhbwQ4Tca2Zd2vAo8jWZsxuNHk3FixU6P+ZChFGakh1FG7?=
 =?us-ascii?Q?hL+VF0FOyTK7F10OAFoD+ycZMHMbPYK+OYhQ/Ze65xKaxNDE3gdmlYLnXSUA?=
 =?us-ascii?Q?jbGl4BJQ/Q+X6k5uGnacsofMvkaTOsMdlcQsVCREOlLiyZ7tzdaHnyE/lUJ1?=
 =?us-ascii?Q?80I/mK1GwFiH4M104k2HEpqgqgodB3brLrpn7+Dm4jg/PHtZwENfMLMrW8iV?=
 =?us-ascii?Q?0DjZTWgZ3w+V4Y+qAsQgWp7OOOZOp6t4rOq2TJWsscsrsJmxMeQmSvJcLpu1?=
 =?us-ascii?Q?I4BFjjVI1eTCwCeOnYZPV+qftz1F0n8bUcu67w/qacZiVLqeRESDW0PYCKlZ?=
 =?us-ascii?Q?lM5nMPvWB45J46e5hQGTuRdRooyr3HWRny4Sz1gGLwEqNXcFV54GkRBg6Z3C?=
 =?us-ascii?Q?xvXKQwgrLEbuSu9SjzLKgL4627FLBIzwUcwKlkYzRCuVdhYsyXM/lWk39Wu6?=
 =?us-ascii?Q?JoMFMC9OXWWon+CAubeGu7oL7zkcktm1N2ECe3CZg8KLLbH+AU162oke5RbN?=
 =?us-ascii?Q?mlK/3e1p6FMoZ5CGzw0mqQt/rvK8XrKULXC9+iHdBHnjytZHnxY6Ov0MN9t9?=
 =?us-ascii?Q?vP10FHmsYTOCi7DtOYEiFEPTbXKDaLVNTO8N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:10:13.8468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3693e1-4749-40dc-7f72-08dd8dee9d73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
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

When pdb0 enabled, the cached gpu addr is not compatible with SMU and
PSP. It always need to be updated. Remove the cached gpu addr and use
local variable instead.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 +++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bdab40b42983..153c0c868546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -276,8 +276,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 
 void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
 {
-	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr,
-			      &mem_ctx->shared_buf);
+	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, NULL, &mem_ctx->shared_buf);
 	mem_ctx->shared_bo = NULL;
 }
 
@@ -1123,7 +1122,6 @@ static int psp_asd_initialize(struct psp_context *psp)
 	    amdgpu_ip_version(psp->adev, MP0_HWIP, 0) >= IP_VERSION(13, 0, 10))
 		return 0;
 
-	psp->asd_context.mem_context.shared_mc_addr  = 0;
 	psp->asd_context.mem_context.shared_mem_size = PSP_ASD_SHARED_MEM_SIZE;
 	psp->asd_context.ta_load_type                = GFX_CMD_ID_LOAD_ASD;
 
@@ -1207,18 +1205,16 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				     uint64_t ta_bin_mc,
 				     struct ta_context *context)
 {
+	uint64_t shared_mc_addr;
+
 	cmd->cmd_id				= context->ta_load_type;
 	cmd->cmd.cmd_load_ta.app_phy_addr_lo	= lower_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
 
-	if (context->mem_context.shared_bo)
-		context->mem_context.shared_mc_addr = amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
-
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =
-		lower_32_bits(context->mem_context.shared_mc_addr);
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =
-		upper_32_bits(context->mem_context.shared_mc_addr);
+	shared_mc_addr = amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo = lower_32_bits(shared_mc_addr);
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi = upper_32_bits(shared_mc_addr);
 	cmd->cmd.cmd_load_ta.cmd_buf_len = context->mem_context.shared_mem_size;
 }
 
@@ -1233,7 +1229,7 @@ int psp_ta_init_shared_buf(struct psp_context *psp,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM |
 				      AMDGPU_GEM_DOMAIN_GTT,
 				      &mem_ctx->shared_bo,
-				      &mem_ctx->shared_mc_addr,
+				      NULL,
 				      &mem_ctx->shared_buf);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 6ea5c21edc4e..106d07aaf8e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -174,7 +174,6 @@ struct psp_bin_desc {
 
 struct ta_mem_context {
 	struct amdgpu_bo		*shared_bo;
-	uint64_t		shared_mc_addr;
 	void			*shared_buf;
 	enum psp_shared_mem_size	shared_mem_size;
 };
-- 
2.43.5


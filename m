Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A50C5DF74
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0CA10F6FB;
	Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3OOMmcv2";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011029.outbound.protection.outlook.com
 [40.93.194.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5E410F6E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG9WZveWaQ6b1qy6r1CyUkpq8V0Cg99npr8w3SpLtnV6YUMRmI3T6NJmrdQbM81aLOUd+rdMIUKEiWtFKrZPzyKsNLCL5LpV8moSATAFaS+AK9jPRP9DT6gQut/BqV8HpHY3s5PvNqK1c9gD+S4LLGgZMswGviiecYHK5AdL1bGo1qP9geRYWpVrkHUoLzxwGf4lOQ/KX5feji0HcKng+XkCiMR37Q0x4wxhKXOTP1xN71LWj79hXqiIcRBChLifMWFJh1S5nmYEU313AcA/eKJiA0vQIX1BmM7c/vA3TImLT77m45Wt2rtBVI2uARthswudZQTh38kfv9KWMF89ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBfQsvybCUdcrpzoSwKtYfzoxNwGZQYprc5kDxEbkz0=;
 b=F4+/P0cZBFzZT9gA7DcQzPRMdARl2yk+vO06ILSO8L/elGfjhySf+GcIgdwhsj2OCE7fOSgV1yURZb+QCAO8jlGw8EHaz8Nsw94BYadra5iTViUMYjDhb+2aLtIN5iyYDUnfJ+86Lj3XzyZ5UoK53QF8dn8KWXTilo3HqYQw1fLJTNC396ugL/NWG9TbC96G7852T7RQEWNiF4zN0rudXT/oPxPzqFbg4Mxrrgje56aPAOtKGu1vlGdVXixpigku/utChTfXt0pHPdTgdIxyp6COzgVFuUTmi4gr6LVS3hiZUNUdSw19GM106GcBgmrYorc/llF3ixeQvemH7sbH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBfQsvybCUdcrpzoSwKtYfzoxNwGZQYprc5kDxEbkz0=;
 b=3OOMmcv2lLXUMwv+NiT7Y8V0ZOu1FGyCYh4nFxipWdUMT9kPxzay5BMXq2ZIpKhlPkb25Wmf+OcPfJpB1nkrn4kWAtA1NkRcyusWP51bE8W/cAaWVl9tSffZNw28EDBkNW8Ou3eCJiQN2k7VP7/EmZHP24v+KmgUkhOqIo8b6Do=
Received: from SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::24)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:24 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::4e) by SA1P222CA0051.outlook.office365.com
 (2603:10b6:806:2d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 034/109] drm/amd/ras: add ext_umc_mask to RAS TA init
Date: Fri, 14 Aug 2026 17:01:31 -0400
Message-ID: <20260814210246.3067612-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c902d24-ddfd-46a0-9906-08defa477769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|18002099003|56012099006|10067099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: Elysq35VBWc+CVoaY530Y2EyK3mRMeG3N6xh0HlPqFIq7pRqIs9ZzLeGImpAiWvedSu67Rzh9CAaciEIgNDoQ16mwUUZrWN5CxwQMcywJMZzVXom6kiKRI83mCtIJCQdfFvduesAtw2fGVFcqO/SsNhV6LXU5XTjxri86TlZek2zU6YfiEz1GPxN7exCS3OSP6DENdqDaYsDk8GyRGVS5Q/YA0L0h0VJ9X7NCh0DZ1OUZV0H6erb5URUueg08kQw/jek9T0QTTTK3KOmsv9g1+QdmkKlN3PbuxVf0XtKrKqcmgAsFCulnRQVHM+lIX4Nd0SvyLY8AkAoI9LnNH9awZphRSociFOB2zMngfsBxZ3o5nsnrtqcSI2j6rsAprp2OlIgRL5MJLhxku8ihzpnsoZrjN0sunbhGqNpQhSpI7t8qUzy/u6pfhHz6Bku4h3hS7EVJRkd25sc6ddY3Jw9TAQRG5PFcP3BWm0BmjXz0mTxf8Xk8UUtaiH7x9w22yzgGuaAn/Whfvevuz2ueiByX7qJ8tFSF0U2uxPzENsopJw3niRI7PrqgalyknvEid86rKAGKV5yT6BRXg61t3YNB9of8LK8zEuo3I/xTH1/nj7217tX4r59Cpf+6XSPpTD7AEeDY0BFCXbu3Z6yi8VYuMTbo4/LYIucMhBXZ9ENRKhwpsuyXtG8in7uUgeBcAAgrQklPPvN9uhE2l3f1UaW8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(18002099003)(56012099006)(10067099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i+dfOBfY2CytpeIvxqL5kJ0A3oMEGNOrQEbKqxvvnDu5TXcMlrpvMpvY44OMzxUR/0xrXqqVSbItnFALfYzAxwXZQqwZ/xZJUDmBM8BBrzhpFIlrlalG965077+nnn8l2J5KLrgWO0JNCmE0UkOxjdJUz9o7t5/scf6GogoLS34dnE7WcmF3PsKhOiXYVh2c5noDHa1xgp0W+6DAroMbXkitHFlY9YPNsuyNFIxmFe1dAIvn+udTnjo5PytZrCaI6Ashts1iuUkMchkUJGxKo62qvhIONdZVUI2lq5Zya8UJaBuZ0rSdNiZDpxA6SlxVYbds4DHBYrp6qDCWqBogUTEtyMTKy9Fjbn3TbSYCmlEU4CdNeVcMa+o5fBOJguLCyu8kdLswb+VZR1fuw1uDqgd1sWzn42EDzPJQBmuRcztRz/dOkLLOb3CEn3k3JOLR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:18.5863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c902d24-ddfd-46a0-9906-08defa477769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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

From: Candice Li <candice.li@amd.com>

Add ext_umc_mask for the upper half of
adev->umc.active_mask and fill both fields
when building RAS TA init message.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_psp.c           | 1 +
 drivers/gpu/drm/amd/ras/core/ras_psp.h           | 1 +
 drivers/gpu/drm/amd/ras/core/ta_if.h             | 1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 ++-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index da49ee79711d9..4835228993181 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -515,6 +515,7 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 	ta_init_flags->nps_mode = ta_ctx->init_param.nps_mode;
 	ta_init_flags->active_umc_mask = ta_ctx->init_param.active_umc_mask;
 	ta_init_flags->vram_type = ta_ctx->init_param.vram_type;
+	ta_init_flags->ext_umc_mask = ta_ctx->init_param.ext_umc_mask;
 
 	/* Setup load ras ta command */
 	memset(&psp_load_ta_cmd, 0, sizeof(psp_load_ta_cmd));
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
index dbc06c85d4aec..f1d32f31a64ee 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.h
@@ -54,6 +54,7 @@ struct ras_ta_init_param {
 	uint8_t nps_mode;
 	uint32_t active_umc_mask;
 	uint8_t vram_type;
+	uint32_t ext_umc_mask;
 };
 
 struct gpu_mem_block {
diff --git a/drivers/gpu/drm/amd/ras/core/ta_if.h b/drivers/gpu/drm/amd/ras/core/ta_if.h
index 5d4cea459954d..30c058a524db7 100644
--- a/drivers/gpu/drm/amd/ras/core/ta_if.h
+++ b/drivers/gpu/drm/amd/ras/core/ta_if.h
@@ -202,6 +202,7 @@ struct ras_ta_init_flags {
 	uint8_t nps_mode;
 	uint32_t active_umc_mask;
 	uint8_t vram_type;
+	uint32_t ext_umc_mask;
 };
 
 struct ras_ta_mca_addr {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 9f193cf2ab385..4b9384bc87b38 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -278,8 +278,9 @@ static int amdgpu_ras_mgr_get_ras_ta_init_param(struct ras_core_context *ras_cor
 	ras_ta_param->xcc_mask = adev->gfx.xcc_mask;
 	ras_ta_param->channel_dis_num = hweight32(adev->gmc.m_half_use) * 2;
 
-	ras_ta_param->active_umc_mask = adev->umc.active_mask;
+	ras_ta_param->active_umc_mask = lower_32_bits(adev->umc.active_mask);
 	ras_ta_param->vram_type = (uint8_t)adev->gmc.vram_type;
+	ras_ta_param->ext_umc_mask = upper_32_bits(adev->umc.active_mask);
 
 	if (!amdgpu_ras_mgr_get_curr_nps_mode(adev, &nps_mode))
 		ras_ta_param->nps_mode = nps_mode;
-- 
2.55.0


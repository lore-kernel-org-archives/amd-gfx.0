Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CBFC5DF6A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC3BD10F715;
	Fri, 14 Aug 2026 21:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l8tmut6t";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011053.outbound.protection.outlook.com
 [40.93.194.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB6410F71B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTuGLCHwQJgaMagsqWSuwkWB1UujjPxAHgrvEc+65TdJNhUe4zBAQr3XvEVzByt5NjOTuwF2iOeux4sxeMhVxJDuNhuNxYMrdKb9sqGlXBnJe7exJbs14Y7TFhW1YHFw6orZbOgS2+SAM06jugV3+u1Csn1qYBq+CeI9beoM/Rhe9WwelNBeIeVTn87VOrzucnYM8jn0VqNigZyoyl6IwkjNbC/SMGTqk38FhcO1t4rrsyRb5OjDSK6zZPMYKkBNR8BZzNjWMcgRRtjdvEJTsuaiK1KVqTapYMgfq0rZkAfjMbmyQ04U4WeSvVhxnLLk4YL7vhdEFFULkCLiuAuwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jnqRq+3YV/Lbhw55bmFjuPCQWXq+8MmPNZtMpDkMYA=;
 b=Y3mV0I8N6HdHTuy6sdJ5OOAGmQuYF8jFjPvk2/wAjYwszR6h75w+QtP8XZJAt0YjuyZlQ5i3ztnQv/U/kZ7Psj6ByHZ9+C15h/O8RSAiIHFjSwrgWT5CH1bs/z1OpSvn99vHzJ45jTNBkEAAZtWoCX6/e9rsOohLRI+d/heScxeWSMpi8NMdB2AvGzCh9ez3tzfuwEk0woNAq5jsVKeSZwt899RYvpuVDYzeRnkCljvW/f9N0GA/Iwy324td9QJViUwl9+a+6PY9cSUPsQll/3k2uwQcrEeOcHTjoMo5JXkfu/RjPPtKDKbpyUG8o13sNvmM6WC9D9EEeKnKkJ8mZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jnqRq+3YV/Lbhw55bmFjuPCQWXq+8MmPNZtMpDkMYA=;
 b=l8tmut6tjuJBiuSW8FM9bV7lZcQsaWhF1WJmrxagDQPhz67MMjFOlrxc+HR5i6b96AnrB9Qbtxg0sCf+BrICsB3E/dEACr1Hps5ScmHo9y6e7719UjhzSwic15Sp1REZl4jdGeH19wXL+73Gb8kD412elmX7rXWeP0NJts6vF+I=
Received: from CH2PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:52::40)
 by EAYPR12MB999133.namprd12.prod.outlook.com (2603:10b6:303:2c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 21:03:38 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::9c) by CH2PR04CA0030.outlook.office365.com
 (2603:10b6:610:52::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:32 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Jinzhou Su <jinzhou.su@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 058/109] drm/amdgpu/ras: reload RAS TA from ras mgr resume
Date: Fri, 14 Aug 2026 17:01:55 -0400
Message-ID: <20260814210246.3067612-59-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|EAYPR12MB999133:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b8d8ff-ce51-4d76-a16d-08defa4782e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: N/b8J+kzZ5NWvqtKO2ngAqapS01xOMe26+zX0b3rv2M4Nfgu62khyPSGk5x4xKiBiiYNxk7BMa6c7e+Gxz64UchOzwS+KYxAIgcoEGHcIbLwGUCEa4wKOBY6kXKu33Un/lpyUP1SkQNZINYDoWw9JiC09KNJXgDZXdu+kHK/QsxLq9nZ0dYyoOHscS4ruTmfaiA52HopmxDzvE4nA6lcqrYkZ72/sK9cDSeXsKnqd7z2lDZsXmW1jd+5tA0K9KYC6EjJQcyzAdlX/jUiiK2MoK1WqM2Q76Osx/ljRJoE1McDhNoPkw/JPCH+eUKek/4dsHTcxdGSobdbY3vNx5xQd0+OVvHAACYbP5s4hi29qX5uZHcHriWRhYVZJNeHu7rnhbfXq14UQGA6f9Oe+TYrAeg+BS6uHeYQyn5NL1w4Yc1hwoc/JCgB/ExT/YS4bjvrAWDbvqEB/nD0Rkt0UViJPCPJSrrR00AVO9Rt5L7gstKS/ONAp/c1iRj2jl3BZwLCRkCjxeMoE/zrG05w2sCq8aZCdmkMG1thNblPGBdlkdKSrpNr5CpKJgm1uD9p92XUfCyBnxUMuOsVXp2Wxrn1iT8puO754YQyXJVn0WHpHkOI9IusfP0APm4T/hlXzAin4CMOXeUORS1zAo9LQEFkyh/YzDfJyCp/EJvTCGEQZdI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BCo+lDotOltieFvZsmdkHuRN/uocAIHgiI9lq1ruSnUfJRsr6dD9f9dihDBAjxtEwNtd8MLxcJCSGfvpk+OFi7cZjRqz08/Ic5OXBFtoCZPeh999C4gCvHr5faoOXCSJbG9qR8meZ/b5rZE52X+4+up0rb2463ZPoBwNqgc4wvsfNheELJrmx1rGKBYS3sqXKJqWs+j+T7PfL5pqLRcxTz82PKj4HqC25108yWCdDd4CfujEPa8jfvwnOmjFVwCwPfiaZs0hAVa1jXq2QkiMmDNVyEK6SSRPItpSWyFx2srWi3xG79g2PX5F62Y50ynwDVWa5pl21qBEUb4Y11rJh9VFmRjSfGabeynamFjRGF7xCWMYzc6pyEtvAYjqIPjIP9MJdmnbXDfXuSpZhfVj1RzZfymZdHnt3bPzJvCzcjzukWcV9Drc6xkPPRTpUHe3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:37.8774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b8d8ff-ce51-4d76-a16d-08defa4782e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999133
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

From: Xiang Liu <xiang.liu@amd.com>

When uniras owns the RAS TA, rascore can no longer rely on the legacy
PSP context to keep TA session state alive across reset or suspend.
The manager has to provide enough metadata to reload the TA and rebuild
its shared buffer after PSP reinitialization.

Source TA firmware metadata from adev->psp.ras_context.context.bin_desc,
allocate and free the shared buffer on demand, and hand the fini
cleanup back to rascore through a put_ras_ta_fini_param callback. Add a
resume hook that reloads the TA with skip_lock set so the reload can
run after GPU reset.

Export thin ras_mgr helpers for feature toggles and deferred replay so
higher layers can use the rascore-owned TA path without depending on
legacy PSP-managed TA session state directly.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 29558888832c1..3abd33796c032 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -198,6 +198,14 @@ static int amdgpu_ras_mgr_get_ras_ta_init_param(struct ras_core_context *ras_cor
 	struct ras_ta_init_param *ras_ta_param)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	struct ras_ta_fw_bin  *fw_bin = &ta_ctx->fw_bin;
+	struct ta_context *context = &adev->psp.ras_context.context;
+	struct ta_mem_context *mem_ctx = &context->mem_context;
+	uint32_t nps_mode;
+
+	if (ras_core_poison_supported(ras_core))
+		ras_ta_param->poison_mode_en = 1;
 
 	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 		ras_ta_param->dgpu_mode = 1;
@@ -207,13 +215,51 @@ static int amdgpu_ras_mgr_get_ras_ta_init_param(struct ras_core_context *ras_cor
 
 	ras_ta_param->active_umc_mask = lower_32_bits(adev->umc.active_mask);
 	ras_ta_param->ext_umc_mask = upper_32_bits(adev->umc.active_mask);
+	ras_ta_param->vram_type = (uint8_t)adev->gmc.vram_type;
+
+	if (!amdgpu_ras_mgr_get_curr_nps_mode(adev, &nps_mode))
+		ras_ta_param->nps_mode = nps_mode;
+
+	/* If RAS TA is not initialized, it means RAS TA is not loaded. In this case, RAS module
+	 * needs to get the FW bin info from the context and load RAS TA.
+	 */
+	if (!ta_ctx->ras_ta_initialized) {
+		fw_bin->fw_version = context->bin_desc.fw_version;
+		fw_bin->feature_version = context->bin_desc.feature_version;
+		fw_bin->bin_size = context->bin_desc.size_bytes;
+		fw_bin->bin_addr = context->bin_desc.start_addr;
+
+		if (!mem_ctx->shared_buf) {
+			mem_ctx->shared_mem_size = PSP_RAS_SHARED_MEM_SIZE;
+			return amdgpu_bo_create_kernel(adev, mem_ctx->shared_mem_size,
+				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM |
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &mem_ctx->shared_bo,
+				    &mem_ctx->shared_mc_addr,
+				    &mem_ctx->shared_buf);
+		}
+	}
 
 	return 0;
 }
 
+static void amdgpu_ras_mgr_put_ras_ta_fini_param(struct ras_core_context *ras_core)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct ta_context *context = &adev->psp.ras_context.context;
+	struct ta_mem_context *mem_ctx = &context->mem_context;
+
+	if (mem_ctx->shared_buf) {
+		amdgpu_bo_free_kernel(&mem_ctx->shared_bo,
+				      &mem_ctx->shared_mc_addr,
+				      &mem_ctx->shared_buf);
+	}
+}
+
 const struct ras_psp_sys_func amdgpu_ras_psp_sys_func = {
 	.get_ras_psp_system_status = amdgpu_ras_mgr_get_ras_psp_system_status,
 	.get_ras_ta_init_param = amdgpu_ras_mgr_get_ras_ta_init_param,
+	.put_ras_ta_fini_param = amdgpu_ras_mgr_put_ras_ta_fini_param,
 };
 
 static int amdgpu_ras_mgr_init_psp_config(struct amdgpu_device *adev,
@@ -457,10 +503,38 @@ struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct amdgpu_device *adev)
 	return (struct amdgpu_ras_mgr *)adev->psp.ras_context.ras->ras_mgr;
 }
 
+static int amdgpu_ras_mgr_suspend(struct amdgpu_ip_block *ip_block)
+{
+	return 0;
+}
+
+static int amdgpu_ras_mgr_resume(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	int ret;
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return 0;
+
+	/*
+	 * Pass skip_lock=true: PSP is re-initialized after GPU reset or
+	 * S3/S4, so bypass the trylock and clear stale TA session state.
+	 */
+	ret = ras_psp_load_firmware(ras_mgr->ras_core, true);
+	if (ret)
+		RAS_DEV_ERR(adev,
+			    "Failed to reload RAS TA on resume, ret:%d\n", ret);
+
+	return ret;
+}
+
 static const struct amd_ip_funcs __maybe_unused ras_v1_0_ip_funcs = {
 	.name = "ras_v1_0",
 	.hw_init = amdgpu_ras_mgr_hw_init,
 	.hw_fini = amdgpu_ras_mgr_hw_fini,
+	.suspend = amdgpu_ras_mgr_suspend,
+	.resume = amdgpu_ras_mgr_resume,
 };
 
 const struct amdgpu_ip_block_version ras_v1_0_ip_block = {
-- 
2.55.0


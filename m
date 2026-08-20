Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F8BC5DF89
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A4710E5EB;
	Thu, 20 Aug 2026 14:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ze0/3ZQE";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AADBC10E5EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 14:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxfREAwaCvCsE1KFspp+1bzrFR+kNnGICG1HF0O5ku2IeQ7RJuaw9QcO4iwXei8RFPHOTD8U97xp2dQqdZCx2TpB9IDJxuNCF1zZLQwBQQF+BB/zwxoLucjzOaObBNrb1GUy7Gv+DiNVhbSghGbIRNTQDODBD9jfubQ+Dm66jDyi+hFVmPEOcBbos+pS2eZhhzI00Z1LQCjgIwi+8WBevPuA/xyB/uloNDF+vXVWpCYGeq6KI7woiJkB9NMSvNHfEMq9DwGY9QnPNLGmkDuM1ZvjifVKFp2x5CtbfugDJi3FmqQNpg9k5aOTYv2q8H+WW/Kq7KyLcDI3FcSKa25scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrHcuN/VDtWQ3fIYibK1/k+o3fYRYITImYfMevfo9sc=;
 b=vhutBQWhn4FSK1yc0bzoOI4UIOg09gku3j3UTjOHlt8AOhIa7r04ffiDkN6BwxC+6pf4cmdr8tlJ1M0xHjMSg2XMrlHzNht9G5OXCi8DhaIGoYzTaVrfUiqhEskzuIR476JzRNJgwOU7Tbt7bGAUQFf7VgFeJb5uZ9nfsSyvrbA4hM0WrUaQ85F0c0cdWJ+Z2Mqlz17CUtY5fFQ4yA02jJWS+G+a9YKgYL9TxZZnB5mvr4FmRg/SzrdbiPuHJE4ICc05dcA/iVHN2kxBnl3CaBsFNzWeProFM2/UHegQYDpPWG6wHD2Qy27qjEBz1E8ulegYYQjq2fsJX2+oUBbRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrHcuN/VDtWQ3fIYibK1/k+o3fYRYITImYfMevfo9sc=;
 b=Ze0/3ZQEzcrfaPiLsXgkDTHRatUZfScsiO34f3jG7PbLFPJIEgz5JP3F+wHRBYSE9dKM39+JAFVdNQJDSq8bAU0s/I4tgKwYQmWn3B/0HTCwrkKxMQcdQA2tvzuzfDo1mAGYR23jvtlZgrQc79xCbP2I55WW+lnPJmWuxWAbuO4=
Received: from BN0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:141::16)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 20 Aug
 2026 14:05:19 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::18) by BN0PR07CA0021.outlook.office365.com
 (2603:10b6:408:141::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 14:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 14:05:17 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 09:05:15 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/3] drm/amd/ras: request GFX RAS features through ras_mgr
Date: Thu, 20 Aug 2026 22:04:52 +0800
Message-ID: <20260820140454.1340848-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 2803d20c-3167-48df-ece6-08defec410aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Vew+lzgxkkRcjupmGsf1ZeyLALwd9VURxFzrXWwpiTKtd79gblv1tmRFO7K5evJD9urHzRaFlYdmRKpGGK4iifufHB63+CbsnxKDuSmhBW0foUKoq1t4vdP+lyHOvm/K+uLUS1hjVnwmYqrO2Gr6PRt+4NA/ut/OF2UPGzsyisvVAzS4b1TYB+EdNZR4appaqJujYVake5LGdc6xmTpYKm+CNkSVG5bjdeBsBfjFWjR7i1Ts8I2+2067iK7OD66gBRHccmfUXpaxRqUaQibsDaHi/6WwC5arapPupo6eEa6Aj/DM4Ao/rYyXSJ9s5Zbe42Cj0PZmFUO9FVq+1edZEnWZ7/wJStZ+0Q5aXIH56Hkb+Px8z+P6BBvIj7gNUseWMbkGjhgoNG19tMJGHwSoHzMuviJDaem/YXFjhQmhIyW52zvrQqqu80vwV5OF8zloW78gWkWqOG3b2b02OR9zvGssti59OUVplTsEZVz+UkztiFCgL8kLTL5Bc+r9lrubsLkLHecsDo2bNPQPltbolgA487MfobOFsQbBqvw04tBmJU69dXtBR/Y4ljhRIuPoexYXV3Ru2pi2MibcRvNRBTioImUSfAGrMP2/sHgjVqjWOsUiuliPYzAwqEDqqooTFQFOHgqyNZctgSMZoauYMTHFU78SUfgC/OCZFzgInX81rsSxWYzHXIOWC4NHQ3OYpL7CH4e7lDuQ1zTSnfvGPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pcPXklZt3T0osrlucb3JGvOrL34NqbB5BQnkL+njlpLO+1lzVuCf7e34sNguaBUdlRqlEkxDoEOfrzbBHjsb/LOTgmruulZo3cNn0PFvDS8gq0gV6uRI1ng6/kKxX/1h3AygDHKXxVtUBnV7wStumR33Tc3Ygf/n4p4YzIgioRP0CNwJ7loGkqMfONNSlR5UoKJQyporbOCCc8a4rspJgbaSX4/H/K2YFsyopmvt1k+fishDOT6Hi21iJuRhwn+UztOOmMh/vJW7Q9w7lS/hpCUuu2IchYeYSsVqzrrdSBfcNYNvcznkJdgFFI0Ge/QksXIx/ehsw7/xRih6l+6rekP2eYswzJaxwU727GWyqYhMSmugdFUd7m6C0/iZjxe7VKUOCU7X1pPL/b9MHShtiW7I9eDk/AsgysAOt6iakDRUfpb1D2VeqZB0ZuMZTvA1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:05:17.9417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2803d20c-3167-48df-ece6-08defec410aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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

psp_ras_enable_features() returns 0 without sending anything once the
RAS TA is loaded by ras_mgr, and nothing on that path sends
ENABLE_FEATURES either. GFX RAS features therefore end up enabled by no
one, silently, because the helper still reports success.

This is harmless at boot, where the TA is loaded with poison_mode_en set
while GFX is freshly initialized. It is not harmless across a reset: a
mode2 reset clears the GFX side, amdgpu_gfx_ras_late_init() re-runs from
the reset handler but its enable request goes nowhere, and GFX stops
raising SQ EDC_FED. The visible effect is that only the first poison
injection after boot is ever consumed. Every later one creates the
poison in HBM and is never reported, since the first injection triggers
the reset that breaks reporting.

Add ras_psp_enable_features() to send ENABLE_FEATURES/DISABLE_FEATURES
to the TA owned by ras_mgr, and route amdgpu_ras_feature_enable()
through it. Newer parts arm RAS features inside the TA and must not be
toggled by the driver, so restrict the request to GFX IP versions below
12.1.0.

Fixes: c8a0dcadcec6 ("drm/amdgpu: add switch to select firmware loading path for RAS RL and TA")
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  9 ++++++-
 drivers/gpu/drm/amd/ras/core/ras_psp.c        | 19 +++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp.h        |  2 ++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 27 +++++++++++++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  2 ++
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 572403cb6121..d168e5d54d87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -933,7 +933,14 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 			};
 		}
 
-		ret = psp_ras_enable_features(&adev->psp, info, enable);
+		if (amdgpu_uniras_enabled(adev))
+			ret = amdgpu_ras_mgr_enable_feature(adev,
+					amdgpu_ras_block_to_ta(head->block),
+					amdgpu_ras_error_to_ta(head->type),
+					enable);
+		else
+			ret = psp_ras_enable_features(&adev->psp, info, enable);
+
 		if (ret) {
 			dev_err(adev->dev, "ras %s %s failed poison:%d ret:%d\n",
 				enable ? "enable":"disable",
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index 102dffe9d498..ed53cd25d6bd 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -797,6 +797,25 @@ int ras_psp_reload_firmwares(struct ras_core_context *ras_core,
 	return load_ras_all_fw(ras_core);
 }
 
+int ras_psp_enable_features(struct ras_core_context *ras_core,
+	struct ras_ta_enable_features_input *info, bool enable)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+
+	if (!info)
+		return -EINVAL;
+
+	if (!ta_ctx->ras_ta_initialized) {
+		RAS_DEV_ERR(ras_core->dev, "RAS: ras firmware not initialized!");
+		return -ENOEXEC;
+	}
+
+	return send_ras_ta_runtime_cmd(ras_core,
+			enable ? RAS_TA_CMD_ID__ENABLE_FEATURES :
+				 RAS_TA_CMD_ID__DISABLE_FEATURES,
+			info, sizeof(*info), NULL, 0);
+}
+
 int ras_psp_trigger_error(struct ras_core_context *ras_core,
 	struct ras_ta_trigger_error_input *info, uint32_t instance_mask)
 {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
index 041d46eee3f4..4cc133c6a6d3 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.h
@@ -196,6 +196,8 @@ int ras_psp_sideload_ras_ta(struct ras_core_context *ras_core,
 		struct ras_psp_ta_load *ta_load);
 int ras_psp_unsideload_ras_ta(struct ras_core_context *ras_core,
 		struct ras_psp_ta_unload *ras_ta_unload);
+int ras_psp_enable_features(struct ras_core_context *ras_core,
+	struct ras_ta_enable_features_input *info, bool enable);
 int ras_psp_trigger_error(struct ras_core_context *ras_core,
 	struct ras_ta_trigger_error_input *info, uint32_t instance_mask);
 int ras_psp_query_address(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index e6941de46787..3d806e35382a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -772,6 +772,33 @@ int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev)
 	return 0;
 }
 
+int amdgpu_ras_mgr_enable_feature(struct amdgpu_device *adev,
+		uint32_t ta_block_id, uint32_t ta_error_type, bool enable)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct ras_ta_enable_features_input info = {
+		.block_id = (enum ras_ta_block)ta_block_id,
+		.error_type = (enum ras_ta_error_type)ta_error_type,
+	};
+	uint32_t gfx_ip_version;
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return -EINVAL;
+
+	if (ras_core_get_ip_version(ras_mgr->ras_core,
+				    RAS_UNIT_ID_GFX, &gfx_ip_version))
+		return -EPERM;
+
+	/* Newer parts arm RAS features inside the TA, so the driver must not
+	 * toggle them. Older ones still need an explicit request after every
+	 * GPU reset, otherwise GFX stops reporting poison consumption.
+	 */
+	if (gfx_ip_version >= IP_VERSION(12, 1, 0))
+		return 0;
+
+	return ras_psp_enable_features(ras_mgr->ras_core, &info, enable);
+}
+
 int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 		uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_count)
 {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 442d628ccfec..99b3e6995e12 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -85,6 +85,8 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
 		void *output, uint32_t out_size);
 int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
+int amdgpu_ras_mgr_enable_feature(struct amdgpu_device *adev,
+		uint32_t ta_block_id, uint32_t ta_error_type, bool enable);
 int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 		uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_count);
-- 
2.34.1


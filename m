Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8150AC5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12C810F4BA;
	Fri, 21 Aug 2026 19:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t/uqCUSs";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com (unknown
 [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CACB110F4BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvixCE7v3Ih63xG4TmG6uuPktvq9h10kbyYSPdMgEAyDmnnvhHbM6SVFIQYRbdggFa31sp/SQo1GqSyRc02/r0WmmHE6DIqJVoID219CPmbg0lY6zRXwcN08XpL83lU8NY99Ej4q5ic8DtuUuamOQDjvakcKSOEv4Q1x3fuNAYMkFTJnq/zH4fTITvHAMxqqGU29CWPbRtat/3bK2hIhvPsKYCP8RJrv21RL+ULzeSluuPtThSxiKp483jrkrtkfaQOA394eySHQU9SVB73WhDpIsHYXfB5J31fZnUjo/I+Jb5d1auMGzD4EwyHB6Y/MwOz5NBoNhhqjP8ZTvTeZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whHdlz06rwa5i519eb/HHLxG9bDXnZ9z9XSr6tOF/AU=;
 b=SsyPPHlWt2+XFNBHdKUa1l9u2Yr1uzwTvhp0F5K6WoG+94Btm1thj76mGVGq8/w8OH0rnD0yQBVFXBcFgWFmwHGz2ZUIUUOkxYZJiYOFOPLnGJaPCZRZ4p7MvV/OfflPuKbCNWtjj2I4szZB2ZWXvePwkHlB33uITJWDcwtJC309iaGm+jUzPfvWGxwNZOAiCgg+QqhDfFIRYaihgve+qbRH6Zli6KSezzpcoSo6gkVqITzGbUBLrXCPTliIjICk48umrH/Llo3wT1SkQjTe/baxiZBrSG+f1IE/SbB4+CT9v8iwePtmSfpwiTsrEQSkcOxJHdkHEnxHdM0GQsQUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whHdlz06rwa5i519eb/HHLxG9bDXnZ9z9XSr6tOF/AU=;
 b=t/uqCUSsxT0jcaR2ozWlFDiUYuMr4sp+e2DAnZkEryiAdzXHC7VrLqIsNOJu+TGPutF8oOuzS9cDf2LU5plVbpa8x+SVbinc5gog7V26mIAVDMbPG1qQhYY+2zjm7uRBf8qeMxkC7tbn8SymZEJhN3xUkSuqg2c7jQTmlforkos=
Received: from MW4PR04CA0041.namprd04.prod.outlook.com (2603:10b6:303:6a::16)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:27 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::12) by MW4PR04CA0041.outlook.office365.com
 (2603:10b6:303:6a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/95] drm/amdgpu: Implement PSP cmd UAL_SET_VPOD_CONFIG
Date: Fri, 21 Aug 2026 15:33:35 -0400
Message-ID: <20260821193458.808626-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac63916-6661-4a76-b8ea-08deffbb5906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: H4/n9S0RmgI8dGRf60BFwNLpQ07EYgvme4EaG6nfekf7cHMtxVAVvGPfZkd2FpzcATL/DS+I2NLS+rFzF2HrtgtxAKc3c6zA1FfPqL6dXDDbJHv2Nw3b/Zj4Sr785Vn9YPnQO2/J9rUVDDI3DFN8Ig3VPc4l78gIY0VUz1vmmJrSBdnk22613rBsLK9sz+GhidsnOpfRfr4vsW+78mX0zoV9adV10mTD66Kf6FokqqUNYe74K9fy7ry/lIrVxzBhM1beyHoLtF4E0/8Zt/Gkwx2Eg/qrS+fDFMGrXiim88OhM37JY3QK6OGQu0IIDTCuxPRPrCUWx0DjyZ/ISxDI4HxROSEq4MEtyvU5AUmRb9hMNgvyWlmIAWWVJpV2m3E8dLkw9l+SOaJnFNrS4krEWSdAcnOIliOS9+qPkB5ci2dTIZ/GwCIXmSTzbTVeq91q8KzIaioOhjs0oW4iICrVDSKj+PMCdacTK8peIjkrDOuzdJ1capbf67m7faYZytQsAwLvB61Y0Wuv+VIKdQvgN31y2eEaEHm3ZdtxGB5SBFXJVxf16aCgKurc2ZNf2zG4wC2gsxNxwhq+3KR7U/cWXcyrolTP03mcx2mL3awNTN9lKxJcL8oQaiM5/8Tie/1YFX+EhYMH3zAjuP/DY7L59Flr+AuCuIJJkQ8awtcBRLA9cihrSqiM3fEBHe9k1sCCJWdcN0Eqb2gbMJOyOxt5ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NUoRa6qj0cObf+GmZffT9sqxNvgh85m46Vsc4QBF2ZC5DfQw+ygbz/zUA+/n1CUH4mu4QzbTp9I5Ap+NJ4xTM+XAIHZfxWydn1nUEGbDL2uMAzTMC0DGzh6NGpqUPvuTfpxZbtvBoy9cqVNxDmU/II6UFpvjFo8/N8xcTk6OEQS3ZAYPCsurZk9Uhi7oRD3O65/xIxlbb+mdoD4wesjNoVvDSFueKZ30LXedJfN5cGVIh6WeGZlKty5h3oTXqRn0UTs4KOB/Cmw5usAWYb+/WJho8HFqzcprsMuQ41c91xiTj+X3P6oPnkgOQulUymFOKC0ZUkjEgN2VNgQ88D4A6AoRGVS8PvkOViol+aej3o7stvnvFbmnd69WismQUuJus1mrOyJYpIr9U7X24T8425SSoIgURqlNfVEhVjyObgpUGOv4RZsihO9AMoChJR82
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:24.9419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac63916-6661-4a76-b8ea-08deffbb5906
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
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

From: Felix Kuehling <felix.kuehling@amd.com>

To set the virtual pod configuration to PSP.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 42 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  4 +++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1d78d8589f54a..cbd85b27c6f6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -833,6 +833,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "UAL_GET_CONFIG";
 	case GFX_CMD_ID_UAL_SET_PPOD_CONFIG:
 		return "UAL_SET_PPOD_CONFIG";
+	case GFX_CMD_ID_UAL_SET_VPOD_CONFIG:
+		return "UAL_SET_VPOD_CONFIG";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1315,6 +1317,46 @@ int psp_ual_set_ppod_config(struct psp_context *psp, uint32_t intf_ver,
 	return ret;
 }
 
+int psp_ual_set_vpod_config(struct psp_context *psp, uint32_t intf_ver,
+			    const struct amdgpu_ualink_vpod_config *config)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	int ret;
+
+	/* TBD check interface version 1.x */
+	if (intf_ver > 0x1ffff) {
+		pr_warn("PSP UAL interface version mismatch: 0x%x\n", intf_ver);
+		return -EOPNOTSUPP;
+	}
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id = GFX_CMD_ID_UAL_SET_VPOD_CONFIG;
+	cmd->cmd.cmd_set_vpod_config_ual.addr_mode =
+		(enum psp_gfx_ual_npa_address_mode)config->vpod.addr_mode;
+	cmd->cmd.cmd_set_vpod_config_ual.vpod_id = config->vpod.id;
+	cmd->cmd.cmd_set_vpod_config_ual.vpod_size = config->vpod.size;
+
+	bitmap_to_arr32(cmd->cmd.cmd_set_vpod_config_ual.vpod_active_accelerators,
+			config->vpod.active_accel_bits,
+			min(AMDGPU_UALINK_ACCEL_MAX, PSP_GFX_UAL_MAX_ACC_BIT_MASK*32));
+	/* Clear any remaining accelerator bits */
+	if (PSP_GFX_UAL_MAX_ACC_BIT_MASK > DIV_ROUND_UP(AMDGPU_UALINK_ACCEL_MAX, 32))
+		memset(cmd->cmd.cmd_set_vpod_config_ual.vpod_active_accelerators +
+		       DIV_ROUND_UP(AMDGPU_UALINK_ACCEL_MAX, 32), 0,
+		       (PSP_GFX_UAL_MAX_ACC_BIT_MASK -
+			DIV_ROUND_UP(AMDGPU_UALINK_ACCEL_MAX, 32)) * sizeof(u32));
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	if (!ret && cmd->resp.status)
+		ret = -EINVAL;
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 int psp_update_fw_reservation(struct psp_context *psp)
 {
 	int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index b65ac4f825d75..d3bc3ba30599c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -708,6 +708,7 @@ int amdgpu_psp_irq_mgr_register(
 
 struct amdgpu_ualink_info;
 struct amdgpu_ualink_ppod_setup;
+struct amdgpu_ualink_vpod_config;
 
 int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver);
 
@@ -717,4 +718,7 @@ int psp_ual_query_info(struct psp_context *psp, uint32_t intf_ver,
 int psp_ual_set_ppod_config(struct psp_context *psp, uint32_t intf_ver,
 			    const struct amdgpu_ualink_ppod_setup *setup);
 
+int psp_ual_set_vpod_config(struct psp_context *psp, uint32_t intf_ver,
+			    const struct amdgpu_ualink_vpod_config *config);
+
 #endif
-- 
2.55.0


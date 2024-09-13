Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B28FA372B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 08:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DF410ECC0;
	Fri, 13 Sep 2024 08:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QvOA9Yyt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC4D10ECCD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 08:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsASahU1xmEfFOUFsYSFMhl29NCxQMoUG5BiCEmk8tIVoseYKUx23EQvPTgL4pSqQhmFs9V+fT0ila6fDvQ+EEFuOJu/NyeT0BUi/NtXS1vvce2JZzngunJRIUaNB0pBAO2xTe0qQzLHC7XQBRwmbN0kDkVsLEO4XDkM9SJLsDQ41q9SdJe2ApbcB+5tYW/GP0tjlNTfSIStCWxXokYER3s55n/v6oGRyJ8sQ93f24aeA/LMN4zeNyBnVhHtCZUjJ9ZrH3tWN+KVRXoR0uPWK4eLGb3YrfAK0KvzBkyeHNwjwmXknSlDLPTVfo3kxL58RONnzEQj5VPeSrjfbg13ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otXe83iYxT6jmR4w+YMlrAuvL5HiVxDQFdbG9WMPaF8=;
 b=AeHMcENp0XTC37Y/efYmgWAOB9la1337rlr3NNiltcy24Xb/U47xclQ3qIg2lqpiRmxJ0Xj18eJT+zDRg+DdZ4UF9LXAWH4JlvKeMbnl35OZ1ihSnTNla9V6iS57Rck9rV3o5GsOrKUgJjQGozgg9+yLIOHPuih/vnpKfLa4cY55IXKCMay815Hd72U49/ORL+TI2Vkug+GolrcjisPfC6k1OydUcZXDL9KUOCCZK2u+1/g3zwmWJjzvLEbf4VDk3MdaVWk5LguFJCGozNUGarbqQn4898xRN+/MzIwl1Kly1+owkyrx4M2NMe5/NNTlhkMsnNj6aK+kUxD6pEb6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otXe83iYxT6jmR4w+YMlrAuvL5HiVxDQFdbG9WMPaF8=;
 b=QvOA9Yytt4d9epVuNESQd3edJMZ6xPcP+pCojIho5+/apWZMTVQuP5qqLWtzh4Fx0xCsrsTpEUVeMAjzfECZYQmwdor+pawFtjjduWDTvao/eCmBfNGUn37eVTF3tJdSu/yI0kMNm3ZfYdbd4qvTP5VUL9oi1BPwi4DJypNCpaQ=
Received: from BN9PR03CA0369.namprd03.prod.outlook.com (2603:10b6:408:f7::14)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.31; Fri, 13 Sep
 2024 08:32:49 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::c) by BN9PR03CA0369.outlook.office365.com
 (2603:10b6:408:f7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 08:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Fri, 13 Sep 2024 08:32:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 03:32:48 -0500
Received: from fc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 03:32:47 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Lijo Lazar" <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add psp command CONFIG_SQ_PERFMON
Date: Fri, 13 Sep 2024 16:32:33 +0800
Message-ID: <20240913083234.54001-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Feifei.Xu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c8494b-a3ff-4440-08db-08dcd3cea6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?REbUfY4PGsbdc9mFwLoEQVqvKEqTKnh52o33LPb/kqtEraFJE884+S3EMema?=
 =?us-ascii?Q?hxJv6DwHjF6nDF1Y3Be4wHhpiwx3AGWihRA1RoqbhWWXTDGlG+MSGMBUvm7O?=
 =?us-ascii?Q?36ou4Hd7qgAiGPxBK7X7PlWhu2nZJcMRrgHYFALIuKPzd72lqIoNUS3mR74y?=
 =?us-ascii?Q?N4dEZBk1dgxCo5oUtOrUU0ykZXE+gDO/y1uo9M1m/ozLvethEvYyK8hGhZ1G?=
 =?us-ascii?Q?SyD/7SGeShmpTz2e8IOBvIpk4q3a11+QSmKgpT/HIruprew7VgNGynSiJrZH?=
 =?us-ascii?Q?NizWltvN82C6TGkjAjKRIFVqRYX3D1yg8hounY4PXxdwgfK7Ul0G9qEawPx0?=
 =?us-ascii?Q?u0EXa6/qeBFkdLnG+iJvt9kK5nIU2pdRxFJ8be5GjzvjeKM/BkB2L+7bTmm4?=
 =?us-ascii?Q?CCtqro1/8FTj0PNr2OaWdFbprVWEsnOf3JC/oy9sKIGxK1GQxaJCnlp2dgsp?=
 =?us-ascii?Q?cN3kcupBLZ6i7whvSPnBVo72KfqEMtpXcNm4qVmR/deWmtIXiAEb4u/FTCkO?=
 =?us-ascii?Q?4we3u+j4lqip4Pt2JerCYjSEP1N9RrugEPQU/NrxPdzqNY+VXrVl1DxjmC7V?=
 =?us-ascii?Q?nS7WA+nmjaVrcrQvzJ9s2y5702x0sWaHKH4GsOyJWSiGhxg7FELINMiBQRto?=
 =?us-ascii?Q?ZiCu7awYkiHP745P2fsTSIE+XZ/Yqejdc3nyZ71oWZIX1R7c6g05deZ2R2W0?=
 =?us-ascii?Q?xocdQpvjtH+h/ZznRjXamkjlpAgWmZIC45Yrus8pfBBTEUzb1LuhtMOggyu8?=
 =?us-ascii?Q?M+TL9iLrjaLosJhFcLu4t/KoCxLuiojd8eQE9Mr2uLCR4jRhWxueofOPivW0?=
 =?us-ascii?Q?Znm4dp2XS4Bt9+LiMPiTtvuGt+RSPuOCJ5YbRAvI32FpMWxjXH7FNwusmLto?=
 =?us-ascii?Q?x+9S0fBpJc0gVXpmtsQPKpF3AXR5yv6e7+InP+cQGNV2uQpygi/8ge3Fec8f?=
 =?us-ascii?Q?3ytiX9+hbo+gHJRG6hutPL3ZEzmbFdagJlmqtgA8ukZHD1UObIjdSsoqXjjf?=
 =?us-ascii?Q?Iw2rxOL07uta1C5eEoDdC0nb/g1RC94Dev9ml6gqGfWxzi51F2fjNdVwFd+G?=
 =?us-ascii?Q?g3YbbyF1d0ET0o3IKl40W4eNgIbAp9xsKxEugJko0skSN8k4uBK8iqWh1aBM?=
 =?us-ascii?Q?y8ALualbtFg/XpESlujAa64ifCgHkEEd1hXR27Csv5eUycd9vm4ILMGRv17W?=
 =?us-ascii?Q?hXT6nUfqknpSgIa3ctTKY51OodKNHW3TVhNMPzjvJEQdyXQv8ECZzFY/t74a?=
 =?us-ascii?Q?bm02lyiVXrfQ/5BKJOhaHTRnCn/ocSr5cm7/gr1w3vGzpsSGoQ8oVgCfGIof?=
 =?us-ascii?Q?KCStRjhOfjmMd5SxDgXJUaJAKNzJCXz1FPkzE8pplwBuqnsU2RFFz1sn66m9?=
 =?us-ascii?Q?oNunNB8QcFNiSwgMPBuU7vikFskhhQCO1uqWuWA4ku56SaLfocwnKw/jpJl+?=
 =?us-ascii?Q?0Q11opEy/vwy6vy1YPrqo3UWtY3pNUbf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 08:32:49.6000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c8494b-a3ff-4440-08db-08dcd3cea6e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
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

Add support for enable/disable perfmon profiling.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 38 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 12 ++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e9e599ff3bd4..390f7aecf59c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -639,6 +639,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "AUTOLOAD_RLC";
 	case GFX_CMD_ID_BOOT_CFG:
 		return "BOOT_CFG";
+	case GFX_CMD_ID_CONFIG_SQ_PERFMON:
+		return "CONFIG_SQ_PERFMON";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -3719,6 +3721,42 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 	return err;
 }
 
+int psp_config_sq_perfmon(struct psp_context *psp,
+		uint32_t xcp_id, bool core_override_enable,
+		bool reg_override_enable, bool perfmon_override_enable)
+{
+    int ret;
+
+    if (amdgpu_sriov_vf(psp->adev))
+		return 0;
+
+    if (xcp_id > MAX_XCP) {
+	    dev_err(psp->adev->dev, "invalid xcp_id %d\n", xcp_id);
+		return -EINVAL;
+	}
+
+	if (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6)) {
+		dev_err(psp->adev->dev, "Unsupported MP0 version 0x%x for CONFIG_SQ_PERFMON command\n",
+			amdgpu_ip_version(psp->adev, MP0_HWIP, 0));
+		return -EINVAL;
+	}
+    struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
+
+    cmd->cmd_id	=	GFX_CMD_ID_CONFIG_SQ_PERFMON;
+    cmd->cmd.config_sq_perfmon.gfx_xcp_mask	=	BIT_MASK(xcp_id);
+    cmd->cmd.config_sq_perfmon.core_override	=	core_override_enable;
+    cmd->cmd.config_sq_perfmon.reg_override	=	reg_override_enable;
+    cmd->cmd.config_sq_perfmon.perfmon_override = perfmon_override_enable;
+
+    ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+    if (ret)
+		dev_warn(psp->adev->dev, "PSP failed to config sq: xcp%d core%d reg%d perfmon%d\n",
+			xcp_id, core_override_enable, reg_override_enable, perfmon_override_enable);
+
+    release_psp_cmd_buf(psp);
+    return ret;
+}
+
 static int psp_set_clockgating_state(void *handle,
 				     enum amd_clockgating_state state)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 74a96516c913..4cabfb7cac8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -553,4 +553,8 @@ int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
 bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
+
+int psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcp_id,
+	bool core_override_enable, 	bool reg_override_enable, bool perfmon_override_enable);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 37b5ddd6f13b..18717afc5f64 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -103,6 +103,8 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_AUTOLOAD_RLC       = 0x00000021,   /* Indicates all graphics fw loaded, start RLC autoload */
     GFX_CMD_ID_BOOT_CFG           = 0x00000022,   /* Boot Config */
     GFX_CMD_ID_SRIOV_SPATIAL_PART = 0x00000027,   /* Configure spatial partitioning mode */
+    /*IDs of performance monitoring/profiling*/
+    GFX_CMD_ID_CONFIG_SQ_PERFMON = 0x00000046,   /* Config CGTT_SQ_CLK_CTRL */
 };
 
 /* PSP boot config sub-commands */
@@ -351,6 +353,15 @@ struct psp_gfx_cmd_sriov_spatial_part {
 	uint32_t override_this_aid;
 };
 
+/*Structure for sq performance monitoring/profiling enable/disable*/
+struct psp_gfx_cmd_config_sq_perfmon {
+	uint32_t        gfx_xcp_mask;
+	uint8_t         core_override;
+	uint8_t         reg_override;
+	uint8_t         perfmon_override;
+	uint8_t         reserved[5];
+};
+
 /* All GFX ring buffer commands. */
 union psp_gfx_commands
 {
@@ -365,6 +376,7 @@ union psp_gfx_commands
     struct psp_gfx_cmd_load_toc         cmd_load_toc;
     struct psp_gfx_cmd_boot_cfg         boot_cfg;
     struct psp_gfx_cmd_sriov_spatial_part cmd_spatial_part;
+    struct psp_gfx_cmd_config_sq_perfmon config_sq_perfmon;
 };
 
 struct psp_gfx_uresp_reserved
-- 
2.34.1


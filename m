Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A91C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE1210EA4E;
	Mon, 31 Aug 2026 18:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EtDuIXbT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F3E10E654
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fX/VU3KBVkwKpFeemdsC4b3T1nuagn1vtW/H2pLdJObicTxrI1OgL4aQdCHw0H1z/xFZ5yYPkeBMOGmZH8e9JsFf1rPgiirLnIQ4Y/ih8iq61KhgAdiolD3jV1eMn7NYHAyc0CW0SUuTg4V6gbyRK5UIenoFsoQRtPM2AjanPq3c5OjPY+9MIPaLWx8HD/32RMSUQ/3BSFBPHStcPAvB8LhcvBiKCJ/drBDAL/Qb4m/qdRqq3LnLL03eIMPsm9xCBdvJepLI0gdCoRWH0TnYJfWKcZuNTdvxai/gLjpR8p2ybpWDAO3t9asOcnT3H6hAys5wu+0ZaOxkfUntp8j12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5RzxKaflnJm02nEiz9MQ9SJmOe0VaLcFTUuuWkHEzE=;
 b=uaSo0gy+ORAKHf4UkmMUpo7eAbsL6SYoU+yrE5p52Y2W8ZioG2zhMTOQVZGkhtGUOIrKeLZVt4xqmKydLNrUaCYa20Ku9SNT2AoGXXeIks2kgyEPs7Xv+2WUV/a8feJdTyyoKIl6KDbGf/MYTyCCSROvx00v0x1JCfpPYuRX3XREqwaHFowr3OMdB49JS5OHJ7gW08eQEWXsc4wU7nodYKmkwHyssMlQfi0jbVexyLyVQvOpAO4SVvQWceHJuPY/IaviZvGu0SJVAyT6SB9kyS0fDNy9OWoWGOUfuGvgbYQavex9qfON9vFC8x2uISDhWYsRlxeALuJEk3TZSx5iCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5RzxKaflnJm02nEiz9MQ9SJmOe0VaLcFTUuuWkHEzE=;
 b=EtDuIXbTc7DTQqjBKJqiplV43b1IE+DWIz3kkxDCKTyZNbl09MxpIruT7Cm600MyxQBDUxVpaMknubxdCNJ7UEwxmf5YVx+j8h7X+i+KUforwkQ16vt0tNvnBTjX3t+ZNpTK3b8Df9RoEliQISsTlIS53+qMisSpqL1+oRM8f8k=
Received: from BN1PR14CA0028.namprd14.prod.outlook.com (2603:10b6:408:e3::33)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:24 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::53) by BN1PR14CA0028.outlook.office365.com
 (2603:10b6:408:e3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/95] drm/amdgpu: Implement PSP cmd UAL_SET_PPOD_CONFIG
Date: Mon, 31 Aug 2026 14:26:29 -0400
Message-ID: <20260831182754.1089811-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb421a3-b0f7-4777-4b3d-08df078da455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GzAoZXk1yjxKPBat8+BcakelrTWAKfgFi7ZW/D8DbjX8EH8TdwbXUlMGI70KHLKj6B6dZ4lxlscOr9ylGTCC5HK1IvxKayjJbSkKeAEd/zA2UUt0aeoch3iGDi2bUtMhVJAZLY9za1i8mG+W+GObkpfTZ8c4FEtX9JaSuZXqufH5cxuX1z88JdN/YgceHMuIqHSOmHxG/hTGJKBO8O0HSsqWb5idpRyMAZmLOLnx87gN8HHQF7uJSfEYjroyWTd9GE5WL+LmEFJEfkpOHAI4kJWciJbZzZTmtpvH83dUPnZy5ob3cglPkisNphTj05j5Q6by5pmCQ8cMQd9jLOAgaG5Zb1/VLIud3B0rO9ZYSl0WqLZGm9IXLvSHwTNRWGoTlr+O1au+StE20JyqufKA8Q08kyUAEnwuEM6MSHIp/AaawgY5yU0b6/qiCWItrL8QSOu7tfKXA+nvuYxR/gZ4ZQWqccem2DHQTa5rANuCgUmP3+LwE1+Suyi4Hg6gZ9vDMHcS76RXnbo0QHEkiTk/Gy1c1tDloutuYlheLZzWyAChRoKcDTkinXq+ZHB1bi1UTtVQKdYM1Qcvd8PDP6UF9L5ry6v0HBkg50V/bt0zItu5k4B605sFDi+kt7IdQjidujJ3K3ZtQiEgR//GUSA+7v9+fnydJOltq8lZObEwR7AC7bZsls6syD58DY4JTp2aO4wixP1HaTitIClRV7EP2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ld4guthVsOoVVKWGp/Kpa/CfHiKCKcPLwY9l1+q5GRsREAZnTSd4sLYK0oEPVOp7EkKyWNI7XNGYduQOYLIIh/Z2i1aakjKeGcecYvR3LcAgeCxs16Ly3SaskgSBORPqiqs89nc0mK3llFV9NJc8GkdWjCI2VBhd9QooMp7Wo8Lqfzfx6NhIFMYJXyJn9J+VRLOv84AL+s2xdFMRTmy+PlIToall1aYiof9mT/PQr+bnJOwZrBsT3tedwBHbuo8UEippzb7rytq9qXhJ4NmnCCBXaWEWLCfqppylQ3EbeQPrLibe1CDSao+QSGkMwDZ2pA0Fusc9jsq1jT+XkyiTUoRcAaWGc/xor2v0IJtcud3eDStPVpj31y+l29hVXZj0LbnVUUzpLg/Io0n5sayyLUzeV9cxBSDrkcuH3kaocdPql7DNTqmjcG2/OkXqhwp7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:23.8309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb421a3-b0f7-4777-4b3d-08df078da455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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

To set the physical pod configuration to PSP.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 45 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  4 +++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 006ec1a241f48..1d78d8589f54a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -831,6 +831,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "UAL_GET_INTERFACE_VER";
 	case GFX_CMD_ID_UAL_GET_CONFIG:
 		return "UAL_GET_CONFIG";
+	case GFX_CMD_ID_UAL_SET_PPOD_CONFIG:
+		return "UAL_SET_PPOD_CONFIG";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1270,6 +1272,49 @@ int psp_ual_query_info(struct psp_context *psp, uint32_t intf_ver,
 	return ret;
 }
 
+int psp_ual_set_ppod_config(struct psp_context *psp, uint32_t intf_ver,
+			    const struct amdgpu_ualink_ppod_setup *setup)
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
+	cmd->cmd_id = GFX_CMD_ID_UAL_SET_PPOD_CONFIG;
+	cmd->cmd.cmd_set_ppod_config_ual.accelerator_id = setup->ppod.accel_id;
+	memcpy(cmd->cmd.cmd_set_ppod_config_ual.ppod_id, &setup->ppod.id,
+	       sizeof(cmd->cmd.cmd_set_ppod_config_ual.ppod_id));
+	cmd->cmd.cmd_set_ppod_config_ual.ppod_size = setup->ppod.size;
+	cmd->cmd.cmd_set_ppod_config_ual.bandwidth = setup->ppod.bandwidth;
+	cmd->cmd.cmd_set_ppod_config_ual.latency = setup->ppod.latency;
+
+	memcpy(cmd->cmd.cmd_set_ppod_config_ual.local_accelerators,
+	       setup->local_accels,
+	       min(sizeof(cmd->cmd.cmd_set_ppod_config_ual.local_accelerators),
+		   setup->n_local_accels * sizeof(u32)));
+	/* Fill the remainder of the array with invalid accelerator IDs */
+	if (sizeof(cmd->cmd.cmd_set_ppod_config_ual.local_accelerators) >
+	    setup->n_local_accels * sizeof(u32))
+		memset(&cmd->cmd.cmd_set_ppod_config_ual.local_accelerators[setup->n_local_accels],
+		       0xff, sizeof(cmd->cmd.cmd_set_ppod_config_ual.local_accelerators) -
+		       setup->n_local_accels * sizeof(u32));
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
index 66b57c871e1a5..b65ac4f825d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -707,10 +707,14 @@ int amdgpu_psp_irq_mgr_register(
 	const struct amdgpu_psp_irq_handler *default_handler);
 
 struct amdgpu_ualink_info;
+struct amdgpu_ualink_ppod_setup;
 
 int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver);
 
 int psp_ual_query_info(struct psp_context *psp, uint32_t intf_ver,
 		       struct amdgpu_ualink_info *info);
 
+int psp_ual_set_ppod_config(struct psp_context *psp, uint32_t intf_ver,
+			    const struct amdgpu_ualink_ppod_setup *setup);
+
 #endif
-- 
2.55.0


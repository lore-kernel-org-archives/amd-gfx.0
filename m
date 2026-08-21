Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C154C5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2297310F3E2;
	Fri, 21 Aug 2026 19:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mvTtBQst";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5171210F3CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8DOtCDdjxjdu2baJNW/ZLrBIrn/UwFQo8C0l0Qyvs+HktVdqvMk7pvdZOuhzfkprunaGeFp17Ii+840fFazBXwTf+jL0KZBglLj1wr7VpNhkfrDEnPGePR8FQ/E9ZdJy8GCd31UUEqZ4emWBimPzvdapJZSwQJYJuP6A1PfK7fFHqOY4GRt5xhCEOYVSs5sWoVkqIMd/1YcZUMVkFWmWMZuECOp9rdDLLg5wandHVHjzb5QijTssQNUFViBJplZnUNsCRfsPaRTqpX4D8SCq8siEeqU2CXNDvIMS9MnePHshgnHLoN6A6+W1ABnmiVjd0uj3OSISHfP+w5EFHfCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p1iOdJtkHuMrgDTfLYDfpFIdvp+d2O60Uf9S5M2YwM=;
 b=lH+jTbJIq5JxNO3ZawP+Y5ini6pCUApK9ZmKfbmsunROd075DK5fLoWk6+/sf96zswNzJ2+uXFqbzeEvRPCF39SkYu0xObDidT6SZwp71B24IKSabiSVKXm8Y810J1e5Q8hIfZIEEFiClaiKsAHbmKqB8Nv+4yHFa3vxg6Dfjgzx3O5OPUP7kxd30YBdJUdiaXCivO7ey84yqegD0kt556uvkgyyrgZs4u0XjPaBxvx+UZSH2vxB7/7BmM+Tn1Pcfq4A0x6iVPJruxyt5HfDKzPESGby7MrwG3BG2PfqqLbAOdPQ7QAVwgeKvOfUHD9bXzBpu7qRMaXvcjSV0fEJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p1iOdJtkHuMrgDTfLYDfpFIdvp+d2O60Uf9S5M2YwM=;
 b=mvTtBQsthYRhx+vIcUvlQ3ITeem5lRCJ9jr/IBOAw8fnXyS2ifyaCQ0zhFekxbEBWOTD1Mbl3moTyLiC7aZpvz6eDSNTv/mSW/qrOjEp5oBJwAiN7E+dyQfjmZWzJCFKVVDTmgZcZFpb4OZE7GmZ4vHcCmAiCaS9BQeJWET94ps=
Received: from MW4PR04CA0042.namprd04.prod.outlook.com (2603:10b6:303:6a::17)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 19:35:23 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::37) by MW4PR04CA0042.outlook.office365.com
 (2603:10b6:303:6a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/95] drm/amdgpu: Implement PSP cmd UAL_GET_CONFIG
Date: Fri, 21 Aug 2026 15:33:31 -0400
Message-ID: <20260821193458.808626-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 21904809-b377-4f33-e849-08deffbb56ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: R/CbOQpqpu2InHAvJQJgyJjIok9enEJ7b087M59o9Xxm9qhcqm0prHXVW0vfF1kqffZCkGbkIYunlrKOyz7qhOZmENuXGLDGQFTBrYmjyVjdtYTc+VhLho1THChgmouDeaWQxO49YM40B08oij5Ln/B0b43exLtXjQ+Jk9AmBBXfDIY5dwdkPFNC4lS7jBUmTz0Ukh6N/ZfiAE2q7cG7aO0reOjvaQ8LuYGJ5Ii4932QeestmHDuImrCmOwnhzwE0WQOVW9TawGqOgqQwAMHkHo8Xjipo5Jb4Pl+ZQrczTr3h0FUuyuDdytqIqR00BXbboB2nvNoApqwYykip0yNe4ZyciXk+TTLZrQzTeK49j1sNvpL+tPEI7LyMJGMFOycw/AVmKydcQe/7lijuLPOOFkFgH18VAV8NqHGXKATtFOkz18bCK1vL9SBCs1fdLqogSEFa2h0u2DlOUdR+Hs9gBd4lIqRP7J84bQSrESrdh5cS2KFweMwtUWN9VseWsFiKPjNc920z8YazLBWQFhsnnHS4/lPb3UG84SdLhL3oJuRMQ/AlJ8hl2MH0tgiNVMF5dtYsxw908JuUjdncf5oYEGgZOJlqknXHb1zT+aH4hTdmKmbNaO7oad8rtPh9tsrTRx+vWEhHVXVGsZpucp1dkuPpA9moKkUzub76RCN57LLH4NJEzsxvsy3GwxZ6nhvBRuQhHivyZsstpn9wzaWGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dyHxHUuhFZ3XSN7qLfybCptq1QAv5dYa+vSUqzdm8SqIwQuvjBcoyCfkedGnGlRB9XQaxoln7yeMPxUlUgYchAILhEZFizvvn3hIy90AVE7aiIUL5FevFKNyJAUPTaK3kJ1giiURpsCpXtY+xGx/fU/lGS8JluNQyeXoKz2uNlHcf7xkrsPX5T/X7jXFAa2CrqbOsqKnbiVBr3EMPiW/uFNBa7cKqdeCk9CJI9cf8tyWTS321HG2eFD73xLQCMdflaMfSGvMPssFuGXDeMuGIMpl2bU2UP4Q30hBPX/vG0iPkZx/jDPWIUUOpXuDQSm+QpkgZv5Sa+gQfStjewmW3v1jv38uza/1yji3tLb+6eXd8gfQvdcd7+TQgDqP3vMAp++7meEwVMfuARL6RSJ1woXx2+wlJ+pUBGB4QLGw3GR7xqGSy7YgySWaZzdo7qKH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:21.4210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21904809-b377-4f33-e849-08deffbb56ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
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

To query UALink configuration information from PSP.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 58 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 +++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 5c82d1d808157..006ec1a241f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -829,6 +829,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "PERF MONITORING HW";
 	case GFX_CMD_ID_UAL_GET_INTERFACE_VER:
 		return "UAL_GET_INTERFACE_VER";
+	case GFX_CMD_ID_UAL_GET_CONFIG:
+		return "UAL_GET_CONFIG";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1212,6 +1214,62 @@ int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver)
 	return ret;
 }
 
+int psp_ual_query_info(struct psp_context *psp, uint32_t intf_ver,
+		       struct amdgpu_ualink_info *info)
+{
+	struct psp_gfx_get_config_ual_v1 *ual_config;
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
+	ual_config = psp->cmd_ext_resp_mem;
+
+	cmd->cmd_id = GFX_CMD_ID_UAL_GET_CONFIG;
+	cmd->cmd.cmd_get_config_ual.ual_cfg_addr_lo = lower_32_bits(psp->cmd_ext_resp_mc_addr);
+	cmd->cmd.cmd_get_config_ual.ual_cfg_addr_hi = upper_32_bits(psp->cmd_ext_resp_mc_addr);
+	cmd->cmd.cmd_get_config_ual.ual_cfg_size = sizeof(*ual_config);
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	if (!ret && !cmd->resp.status) {
+		WARN_ON(cmd->resp.uresp.get_config_ual.resp_size < sizeof(*ual_config));
+
+		info->link_type = (enum amdgpu_ualink_type)ual_config->link_type;
+
+		info->ppod.accel_id = ual_config->accelerator_id;
+		info->ppod.bandwidth = ual_config->bandwidth;
+		info->ppod.latency = ual_config->latency;
+		info->ppod.size = ual_config->ppod_size;
+		memcpy(&info->ppod.id, ual_config->ppod_id, sizeof(info->ppod.id));
+
+		info->vpod.id = ual_config->vpod_id;
+		info->vpod.size = ual_config->vpod_size;
+		info->vpod.addr_mode = ual_config->addr_mode;
+		bitmap_from_arr32(info->vpod.active_accel_bits,
+				  ual_config->vpod_active_accelerators,
+				  min(AMDGPU_UALINK_ACCEL_MAX, PSP_GFX_UAL_MAX_ACC_BIT_MASK*32));
+		/* Ensure no uninitialized data in the bitmap, even if these
+		 * constants change in the future.
+		 */
+		if (AMDGPU_UALINK_ACCEL_MAX > PSP_GFX_UAL_MAX_ACC_BIT_MASK*32)
+			bitmap_clear(info->vpod.active_accel_bits, PSP_GFX_UAL_MAX_ACC_BIT_MASK*32,
+				     AMDGPU_UALINK_ACCEL_MAX - PSP_GFX_UAL_MAX_ACC_BIT_MASK*32);
+	} else if (!ret) {
+		ret = -EINVAL;
+	}
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
index 5968595647fef..66b57c871e1a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -705,6 +705,12 @@ int amdgpu_psp_irq_mgr_register(
 	struct amdgpu_psp_irq_mgr *mgr,
 	const struct amdgpu_psp_irq_handler *handlers, int count,
 	const struct amdgpu_psp_irq_handler *default_handler);
+
+struct amdgpu_ualink_info;
+
 int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver);
 
+int psp_ual_query_info(struct psp_context *psp, uint32_t intf_ver,
+		       struct amdgpu_ualink_info *info);
+
 #endif
-- 
2.55.0


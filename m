Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D66C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDCF10F3D9;
	Fri, 21 Aug 2026 19:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEXb3BFT";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B4110F3CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cbf8A0uukZ+7Hll1ZDB0prJkVrIPzlEJpgWMXxm7qyrGuzw7dvodVdOKzSKCfyd/XttZCerLxG5S5RxolOGhqKwc9Lv/eb2X27vwDnRFIJa+xWF29gp8JwFUBGuv8YXZbIiCZEBUi5SRqeKs81FwwxNOPOkP7E+DRsm2JqWFxXlkej/h5OJVzh/bK8eFDpWQxqmtXKe17fcXFTlbduqUfxo8x8WvSsebu5WguUZ4CrBwITiKNfzvFPGEVD2hHAMr5+iIBwv84VfOPdYPMpwJ37y4xOl6Q5y1mmrkaeYPrImlgPOJhQpgKKqxr1ZxEGumSN1r6P7te/JRNZ0ooYA7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZy7Bx1krt/K0mLIVSYBYuBxgW7BnKBp5Fs8aEv7WGs=;
 b=rjD+55Ze7Y6RBkuYFP7o6SD7yAbOSFSCsLZHwsytNqXRozxhFGlT9C6TZXY2R5uI0zqn8hgCSJVfdZd9LNyPH1+SM8l5ypJ4rOK3z1CyZ4wdXIxPCvrUkRV19Xp2aCCDe9e0eotcRxxy/uIlpLEK2Ify36kdZmQ9xXfKpkx7zlGOA/hxKgcobuehACOII8T/U3UdUA8k9W5itzxRPSvSYx0ArEJso+VV3g0XfSmlsJeerFFtRTAbAXSebQ7tbV6LMufl1TDQUGJj/OrZgabKTcUgtn0eG91UudVWugh+UPpZLI5IfmEqotgiyZWlfcIFhxXzcnnTRyORuYUg8oRIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZy7Bx1krt/K0mLIVSYBYuBxgW7BnKBp5Fs8aEv7WGs=;
 b=BEXb3BFTxjtvvjAJDgUftoupkRCYik1XMcZB12C5Cw4JLbVhNCtZD/vjYzKoZjxVc01DInbgTpv8NpA98CNULsjxx76oxCuurEBkTDA0X2So1TCm5ptqPS8vr+kOBjTxoHE+zMpLS+DWc4p93nEaX3TSZZoK4CgKwq4BzUco/kM=
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:27 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::b) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/95] drm/amdgpu: Implement PSP cmd UAL_SET_NPA_CONFIG
Date: Fri, 21 Aug 2026 15:33:39 -0400
Message-ID: <20260821193458.808626-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 908f900f-4408-4306-8411-08deffbb5a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 4IyTIHPugwF3qgcPlysWgcbPpastltKVZPIUX0uez2gzmBqLzAY78zs2WK3OXdJ4uTm1RIDPeQ0oTBSavYgSOy3eh/XwUzi6MY1CzV5zKm1qNlwC9UKqUmBjKQ6PE4EqHdbtUUaXkcU4QK3wNPyNE3d1Zqe8c+g9TgD3OD6HznSFHY0MiN2Qhnvq+psN8eCgNb9cyrFY2s3e/p4Wq+OAhYJaVuECc9rBlS2bPfgFAfzHWzTsSZxDAzWFxkJ/KFnqDIO9/VCLUx39nAmMfFAtnq+ZZKI+ruWdYxxoPFJuKpbjhxpQv8VgcdCjvLjiD7pdm71aHbdRI7Rxt0L5YAx0rqzPgqZpPisUPP0l4pxqDozXRULEgMB0i84dn4jVGt2VY2lcUDDZVXnX42iL8rcVNPSnZ4b962YQRk31kxSX72fIVpwkfXFHba9v18n8M9iiYG402cDs/xHW4VViaP6o7tJFOPXswfybI/gtJrXCpQXm6yNjT8zKG8aDUpP8xX2j8juoA4ceVkIN06Enm8LyTL1u64NyNevJ36BhsYpdCNAmldsoqZoI5KplJmlayHRuxdEH+isBehGgycH5AyJ3tdA1egba9G4mBRqymS+jnE8uHoFpDO30NEfGD825Fcq010uZMLS/VD1wHvjbrdSiqGG/1MwLwdm+Y5vsR3MdgCvG7IAhUKECP9Pn9DzQezrjaf5w317EZ9C2KWxC3S+mzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b4E2NKN13cvkKBNYo9+rORR+oVFRifQrt++qImldFRRhSZKPzURERwZTiX7pNtFZk4fD++AmBOr7gltU8UHvj1x6V5eKH5/3SxeLCLg+v0MSsqb+u22njFpJ3qTF1Z880lA9xalXxLBjx2m5rlu4oMUU2EBSuHcIVXCdHbNk3zabBvo3u8OsVKAd7THZ8ApVvAhejJPs0Cae2ln+A1NymTpBnCxaMXdNcznom1rc6dh1LLbUeMawXpCcHWbGY7PZfQa51XssinFAjL4ii8Zu2a08Sh21oAPuVMi6wZZQWRT4hl+l07/yAgdO/KI7l2WwglP9bwKK4gZQm5JsC2guhQN8Df6MlFrSY/K5RhznI6hT16Py65XGXjecmy7o7VjwWuOuh2T52F2jHHOwaqNnd8zoruKf/qR1f+6/rUPXKR7XiRnNFpyQmkj1jnO3FCV/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:27.1174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 908f900f-4408-4306-8411-08deffbb5a46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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

To set NPA translation configuration to PSP.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 30 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 47367ff8c3903..d68b1e5118732 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -837,6 +837,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "UAL_SET_VPOD_CONFIG";
 	case GFX_CMD_ID_UAL_SET_STATION_CONFIG:
 		return "UAL_SET_STATION_CONFIG";
+	case GFX_CMD_ID_UAL_SET_NPA_CONFIG:
+		return "UAL_SET_NPA_CONFIG";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1392,6 +1394,34 @@ int psp_ual_set_station_config(struct psp_context *psp, uint32_t intf_ver,
 	return ret;
 }
 
+int psp_ual_set_npa_config(struct psp_context *psp, uint32_t intf_ver,
+			   unsigned int vmid, bool enable)
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
+	cmd->cmd_id = GFX_CMD_ID_UAL_SET_NPA_CONFIG;
+	cmd->cmd.cmd_set_npa_config_ual.vmid = vmid;
+	cmd->cmd.cmd_set_npa_config_ual.enable_npa_translation = enable;
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
index 60ee3dc25113b..ee37170c1c2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -725,4 +725,7 @@ int psp_ual_set_vpod_config(struct psp_context *psp, uint32_t intf_ver,
 int psp_ual_set_station_config(struct psp_context *psp, uint32_t intf_ver,
 			       const struct amdgpu_ualink_station_config *stations);
 
+int psp_ual_set_npa_config(struct psp_context *psp, uint32_t intf_ver,
+			   unsigned int vmid, bool enable);
+
 #endif
-- 
2.55.0


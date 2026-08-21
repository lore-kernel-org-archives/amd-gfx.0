Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE83C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B3810F410;
	Fri, 21 Aug 2026 19:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fUm9kvGc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E67610F401
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGzzxL6SZeB2Jmt+X04uuu3VAGYBhzFltuOLTCus4uWbTb1qoupyPfkEkpKYuymP748C8ZNOoU5EnntPrSo/YFfUshBG6FSgWTQFEYmXHmva20/KLAw5BQ4fM7LhRs0uzg8QT1TiRe5+nabt5gzk0EPcFUGquT7RUJPTfp2Ljw1reIAP42a091lzti9LsgsSd27snyGCXvuOl0MLzJ0PipPEUeiqyKArD3QaTK7u2N4HL8ripw45k0iPfdmGcXGao7xUDfi1TrxU3sHjlGLt2QQXpDaioFJ0WvzKnyqI2jMnyCNxN26btJIJbjYR3Wk0y1apX0hnBm5G3kwkGnbjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5RzxKaflnJm02nEiz9MQ9SJmOe0VaLcFTUuuWkHEzE=;
 b=uLVufyV9Gpt6jEstDkow6MY04uPl5ucBDqYYmgZmLAg9hPKTolHeufS+jlwfnptrQ1OaiWEVs97pGJZZbZIbEqzj4mOq7gKqs+6S/Wi/LfoMuVqxbx4cXuAiXccSthpYedsovEGnI24d8NtLXF7F8WNMmdsqxoUuwGftXEmMGqWg4olpWRRqsGS7lDmiuEJRF2dElLNI86Zd6iVdGtNyfOpFRCHnM63G515UzBuzn6qwTqCbRTgRcJG5j+Tt7cFrfxCi5SpqMdcnSX4/VTcFz+DlfVlobbQ0i6EaON0zjVfEDiw4GD0cvXYm+Cnzssi4DpQ7+PvoUNgjqRyjrTxV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5RzxKaflnJm02nEiz9MQ9SJmOe0VaLcFTUuuWkHEzE=;
 b=fUm9kvGcUfQ03+bnR/9NeKa9vCpRpYlvOl7eTIp7R9PpkCk/6JszTpn4lG4bUTzvBx1GEc1MYfktozRyGd0iaJZJf1EW8ZgNh3NryRvNPKk/0dMBrY5Hdj+JhjxIgSAMzR7rj67Mtb9ZzE6CXjO4ko1vLJ8UoJSf2sH2da6dFVs=
Received: from CH0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:610:cc::18)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 21 Aug
 2026 19:35:25 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::a5) by CH0PR03CA0073.outlook.office365.com
 (2603:10b6:610:cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/95] drm/amdgpu: Implement PSP cmd UAL_SET_PPOD_CONFIG
Date: Fri, 21 Aug 2026 15:33:33 -0400
Message-ID: <20260821193458.808626-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec01b80-e219-4cc4-fb8c-08deffbb58ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|18002099003|22082099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: YXoFuhhZnlzehEaV+dKwEYY1AJOUqpyYu5k7L2fXRDpzJzc/ecjgwK5an6ktq4/FbfLKHHCTiZ94AM2QTSpbU/NXPr5QmizGURJFM2YXoVi9x3YECeILOuRuM8yGPeHvRPC1xRxdxL9VBJjVesAHvM8gkHU2aA/FJCqHzmH4NO0+I6dmXaS9qoRyPkn0GICQL23X5xxQ4FbXlv6+sGc9UKCaOV50ssdWQRJKQROgm2I5U3cvYswOTVCDsURbQSPWSHBBhfI74Otmj5m0IM7uWSnMmhDf4XPcExy9IZtWM30kEIrAWNzvgYxLwhUmqwRbkTJl6W/sFm6TfViuszGT/HhJXH0AouS07FPM/EnPZ53xRCxA68mxh9bNbrqw8y9KdQyRAOBVtm7jwd/dmu1oNUzf7+/dB2bk+LH82FTg3hoALNgI25lcQ3SwnvpKU3EQKxDrIZCv2zOwQm+FGYNbu96bczW0+qbrd0iC6IC0GteH7oIOMIp8MpG2XlVsM/DxJWy8ZCfy2Vf7SfjXkLuWCdULVQCQJR75LOBBEUUIGVvLPVw3W7zShbEmfAEGSQPoVeWqRXXAPfxA1xLBuMDhCNnOJ0TLjpNH24zs4U8Tr2pvCFBRa9D0CKvNELD04Q4xUPsGRITYErsE8jkrwK+SwGFYsluOqVHBi34fNqMkChFLTZqrsqn6ymajkAJSt1e6IDhUKhsr4dJIpw9rk6zG7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8EeW6dKaX+ZBkueEFlKFG2A5XoR6Ep8XRebFwTtfJx/q/rIoUQVBIOj5fBS4i7KS8SybG9g9QKNhSTuAJc7kOdAZ/epaFGSwnCKyFARR9KSHxKPetZQLXJjDSzfnfoKj3sY3LQfLJSNwTKqpMZn8fka6gSa6r6+imSgkzELT9Uz/NABFyU6n4Q+KCbvF6O99xf7PhuUEL26OCEuf9u1aOcT7aXnCvOsffIOyw185rT6eqo8QO+7u2MfwIslJ3YgLSQTr7C5YN/3CPpq1Fw9Baq8Q3fZIdHR3u6Mdz5iCkt711H5kO7eF2WVl0fSiVZpGOyG9tDN8T3kmneuVAfcw9JLBjIcI6G5e4g71WPYAfTSEYh/F6I8GkTGHzk/eBiE3T8lN+9BNJsk/v1+hJqAZ+edd+zQuYQDJq4U5Vl1awvhNMNogq/dVrgV0lVxfMfN5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:25.0065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec01b80-e219-4cc4-fb8c-08deffbb58ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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


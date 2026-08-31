Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A57C624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F7910E8DA;
	Mon, 31 Aug 2026 18:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0nRXOKKs";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9141110E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omRLXjbkEGcD44TNQXjc85LSRHFNr3HLuNHtDnsR27DtjqEr8Qohgo0KJJxGIeBQrdWGCsJEZyJJiXBuZsCuNEn8738rprF0Js6nKNwAiIRdUOBwXr/uugaSmozJd4tc0NPIYyHUa36+F4tPad5Expm44kiTZyMF1I0EmdJigR9vTRevYwNSjdLmCjWSwM9K51J68VHn7i4rS2azo3aHAoO6OIRX3KNFe1TdPMaWdmIoh6jNNP9PmxmI5tFzERYSCwJv9v/VKclXMt9uFfqAMbhC2ZLdFEAU7uCQXaP9kcxiytfVa/P5kXc6E69cjaXNZLSZ1o3/PY4ysszAo6fM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p1iOdJtkHuMrgDTfLYDfpFIdvp+d2O60Uf9S5M2YwM=;
 b=y3ef3hZL7wCE+qvmb3VPw+dEr5cBq7Ji5G+d/Mwh90TbpZVBS7cWDPggfZpSc6tcy8Q4RvU3EgaYUddOtb8yL0nFuUbb3gfGvDHCqQLeu2u0uqO2cY4mTB1eACWz2PTBY5ELQcYVPGaWtFa8K8J5w+7Z1rWDF5+9oldIS3r3CV9f1TTjW2Xyzog4TedTxK2O+PYlmlN0s5Iz6KG0kGmzrBfz+LuEuqdyZLcTYlb34Q1GgFDaB19qpt9Iyxko2oH8+tej7HOVXTsHVviuKZVfA4BCxBD6HOpyu0I/hl3bKe+D/0MA75W5BUcrt705JDquI+0vhj6cFLyhUNmmOMImHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p1iOdJtkHuMrgDTfLYDfpFIdvp+d2O60Uf9S5M2YwM=;
 b=0nRXOKKsm5bq1Px2iWcdDY2AT2blF9F30DOJyB+upbsIq+wTCPXoK9d6mVbaiTOKI7SK6N654TTNLuRh3Cqbsoxuafia2FTqWinale+6umdvTIPc35zjHHs1/28AppPjcULKDkMUmYSn7YQxxYaeNki4JedXoSf8aZ/kXAqEs8g=
Received: from BN9PR03CA0660.namprd03.prod.outlook.com (2603:10b6:408:13b::35)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:21 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::49) by BN9PR03CA0660.outlook.office365.com
 (2603:10b6:408:13b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/95] drm/amdgpu: Implement PSP cmd UAL_GET_CONFIG
Date: Mon, 31 Aug 2026 14:26:27 -0400
Message-ID: <20260831182754.1089811-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 4098afb9-309b-433c-088c-08df078da2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4hBQe0yX6pyzURbTBI6gQ4Mb1nI1IjLZuKuBadFzjUeSYk8W1368znbNfrwJf9mxHZMDM+Mj45GKSXHXGpSh6snKIq18+qVIjFaQR7AYdqxJJNvQm8PZmcqqaR8apnesZrgeVs2qT5gnwL8+AnTpklTmVYHZ7zqkTCfkasivSHb+uYAQo9eHOjnhCNucv8wA7WpBImIxLxXO82/TD9h8XMioYSz3Wr8tiKl1CAD2sQdS0b43WpDRebuXYzpWS16aMT9MBfxD2MOYIyrRUnR+tHwD9wXfqamauzZoQUJ4JQ5NviaDcgGVd2eEY87jft8EAjeu/QgnLcxPlzTS1AQWOW9Bft8PI4cZvxNK9H6PLXrm/I10v0q35gf2EhM2RibfY3NYSkshmun4+6jc55cp2+HC8L+nLFUUnA8obszopPIitOilv4TxGu/Tv8P5yI1ZbKGt4JBQzqCo+MJVwffPhp6n3J+VdDZo8gp45/JSW1bu/2E5UCe6ET55ZCgd0NF+EzbngCbmOeW6SKuhTnjSNWmMTY5KoqGgenXRZOgyG9iWCbmLeDJkbCWgd03T/5n2JA+oG9dy+rvC2KNXSUCl7fUJyP5Py5TTcU624u8sYXdYjLMuxuzZNQQj3cJzYe5Wp+ZyH5pvTwoxP9kr7+HApXsYp3COJX+cmErQcxpoTSq7xmCzkT6uKiMc2ZOMG3HfO5NddNp11fOnkFBeHmywfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uy3hwupxYOZGaGFY8QD8yoiDIMdkCooDkFpIrqglbUxrgU08zj3FNkU3FDdiUMWeteNoYbddA5onKcv5M4G0NrL80VYBhPzJoQp9SqdoOcClTVKLw6cmMu1IRcb0iSzHUTPjp53pD7xDsuW9nlWWZLtprQkVdKGZZthuSzRBWYimBGqyRXza9SWWDlT05aD14xPVX5gw7Ez09lZN+kdcn5d/VBLktPxgtfoJXrw7Kj1SP1AFWLKUqflmoQcKVGalIKAOsYNy9IZBi2EkTqZrv9eppUOsW2NDdDMxxrqcGfVStpzNIIKtcoGakfP7IUYeNtWOjQabaPXrTm4VI1lTtyRQoUxlK8clQ2b0kSVMGARCsDPBAcaK9jlO+DZZfl8KsacvCMOJM0oa6FwQPkinrOl1qKCO1fJqr8l3suPIK0iJZk1/HmygAZQjh13V/6HA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:21.2345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4098afb9-309b-433c-088c-08df078da2c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7161C624D2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FE210EA55;
	Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YGSgRJ01";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C0A10EA5E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAlsLUtjEF4OoWzCqvxSJcjeOBqDL7UMegNPLByghbhRfHw2uyi0nW/0HBOkh8cIUxjfz8XzY/SQl7ujuxTTp+uyxXDyntBI6e712cfOjYyjoSkJY6NKP+3BRZWdEqOVCY7TSOVhYYEZoq0VjGS8UQXqfUMzRwJqvCGwi3difzmEFI9QJq3Xd0onqQQoH+PqBRhOae9a60bpf/udiwgdN9NcxARiZrtIKPee/VtxjrcS9PlJf5274CUQU12PvOw5CMPM42vmxqiYeIn1SM8YR0TRjaPNLE94D2yfDjCRyWUe0GGnMBH0h2yZCMDYd3U6RlC3nVSVKuFF/S09zWIgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whHdlz06rwa5i519eb/HHLxG9bDXnZ9z9XSr6tOF/AU=;
 b=KzxfBsMfZTjnkBRAUZGKVKvsJ1uU8mKFRxR1YiWCL448qREZQSR7sEIPfLCdpQ5jvhWHgl/FHxBZJ8vmmYKm6wpsNJ2NMoDN6VmLwGtfVaixjfKXe26I3+mL1DvZ7JK7C/sPrUzEHw3iOICvV3N7CWfCX5ijxD6OiDdveo9c6/CPZUNO5T9WezV7kSY9bH+5iqygMe795c++sRkstAoW9SmjCa/MJsMIJufaxn6PZNQJys9SzTOnI18L7lfBZSo4L408OdBry6wv95Jg5yfXL0/pAK5GJmLfCuBchM/IXNFfY2GWIzNGtsFjfIDvIdzRFIW5JR5Ny3YOIUUStsJhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whHdlz06rwa5i519eb/HHLxG9bDXnZ9z9XSr6tOF/AU=;
 b=YGSgRJ017jTyKNMu7rjcB4yPxX4JivEY8sXwr1koCPUxaynHNWR6zHAYBkRpBS3ai9jnvBS32ha3MeJnpLgL5PXhKfbjZTHTQI3h7I0TtUB8suFjgG3vC5OUUcceoI4RxSNSJc2vN3jVUKnlu3Z4W3YdYgXsntHgvJm7zeCzfPc=
Received: from BN1PR14CA0030.namprd14.prod.outlook.com (2603:10b6:408:e3::35)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 18:28:27 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::5c) by BN1PR14CA0030.outlook.office365.com
 (2603:10b6:408:e3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/95] drm/amdgpu: Implement PSP cmd UAL_SET_VPOD_CONFIG
Date: Mon, 31 Aug 2026 14:26:31 -0400
Message-ID: <20260831182754.1089811-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f029d3-0864-47ee-089d-08df078da549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|6133799003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: ilu2jvLQalLxhoJoHfXAgAjk//NhBcX2V5mh7/IxUakxopQrBjeouPye386YXd8NzhnKU1V8PGiAgz1Sj0Qyl8Whv1ImgeyV/Avlsi7huPax3jEwaML2wFKbn+uVQT/XK//2VZbDDXjLU3E6X+COQ/g5tw6kNY7cI15qDn6CFR/Ssx2hPZtTE1dvwabH81AdcQ5xFR2Oh6VgSg1r0kirJJJz7tKQN4NqIWtt8IcTg7l95sDcSWl6pB+iL94lwLDR7B6K2Dkyba/HqmM8GVoLjCuchYl5kM1Qxsp1KvlpSOCPXv5/1OjRRlZTMUSwzIbb03y4HOOIQcyckuHtMXvmzJj2H+kbuKLeOhxD/TFqTKBhS0zJRoqjDqLzU4LiULQ1jQctLlgTyqISWab8Qcia8oBZnQxnCBSGsbhyHcWU1Ogf5Qth5ChmmuraTTlyzXGCXO4K/Rx0qPQoTrkN5uXelgZpaNCyaO0oN1I3izJrYg4VY6pqmk/FOSFhoKvL03BNpDn+MMgc4sTzIm/MOlIZ1mK4Mbsff1NWSFg0JWo8sT+t5HkkXwTsB6FEhn2GhFJdjiw+8ACmL6S8uQWZIKVypdJPxd1D4AKCi4jViWSkw0Al5oObERTkfKQ5MxAVhxE9JvLitzVnknFINnaxALqtCa526sf60+DYYnXXvkM7oEs/YdrnEO55ExLXAILDsAhRisWvL8cCEGAgqeH+wnk3yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T1EY0iNg4Ol+8fJZwUWKO8fR5kbU5cyXVKtxQ6K+Q0YynLmHhCbq++lAt631bUFVVD+47KMui1u1Z8ourynXV3hVjE0aueylw8aYi8e1d2Sb09j9U1oM748WzZyRCVeJm00A+QVeeOLgnz0OtqdeCQyiK73N9XwDPdkjf0rVZPSlmojH328R0ljnskM0BoXndwyiH0xaRm2CakswtrBF5g8K4s8UEI7qr3Kz5flOXZatQMLxdU1WvfC9XIfYULwHQO4jwguYsiEWV26/igoNNj5vhvF9DXmjJQTIFGfWBMTdeJ8WHoNQt7/sazAYQIG1fEHVVm+CPB1XVzO/WDCkOu3z0BSrGt8JmZ5omIOJKVEByZUtkdTo+VJWNGrP4Z5LPvwkkqjC9P1L3zRe8djo8+jqAGfqJ5V1YzcXUkajc4rfbDnSz/cPyxeTDmplNohR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:25.4316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f029d3-0864-47ee-089d-08df078da549
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
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


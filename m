Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8607EC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A1F10E295;
	Sat, 26 Feb 2022 15:42:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F6A10E295
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVla7mTaDsC3LXIunlZ7oruGM59FujYYoS34wHP7Wdx+PwpibGHwOLws1Fevumo84fh8lhtpwg3d0FE4RjbKsEsJOzOzuIGJeXfIPZtNlMFiDpSDkqmRT2ywISOKiJpZaIe++X9bNQF9PdLS31MP2Uum5vNrJ+OatUQYdIrA7MyQj3ilJvHdblEmorrJMV68eHp2G5WjfigPQONGl8KonDNNATSsBAG4lOKuLiS6/u3s9C9zrEaKZ8FXt6MnKRgKks/ubxf5FMQ59lVNLYBVleWruTtPdC27nN0AUje0wjK5lt8Qrg/x35N4HxHt6OJGqMsMlMRCdBdKjiLG2GmMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBRmXuSH5v4BD3SUIG4ACRp5cRRzYom3fbCf+QdIPcg=;
 b=ldNY3fcuNFdbTZRQJgqbB2AIWcVnplSkOesbQgtw7wtHhETTc+odWdJYIXehu5L7PTroWEEW21ilMjcprrYYZvUJk5TS9rz361C/MAO/bNtN2f9F1Ow6wWtMUDD9yl/OREYsjtj0jqKzeldBl8DSM2GfD0RhnQpHK4v0eoiaeolrdCLlDtzdMfUaY6ysQbDVp+iIWNM2B2U+2FvIINXTXF6a1Vh1QLFHYoGDrFI/+VKcFAgaD5SnVFw48vBvvsSjFjAs/ndXaJF3Gsc9ieiJeXhW7hegHlj0dnwaDIZWeDC2eEm8CRckYVlnIurmSgGko7iwwgaPgdVaYcspVYGjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBRmXuSH5v4BD3SUIG4ACRp5cRRzYom3fbCf+QdIPcg=;
 b=d7X7UDhbfSTsNyyNbQ60JCrrjSM0urHEUEkZgFlLdCcamTYdi9hfdcwt752qjSJNybAI8+lWeBB5O2nPoGwCDdDYf6X1Wad/5+gnDmOU9OEKcT+ZuyA38+aCte516R2AkhqN88ermA/jOj0fmhvW/xfQlyet7QqJYLAsmZBVMUg=
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Sat, 26 Feb
 2022 15:41:57 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::86) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Sat, 26 Feb 2022 15:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:41:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:41:56 -0600
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:41:47 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: Adding a dc_debug option and dmub
 setting to use PHY FSM for PSR
Date: Sun, 27 Feb 2022 07:41:08 +0800
Message-ID: <20220226234117.3328151-6-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84439ed6-fc45-4be1-1c17-08d9f93e8539
X-MS-TrafficTypeDiagnostic: DS7PR12MB5959:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB595985BABF440709086C2064F53F9@DS7PR12MB5959.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iE+JaWRfJka71m4WXkPae81p52AMXp2YbvVLrSy4JHphcFz5burySc5Qc4ZCoY9mMoGontnXhETvKYV4E0xQcwHSo3Qq0/Dtk77aOc1DjEMQ8LMbDrjqNI/FgohaZbElIntms3EnprV+BoIHLN0vaE/jaTs4nRrKGk1NsX+5MYWvAk85/8vD+fmr8R4FXZXby8emR15ikpqeO32onJbiQa1+jCrh17j/rAu4/OH2RdRh0nyDb6T3VC96cgl+KwyeVmuD/CudPbBRwU7KgqueK6GA73CfQwGjodILkOb4b4gVGE6ftoKVMBcU6bXeyOiqnK96yBFADDZWX//Ngk4y3hJgG1psyeQFXB+H/RyeR8ozyl4REj5JUOwt/6JIlPjseuwg9HsrrYeH8AsltYGX8zDeOdYz44xpOTC9FZLNu8VoZZPSILTCbtIscIZxJWNaN9v80uZUNbC1QCQ5tNxXf5N2FYo4cY5LgUO6SnEL0MPU3MGw75ofwqBPmwuUaMyKdaQEt5ZUFhn9ec152fHkZL5xwdBnH7xkT9kGpKxFIioUlKjXkdosr2BUC7oA08juWFDfr6Ve6kZqTODY4xyLKumnp07vjuIBiWX8DTzku4tAm5KPCrGhO34hzgIZg6iO07m//K5zGV5eEjgC5karNosyM+vqpckjvp/nC0+eB+8G22W/ZB5wkMBJT/RCcZm41tnWo9UXb6CLEHtH616aHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(1076003)(186003)(2616005)(86362001)(7696005)(70586007)(82310400004)(6916009)(4326008)(6666004)(8676002)(81166007)(316002)(54906003)(40460700003)(70206006)(36756003)(36860700001)(356005)(8936002)(5660300002)(2906002)(508600001)(47076005)(426003)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:41:56.7255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84439ed6-fc45-4be1-1c17-08d9f93e8539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Hansen Dsouza <hansen.dsouza@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Shah Dharati <dharati.shah@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Shah, Dharati" <Dharati.Shah@amd.com>

[Why]
PSR Power on/off is done in PSR. Add a dc_debug option
and dmub setting to use PHY implementation of this instead.

[How]
Add a dc_debug option and dmub setting to use
PHY FSM Power up/down for PSR.

Co-authored-by: Shah Dharati <dharati.shah@amd.com>
Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Shah Dharati <dharati.shah@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c           | 1 +
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h         | 8 ++++++--
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 55d43d642b38..7c8b6e1a9c9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -710,6 +710,7 @@ struct dc_debug_options {
 #endif
 	bool apply_vendor_specific_lttpr_wa;
 	bool ignore_dpref_ss;
+	uint8_t psr_power_use_phy_fsm;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 8bd265b40847..312c68172689 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -320,6 +320,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		copy_settings_data->otg_inst			= 0;
 
 	// Misc
+	copy_settings_data->use_phy_fsm             = link->ctx->dc->debug.psr_power_use_phy_fsm;
 	copy_settings_data->psr_level				= psr_context->psr_level.u32all;
 	copy_settings_data->smu_optimizations_en		= psr_context->allow_smu_optimizations;
 	copy_settings_data->multi_disp_optimizations_en	= psr_context->allow_multi_disp_optimizations;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 406492655dee..48381cb58032 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1034,6 +1034,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.optimize_edp_link_rate = true,
 	.enable_sw_cntl_psr = true,
+	.psr_power_use_phy_fsm = 0,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3eb0d7a2d3a7..da93087132b0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1560,10 +1560,14 @@ struct dmub_cmd_psr_copy_settings_data {
 	 * DSC enable status in driver
 	 */
 	uint8_t dsc_enable_status;
+	/*
+	 * Use FSM state for PSR power up/down
+	 */
+	uint8_t use_phy_fsm;
 	/**
-	 * Explicit padding to 3 byte boundary.
+	 * Explicit padding to 2 byte boundary.
 	 */
-	uint8_t pad3[3];
+	uint8_t pad3[2];
 };
 
 /**
-- 
2.25.1


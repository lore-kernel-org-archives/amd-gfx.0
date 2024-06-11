Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90144C27C78
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959DC10E13F;
	Tue, 11 Jun 2024 16:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AxYRIUeQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D52510E6C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoHxCgC7N8VKpxH/NzL77can6ioUqt+w21Cir9HnLpP8dwUmmOxjiOGF+ZqhTWEqdxcIO/nWZuAXPT4DYHE5xPE4Od+qifcmInsJK8bi+fdSYdbRCBGDqULSXD0QNTG+5hW7qdkHQbpoa/mSiUVyW7LAVAVWjBJcl+0CXtGDtKBrt9BQpcVIrrq9wE8zLnP8zMruJRTTDYp8+1eC1JCs8KiPAl5hQoIEa8AKmFSUZIiOSj7ISZuq4DLUAXky7lShwJHJ7U8yq8FpppeZ3q4yaUy46aahRESf/95AFT9UgniKyYGys5vBMmhOLDJSM1xfmqamZ/RSY+xUgQTZcvegoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnPso8otruixXYJyLcUEfm8yg2Qx/fjwRHO5tfI9skk=;
 b=NMTFWhw1wDyu8xhgVGRRNkBevFcgmf2glAGGbLHDPDcs44I+7fzPlxs2LCFpdAZxUOLl+xYGzZVjZeDkPgCQsv4LxfSg9i9/koApcDDIgLfRU69y+hH9eSdCilFHCZcStsrZ3se2UwStBcJMlXUNhWbR14DDycqyBQ/JrJnSKRKuCZhsLuY2GjFaUa9PM5E1syeUoifEiGQiNCw0YpjIqWys12Rcg/oLnUuKRgClwr7QKYSVkJmmN/yQCWaxGQ33TrTjCmCVLElXs861giZtWH+Shrjlo0BPz6Vi7xEBjg07XiTP3PVbNyedJGjCWdtnC5dN5fb2caUUvK0x1puqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnPso8otruixXYJyLcUEfm8yg2Qx/fjwRHO5tfI9skk=;
 b=AxYRIUeQd1l/VWMMULACZgF21+rL3/seZoiLkhhQZpL7CricuPiLA3Hpg3ITzLB2u1AEloAhO3a7qrLdC/qu4tx1FUafSdaUOjQTMaQC/3uuREnV1D8+Rr8UQCq4X4fTvWfhWAO/9mmSl4qk01jQWbdkplOFSdOfRgp6ehZGsn0=
Received: from BN8PR07CA0001.namprd07.prod.outlook.com (2603:10b6:408:ac::14)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:22 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::2f) by BN8PR07CA0001.outlook.office365.com
 (2603:10b6:408:ac::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:21 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:20 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>
Subject: [PATCH 04/36] Revert "drm/amd/display: workaround for oled eDP not
 lighting up on DCN401"
Date: Tue, 11 Jun 2024 12:51:07 -0400
Message-ID: <20240611165204.195093-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b960bab-bc13-4dee-e256-08dc8a36dcea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JuaJntJ6sqCVoAbvU1hYRP+o2+XJMZTGRQ7Z2oatsG8TXz6sCEROrjDmTr2+?=
 =?us-ascii?Q?CF59pPwZfYzf3U79IIg9iEXJTPqAkqbOjaarPYUH6VUxvIMjaTaRDI7jvHWt?=
 =?us-ascii?Q?nUQGikTAMMUQpj0eoH2KfHM0UFuT4+8vzTCPFwh1cTnM2zZfz57q7JcTg+DD?=
 =?us-ascii?Q?mr0EHOb4QIi9qklPwM9/tLgoIuiW4ZrKV9ptuiomtWEFluelg/O3OvqHrhls?=
 =?us-ascii?Q?SXJ6MHh2e2VZJJp0MHK8Eiw/FsfWqQmz3pdDnMN28ub4M09CSuLXLyUCGpJO?=
 =?us-ascii?Q?1ugkcOYE9gbONreK0gaLjpYQhKSZDZ9u8a2uGRbivXGt059x2SAEGgfUWZuu?=
 =?us-ascii?Q?QIta40x1PqRHDTUeroxntNuUsc5PFPSxeQosaaTgkwGnZ3qqc3pmOPE/vE3E?=
 =?us-ascii?Q?eKwhAsvc41PeSkRPymlUXwlX5sxEGVInX34Pcjz9U73kubyMJZ51ot7UonUd?=
 =?us-ascii?Q?HZm3DFc1iA4jHUJfaCBTkGupFhFkdraHAST+91JDiXQoyWMkmi1FQ+Q4PC+e?=
 =?us-ascii?Q?kM8JoWmVqWaw5zKbFgsjxjuHjrQ99DoaBH+LZZUOsIOZ9qcKoTQgY1BzI8hW?=
 =?us-ascii?Q?TQgoOKkSWiCHPfuBjgQ3TKLMNbplZcArMzK5rSZTUJHct7qZT7g4BzC2ZuYC?=
 =?us-ascii?Q?jgQ5X9tMISV0mEGkyYPG7xmiNASVyJa+cEpaGhlBFq+kjJbVxhwp75qhf8bP?=
 =?us-ascii?Q?J/jT0B8UZLMZxDbd6HcHm3zABqJhDfk3xaZlJnfM1qqp6u2H7E4dIe+lEyy+?=
 =?us-ascii?Q?zAOh+YUFb9Ho/1ZKzchq1hWmkcF79V8xvm0yeDGqyikBYqpj41NE0mvJ+947?=
 =?us-ascii?Q?PyzDjsoe1lOFe/0eTJGLlTsg6ok+3TQ3AaPGo2AbAbj4SwNpxLLQWU3mReDN?=
 =?us-ascii?Q?LEIpD2R0KSnrkNdCO5kPEHUFQap5WI7C1ZV+535H4x7SRPjs7cvgk1dvQZdJ?=
 =?us-ascii?Q?aASUoLggdS9H3fcd1VEq36x/GAk1JYV1u4SXtQ0+dCgGVFUckUmJflNcCG7H?=
 =?us-ascii?Q?mIAHkI3OtcupIlk54+FBBT92pHtsHEONLyDoDH15i7ZYLaC35RwehF/Ls7XR?=
 =?us-ascii?Q?QldTJL3Efj8UrLkONuK1yhwBwJwtbgSk9IyaRWbD0st5dGj+gDz3E11LxV07?=
 =?us-ascii?Q?zRAolrN1yOTDcK3Cp9sqECdZNdDxQ6fRk+4HpxNQaIrkTauyWzHWVZXcW6a6?=
 =?us-ascii?Q?m/g7PtUV3TcqSy6dnU8SpOpIErPWlowQAUy2oVyDwNFDJPuwwvDO6eE2sLoK?=
 =?us-ascii?Q?fyhUy90dMkWIR1G9FxGX+4z3bym4YYDA8QIeCEgHGW6GlMLMYqjw48mfHmUc?=
 =?us-ascii?Q?kEYqaYSBUIEGavzKlb3cRxH7Onl1KjLNE4trn0gqWM5T82JkSZTv5AgsQ4rq?=
 =?us-ascii?Q?ljEkpGx4LjFpj084snh0btOvaUtYHCclqnV+8BRWtTKR/V7g2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:21.8234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b960bab-bc13-4dee-e256-08dc8a36dcea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007
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

From: Joshua Aberback <joshua.aberback@amd.com>

This reverts commit e296c84e7d0561ed626591e1cf9b71a7ba0133f4.

A proper fix for this issue has been implemented in DMUB FW. So, no need
to keep the workaround.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                            | 1 -
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 ---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c   | 1 -
 3 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 35ca38ea2efa..b9c67bac7beb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1045,7 +1045,6 @@ struct dc_debug_options {
 	unsigned int force_easf;
 	unsigned int force_sharpness;
 	unsigned int force_lls;
-	bool edp_oled_no_backlight_enable;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index b0e17064a960..455b85adec28 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -248,9 +248,6 @@ bool edp_backlight_enable_aux(struct dc_link *link, bool enable)
 		link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
 		return false;
 
-	if (link->dc->debug.edp_oled_no_backlight_enable && link->dpcd_sink_ext_caps.bits.oled)
-		return true;
-
 	if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_ENABLE,
 		&backlight_enable, 1) != DC_OK)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index d78dc63f82fd..74fb21b88f12 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -731,7 +731,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.force_cositing = CHROMA_COSITING_TOPLEFT + 1,
-	.edp_oled_no_backlight_enable = true,
 };
 
 static struct dce_aux *dcn401_aux_engine_create(
-- 
2.45.1


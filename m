Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCC3C27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D17110E6E0;
	Tue, 11 Jun 2024 16:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4s/uNV/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C32D610E6DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH1dT9XDbOQNUs+3/JSNHgFmJ3mj55R88mg2/K9HXFCdQj8t/w0BLbRTEKR5TsgrlgAstnxSiWLrLxvPcGJSgNJ5VcSSkvHqNQGVX9Tck8abxTKkTz0TZ+qL8lLa5E1s0un5xIjeqkWgi8UKpmjF+Ln5X3aBxCSll0d8/AtvOSLdOfGnTpraSbKOa/ZWutUM3XHEDC9IKvEzUAKF8D4gz46Vp6z+vMudF/RhIv59f0wy3VI0gKioI5WeJN5y2sb2QYfiqo0spj51CopGJX3PIscaiZm7pBrwQ8TreTS6SgaosLWK2gWRi1/McMHo8sRqu5y8HP17WSrRdLOdHO8Hkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3D7FFwk0Pf/OmHp2VpGydYpo5vCNTc8BuUaYEBYTd0=;
 b=XwCtQ4JAhVZyLdkQdp8h7Sf6LcIvpT+K0IQ79ywC9DoLR1bdjp3brmH2PoXyXEcor1qClRD2khN3R5Y8hD7kugmKorVyoRlU2Nz4HjIy5IPaQs23vDze5B9uwVoufbYRLUkbHMknJwL0A4vu3yJfqpqErh6vdFgXgKwA4vyLo9UmPw0LzoCoWU48zhYeF6y+N5hdGBsni8Od3Nki469OVMPcvu6uh1tt2A405aNS+3yKwIbdOaDr70n6qQESwPbGgr21eSPyyY6aiOvb0zcOy2hQ+93XoEyXd1dQRX7xc8ohz9BGyp/XpkL7BSCTXXJLIu/A2LKkOXf0lVA6u9PCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3D7FFwk0Pf/OmHp2VpGydYpo5vCNTc8BuUaYEBYTd0=;
 b=N4s/uNV/1kpzGFNQVCAADcjRvsFQVxOhU6qPh+J/S/geoQ2eWFNcVCBVt9qakb13IMZVpqyVkPqzizoJqYJ4mzAzqgYC0pCLUojwh5D0/BHa5kQ0yov8vjkV95eN6EC2JawI8jj/f8wLZ3k+zMX7aDUoYn4w4OrXUpTV4mfLxlM=
Received: from BN8PR07CA0028.namprd07.prod.outlook.com (2603:10b6:408:ac::41)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:47 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::46) by BN8PR07CA0028.outlook.office365.com
 (2603:10b6:408:ac::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:47 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:45 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 28/36] drm/amd/display: Remove redundant checks for
 ctx->dc_bios
Date: Tue, 11 Jun 2024 12:51:31 -0400
Message-ID: <20240611165204.195093-29-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e946e47-43ea-47c0-a1bd-08dc8a36ec03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w4uAIUBY1Ht6rIy6DTqjlQhGVlrWL+d31pfaKQrnxEJFYokVkm6xoHw6YnN2?=
 =?us-ascii?Q?CXkjdYHYSuDMcNg9qBsR1g//FptqJh89Zgu2pcSa9t9NHVzOSiBFVIg7AFBd?=
 =?us-ascii?Q?rbkpu5yK16F4AfGxlkPz4fVUPwUcnXFqiNYWjkqCaX1cHNP+QJnmUaprw9uZ?=
 =?us-ascii?Q?VBuj557PGCz/O5oUacGkJE/0VWMEzmwQ4BJtzdASlyZVA0uReMq9Y6iQ1VxX?=
 =?us-ascii?Q?V5rBOnVbSTGv8Qu4LFF+fTuOLl33y9SDfmXXSYYA8qkEwN1Og9gZk7CqtIPt?=
 =?us-ascii?Q?wv2PLeuPIQH9B2ng5sxpw5eHFxw0/s3tFv3hU+MF+Y7jRcR6qfvs7iYbxEiI?=
 =?us-ascii?Q?ofpVFZehfm7YW24nTIJ23VFZakKqSz3JiPSdHdqZZ5xfUygoEw9Yfloy3LDY?=
 =?us-ascii?Q?dOG0EA1ZcKakf0zsxEOLlEsrPTpOeHBzvlzjY2Jv7Dxa63pqIWtwReIY4F5T?=
 =?us-ascii?Q?mw9Qf3+9tTQ9SSd28Dsk5drINzRcIZNCT35jcTZ0Sn24eCHP0ByilR3NUaa9?=
 =?us-ascii?Q?aPlcF7KxF7oN9MqVzdW4amSJOyiGOxH1Dh1+XKdD63HE9hBJKI89lTdXI+7Q?=
 =?us-ascii?Q?KqRWMKMRVfPSUHVDWh8I7BXSz2nDMHvE7VNEPr6IkO8bkLcu39Ldt6axIu5D?=
 =?us-ascii?Q?wnYRDyw/Ez4x9haUx/SGibDpY2IQcN4gl3929aZKWroOiTIgZo2NQWvi90JX?=
 =?us-ascii?Q?iJAi+Ul3L4YQpmHGqbmrnD5hedOc8EjYKdpfOJBPqwOE0yX5fsAQULUpLZHw?=
 =?us-ascii?Q?6ep8I4csN5w3Dlt+n+bJVm8wQmtKEXS2pgTplFQ3FEU6Sg0DodxU+ll4Fg8D?=
 =?us-ascii?Q?b8iRzDUayjIbo99CqH01AoRv9ceaWe5aGLqUp+9yKZDjJG4Fa04WGwuI5Arc?=
 =?us-ascii?Q?WD1ACxl3gDXSBGREQIKksl+IwmxN6rUqJDxZl7LspSsRPyEj0khMz73HQbnZ?=
 =?us-ascii?Q?l6CjX3vtsUrhXEGZDE2ubCPsem8llatXn+qRQATSsT/DZBs5IZlgBnGcXgVW?=
 =?us-ascii?Q?7B+crxJygw37Arfxi5mnciOeJfjSDOLSlBIUHlzgW1eXF1AlWAdYpK/Mw/tP?=
 =?us-ascii?Q?NowzCp0Q7s9owkbV9sdChDIZYZ+BmpRkIm6n3vjpiYOMz0TEjghvO/M3r+bo?=
 =?us-ascii?Q?9sXLajWnHJk5DOGTO0OfiZ5nFZ2YM/w2hTFd0SC9LTDhsbqPqZGPlz6vGglR?=
 =?us-ascii?Q?rY9gNY4iGkM1kj3ZE+UJjkEXJ15IjMYERibxK7qCh/UEtKx85axUrFfy9ZN0?=
 =?us-ascii?Q?g10pxoadJ29gIuOZRg6hZdNAvV/Ktg0VXNp1AaRj094J+OY8yBwjJqstk6ui?=
 =?us-ascii?Q?vVMDGRH7pKqofHEr5zD5vMV9zD5W6BaEXzGmRa2B0HEzmKmrlnq+ye8UmIyO?=
 =?us-ascii?Q?9f1QKUMRKa0zb6HLzfEQWNyN1cA5X67csUBBuoLsHJrWkcPZ4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:47.1670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e946e47-43ea-47c0-a1bd-08dc8a36ec03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
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

From: Alex Hung <alex.hung@amd.com>

The null checks for ctx->dc_bios are redundant as it was already
dereferenced previously, as reported by Coverity; therefore the
null checks are removed.

This fixes 7 REVERSE_INULL issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index a650a9877097..e18097f82091 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -772,7 +772,7 @@ void rn_clk_mgr_construct(
 		status = pp_smu->rn_funcs.get_dpm_clock_table(&pp_smu->rn_funcs.pp_smu, &clock_table);
 
 		if (status == PP_SMU_RESULT_OK &&
-		    ctx->dc_bios && ctx->dc_bios->integrated_info) {
+		    ctx->dc_bios->integrated_info) {
 			rn_clk_mgr_helper_populate_bw_params (clk_mgr->base.bw_params, &clock_table, ctx->dc_bios->integrated_info);
 			/* treat memory config as single channel if memory is asymmetrics. */
 			if (ctx->dc->config.is_asymmetric_memory)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 148a0e4cdea2..9e2ef0e724fc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -731,7 +731,7 @@ void vg_clk_mgr_construct(
 	clk_mgr->base.base.bw_params = &vg_bw_params;
 
 	vg_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
-	if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
+	if (ctx->dc_bios->integrated_info) {
 		vg_clk_mgr_helper_populate_bw_params(
 				&clk_mgr->base,
 				ctx->dc_bios->integrated_info,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 12a7752758b8..e93df3d6222e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -785,7 +785,7 @@ void dcn31_clk_mgr_construct(
 					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].MemClk,
 					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].Voltage);
 		}
-		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
+		if (ctx->dc_bios->integrated_info) {
 			dcn31_clk_mgr_helper_populate_bw_params(
 					&clk_mgr->base,
 					ctx->dc_bios->integrated_info,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index a84f1e376dee..29eff386505a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -896,7 +896,7 @@ void dcn314_clk_mgr_construct(
 					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].Voltage);
 		}
 
-		if (ctx->dc_bios && ctx->dc_bios->integrated_info && ctx->dc->config.use_default_clock_table == false) {
+		if (ctx->dc_bios->integrated_info && ctx->dc->config.use_default_clock_table == false) {
 			dcn314_clk_mgr_helper_populate_bw_params(
 					&clk_mgr->base,
 					ctx->dc_bios->integrated_info,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 5506cf9b3672..a0fb4481d2f1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -712,7 +712,7 @@ void dcn315_clk_mgr_construct(
 					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].Voltage);
 		}
 
-		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
+		if (ctx->dc_bios->integrated_info) {
 			dcn315_clk_mgr_helper_populate_bw_params(
 					&clk_mgr->base,
 					ctx->dc_bios->integrated_info,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 20ca7afa9cb4..c3e50c3aaa60 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -652,7 +652,7 @@ void dcn316_clk_mgr_construct(
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
 		dcn316_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
 
-		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
+		if (ctx->dc_bios->integrated_info) {
 			dcn316_clk_mgr_helper_populate_bw_params(
 					&clk_mgr->base,
 					ctx->dc_bios->integrated_info,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 9a414f49f15a..5691714f738d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1182,7 +1182,7 @@ void dcn35_clk_mgr_construct(
 					   i, smu_dpm_clks.dpm_clks->MemPstateTable[i].Voltage);
 		}
 
-		if (ctx->dc_bios && ctx->dc_bios->integrated_info && ctx->dc->config.use_default_clock_table == false) {
+		if (ctx->dc_bios->integrated_info && ctx->dc->config.use_default_clock_table == false) {
 			dcn35_clk_mgr_helper_populate_bw_params(
 					&clk_mgr->base,
 					ctx->dc_bios->integrated_info,
-- 
2.45.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA0BC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 16:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE13210E108;
	Wed, 24 May 2023 16:20:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99C410E108
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 16:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxS2pyDO+GDnXTq+PiotsWh6+C3zVO6h7eF473poaMK2nt0sJV+o5XXspv5KCIh8P3CkLqfGoJVAi0khM6jcvsMD87P515zIuWW7o63wiAMKFLiDUOuaowwGWTm42+FAUt1WfEdAec/aIYG6/WhDkR2WC3/kxt/adFoms+QMikgcHWhXhx5TaD0XWUD8gA4uzJjgUVYYLFZtOwqYKquWJkBnNvGNDb0dFySpconyXP2FMPHvq+zIRubsGnECx8kPMb0coGrLtMKIwZKZNtXzwkLwPYyHKmA0upStFH3PEDCfajIPzvW11n33VXHAFS4Rx3X48mHPFEA6AknJi/EGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmSPC02rqIvJ2ZECTaAA1hWS37Ii5o9FPHpRhSTzcwY=;
 b=KJjMhG4YV2fNhzn84HPCoIf9nK+/QW8peQXxiG/ex5XBSFY+sKVJ2t5ct2k1YOJwwXycT3h7PY8vvAiHUS0L6QDn45C3pLTNDdUemGBTrej37GsFouo/xgHzqwuHFUslSHwkV3LED8WCqkePfjmF3mrt0IZWvLfuaxb91orVjVHx6j7V2VQK8QWFd01x+3qVVbPEF97JcbCciuKT5/WKG4vXF0k+xRcD0QxsOBXKZB67hItvrnWEREK0jzSDk8QOih5HdGPbfHSE1thFf+WJncR+kBveNjv7/CsnmR1ccuKeZuUaPjqkCPu6HEKbpXsLWi+i1MeubRuFdaQNtJBQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmSPC02rqIvJ2ZECTaAA1hWS37Ii5o9FPHpRhSTzcwY=;
 b=2YDvQeNX9Z+H3LXA9a+0IIGsUS/llhjVPnp2AN97cG8WdzbBr4+9YLK5gJnkuETBdhNgf31eZ1ijpJSgibv27qBXfGzQBx/CZc+xiiq7+UfIc7UDWbFi449UW8H627NUn3ZyluT4YCsRbOJQ/crm5eTWHPGwJl+hemGKDzHjILo=
Received: from DM6PR06CA0030.namprd06.prod.outlook.com (2603:10b6:5:120::43)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 16:20:36 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::d) by DM6PR06CA0030.outlook.office365.com
 (2603:10b6:5:120::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16 via Frontend
 Transport; Wed, 24 May 2023 16:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.12 via Frontend Transport; Wed, 24 May 2023 16:20:36 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 11:20:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Drop unused res_create_maximus_funcs &
 debug_defaults_diags variables
Date: Wed, 24 May 2023 21:49:57 +0530
Message-ID: <20230524161957.3672412-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: b6908bdd-75c3-4154-5bf5-08db5c72ce88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3REv/rKJn+gWiOP/STFXhSvYZuq7rmvlCeCdLxLl0i7dn6gmxRAYioHArPDtxFflRVQgHRaNHLTL1auzjpeb3fTNplTaJhW0J1eM6rLfaG/TkMjnGz+y5JESepokS7csWKPEZt24K63L3dbkc8FEPmH5dxqvIzOL22xninDgoMLWBImaBzvQL+bz1WoZVF2IIQoIQG1hicsJgFrg1o4ToVxXxwbnnc8oxeb5yLDF1kSOApNRijmDs4CEOhMtwdsH67DOA1iJgS7Y3EQHv4KGSdfWQPR8Zl7vur642MXArrGoEoovk4xn7sOSsmnfCQSW9j4ogB19ul4lp+v80A1ZDq/JZU2UyLDyXJ21bwZMUjJmUzSLmvng1COpcG1tpUOb3FU4AV/+ClhLwLv+i8b2N3TDOQR+iOtGfNmNOiOSdfSP7+w0DUEF/yL7axzmV9zepo6AE2CzOPTUTIF85DSwS0ISrwClsFNbxu7yMpwK5BMDeGA7wKah/ulYx1owWI/9zXJb4jSO2ibP3Z0iJMgIkcnVvKeV6RtJhU4sk1lQOvTM7/lb0vzNyBXYAWnmsaGgNSEIFZ05an8EO5FYIG+NjGqVZduiWdEt7PoCO8Yd24qhFgUfdniIvjb1jYmBYbdJT4wil0XteOMFium1psLwRj9+jUpQxPe4vLbIp/z4VnWlE17KagwxeSnYa5l+PrWFlnx8DellEStpBrwVo4kj4Xx3cgnKj+e6oxm8ok/QR8SZ4Ctg9uVtSDs6Q1pMeLvxl7RWw22cIWDswqaqcZJT4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(356005)(82740400003)(1076003)(26005)(16526019)(40460700003)(186003)(81166007)(44832011)(2616005)(36860700001)(47076005)(36756003)(83380400001)(426003)(336012)(2906002)(40480700001)(7696005)(41300700001)(316002)(54906003)(6666004)(37006003)(82310400005)(70206006)(70586007)(6636002)(4326008)(86362001)(8936002)(6862004)(5660300002)(478600001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 16:20:36.3189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6908bdd-75c3-4154-5bf5-08db5c72ce88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gcc with W=1
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:1346:43: warning: ‘res_create_maximus_funcs’ defined but not used [-Wunused-const-variable=]
 1346 | static const struct resource_create_funcs res_create_maximus_funcs = {
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:735:38: warning: ‘debug_defaults_diags’ defined but not used [-Wunused-const-variable=]
  735 | static const struct dc_debug_options debug_defaults_diags = {
      |                                      ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1360:43: warning: ‘res_create_maximus_funcs’ defined but not used [-Wunused-const-variable=]
 1360 | static const struct resource_create_funcs res_create_maximus_funcs = {
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:737:38: warning: ‘debug_defaults_diags’ defined but not used [-Wunused-const-variable=]
  737 | static const struct dc_debug_options debug_defaults_diags = {
      |

These variables are not used so removed them.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 29 ------------------
 .../amd/display/dc/dcn321/dcn321_resource.c   | 30 -------------------
 2 files changed, 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 33abc8c9d4be..2e6b39fe2613 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -734,26 +734,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_max_blank_us = 1000,
 };
 
-static const struct dc_debug_options debug_defaults_diags = {
-	.disable_dmcu = true,
-	.force_abm_enable = false,
-	.timing_trace = true,
-	.clock_trace = true,
-	.disable_dpp_power_gate = true,
-	.disable_hubp_power_gate = true,
-	.disable_dsc_power_gate = true,
-	.disable_clock_gate = true,
-	.disable_pplib_clock_request = true,
-	.disable_pplib_wm_range = true,
-	.disable_stutter = false,
-	.scl_reset_length10 = true,
-	.dwb_fi_phase = -1, // -1 = disable
-	.dmub_command_table = true,
-	.enable_tri_buf = true,
-	.use_max_lb = true,
-	.force_disable_subvp = true
-};
-
 static struct dce_aux *dcn32_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
@@ -1357,15 +1337,6 @@ static const struct resource_create_funcs res_create_funcs = {
 	.create_hwseq = dcn32_hwseq_create,
 };
 
-static const struct resource_create_funcs res_create_maximus_funcs = {
-	.read_dce_straps = NULL,
-	.create_audio = NULL,
-	.create_stream_encoder = NULL,
-	.create_hpo_dp_stream_encoder = dcn32_hpo_dp_stream_encoder_create,
-	.create_hpo_dp_link_encoder = dcn32_hpo_dp_link_encoder_create,
-	.create_hwseq = dcn32_hwseq_create,
-};
-
 static void dcn32_resource_destruct(struct dcn32_resource_pool *pool)
 {
 	unsigned int i;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index af0bb3e94250..bbcd3579fea6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -732,27 +732,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_max_blank_us = 1000,
 };
 
-static const struct dc_debug_options debug_defaults_diags = {
-	.disable_dmcu = true,
-	.force_abm_enable = false,
-	.timing_trace = true,
-	.clock_trace = true,
-	.disable_dpp_power_gate = true,
-	.disable_hubp_power_gate = true,
-	.disable_dsc_power_gate = true,
-	.disable_clock_gate = true,
-	.disable_pplib_clock_request = true,
-	.disable_pplib_wm_range = true,
-	.disable_stutter = false,
-	.scl_reset_length10 = true,
-	.dwb_fi_phase = -1, // -1 = disable
-	.dmub_command_table = true,
-	.enable_tri_buf = true,
-	.use_max_lb = true,
-	.force_disable_subvp = true,
-};
-
-
 static struct dce_aux *dcn321_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
@@ -1343,15 +1322,6 @@ static const struct resource_create_funcs res_create_funcs = {
 	.create_hwseq = dcn321_hwseq_create,
 };
 
-static const struct resource_create_funcs res_create_maximus_funcs = {
-	.read_dce_straps = NULL,
-	.create_audio = NULL,
-	.create_stream_encoder = NULL,
-	.create_hpo_dp_stream_encoder = dcn321_hpo_dp_stream_encoder_create,
-	.create_hpo_dp_link_encoder = dcn321_hpo_dp_link_encoder_create,
-	.create_hwseq = dcn321_hwseq_create,
-};
-
 static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
 {
 	unsigned int i;
-- 
2.25.1


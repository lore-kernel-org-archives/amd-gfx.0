Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEEFECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E43510E816;
	Wed, 14 Sep 2022 03:56:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA6910E816
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRWuDL0r13OSc+cOqSu5xOCpvmpmOmAjOljctFYjoawlDq2siGQ6E9Se7ADKL55lsiiEuSz4dnAcmgwEeGq+q4fluP/4URcMOPDAL+auh+g8k9q97u9mc5Ay5yUY/OgGIFu/8qgQGUsdzSyecV94c8VrSxk1CyXDbJLCiyp9gKzbdY4I/aO87Tp0pf46b1cbRGRUL675mkzzSlL1ooieg8pPr3SGKLT6iv4bqkiA5UZXBr822fHK76RGsa9pHrY9gb56jafPFj6rNJMUeuGyL4/i3cdxcJiCzn2PeDeYvNBaV6Sofv8NPN05jMkskB8iHD5VBGzplZzJq9tDGMSJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0D7jINnPCgMJ9845vZ07/abMw4JvPLYZhrV1hKL//I=;
 b=U0R1w/a6w7lG3n3KfRQ4HaCLyUGTeBXorjEuepeRfNfC8gC3StfDAEx5Ez9KE25DO2NXXh6TIGh5VXk+8GRmlMLrT3OowEsgRVc1ikaLnd3LJgp9w/DvB4oRhhvTxS3S2GCofwr1XJ/o/mfalTudqlMkK/f2FJh3lY6mudmNnglXxSHI5PfQhARIVO9YQo5/2J0SuMAHSnOV1gQb2CFehIxtqTOJCaRRONAIKndJA0T/PZyGUusEYy56ANZLXp5xd8rDEViapQXmwPvvJUKjR/RdXeyrnwN2DgvmJ9dnw9m0wh2lcSoRvGkzOz+RUj0YNc5uE8plAxpbzdqzoQMBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0D7jINnPCgMJ9845vZ07/abMw4JvPLYZhrV1hKL//I=;
 b=Z2TXMA6Ff/OqVz5YVLN7ltqm+RygbrnFCtM9HuuxN2cm92VbbgiFsPsKlnbHGV0C/89mGp6PmHiLRXVXtVuQwQmAEcIem2BDJ+WFnzNSCK/gmz0rOZbVE3kVWaHimi2V7mHjs4Cba3haYWhdCi80wETKrU9sLqZAhW8SY3FNXdY=
Received: from BN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:ee::30)
 by DM4PR12MB5277.namprd12.prod.outlook.com (2603:10b6:5:390::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:55:44 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::72) by BN0PR04CA0025.outlook.office365.com
 (2603:10b6:408:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:55:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:55:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:55:43 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:55:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 34/47] drm/amd/display: do not compare integers of
 different widths
Date: Wed, 14 Sep 2022 11:47:55 +0800
Message-ID: <20220914034808.1093521-35-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|DM4PR12MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bb385e-3b07-4538-6104-08da9604ff99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsrC+kOVS5JZ5afWWh0Z5guzU0nZpDwt0bmyk1gv2sItT8K4QWIFPLnfbZQU0UAXcnI35JNIncbJPqBOizOtbGgbj9pdVFTcXkIdlBAPbCzlZ5RXpZZ2lS2CiJazdgc4I7fmQuOwWS4Rt1QvmQbI3khDyuvwz1FNIB9s8vjrMAcUWfXaOCoCIdm17K9fWWxhwP5BuhI4wwwt05D/nRkZf/lful4IF4RF0K00fiJKiv+f8pObW8Onw53BkkOk7uxcoIn/1rqEVK6tt9q0D7L7o/4zWR3gd0dFwWtgiVFWX+OwVQSAzaGUAZsT/sCoidwqAx6KCSfQ5lq8QyTgAYAyrkdgQ8zqIA7zGe6zMHubKykLaCYHPMxlH4+omHAUEDacs4xAek9OwN5PTyqoGWI3a+b/GSlcdP9AxcTk5RlKFiFgrmYo0wePJK1Grk5FR15NPUYGYMOnnU1IwyF0cF+GUxbU8iNJincMW7yPojmDFOncIlyCq3AJzVwCUuJYm8kDlG3BetS5Ab+TVbBuMSDQJwV4nZIGolmhdg344Kk1N09edtNPKtKYcQsue2mDpug+VLVM9Qr3R+tnNa/DEqvx8oC4b5jrFCNJ7O0C/NhghmdO2gaKEHg/E9Rty8h4abTkV4xu35okFlCed9zTMxtErFiuJHvA4E4BrTt6tij8bNBvudUNZ1NRmINhglGdrGt/twhdqfQ1FGiyKZTKwSZedhQG26nFQ8sdBCZxKvdSyYoPT1/sF2AbcoyPTseulGXhVphyHxzwyoDRuy6T/H6cnvBdcforkMMn0bcEDA0bFiFbijnim4dzsB5S7QX4+v/n
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(81166007)(82740400003)(426003)(36756003)(356005)(6916009)(316002)(336012)(2616005)(6666004)(40480700001)(40460700003)(82310400005)(1076003)(8676002)(2906002)(186003)(70206006)(47076005)(7696005)(478600001)(26005)(83380400001)(86362001)(54906003)(41300700001)(70586007)(5660300002)(4326008)(36860700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:55:43.7842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bb385e-3b07-4538-6104-08da9604ff99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5277
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Increase width of some variables to avoid comparing integers of
different widths

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 4a1954fe3f7e..8c5045711264 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -940,7 +940,7 @@ bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane, s
 void dcn30_hardware_release(struct dc *dc)
 {
 	bool subvp_in_use = false;
-	uint8_t i;
+	uint32_t i;
 
 	dc_dmub_srv_p_state_delegate(dc, false, NULL);
 	dc_dmub_setup_subvp_dmub_command(dc, dc->current_state, false);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index c1261cb0e001..b8326d41810e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1354,7 +1354,7 @@ void dcn32_update_phantom_vp_position(struct dc *dc,
 		struct dc_state *context,
 		struct pipe_ctx *phantom_pipe)
 {
-	uint8_t i;
+	uint32_t i;
 	struct dc_plane_state *phantom_plane = phantom_pipe->plane_state;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 5490b3705b41..160aefaac173 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -265,7 +265,8 @@ void dcn32_determine_det_override(struct dc *dc,
 		display_e2e_pipe_params_st *pipes,
 		uint8_t *is_pipe_split_expected)
 {
-	uint8_t i, j, pipe_plane_count, stream_segments, plane_segments, pipe_segments[MAX_PIPES] = {0};
+	uint32_t i, j;
+	uint8_t pipe_plane_count, stream_segments, plane_segments, pipe_segments[MAX_PIPES] = {0};
 	uint8_t pipe_counted[MAX_PIPES] = {0};
 	uint8_t pipe_cnt = 0;
 	struct dc_plane_state *current_plane = NULL;
-- 
2.37.3


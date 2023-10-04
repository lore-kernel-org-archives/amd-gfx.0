Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5BAE936EB
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C09210E3C6;
	Wed,  4 Oct 2023 21:22:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE14C89EAC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldCULpScC4EEJBWGGlMa46vDMbxdAFR0i21bIH2OhELlRJvPfDZdUf0gFAiDs47u4r2UIVchnaQWdkpFIIYScA+5U7/6ntRZi+xM9Pnkwz9D8h5TNtWw7OLCsjuDIu2D4WEdY2LC+HMmNKPu1//IkyB1OIR8JLNnqgk1qE4XCvyxdOwSGa2lUxoKrG9BdEYukMjdctrcnj9PkXEtridw4kCEi45fppEpDth0PR3r4c8//lfZ+Q9D099nG4CGdCQRIAKr7z5iCJfrX2FNO/tBD0i1sdU7dUptfiZWPXsrBEmovGyCt90pcUExA9mS0XYXkCe4qMMTWZI3gv9KS6RbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9o4Bv4bXrLr97AE5pgPVrQSlENNfvIKpScW9d7aVlk=;
 b=MvSxRGE94VOIar4WTKtjrF8XgZwDPIH8PUUxlWZsMmvFSUFrJ5Dgjz8C/ohn/SR8v4pZmrOEW/ZOCTWB7T+cYwz9PVGFTpsMBFIWPEC5SzCAnaeNPqura4YjtOmyGlMFxE+s2g+bJQt9a8JgBowmDmLzisJUjNFxBa6nxcreBmwHfjvfjMaqkuBX+2IeJSBJ3QOnP7oDCkRzZweGeneTldimy8cTJ1vnrt3WSfD1jACMsmtcCQA1rcwNCAjz/s9N7HHgPSBTdZlEZ83l5xRwk3PYGQTT5zF8D2xwdGQ5lCIIpOPyzMbJXI0C8L+8tuUyj1Qfagh2sMxnmA9svahVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9o4Bv4bXrLr97AE5pgPVrQSlENNfvIKpScW9d7aVlk=;
 b=BqZu08vkxEt3foOiGjX4CDt7aGUSw/8ASB4y0APZenrgQp6bFFoBAJYvGpn9rqDBev+9xiNe0wdF+uVIq/KiQOTvWS8OrUkosKs2We6AxczAZZyyPpC8mtQrEHUKLi2/ezg+0T02eorXX6+xYOlij4HG9eufPg4fLQ7Wv+I3f2o=
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 21:22:10 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::ea) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Wed, 4 Oct 2023 21:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:22:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:22:05 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 16/16] drm/amd/display: add check in validate_only in dml2
Date: Wed, 4 Oct 2023 15:21:10 -0600
Message-ID: <20231004212110.3753955-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a87300-005e-4d5c-1830-08dbc51ff89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTOQN3kgLxa92MZILvjX5rp/jIahdnbx39IykiW2BoTCeaOaIM1bb4sSQaKcfTAec7BK2gwngobVDG90iqLLhfZN6KMAYUmLyBJULEMS19hZJGzLoigrMyIgOqp+4rbYAlhQktE9QXrZfb5nS8/A+WAyDfIcs7KRvqEMRHOgoegGd9c3JneUqCWsyqfFtMUpJ22dfIlV8teExF+4mmG6afl6aLi9ZJ1InU7tSxVS9AD970A1soQCw9H/QoO29bMwAmjiYUXXd+vXP+04VwpkTpNvjCdbtKnrs1hRjpq/6BewzlCSU5i5Clw//lyvGnTvSk4eW9zwuQ4NJtC0Y3U8yuKseVYp6HM+sNutrTDJ/Nv0m5w6Ui533UoLcHVYHpL0h19GFrnfTVdr3u6isTdsTOrfFyAk1enV4poMdLFT8A+QHnMBhWsPrDY2/VBigob7jSwhdGHVe62G4W4EuGqc/e2AoRZyJU2ffNTJpCfYDEDDRjFxLaQXOR+PsEagQ8Rq/DJoFfiDz5aHjH12SyiZxUOfFo1y9pPUD4zyIWAqr7Fly+OMld6qUmR7smjd4KT5mTNJHsFCBKudaIn/bbTRodB32PzTmsX8WlkkUecuohPyCIBdkQOsPIJrgcGqnmqg6ZzhKU3VjeAZWwWfnN4EODjSTRu3C1Iqtj9n1CTD3etrcWGxXODxGY5Y0CAnEaeKmausXXLYcBuXHpNgQLdJmviVaq+nHu1XxfFvSlt3Ny15rEyB4i+xbnoMmDbiP21F9zJ9rQmB1YEKcxeLkMuWlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(478600001)(6666004)(16526019)(82740400003)(36860700001)(356005)(86362001)(81166007)(2906002)(6916009)(4326008)(47076005)(2616005)(15650500001)(426003)(336012)(26005)(83380400001)(1076003)(36756003)(70206006)(70586007)(41300700001)(8936002)(54906003)(5660300002)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:22:10.7353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a87300-005e-4d5c-1830-08dbc51ff89d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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
Cc: Sunpeng.Li@amd.com, richard.gong@amd.com, Qingqing
 Zhuo <Qingqing.Zhuo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com, Gabe
 Teeger <gabe.teeger@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

[what]
does_configuration_meet_sw_policies check was not done in the
validate_only portion of dml2, so some unsupported modes were passing bw
validation, only to fail the same check later in validate_and_build. now
we add the check to validate_only.

Also add line in dcn35_resource to ensure that value set for
enable_windowed_mpo_odm gets passed to dml.

[why]
Immediate black screen during video playback at 4k144hz. The debugger
showed that we were failing validation in dml on every updateplanes().

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 2283daa45318..828846538a92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -2072,6 +2072,7 @@ static bool dcn35_resource_construct(
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	if (dc->config.EnableMinDispClkODM)
 		dc->dml2_options.minimize_dispclk_using_odm = true;
+	dc->dml2_options.enable_windowed_mpo_odm = dc->config.enable_windowed_mpo_odm;
 
 	dc->dml2_options.callbacks.dc = dc;
 	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 11c131f6cf26..9a5e145168bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -659,6 +659,9 @@ static bool dml2_validate_only(const struct dc_state *context)
 		&dml2->v20.scratch.cur_display_config,
 		&dml2->v20.scratch.mode_support_info);
 
+	if (result)
+		result = does_configuration_meet_sw_policies(dml2, &dml2->v20.scratch.cur_display_config, &dml2->v20.scratch.mode_support_info);
+
 	return (result == 1) ? true : false;
 }
 
-- 
2.40.1


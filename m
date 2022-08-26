Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932C0ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D38010EB74;
	Sat, 27 Aug 2022 02:51:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF3410EB6B
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDUC2F4cLBz8eLkxYO2N6a2kYHD3Zwe+jngFLa1if04MqBDoQ8ummqSlwQpW73xfaqt/J0lzMfxki8f4o670n2ohHop51/gvaSIVKPPliaiYfgLEHa2EOm3ujW3Y/Nv2u4NAZHQnK0XsQu+NdmAGLKQ2VhISjiU0UDGHKilDbVKxo7if7w/gI+7cMb7AsVCVIQUV+WRA6uxag4AwiSjMALYMrKP33u5GK/AHEUDbJnsnmepq3da8uF3cwwiNO1L/Wiiy8rkDPAHVaj61upeqbdue5YXzw0D4+K+xx4DVJe3nlm6mT65z1ge+kVWwzBRctJ57d+cvowxwCSPiA9gjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlD75Hs1dmDdm7mDxnAhAt7kHyDe6urxT7ujl+j6Jgk=;
 b=K/Eyo4eMNKTYBd8gip79FXc9lrTp5rtPSu+b+kMTw8+rswp+EwMMtbN28iAI+GUZAy6NTuoeLGkCvF9tToPoAl5wpEP9bsnUxAjTjPFQFT1KnZWBWLJhsoW863QB5ewjLTsx4xvObmim6bbTOtoL7+mFQhdnGu96R2CjvEtp8kkLAa6+i5ey1PAybxRO4EKb3dH6zJZgbmLIGXfQhPNAa+vW8ex21zRO6zEeq5R8Raw0abjwrBlIEmPKKwvdj7uqKgno1iP0rleUXXFUk1K1haooIQhn3MyrtkilCcBbOQozX/puHcg5LzrM9AyO5M0Y7EsZYU3gc5EgZZBBpT25EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlD75Hs1dmDdm7mDxnAhAt7kHyDe6urxT7ujl+j6Jgk=;
 b=fWtLY1z1t9qXcaesNYpnrwInCGNb5c5/Lva+rFr+DUo7h4JrEC5BJxIbgR2VZq/UYFVd2F6rRrSzC1mM8tk94Ipv5l7rHvXTwmNChnjHRSTC56luyOg2fDw8ssix2F8wbLdVeRr4tNYpJohJhlSwjXrGkZz97sFLGsoaBHWouJU=
Received: from CY5PR22CA0061.namprd22.prod.outlook.com (2603:10b6:930:80::6)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 02:51:13 +0000
Received: from CY4PEPF0000B8E9.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::98) by CY5PR22CA0061.outlook.office365.com
 (2603:10b6:930:80::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8E9.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:51:13 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 19:51:12 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:08
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/33] drm/amd/display: Cleanup PSR flag
Date: Sat, 27 Aug 2022 06:50:33 +0800
Message-ID: <20220826225053.1435588-14-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8275eec-78cb-419b-875c-08da87d70153
X-MS-TrafficTypeDiagnostic: DM6PR12MB4404:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raSTL7YgP1Blid1Ej4ZNr24UnLTYcKE1PWcCXgCi5ONelsjcv4AeBdjPVmiDmtatERUSVczeWxk7E67e0Uy4w/nClA7OyyT+W2Is2gdPi2q4/abOxLPBTUJML7A7QBiehWiboTbBf0sqmCVdtgyJUGPMUXEkIDmITHIVx8f+Ej59t55QjWWk/MQ6JD1BWlkvdPv3/i2tm6aqsBoi63c6S0hlTlDr5JxGRAuk6jffCz8P14+H2rFiToFjZJ9/c9g0fXXj7j3Mz1ZKw3ZxZ+iGcMpYuFn+AkiCieitTZ6HC9+F4w0KE2BC4k0SIiJ4kMFrUcDmZHWraZGOR38VIu723O+aAM/A5jPwf3Nj+2LA3x1OTnIx7QgsUPlFZ1IIZ9Wpyz8SX9Pcd8hysqw01JAKvjyO5ExUDDDsLhjQjWHpkGod2YBJ2oqVAi7/WfFqkHJVByLU8yeOJY1mVZIi1exx+xfw9F2c10g5+5shSZSEcPJXp/sPw5k+3rCIvKNVIF+/YiMChG+BZlvUt2tYxMMed1kPhZq8fdrBcmY510Grw8i9ngi9x8k4LkZp5A4G7tVGJ25uUSkYSJMYmMgYAMaSZYZLmdllbMu44m0SpHxo1mnNqz8sEJHt5rhIzvpyq1VrWcfORC4h/If0WsZteg69WaqbcQnwctIay37tF9pOR0PGuWgK/bd6ju31iWFew0GlF367RzEEHY3xH2QVKZ26LYJjMJu5GHWaZL3aIHw3B0FtwfGuhWQ8uW/vJUFT6mlyfaDQ3WBpTEKfWiiV1XIEUyYNoWqmkKxFGl9G9kXyZJojcfIjOoJ487iaQZFvUCm/1oVUtriyqWUfDcZ8ya6K6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(40470700004)(36840700001)(36860700001)(4326008)(8676002)(26005)(478600001)(70206006)(70586007)(5660300002)(8936002)(41300700001)(6666004)(83380400001)(2906002)(7696005)(40480700001)(336012)(54906003)(86362001)(356005)(1076003)(186003)(81166007)(82310400005)(47076005)(36756003)(426003)(2616005)(40460700003)(316002)(82740400003)(6916009)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:13.5066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8275eec-78cb-419b-875c-08da87d70153
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Gabe Teeger <gabe.teeger@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Robin Chen <robin.chen@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
enable_sw_cntl_psr flag is not needed.
For PSR1 and PSR2, we should be passing
dirty rectangle and cursor updates to FW
regardless of enable_sw_cntl_psr flag.

[How]
Remove enable_sw_cntl_psr flag from driver.
Send cursor info and dirty rectagle status to
dmub only in the case of dcn31 and above.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                  | 8 +++-----
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c     | 1 -
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c   | 1 -
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c   | 1 -
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c   | 1 -
 7 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 95daee11a445..1ca76708705b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3113,11 +3113,9 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_state *stream)
 {
-	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
-		return true;
-
-	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1 &&
-	    dc->debug.enable_sw_cntl_psr)
+	if ((stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1
+			|| stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
+			&& stream->ctx->dce_version >= DCN_VERSION_3_1)
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 473e6a0c3310..cffb91363b52 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -827,7 +827,6 @@ struct dc_debug_options {
 	int crb_alloc_policy_min_disp_count;
 	bool disable_z10;
 	bool enable_z9_disable_interface;
-	bool enable_sw_cntl_psr;
 	union dpia_debug_options dpia_debug;
 	bool disable_fixed_vs_aux_timeout_wa;
 	bool force_disable_subvp;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 1eb3957f52a3..2118ad3e37d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3343,7 +3343,8 @@ static bool dcn10_dmub_should_update_cursor_data(
 	if (dcn10_can_pipe_disable_cursor(pipe_ctx))
 		return false;
 
-	if (pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 || pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
+	if ((pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 || pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
+			&& pipe_ctx->stream->ctx->dce_version >= DCN_VERSION_3_1)
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index aedff18aff56..8745132d6374 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -889,7 +889,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.disable_z10 = true,
 	.optimize_edp_link_rate = true,
-	.enable_sw_cntl_psr = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
 	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 3a9e3870b3a9..5e62527d3ab9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -911,7 +911,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.optimize_edp_link_rate = true,
-	.enable_sw_cntl_psr = true,
 	.seamless_boot_odm_combine = true
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 7463b12ae4a3..eebb42c9ddd6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -886,7 +886,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.optimize_edp_link_rate = true,
-	.enable_sw_cntl_psr = true,
 	.psr_power_use_phy_fsm = 0,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index d56a212e065c..f4b52a35ad84 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -886,7 +886,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.optimize_edp_link_rate = true,
-	.enable_sw_cntl_psr = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.25.1


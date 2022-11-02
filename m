Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D795C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA98E10E4E3;
	Wed,  2 Nov 2022 16:03:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A349E10E4E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb3F1qUAbtL1kVO0Z+waLHWXFq5IITws9i2clrOyziR3NOySE7TvKgzSlECsZZgFbt57Ffxl/Nw/4SKfSmI5g3Q7JBEpCkHE8F3sLFXl9H4kSwA+yfqHWZD7Ejn3RMScxiYqykD0h16c2M68om9iw9CuTeyiCM+Slw2FzAVuWMpuf0syLbPT+QPZvPSulF9Z3dJ4Ed/JV5hv8V0z5ZrDLxcr1Cu6a2nrkB2y9lwpOKfBi7AbFeCvaVEzPkGasFLH6PSx/nHVbeeEdBtGbQtUBKIdP+vTnVzdBnegrHe5vO/PzIiWX5uWtXWSzb589vMLhCIUzyJ1gIHOx+tc/plifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8CzgevNrFkK0JDYDgEWh3aiWaTw+AcZR3jiEG+M+Wo=;
 b=f6gSIGyf5NnETWq2O6jaQu3LSxE+s7se1DD3hiRy5NMLPM+djv2McwHpG106LHQO3hjXGCE1pIfG0h9lb4SPJJD7wPqpR4mVPOGE2SvDnrcyZ19wBf3JymOUv4XGx4UoiUMfZ/dUsNX02o+g5IwFo5KSLCXduuA0yCRxwEQ+qHPYx+De9qWUo9QErUBBR49mGfHKZNccqCnmwbFb9a8dOixMopfggekfDdlTvaW4Iw8A0yQrNJGHag6x8vA6coNEy1myKm8TQ2LB0yTshZkpWfdy5NagcKea+tslRQZ+t4Y7DHejpk/c4vAtSOAElCo9WpjGMi3FZtkem41aXf8wmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8CzgevNrFkK0JDYDgEWh3aiWaTw+AcZR3jiEG+M+Wo=;
 b=vUMx3YFCwhuRK4i2qFEKhQy9krGiwqeCm1I/OGg6OKjyHjwCxQLZLsCHlTvdZEsEtZW7CYGSgqjV7ncOfR7HGU0o0ngnl+cNAuptoWQKu7poSpNDwGiXztkgTRFXNxeSvSNFzEIrlCGMLFZNFIE8XWhZn31mna6NiavcQPFfwxY=
Received: from DM6PR07CA0085.namprd07.prod.outlook.com (2603:10b6:5:337::18)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:03:22 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::83) by DM6PR07CA0085.outlook.office365.com
 (2603:10b6:5:337::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:22 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:03:20 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:17 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/22] drm/amd/display: Update SR watermarks for DCN314
Date: Thu, 3 Nov 2022 00:01:02 +0800
Message-ID: <20221102160117.506511-8-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbc2234-6b60-41c9-b907-08dabcebc467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aArqVvThL8MnMYQWNtTUmBNnv3Mfk+eyHtD5TV+Lwc1578AxU/KBcA4z1TIpgp5aL/1llCLVZsmQqVRuh6xcnKzlwO1L1ccX92q2vga/XGvrsYDBNocVY79jQw+KVt0cE+nM/CNa6CaxfYwj5B3WuPb7VwXWdHDH5EVqwcRvXYS46WLiFTlzMhTZJNZogiz7B4T+HV6X8stONaS6YLhsDl18MXOPxWFs/vPR33HI5OoPuxhkoV2RXbcskdq4+qTc9cahXWzeI5NteFrZk/0Tw6ymCx7YCV99/+Kv/scJsw23hlnK+YraJuYFabgwwVI/Z5LWz2IHFJRrw4quMeOkXIi0fY+BjGNvKJpkFaQJjoAoCIP2UffJSKN0QnH2mMaDSrYk5zKOi/QjPqM13ijA65KVwwu4Dk9H7rPqGYJ2GVPgbNLMWGJ5fHKRr8uu9vIsbjoTuf/HPd+hQqA4KtGODPOXNKyLJkIh1FSSfP+lgJbIcnSTADcKg/Yphus8MTnjy3IYOi5cZRVADfzthRqgC6yeeLfQyo3uQBUCpUf4etxKpumZtPHK+IbZj9Sp1CMOykyAX+lhIil1RGVJ2LMz+B2DuKYi0Xs/aKnb/uncVSX2S5KqUCrzu7TYm6YcfzpYn6RIRgWkUuHxipgwdTtWueZHfI5yGRFoGJJ27LnBMHVamfK5GyOqbQ1X80HAt0nIqTx+QXYPSsw1CZZFVy9XAWklQOod3dRCNBA33ceBaU8ZVr2yh6ASM3J1o3VjGPJELP4EXmuTAyjeTe1J1NWok2QiKjlzviKoorZFi5HOFc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(426003)(83380400001)(81166007)(86362001)(356005)(36860700001)(2906002)(5660300002)(82740400003)(47076005)(40460700003)(4326008)(82310400005)(8676002)(7696005)(70206006)(6666004)(70586007)(336012)(478600001)(186003)(8936002)(2616005)(316002)(26005)(54906003)(41300700001)(1076003)(15650500001)(40480700001)(36756003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:22.3721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbc2234-6b60-41c9-b907-08dabcebc467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
New values requested by hardware after fine-tuning.
Update for all memory types.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 32 +++++++++----------
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |  4 +--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 1131c6d73f6c..20a06c04e4a1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -363,32 +363,32 @@ static struct wm_table ddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 9,
-			.sr_enter_plus_exit_time_us = 11,
+			.sr_exit_time_us = 12.5,
+			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 9,
-			.sr_enter_plus_exit_time_us = 11,
+			.sr_exit_time_us = 12.5,
+			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 9,
-			.sr_enter_plus_exit_time_us = 11,
+			.sr_exit_time_us = 12.5,
+			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 9,
-			.sr_enter_plus_exit_time_us = 11,
+			.sr_exit_time_us = 12.5,
+			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
 		},
 	}
@@ -400,32 +400,32 @@ static struct wm_table lpddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 11.5,
-			.sr_enter_plus_exit_time_us = 14.5,
+			.sr_exit_time_us = 16.5,
+			.sr_enter_plus_exit_time_us = 18.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 11.5,
-			.sr_enter_plus_exit_time_us = 14.5,
+			.sr_exit_time_us = 16.5,
+			.sr_enter_plus_exit_time_us = 18.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 11.5,
-			.sr_enter_plus_exit_time_us = 14.5,
+			.sr_exit_time_us = 16.5,
+			.sr_enter_plus_exit_time_us = 18.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 11.5,
-			.sr_enter_plus_exit_time_us = 14.5,
+			.sr_exit_time_us = 16.5,
+			.sr_enter_plus_exit_time_us = 18.5,
 			.valid = true,
 		},
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index cf420ad2b8dc..34b6c763a455 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -146,8 +146,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 		},
 	},
 	.num_states = 5,
-	.sr_exit_time_us = 9.0,
-	.sr_enter_plus_exit_time_us = 11.0,
+	.sr_exit_time_us = 16.5,
+	.sr_enter_plus_exit_time_us = 18.5,
 	.sr_exit_z8_time_us = 442.0,
 	.sr_enter_plus_exit_z8_time_us = 560.0,
 	.writeback_latency_us = 12.0,
-- 
2.25.1


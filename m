Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E31ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D551910E821;
	Wed, 14 Sep 2022 03:56:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1116010E821
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmRXd45gpJ6zoHm8axAe+KE4B/6iQs7rLx8OOInE/JDw2QVieDQOGo/i/bw7MmYCvQViInkWzpZ/DBSLCelJOlclsclu3nSQCgJCAvWXYcjTmhr5b6wcn4groY5S+eytw8vQGEFRtyYd6UoVIt8m0nKVjyekp02QmjSyGLDa2TMlO5QsJtOazV7l9bw7BJPjvjN+ux/Mi6oP51fcnegy/cxu4TMP+nckJ9yL8v6lhrIv2HTHYaGnXCYP+nAQ6cJWQsuO37oUAhpmA+1eD8cFfqywIeEepFDfPZJhgYMwCVIrBSoTliNMg0bQKiWqICYBCyBArxi+nqC9ss6kQaThFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epxRgeucK/L0gy+UM5eyiCWDm3mZzA8O4Z3MPeg/poY=;
 b=WpuvtMenJ6XQwpV6bv1ulcXM9TF3MdWx2/7QHEc7xS5hzqoaUJ2wrG/wcyFH4fxujKXR5NzTV6CQLkeXJ6e+FFGX6KfO/hIKnehmqcbNnUB19sv01lzTuZgeCuFYSJ6QW5rOwkzmP47nRlkwtWiU92JTd3Tl7zqUS+aMl11/ZGK5QkYwmZZ7zbGGHCS3LklyQGm5koU1rJ6aXVCVl+95D6eIZGugDFA0DOU43vDA9GKSR07Gm6xJ+8lpkTv3Msuj+trt9VUjLACiT4Z59Op4sWp87/j8Mef1sZx8TGCp/lEX7u9+GfpHIqhKjKFI5oJU+U2JhmDt6jQT+2gmXY746g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epxRgeucK/L0gy+UM5eyiCWDm3mZzA8O4Z3MPeg/poY=;
 b=b785N4FCe6hd4jii1uwHITZf5vPQAgljm2vUVjpqgTlHLXvgKRGP8p9kdsOcj0rOlwbSlxf0AUE3D5WK8lLMHfhb7si2N++ROEsGK5t/Tmh2pBRcGo519a4NsYnVVXIpOI3VRVwKxK+NsS0lp/5rdF9pTT+Bs5qXVQKHO9GissY=
Received: from BN9PR03CA0267.namprd03.prod.outlook.com (2603:10b6:408:ff::32)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:56:50 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::62) by BN9PR03CA0267.outlook.office365.com
 (2603:10b6:408:ff::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:56:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:56:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:56:48 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:56:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 39/47] drm/amd/display: Modify DML to adjust Vstartup
 Position
Date: Wed, 14 Sep 2022 11:48:00 +0800
Message-ID: <20220914034808.1093521-40-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bb6f7b-d236-419c-bb3e-08da96052741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4kjUC/Ih6K/HjXzt06d6ejfPf/cZq2MnmmsXCe9vBhVbH9HizR4Ty4c8pnl8/p+Q/L3ylLFt0dn/EplIoSV9W6bkRG6EW6bY/4s6XOJyEBFQptDb/450qAgQv4h4VOK9BuU2b1N7kVBUoQ0wkHnIjxJ5rPhfzJI9cFx77eVUmIPRkMZySJG7UYcQUM/+T1PQ0X7J9uxF+r/pCqTzbiyyoaVC3I8Rsrpzi271ZIXt9CgFqgxEEXJfVPe47pE46WPHRriYWFX6axX6DukpkL2GozPuiPoVsrtzFmdsiRTMzz8/x188D6OgFYQpJf4OA332Xg8v9BUmJikYBwqlhVg8nB/kWfSI5wwMM/yTqxoDzhdY58YEl79EQ33v+Id5BVCTmUtdZ0y8eGd671fYxflV8PJa2bzgvdp0DDuNmozGlQ61u1Bs7e5VDzdbGwbV5MdjcuQhulcD/SGr+wHxOMHdoHR/aQLWothvq4o57aluHnltXrqNqv9brHmsHMt2jjzJ2wG76I2QzbCf6o/KioQzhBFgHTlOARC7zzcZRgWZ6frED3rNhWDs3E2QCHCV4Y6SaI8e536cy52nrQ7REQYPyVcA78ILM+24DTbqX/sgHDi9zz+N6Wa3aOSe1xxaW/S3xrdjc1np0zqt6jiGyBKDvyZOPkZeoVHtED3ieRJWeJ9dP0qi0gOQMKEYf9cXH04mqpr9fTC16IIKJDZdIzFG9oKA70wh2i20IHi6W4mnO7JHuq+X7/SffoS+wISNGwbzfX3f3DxG4uLKIKDePCKKnnO+miVyWu3Bhht/1y9o2c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(316002)(82740400003)(356005)(6916009)(70206006)(70586007)(8676002)(81166007)(41300700001)(478600001)(7696005)(26005)(54906003)(336012)(426003)(186003)(19627235002)(6666004)(36860700001)(2616005)(1076003)(47076005)(4326008)(8936002)(5660300002)(83380400001)(40480700001)(40460700003)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:56:50.3187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bb6f7b-d236-419c-bb3e-08da96052741
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, muansari <muansari@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: muansari <muansari@amd.com>

[WHY]
The Vstartup position should be as late as possible to
maximize power saving with the current. Calculation of
Vstartup in DML does not take into account as SDP signal.

[HOW]
Made necessary changes to calculate the correct Vstartup
position in DML to account for AS SDP
* Overriding the VBlankNom value in certain cases
  otherwise it will use the default value
* Bypassing the condition for adjust_sync_Vstartup
* Overriding vblank_nom_input with VBlankNom that is
  set in the SW Layer

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: muansari <muansari@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c          | 2 ++
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h       | 1 +
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c           | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index ce477c090987..cf420ad2b8dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -323,6 +323,8 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
+		pipes[pipe_cnt].pipe.dest.vblank_nom =
+				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
 		pipes[pipe_cnt].pipe.src.dcc_rate = 3;
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 2829f179f982..73e6579c6f54 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -7407,7 +7407,7 @@ static unsigned int CalculateMaxVStartup(
 	double line_time_us = HTotal / PixelClock;
 	unsigned int vblank_actual = VTotal - VActive;
 	unsigned int vblank_nom_default_in_line = dml_floor(VBlankNomDefaultUS / line_time_us, 1.0);
-	unsigned int vblank_nom_input = dml_min(VBlankNom, vblank_nom_default_in_line);
+	unsigned int vblank_nom_input = VBlankNom; //dml_min(VBlankNom, vblank_nom_default_in_line);
 	unsigned int vblank_avail = vblank_nom_input == 0 ? vblank_nom_default_in_line : vblank_nom_input;
 
 	vblank_size = (unsigned int) dml_min(vblank_actual, vblank_avail);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index c596187a1e09..f33a8879b05a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -510,6 +510,7 @@ struct _vcs_dpi_display_pipe_dest_params_st {
 	unsigned int htotal;
 	unsigned int vtotal;
 	unsigned int vfront_porch;
+	unsigned int vblank_nom;
 	unsigned int vactive;
 	unsigned int hactive;
 	unsigned int vstartup_start;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 503e7d984ff0..03924aed8d5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -597,6 +597,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.HTotal[mode_lib->vba.NumberOfActivePlanes] = dst->htotal;
 		mode_lib->vba.VTotal[mode_lib->vba.NumberOfActivePlanes] = dst->vtotal;
 		mode_lib->vba.VFrontPorch[mode_lib->vba.NumberOfActivePlanes] = dst->vfront_porch;
+		mode_lib->vba.VBlankNom[mode_lib->vba.NumberOfActivePlanes] = dst->vblank_nom;
 		mode_lib->vba.DCCFractionOfZeroSizeRequestsLuma[mode_lib->vba.NumberOfActivePlanes] = src->dcc_fraction_of_zs_req_luma;
 		mode_lib->vba.DCCFractionOfZeroSizeRequestsChroma[mode_lib->vba.NumberOfActivePlanes] = src->dcc_fraction_of_zs_req_chroma;
 		mode_lib->vba.DCCEnable[mode_lib->vba.NumberOfActivePlanes] =
-- 
2.37.3


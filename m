Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37505ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A78510E854;
	Wed, 14 Sep 2022 05:19:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3BEE10E850
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8bZ62gdo2OmVveE76tNl6MprEAXeomOMY5MTQICHnZ33oXXBcvMhF4F4D1AemdIzeCoo6gXYSiMvTQt1h7kJAUjJVPyJZjXRTuR3aDW3qF0o93gWx2P4ym/Y3x+c6kRadxgvaq4idoHJxXVq4YeGvUbUQqfNDK08H3qUxuhsXkKEvsc4rUMe7A5O3gzwZbztpYMuaZpxeOlJf2tilJ7QTA/qpcgbnvLOO8vkxUotCNdzRJTzEGi5tS01Vp9gkX1m2k8CQdRpPlsusOpTObTX/oPUjS9y6gYv5Qe9IrSXIqGV23EnpugoETAdwaPEAGZxyCEvN9UiTk8PZLr8qC+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epxRgeucK/L0gy+UM5eyiCWDm3mZzA8O4Z3MPeg/poY=;
 b=Vthgbu4LHfHyNNjcFb+wDAY35Orl1xh0jXfzsI5XyrlgZiBq2itrDrI4wb1bBEu9PJv6vziXqUiu5h2VtreB3qdG7h4Bkc4nZJvMDmtDUnguLaAQGgp2gZWa8XJ+TP38JVMvvc/cugoFDV84Byto3y4OWTMASsAJ7VmbylwE20ZxTGCYRuAj2fVqBNaHF1eQDZBTbtvMHdarsQnDipOiQE9rufezrm88scot0TibGsB6lGYCB15gt7GrkjdZi2q0o98AElM9ZoofbQEjQo3ZvUd+qq3DG0tP7H73C8JdJxMbBZMpNwJlnOJax0fvLOEuz9OEhw8UQMZdPYpSTR96vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epxRgeucK/L0gy+UM5eyiCWDm3mZzA8O4Z3MPeg/poY=;
 b=455aWTHNO9+x64R2BY5haoSuvN3AvYa11JZl2SLy0jJP48GEZ+bIVNS0WjOPIJlkO+j0lzjU5VP4D3DmlVEl6e9WuI11hP7ByO9VgxpBtXWZySFixC3FBar5Za4TsbUN5ZMx6jcY+nTUso3JwXsGpJAxmE/DLslxAseKiUc4s0c=
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Wed, 14 Sep
 2022 05:18:58 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::8d) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:18:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:18:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:18:40 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:18:19 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 39/47] drm/amd/display: Modify DML to adjust Vstartup
 Position
Date: Wed, 14 Sep 2022 13:10:38 +0800
Message-ID: <20220914051046.1131186-40-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b115e5-366a-4830-795a-08da9610a094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrMRKNwmYaDv8jw9e3OHLPxz4FTXzrIaujSudDOVeJ9VdeMDhrMxKN2b/SQsOnmG03yY5jA4vwsXszHn7rT2lr06N05z98/KCtvChWXZzGcJv9jdH8goduulA9hzlFzT+IoDYjV2+UyLhH3ibV4imXjYtWBjD1kS3zw3+XZpui97tD4Ht6hZDKHH3R0RwGpgf6oWUkaOf4QEt1sNkxe5sAFRCZe9JJS6NLotww8enr7WsQLsV1ySvveSeuH7HAYM1zilbWfZzJv+/MdCNP2+gzAjhEkj4cAQms0hETFTlflp1k8+Ui20NidC6+prBKPe8ByInYw6ZADl02/2MrrWhR45WwyB3FiNYsPK8eUUPeZHmmh7GygwDrTcBybWLy2jKwNhhHLFF0AakVMEjEaRiZVX5h1t//sSDCzggpRaKVuNG/nNNANBhc07vk4x21jSs5q6YS3RRQDQz4MEoSPwSWzmPKXubqZCgbnv46MI+M0KjgE+YraAXvHXZAH/vFSshZeI+acFiDI5wbe+cop1+aYyQDYDZjdqC6jGQGlBCXQYzUugXLp+mXgnAxL06r+nCtI4TEZ7W1Y2famT6SKVpeF4Kz4gBz1ilPXJs0R8ogs6K2Wcc/Qr6gCEM6CscHB6VNi+M24jBb/C/O8pIRcqS8/Tn+qMnandjcl8G+inKCQiuTffK/BQ6d7sHyDThHzCxiLYO2v4XARjixZob3LHVWvkJ4ogJpKaSEzgOKPXjpfxEEMVnt0bA54oLzJVtPxTAKF/GiSS7dflunLVuMagUVJ2F+mX5LH4Vi7ldhsbcqCBZHphVPnC80Fw5+YNjCh9xCjQjkD1AtCrbKB7+HIEq2tPUKLuY0IlUoS3PfcyVKM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(54906003)(41300700001)(186003)(19627235002)(1076003)(2616005)(356005)(36860700001)(70586007)(26005)(81166007)(4326008)(8936002)(82310400005)(8676002)(47076005)(36756003)(82740400003)(336012)(478600001)(316002)(5660300002)(6666004)(70206006)(83380400001)(40460700003)(6916009)(40480700001)(2906002)(7696005)(426003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:18:58.2199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b115e5-366a-4830-795a-08da9610a094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
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


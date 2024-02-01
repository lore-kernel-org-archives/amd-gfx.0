Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1614C47DDF
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 09:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F96E10E413;
	Thu,  1 Feb 2024 09:58:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50FF410E421
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 09:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmCuelDFUI+wx2NhIXU7wiHvyidKWntfW3w4Tc3UGOcyJmNdu2GQc6itOZy4CHIQqkhpZqU/YqMPsGnLO7B9N9KzxYhhLNfG3H84pqTG1QB4Iu+jKvdBZyr1r6vqOoANg2A0jsGD8al6neK3m7NDyc9JkQgITJHQGhUeqhaL401ql3fJ+g9IGdVnmejxcJ/optD6ojkZtxG2YTC2/eMlCnIB1neL1DJ2UKS+ZaK+ii9lzx2Jqlk5s+WckUMjfICVqHSmubekIsdX7x51Q7USC5ituUOiFncy28i2D9ouSR8R8x3NPQCs+fjMWoikcHr3bV1PFq5q8sls1/4A4YqN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxK5RG80DxperA2rnDWjoh6sOToEPagrp+abDogCxDU=;
 b=hacN9jvFco4fF9yNeaNwkUA3txhLgzeqcedJl56OVlJaUH6LFojjvGSb40Ow83CJKnCBpc0HilbeMZFKukRme9JPQLlz9e7rMjU+qK5qUaNeVwRXzWvhmgj+nH5LBLEXWMh/4GWWq03V+UQAEh0qHsolB52hmJu9HFpRxyDLBtly1ei/pGotkzffdCgMr9RJOsFlnY+7A2v/081HH52Dx5mRRNooihit8KTemWuNIfy+BukDTbifAKNtJfJNDoQT1RuWamKMZTRvC187HA7q9HZXQZa/Eqj7NBsGeqj6iCYHrcR353BNaJHlhiL1tEjxxXyDlB1xU9M00UbuvUVaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxK5RG80DxperA2rnDWjoh6sOToEPagrp+abDogCxDU=;
 b=D5H6EEeJ6ncZ26xqF7AGtIOT5PltYhxOfRUVqrpudslu3mFCrggarS51/eXr9Lrr6y2ZoAnh0YkVMgEh6+0Kql6iZV97yp3PKckIQRJ0KyEMpfkueqT+SrL9ar4HoC/yUdzb2ETO7iOrKVbClYU6v323pjZrDJ3ErD5NZsIZ630=
Received: from SA1P222CA0103.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::7)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 09:58:37 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::f3) by SA1P222CA0103.outlook.office365.com
 (2603:10b6:806:3c5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 09:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 09:58:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 1 Feb 2024 03:58:34 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH v3] drm/amd/display: Fix 'panel_cntl' could be null in
 'dcn21_set_backlight_level()'
Date: Thu, 1 Feb 2024 15:27:12 +0530
Message-ID: <20240201095712.1171428-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131030412.692179-1-srinivasan.shanmugam@amd.com>
References: <20240131030412.692179-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0fabb3-e0c4-41b4-fedc-08dc230c5c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guLBZiBV3Oh0tq/PjMMbXXDAs3fns8cMTvu4xJfaK0nZYJeb8/zFfCfOEvV/Brhp5zx/1AKQYFEqCnJc2h+Lv1UWO67uFrm7YbMvkbvTfCDnazFfBu8hGAcHTl1H+FgooEmg+uc2p8eGlct1eobtiLBpFFOmBy5wHKPG3cRKhsM0CvhkD6nAMSE0ewqLJb9VegX2K3D1EuO4gE18g3B5aTA2zSaCulPD+OFD6eq4JrByfpMJIqvRi5EVdzhVDuF6cyhjvwJQnTvk7KMzCr+nTjKHDeMYvKrlmg3FES6/Phv6Yj1g7E+KmR5muXfl0mDQ4lzjNN32dJippG5LHpucSvDN5PdbcXEhdF8ui/J4Rf52YOAw4Cd/doSrj74jW24HB7Bkmq+B+WSe1mVknjHlaFQNnrg0PbEH/RZ7NISxTWkoKd0DBk4ho1EuEqv2yZsxDt8BdqOpVJKl68JgWVFpxOkkCO1Ab2QCC2OQfvE99EFuBy2Te6+Qw+7hNR4PfxsIiyo6sKkRIl6QgEop2m3fmq9vp5H4VxyLVRcGXesGYzX5KzA2hfOnhMGh+sfAnJU9u5ECm89ndPXW8o13IrR3QYtzQ08DkKPRpBhtMEjq4ctcRusyVN4fUjuVpKTyK4dsQhN/crJ2nOWmQYpmp4K76lm5fvNGpFfJ8EPlhjuAWH2p4Aq+LcdXYo/Psl9tg06JAE6kRJI3OY5PvuvP0r1HmJSa6UzjSABgwxV4N7AJ2yZXitHEfkXsnK7fd7patALL4q8oJAY/2ES/fS38GWdE4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(44832011)(2906002)(5660300002)(86362001)(82740400003)(36756003)(356005)(478600001)(81166007)(1076003)(41300700001)(426003)(83380400001)(7696005)(336012)(16526019)(26005)(36860700001)(2616005)(6666004)(8936002)(316002)(6636002)(47076005)(8676002)(4326008)(70206006)(54906003)(70586007)(110136005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 09:58:37.5583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0fabb3-e0c4-41b4-fedc-08dc230c5c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'panel_cntl' structure used to control the display panel could be null,
dereferencing it could lead to a null pointer access.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn21/dcn21_hwseq.c:269 dcn21_set_backlight_level() error: we previously assumed 'panel_cntl' could be null (see line 250)

Fixes: 474ac4a875ca ("drm/amd/display: Implement some asic specific abm call backs.")
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v3:
 - s/u32/uint32_t for consistency (Anthony)

 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 8323077bba15..5c7f380a84f9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -241,34 +241,35 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 {
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+	uint32_t otg_inst;
+
+	if (!abm && !tg && !panel_cntl)
+		return false;
+
+	otg_inst = tg->inst;
 
 	if (dc->dc->res_pool->dmcu) {
 		dce110_set_backlight_level(pipe_ctx, backlight_pwm_u16_16, frame_ramp);
 		return true;
 	}
 
-	if (abm != NULL) {
-		uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
-
-		if (abm && panel_cntl) {
-			if (abm->funcs && abm->funcs->set_pipe_ex) {
-				abm->funcs->set_pipe_ex(abm,
-						otg_inst,
-						SET_ABM_PIPE_NORMAL,
-						panel_cntl->inst,
-						panel_cntl->pwrseq_inst);
-			} else {
-					dmub_abm_set_pipe(abm,
-							otg_inst,
-							SET_ABM_PIPE_NORMAL,
-							panel_cntl->inst,
-							panel_cntl->pwrseq_inst);
-			}
-		}
+	if (abm->funcs && abm->funcs->set_pipe_ex) {
+		abm->funcs->set_pipe_ex(abm,
+					otg_inst,
+					SET_ABM_PIPE_NORMAL,
+					panel_cntl->inst,
+					panel_cntl->pwrseq_inst);
+	} else {
+		dmub_abm_set_pipe(abm,
+				  otg_inst,
+				  SET_ABM_PIPE_NORMAL,
+				  panel_cntl->inst,
+				  panel_cntl->pwrseq_inst);
 	}
 
-	if (abm && abm->funcs && abm->funcs->set_backlight_level_pwm)
+	if (abm->funcs && abm->funcs->set_backlight_level_pwm)
 		abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
 			frame_ramp, 0, panel_cntl->inst);
 	else
-- 
2.34.1


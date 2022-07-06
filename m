Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D227C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 21:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5D810F072;
	Wed,  6 Jul 2022 21:42:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4614D10EF66
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 21:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnzWVqHyR4QsixHQMuMTvSmzWgI+IRsEF2mXW5asNhvTmv6mllUtdoXxwggmA0YDO7O5v66rskYK44o4yU+sXGOFxCievOOMMrr7TJ/L6VniuHDRNFTQ0koziafZnkepHICAxrHa7Wyslb+Dw5ReawL6Ua+Rrsei5HtOJ8z9e3S09mjOGQ60IyWhd5JcRctZ3t4Fye+YrjsvhB0zugSG/q0FYHKfiPjA2zAuMcbAsFs3Hf8ZXPunlUhlx/41CNzP33sPdJ7E7JKcduG0JoftdOGUORhM/uDQpLoeCE0C2OG4HuIahk12zTEn4T9o+ChdhKPWyGnQ2PsTeEv6MnA+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMmSU5Plh316UJz7H3jNTvW9Azutkd2uLlNf+YgM3uk=;
 b=jx8b6a4Ktp/vjumCiEVsSmW5b3oBhWwAeWhP60tYeia0aIRpZZ1qZkz6y9hqLdcCsvna15xhw7+InUOL49DBYlDIPBB3/gPpFQlguFzHu+5hP/kcxXR7KskzBlCeSRk4Bpza+pJkRQJVYcBHh9RYu5daho1lIiralDrhkCjVCxnVer0LZOkHjNUaklaH679hk+YTb0OlkfS0IgQUkmOzbsbdw7TZwohqXIJZGQUbFtM8rciDVf7G6ztsFuiLYBhpKwZpPjKL34N+TYHdxNNfF1hjYtYafW0c/4qmaCd5Sum+u0fcS/vZCkIe//uRNKH3yqoZ4BcNNlhjGAytr1qTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMmSU5Plh316UJz7H3jNTvW9Azutkd2uLlNf+YgM3uk=;
 b=P+w7G6E10K9e2GuQ7EZlltq+hhPv1ov1vKvIFGY2LBIG4EK+grg4dA3smBdh1lsYlqs8aCrZU1Tj9yHlAKNrbifeRAlcc266lxiPMNOHDQTEq/UdVncUgEvSYoivJRMW2W0xSafMwee863PoKkdDol5lHux9QTHljK4yO+Lyzrw=
Received: from MW4PR03CA0347.namprd03.prod.outlook.com (2603:10b6:303:dc::22)
 by MN2PR12MB3631.namprd12.prod.outlook.com (2603:10b6:208:c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 21:42:17 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::ab) by MW4PR03CA0347.outlook.office365.com
 (2603:10b6:303:dc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 21:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 21:42:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 16:42:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix non-x86/PPC64 compilation
Date: Wed, 6 Jul 2022 17:42:03 -0400
Message-ID: <20220706214203.555342-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16103480-2537-488e-abaa-08da5f98659b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3631:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOBct1gxFaL4aalP7nKzoaH+FfWXvq5Sd2eMz/bCcjspjp7eJAJ15Vhskfjww6tNyjs8eZf/WsE+UjG0Y8HbWudvfTAqKKLWfcXw7Pz8GWdavjYMl2yHwUmdPNsOp53VwegktFByPOChN6OZz0hygsqop34eYoN4c8WIPJW9Oaj48azDdCLBTUhW3bWnak6/FTnaRgvP8dBO9p4/yYGgLKOINcvBzOfXhfQ04Symzad7TZWARcnEvlMPqhwoCFOQTYRdQp6/hOECtqA95zpmN4zo9mtwqKndTxnHAgHjUUTcR3ZHpqn/6k97uNoGXxDl0m2AEhGwftNSXLYPuF0VCkRYI6F7YpagkRskSyBluL2yXHStAniOGcJv9XaZyis3dFtRbpqcfYgaQxqgR0+D+h6JaaoZouiZpTXyp8B8ZY1CHNNhPFrFVMJH9DYmxQ4sapgmdQuOJr5EcDkgXFUs4wSkbNq3J56yDa3t9wxLMDZJ4I/LfSFWrqwU7Qi85pD7ghlVjME84YgITGe188RD/HlzIM5jGmxgMPRu+vidcqCXOf3Q4QrZ1Gi4K9SSEm03vi2Tl5d08WV4MXzt2zFXHOxp/VSEZFpzXrW+LlEK2Nb8eHeK39rDBiHm2Q0wrW+nx4vK28GskUMrRRv52n4DjTAFc5D0vwPuo2nWy4LjZrpcwykG0lEJ+dR2Hby7xt+swcCBzlBA2M15Bu1ONIpO1WDKxI2qcvwmwN5lDk+JtcN8zbFKjG4OWGj4Fpn0edRUEw/fFFNP0jerZ1/6upmS3toUrAt0xZ82nbH4F7G4V3kZ0yUO6fP9agDPhHSF2tbSiSb+vft0qEGDfEKoJrsaXGZv+xs0AkGOqEdnTbitJhPEvDo4bLDpM5Ws1x+QIS/R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(40470700004)(36840700001)(46966006)(8676002)(47076005)(6916009)(5660300002)(82740400003)(316002)(86362001)(54906003)(81166007)(70586007)(356005)(8936002)(70206006)(82310400005)(83380400001)(336012)(7696005)(4326008)(6666004)(36756003)(40480700001)(34020700004)(426003)(41300700001)(1076003)(186003)(26005)(36860700001)(2906002)(40460700003)(478600001)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 21:42:16.8840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16103480-2537-488e-abaa-08da5f98659b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3631
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nathan Chancellor <nathan@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to protect FP DMCUB code with CONFIG_DRM_AMD_DC_DCN.
Fixes build failures like the following on arm64:
ERROR: modpost: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__divdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "fma" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__adddf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__fixdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__floatsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__fixunsdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

Fixes: 85f4bc0c333c ("drm/amd/display: Add SubVP required code")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 6a25d64dd15c..6b446ae9e91f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -370,6 +370,7 @@ void dc_dmub_srv_query_caps_cmd(struct dmub_srv *dmub)
 	}
 }
 
+#ifdef CONFIG_DRM_AMD_DC_DCN
 /**
  * ***********************************************************************************************
  * populate_subvp_cmd_drr_info: Helper to populate DRR pipe info for the DMCUB subvp command
@@ -698,6 +699,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 	dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
 	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
 }
+#endif
 
 bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmub_diagnostic_data *diag_data)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index fe29725b4c06..932d85fa4262 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -27,7 +27,6 @@ ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
-dcn32_ccflags += -mhard-float
 endif
 
 ifdef CONFIG_X86
-- 
2.35.3


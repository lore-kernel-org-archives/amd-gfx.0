Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4286DCCA473
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A33DB12A902;
	Thu, 30 Jun 2022 19:14:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAFE411AB70
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhBKKqK2qlVPqbLFKoZ+TiSeGImyiu8JbFPwvjJk4CitX2RZ6zZEhJkTkhj4Ub+Y2323oBWIL9CsuqfyAWLIvzmt14kJmqDezY8jrcQ54n5fPLj/EB8CInIjqDpsm9mmclV33Ye70PWf7/4tFTj0ESy3iu4G2DiS4QIyfaa6ENmcOXEIHhkYYw5d+2kbn+Ch05c/Yt1MwS4gclj02rlHKSzXXm1E3QJR+0DNQKUHAChVQv0GN7hGaQ+HtHapOExYPdsebjULz6dU+GbtVVukCfld920oPzOq9fIw4hNkR9Vil7fzNN3vZJvrhfNvDG4qzwGyExc3ODYT4hbOa8syMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBuLoMku0FK3WwjYwlp+Cmt8r1y2RIoEePbgnFV8/xg=;
 b=Ui3wHeO31z8HxzRoBDueDOE9H0JMPZcG1vYEQyJ7f20bOR396TGqA+u8rDaiw5xTTZPCHMYfn5dRA8Lk76n1ub/b/VMktEwAzhN9icqtqMknT0D7CjP4hBBFU5jp2+EA4TPI41Shq+j1Pri7waNH+DFy1DHlhITEdC1YW9jVl3/0T9Pydzr2lplBN3GL4XZmh8hqyl60UIAwzU7GkeCM3gyn9prtLZ1hfKQUJzAtucShn8pEP3ofYLG/v50p9EMuXp/yUF3Co17uA+/+iv5c8cLhW9GqY6cI55zrXXVXCkLP/0b3QDODPPDnQTpeXPJduNya2rfr4G8AQG4pAUisnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBuLoMku0FK3WwjYwlp+Cmt8r1y2RIoEePbgnFV8/xg=;
 b=QDKVUNPoD/TDiF1omKGR7S3epXdjhaVw8Pn3kiKaYVmAbBtwXtp+9JZ41MUAYt2V4Ias2vkLS542xQcv5v9ljnEJRVMyg3MzZDn0B2ktcWoCclA7KnOYNhhajgVi9OSJtTtBpHfkaX9XCW6UEAcJS8sfBcu2CBEbBNZHXaS0BN4=
Received: from BN6PR13CA0021.namprd13.prod.outlook.com (2603:10b6:404:10a::31)
 by CY4PR1201MB0086.namprd12.prod.outlook.com (2603:10b6:910:17::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:08 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::d9) by BN6PR13CA0021.outlook.office365.com
 (2603:10b6:404:10a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:08 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:06 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/40] drm/amd/display: Don't set dram clock change
 requirement for SubVP
Date: Thu, 30 Jun 2022 15:13:01 -0400
Message-ID: <20220630191322.909650-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca519bec-ff1d-40c3-55e2-08da5accb512
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90Tb8uhYpm1KOuXUMD4Z15ynPKN/LY6yBXGG2BgnZO54lPg3cjUDiLPYJr8pmTqPRFRenQbBkJms7VOlXQSZc+UvGEnqbNh4wqHtw2qHpT4qjVuYqM4LN8ukQtbuVBLh5F72Qfp3PgD8xRMi0UNx78vx+Qkm75E8pLm7BLGEA4o2m/D4HdXYar0pm6MK6t3Ybx/fgASGjMkyIUs8z2DmsrepQODULnh074ML1ve0khfRFGlXdFdr/NM9cHWwMqahIHgTMWzb8n732Bjfyd1oQyCayp1PsaNAVTqIM1s+b3+POG1slWmPJuq2+G7KDW7+ikdvgf2zdKSsIzufTx3lEZ2Klp3HD6nzFd7y2KYeLcnF+UxFG7/9Cvewe7FW+w08As0tv6YIvANoudTYAmNzkNvrhM1xS+DMUsgdeD/OMHRcVnwZFIy6VdeAR25S3Iza27RHvAoLVzB5hLhlhsZAgTcIHFuT0/meXzDq5+dM6h8P8ImiXt0uXuI5LLEfwEXTU9VYrBXRQpLJd9wtcbiA5m/uiYvRQ8qvKsaFoLjsja1Veq+KbRgGri6upyfBTk30Kfvd3kqXi0eOpY7GoIBgC66w4Eh8w6II37x1Cg4fcGyqWVhyQspUcVSdJCLcn7iwTMDLZ7eI48q7CtMxQ8Wiojy6IclHNs8FzHFpOY8UiG1SG55XjfxipUzKec08TAnJ9mXMk8GU5gJvWX6K3tOC3a84WmhYl2zUP0vA9fRAwVcESPe10hHUbIODVxx3dUQt0vR0zqPqW7zuR+yUq2g9ryRUDcL+Mob2DjN6A2I9yiIIw3u5xaushId8gLMu9hkckP1RcyKBd1sIeeIMXWQdo2jiRIMklDPtiAT+0DXInzc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(40470700004)(46966006)(316002)(356005)(6916009)(82740400003)(54906003)(8676002)(81166007)(4326008)(26005)(8936002)(36756003)(478600001)(41300700001)(6666004)(7696005)(47076005)(16526019)(336012)(5660300002)(426003)(2906002)(1076003)(70206006)(186003)(36860700001)(40480700001)(70586007)(40460700003)(86362001)(2616005)(83380400001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:08.3271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca519bec-ff1d-40c3-55e2-08da5accb512
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0086
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
In general cases we want to keep the dram clock change requirement (we
prefer configs that support MCLK switch). Only override to false for
SubVP.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 1 +
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index b5d7e251ed81..87c9b9f9976e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -184,6 +184,7 @@ struct _vcs_dpi_soc_bounding_box_st {
 	double max_avg_fabric_bw_use_normal_percent;
 	double max_avg_dram_bw_use_normal_strobe_percent;
 	enum dm_prefetch_modes allow_for_pstate_or_stutter_in_vblank_final;
+	bool dram_clock_change_requirement_final;
 	double writeback_latency_us;
 	double ideal_dram_bw_after_urgent_percent;
 	double pct_ideal_dram_sdp_bw_after_urgent_pixel_only; // PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelDataOnly
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 5185c2ccdfd5..95edca4c085b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -343,7 +343,7 @@ static void fetch_socbb_params(struct display_mode_lib *mode_lib)
 	mode_lib->vba.MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperationSTROBE =
 			soc->max_avg_dram_bw_use_normal_strobe_percent;
 
-	mode_lib->vba.DRAMClockChangeRequirementFinal = 1;
+	mode_lib->vba.DRAMClockChangeRequirementFinal = soc->dram_clock_change_requirement_final;
 	mode_lib->vba.FCLKChangeRequirementFinal = 1;
 	mode_lib->vba.USRRetrainingRequiredFinal = 1;
 	mode_lib->vba.ConfigurableDETSizeEnFinal = 0;
-- 
2.25.1


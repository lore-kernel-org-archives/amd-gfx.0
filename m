Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957C2C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE3310E520;
	Wed, 10 May 2023 20:49:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D7010E51F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0hjG0EJSP7QlRXBYOet+n/3GbdoLpPGgb+mfRA0dLpRj23jr/rNIn0OLfVFVb6s2BsmvnwyNg8ouP6YqU05K1dMjJA4F2Ww44nxgZy9eTlwh6TFlypWX7oTe2hcPVlZ6v0VbVSGcywMdoUDZLyG1qE0uB3pFYFx5s7L7GAJyCkr39TjnfTL4fZPxNCxiiQEdn8U2DhUdsmRBZzu5wyRv7sN0CkpQ3XPh7WgpqFHeWm3oLmJ6WOpx6KBPPODcvXMwenCtdfk8/3JHpCQkNFjdAP6E3CYyTzUC8pSPt+VCxeqGHiabgngiKNeBHn1yHZnJzECKjb3b6RjpR2nKvke1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QWAjFRwkyBPzPwPKzw74ta/2zY0DxGDqyFmagQVnpg=;
 b=TmewCsS12r0y+U1+BeWcVfk0RW+NrUEFyFfLFlBIqfv3rUmozFMz8BljPrXdRLaxowDngwZg4ZNFFD2fova8Wh4nG65NNa2Rsmi2CM+aNrUWb7JSJqsG+Fjnuq6GLVcuVzPjXD8A+IXqS2Smc8K9YnkVVO9sWkpFyq3tkY541C7wFHjhYpxJD4+IY/VmJ8DUpAKzK2uN5iV4ElR2aDz2yAjyks5K2E6yqhbX/yV/87ye0KTitoTZ6IMq3CMxrpvZf+rXsvCLR4BP+w0l+VEG8sue3YSkXO0SEsQihaxhb2jHO4ndaGN3LDpUXYsafh4I+s8bcUqTprbymUAHkXKyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QWAjFRwkyBPzPwPKzw74ta/2zY0DxGDqyFmagQVnpg=;
 b=rZHv/wAE+y5HblMCDHwVQgRdN/stpeNlo98R7wseIFaY7zQhwJnxwoQKUPjdssmZ+NHMoA89T+BSkfOclnt4QWV0K9j5PfJU+kyMw5jnNwIPeEcMr7fbyeut1O4MOea+6ZRU/N7IQEZaPEhWBGmumqDKkc0l+MIGaSuaN/l6cas=
Received: from BN9PR03CA0061.namprd03.prod.outlook.com (2603:10b6:408:fc::6)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 20:49:06 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::81) by BN9PR03CA0061.outlook.office365.com
 (2603:10b6:408:fc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 20:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 20:49:05 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 13:49:05 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/10] drm/amd/display: Update vactive margin and max vblank
 for fpo + vactive
Date: Wed, 10 May 2023 16:48:53 -0400
Message-ID: <20230510204900.949963-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0c3226-f182-4b34-8a81-08db5197febb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40d8KbpypUZz3OQAIvQaUtykvi2ZEgJDB3aJkcQUm/rHzIM/CzbooWG7ZbjC9NbzLeDvfoMJXKmY6i7jn/ythfwKtX0WV4zfUvphNg14HZO+Ls1++m9mgyHkAcNqpSYbyjOy1pxB7CZ8dm+Dyl7J+HahObJ3ymd2iFxvIZCCvYLYdMU1oCtF5AqstS8tktkrxc46av7JO14cNglTQFz9eMloS4fxvTuWGy83WS8dvwK0H5iWLR+GlMhVylCv9fyvq2FM/fJs0UcO+2icUNYdGBx9yeM8QD3IKBZWYqKvM8V9R3U2kdQ1Rx3zfFj2/7ZzMfoa0Fer7Sgx3LYW+8j+pcUFXy0ejAlPuSTv9IMd1WzgSfloc+jVc/gLgDpI5qFl1ti8BAIWXe9gppPcL+9wan66vGfmfbVjFHIKtJ9urUdhQ0xuj7kdNUQCN0BZAPxysGS9oEJ4oo5H627R4JaWBQJOTmlFmmXOJvuhqpjUuAxVoZ9nJ/wP8bp4Nl1N6kc1Cf61r8UbzRa2JfgXG0umL9MccgBxCcyLhQpBUSVZZUAavQqP7EH0466UG6OMTBof7aZaWvhkRmhBqFVASX6xisYKaADUq4a9EAXsBQThcFJiwbOigbANtl+gWJ4n1X3vF8GMgPIQhokKp+6ofbKIrSgEv1HaYxGdDF5iM6LHeb+l0QejacjIZL8XuOsTFv2uh7UeVeKi2TOHX/vD1QaEKWe3+jmNdwUmVBIVQ51qqn4Dp1E5CTaNXNRJEeqHaypHTqjfGsHPg1Re/TM2mtHbTlTUVBpwTqK803nbrQPIRRE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(81166007)(41300700001)(186003)(2906002)(40480700001)(1076003)(26005)(5660300002)(40460700003)(44832011)(82740400003)(8936002)(8676002)(7696005)(54906003)(478600001)(36860700001)(83380400001)(47076005)(2616005)(336012)(426003)(36756003)(6666004)(356005)(82310400005)(86362001)(4326008)(70586007)(70206006)(316002)(6916009)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:05.8203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0c3226-f182-4b34-8a81-08db5197febb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <nevenko.stupar@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Some 1920x1080@60hz displays have VBLANK time > 600us which we
  still want to accept for FPO + Vactive configs based on testing
	- Increase max VBLANK time to 1000us to allow these configs
	  for FPO + Vactive
- Increase minimum vactive switch margin for FPO + Vactive to 200us
	- Based on testing, 1920x1080@120hz can have a switch margin
	  of ~160us which requires significantly longer FPO stretch
	  margin (5ms) which we don't want to accept for now
- Also move margins into debug option

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                           | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c         | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h         | 1 -
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c          | 3 +--
 6 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e89de1078964..1ebb8d3573f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -893,6 +893,8 @@ struct dc_debug_options {
 	bool minimize_dispclk_using_odm;
 	bool disable_subvp_high_refresh;
 	bool disable_dp_plus_plus_wa;
+	uint32_t fpo_vactive_min_active_margin_us;
+	uint32_t fpo_vactive_max_blank_us;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 4de2f8813dce..98c394f9f8cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -730,6 +730,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_boot_optimizations = false,
 	.disable_subvp_high_refresh = true,
 	.disable_dp_plus_plus_wa = true,
+	.fpo_vactive_min_active_margin_us = 200,
+	.fpo_vactive_max_blank_us = 1000,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 42ccfd13a37c..58826e0aa76e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -39,7 +39,6 @@
 #define DCN3_2_MBLK_HEIGHT_8BPE 64
 #define DCN3_2_VMIN_DISPCLK_HZ 717000000
 #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
-#define DCN3_2_MIN_ACTIVE_SWITCH_MARGIN_FPO_US 100 // Only allow FPO + Vactive if active margin >= 100
 #define SUBVP_HIGH_REFRESH_LIST_LEN 3
 #define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index df912c333bbd..a8082580df92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -626,7 +626,7 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
 		DC_FP_END();
 
 		DC_FP_START();
-		is_fpo_vactive = dcn32_find_vactive_pipe(dc, context, DCN3_2_MIN_ACTIVE_SWITCH_MARGIN_FPO_US);
+		is_fpo_vactive = dcn32_find_vactive_pipe(dc, context, dc->debug.fpo_vactive_min_active_margin_us);
 		DC_FP_END();
 		if (!is_fpo_vactive || dc->debug.disable_fpo_vactive)
 			return NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 4c1e0f5a5f09..f4cd9749ffdf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -728,6 +728,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_fpo_vactive = false,
 	.disable_boot_optimizations = false,
 	.disable_subvp_high_refresh = true,
+	.fpo_vactive_min_active_margin_us = 200,
+	.fpo_vactive_max_blank_us = 1000,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f7e45d935a29..8c60b88c7d1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -35,7 +35,6 @@
 
 #define DC_LOGGER_INIT(logger)
 
-static const unsigned int MAX_FPO_VACTIVE_BLANK_US = 600;
 static const struct subvp_high_refresh_list subvp_high_refresh_list = {
 			.min_refresh = 120,
 			.max_refresh = 165,
@@ -2937,7 +2936,7 @@ bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint
 		blank_us = ((pipe->stream->timing.v_total - pipe->stream->timing.v_addressable) * pipe->stream->timing.h_total /
 				(double)(pipe->stream->timing.pix_clk_100hz * 100)) * 1000000;
 		if (vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] >= vactive_margin_req_us &&
-				!(pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed) && blank_us < MAX_FPO_VACTIVE_BLANK_US) {
+				!(pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed) && blank_us < dc->debug.fpo_vactive_max_blank_us) {
 			vactive_found = true;
 			break;
 		}
-- 
2.40.0


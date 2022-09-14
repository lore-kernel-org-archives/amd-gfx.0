Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0A5ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C975310E7ED;
	Wed, 14 Sep 2022 03:29:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6AC10E7ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKbRPySAU0DzzIfremFGrrDs9yLeJVP3ved63nk4Mjbm+0VV7KLMku1KHqPNqmuU584nHppkCKNDeI4Ztfov+RqOaBiOg2RceNxCoQA4vh3feA3WCRszM0RVeEk5nPE/Qn5Wo6WMI2cvE/1cvLluh4Fg8eVut/eBqRvsptV7BIT0Jt7Z6pNZJ6LKomDylOOv51rELbJ49yoBKhW9qJRk45F7R9fmtWeoNLXeP9N/VVMrgv9h/Y/LglCDQ/Q7XGPtNe04YgaSEJGnTzVEIiEkX44WN/d1ZPRnxWf3oZSXTXVOdrB1qtNZKyV+e5PspenConZ7PBBBpHo/p6py/wGdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlMBzCpKyJ37E99iEJJB4ZHNH31RV+ninyq9XTQFskU=;
 b=RiZb3F4K+hogj+IaRyjw8hKUYZKNDPeKLURAKCc1TXOTbuP8LtPr4dQWINjWwodBdgsR5dAe+Ozk/i6KRSXxyNqcg5EKM8wQFectXNV4uw2u611fqMP+gFawwnPQ/ru64tppELTEoOBzgV0D4nqfuhtS/fkhHDEL57EFc4utEmFbe200PlWLlO+rcqiQCFOq5gIFIQV6uOUSpC07v/a8U9bZ7SA5EgR/NQLYCt+90YUo54wtWmaUeNqBoCiYFCLST0SIa7hn8s4SkuxI8mIar85Y5zRMsv43DfjcvV6+Q1WXB++j+dFeKwox58MRu2QOmm4MwUqTFAPwhNWFjvivpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlMBzCpKyJ37E99iEJJB4ZHNH31RV+ninyq9XTQFskU=;
 b=ga6i0xly+7bXlN38djhvDHFiYhLxS56gHYUBnmU/HTToJTm57pk6aH3EyXg3sG6m4d1cQHG9bJ3dAgavGMzCTX5qSr6zo0ulCQjsudOy3seLk3PhgPkFs3akWl+1JV6oSERoXwtTBc9OaBIMXVkdg6b5zSBW6me4VTh6LnLt3yI=
Received: from DS7PR05CA0082.namprd05.prod.outlook.com (2603:10b6:8:57::23) by
 BL0PR12MB4852.namprd12.prod.outlook.com (2603:10b6:208:1ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.13; Wed, 14 Sep
 2022 03:29:21 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::8) by DS7PR05CA0082.outlook.office365.com
 (2603:10b6:8:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.5 via Frontend
 Transport; Wed, 14 Sep 2022 03:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:29:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:29:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:28:50 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:28:45 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/47] drm/amd/display: Add debug option for allocating extra
 way for cursor
Date: Wed, 14 Sep 2022 11:24:07 +0800
Message-ID: <20220914032441.1075031-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|BL0PR12MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c73081-5f7b-4f20-6313-08da96015028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECPUbSEooK0+wiLLhEHPBOv966tHGPpvvvzeWXgkp0eryUn+QIFymATlI2iwKQXvHtl7yI6zXII7YOzEAyN3putzn1TnFznO+QM+CKBQJMb3xTnwt9ghaArJlF9SDShf++YvHTgJUV2kEmkHWnPWZssu8hxah2OQMtN6Rv2gBh8dpqoBZ30Vyvn6wbQ5V2wXSN2UVeRlYJcbCOv9utkvxb4ZTmqJr36Ytxk3a+ygwXwCO2ve/I+lz5Yug25BCUKDfjO08t1Q+D6RgkN9wlKj3mTTQyqULL0U/6UJoXE20PbtDMwLiClg1GjX42e6VbavAiGp059X+Io2rnkLfAH6x4rLXtHQ9ce//IswBCixq3FWk5iPeTnt0EQC1AnEpq63t+mTJlAVgncHpYYOwATmWKDqcLZIxfPZ4XIXO8JC/y4+Q2WqBqhSolL1fyVhmdhyX3O/d2FTy0XOPFrLXvTtSJZz9njKSD2Vq5FylMupnS+zIAfmRAjvjfqiMJBchXDFSsn/VyIc+6jmHAcXVmYwEzYIfy985gFAslwqsy5Gvb06kuszycT4ZDiGN0/+SKGv6irDtod0VZpjkstZkYNDZtOe99Tp3qZeA6s9QgaqcqkCVogx7A5Vpz0KUJqTB0roSkKIkhoyAbSzxVmo4CLBKUXDQegviQIpJhna/9oup0JU8KcURbg54rUzNoTpVoc/ka3twncC8jvckVYbHHCXyhLqisSOV20Mpq7C1Er7Ezx7bqD+j/aoGNHV2sf9xma7VIIt8wRvFyHs2PQJ8iDYCWaydckiXHhx5KOwo2Vi08+S16HeIvUOIrXP0LQJ5G36
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(316002)(86362001)(186003)(82740400003)(6666004)(82310400005)(336012)(2616005)(426003)(1076003)(478600001)(5660300002)(70206006)(6916009)(356005)(8676002)(36860700001)(47076005)(70586007)(8936002)(7696005)(36756003)(40460700003)(4326008)(26005)(40480700001)(41300700001)(54906003)(2906002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:29:20.9210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c73081-5f7b-4f20-6313-08da96015028
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4852
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why and How]
- Add a debug option for allocating extra way for cursor
- Remove usage of cache_cursor_addr since it's not gaurenteed
  to be populated
- Include cursor size in MALL calculation if it exceeds the
  DCN cursor buffer size (and don't need extra way for cursor)

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                    |  1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c     | 10 ++++++----
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |  1 +
 .../gpu/drm/amd/display/dc/dcn321/dcn321_resource.c    |  1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 53b13beff0b2..af726ffeb0d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -832,6 +832,7 @@ struct dc_debug_options {
 	bool force_subvp_mclk_switch;
 	bool allow_sw_cursor_fallback;
 	unsigned int force_subvp_num_ways;
+	bool alloc_extra_way_for_cursor;
 	bool force_usr_allow;
 	/* uses value at boot and disables switch */
 	bool disable_dtb_ref_clk_switch;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index c6d2a05ded3d..931dcf3e5ada 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -304,7 +304,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 				 * using the max for calculation
 				 */
 				if (hubp->curs_attr.width > 0) {
-					cursor_size = hubp->curs_attr.width * hubp->curs_attr.height;
+					// Round cursor width to next multiple of 64
+					cursor_size = (((hubp->curs_attr.width + 63) / 64) * 64) * hubp->curs_attr.height;
 					break;
 				}
 		}
@@ -325,7 +326,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 			break;
 		}
 
-		if (stream->cursor_position.enable && plane->address.grph.cursor_cache_addr.quad_part) {
+		if (stream->cursor_position.enable && !dc->debug.alloc_extra_way_for_cursor &&
+				cursor_size > 16384) {
 			cache_lines_used += dcn32_cache_lines_for_surface(dc, cursor_size,
 					plane->address.grph.cursor_cache_addr.quad_part);
 		}
@@ -345,8 +347,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 			plane = ctx->stream_status[i].plane_states[j];
 
 			if (stream->cursor_position.enable && plane &&
-				!plane->address.grph.cursor_cache_addr.quad_part &&
-				cursor_size > 16384) {
+					dc->debug.alloc_extra_way_for_cursor &&
+					cursor_size > 16384) {
 				/* Cursor caching is not supported since it won't be on the same line.
 				 * So we need an extra line to accommodate it. With large cursors and a single 4k monitor
 				 * this case triggers corruption. If we're at the edge, then dont trigger display refresh
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index d757d1638fa7..dad174a52449 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -720,6 +720,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_single_display_2to1_odm_policy = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 	.allow_sw_cursor_fallback = false,
+	.alloc_extra_way_for_cursor = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 60bf6e1b2972..1068230f16ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -720,6 +720,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_single_display_2to1_odm_policy = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 	.allow_sw_cursor_fallback = false,
+	.alloc_extra_way_for_cursor = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.37.3


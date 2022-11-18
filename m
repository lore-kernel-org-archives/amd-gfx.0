Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCC6C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F4110E785;
	Fri, 18 Nov 2022 16:59:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF61510E785
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwsC9/o1AUorWHDX5CAEWPrLPrr50HSfQ67IqzZXoYNuURIWxlYGhK9/a5YB6w2BQvjVqytgCsrqS60ZX7EiIUAAdLV1wrPtrzrROnSZTmbWGn5tllbTkDasYZiLIaEDX+TYQNy6hE6wtxPz/4GX+Kadq7UG4B25cgRxl3jvfV19SartegRyjJoqGDI7Ut2inAwbknYuY4pobH/vunamF8DAGe3KbUbeEip0/WMxlaL/KARV0xTvJqdabAhAauF1Bf/ijGKxr1zpcfdyZusXMjEnx22aT/cE5gWzGZPlfcb87N3ADdEzBGJQPHc/Vtjue3tNOG035UFyFrkTAna3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP/sMYRSnZ9p7xrNz1d7Ks6WTvgSOt4mFZKDZUuksXU=;
 b=oHOt814NcCY/2Kk4L/gfGIFqLtN/HKVNguxNXm3vVjutqmEnNYz0Y5W8XbIv+BGtw7YJDS71q5vAu5vLMNoLxS5ExzhfaRWsXFGpzU3OZ8GXo1fnH2uKBZ4Tldy8rhCgdf4+t14IFOPt/4wk0NecCF5nPGZs4DRo5gE+uFI2UW1C09PsO+mozskGacQ182Jx406dIxJ2kBzkpJ0fd9nuffJYAWRQdN0lmZKnXHvQ82ixwZ6M2R84LQPlxCs97MzvDx6ZUlTkf+/F7hnw8aE/HGVAm2dmT9Xn0zaXOjC38ApO6EF1Ei6XgrAUi9qfw+XRevHYwuJAY85Caekg9hqD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP/sMYRSnZ9p7xrNz1d7Ks6WTvgSOt4mFZKDZUuksXU=;
 b=xUiifwBRGsOZJdQzdhiL6hzbArHUnk61wiLH3J2c2/o4W/7An9MewGwgGb3moKduzEzPcKRIC+3/FensHd7unZB0HVIVZKB9SVCoSJKB2xGXvid+1u8RIbzU+3WL2Apk0jJqfylcpK/77HqRGiKDyXCLoh9wGJTZJvGNZ1/hekg=
Received: from MW3PR06CA0003.namprd06.prod.outlook.com (2603:10b6:303:2a::8)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 16:59:36 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::ab) by MW3PR06CA0003.outlook.office365.com
 (2603:10b6:303:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 16:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 16:59:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:35 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:31
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/22] drm/amd/display: Limit HW cursor size of >= 4k
Date: Fri, 18 Nov 2022 20:59:17 +0800
Message-ID: <20221118125935.4013669-5-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6c6680-10a2-4606-ab14-08dac986460b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6G4/dsYB+pLTxn11e7Q4JIfqIh0KF/Kj/VJbDZgK1yTQDJK+jFMHrYcYdLTgYGC1ABYP01pKdIKKvWufgPWje+Pohqr55Vfmj3/7QSiVt2KJhyolT8cO4aGHHfqL3NuYzHD83TYPMAJ9fFv/JtGiRqJquwLZBQICpnFiZmXWmOaT+xGsNgQMCajN0PN+r0QJn4s0l3Hic5NUSbER6IeDmlGF7/bvQcgJGfMzsKIpiSZkBwD6oCSDEv1GENrDxGb7FLf8l6N7tSaqyNhvVx2P/krZT5Q7lZxDo1ztRfBxBIGaE5pFt/Pc8/a7wkxvLgoal8LhW8qUVTxhTjRgYn7DkxKimZmwIfCNv75vqtBjtA6VqRjrUZukIIba+5+qmUfKTkeX3guNbxnV8SycDtoyevpXrny4hyTJSGGrZb2zIJIhl2ygmiQpcJajyXwZw2JYWIDRmsffSgd6Xiuaft85KwKeQ7xF8GXnDU1+CG6i2nSsyW9Fv4mN98YcR8QW6p9ueeto7E/a1eNiDQ1ASvDlUIrrUvPVAVZ8dkxnJ0wyX6hWhLGn/gjlXx/xELbyR62L+U5PbugcNyMGPlT8b6uVDdLxoq7ko1d3kxHORFgU+BYfo5Q/hM1UeD8aAkwiSIqaDEf6ZIwt2wXkPYgf5KJUWQt5er/VTUKMkecYGDcYExdqmebPobHDVkCkiqG5is1Pj0hk8nV7EbTmZ/WPYytiLtARUKqV7fBZyCCGNXDtQxgiK5H61Z3bGv2C8fcDuDdh9uf3QmM4mzjw0BEpU6/PZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(36860700001)(83380400001)(36756003)(40480700001)(40460700003)(70206006)(41300700001)(70586007)(2616005)(8936002)(82310400005)(86362001)(186003)(6916009)(7696005)(81166007)(1076003)(54906003)(356005)(26005)(336012)(5660300002)(316002)(426003)(8676002)(4326008)(47076005)(82740400003)(478600001)(6666004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:59:36.2598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6c6680-10a2-4606-ab14-08dac986460b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- For SubVP, we cannot support HW cursor if it's
  greater than 64 x 64 x 4 bytes in size
- However, on certain config changes (i.e. pixel format)
  we can exit SubVP (then change to HW cursor) then re-enter
  SubVP without changing back to SW cursor because there is
  no SetCursorAttributes call
- To workaround this issue, limit the HW cursor size to be
  less than 64 x 64 x 4 bytes whenever the stream is >= 4K
- Also ensure this W/A only affects DCN that supports SubVP

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c  | 16 ++++++++++++++--
 .../drm/amd/display/dc/dcn32/dcn32_resource.c    |  2 +-
 .../drm/amd/display/dc/dcn321/dcn321_resource.c  |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 38d71b5c1f2d..20e534f73513 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -332,9 +332,21 @@ bool dc_stream_set_cursor_attributes(
 
 	dc = stream->ctx->dc;
 
-	if (dc->debug.allow_sw_cursor_fallback && attributes->height * attributes->width * 4 > 16384)
-		if (stream->mall_stream_config.type == SUBVP_MAIN)
+	/* SubVP is not compatible with HW cursor larger than 64 x 64 x 4.
+	 * Therefore, if cursor is greater than 64 x 64 x 4, fallback to SW cursor in the following case:
+	 * 1. For single display cases, if resolution is >= 5K and refresh rate < 120hz
+	 * 2. For multi display cases, if resolution is >= 4K and refresh rate < 120hz
+	 *
+	 * [< 120hz is a requirement for SubVP configs]
+	 */
+	if (dc->debug.allow_sw_cursor_fallback && attributes->height * attributes->width * 4 > 16384) {
+		if (dc->current_state->stream_count == 1 && stream->timing.v_addressable >= 2880 &&
+				((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
 			return false;
+		else if (dc->current_state->stream_count > 1 && stream->timing.v_addressable >= 2160 &&
+				((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
+			return false;
+	}
 
 	stream->cursor_attributes = *attributes;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 0c13fe0239d8..c40dccef6843 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -723,7 +723,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	/* Must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions*/
 	.enable_double_buffered_dsc_pg_support = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
-	.allow_sw_cursor_fallback = false,
+	.allow_sw_cursor_fallback = false, // Linux can't do SW cursor "fallback"
 	.alloc_extra_way_for_cursor = true,
 	.min_prefetch_in_strobe_ns = 60000, // 60us
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index d17d0f22be1f..06f144189e9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -721,7 +721,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	/*must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions*/
 	.enable_double_buffered_dsc_pg_support = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
-	.allow_sw_cursor_fallback = false,
+	.allow_sw_cursor_fallback = false, // Linux can't do SW cursor "fallback"
 	.alloc_extra_way_for_cursor = true,
 	.min_prefetch_in_strobe_ns = 60000, // 60us
 };
-- 
2.25.1


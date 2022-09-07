Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B768C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1809810E7FA;
	Wed,  7 Sep 2022 18:12:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786D010E7FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GptFlAWsWSqNHC7/FMXK/0pGPxyVzGkNF5QPGmn2Bih1nJ5BmzKzb/YHXTBEiDHS01ItoKZkDGisUKNt8xdlOdo0oC+Ofh/fDN/Klh9bOQGr+LdHp0xKUT8a+Gg0lpOz5h6AQR18GfO7/U7cdR4m1Ud+BLpQIpfMXuG4ktrUokOg7goDWwid1PZIYFkGjnTNQRYog5m3spd7HpV6l659Yj7OXaQ2UFwh+Aj4l+z1FJoWyeY1XXH2ums12q9nkJaM+Zh/KJGi42UydHCKBVJbcG9wVohPjBQHMVdHWRtKlGW+k3O6pk6v2w2Qlxz2HRqZqRjXR2K1oYKUQ9izXDSxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tya7ehBUrL/ktV7A5D5DTRWaJve7gFMEM1PGbOP8hTw=;
 b=gaB5yKQMo7/BUArdAhiHwRtpl1tzETf5zoe0mbb21oIgdeZgZkZcNZMBKD/OY7lkF5SUGZoVLRzwkKi3a7LB5J6gYT81Uwty3tcR26N/G3N4r4t8hE2BXOTA7NE843v4OWytzzgTjHT+SyLjBrTqoUy1POwlU3bLsFArbhigLvZmAj/BySW7ZXHa+OXyGws+j43OIMLZq4zcURIFm6jnNytZsOX/OTBHAnxZdsIS6JuiGjts+OKx78WCM/uiP0P1q4jWwzcR3MUa8C8oeLYEdzOYRSl1wJ7wbh0A0PK2Cl0P6A5XnjNMrd9L0VoFiYK8wtPEpWR1T5EVVKuo/FZsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tya7ehBUrL/ktV7A5D5DTRWaJve7gFMEM1PGbOP8hTw=;
 b=w4XZbq0oMp/6yOaaZlIx9m0v30lCZD+AZmULG0DPpOeiD/yuTSdp4SR8QLcuUfTjOOIQr3GK78XfgvR73Z2nCcLkvwNu+AjViD0p1ZqxCACBTuOExXNr8g1sQNcQpX29rZLLprtCud+lpt/bfxyXaVWrZWlSaWyTgEkSPbTZy6w=
Received: from DM5PR07CA0106.namprd07.prod.outlook.com (2603:10b6:4:ae::35) by
 CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Wed, 7 Sep 2022 18:12:28 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::ba) by DM5PR07CA0106.outlook.office365.com
 (2603:10b6:4:ae::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:28 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:26 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/21] drm/amd/display: Round cursor width up for MALL
 allocation
Date: Wed, 7 Sep 2022 14:11:50 -0400
Message-ID: <20220907181200.54726-11-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c0ddaf-10b1-4d8c-72ab-08da90fc863d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPTxuqJ5XjG00SnqGXZQMN4JAlg5Ovv5eBwAfRPff0RwyMXlI0VYsyhew57fkmPOkKOmA1zALKp3gI03ILBaZR1izZ3S55wrzpkz7s+ngAg+GLsUInAL7azdLVOJ9DnzT+hzr9RKslC/50JFCpboQV7e9LQAfHcU3IeRQpKZjmvmIGzYw83QXijaBzIo+XyJ+JfLsaAf9R6mN3A3PrrSBj3MOO8uQaQ9BqO+XYpUijw8Oq68tK/uP6OKtpUa6gGIhXGIi9QrhJTUvgFuDmvlccURsLNSy6RBVJ2fOGSUkLkAW6y/Sp4/rtYaFHyDi51EBfiWtNQ/wpvQcwvz1t8DRBK9DPczUjJ1duYrYU1xwX9kV1yZpjmYuP4aTlkpYIT1YJETnG+HB0PdgzpUDfI9n88iOJs+MxXhaNwHauxE9J2Ku2S/voq3X2H58Xp07RD2Ww9yrzwHSimz0Naqsq/WHfAPwuDHPFD8ySG6Cj1yjM4Ne2W+e/pzUVhq/0Ti2O0tP9U/hFB0qW1AHIpWHRFQtou3TPEnG4KkxN19i6CwK1Aqup4hP9xzKBdzDvNzAOYirIeeck3j3THq48nSVt4vDM27yvYPmRxv4uF+M1N+0WU9g1mNV0l+6lhNFqFp0vjvLzLabFmD7Y6aCdu8kmm7KpwVgd98Qqyv/7i9LwY9u3+FNnCEB09fpEFKVeHjaWcJYIaR4zcqqhzMKrfZRwoOwvp+YXTpgiuyJ/cVwqXaAdugZHVnBugyJ0WpYVALzO2AqQdSVH4tr1XpnxxsAU8gEa/wqDWcSDr/JyVLeUz1rltih9rNeiZufUl15Ke3xHxb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(40470700004)(36840700001)(46966006)(16526019)(8676002)(4326008)(70206006)(6916009)(316002)(6666004)(54906003)(83380400001)(82310400005)(1076003)(36756003)(86362001)(47076005)(426003)(26005)(2616005)(336012)(186003)(70586007)(8936002)(40480700001)(2906002)(356005)(40460700003)(44832011)(36860700001)(81166007)(5660300002)(7696005)(82740400003)(478600001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:28.3741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c0ddaf-10b1-4d8c-72ab-08da90fc863d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
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
 Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
When calculating cursor size for MALL allocation, the cursor width should
be the actual width rounded up to 64 alignment. Additionally, the bit
depth should vary depending on color format.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c | 24 ++++++++++++++++++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 24 ++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
index 6ec1c52535b9..2038cbda33f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
@@ -103,6 +103,11 @@ void hubp32_cursor_set_attributes(
 	enum cursor_lines_per_chunk lpc = hubp2_get_lines_per_chunk(
 			attr->width, attr->color_format);
 
+	//Round cursor width up to next multiple of 64
+	uint32_t cursor_width = ((attr->width + 63) / 64) * 64;
+	uint32_t cursor_height = attr->height;
+	uint32_t cursor_size = cursor_width * cursor_height;
+
 	hubp->curs_attr = *attr;
 
 	REG_UPDATE(CURSOR_SURFACE_ADDRESS_HIGH,
@@ -126,7 +131,24 @@ void hubp32_cursor_set_attributes(
 			 /* used to shift the cursor chunk request deadline */
 			CURSOR0_CHUNK_HDL_ADJUST, 3);
 
-	if (attr->width * attr->height * 4 > 16384)
+	switch (attr->color_format) {
+	case CURSOR_MODE_MONO:
+		cursor_size /= 2;
+		break;
+	case CURSOR_MODE_COLOR_1BIT_AND:
+	case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
+	case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
+		cursor_size *= 4;
+		break;
+
+	case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
+	case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
+	default:
+		cursor_size *= 8;
+		break;
+	}
+
+	if (cursor_size > 16384)
 		REG_UPDATE(DCHUBP_MALL_CONFIG, USE_MALL_FOR_CURSOR, true);
 	else
 		REG_UPDATE(DCHUBP_MALL_CONFIG, USE_MALL_FOR_CURSOR, false);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 769171ab8ef6..dbf2d7cc96c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -741,7 +741,29 @@ void dcn32_update_mall_sel(struct dc *dc, struct dc_state *context)
 		struct hubp *hubp = pipe->plane_res.hubp;
 
 		if (pipe->stream && pipe->plane_state && hubp && hubp->funcs->hubp_update_mall_sel) {
-			if (hubp->curs_attr.width * hubp->curs_attr.height * 4 > 16384)
+			//Round cursor width up to next multiple of 64
+			int cursor_width = ((hubp->curs_attr.width + 63) / 64) * 64;
+			int cursor_height = hubp->curs_attr.height;
+			int cursor_size = cursor_width * cursor_height;
+
+			switch (hubp->curs_attr.color_format) {
+			case CURSOR_MODE_MONO:
+				cursor_size /= 2;
+				break;
+			case CURSOR_MODE_COLOR_1BIT_AND:
+			case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
+			case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
+				cursor_size *= 4;
+				break;
+
+			case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
+			case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
+			default:
+				cursor_size *= 8;
+				break;
+			}
+
+			if (cursor_size > 16384)
 				cache_cursor = true;
 
 			if (pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-- 
2.34.1


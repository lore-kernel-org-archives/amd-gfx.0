Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56069CCA482
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9148B10F504;
	Sat, 16 Jul 2022 14:37:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92FFB10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKZM7Gea250fuicnqS2riGIxfhRU1nQnmVfeEbSf7blUwqbee24D6n5SKFlJoWBb0DZmcXtjJkPcWQayzVu4mWiVDaounLaJKGBCNYwi6DgSfTX+dNxclKigt4z84QGcNhvnmY84aS6hijfkmmPElI9cMD7dvL9yNt7kAPfrWqLdb+CdQE7JhJKqQPCXLEVE+7u+a/8CpuF8oHXDE9ZbsZUmFgWVpIDIIXffQGADkDNgSiFcLj9j3jIFK06XH7lDFyrSH1DWw8cYi46Vqh/L54aK9Y3A++O7qNN15GprAT7P93L+KsjCd/G1T9dlfGc5HeVnkEh2VWeLZegThjQpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIbKoR4L8BRzCOh+icpsqV0iPwQJ5Tl9RZZn04TWDME=;
 b=Ppl+4c0RumrDqQ4LXypDhGMy1wAnOopjtxX5adJgs/c2cyQwACZMPP5yEwjbe4muKPYPvgK0tsxnDfbxY3IScRpkni7o/qKORzQYpRHF1Sokogm7n02jcd9zd9wfnX9RrldkJ+NgBqc2LPat998KXHYuOYQp3OOqRlvFiHwAzEFeyPjUET884aBm8EoJKjapsaIMSUH+r7LUoMFApEqckQCmQ7nCkvhuhDlyOUa+TQPe9/r4vnPrpSbmqSKa6+39OdYszHlDx3c3xpdRYFQF2zZJ6zqaNoxTt9ITVoympoMCptxRULZJZPKM9a3BijeflYW7L0qt4gwvnVEKIAhiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIbKoR4L8BRzCOh+icpsqV0iPwQJ5Tl9RZZn04TWDME=;
 b=3Lwyrkuhdl3ozUjlsu9s39GFMkLc7uI4UC+mqLCzvZ/VjePizDLOLabNm76T3a3Pe2vPG/kDZNJ+cH36qkOIOdW01araN7ynttApzCbH4imLJL5E9D94oLSv5KXZXLC4cmS+e1TO6LmPKeaUUyLNYwkGKPgOZjzCoW9HVgSBFvY=
Received: from DM6PR07CA0055.namprd07.prod.outlook.com (2603:10b6:5:74::32) by
 CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.13; Fri, 15 Jul 2022 18:17:46 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::d8) by DM6PR07CA0055.outlook.office365.com
 (2603:10b6:5:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:44 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:44 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/31] drm/amd/display: Update Cursor Attribute MALL cache
Date: Fri, 15 Jul 2022 14:16:50 -0400
Message-ID: <20220715181705.1030401-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc709d58-56bd-48fa-7f19-08da668e5132
X-MS-TrafficTypeDiagnostic: CY5PR12MB6455:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2j1aON+TlZKKxq1qT2qB7EadEmx848djWI8rJFfRHJdTGH2tVbs+lOATKZ2X4UhV8+MqwQ6A7OfOk9Mgo6mrHp651ZneLQR4rqWp7PiES6cKIh7RIW+r9+XSdDXKVsJxYxLqWiaveUTE6mnKXNt1Vy7dNYy9JGd6vSxZMcX8s/j9sWwbRcNzj7B2Xkd2y5zIxmYhFD4pXxCU7GTgSg0JJ3LN3FAvmQprd2ODxNns59XsxM55vmGAWVUrUZOkHkZBqiSyMwLOWZhUOUMkoc4K7xuF52PMIZInpdxg0uxtzfK7dQt1xgkSDgr5ODIPN9CUIwqxpVYXGW/q1DBAoljyl5cjCldgGdlm6RvHLvXMsaITw2k3uYVLnSxSgwbyk5gp5zgP29jczX9Ht0cN1raSlhBE1mIPUUorr6HrK05zZV2WjkaIHW5Qv2thIbEhwN/R6nS40WiPaC5A78Brbu3bWE6x56pFjgWBEGncDSyAgGL4fV45wLv7oJm1dTHS2wA1/90dkgHPuNDRfmthVEF1Rtvq970tkWaK0TlcN630tQpmX5P8IX3Uz6kvfyFbzu346gmaRtQZkmX/iEexV3IGs46T41tXbYDNdT87UW2OJvCIS1QsSCLUrcCeXeGph7dji8mtSlMtwZFAIcCx44KyDjHft/tx35TCg+8VZrtH/StONAWxvyVnW7s2YOwlH17xiHLWa8k1vj8VNAqO7cUcjd33W04ZknuYnOFH5jit3HM9XzxIXcW8GN5i1mRxLRV71qgay46HP4773ZyLRB/KmBQg8HdnwrBAhiC3hcSWnCYnyJNkZ2UZ2IDFZeqM0rOd5B85rug6wxCu/oeRe/HgvKou6/EsSHyEwDlYrbUb1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(86362001)(82310400005)(478600001)(356005)(26005)(8936002)(82740400003)(15650500001)(5660300002)(316002)(70586007)(186003)(40480700001)(1076003)(336012)(6916009)(4326008)(41300700001)(47076005)(426003)(83380400001)(70206006)(6666004)(36756003)(54906003)(81166007)(2616005)(8676002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:45.8905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc709d58-56bd-48fa-7f19-08da668e5132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
Cursor size can update without MALL cache update.
Update the register on cursor attribute as well.

[How]
Update cursor MALL cache on cursor attribute update.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c | 40 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h |  3 ++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
index 0a7d64306481..3176b04a7740 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
@@ -94,6 +94,44 @@ void hubp32_phantom_hubp_post_enable(struct hubp *hubp)
 	}
 }
 
+void hubp32_cursor_set_attributes(
+		struct hubp *hubp,
+		const struct dc_cursor_attributes *attr)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+	enum cursor_pitch hw_pitch = hubp1_get_cursor_pitch(attr->pitch);
+	enum cursor_lines_per_chunk lpc = hubp2_get_lines_per_chunk(
+			attr->width, attr->color_format);
+
+	hubp->curs_attr = *attr;
+
+	REG_UPDATE(CURSOR_SURFACE_ADDRESS_HIGH,
+			CURSOR_SURFACE_ADDRESS_HIGH, attr->address.high_part);
+	REG_UPDATE(CURSOR_SURFACE_ADDRESS,
+			CURSOR_SURFACE_ADDRESS, attr->address.low_part);
+
+	REG_UPDATE_2(CURSOR_SIZE,
+			CURSOR_WIDTH, attr->width,
+			CURSOR_HEIGHT, attr->height);
+
+	REG_UPDATE_4(CURSOR_CONTROL,
+			CURSOR_MODE, attr->color_format,
+			CURSOR_2X_MAGNIFY, attr->attribute_flags.bits.ENABLE_MAGNIFICATION,
+			CURSOR_PITCH, hw_pitch,
+			CURSOR_LINES_PER_CHUNK, lpc);
+
+	REG_SET_2(CURSOR_SETTINGS, 0,
+			/* no shift of the cursor HDL schedule */
+			CURSOR0_DST_Y_OFFSET, 0,
+			 /* used to shift the cursor chunk request deadline */
+			CURSOR0_CHUNK_HDL_ADJUST, 3);
+
+	if (attr->width * attr->height * 4 > 16384)
+		REG_UPDATE(DCHUBP_MALL_CONFIG, USE_MALL_FOR_CURSOR, true);
+	else
+		REG_UPDATE(DCHUBP_MALL_CONFIG, USE_MALL_FOR_CURSOR, false);
+}
+
 static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
@@ -106,7 +144,7 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.set_blank = hubp2_set_blank,
 	.dcc_control = hubp3_dcc_control,
 	.mem_program_viewport = min_set_viewport,
-	.set_cursor_attributes	= hubp2_cursor_set_attributes,
+	.set_cursor_attributes	= hubp32_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
 	.hubp_clk_cntl = hubp2_clk_cntl,
 	.hubp_vtg_sel = hubp2_vtg_sel,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
index 00b4211389c2..c4315d50fbb0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
@@ -58,6 +58,9 @@ void hubp32_prepare_subvp_buffering(struct hubp *hubp, bool enable);
 
 void hubp32_phantom_hubp_post_enable(struct hubp *hubp);
 
+void hubp32_cursor_set_attributes(struct hubp *hubp,
+		const struct dc_cursor_attributes *attr);
+
 bool hubp32_construct(
 	struct dcn20_hubp *hubp2,
 	struct dc_context *ctx,
-- 
2.37.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7048FC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C8914AD84;
	Fri,  5 Aug 2022 17:59:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE2D18B038
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPLgQP7Uqj9YVme5PqCmByAn9xiFIwiok+8qOpvKCn9FVitLr+RRCuXKgr3ro7ciKzM4iU5L9CiU0lYsVukQsb+dSMGGMDX8N6JBT+k8BA3M6Ddsjtyb3IJZIulCwf1lTwqQpIf3FjC0Ca3f6KB3+OPpI4gZGRUx9mXSPi8jDMnQiE4LyUN17rltG+7pn4ofFP/hPRtJMJw1C6c4pk207n44u9Cp0OCGbbgKM5w81fA8UCnksvlMU5UgwsMON4H9v3/XauH2r62Aw1Nfa8RX3/EfJhY9Abkek838phDoP836RKw71JXcIyCSqjHRdrO41578qxSooET8ndqonYuIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMKWZwpzibzlTB2EInfFSrlsmcM1RWvMGCXcP1Trdos=;
 b=myXSRyhxENUDBbzn2bmI+H2oGerCQVPqHjjP0Re04YdPsWX9s6b6eurXdwB+RU6/6hsxNOe2LuF4c/Ek7WJ68aEWxgDa64PpPcI+B9d5dXzo5wBBDcb0EMyPD0ifIsdmW+tn+QYTJB+bMErSXoqwZXIBIY9r8UX4P+21iupN5Zu7ZK43tlERnIYw3tUQG/bv/AeSpMDBP+z7Yqg+RY5whDovK4iNFuTpOQq7IBk23XN+nhqV5VboIFhGeMVRrrWHJICWgIVpXP1MbU/a+2tqCaPptUPFkB+LgXNnD46wVGVPMhzZ9K3qFdm30Bf3fSKThVIOUl9rkLEmiNVL5Hwnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMKWZwpzibzlTB2EInfFSrlsmcM1RWvMGCXcP1Trdos=;
 b=2ugihba7+4BsYhnPZjgOMEZscLWSt75IbEkGzGyJ0tDnrxXej6JE0Tj+Gw50Le5/y/EYsJEX8B7+sbg4O32f5PgOzJO39O6jQJpp17cg/lJ5VKr3fDvesU+9FzQ2pjWMZUOpbY1yVlRQK2iY+ZZtUBVsYvSuo2IblPXrv8/uyz4=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by BN8PR12MB4625.namprd12.prod.outlook.com (2603:10b6:408:71::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 5 Aug
 2022 17:59:35 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::9b) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Fri, 5 Aug 2022 17:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:59:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 10:59:12 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:59:01 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/32] drm/amd/display: fix CAB allocation for multiple
 displays
Date: Sat, 6 Aug 2022 01:57:59 +0800
Message-ID: <20220805175826.2992171-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eaef911-f717-4cb9-bafb-08da770c40b3
X-MS-TrafficTypeDiagnostic: BN8PR12MB4625:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBXsGHvKkeFxbWsal4XvGKAe7kkJ8ACSBCweM1zywaO3v5sru+TnZ2tqdu+dqiLtCkgPjPYIMSEFbuF+ojkgmxI8ICVxj4+vTF9Xb8RPzGNpwfPD5AeQEclmmHl4D5Qot6AebSmv5oqc3sT92siWSkw1UyDLyY4M2noazewrGEzq8XJr39twtPDFFfxPKtoynkqknikwoiQUt6BNOQcTjXZGmW7q8ZSeOYDCC+syWS7kncahxtJUQdSYZwpVA2G3xJJSZDXRrp2ZiGyniFf5cGWBK3iaeAnXcGYF6ookfGxDvb7FSM2awIcFySYlHkI/vk1McatxCFgij181LEUgB1815DKmv511SmXgAzY+BledFV3qrWIo0oCgRy/fWBs/0rqs28LwJ0k3EEzjcKM8uIoLK6ImRjikoDcYkL+FJGLw7u03kzZ8HNI/7O/0YOrqVXXkil3tAJHF7pEnqXzjgVsbTA8IPxWp9SfkrzhTC+2VZrhnmnwjgQW5dbRp1cclEP2OnESJoJWrCsqKYeJO0sCeMSsIFCEisAwjM7PwhF9VEuZawP7i74C0AgnuwwNMKfP6ah0pQBKGrFNwImzL5LFEWTcHDYW1293/Lf7rEljXb9oORUcDik8AsBdRuMVtq315DSnfztvRn/4Fob2aykrwkg21WIZRIAWvNEO41YTRj65ETEFpP+N1sWIKKpjTkDo2/yMopOckaqtANOI5nYyzMgS/yytg7SMAwBSVRgaYvDqjisqgeLSf4BWxIjYCphp/yZ5SdzHK++4/v6O1suSF72Jn6nIqRR2eoYcB3Pt4IShAbYFtrg57v8PumTpLtRchZcNuNSNFpn5J2FKfsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(40470700004)(46966006)(40460700003)(82740400003)(7696005)(41300700001)(86362001)(26005)(82310400005)(54906003)(478600001)(356005)(40480700001)(316002)(81166007)(426003)(36860700001)(47076005)(186003)(1076003)(6916009)(83380400001)(4326008)(8936002)(70206006)(2906002)(2616005)(336012)(8676002)(5660300002)(70586007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:59:33.2523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eaef911-f717-4cb9-bafb-08da770c40b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4625
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why & How]
When multiple displays are used, the underlying framebuffers could be
two separate framebuffers, or a single large framebuffer. Fix the
calculation logic for CAB to account for large framebuffer. Current
logic assumes that any FB that the plane points to are independent. When
a single FB is used on the system, this does 2 times allocation.

Add a check to prevent duplicate allocation by checking if the base
addresses are the same, and then ensuring that the if we allocate using
the pitch, whole of the other fbs will be accounted for in the first
allocation.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index d38341f68b17..5ba503d80728 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -250,6 +250,7 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 	uint32_t total_lines = 0;
 	uint32_t lines_per_way = 0;
 	uint32_t num_ways = 0;
+	uint32_t prev_addr_low = 0;
 
 	for (i = 0; i < ctx->stream_count; i++) {
 		stream = ctx->streams[i];
@@ -267,10 +268,20 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 			plane = ctx->stream_status[i].plane_states[j];
 
 			// Calculate total surface size
-			surface_size = plane->plane_size.surface_pitch *
+			if (prev_addr_low != plane->address.grph.addr.u.low_part) {
+				/* if plane address are different from prev FB, then userspace allocated separate FBs*/
+				surface_size += plane->plane_size.surface_pitch *
 					plane->plane_size.surface_size.height *
 					(plane->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4);
 
+				prev_addr_low = plane->address.grph.addr.u.low_part;
+			} else {
+				/* We have the same fb for all the planes.
+				 * Xorg always creates one giant fb that holds all surfaces,
+				 * so allocating it once is sufficient.
+				 * */
+				continue;
+			}
 			// Convert surface size + starting address to number of cache lines required
 			// (alignment accounted for)
 			cache_lines_used += dcn32_cache_lines_for_surface(dc, surface_size,
-- 
2.25.1


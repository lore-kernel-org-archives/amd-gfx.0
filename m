Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72696CFC273
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0392110E548;
	Tue, 15 Oct 2024 08:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uSTLC/XD";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 793E410E53F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 08:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDV9U697uQaxjF8ex1mBJdGgBaesqCc9jpFx7MVbS7z20Q7GcwfdYSm5eF0iquNcg6hVgDmfEJ14M9AQqwhpM8M6bw32JUjSIX9CRTBSOa9Swta/7je7jOtNfWY2/EkH+U7qhw7xv4g9/pcgfQ4Xw8S5E1I+gqhD0mBqcn0d8aLWkqbTOje8YPZKOCkwMH2hWzhIcHPI5aA/l7A188+auYiYY6tUB0nWR4NM0KR7xS56ZK/XiLbzF9A5IZFLFfwzQ2pRqI6yOGXmdAwHSFv1LhZNoxDqUSGeyQyoDVBjLkG2EYijS/2BNYqE33NGbvgXn1mmoFvYO6Hvq7cR8pu4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T++d+NQW9FX+CFu61/S3ZKM939Hb214wZbeDQO+n9pc=;
 b=xruzi17P2mWpUVXwwzv5xyBpUJpO7RU9QSNDOoXJGkww+ny65qdHJSgmvsRsiR6P/JQLRJOEVBJiJtVGEmbsiSENbdWXfT71/dsyDjRTc8yF1R/HNAX9XibxqDICJMlHYC9B2poO0OXVAYMDCkXBbwkHW2fPoX4IvqDZd7k1Vir69X3WQf/maX+Sx380aGo+W+HHbOVZPf0WvlCsy5A9JVmN6XLx9GGiYSe4DJJsNo7oUEwgZgVyIiO9QsLu/1p30ZjitSLDoHYRRKcxwS3G6O4RnxKEaO6JdWy61LB1h7BnJl19nGAnd9UZpn0IUJd+3mQVeUFvw8CW6vQDF7YmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T++d+NQW9FX+CFu61/S3ZKM939Hb214wZbeDQO+n9pc=;
 b=uSTLC/XDKmU0KW99gssIHc0F168Wxxd1o7lPDfg1kIHhxVqK4jnFIHIfxSwDwdiCI5Hj1FDBBYHp+ubYbvAZE2uNlf0LbBnkFRsZ0MsZ7/23gS7T7v+4+FUgMDmK34Ta7LfJQigNkdqWyNCI8ECBH1lvGqdXFR9AGVOG+3aHZSQ=
Received: from DS7PR03CA0134.namprd03.prod.outlook.com (2603:10b6:5:3b4::19)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 08:18:01 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3b4:cafe::23) by DS7PR03CA0134.outlook.office365.com
 (2603:10b6:5:3b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 08:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:18:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:00 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:17:54 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Leo Chen <leo.chen@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 04/10] drm/amd/display: Adding array index check to prevent
 memory corruption
Date: Tue, 15 Oct 2024 16:17:07 +0800
Message-ID: <20241015081713.3042665-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d86eac2-3d4e-465a-f2fa-08dcecf1e28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bLTL8189YI/NUFgozZQopc5sutftTVmuKCv7siPP7guksOZXUPW3Iq2NqyAl?=
 =?us-ascii?Q?hQ0dXuowpTxtMasTcUaOiEtCvzOya0q7qeALlasDiHpL95E90kEbKT52lF6F?=
 =?us-ascii?Q?0qxkruSRtOJmNZESg7qBKTgeHmtCwbpmj1lyuoEWHoS2QAGP1COu+gI8YN8h?=
 =?us-ascii?Q?tRNfIfWCk+3HJ2QR+54Uc9p9OO9y2mMSWEk/lZ9VHS30j8pG6WF0iye1mYx/?=
 =?us-ascii?Q?E3zbJrQzV+x3Kd4fX9MwAapQt2DQCwMniDLdLIva3nJWldWrxdCBvTjmt+ro?=
 =?us-ascii?Q?/+v8OXogzmIi8O36bEoZk/vjlIpAGuc2mK/+bpQbDi4jgaOyS4/UywK7js2T?=
 =?us-ascii?Q?yQklc07ZHLqWMipAVTnkHuBzfdNyQ3DgEW3OkTMP1366YQUSK9mafZx0lY0r?=
 =?us-ascii?Q?2OzRgITf8ylReweuhcVfusTe+uELhffNOPS1PD/r5LRNqofVnt2YyMxzHTLq?=
 =?us-ascii?Q?AOr3QDS83ZVMjPE01JYuzCxB80j5tVO3iwSLCdewFh7SzMzEoVvnNomH1zs7?=
 =?us-ascii?Q?28hNUG+av3VgVkIPgTnO7500tTxfKMMxMFqhsvpV1dXvsftRkWYC1fEUclpe?=
 =?us-ascii?Q?EtlgNPlPt1TSEOiMPNVO4egsCGFZkd2mb7wXq7WRvfLEAExl2KfWfiJY136c?=
 =?us-ascii?Q?9vjR+M8L1jNZv/NzeMyyH/6FKJkrRIYy80u5g5ZAz9436PBiDLRnK+F0e9lU?=
 =?us-ascii?Q?5KvIpdf6uJk98xg6F9bzR7fCNqURFgile8u0U33OBbV23Lvi/RJ9/oiM7ujX?=
 =?us-ascii?Q?Z74Iqzb/O9uaBx4mA86Y5xoKAEkiaXvIp+7SqRX6lTSWn2ED83hGMPXjLpQI?=
 =?us-ascii?Q?0laujkLz/4qLVUpf4QN9uPQXhaqALWPngr6cuhUl/+Y8Oj73sFQN3GHdHO8b?=
 =?us-ascii?Q?Vj2hC0H6WGUBZjQ7f2EI8/o8ZJiF25a+OBRkt/6esLy2Beu4SxFt/2feSVba?=
 =?us-ascii?Q?ozNKBUjnJv7vPWcuLzxZ3IW66UmzgHiOUYCEfbI+OYOWHVYEG9FON1mu3bvW?=
 =?us-ascii?Q?WIEGrI94Uc34VqsQkR+Y6Ay1q4xJoHLnQpheaT32CND08JRWbZgKYCuDFWHj?=
 =?us-ascii?Q?eI0YCjhQ3a/6e+lWqbbWkwqWXY3Kg6Ve/+89qJ5ngcuk/AzElVa0GVmH9gHC?=
 =?us-ascii?Q?9+5Ut1A90GRDForkfDTctV0OS1pjDaaKuXXT9/sR4jslnne+tjlpALk4Nal9?=
 =?us-ascii?Q?lFP2sStL4BZZh6ZlwtpwcNYNDX8bmtuIPURPwdwysEwnYTBdroPldboC9rDZ?=
 =?us-ascii?Q?cNdLgQkcPnpodO98PjLgLpF+mCyO4/30TyRkHpvjBkz1b4xtJ47B4IzoEu+O?=
 =?us-ascii?Q?giXfzPdB8pg3Dhk0iJwGu8q1vCwYJrLJezp8qA00vHw2z9SVaYrnu+CZv0nU?=
 =?us-ascii?Q?qfJ0QnE94t1R6fX1QXwkAm95Th+a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:18:01.0810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d86eac2-3d4e-465a-f2fa-08dcecf1e28e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <leo.chen@amd.com>

[Why & How]
Array indices out of bound caused memory corruption. Adding checks to
ensure that array index stays in bound.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index b46a3afe48ca..7d68006137a9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -257,11 +257,11 @@ static void dcn35_notify_host_router_bw(struct clk_mgr *clk_mgr_base, struct dc_
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	uint32_t host_router_bw_kbps[MAX_HOST_ROUTERS_NUM] = { 0 };
 	int i;
-
 	for (i = 0; i < context->stream_count; ++i) {
 		const struct dc_stream_state *stream = context->streams[i];
 		const struct dc_link *link = stream->link;
-		uint8_t lowest_dpia_index = 0, hr_index = 0;
+		uint8_t lowest_dpia_index = 0;
+		unsigned int hr_index = 0;
 
 		if (!link)
 			continue;
@@ -271,6 +271,8 @@ static void dcn35_notify_host_router_bw(struct clk_mgr *clk_mgr_base, struct dc_
 			continue;
 
 		hr_index = (link->link_index - lowest_dpia_index) / 2;
+		if (hr_index >= MAX_HOST_ROUTERS_NUM)
+			continue;
 		host_router_bw_kbps[hr_index] += dc_bandwidth_in_kbps_from_timing(
 			&stream->timing, dc_link_get_highest_encoding_format(link));
 	}
-- 
2.37.3


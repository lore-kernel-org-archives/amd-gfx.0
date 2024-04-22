Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF0EC07E8E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FA9112BEB;
	Mon, 22 Apr 2024 15:29:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EmlZ7k8V";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5CFC112BEA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB1Zm/qJbugQ+0d1K7hQebHhLdr8PiHHuTWQNOiqzpOpoq9eY4oS6DUZ4CI9mE4Z6QdHTMo0cSD7UcpIacUW5/y9WOk9gX0dmeQI7QNahYxkaBw3oqUcetwJ96yK+pwMupZ37B4a299RkWshVuBQr4bQO9VGVS3AGcnGNre3SifPJWakeOmUeAX01i8PjeCIYarg4flwjh2nuuob1ONCgFXk2JQeGz0GmFG/tEQhr9JpQUz54Obg8ElkssOr83pWjij9RB5qk3yGbEJrQgp0T0HW11duI//t7Piyh++S9Tg+gTOn9vtdlCz4vgkF1xi6uBHHJJ4wG5IEizem4XAC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dga6hOGUCEzTc5Ywn+l8TJNRR4bJ22ab3aBnfdEkTuQ=;
 b=Eqdvn1Yo7UEUZXknyg1s5i9+40ulVl74pykrUwWVbdGUcIUF51TO6ebAYqOILAmYbYYf4QpAWQJ9cRxOfTUXzqTkX6hNySmi71a7J3FfcA9RCEqcYaTcvWUMDi3c4dqtcoIv399ynriUZnV7p+/4rFwtwJ2DLVcgd27QKJo4vztvWTB/Y8xTotI/B0kiT925bALQhPuyboJj94mvYKkbeTMlTqtosIDGYEsaXkpb2VbePwbxomJWzHWuLZid1hayi5Nck+zXsGPXeW122TN3MMW5RT9VkRIQXd8Sx+JpXodltMO/8W/1Lq11Raypmgw71/YQWxA2vWqz7n4BZyEI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dga6hOGUCEzTc5Ywn+l8TJNRR4bJ22ab3aBnfdEkTuQ=;
 b=EmlZ7k8V4TPFiZ4oCaerzHZ4vZRHhk9u0rcCYs6QxJ2UvQt2LLoyA0BI3VskT5CzMQxXgq0jigtr5toAdJCTOVn6TPJEhU0N/rct1zUnl1vkvDLGhrKSHVQN4Unr4O6iwze+wlPAWJBeu5n8maN9dslwdldNIDq0tV6R5Tv0W+c=
Received: from PR0P264CA0225.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::21)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 15:28:51 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10a6:100:1e:cafe::7b) by PR0P264CA0225.outlook.office365.com
 (2603:10a6:100:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:28:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:47 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:28:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, George Shen
 <george.shen@amd.com>, <stable@vger.kernel.org>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 06/37] drm/amd/display: Handle Y carry-over in VCP X.Y
 calculation
Date: Mon, 22 Apr 2024 11:27:15 -0400
Message-ID: <20240422152817.2765349-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c56d2b-6276-4b74-f362-08dc62e0e965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cuL9sB9pPIJx9DkQ9tKjKzG2mgqOKzt3nf1o4DEfkYvTkMaFJRctvBRCWpv0?=
 =?us-ascii?Q?oYDfwachJtezrnM31raBUWufQerr6lYykWxBq0SIsBKuoOoaOydDrnfGd+RE?=
 =?us-ascii?Q?DzCUB7n3gnGW3KHCLZwgD+VAEOBK6tYOln5AahJ/UbFmj4NEtFjV9Mivkr+y?=
 =?us-ascii?Q?kK/m6GND9RsPNFI9oPcrtzGBe2euV5VWmhEaDd0ERQUyZlA0/iyB8xtTsrmz?=
 =?us-ascii?Q?gL/+q+Jw1WUL8d1ZVdXmtKGXUkgaolTycDgzpLvvJ5CKcrChYeb9qlKMZip2?=
 =?us-ascii?Q?t4d8TQr1zpNXH6eOgpFvy5xDk0wOyWbAowDdvTSez8lro8IcjjLZkLIkpxpO?=
 =?us-ascii?Q?GBiU0rNo8ol5xHjPKUmj9H/QdIZPl1VktVY0lJ5xNPwSu9yeRokBwzvXziyA?=
 =?us-ascii?Q?W6c67YEvRUZ6S5N3trdFzU7YpS9oaHeo65ldhkH9Lh93/BbRE/39P6Pp1K6/?=
 =?us-ascii?Q?p5DwiSOeQAmXgEoxZZlDsETiFPsDY6G/+8VvyMZ5tYD+Xa7x7hH5JLPva7zL?=
 =?us-ascii?Q?492nDBb+3yzCjEoKgMqdKUf25b+VWYQ4v9R2Cv9YbHPTQEzYq+G+R6s0FaTu?=
 =?us-ascii?Q?HDe4B31iGCd6H5eK/rZhSBmB1WqalHMNoMFAnJitV6VFMFkEbbHnM5AAvO/S?=
 =?us-ascii?Q?r9VRA5Wj7vhWwyqwFq1BjgMpIR//cg26BKiIiIvne4maHBNE11PkSDixYc6C?=
 =?us-ascii?Q?D7zkOxbMadcUvaf3NGn3wH1SK06On2+JVS3+Z2kDTG9gVCeodGQ4AVMJhQ7x?=
 =?us-ascii?Q?tMfXwASmV6VjlVtGU5zHK/fAMIfGCBoNkoyE0vylmZVYZAjbmqkNJhcuqChW?=
 =?us-ascii?Q?73opv1SEdB3cG3MSMPpJKe7HfgsRkClnimu3iS+Y4BJOAMurqfQVklwE5t1E?=
 =?us-ascii?Q?TKZ4J6z8g34JhIVyHDI0exYreUQOD3c6UudBVCojJ34LDP01HgSZBAAle/gQ?=
 =?us-ascii?Q?Pxzxh95llds7S2t1r3YBIQG7c+7LACiwixmNx6zDuC63zmIhChVrYbtsfKpA?=
 =?us-ascii?Q?i6HDbjI7W8q7SKUD3Jsbyoc0RmSyzf6eDTy4V7aNyqcLczbdgbhqcQ429rT9?=
 =?us-ascii?Q?WVkZF1ufqN1pBtcyNdk4KM4QoPnx8/dvuVKZqxIMMz8NWYf8Nw1nWgwV7Tak?=
 =?us-ascii?Q?ShyXtgCrVpzxcmHF5neGOd/dKdbDWurnqTASpwFXhlxIH0sb/ySXZl1L5pjz?=
 =?us-ascii?Q?qhfoTcYU4WhHm69gNK39fV4mHQUlxqIvy5OXOhuOsmRbVeFHpocTYEVybSdy?=
 =?us-ascii?Q?Ll4TEjtSrqe7NWCdKZshukh/OkKW9np/PQBl+eeTJfITPCweUeGGmCEIOVuK?=
 =?us-ascii?Q?wKI7HasYvGM3bCaAgXz9/FkBLx6vPimrAbT+/jR4G3d/6pA2f1McscyCXpR2?=
 =?us-ascii?Q?YFAlYj0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:28:50.7111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c56d2b-6276-4b74-f362-08dc62e0e965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
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

From: George Shen <george.shen@amd.com>

Theoretically rare corner case where ceil(Y) results in rounding up to
an integer. If this happens, the 1 should be carried over to the X
value.

CC: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
index 48e63550f696..03b4ac2f1991 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
@@ -395,6 +395,12 @@ void dcn31_hpo_dp_link_enc_set_throttled_vcp_size(
 				x),
 			25));
 
+	// If y rounds up to integer, carry it over to x.
+	if (y >> 25) {
+		x += 1;
+		y = 0;
+	}
+
 	switch (stream_encoder_inst) {
 	case 0:
 		REG_SET_2(DP_DPHY_SYM32_VC_RATE_CNTL0, 0,
-- 
2.44.0


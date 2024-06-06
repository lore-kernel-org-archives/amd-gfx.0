Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C2BC27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF72D10EAAB;
	Thu,  6 Jun 2024 21:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZg70fEC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2616510EAA9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHAbxbwQefUJMt+JgqwtXx/vD5Q0MCbu0QqILMllGSpcu0J6mGah7yJIFMn2adDgkhlZhJec1GbY75kxFxQlCxXGIjSN+dJnbBR7260J8FrFAHPzd0poU7PU2/M7uTwMLNeW1u1xa4ymRTdZS5KkhCiaBYU7DSiIV/23uttZCdUj5578MDVlavuaVqdyGHcw7WZz6SpNVl852+KPQTBU49kQ3OTYyaEvJgVGvWxSCGYavaH/6e/3xicVwb4bTjYkY4gca1XXHelRQiGACUCrkSvUhSD//x6raxPt8RbDFYw24qD5rAolTIB7iZ01aXzokMkKYO5vjbb6XGUcGZ5lgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajAesSoQFC/OSnoimllLVsX+mMKiYMq0ZCF1nzSPBEo=;
 b=mMa6oHgLDNnBGoSbpQVWrw/1LudjjTrSUXZAozUUsua4au2gmInBtD6vJhYcDpFA2ASeOm6hQffUTaIDbyRS24O5/Yk+Tnmqo0+8UOifCiV44+ijh3Qq2jP6KKffkUPrAx2ABiydiVu2JXGqyGa0+ptqajdIGab1owWByuDA1L835c1vaYzq/zQAXKSgNhTr1wHlBuy8vQN/PIflkqEH9kPnNcU3HPVlvZmvcB5yiQO4+6dCinjKwo1BaClJVawDefyqEqMAbELeBvRFUr97b13ric6G96UgAf9myeL+IddwYVas1KcRnevaaZloOw0fF61i2bqcuraOtEKFj0nasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajAesSoQFC/OSnoimllLVsX+mMKiYMq0ZCF1nzSPBEo=;
 b=TZg70fECyjCQMnvUvZ8wo+aYFRc+jS8nmHzYAXctIyM3Vd4X9ImVWURVdxHgCUTNjlLuJ6jQ2Xp4MFyARPt5y4/0J3TLwQ69kctaJbZdswo5/q4iKCpV3+OpIjoIxdaFFrE/KNDoVSeGkdOzm5/8yTG1za+XjHQf+AAhFHV0mCE=
Received: from SA9PR13CA0022.namprd13.prod.outlook.com (2603:10b6:806:21::27)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:02:22 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::fe) by SA9PR13CA0022.outlook.office365.com
 (2603:10b6:806:21::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:21 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:14 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Michael Strauss <michael.strauss@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 17/67] drm/amd/display: Update FIXED_VS retimer training
 pattern delay
Date: Thu, 6 Jun 2024 16:58:38 -0400
Message-ID: <20240606205928.4050859-18-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2dfe65-e04b-441f-ef40-08dc866bf575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vmBtDH/qpc8QXHthHWXt7Ej8U6jkrKBhtfp2OR3fgUsius4173tKY+UdENlw?=
 =?us-ascii?Q?oFYgGseUNpWsWWg0VDH5iIV1NioAazbYOeNgrFLXrKkbk4P86KhKr2QW3pBN?=
 =?us-ascii?Q?+cATveAdH1ZYF0J59nvM1kF0E6zwkV88wIygQUqdyGVaBLuPjR0PFGPwKhbK?=
 =?us-ascii?Q?LAwXL/NgQrEyqEiczgkbnBI/40YVmFgQjyj8LV+vGkJYDxeB/NiZjGYa7zgb?=
 =?us-ascii?Q?mPA3p7Fs5IOEU9rCsYQwDtrPfzGaOUs3654j0YEhTjYxMf1TZGpGq5nD7tGR?=
 =?us-ascii?Q?O4z8l1ktjw71kSBlL9fxxWyo2TwILGzlINIXAWCt4ZjkoFekk0DvRHWl0Tji?=
 =?us-ascii?Q?nKbuN40zvAkscW6eP46YHhgJ5v6hi3j52vgt6RMJjrKJ7nJxqRtem81wwQvp?=
 =?us-ascii?Q?hf8oP3Yu4WQqoyzD0CIxZonCT+DhKbrn+1eEXl4aGXWkwErvLIhbDBzS4Mu6?=
 =?us-ascii?Q?CNJueti8oqwxwUmgeFI8hUH+OcP7LvewB4ggsi18B6oZsVx+wKXmK5U95IdU?=
 =?us-ascii?Q?26I1oT9OruMZMe9TMCMOuebywqaUOGTkLJNgVKjm+FNimdYAsI0oHCcGnbyA?=
 =?us-ascii?Q?fcPdTdGH1CbVNpe8p+RPYvrkAPtvXcZFZBxOY99T6Htf64TXXIGDtxvK9l2M?=
 =?us-ascii?Q?0+bMq+sR/LoTly0ZhVNBggpK4JjFH9DhLZN7lUjkb3PBORzJWiklFl3WBQ6y?=
 =?us-ascii?Q?tgToDwDUX9u4rSvw9ZAZtOeRAhLtpk1h8DXqIzol3KU3yeHqjtdT+MQxlBpl?=
 =?us-ascii?Q?+SiBidHITsX0eLlgV924usgJ77gxGbUxN6zf2mjLpn6DLa/kDDAgEVPqdRDr?=
 =?us-ascii?Q?RE4xyZt5eo84iQZWwVGFeuq9KBx2bAIMWqkGqDPpwsxZPGXWoXygLeVWXzB7?=
 =?us-ascii?Q?IhNe6aXv7y0Sa3P/XSuYskgBqnRR47qkLh+GOKnVKUq6N0tBng6Nzd6PAltS?=
 =?us-ascii?Q?6GQ7MQDMPyP5H4AhKEbW2PbET5jmIQ5XCBfdHoXH/m1h/xgQ5pB1v5gnrBu8?=
 =?us-ascii?Q?P3DAxcCkM35sVEwsTBxvvqpZQSFtr/RROp927XVSvjikAPLaMuGLj8n3MtYd?=
 =?us-ascii?Q?Os7kqrxwfDQiIUqU07nZvMnznxvNzy217c5JTzU330rtew9Hol3SSoTVKrSc?=
 =?us-ascii?Q?0bJbJMNnQMTnLnDQW2LhSfIXGroF2Wd8AWfzn3reHNrWdjgLWoMa3KTv4Vmq?=
 =?us-ascii?Q?nRDy3tac8pMgodl7DNeWn1aVIYQls+EtpZ0SWjWp6gR9xeN7G9ZHjw3gxJ0F?=
 =?us-ascii?Q?MLSbDnRCmJL00abeesLpC+NSix7bIcuIaFY2FbommYO8AB6Lq/EKlY141c+b?=
 =?us-ascii?Q?32uc4hOcIEesTyl3y97E2Av4rfVW0owIUlIK5a+zGe6rZIcCsy7Y5+h4ZKIj?=
 =?us-ascii?Q?DDinDfNSUYEyaa7KgPfR/apjPNa44rw8UBmF9EROfiAQ96YGPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:21.6756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2dfe65-e04b-441f-ef40-08dc866bf575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Needed for PHY patterns as well to perform electrical compliance.
Also need to increase wait time from 30ms to 50ms to resolve very
intermittent UHBR20 link training failures.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c     | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
index 5302d2c9c760..116ff37126e7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
@@ -168,9 +168,9 @@ static void set_hpo_fixed_vs_pe_retimer_dp_link_test_pattern(struct dc_link *lin
 
 	link->dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
 
-	// Give retimer extra time to lock before updating DP_TRAINING_PATTERN_SET to TPS1
-	if (tp_params->dp_phy_pattern == DP_TEST_PATTERN_128b_132b_TPS1_TRAINING_MODE)
-		msleep(30);
+	// Give retimer extra time to lock before updating DP_TRAINING_PATTERN_SET to TPS1 or phy pattern
+	if (tp_params->dp_phy_pattern != DP_TEST_PATTERN_128b_132b_TPS2_TRAINING_MODE)
+		msleep(50);
 }
 
 static void set_hpo_fixed_vs_pe_retimer_dp_lane_settings(struct dc_link *link,
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59533C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F142B10EAF0;
	Thu, 20 Jun 2024 16:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uYt6EeOK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65EE510EAF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7ybLQ3Knb9/juy+CXjS5ekWCBwv9p2DURCf4IjKlGTsN+AEUZHgxdy72NEnK8bgecijn7oVKXCy2CS0OTMQyxL5zKTH4pbsSr0VKaWs1zD+tdths1kgJmlVva0CiXX2nh1Wjb/7Mg+JNnWxiMHRqC6qz7duAAxeCclspZaThAKyDdHAEA9Y12uG2vLbGBooCIh/fPyPRHbCx9+nKqhIPZk+dgLlKIqL+aHHIqfawaUJdosYcMKffQDIXUi9SXUTgLWIYarnyO3Cl+P+4UIvDdGarAZHlPcnY4frjY3yU5tMbkVaQUuTCyYw/JWONzUp5IKNa7OLF7qMJoojf6kgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Jvyv8bqVriobYcXWrUTJz3LMeZPwo+hXzLWSYwTOc4=;
 b=Te9lA8kSo8fLVALtnB3VviBGNGgD3/rqbpTxx5P51U49GjerMVvdZ/3OHgSaH4ewahzb3R1QcHksxwjpJT2Xjt8JmavhRC9tv6XTBR+GfC1h2VuuZnVUVtXBp7SYIJsvLnWQfZihNZy7Dh4rVEPfHfF8qxOIfa8TYPzL6TDUMSBe35g2QuTow6m+NhXrENxAxOgd4TL6gN3IHvowSItkLkfH9Isjdlp8PuaPxH12oUi/Xp1nuZ+nn39IfQbMpWlmtYZ5l6MeUlxO7VEDpo2OTg1pTYpZnPWkacjCZup3fsbqDGK7PG/aEQyuxpYCdcwT04NGA0JvjLg8f3t4RcbBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Jvyv8bqVriobYcXWrUTJz3LMeZPwo+hXzLWSYwTOc4=;
 b=uYt6EeOKVAOH1DlTIihm0DHp1BDVx9wo0Lf/E6fWBHfEFf1QbwePKiFMPkx651JHqRaJcMIKqrTBlMPvrkYm3FrSDXgiyFvOzVhx++NqMsVTiYzAg0Bnd9SmVGVTiPV7VpDjhtiXnmRobWs9QXifQF9xBIxn4sKL/cEno27pBKc=
Received: from PH7PR10CA0022.namprd10.prod.outlook.com (2603:10b6:510:23d::6)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:14:42 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::b1) by PH7PR10CA0022.outlook.office365.com
 (2603:10b6:510:23d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:14:42 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:14:38 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 11/39] drm/amd/display: Remove useless function call
Date: Thu, 20 Jun 2024 10:11:17 -0600
Message-ID: <20240620161145.2489774-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 33808c2e-83e4-48e0-4b63-08dc914417e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|82310400023|1800799021|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YyH7G2Wj3QH2WXoChs8PMITlr9yc0yuvlF3eqcY0yafqDj+4r0/+sYs250uI?=
 =?us-ascii?Q?4v5/KdFPUIjYFnP6fFxcd9H2QPZsROe6npUjE5VsBO1aC0tjBfTy7DsSYkRX?=
 =?us-ascii?Q?emqWJ17h7ocNIswA3Yo69Fk9GR+vmJ8aTzK02PW6+4gXYRAIDaezoobXqZ7s?=
 =?us-ascii?Q?3VyM6fYVfJnLZLeQAFYjEPv9zW+8TKuF3JLiKwkoS8XcJC8NqteH9H5D+Gk6?=
 =?us-ascii?Q?kguCQle8q8d1obzevGaAC9SaymwxqklgnvuFMY2QYdBTY6ErMtxSula5U9Sx?=
 =?us-ascii?Q?mpeULkoXaOc2XV6VSnyGD+HzpSAmPPhYrDQQZV5kcBgDXQZv2S8E77aXQInS?=
 =?us-ascii?Q?xsmLScHz+flWaacEfAl4dJ1a5gnBBZxD34Gp/AwMQeDuCP4mxVCwJAuxR5Fm?=
 =?us-ascii?Q?/rrP3nYgccS31Q13cS26xI357O4RfKd+07m9Fpk+vT03sXBu0mIsKF67mkOL?=
 =?us-ascii?Q?vD7sSrRXZe8lE3QJ40wfmPEUBnTbft1fxhH04wyPBfdO3sXWBuhSxOf5hXGY?=
 =?us-ascii?Q?t1Kmuga5xCy8V0mLZlkedqEQWFwMMU5e1GP+UVbucZL/qihNF4ave5JrnHV5?=
 =?us-ascii?Q?/EEVO2QBKmYHLMQ+BGOnuWZXq0ScilP5fNV00mkK/c8sf0QP2+cbmT8+MJ09?=
 =?us-ascii?Q?2BbXq3dOAiMM1hCU4+CP1UqGLdUxJoMGeQuAkqrx3PMd2Yiea7a2nkgMbL+J?=
 =?us-ascii?Q?/tNq6iq3ORi43eecXuIJKOZE1knU7VthBhJskStj0cNElYVmBcaCizNKAV/1?=
 =?us-ascii?Q?ardGWgVhYg82q+yZIH1Qn1ZGNdoYgxlxW/al3S+AT5Ix5lznBpV88M6Vku8U?=
 =?us-ascii?Q?P6u6xcLZ7txA7xxiXnkf6GVw5s2wTHpfNKTzBZis/k5AC0t1PARPPA845NYf?=
 =?us-ascii?Q?xiRDaLxYPWNKxkeM1nsCPZtclOI1Lv3MAT0cLtpc/mh6cIF3zhOfn60oA1V4?=
 =?us-ascii?Q?Ehf7YXLQCt8epsztbhZInrJLxYZQh0nv6bCD1Fj2S+o9UQ2paJXuPs8XdJjs?=
 =?us-ascii?Q?AJb8NJRn2kEe+FWizOJ0my+qItkRRBWgt6kVG2hGSMesPKyRb42kK82V2/tv?=
 =?us-ascii?Q?l2UyyawJI8ujOeEPe/J1ey0svyWzt2+9z+o63ROvBSfJTcwb6Lb/+iMjlBkJ?=
 =?us-ascii?Q?KS6uswSEthk4GhS0+h/sPXmFHchuOF0IlBS1TnCHnRvgggj6MiBLxhEoYDGl?=
 =?us-ascii?Q?tBiutQbRSVDy7p9EqKShH45BeTk0U0gkqMa15nuUyjr97Oe2yt2B2t49yBUw?=
 =?us-ascii?Q?0qQwyo2f/kHmQ6ckwr06WZoK8907TkAodqEgEWCl2HvbrWWPjSCVQTxtkeBd?=
 =?us-ascii?Q?Tby4nvBcYiYeUhU7ALbZOl6LodBLQWcyp1VaJUWa7AcmRZysmpfEsgQ7GNXC?=
 =?us-ascii?Q?I3UAAkPiC3JVzAF8z2FE/fYlJ5H7XgMLakQKlWKfYJnp7dHj9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(82310400023)(1800799021)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:14:42.2962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33808c2e-83e4-48e0-4b63-08dc914417e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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

[WHAT & HOW]
clk_mgr_helper_get_active_display_cnt returns display count and itself
alone has no use.

This fixes 1 CHECKED_RETURN issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index f77840dd051e..7920f6f1aa62 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -113,8 +113,6 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 		dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
 	}
 
-	clk_mgr_helper_get_active_display_cnt(dc, context);
-
 	if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_mgr_base->clks.phyclk_khz))
 		clk_mgr_base->clks.phyclk_khz = new_clocks->phyclk_khz;
 
-- 
2.34.1


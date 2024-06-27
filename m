Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C43C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5F510EB5D;
	Thu, 27 Jun 2024 21:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EHtfYFuT";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E09B10EB5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIL8Z/PYoa/HAiCNUApxagmAJ0wUuKROpGXjqE/jmBlwiiDbhmZfk8WVXNZ+YD6jU2hFH176ViaVLaHCBmHmjYrcEawreVeioRmF9TsgewXq01AL/abgGdYfGDN/Vx4T/HpRwhY+hOG8+QcsJzngvxVYFtlOqD54gCN9js8QQme0KQPalqFTNT3o1QJFWwnAbiKosZKdKuqI8In7yhwASn7rVKXHdJH7cAgoI4lHG4CtUQoHZziE3xYGjVGbMvC8P3IkBPIWwTBVbO6ZRrQM9gAQLiTYINEvXDmvNVjHLILqX2fcV+5qOWQ/3HQgSkL479HPjmU/Einpx0OjsV0cKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+AvamC9h68/JzR2jl2TjyInmyN7PmOt22LaGBgAtWI=;
 b=kp5E+7uPPxugUM3NFKLIaHUvHobLk4MyQlvh2G1gG8756mfsNJ9cR8FZVTM0eRTcJYzRDzqIvhjwg8yUkIpUQzViUn8MbWkZY8GH9s+M/s4MPwN6Zjv0TBfX4yavDI95znzp+IaVJd4BSJUei1A/SGmsNWytqnasceOs85lAXJ3FudFeYNjKMCsT8U2sA5HhGxr5uh1d9w0XQ7JAYUL5bHk0wIBGRew/PV8K1IDPWDCUXAwzDGva5v5BEpnvi4UTLZRvfugtZ4GgfMhz4qRkr36eBvcNrRCiWdQMRoyPh6tXQVxBwWcxjiOB0TxVNYKCYyQCNUEiNd5j536seXhF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+AvamC9h68/JzR2jl2TjyInmyN7PmOt22LaGBgAtWI=;
 b=EHtfYFuTMjJi3yKHKaVO4FiVXyDJ/msQ4dFlDKNyMvi+/w7h8Z29s7cY7qFUKamdyV+7DpVSfLWU03PKpA4+QH/R7/6QinbkUPgUFjsk/3lQ+yXG9ewXHYZqa5XPkLKpB7Z/JdO1cVceIFwb+FfVcM8XCrIe5fmkQsi1Jmn0xAI=
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 21:14:27 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::f7) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:25 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:24 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 13/26] drm/amd/display: Cleanup dce_get_dp_ref_freq_khz
Date: Thu, 27 Jun 2024 17:13:16 -0400
Message-ID: <20240627211329.26386-14-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 3166f21e-5b48-45dd-2e5f-08dc96ee20b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OAyfmsweALMuBhoSsZM6s49G3Rn/q/PmrC3FFOYEDSvhrJ1vO3QY7obsm7da?=
 =?us-ascii?Q?++Me/HSa/dkf2y9CFfUhLYuuLxi/9cd9U8MrfR//N98Cc7CVwHzt6ox8grsi?=
 =?us-ascii?Q?heL8UkFZR4cpRKnF3u6xNNAVWQeZ4J2BoVWb7JQYrkqIKzUoYLuOb/Exjsbz?=
 =?us-ascii?Q?jhg3MV5QpiAO+2q6bIvc1oDyE+/LBhiY/6qqAb4oeOOa5FwBzRNUtFRKkoYq?=
 =?us-ascii?Q?7jh5vzNuXldelAs/Na9XZfC6+vTACiDmGhsXsgWh4KSQirEpV9CPMoreLjln?=
 =?us-ascii?Q?t1F6+m4w6Oai4ZpCpVS0BQT/JyUCxLdZTEVH4cUyRxgD1z2Hjq+bJTF77KTj?=
 =?us-ascii?Q?uX7FvQlPhKJ0N4iez3qWQYjw3pmrcWMKBC7d6nWhfonPac3gJ6YKjxvnVTzt?=
 =?us-ascii?Q?lQgpuJtVY7K/zqyQKLy4aXMMx3YJ6UQYUe55ba0TOoPKse3alg5qDZWMSFTf?=
 =?us-ascii?Q?Ba9jrn0bqLlPvS6i6D2Lzv/UEhdWuiT5hXyRG1Je8erVhKc2d3KOlFWG4UBX?=
 =?us-ascii?Q?b8DUIAfUDlSvK6LV7if/DCvdpw2XHeX9gmc2OUUN4ntp/OszClODUmAb+GfG?=
 =?us-ascii?Q?2S+mZClEYL8ic7EWkvPcjP9CqF83H1cUB7FfBF24ck87gkkhf0c1FSNXSRKf?=
 =?us-ascii?Q?vIUxsrmXyaBPGtsEAVHFmrdDMYTt/yjkeKBa125Lt9T+DTvu1BSi0EbBOmKw?=
 =?us-ascii?Q?dx5n/uGtiTICyCQGLeNc6Tfr9mBfxa5unNg2B/HJR9f6EAl123WUWqlFuvud?=
 =?us-ascii?Q?S8It/NGclP1gakxgo7oBPYuDxmgcCb6a+im8u05yk7SjtjyO668IJwCvOPYp?=
 =?us-ascii?Q?Js5TYFSU8BdjuzseolAf8D9KhtoixAWGA1XuqB1dBN3DqewZIOtbRyip9zDA?=
 =?us-ascii?Q?dElIAqmXy/8/m3ATa0vOtvR8bjkkzwWgiZFpxzYXgTQzw9WQnOePHAaGlRsf?=
 =?us-ascii?Q?DUUvAYASvk8X3jTGTBr6aD6MIpGBRBkpd5wNXjWKzWqE/HUtvQ2g7sfOGV5d?=
 =?us-ascii?Q?JIDNIS2zzlcgr/7jTRcUUAuQ2HF26N41ifpTVitLQfacjYU5WTfLYtXo4laZ?=
 =?us-ascii?Q?gXAPNCzShv8nlmeciR6G35QKQV7db7kWRnGiApgyIUbx1iR5dGN4dWVm26fZ?=
 =?us-ascii?Q?JqTBtIqvAOzjtHVEqolKeHqAuh/rQas1PBLpPoOvRqF1SLuzlnSQStHs4sz9?=
 =?us-ascii?Q?JBHr/SmrZiucJRBRLeRjDhAXWDSP3HJKRDPW0YM3GN8XYnWhTKSPwuxFj56n?=
 =?us-ascii?Q?DbTTDKnOERFf+7Ylj3iYSlG/CWsF2uHDoYe2SQff49F4x3SXd+RS1IrPkFn2?=
 =?us-ascii?Q?+rglpttspcAwMQBw2dySvIWvI4CpZ9xrbGAG4jOI5mD/qUCIcfLuGYKLmwsU?=
 =?us-ascii?Q?+gpFYdLNsEveZcXJjLYYwch/azuqmpJ8gNpu8yirQEENKtGj2eYwV/kMonej?=
 =?us-ascii?Q?hDt1yqLx1th8BeTINHg0JQ0otBOTEtKY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:27.1704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3166f21e-5b48-45dd-2e5f-08dc96ee20b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Cleanup unnecessary code pathes as compile guards were added and removed
overtime.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 2a5dd3a296b2..26feefbb8990 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -131,7 +131,7 @@ int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	int dprefclk_wdivider;
 	int dprefclk_src_sel;
-	int dp_ref_clk_khz = 600000;
+	int dp_ref_clk_khz;
 	int target_div;
 
 	/* ASSERT DP Reference Clock source is from DFS*/
-- 
2.34.1


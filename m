Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A30C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AA910E4F7;
	Tue, 13 May 2025 11:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zw9xJQtN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D2D10E4DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRNuIQOZ6GvdaIYwMA+z/nVjp4D5SDRfOpVGY43T2zCNNos2FtD4Jel/uj2qYbs3qiDZsylhFs3ydI1+g6s+FtOqJA//RhP59LwlD/lKOKqzOSZGI7pweUPd1J4zskUG3ebD4enuX5+ejIG/lOdQF6Zxq8g5ESgMRKcnwCOKOam3qOJR2fiu/NX1QNEJgKDuCr4tXniEIKW926I0WKjzbYGtcVQfBjsxzh6UpeEUla4vqD87d8p95E0PhY5/K3ZRWU9trkRkp2O2hExH90ltfJVkcKQUrA90ClFOL5NggmnD6YaDL7mK5ELawkLmay85/qR8svPmAA7LGRJLiCiAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA10mdnKkWj3rX7lGVbyfzVAulMiatdKqvv0EPcs+zw=;
 b=QmARWnJzg90wyzxsskM5cbw0aqmNbotfH7KHo69kk9NgOh9Qf+dGQ04dZzCToITmToWwdWMr28e7A1wTxbCSJ9zQCrRck6f+14uVjm6CXANZLPgm7E1XLHRQwZEeYBn6Iyl/5k2EQcgQbn2ThnG2MdSWzVefizaOLnNmgx/HwBr+aYe7T4QB20T9ccwjJHcquK6k2bStIgT4LY9frFHhomhK0ks/cn3XP/dVGIJgI3QOYN7rIgR2WEMt2csHO+L/Ohcc0G+KqtST5rQsNEfn04qy4adJ6pH5femEByLYMK1huB8cIaKTivn4UVAdo+EJ0pooXPC1QLtWJJPAGhoeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA10mdnKkWj3rX7lGVbyfzVAulMiatdKqvv0EPcs+zw=;
 b=Zw9xJQtNvsyiasKThkFngP4HGp5EYd3RdtWpgqzYLCHq7nCELSS0j3TktwHp30Spqo4+OUqqJ64APdyHEe1mvdYkDmGy/O9Brx738emEpldbn+59xm6mXdEFtkCRzPwgfQ+pjQb1wo2iz2XRK+WhtzhyCQ8LlM297vNYzclAKSw=
Received: from SJ0PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:33f::17)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 11:25:13 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1a) by SJ0PR05CA0042.outlook.office365.com
 (2603:10b6:a03:33f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Tue,
 13 May 2025 11:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:25:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:08 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:25:05 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Chiawen Huang
 <chiawen.huang@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 05/11] drm/amd/display: Skip backend validation for virtual
 monitors
Date: Tue, 13 May 2025 19:24:33 +0800
Message-ID: <20250513112439.2295366-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: a1137d8e-6d6b-40d3-47eb-08dd9210d309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6GTwHkW8VYn+aN3wxELDwRDh17/z6rs/eL2f+B3pYwsPF/6mR1oJQbA+WXyj?=
 =?us-ascii?Q?ZLD/wAshXX0IvGGl3w8NUFgoxWPLY9U2nZgTGwsMNjd4rgm9li7JWzrTKYr2?=
 =?us-ascii?Q?qWtg714FgniYHZK3lbNDr8fz4VkSHLBVEejJevq2E3qrTin8eccudPdzASHF?=
 =?us-ascii?Q?vBNVpNcmgHnWmVuDBk1n8Z5WLdYB5lD0zbcxJzwYeh76Rb0fkoGcITJlqWvg?=
 =?us-ascii?Q?91re3Q6alut/AtD5EQRHDLDPPf4KArqepozizyrkR8g6qs8hoHzF2J+ZyZ6v?=
 =?us-ascii?Q?kIp5E0qV0ESqkF4cM+f6qtW2SREyJz9PJkn3L3aMLQwO+jFQXRRJw3DVP83o?=
 =?us-ascii?Q?50k9L6fWWkKMafU/uqmm+vU+DYPfQxRwSmeUqYgf6cEu+ZGy2gVdlo5twXYe?=
 =?us-ascii?Q?Pm4JmDzjnbOJA+hRMvdRRib3fM/BkNgztLHsq+jiRoxLFPkoCeaIXoOr9C3U?=
 =?us-ascii?Q?tsiHQUgjB7nLrrY31dJfmi9uLhumbWpD/lnl4Y5LVCvpO3DsTD15pkJ6uV4C?=
 =?us-ascii?Q?0IznFHKoKNnvOKiJLph4PuXXjuqUn7M1dQ1Bdrsda2ztEKbxvbICFv2ktJrC?=
 =?us-ascii?Q?5ZRgZ+3l2cGIO8Zw0K7UxQAHB0yixd1a5SjQ3fKgsNDhBVBD46jPAiMIeFny?=
 =?us-ascii?Q?N+BfsUh0om8nRowDgJSa62fwA1YL49i2W4gNP4HwGF7cfnTK6Hj+gi2pFYG6?=
 =?us-ascii?Q?6IyAErKqWTSsaOXJQV5gZGbg233/OLUqZ4jwliSHJpmAjooENA230OM142zv?=
 =?us-ascii?Q?SCOGiaR7pYDfKm553ZwcJmvrtDXg2TkIOB+uUNYEDBUynqwgizUBxZ+UakFK?=
 =?us-ascii?Q?dKNWqY+8k65EfFAdbeZU8Fug8272X5MUgceGyBlSGMxHYfKfWAukjYyCm2SN?=
 =?us-ascii?Q?zLnWnK2UBeeMkunuDF5zGLGhCohZbtI1U9IIV9KhMVDcgmxdZJkWkLvlk5EO?=
 =?us-ascii?Q?G8gh0PTQdVwYjd7GPqr6T4BQWX9+m0Xqa8w/fmukLs7asVPwbmXHMyBT4tco?=
 =?us-ascii?Q?AyVnsKZ/XXApRUWZZ9MzqL5DnBThjvs3aJ8BxZk5NMtAupufsRkOW8K25phN?=
 =?us-ascii?Q?PCIuHCC2xrbvO9RRshkHxdZWZldzzB9vtLZ2QjrYNhVU4KXf3mTc/u75D2nf?=
 =?us-ascii?Q?aXiikgNpDtdoOqtz5E6NyA478Qdt48R9bH+FxmNHww1jHdqCfVxU8Xt5cCeX?=
 =?us-ascii?Q?rXMaYYi8o5tSbyJEPEfEWe+O3Vu6MAzA3WGaGDKRIS0Dco1V1hYcGchnujVT?=
 =?us-ascii?Q?C8LdshZ5LwyhDvMCmqEboVkwbVyaM9TVWUtypOLPe3GZAnYc6AlZBubCvgTD?=
 =?us-ascii?Q?/qOka4Yos5AfzG0HaugBrDB+7IsgWKVPDhG7ZSZ1WxUBSGEEWpGA2QVNkS1n?=
 =?us-ascii?Q?2jyK3u+3M2OzNlhbKPmFHPHoVyIhL3oZcVj+Tsl2NMkuqyhdntS2lNAG7Cpn?=
 =?us-ascii?Q?Ujzz/S1MiQKbjq74Awtci5H2+lIoNAzr4wECgE/gOxI0OCesqniCNcspnysW?=
 =?us-ascii?Q?gS1SceZ3enx76u17xaBaGNzkdMVj3S/BZfjv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:25:11.3226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1137d8e-6d6b-40d3-47eb-08dd9210d309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
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

From: Chiawen Huang <chiawen.huang@amd.com>

[Why&How]
Virtual monitors are now being validated during set_mode.
Virtual monitors should not undergo backend validation,
as the backend is intended only for physical monitors.
Virtual sinks have no real backend part information and
should be excluded from this validation.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 608aa2d7d086..56d011a1323c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2334,11 +2334,15 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 	for (i = 0; i < params->stream_count; i++) {
 		struct dc_stream_state *stream = params->streams[i];
 		struct dc_stream_status *status = dc_stream_get_status(stream);
+		struct dc_sink *sink = stream->sink;
 
 		/* revalidate streams */
-		res = dc_validate_stream(dc, stream);
-		if (res != DC_OK)
-			return res;
+		if (!dc_is_virtual_signal(sink->sink_signal)) {
+			res = dc_validate_stream(dc, stream);
+			if (res != DC_OK)
+				return res;
+		}
+
 
 		dc_stream_log(dc, stream);
 
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A06E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DB910E712;
	Tue,  7 Jan 2025 15:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LdtFNAZW";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB47D10E712
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6dfeT5YgD00DzYWz/FRTvur3otodS4NCz+0gm6LwJTPEBNpbcTZrvAPR6EyUNEzeMceVkh40c2yomB6XqRjzHp+8VOUumReyZ8i6/ec6rnzvC8VoyU7/SxRFadgnJVdZi+UJaTFbZrejUpzcIDXYlJRqa1IpU5b1QMpfJZYO60kjT+s1x/pLTdA+FoNpAdurQr+ujShu/lH93KfmE1Ixb98DmYsxU+gRPI0TkLPJJ5cV/zGc9RXgmHE0qMkzRumK9ZOP6klkO9wkVtiJaxrc5SXxhIwDucSLwXwqQaF/nlKv5zJKZsJ0sqvJojW/h9V+H4zoDAeynH2GvGjTyzMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5ozm//KOI6upM0xDkD5NZTIchW56TYynrLOleMS7W0=;
 b=Dik4mB3ZgRjWNMajTo/1fsbMAwY3kPO2ENhxHgQ9Swjf4xAeD0wq5ItDkEP8R5N+DIce9Qd9YloaYN8lc6sWBQhSHEIZ6/JcN1p7JRosnqVu0gFhiZkUuu2Arzsy5Mwk2PUMc2UzcLvituxibvA+Y0JSxy9CF+oAmfiWJ/1wY8PwNxFc9+PSoiHgNPqBHD1UDyfsK7wVfhsgXJTlOZ09Iq0WNK6dtZv+FMlOVBHT4SY8T1zAzE+u3vq9tt5J8lngE9ZAoPyADJzAyT7JHaH++eq7UMTMR3cmanfyCX84lI9Smm/PbflzDH0Wwj/8wND0Hk2HtSFt9Un1WylUyJ88WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5ozm//KOI6upM0xDkD5NZTIchW56TYynrLOleMS7W0=;
 b=LdtFNAZWijZ0jU5+IfaYPP/DDEEqJemboKH0lQ4fQs7ib+6WTi7qcQuH2v5b1fn4ElYrkrnwu4db5kB9lIy1CnfEQJXpYjUpI6JfyEA/WukWIwk8a8+S3gb0im0tqV2EHXNvKqZaqttcIO+ETt0Nf+9gcsKVZ5Uw3SEHFQcuNng=
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 15:29:07 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::8a) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.7 via Frontend Transport; Tue, 7
 Jan 2025 15:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:29:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:06 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:29:02 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Gabe Teeger
 <Gabe.Teeger@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 01/24] drm/amd/display: Limit Scaling Ratio on DCN3.01
Date: Tue, 7 Jan 2025 23:28:32 +0800
Message-ID: <20250107152855.2953302-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: ab04d7d2-9385-4ef1-0e74-08dd2f300698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tw/JhAztI/7j+Wn9j/uO4I9uPPuilb/ukslkv5Ww7zbsVZOGLw7Mg+JCv5V+?=
 =?us-ascii?Q?0MRPW8dDutiPDxsp1xaKIyOqWJ2hPxkfQKu7mUyebCZV1WDfwk2AFMiNvtXt?=
 =?us-ascii?Q?hoHvBo9ujmu2FvZNhqnYT+L0EKIM6rW2PIBJrlBj3rbripx7msLyDBvdqVVI?=
 =?us-ascii?Q?HLYcFIuZYPFmnNbKa9Z7VIT06ob0tadqvyGO8y0p407kgElu+qGVXXJt++gv?=
 =?us-ascii?Q?BCecEpuKTn/c4E5Pip/RGi3p/AJIGAPDCS57kSoBZFSI6OL0YrtVFPmQ5gjj?=
 =?us-ascii?Q?dno6HnFSK8Lgo1bcW06djIe2rrJB8ErAT2tqTxdnXk8OC37laOa01DkyESNB?=
 =?us-ascii?Q?HsUHvbYTPEvArUP5pQ/M6f/GHqElpIYQl8y+/0MBtugGQEs+A4qxmJF35Hh0?=
 =?us-ascii?Q?wivNELQhSze5Eae56EAnlnJWXZNNWKej9STaBRNTkGz7fe3h4bqQiPq0RF1N?=
 =?us-ascii?Q?s/eEXZDgya2WC7LfRH00Cjitu86XjWN7/6TN9IfR30py1FYNNdhHr2VTWj+J?=
 =?us-ascii?Q?T/O8joEFuvb9NBQ4h+f3Xa/qQl8bo31YUCHX8jRY8yElLjLdU4i9M5seJD3q?=
 =?us-ascii?Q?iF8WS0Csz0DJFhfXxA6Q46DnFnfvYBGDpN+RLeyOYhYAYL0V4vyemZWjcLWI?=
 =?us-ascii?Q?rXWKJS4FIVMX7f2mOT+yt9miJjclDKSuB2+9hfPI1Cf/+I8olv8gSJbRMmYS?=
 =?us-ascii?Q?sU/kZARA0J3IgxAqlP3lWRuH0iydYhwPc5Fc5reh7g1YHCP/GRBWuFLfSBvt?=
 =?us-ascii?Q?EyHDw519Aa5FHUco9ZNWhkSRP/v+ngZasHDuxEjPhjNO7cKK+PmAUWUzL9QE?=
 =?us-ascii?Q?rEckx4f5riikWdhirmEx35mso8KrCI6z5q2jcPZ0ZPgBO+r0LTqRbjzL9/OC?=
 =?us-ascii?Q?Ouiz7VUCdfoU48/fjhyv1KkCrEadp25v4Cpru7p+SYgMlqa/js25YSGScIqb?=
 =?us-ascii?Q?5nQrXBg6fa4xr7K05LWuwgPDG84wMlh8uR3o7hD/7+g+IKTk0BmcRCTpkbFc?=
 =?us-ascii?Q?CuMBE9W+U/cMSHYd8vvCJyOLw77mr5raolc7e8GUF2dCSjF1hMyBc+kQ+sIx?=
 =?us-ascii?Q?HeiLcmN1OCxbW4cAeXzWYL8PmaTN5kHxmhUjKBq1rjvK0fIs3NDMhXdy//5K?=
 =?us-ascii?Q?CW8Y+RH3ePRQFxzsW/2HATuSepZweVH3NQRGyTY8kwf5xpQooKeCkIDqTwN0?=
 =?us-ascii?Q?aAGoToJ3eMd0ACtxU++DRlTilH0qEEkVzT4GhF9NPjBKm/MGpRQZ9+2R/QmP?=
 =?us-ascii?Q?uQ1tECo+ZQtGQ7l9KOa2Pzi4+6Edkivke2mPhsR7TeRNBx+Cjr5xW8Qa5OyA?=
 =?us-ascii?Q?A5UNDse7p1EhIcaO//B8YQOKLNBcO2EEw8HhCA734WdIht83y2aV6DRV5GVV?=
 =?us-ascii?Q?VM12Hl/G2ev9g3KbiP+8qnpfUSx3xefrlGq8shT0VArm9Ws9nQ1mVhslSwGS?=
 =?us-ascii?Q?q2fruSw5S77fBqeMJKL9TL54aWYvhUBDOLbaVTz95lxURxJc/WXUSrOMiw89?=
 =?us-ascii?Q?R0LK8yiWTS609ks=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:29:07.1261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab04d7d2-9385-4ef1-0e74-08dd2f300698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
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

From: Gabe Teeger <Gabe.Teeger@amd.com>

[why]
Underflow and flickering was occuring due to high scaling ratios
when resizing videos.

[how]
Limit the scaling ratios by increasing the max scaling factor

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Gabe Teeger <Gabe.Teeger@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/resource/dcn301/dcn301_resource.c  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index a9816affd312..0cc8a27be593 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -671,9 +671,9 @@ static const struct dc_plane_cap plane_cap = {
 
 	/* 6:1 downscaling ratio: 1000/6 = 166.666 */
 	.max_downscale_factor = {
-			.argb8888 = 167,
-			.nv12 = 167,
-			.fp16 = 167 
+			.argb8888 = 358,
+			.nv12 = 358,
+			.fp16 = 358
 	},
 	64,
 	64
@@ -693,7 +693,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 7680,/*upto 8K*/
+	.max_downscale_src_width = 4096,/*upto true 4k*/
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
 	.underflow_assert_delay_us = 0xFFFFFFFF,
-- 
2.34.1


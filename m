Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE2DC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BB710E650;
	Wed, 25 Jun 2025 04:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IeJCoQ0m";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23EDF10E654
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHY/1sK3SZVyhEEyrVUqZNyYsncBFEEPbPYOpKrNOVNoa1XjLerhOpZzH1C4rqHZ8CYHUWL5hV7YdH7yS20WnQN5VZvOidbg/PkDcGlcvqW+Ldxs6lcwM7MJEQdJLOPs0Q2SH1U8lTsKPAE4xuWsXe/DnBmhDfB0rXYPX93VlBqqtxLLTMhtnTK/8ColYOVWHA8pvCKNkn6BlaqAEzeljaZmrkLf1vtSFSlabtYp/MBENMjYuUYHPIx2HyS2ZizENWcAvRVqkW2iIhHbtrRBvTa85W4NbC9a9+HLW3p0wiH0+NZuKg/4UhfA8UzOosFF2gYs9uO3sB+K2GjpqqPUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRWuD+q9d9KyRWuOEA16C2AO5YgLaxcaqq+AlBmPexM=;
 b=AC87h7M4IFNV8z2F04n4Sx91JOSHMpLeeE9hG2ZfWTi5bZMkPG++XP/G2t7e90DAQV2Fq30+bOG/p6yHQG6C3zvi5BRLZf45iihgIlpCWRw5zMdBJfVTnPo21dsCXOS+D2P+CxlcZca75mWrO0heevJstBE+1l0DlwkRdO+frkBtvJkWV2vNbT84Cp8LF0yhHT1S5sAIzRm+4nD/hJCuRDbCgQiKJRiIPoXrO4f6LCZEob3phh3R9TjMlpbpDTTjREM/KMmPyun76/W97nBlLXLmY+D76LNQNI+7sI/mbdmoFfuSwtUtaYARQ9fdFAdDpgSiQ5tfFQoYysBf8fedHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRWuD+q9d9KyRWuOEA16C2AO5YgLaxcaqq+AlBmPexM=;
 b=IeJCoQ0m9yvVXJEEY4ggZiQLqvqCh3t5BBfigrdGEGSxd9EC/OrA3xzvZoWGy29mrrVp5C9Js8zRt+LTtAkAw8+xTluugTwOGEVHzelJXys+1YiKJg+6xikVKw42D99nIyGI8v0XKg4XDT9Sb9nXjZbR84zRoiRjEeCA0DAxMbU=
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 04:05:37 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::14) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 04:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:36 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:33 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Harold Sun
 <Harold.Sun@amd.com>, Jun Lei <jun.lei@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 06/11] drm/amd/display: Added case for when RR equals panel's
 max RR using freesync
Date: Wed, 25 Jun 2025 12:02:24 +0800
Message-ID: <20250625040420.886013-7-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: c6baba31-a98a-4042-0268-08ddb39d8ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mzLV/ERVklr8Sr2xpzYmZ5ARpmGa7yMxVFAbCquZoM15tyvCGKPFhx6Rsb77?=
 =?us-ascii?Q?zzcnZy5rs14fYgSXMvgGEf2BvcsYgjn7u5XvZvJxieqMq4M+1tUFUn+Z5z52?=
 =?us-ascii?Q?IQxfoyo8F/ZNN+S2vU63IfFlYrEwljg0x+GsMiI3h1v6altqJZ8+8XDn1lgF?=
 =?us-ascii?Q?LaQ/uviYGfZbQpTGoDG/N2nHXYbVdAlm8wzU4xNnHqKpZmAsyh8qWgf068B0?=
 =?us-ascii?Q?/8VsBP2XdkXaI0u2eONR1gzPyBDaxq+qvOtfUyHeo7Bz61ozNO7yXuuirc96?=
 =?us-ascii?Q?g6mUJqgwLWqU79EKyjoyyhk/FUjYLtg4jhQnhPuFwgFOHn+Uc9C5i0d9dyEi?=
 =?us-ascii?Q?+YdPCXM1j4pMtB/R5XtBYJoSrAuYdDOSNFQPxDs8hbauJwjLQwRJOQnJfAPz?=
 =?us-ascii?Q?1NdedxudHzBVa7RKewQyet6J37jmOxntXRizqgryhk2iIPAIUnbN3WZggwZ/?=
 =?us-ascii?Q?qq0+ZgI8p/WSlHBQswIDSRX2zAIHPhtHDpCA8svVCZ2Hje3B4VqavREoqNF+?=
 =?us-ascii?Q?uLpO9Fvm/senEJumvN04uQ2CZxjjJlVXFPhfDigHnCaNns/hbJrOs9tUwf70?=
 =?us-ascii?Q?S+cO6R5bsCs1VpnUeBN3yRPW+6+VSsl+sszQ+pKzio7hCWCF+iU+64oQ2u52?=
 =?us-ascii?Q?/5X0/mc4yyZFhdR4HG0HHaHsx93T47OP4TJGDc/zoAsqDI5Nf8iDKvtqlT5y?=
 =?us-ascii?Q?3t2/ZY3s3ZwBULb4fya3YabknoUuVm/txBzZ5do2eRNYHAsRHAeRj3v+hAh1?=
 =?us-ascii?Q?xQUPO03Uov7delZvEPJgzCQRn8LPMtd33A5CHd1EM3uq+bJpJZULUb+oKzPT?=
 =?us-ascii?Q?PpjkmGacAFb3BHTsvEIZbRXuxbxOsjr+Kuv7OxCQpsxpkTGuUetM2mm+J9IN?=
 =?us-ascii?Q?5+R9h7qbdFaJ87mM+2Bxh/+N72zH62u8d/CQG2fqyam6/Os5wCMLvjkPjjWV?=
 =?us-ascii?Q?mDy1TdhNiyfvirS0A8J2g1FFm0bHBrr54GqrPPTilZVuWrwHXKqGyxBWJD3h?=
 =?us-ascii?Q?TdabtyRU6yitBvjL0VqKNWSW0YhbICvdrUV/OCeHY6UFuYgaat5OJbPBP8Ot?=
 =?us-ascii?Q?Jyql6t52ZeUb68rB7OxsTYiiF4PHlNrgZaKtjUM8HmSP7SCuHBxNNXzWDVdZ?=
 =?us-ascii?Q?+ay0Rvtt6rUP3V0mNFohMaxEYNaJwr343HKqL/FdJDNwavlykeM2NJ60fG8L?=
 =?us-ascii?Q?35Em8P5tpKokTguCPUzNDtcryW5rMJYdlAMLWo9CzhC+8w5bJyZ4AqDccYeu?=
 =?us-ascii?Q?NNvW/DkgiGPV/dCVm2mVz6+8A8Zyh2GYooINUEq1njyfGUVpZa8RWNz1pqXI?=
 =?us-ascii?Q?EGmlrAgeWnvtqLIHATA8kuwOCInTMPfri3TN4IFGcUFPYLU4zqzFlyhi72Ky?=
 =?us-ascii?Q?DknSXyZWfNiSvXUGccjbZlfVsaS1tg+te5+FmT53t0DHKXBmNjhdvQnxSPN7?=
 =?us-ascii?Q?Fb0gYT9KDp6eAE26GMmN0nMDG6n6GiDKywx8+31O8QYWmyTKtjsBWxNeaW7E?=
 =?us-ascii?Q?DNcQkHcqeFUdnAk7jcx1mNNWHfFtl7N7Kq9f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:37.4791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6baba31-a98a-4042-0268-08ddb39d8ac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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

From: Harold Sun <Harold.Sun@amd.com>

[WHY]
Rounding error sometimes occurs when the refresh rate is equal to a panel's
max refresh rate, causing HDMI compliance failures.

[HOW]
Added a case so that we round up to avoid v_total_min to be below a panel's
minimum bound.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Harold Sun <Harold.Sun@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h            | 1 +
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 809fc696962d..667852517246 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -974,6 +974,7 @@ struct dc_crtc_timing {
 	uint32_t pix_clk_100hz;
 
 	uint32_t min_refresh_in_uhz;
+	uint32_t max_refresh_in_uhz;
 
 	uint32_t vic;
 	uint32_t hdmi_vic;
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 6a939f2f2fb9..71efd2770c99 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -155,6 +155,14 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
 		v_total = div64_u64(div64_u64(((unsigned long long)(
 				frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
 				stream->timing.h_total), 1000000);
+	} else if (refresh_in_uhz >= stream->timing.max_refresh_in_uhz) {
+		/* When the target refresh rate is the maximum panel refresh rate
+		 * round up the vtotal value to prevent off-by-one error causing
+		 * v_total_min to be below the panel's lower bound
+		 */
+		v_total = div64_u64(div64_u64(((unsigned long long)(
+				frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
+				stream->timing.h_total) + (1000000 - 1), 1000000);
 	} else {
 		v_total = div64_u64(div64_u64(((unsigned long long)(
 				frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
-- 
2.43.0


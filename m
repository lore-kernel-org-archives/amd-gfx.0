Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD464FEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE4F10E79A;
	Wed, 25 Mar 2026 07:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRy3v/Qu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DB010E79A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tm+XCBpqpZA8X9W58qkF+fUc7RhWz4h14/KUQ9sudFOoDGP/mbanutCwtLNTfXXA39fiLhWM9Sk8lHeOvZkA1I5YfPNnQXA51OjHIanlf4AXG7yaOm8MytT5LWzG2HLPAZQSlN7l2QUVU7DEHfQlOCVl1Fppnjl1q9FM1tUFjuYS4WZ3RGgejdnMqHgrvgDo8/NiXTBFFz9Xy487O4lZXShBSLsv4P+4mNH+PJFV+N4lMbWZZif9QXppk6x1sngIqC276WazBgCeSVl4x3TNQ/XRFESK9DUcXuA0H8b/NDho/Ykqtne0+MwVDZnzRTDche/wiettbnRpXMmQe58XhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++Pn9vm5049OHAYrWsQaWUrZMifmmbce6jhkvnI5dds=;
 b=RkEGI2vgfRn05MR/fcVbYLvFpL+1hkETP9ObYv6GVFPYXBIGAKagedk5v4DcDClK+4uluJZbQ3x/K/SXZBlRiNg2shl2D2VkDnazTaRMLDf9l/TdXepdOBWeh4hldFc8kHEtO7KOXmQB0XPZ+jywAPJFFCsdI0/SS7pqSYFFpzlLo2O/WA3xCvKaCtefJQL72wANFLPXDbd1dbmcmu/NiEPEMvhCUgnN76uLjRRS9G/bC5kJ5I2QgdZJgWXpTGoIGkN8s8Yg5r2VPonvKHSSmrvk6DqXy1BMPTLXF7t+40DL2Cp1v5G+Cx/n0fCWvMV0AP7jBIPgA1iik0o24wTHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++Pn9vm5049OHAYrWsQaWUrZMifmmbce6jhkvnI5dds=;
 b=MRy3v/QubbUXy9KduDgRwVR8Ge7HDs2cZRoCemEHa5tT70PfpTUe9ghR8DRGQnnU0iu2YyYf6WqnirqrLzd0qlBUDaiyw7rQvU8gm1OyWBmrteKh0PfgnMZiqwoztH7zNk82CkFrDTKZGbr4QSQwkAVkY8GLfTYLuiIXmGzYc7s=
Received: from BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::12)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:08:58 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::a2) by BLAP220CA0007.outlook.office365.com
 (2603:10b6:208:32c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 07:08:58 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:08:54 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 06/29] drm/amd/display: Merge pipes for validate
Date: Wed, 25 Mar 2026 15:06:12 +0800
Message-ID: <20260325071003.4022594-7-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: fff5b80c-28de-46ef-2fc2-08de8a3d6272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 62dXmtDLlXvIY7As3QNg2yQGb7A6PwzTSvL94k6EowWIwV0kkLIVL90/p39A3Gyju6jCbw1Tu53Pmh9vhiSGRlDTd7Pk9cQaViMO586PgcDK3h940srMI9gH1z5qZPzDmjnouADXttvKQ4iOvT0bcC2p0jxXMwYrTCiGfyvIbZnD02I82VJyC9urvonntR6xUAPZzELpU7a7yKpO7JWkMVR7fN3rjs/qZsJ19oEkbSd9ngxZoB+4d5OMgxFhCAvtGO5JmfBvQRDVisqCL1AZygh0pYPL8FKhTuEagvgV11avWGcXTSfuxulf5mfGnDLgrZBl0cRneieDJlYI573s/15T8FzgR5jeLPGniR6qPRbS8rfD4Xy6GhL59lMWZ3hEv4CHGLfFTbRGReE7NEmRMFy+6Rp9pHq5ADMlyRYmJrrmTVgKZNPJkvZl/NgfD6kmiIqmRVTzcahRfAh106k7L9Q9QtrW9I9KaPKk7RlVAGR9t3tjHBr4vfzYjmkzgOwb3mtvl4/ORAadiMVGC6djO75eAzZywOYUNdh2zDF7ILtil5SpR3PEPgrMdkdR9C2nf2WV/NqcGEPgvW0SzD7F8PAGZ8MweEIxKy+oZCW9r7zhWY2qYxUeZcjorPguNmMUHHEvIU5DUQ8FYbHK60+XudAroqxKLS/Gwzi5u0Z7uZFsLDqWhYqpuu1F/0kGaEp7n5HLaSOEkd9LGIogKbRtLC76mVGuVxwEemGGGwLS1a2ld7SZI6AbTk/Zujmd0e4j8EFdVNnEnZBplc6MsDhufw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BE5QF0FKOP2z6vh7zgzJ1a69rB8hAgLtGjcudAU25nf8aqdVVz/wGFuq5WA2PnDaBvRpDo2M7lyK1D/dN/r6YLHfOlsLxs/u1hedKbU57TxreQfgalLK5f3U0Yt4Bb2+jQyCGJrlTP2Osd3qa4g94fxXxbJTLwMJ+ymNbxmz6rDZHieMcABeGaS8qkjJkLqdFKy0tw/8pOzK7gYu2KgaBMaYeDb2gO5u+FWEeq7K50pVn2h3Qe093z4zrhaYrXQbAP6VSAsqgSpzCQBlGBf+b8jqRCQLMWyui7pqy5kktD+YQiqqXocqfsxx2Eay7MDYeFZCLTPnysUc6l/2ExpwokAYEYrc10KcfkMX6qOWcn+bM0RdGCc6BH5RMMkuQ2mYUEmrvgoLekBzArqyuZVtvwNVbnB5MqZdFhx9wGYEwmDMv5oTCZ+wnu7XbNemAaew
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:08:58.2026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff5b80c-28de-46ef-2fc2-08de8a3d6272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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

From: Harry Wentland <harry.wentland@amd.com>

Validation expects to operate on non-split pipes. This is
seen in dcn20_fast_validate_bw, which merges pipes for
validation. We weren't doing that in the non-fast path
which lead to validation failures when operating with
4-to-1 MPC and a writeback connector.

Assisted-by: Claude Sonnet 4.5
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 66b1a1c2db1d..2c606d9042a2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -1645,6 +1645,8 @@ noinline bool dcn30_internal_validate_bw(
 	if (!pipes)
 		return false;
 
+	dcn20_merge_pipes_for_validate(dc, context);
+
 	context->bw_ctx.dml.vba.maxMpcComb = 0;
 	context->bw_ctx.dml.vba.VoltageLevel = 0;
 	context->bw_ctx.dml.vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vactive;
-- 
2.43.0


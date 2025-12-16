Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36CAD5CCB3
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8281910E751;
	Tue, 16 Dec 2025 09:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EDVlo9Jl";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4258410E6BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfiugePnEAwgGepd6rUSvF3jpDo07nFisB6fpcD+S+jo1/fYBVG+kclZ42iJZwBaYexvtMwe/b1D41uPeyPd6G3OW3altpsjxDAtby/bJUin7BgtT/SkY79LMEeWJhOkWmzP3ok9q7UKAVEIvqePbVtvyAl/gLs+Tzr1KkgjlXL2OAEeNgr94EnQPOi5iyQKJkQ0pRGxu0S6Sm2MJHTwPdO0V8lujdZH7gw8elNeWjhu/WaE8Sn4GBQlGsq80aBCT0HGfGci2RioIJl41R9oDw60YDtl53PVVgv0XbEuysTOzyaj00fqJNZALcIizCQrm1R3Wpx8z+atshK/ox8j5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxoN7ML24HtOLPDVA75uxDPdX+dlJicR8GM4nwe4ABI=;
 b=kZu3peIo01V1H9E+l+aKWUnZvIve9vRU8sngvB7cnhz89iiPl8cW3kN5r/xpE8R1y1bUjey7GWDz9JNZcCvlCzDGKQYlupJQCb2Rh1vPsd8vXYSbmEjn88IRFxYsuHfZEMm/d+3JpEtBFjEhCxxbtwBFW8fGgm6GUIsLkHpBDzG6kJaBSmJz58gNgQL6xoqrQxyRlMfspgd1yHw/+JvMA3IAStVecYH6Imk+7ILffXFflDPApMKfUl6OWfoaoqL/BzsXP5wJtRFFvv0vzudlaLtXOs3eaAGE1WOPY9Tp+FB77th6FWz1ZobTmG+608dKogzrDn6dgxVpcenbkIyRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxoN7ML24HtOLPDVA75uxDPdX+dlJicR8GM4nwe4ABI=;
 b=EDVlo9JlPffLNLEQo0vWmReqgoJPV0Ym05MggDcxVfxKGVvEFfQHWFKkuGZsL6exfB6azzFHWWq86oSopUFJH1baOcVHc6zFuHK1nlUasdEtJTOiiCXzL3Yqp7S8l+M/BiQZ+j9+AqEE689IprzE4tL3UJJ1+lMcDVaK1nqbDb8=
Received: from SA1PR02CA0016.namprd02.prod.outlook.com (2603:10b6:806:2cf::22)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:57:59 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::b3) by SA1PR02CA0016.outlook.office365.com
 (2603:10b6:806:2cf::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 09:57:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:58 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:57:55 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 08/16] drm/amd/display: Add new fields to fams2 config
Date: Tue, 16 Dec 2025 17:56:08 +0800
Message-ID: <20251216095723.39018-9-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 30200008-b1f8-4975-8e2a-08de3c899846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Srp+TZTN7tHBpe5FGF3mnTum0rRy0nz3u+e0Y9fpKQFsgmGOSEU6GTooYY8A?=
 =?us-ascii?Q?OR4V9aymGaQG/xybafArkgMjVAFAh5iV3r2/loSdXzxlDsQBTP/Q3hDJ1dY6?=
 =?us-ascii?Q?IuwfO2qjwJatjXGZ/eabPASHa9HvgQi58Byrv1vA8jHyl3RttlL5+sJDEvMw?=
 =?us-ascii?Q?WT7Bq/drgmkaIsOBTNkJoJsL+BAun7qCHUGuOzuB8qrDm2HVMcNO4qWre4Ja?=
 =?us-ascii?Q?uRHv8PR6EG/YT1pWg8vCl+uS1CNnUu1Rs45O68u/Xb9+Jai6dz62lv9REiQs?=
 =?us-ascii?Q?y/HSzln2qtId8+7IAVhPlG0bL4fozPoA7njfdHZwBL7woLsUsRHepAJ2omnc?=
 =?us-ascii?Q?OF0Fi38BLC8ssNXX2diNP4ieDoehyk/17TH9uUi17dsvCyfxOgZ8yKwurlCc?=
 =?us-ascii?Q?KLbISh276kVDiXwpNlrQ8wZu/wfByRaUB+xQsxhFFHFrQZt+rUJ2SC6998XE?=
 =?us-ascii?Q?OyrFhfLG10IzBOg5Hnv8i8TRdyt2+UynAqKUTbbiN7V+5TIBtsTkThrRm9zZ?=
 =?us-ascii?Q?m39NhMfFwh2ZuQY/BjETmRMn1sDYHt7wHKo6QTegAZqo+K88w5XauLnBgG1U?=
 =?us-ascii?Q?hQW5/3TPRnwjjvu82F3ewDZ4qfCphhLXjSeyAITv+49dVAvfvdnwn8ffNSvj?=
 =?us-ascii?Q?9mE2zheYAe6cmpJrPwEeGAZLfwOSJMxhEy0vOOlK24DtVpOFhstynSl9A8/7?=
 =?us-ascii?Q?+S8U6i0lz5ySxCsqTaoyQxVqKkbMD4DZzu1CzgB3dqvFaM8mr3MTtgj+/mCy?=
 =?us-ascii?Q?DnqNe0w01/FVyxzd4H2na0MXAJNZ9Se0X1hCWBX32BdgOKBRQbRmkMNilbna?=
 =?us-ascii?Q?SFw50WENWQa4rnnM+ycrByRhQDgrXn9pA6yA8NsA34IUXtXYDuYZMoOmSQAz?=
 =?us-ascii?Q?FZ43qTlIliJ6suHi5z+/9ilMkEgr+VwjkZA2XiYAS2/elVe4SEhZVfi27jmh?=
 =?us-ascii?Q?p7A+ar/ikZ3vHn6sT9eUJVhjl/WLSqfkDw29LVc7j0Sk0ET2QeukH4jEugmx?=
 =?us-ascii?Q?RSn2wsae3o7Vy1NqZ9lDQwMvAN6lc1N3wb14FMLGFZ7WHno+2u0l2rBF+6lB?=
 =?us-ascii?Q?J2ZC+Kshqy8BYXIoF6vNP+8raLYmF+Qvkg827wiVR4iATr50OaHmN42DQ0rM?=
 =?us-ascii?Q?e0Q4XfzbsdCsbNkZTEwq4VQFwjQyfuOxr5NbjFcjaCfPARK0TzX3oiKGVjgw?=
 =?us-ascii?Q?n228hSUDS2PFn23EqBIiRiPSI7tBTWKxvHHopC9oaMZ0ISWYqV9kJ9f8dIRj?=
 =?us-ascii?Q?hDezbDMzTIzTITe0R6qlZyPhlEzMjoCJ/KoVm4jTm6Gg2X/Idi0D5dtgBuXF?=
 =?us-ascii?Q?Pkr7b2pRgd3puAjST27gI9gf+FjLAZ88NNUNSeTayhEmygrVsyWYEVpmII68?=
 =?us-ascii?Q?0nbFeMHqYvLoc9VbCO+FnQfUOd1Hb9Z8/967v4Ah+HtW8hU3FeQAJKTXfbdr?=
 =?us-ascii?Q?eA4jDYKtoXJkmUqpWYMUEEZILdMlE2C7szTywfjQc7DLDK7lpy2ORWzY6/Bc?=
 =?us-ascii?Q?Et5B87q2CAXC4wLaH56tPTrQ6IRPb0rfcFXVyAgZL1PNAML3KWr4+AhF30uZ?=
 =?us-ascii?Q?NWg2DmmCHiJIsUMo0+U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:57:59.5402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30200008-b1f8-4975-8e2a-08de3c899846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Adds new fields to the fams2 configuration structure.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 019eb005bba8..83cf4888fb54 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -66,7 +66,7 @@
 #define DMUB_SCRATCH_MEM_SIZE (1024)
 
 /* Default indirect buffer size. */
-#define DMUB_IB_MEM_SIZE (2560)
+#define DMUB_IB_MEM_SIZE (sizeof(struct dmub_fams2_config_v2))
 
 /* Default LSDMA ring buffer size. */
 #define DMUB_LSDMA_RB_SIZE (64 * 1024)
@@ -603,7 +603,7 @@ enum dmub_status
 	window_sizes[DMUB_WINDOW_5_TRACEBUFF] = trace_buffer_size;
 	window_sizes[DMUB_WINDOW_6_FW_STATE] = fw_state_size;
 	window_sizes[DMUB_WINDOW_7_SCRATCH_MEM] = dmub_align(DMUB_SCRATCH_MEM_SIZE, 64);
-	window_sizes[DMUB_WINDOW_IB_MEM] = DMUB_IB_MEM_SIZE;
+	window_sizes[DMUB_WINDOW_IB_MEM] = dmub_align(DMUB_IB_MEM_SIZE, 64);
 	window_sizes[DMUB_WINDOW_SHARED_STATE] = max(DMUB_FW_HEADER_SHARED_STATE_SIZE, shared_state_size);
 	window_sizes[DMUB_WINDOW_LSDMA_BUFFER] = DMUB_LSDMA_RB_SIZE;
 	window_sizes[DMUB_WINDOW_CURSOR_OFFLOAD] = dmub_align(sizeof(struct dmub_cursor_offload_v1), 64);
-- 
2.43.0


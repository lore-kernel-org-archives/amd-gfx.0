Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5614EC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED01310E56E;
	Mon, 28 Apr 2025 13:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fcV9cg5U";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832CB10E56E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XM2sPfJOkxAKbkUEqbkR5EcO23SS5WcCUNtpjXszvO8cE3YRmUFqWfa9xtXQJE+T2zNgV4jlckGfAUSEnDVgANelLHaPh9KNO1Fnlh8e70CJ5tg2f8Eo9sBsLqxRQ1THQX2TsEYmg1zYYqtiwTyMUnrh3XnctLuQYiLHWHI5LO9f2vqvY3dF7eb+tI6cXTh5LMcLtp9m/jzrYZhZ1+2PtFr82vbmZ5+XKDNUxxespfcqXvDfk5q/IOBPBUGaiV6lNfonDi2Ko6MerXZu+TiSSrmBbwBlXcMSXkRqAfHt7+f0Qn8ml+Z2cNM/dcwJ0KA3luYYSbs4pG1NXN8llvAsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8QfYB2+KxwQfCDDEsX8roRcyFL+3K1KBm3rMrjYWhI=;
 b=xlqb2QcwZMBNJx/0051I6t8x9DBla99qz72XzRE/G+B28gjwFpjdmTToRGE6ZJVrsLpFz7Zg9djQu8LmCm/cdG4tBTf6vaUDC2BN7OFItBYRtKnNK0TgwiZRlXA0LBIjoL+EkyyCnBG39AyevpBE7TWyfZ5ODrQwoNP86/qasQYIJXEwOcOrOS1jetJGV9uBWkxEaonfGLQBryHm/rKLe5UclyFU+G2bJZUruUzOb16sy92eOaZc/lnGlNvGXG18DCVsgVAzsJv35W/zSZX1HK/3ZHggL2o+50wnZATC6DIMxJEA4StEe9PqhOCTC67ggORKljI2nbZowTOE/d2zWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8QfYB2+KxwQfCDDEsX8roRcyFL+3K1KBm3rMrjYWhI=;
 b=fcV9cg5UVovue8fMXO0oyVgbzd3yY1uI7J/0pIbB1t+a6TGiiz74ipA7vo8FiGY4HcP+OOu9NN3KoVAKjR8S4zNdipeLbhjYzXWsI+Oykxn1Z3B3BdXNz38YPV0P3n6UB6E93KRVE74c9svYb8GL9ju0DymGzfxsDBDJUzIyZxw=
Received: from MN0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:52f::27)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 13:56:57 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::3a) by MN0PR03CA0020.outlook.office365.com
 (2603:10b6:208:52f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 13:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:55 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:52 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 18/28] drm/amd/display: Remove unnecessary
 DC_FP_START/DC_FP_END
Date: Mon, 28 Apr 2025 21:50:48 +0800
Message-ID: <20250428135514.20775-19-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc8dcc0-4ac6-4a2a-add0-08dd865c8a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Totd9bYBYi/tBc6RDvahLyoRhqcnH1rxvHlsVPe5bcKYJlGWq0JsNi7T4B+j?=
 =?us-ascii?Q?TEJdmiAwig7YxEPjXS2jsUjHJdOsuBzLKOlYnwZhYGlftsd9zoX3S4zychJ/?=
 =?us-ascii?Q?3UvR6V7nPaMCsilU3O38p4kZmnEAkh8m3RL0oMZcEY2+cEU5VG/v/Yf+u1o2?=
 =?us-ascii?Q?4bEJzGJY2VQjNJPXm/qWiMlsMFLOgeZ0cuj7zO+NtF+9xZ/DeBQB4tgqWAfx?=
 =?us-ascii?Q?w2yWFHGtPzUM6AuBR2+5K4L7JljwLqpq2kGh0ja5Migtm4WW43QX56whiQR9?=
 =?us-ascii?Q?/nludwLprRA1sdsTYoRYQHaITdxKgxFabzfBINSopzC23S2PVWxAcefssnsq?=
 =?us-ascii?Q?5lVYyr2qjLl2lvGMEQLIbMTtA0OST9yC8Ee/uZgCXNxsJeqFhpqH9pqbeyg+?=
 =?us-ascii?Q?k2J7dFLd6dwI/+bINPKdjmU+OaDyCKthxfoT2nrryxFMqbw0CRTpAKyuWnjr?=
 =?us-ascii?Q?nJnRbuA2VK17CUxDPB6Riy+nCmyhmsecwprVG35jxn/x8oEtte90YYTD5pGW?=
 =?us-ascii?Q?TeHM3IQAPXUnLSIaGavRC9KJCT/oQmCuJJqz2hw6Ja6vhX5O/A2UWnCNDbo+?=
 =?us-ascii?Q?Mjz6I0ozsX0UdAsKjjiKnsfkJCjGZDECRQ1uBHxdq2ifDU0vhw87uFSEutw3?=
 =?us-ascii?Q?tUrS38ut/8Et2hAClABhRXmBzl5DfSswmECAEV8yoKoZHlfgNmiKC2C/Kj63?=
 =?us-ascii?Q?E2vSy6kQRpgyKNSKPmdDZTzRdEAoPquX7Wfk82LBgyapQ7Mq/Ie583ea62Nr?=
 =?us-ascii?Q?WVwWq7wT8V0wwI8v6nsIismNb5NBsaHbPhYPCTIIq9VUeQ9q/lHJ0l4Fhw+6?=
 =?us-ascii?Q?18jBddeajZXzUuCjHkCBhWiboaNE/aWSu0GjghidMGM8lZ3Q8sdkuiEmpnzU?=
 =?us-ascii?Q?wo1mgtKfs3xnSoWxGFvQSewRmgUdNNRpGpo6USW0rnmENG8o9iXwFRxCcBd3?=
 =?us-ascii?Q?ZqpMa+IjUWqooBkYCb3tsViVSEclPEpw2i7F2Tyfo7/buJ8YLwhWgoWiTdB+?=
 =?us-ascii?Q?64hoJfl2uP9xhfTAf43xzRJOCpOiyLkIa604oWwR8vYt1KBU5Hz0dwFls0/g?=
 =?us-ascii?Q?+ngaOqg/MU9HtFc73HfW81ZXcfEAL8XXtqZMQASgCytQGQXPUJhZcTpyVanx?=
 =?us-ascii?Q?HRpWcV6+RAzs+sgfX9QkSOZiNqu1lAKYGBieYj3HvKOHDXbRaTB5kxso90p/?=
 =?us-ascii?Q?8VwmCY5fFw9FWJFAbqcuN+0kTvjZCPABKu+8OxK+dfoz8r/HYO9qOiYX/ulP?=
 =?us-ascii?Q?oaO88DRPixW20x/N9ZJxU/ZJZr5vLPzw+aEcePlYrG+SJIXJpY1DlJyRd2Ai?=
 =?us-ascii?Q?VkI1LoV51PqDy+8ZsClHCaFAtbODK828OKLQuOUi/1Du49k7pmmaqsV9plJu?=
 =?us-ascii?Q?tO0bGn3Y8Uqj+9LXCOqkSH3AfTdZWhcT2Kxu3BUA5fQ7g1Or2zDZGY06vWcZ?=
 =?us-ascii?Q?hyWpMQB78MDy56Jh/7GGqz6/kACHYUBeJwCpgCmJ1ls/E3YatKARDcudJ2BN?=
 =?us-ascii?Q?i6oNbUMbVOV9PLkVdIryCBpEC7Gwzm5ZvGdS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:57.0906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc8dcc0-4ac6-4a2a-add0-08dd865c8a44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
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

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
Remove the unnecessary DC_FP_START/DC_FP_END pair to reduce time in
preempt_disable. It also fixes "BUG: sleeping function called from
invalid context" error messages because of calling kzalloc with
GFP_KERNEL which can sleep.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 2a59cc61ed8c..944650cb13de 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2114,8 +2114,6 @@ static bool dcn32_resource_construct(
 #define REG_STRUCT dccg_regs
 	dccg_regs_init();
 
-	DC_FP_START();
-
 	ctx->dc_bios->regs = &bios_regs;
 
 	pool->base.res_cap = &res_cap_dcn32;
@@ -2501,14 +2499,10 @@ static bool dcn32_resource_construct(
 	if (ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev) && (dc->config.sdpif_request_limit_words_per_umc == 0))
 		dc->config.sdpif_request_limit_words_per_umc = 16;
 
-	DC_FP_END();
-
 	return true;
 
 create_fail:
 
-	DC_FP_END();
-
 	dcn32_resource_destruct(pool);
 
 	return false;
-- 
2.43.0


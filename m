Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F7EC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A3910E43E;
	Wed,  7 Aug 2024 07:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hcSQ5Ohh";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B456210E440
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9RrXaHzytE+AJICk02BcoTHZz7rZ/29FQk97Tw2oRL6a6RA5JFEdhJSNMMQThKxJt90KyQfcDtSuV8WCyuDudI/cks9W7EhsKQ/VF+ekMMZPIvEUiZ4DDVEfLmSW9F64+Tup6pimgLnhl8ONxHihlLA/WXCFRUcOFh7lDN4qX8EMcbO2/f8skSdgft+meoRlpjWko1aLEHRaseY6yzSK7znp64Zjn0ENJC7PZxcchTbUi553CAiqz+JAGudDn9l5fN4TV0aHCH6znVXwrrEeAoBHZA4FCCR60Dd7yrDb+cm9FB4PfhECvgpnsGVfweFfVp7ObZPLU0gx/tHp5JL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycj2vQeuynapuDdjj0XqafZ26jkfx/+mVXaYbmXGdnY=;
 b=xZTdDKlA2uLnUnOQOy88UOPDUE27FnrtrozYqtip3V0Snv0kiDzhRIgxk9Wlmx77elKiCJCOiUQF+PpepwsQIa++J4JorRocIPyRywvbB/TeWycE4qSIQtugOzjfy2xUTmc5l+vxDthg+K4vIcxj33VPsEKkRN6MPfUYufIiolsd839wXRfT2rJPn80rmhMSO/lz/ocag+bvzBcZ41dgrO9zGru7ZFBFx7prgL0KMlThLu6uUSlV2MRQETk98NTmMCwIX7c8giwpRJNt0sXf0/v4Yig8Fs6bOM47S/mFTQDDdmWq2c6iR4t83P0RZRNQWqTLA6YXRhFDz9kHqvV9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycj2vQeuynapuDdjj0XqafZ26jkfx/+mVXaYbmXGdnY=;
 b=hcSQ5OhhuAehc8Z6RNfLhRV57e/oFAmyYhCjKVGLZv1s8ZWgpva61Xlq783f/4nLVBXnXuKMVL5f51iyPWi5VgNcvz4Am7m8LVAamKUIxJNO9/9uXqD2Ar65djidZClTtwNQZ24fJCbFw1Jtgu4zqMGnEn+yHSWh1obgcjF+p5I=
Received: from BN9PR03CA0147.namprd03.prod.outlook.com (2603:10b6:408:fe::32)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 07:56:11 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::e0) by BN9PR03CA0147.outlook.office365.com
 (2603:10b6:408:fe::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:56:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:10 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:56:02 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 04/24] drm/amd/display: Check null pointers before using
 dc->clk_mgr
Date: Wed, 7 Aug 2024 15:55:26 +0800
Message-ID: <20240807075546.831208-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: f093784d-9ee8-4cc9-9073-08dcb6b66732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WiCgM3XmAvk2IvVoe7bAI2wPI1KgCcpNxXeKdZzeVadQc97EyUlp4q6TEwoS?=
 =?us-ascii?Q?7LeTaNHHTW3J5q2pY0zMjIfcrnrMLpAwmOLSAzCcQ2xOuXlvKWy6JhcMIeij?=
 =?us-ascii?Q?pKz8Np4WhV75vSQBw3zOlXO4CM/GqFZ6KLUdfHPYNETnaHd3SEbZZ8toYZUc?=
 =?us-ascii?Q?gN21v0CcjG+Q8A5pBndrhm0c4d5IdBm4SdE6mPjzScCUYObyNsxhCnU4kEue?=
 =?us-ascii?Q?7KHsBvjhvpVvHkc8M4XF4UdeMFpExSDFmIhzid1eosrgnHJeg8cjy9GmM2K3?=
 =?us-ascii?Q?XQW2tp7CH/OATE0tqj/dFzS9JlTCEJW0vtsXkwPVAuRKzNqyGWIzBwCX7R5k?=
 =?us-ascii?Q?WRk1S6KTUS619aAPgaRmSjaSfmIiVJ8uvzgh3EjPKYIfoPj8tlc2lIA0Q6o1?=
 =?us-ascii?Q?FBt41Kn1200A9qDuqloVoLnGe7GzzKvZht5pv2C+ECxMTNl0QVItKeK2zeJw?=
 =?us-ascii?Q?lbtnkbemnca7/a+qnOnFJpDeCQDE7AAOTOBaFfJV3nhF6b4tmGN9IIQIxxcB?=
 =?us-ascii?Q?3y6WGJyst8fNhj+i7MjLX8ROLSxN9GmWQwtBPfqbP0w1oy2Svzi/Y155cd1w?=
 =?us-ascii?Q?XFKFy/BUL/0jpwgfJn+U2XrN4pXIdQx5nllo5Dh70j+Grs3RMHqkvYlHLyAt?=
 =?us-ascii?Q?BFz2gP3rSWiYsmnGTdDfBBoFS++kerF/bcTT6UL0F3Lj1HnKrTVXKmASTxV+?=
 =?us-ascii?Q?x2pvIFoc7TFd3tenMGuuh6Bpp+F6BE0BRiH+yhMQ43PLMAd6HoOpeRnwO1uH?=
 =?us-ascii?Q?cvmz9q1mrkHD8142M1vB20Ap6EuhHPxjuLJY+g+pynMhHC/3VSN1sNS+++Aw?=
 =?us-ascii?Q?SojXv1vRrZ/qPdl1s8tv00cinrYtlrEzQvQMA4MO9N1OXUl6PZI1nUHbxfXF?=
 =?us-ascii?Q?wZngjuSnIX3fehC28/8WAugjhqsfvP77rO2En15ub6iPSsMIlcNaa5cqI8CB?=
 =?us-ascii?Q?9mgGD57CXlNhCE58L9aUCRJmp8uf4Cu8tZAEz4lnFlqwOWiHdC89WxkWxRw1?=
 =?us-ascii?Q?qcDPjx4CNAtW8DZmOx11gULCPDeTnKgy+VMeSt9wgEjHXJIBHCxP6/0aL4NN?=
 =?us-ascii?Q?xkqhWaBaPnRhyEG207CSgQf8VUjk0T6fVGNLGsQMaFgp4Sd0zuvGecPXiANi?=
 =?us-ascii?Q?AA7vRV3W2p2LxyPK9O22KAOD8LYm9l8ZETjg3+pOeNhDLhOHIBRRmH8pScDL?=
 =?us-ascii?Q?r//GD+guEa3+cuW9mtItzzuUMvt1ifOeKpTlaLTkFaP6LihwbATWgU0RAfL6?=
 =?us-ascii?Q?bD7g3gnR2+RoGXxLC1u06ZwhRWuaHVjpYY7iUpengAqPmekAySnUw8Yhy/vu?=
 =?us-ascii?Q?KO6gx9A6AbOmtdUXEsFvgSS8M6BcsvqHczr8JH0JfbdsKpxd8ZdySgVFdMVr?=
 =?us-ascii?Q?MiDmLKGpcUp53Upmdn4bMCCR8PKp7mshaqeeXgphVuqfsDrmv5qlPamMzXCT?=
 =?us-ascii?Q?EA6pRKwRPw7pGQbkg4v55IZz55PqIRvk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:56:11.0656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f093784d-9ee8-4cc9-9073-08dcb6b66732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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
dc->clk_mgr is null checked previously in the same function, indicating
it might be null.

Passing "dc" to "dc->hwss.apply_idle_power_optimizations", which
dereferences null "dc->clk_mgr". (The function pointer resolves to
"dcn35_apply_idle_power_optimizations".)

This fixes 1 FORWARD_NULL issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b1253e4c81a8..3ba2acfdae2a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5425,7 +5425,8 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
 	if (allow == dc->idle_optimizations_allowed)
 		return;
 
-	if (dc->hwss.apply_idle_power_optimizations && dc->hwss.apply_idle_power_optimizations(dc, allow))
+	if (dc->hwss.apply_idle_power_optimizations && dc->clk_mgr != NULL &&
+	    dc->hwss.apply_idle_power_optimizations(dc, allow))
 		dc->idle_optimizations_allowed = allow;
 }
 
-- 
2.34.1


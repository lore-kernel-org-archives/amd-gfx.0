Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E9F109E540
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0722910E918;
	Thu, 26 Mar 2026 03:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PhXkZXNZ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC3D10E934
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7BeqzWlh+1BF5sxAQeJUJ/zu5uY/uff0TdG+BlvlgSZ8kVikjwqFf8snaCoES2+kmwQEpN9KccxX3nQJ6h8zYymIycIFchNXmfmA1iY2bNM//oBjpW/9dqsoFUOwZ0UzN0Ryp9wXoeEgQxxJ3i/EPCOmV/p3Po/gmMKcUinYI/4KOmEm1xFL2oHXNXifJNA20lamGuJXaNWaFOVuTEa/UI8nqzMWRObfaBwd+2R80mjOnsEU52W0mMZk6KNC0uBQnrnLWBR20Y8oSg4f1y7goX4VgpWvzUZQD6GNhVdGfNlv759RYz/C8wA/h0cPl9DiOI6vX2rI4QIIZZZ/9iVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++Pn9vm5049OHAYrWsQaWUrZMifmmbce6jhkvnI5dds=;
 b=dJF2RMGF4dqL+4w2+P+q9io1yJIy3bWzxRDNxC5J0cCHqfq4E/m/N5tLCTsCXjlPAtBew+1bT3xrf8PKigUpuT4bJyGhu65Ixzw6cGd8/VKQIhGSqjeB2th46IzjptUV/j8JWRrgIfalfovLjs2OrVufVq4wTu2K/9B4Ibj1nj4YJy4jP1gVMXztfNDKa+hSDyCPnWQ08g70cOrUGIdCd/FqiAPjKw/Yvx68THeFIDDAqS7QJZ98xDKU/RtANh9zFZ+ZVYasXcyAaXBrzQcw8OJOwj9/zsEaSSV+Efa8TGNcIVfZnRIS5vDLiG0OlyOvIfq3lGzvUeyGRHrX2m5wDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++Pn9vm5049OHAYrWsQaWUrZMifmmbce6jhkvnI5dds=;
 b=PhXkZXNZtWbMdDCK63bxGnv4RhebRpID9wj9f7nrYYNJqocn1tdFm+FA/Qm4lzg/KKHF8mPx/abm76ySyRpBckfXf+ElS4/EjmrW04SUYKWCpvtU9jMhqtbgMOXQd8lopJzNNVFFhkkjPCwzoEQCkqjNPiX2eG/7D2XoGPu6ilg=
Received: from IA4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::12)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:00:51 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::48) by IA4P221CA0004.outlook.office365.com
 (2603:10b6:208:559::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 03:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:00:51 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:00:48 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 07/30] drm/amd/display: Merge pipes for validate
Date: Thu, 26 Mar 2026 10:56:58 +0800
Message-ID: <20260326030153.406612-8-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6c0306-6bbd-4c69-813a-08de8ae3e3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Udt/ghNA49xbL3YwiH2G9TMizFk46kyzWG1SoNaEusV/eW2dxwndNMhRBh6cbD89WUgxgxYHnOGqWRTaxCfDyhsTkVEKRWuNm8z8/3QnjUmRx4g/Z+T107/6bu4sE55ZwqFprmHs9s6XHpR49eWsfS0tnVeRUlMytSqCSUt48e1B0E+caRJOTktK1IK3TLlSR3hifg+jwiCDBCmC5HV+2jZEsSPiZ0GtrntgXxZnot3UZ9Nz/ywy+r1lq+bqwNKFdYOTvrI9tAktsjEaLhkJaRXxyo1Uxt+a5kEs4Yv4HENMY4/jWN6nKqxWklQSOFX7kHP5ltMD3poIr4FWZLWs6hbAlQI2NwYCz/U5TGGmbA5bnXDrpoZGKGbmu78RQMNGuHkmzlxTKMPlxJcnHEZC9+yp3t7xBP6EOHckPe+z65sBxv5YweNN8ZYf91lARFoNn6FlCRJrq/tap+34GsVT3C3GqA2oW6gtnUmyo7OP7DfhpEXUZ+mcGqeV4erP0+rfrh8BMp6bpWx52n/H6f/Hby7UKUZYurMWFHJg85OeVjxZc8/R7j4YSOAT4nHwnUmtcz4nKBSL8Fooc2ARjGiyN4x9Fy3s81Geq8eLsfhKViod7fwUnov+irOTD6m6rRSks6LdJSang6GXWwcPrcVaIlnTL/PIahblaJyeidkJvSPbB5PCcvkpnyAUa1al2uwYryowLJBxurkIsf/+lG0W8vVhbVGdYkWP73NumWw2zy1SIByGubRhq+SRSWjloS5vD3eZuoOun9Z20Kp7JNiW1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZRChsrPqAno84Y/mGP8PNqDhiM5ddvDjS9Cpz9k1o6LhJpT4CuZNzvF4ROI8Lt7ZtEpTvAbBUXPBmlBxjyOueZ1UDMX9Zk2hQZlGirAXCAjqxQFbo0LsB9Gc6OIChR4+5ui5oBdk07HDvQzw2D7+OJHNtiFLs1mmdo6fubpcuI0TWr+WVY6Jyxh7axst2SYZQK1V18kVa2w9sQ3h2WSDUdXJboj3IfZwoXs8ucYRB1VucJAQ9MORwQzZqYS+rZNKXSvCHYf8CKgtPH+oeS3jtUlCCsDEJsQynn4lahaNWlrpGsJAbftFvSpFIMEAK8gd22Cr8Ut5FTHRn7PESDEHsYeyCgy9mo/ShJfvQJYaZEM6EpZ9ZyKx6EW9S1uDCGhvLu4/nH2pRLA2psfww1h/fcAXnOHaYQIbn2Ao/6oCPS9qVm1NK2jMNqxhH2u/OUUj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:00:51.6984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6c0306-6bbd-4c69-813a-08de8ae3e3ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330
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


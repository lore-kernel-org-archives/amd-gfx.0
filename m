Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0529F513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFAF10E308;
	Fri,  6 Mar 2026 03:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fe6EbaAJ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012024.outbound.protection.outlook.com
 [40.107.200.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 734ED10E308
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyUnh4iqgNYOK/JiUebhMr4dfHnEtj0mW9HKRveqnsfTaQY4rTsfMNAYAx1MrnB60H1nIFIBr33+uVHNayg7nF2bGH0V9HNBFayc14zLAVSbyjEXVyEnM3fmLBJ0RQwW+wq9T5h5QFS8F90mP4wM3ekR+t6aNkRnde6006FZM1p0XRzLWFCS15eqez0+BbYCvJoo6KMfcP9Ham/f0P9caqp6wh243z8y8Y2SXxpapJqqDBsNLB5g8p7D9SXtH4NUZwRTZjw8yEsomVI6gQsxHbXP36wqpfZpjQD9xQ0Z479RMYN9h+ApZn6/BEEgSDxIabXKeMx72XOTQQZEOgk5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwpQeFe1TMCFeK+qgPisoZkrgJ1a5STglDUxYQlmnj0=;
 b=Ga9cGNdSFkKvk8pJo8L2tonaxvuKwL7QCVW9bgwgbWs4AT7BJh8Y/MdShLnAE/ad1VIEB8eBuzOnKJA1ALG0o4n564f8uQTNrTx46atQW2sYs70NT/EBJOvmzNrje1UoJTdiSnnmbZfg5kxn1zjtTmTfFk3fRe0T00d+Ld3hpvBzpLdlXRW55ClkDd65EKk/l8dpzhkxv8QIn/ODh1HSajR/4DHEzst/lPMeihD4k3J1aw51ylW72NameuaUO5GNc9fbxiJQkuWXiuj7zc90FuRE0/KvoK+DsT7TplAX3Heq4TKhHy6EVuDZOmatPkJtBGosdHWzGCaDMaY9TeLMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwpQeFe1TMCFeK+qgPisoZkrgJ1a5STglDUxYQlmnj0=;
 b=fe6EbaAJRQVqSrExgIWa3Z1FG2mabtQu0d0EgRMXCgu8116mL86Fdgo+mEncO0l/ePcDDjTk5w+NjG86cR8wTUGf/24tBu4WRXj3WQy6U4dbIukh/99Ef8zIqL2Zu87dTa3hM4thuXhmNDnfK++cQHKD4m53bqOXmW4cCz0NMd4=
Received: from BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 03:26:57 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::4d) by BL1PR13CA0389.outlook.office365.com
 (2603:10b6:208:2c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.17 via Frontend Transport; Fri,
 6 Mar 2026 03:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:26:56 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:26:54 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 14/21] drm/amd/display: Fix compile warnings in dml2_0
Date: Thu, 5 Mar 2026 20:13:40 -0700
Message-ID: <20260306031932.136179-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 769b5c49-f8b6-4781-1e08-08de7b303872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: RkFO4/ZrDkXko8X/0jLfVe4izDWvcJ3NaphziSNjCXSXYAjY27qk3UQEDIsz51vEwGs+27ExfSMBEhjsLmMlR9hngOpQoKt8sJRFWepZExm5Pic95Y/KP6lKp09sDrxjvF6PFD2SytoPeTyga7kj6u0MtICz6b0eSk8iCbflJdFnaCrUA++k9jxTK/T98xgXjI8oqF0EMicu9qBOoLU2xsZR7TgZHVb27eQe75hKtyD90K97yM9eIMF5hVnHf5TA2JAp7+lfSMHGlGF79g95X+tK3XsxmjzOY2cpGdit6ZesttZq091aZoMOijSv9zOtp+FjlMvORp57bV2sg7HutSsGNK9q1y6wcjA5T6NclxMUZSKpxO15/3C1cfbq+KdDOB3llsNb9qTkT6zw38T5w5iqmQzbmKJVCr0B6CrvJ8rL+psALS1hC8uxJ2y7aF8mlUE2SVIq6eqRRVimNrxDFtfRiCxi3xWAFFfTWO4ujjdSJn5qtnSeBCemqkhgDNKGXEwKq9QRB+n1RN8hTqjeKDZD8JXP6uacUPXoEyWDzOSeKghLBnDnFjwnyddK5q062YT0I5/aZ73l2bRzXsgTOTESDnP2+BymptYkrhyu303gRsx1aWAMKUSF7r0kO4w9iN6uTggQ9eD0Oc1r+2QPua63rJV/NCfAI9w3VVveUjojWTH2LibYu0tdeZeke6AKnAUwKkmfVyIPu0qRGuUq++O+5H+VpXTMxSliv9pENNwDpf2r0fk9zUOWenU2b/yStGCKW0NKzf+cTyNAw9qqiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mT19RLTrk8brtl+Vqj1YbKg6l6c3yPeWRutfgdIn8RlLlWdkTapxKdu5735FUGjo5ORYqNkCcrxJUszhR4ym/SwnA65bnzQ9aGpmsZuOoi18JBNc3I79WkXT19iO/OpHNPM5Bp+bffrNPPKAhPEH6SWIciUvaVnqRl7l5nIl7DRylsrSUR3wA1KLlLWP1UHjct8hHFxSGMwrt1zgXEc2u1YZkpILjWrCrJYE+jl9FZzFxLyzBAhckURR7EtFFVZivRHdtO4XohtDug6pQT/PqTWto/5Bug5Rnugc9xIW2Zymx7UC2FFfhAWPqIa5FgRDuYvVNip2BA3fCRg9eTgR1GSl4ophkqCIT+YS7gevlloxj7QtkYpYExXFk7zEFAOCijGy8XCTV8t2Z2rwB5OS3Pr4jw2Zmstnta2/WnBdkeZVpVE54E7iT7w4CytuPB9S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:26:56.8488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 769b5c49-f8b6-4781-1e08-08de7b303872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

Fix static analysis warnings by ensuring swath size temporaries
are initialized before use. No functional change intended.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
index 09303c282495..8e8935995fca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
@@ -4089,8 +4089,8 @@ static void CalculateSwathAndDETConfiguration(struct display_mode_lib_scratch_st
 	dml_uint_t MaximumSwathHeightC[__DML_NUM_PLANES__];
 	dml_uint_t RoundedUpMaxSwathSizeBytesY[__DML_NUM_PLANES__];
 	dml_uint_t RoundedUpMaxSwathSizeBytesC[__DML_NUM_PLANES__];
-	dml_uint_t RoundedUpSwathSizeBytesY[__DML_NUM_PLANES__];
-	dml_uint_t RoundedUpSwathSizeBytesC[__DML_NUM_PLANES__];
+	dml_uint_t RoundedUpSwathSizeBytesY[__DML_NUM_PLANES__] = { 0 };
+	dml_uint_t RoundedUpSwathSizeBytesC[__DML_NUM_PLANES__] = { 0 };
 	dml_uint_t SwathWidthSingleDPP[__DML_NUM_PLANES__];
 	dml_uint_t SwathWidthSingleDPPChroma[__DML_NUM_PLANES__];
 
-- 
2.43.0


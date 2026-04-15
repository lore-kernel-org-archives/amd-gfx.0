Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7EDFA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD3510E693;
	Wed, 15 Apr 2026 07:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cHOXJOGY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE8E10E692
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qI58ghWUlIDccPjChnv/GQfd4k9Ja1lCnhPmiSTr4kBWXPikT5xWhEfgMhEokHGrhapQCp0XOQSNNPoF1BL8sWto95EwyyU25Dj+bUVROrUMvWoATWG9hWz/Hsot7CR/SV+1Nw07CODiOH5odJOE7DThT9Qa8YMOme+Zx7ALf8s+sMr5zQSe/S0Cy0DsKfgAwRgcFsJehAFhgiezEJHsYLaQ7VbVqlnloj1fpKO2c65ABoFAa0l9fzZz6JATkuw0bFDbvUYM/wcmSs4bhZ0/Elvkyo1U21f+FRrhGrOzsFCFnmVFAWuCwIWu9i71eRTyJqrA9N/x4YrDOxtL/5uakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7FoJzFcFFsXM6HiiG9re2ataId2E/GBQKFU9dz6Eek=;
 b=QWZGSFIjfmT0zA697OlmgX35NmWAijfZR6GIZaIKBmeUr0StPf88Pmglz9Tt9oD3Ch3JT3nNaxP8aVvs4kBhkkaFGzGsqvAY+CD5HhC+qKci+OHSpcL/T3GTho+o4CUB6w5wyaQqWtspBJu66qZyeBaDZsPOwv5ARNOeTqySanDOTnwp42w1M/o6+IOv3Kt1YUsjzi5WFpHXPxRHVUNaDANlOHGbZXwI6OxS9Zb4uFEl2V/ibFaK62CaKBw0frolUdoD4EHpqBHqNENKBWGbDtnWf/uUWjxzKJQSdYacq+ToGCz9g3RSd5NRiMTLVSnBmSIOQeDCp+G+5/qewamjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7FoJzFcFFsXM6HiiG9re2ataId2E/GBQKFU9dz6Eek=;
 b=cHOXJOGYCCGNH+l5R4lPTgJU5e5yLOcMcfonDpbrwQF/CzwXnklLnTg8EWboqw7GwwKWC0wdyQwn3EyUzzp2iaCF0eyB1QfJSVMKgVCFRfLwOlGDf+FCay/3UBZvXTiSpwnWVeSOtBqZc0v5Sn7D7a6VooxrJdHpibDPcff/Rik=
Received: from MN2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:208:239::7)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Wed, 15 Apr
 2026 07:42:51 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::3c) by MN2PR08CA0002.outlook.office365.com
 (2603:10b6:208:239::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:42:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:42:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:42:49 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:42:41 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Roman Li
 <Roman.Li@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 02/19] drm/amd/display: bypass post csc for additional color
 spaces in dcn42
Date: Wed, 15 Apr 2026 15:39:41 +0800
Message-ID: <20260415074223.34848-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 776c567f-6b98-4f3a-97c5-08de9ac29882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DSYrWY3005uA+Cbs6/fWRfZx3XKKpV+DvplMiSHcssdH1kEPFZ7tOJKg8QsM0lOsyxV/hmSO5AFoe2xS+rUTXQf6DCsQ1P8o1slnisT0mF2ae9ywtG3vL+yNxP2BgZ54te97D0RBVzrNg3ahRcygYNcydacnlnI8pWjgGlrAKEWQtdgoEBH9ZbETVBAJdKD1t7M2Tog7tFHiSBpwb7rfBWwDVFARCOlKFZNLiPalJ8r+225zGjh6oQiUCnoh0p1P6cNDYb2nT6uguun3Kj4+tWKkjFS7IgfBVf8NRt6in5gv3dwruMZR/1NEm98OsC1/qQo+Qe0JOiKWW8TbireXrOEazaZpNUQJ7yphj94SDBgTUfXkviiKvsawbJOZgjdbWl7/pwsqKeH51KISevYIcYC0iRjIWCxF1xiFYJejXC5/ItI+81MDFVQxZ23GB9qPeYU7Qy6MKvzb2z3datZy50k2eqUKihCo81qvsRZzkjlNdT4DUlZd5q6uezc8okH4t4WTlTqJuJRXbsin6CggUWSW7ctoutFZAe5hRZn51cqFwZY4PIVMVbj1QXs+85dLC/kJpUwEQi3TpV/sZ4bx3QGHKwuRxu16HEfrin/s2hkhCMyAhhB3zNGWfY/gJHUXvqS+qtrl1xxBqBtdjbU4HsURLAtJcYm5hEzvw74yN0cNHLaAm45SftTUpLft746bdM8BxhODrZBVSAXbrnVGiWf+IvjWw/HBPx3YLgShDj0ep/qOHA80ru1KUahD0f8HsCku0huNrXZQE3yWKlxeww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TDfLCn+jmNbERpFhWwassS/PpUCKJG7PC+x/DYYMi4SRcRTzYQvLMmDrPuG8AcIFOac39ZCkI31wgh2P9fUoss3B4u3CChyB/a9q9XK317pbGk8SUSI2+SWa3XYutIzgoOepf+NBxbGgVDrbCVc1+v0m8XHQ2sukIIgz55bX3vN02hTpPkBBu4Yh1bEBKmue81tA/cQOq2VdHkT4D3baqAoyfd6foY3uwPyI1cxH/WMTIv64eT18/2kuh86BwV6PXy+aGJZOxAfl9KsaQd8xtLBnfY2qKWBTQ1DKf/TbEdh9jQyT4Zsre2S+kC7QKHSExZXEg666GyznazN7xpLODEHqg6JDZ0FM+0MORgbZ8KwVkbjf15W/+a8c1VjAOjrM7OrgeeQBuqxS9zUJ4+vfxyVFS9Y1Z0dEye/XVNqSViuXAE0cq2Wcv4igYHhq7zwT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:42:50.5787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776c567f-6b98-4f3a-97c5-08de9ac29882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655
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

From: Roman Li <Roman.Li@amd.com>

[Why]
This aligns dcn42 with:
"drm/amd/display: bypass post csc for additional color spaces in dal"

[How]
Apply the same post csc bypass logic to dcn42 dpp using the
helper function.

Signed-off-by: Roman Li <roman.li@amd.com>
Acked-by: Chenyu Chen <chen-yu.chen@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
index c126fb9d5bfa..b5d7ed5dd511 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
@@ -269,10 +269,10 @@ static void dpp42_dpp_setup(
 
 		tbl_entry.color_space = input_color_space;
 
-		if (color_space >= COLOR_SPACE_YCBCR601)
-			select = INPUT_CSC_SELECT_ICSC;
-		else
+		if (dpp3_should_bypass_post_csc_for_colorspace(color_space))
 			select = INPUT_CSC_SELECT_BYPASS;
+		else
+			select = INPUT_CSC_SELECT_ICSC;
 
 		dpp3_program_post_csc(dpp_base, color_space, select,
 			&tbl_entry);
-- 
2.43.0


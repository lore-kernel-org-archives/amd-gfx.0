Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B04BCD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 20:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3012411237F;
	Wed,  3 Jun 2026 20:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wzr8hnIm";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89AF211237F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 20:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ep81E2yJGx4VloiFYjPFsHg6tyQu3Y6YAM5BCcBnwUR3Iwk5EMnBHydHTBHiqMr0gaXzTbvfGdpjVnUHMKltdfqeVA4MkmpmUGUB+rHHTlNRR8nB+f1vh2/XOidsC5zUXxSS6hT4u/KstdtYPLdhJ4k4wBzGuWvLmmMBFXPkEA5ubVY8T8rtTjv1888H0sCC0EvbsoItI+fRAcxj1c6rjfxv+RYt/HqzZXNBcKyaKLoU0lH9HyysidaPU1GDX7/huxE2+1HRZrsyPIKBnMqmsZsmMF8NUwm5KtjTTYRv376Fed379dJ7rfgR+efv39n0B5x4e2KrFxkcfYhiq7hluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbhxwLNxMCz030cDxnwtaXeWNrXZolvaj9gd82gSyXg=;
 b=iL2lYwOgrB22vCkExXEvWtleYvcg3cTBciM/DTFt9T6pqlYPhWe2IUEkbHmitKFNLzw8ofIrEL37O1OV7YtP9SQedmdS8koACdEaNIOBwz4BCZpfAk08wYBKNkcOZ6QxS6vlOxsJ+9DJ3GK1UYuVd/8P4X4obhou+lGweT33SlGq4nvqD9K9YRL66eHsJuCTShB6pa09teI+TiXzZ5ZAxUZjDTy88EHBQioFhUKBLFo6xcc2PswQtZ2XOSV1XwnCAkM1Iwpj4f+o/SP7xy3aph8jHRq7BDYGMbeQ9KrtHviBExe/c/bMxQK8Fiijvl+xxjM0OPp79ZxGqdT0QvDXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbhxwLNxMCz030cDxnwtaXeWNrXZolvaj9gd82gSyXg=;
 b=wzr8hnImAo3tzxcmXQHU20DYMODhP3I6LysYWBwYWsMqNbeWpVPgJX8Ro8BuIV3sSh7u4Ct5xwqpwhFhxmJMyC0oVnsMEda60w6cFeHtSAgtDTtSBThnR30qmfuYaIRAfan4qYeXNNQJpV9MkNdf7e8Hunl7vQe5iv2hNggzcsA=
Received: from PH7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::32)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 20:41:40 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:33a:cafe::95) by PH7P222CA0007.outlook.office365.com
 (2603:10b6:510:33a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 20:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Wed, 3 Jun 2026 20:41:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 15:41:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 13:32:02 -0700
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 15:32:01 -0500
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Add DCN42B to dml21_translation_helper
Date: Wed, 3 Jun 2026 16:30:16 -0400
Message-ID: <20260603203208.3721331-3-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603203208.3721331-1-Matthew.Stewart2@amd.com>
References: <20260603203208.3721331-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: cf737e4d-c661-45df-cfc7-08dec1b083d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TNG70L7L193hq3zIS7JrgD4T7h0xF0L/6S/f7iKH7xRNEL0EGwTb7Iv1thxjWlrVupyWxWpkcMHp5yyBFV3kTtSx31SFxmfuewhplcEHvifYuI0hy0odlZo/5R5h8ue+ZdFWusiY2tmF2H6v52UJRbPlx+R+NVhtLNffv8qFnV9fxT7ZouQrM0QkIW1Gdb9hkO7i2DC2TaOMVZwPr1EMSjBY28AdsYj9LvqgpN6x6u1WUwR8nGxpfYmqwFjE/5IuA9E4yV/eoqOttUeDQCvlNhVspb7o+vXH+Tj/u/C7QGWJ6cduwIvwzWO6YZ8q6nP/Qa2ANClw3wer/qoMtjNGvAexHVMSJ3LjSxy3Fx4KAfbjlOitkVolN8cFvImKMq7rW6lLpIUux27gSQ9x0KcuC2Am6Q2SfIbcMCMSNavq2BBU7iEw0vHLMx4HuKLF3A+0xUvs7+HDhrbVG+ZT/+Hv7frCfDjPiR67IW6TVZP2WPbHVtGwVzFlmjMHlMp/Iwr4e9x86/2keRAzHyc7HNzqwbrxkWYLS2lPvL+rpDoK0HL25KiDsUVcspCwryiU1kvwwD+D9PaJst4wqzyzMs7MKVXqFUGCMwfU50Ie4SNTJpAx+5esnoHlRlEgz87v18sH2AcjCqwaii+pUvmxGstzssCqPS6q6jaVnE6EtXDWQ1lLNrQPmmtUNjREMoFdx3d/ybkSt6FJJofRkoMAcVt+iorTsJu+4ARH9qaaeiuqtzo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CJ/qHMtS5k5HD9gYnZsNcIOtj4cz1O6LvUd2EyyMbcmAAyQcQV8yHvK+7A0xxFATSFQNRr7IPyfwF+ctY+r6NMSO+IrH6AWc97JbzbFkvW0lXYejOQNEomEGkYbjwlraqoWF3I3BuhGGYt1sIv826dISt16p9c59UiVuf24v0/a8pgOyg4mxtYUhq2eTcZBz5bPu88AW7t/nd1fqzNMYw0Vh1v1HQXlaeIP1i25r9+g7souF6hEerhqY9njt43xt+63OT+tfl69xAhpKnYKpeWyhezn9C8eIb9AkWtjXXEI98rYHduEznI1RrwQdBGCl9lAjymj7xcgXJuw9bTuzb43k33Rsgs2ghiakmlZm9e3fzkhpNssYc+KsyjES3JEhHlZu/ytjM6hFABWPz47PMnL/NQD0SDIojAeDcI9X/Ph9FSsbN47dlYgNFD5Bt2JQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 20:41:40.2583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf737e4d-c661-45df-cfc7-08dec1b083d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
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

Needed for DML to function with DCN42B.

Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index c6ff7a290c7f..c1a3e2496983 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -48,6 +48,7 @@ static enum dml2_project_id dml21_dcn_revision_to_dml2_project_id(enum dce_versi
 		project_id = dml2_project_dcn4x_stage2_auto_drr_svp;
 		break;
 	case DCN_VERSION_4_2:
+	case DCN_VERSION_4_2B:
 		project_id = dml2_project_dcn42;
 		break;
 	default:
-- 
2.54.0


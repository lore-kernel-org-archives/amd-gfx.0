Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB69C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFBD1130D5;
	Wed,  1 May 2024 07:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WO8aMyhL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE68D1130D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhfwhLooIOcUtxs1Lt+f0wFyRyVutB2fOQ2K4uqVk5PBXioRXPN3tpzE9+rlZoDfHGiyIHXF8ddX5nxxy8TOAnrPXg+OcZ8N9IVn1kFQb79Tp2S7Sx+ZrNpPQjuH5+vrY5dF0yZp6odDB4ZFukl0EeGWsAzNe/esXGrKjQhMT7NeKFcCnTQQ1lexKG9DtRe1ZGm7ikrsj3wCoAaDWr0FzpOA6MQ4kkC7L3q5Cnv6WUnh3j94apQZGDEA7SXo//BnxQMdsiOeWPyWDX3TJu2mAftag5sJwuPGpK92eYRNIqnqpkLHUQAOq1UAMe5qVFqdB0t4EpT3mrFdMGO+tU79WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhZLF82tFYiigcxXFZBsoQP4DC9Dhdc54muvI1kd5kI=;
 b=aHE/JoJWhTdVtfnS0sscDngm9zG8kSjnS2yWJiaBheCh46b3biaJnUfer3EhMQtbo3LmbqCmkeNgHf/c3ftdfzaqJj8wlOSr2yQ28ePef2/OAZqpmd3Wi+O1aeMzsw+hcOM1sUFZcG6xG6n08603wKUhOhu+2vNnVMRp5PIgj3N0Tt26C12wc9EVappl3civrFEZ/K/S9uPb+nzbyz6O04k6LNiQO5MHiA4DcomX4MAj9pi4Fm+uY8MKstulE6JnfjnpoTjpT+aITHINV5p1d+37b13vSddxPnzOAv2gcS+utXa4KOjEWpxaba/3/gX8cPrr3NAQP8lG8Phcbnzj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhZLF82tFYiigcxXFZBsoQP4DC9Dhdc54muvI1kd5kI=;
 b=WO8aMyhL+AB+F3J1beA+0m5tA7BjnUoHR4roCer88me2kZOA6hkv6WiYRtI1eu3EXHtdtBtU+ZY7foTQEVAO/+3kdwX5bfvVToN6JOrcIgZUsf3gU6AZJ9FFGhaqqcKmjYbYvFfCgXBye+a9j5bO85tfLTGZ7WvoK5ZbGrp36sM=
Received: from PH0PR07CA0038.namprd07.prod.outlook.com (2603:10b6:510:e::13)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:20:46 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::d7) by PH0PR07CA0038.outlook.office365.com
 (2603:10b6:510:e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Wed, 1 May 2024 07:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:20:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:45 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:20:37 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 37/45] drm/amd/display: Release clck_src memory if
 clk_src_construct fails
Date: Wed, 1 May 2024 15:16:43 +0800
Message-ID: <20240501071651.3541919-38-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: a59ea5f8-9400-4c45-ba69-08dc69af37f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WRtOzt0M1zkUWL8KqwB5L6cp3uMgdG8rGcspPZE0CrH+NhDDxMNaVgF+lFLD?=
 =?us-ascii?Q?P4JsMIONwQo1NQ3fNLurxXuT1qdFsuoBExecg2+q7Pq679BTjq0H/oeB+E/U?=
 =?us-ascii?Q?TKmVE0N5oRVs8m4BzoziDOpt/oRcnBHzJqHVKbrEgC4qeKmXc5wgWfKy5gvE?=
 =?us-ascii?Q?qMKWY3NuwjO02Y17ADmQFHKC0CGApxSwHnLhRtcjXEy8FP/uTnf8nJwjXCQr?=
 =?us-ascii?Q?DIsEd2jjfxUZdE0HHsGT9rAFX6X11+uVXIBE+LIy3e0vo+edE+rqzJTzj6yS?=
 =?us-ascii?Q?6d22rGRBE/nkXUN/T17UdbjF/2Vkoe2aoUt++5DNL2g2icshp0OowFMRfxxw?=
 =?us-ascii?Q?lepYBeuMiQHpU5fomhsG7HLrC9L9ZqussLhiQ6JOEh3URYbWXJjtzVI8wKUT?=
 =?us-ascii?Q?1rU06lWH+ZsQriPU0OtBMscJPb1VVscsx81PN2MdE+PPqPPqIh51pfZRLvYW?=
 =?us-ascii?Q?XYsTBVaypFTeaHFT43n4DEX6qcfFc0yHw4hSp61KiW+qaUWxHLpb8kIujRx7?=
 =?us-ascii?Q?QuumMnKu9bIhTtXfYCAuDjKt4tJWPb23X/81FpLfIw92svHsKU8GLWK1PRvs?=
 =?us-ascii?Q?OMAKd0R1l1t2NrhbR4aY+U7bjIsjHqTGDY5oDipAlNFevsdK8wK9OcrxJerT?=
 =?us-ascii?Q?LjEKKtovAe5U+temRfRNqabgTermxZmr2Dv9vsrUt5I+DtJyiCboGTe6sTet?=
 =?us-ascii?Q?ocBk4KoJQrNhfJk3Pp2K9omZeMweeaIbF/1IzD2IDHF404zaRqiFY+TYkb8y?=
 =?us-ascii?Q?4qN9R/efXPQJ+eLGSY9EjMdb7dZ4QENkfU4LUxZHktbHxvLJJG1OR4VGgMoq?=
 =?us-ascii?Q?RYLHNanYSc2Cx6Jmu+XeKH16E+bjGHZfamKmITJS/T9VNi2aE/mefIPd0xR3?=
 =?us-ascii?Q?ZK8nVenqhIEjaLRL2u0+gFJ35pT4qzVGjcPQPxTf+r0wkWk0WVUbyZ+nDVHR?=
 =?us-ascii?Q?e5WfpZP7OJ12eBAyI37W2NxjqvlBujkrV7ljnG5yzd5czo5D/ae5sC68MELU?=
 =?us-ascii?Q?lma1cm3jqcAacDIhrJx6bg9gIUpvdoO32WIr9pkn4fskLBuWf+kV8aNqVO0D?=
 =?us-ascii?Q?36VlgGOVdUfgrHl650WVov8CHw5hCRirF0PeqiHOh5q8dm9ONiRuTXwPDCyX?=
 =?us-ascii?Q?4iBJhZkdnoCZR9vhkW0T5rkY5KYzobqrArVqdMeRdBCp2lNsh8pwYK7Xw4+a?=
 =?us-ascii?Q?Uc7O1xu3QQYFKgVDhhdSCuEdY4iH/tNpZX1AZ2g/Ao+CRghzL6xzLgK2OAv8?=
 =?us-ascii?Q?RqIt0GYHlTYft+KzuLfsqKhw8CH7dUMP3b64/dlhJFRUXbgYThnveTe19nIt?=
 =?us-ascii?Q?K3/KUgCvr5xdI8QaZnHAPRf4NfCYEO5zI/iC+v816qaO6kvD2cz/8gemrbhe?=
 =?us-ascii?Q?jOZ1hT4zn1iC1IZX2niHz3lbF/Mi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:20:45.7859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59ea5f8-9400-4c45-ba69-08dc69af37f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
Coverity reports RESOURCE_LEAK for some implemenations
of clock_source_create. Do not release memory of clk_src
if contructor fails.

[How]
Free clk_src if contructor fails.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c    | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c    | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c  | 4 ++--
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 1 +
 5 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 56ee45e12b46..a73d3c6ef425 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -1538,6 +1538,7 @@ struct resource_pool *dce83_create_resource_pool(
 	if (dce83_construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index d4c3e2754f51..5d1801dce273 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1864,6 +1864,7 @@ static struct clock_source *dcn30_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index ff50f43e4c00..da73e842c55c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1660,8 +1660,8 @@ static struct clock_source *dcn31_clock_source_create(
 		return &clk_src->base;
 	}
 
-	BREAK_TO_DEBUGGER();
 	kfree(clk_src);
+	BREAK_TO_DEBUGGER();
 	return NULL;
 }
 
@@ -1821,8 +1821,8 @@ static struct clock_source *dcn30_clock_source_create(
 		return &clk_src->base;
 	}
 
-	BREAK_TO_DEBUGGER();
 	kfree(clk_src);
+	BREAK_TO_DEBUGGER();
 	return NULL;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 2df8a742516c..28c459907698 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1716,6 +1716,7 @@ static struct clock_source *dcn35_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 982526c41d55..203fd4aaf9f9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1696,6 +1696,7 @@ static struct clock_source *dcn35_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
-- 
2.34.1


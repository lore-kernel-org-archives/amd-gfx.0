Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03F5D69112
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5220610ECAC;
	Thu, 28 Nov 2024 14:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xeMB5ScR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064AA10EC97
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ6qOkId4v4pyxRGQ+TKbXjxlkw9WGE6t0K29eIeB16ALA1ySzyKI+oBZSjj0owJv80IMR+xOMD2+Eo5/zmN7STFyY4Fwe+a3uX7o3mPPjB3782KrFSqhuMCWGKQc5ohC8kLjSXb8q6M6eTPf06awQ0UQTmQRedY3NBuWVYB60BDDpRW3o1tU3OZ0fd+NipnndmttSnVxN3COLB/41CuWW8qOcB4PZQp/BN7lAOjlq3uT7bgZOVHV3lYXDZzLUqlSBaehaAHFlWvJv1uYo58J1K+IKgkfaZ+83g366gVv59ciR4fRH/lLQqfXRYbFRRxOovanxHESfaC2E2AINJPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFbjO3ohjVGkUMZA+rmiVNCA8i8Jtjoo3uALymNjjfg=;
 b=AGhyS4pkDc3pkAlhNx7m23e6BMLUaIL6/8x+Fm+itx10vaikCNOn9LnmkmNUQWb8WZo3kzI2YUgeWcNhT5yRJIdVWlBpE7shvDflJFlKv7wUWaQGXeWsEl0bi3JWwyfPZlaq36+12j3YB0ljOnEUrInmoaIbFpNMCBrFS1llAhmRIjfbt87iUXhv70FhC6Nji/Ib1jKO98MSwH4COv0DlywrU1RSlEB6azEyMNfLed7yCeIuYuLrpF75ZXcbNovNAdW3dn2UIfdgFtYvvo8idnXnnu9IUGLX6sGppRCHDFspe62HNb2jqs8BCAGmUnKdswzuSoz8nbziNDCou7C9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFbjO3ohjVGkUMZA+rmiVNCA8i8Jtjoo3uALymNjjfg=;
 b=xeMB5ScRjynHAJGkZVR78CknpVn2n80VYj6dRI2PI0hMq93oCcrevovYsgsYseoVUGlNbT10I2XopCXhbh38/a6fSlnTvOLvviC5nEiNr24qaapPup6Tht5xViuoy6qPx552p0vl33XDv6k8EiHAZF3yStJOwHnHu6WW1RDYSfM=
Received: from BY5PR16CA0012.namprd16.prod.outlook.com (2603:10b6:a03:1a0::25)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Thu, 28 Nov
 2024 14:30:27 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::7d) by BY5PR16CA0012.outlook.office365.com
 (2603:10b6:a03:1a0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Thu,
 28 Nov 2024 14:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.0 via Frontend Transport; Thu, 28 Nov 2024 14:30:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:25 -0600
Received: from jzuo-linux.phub.net.cable.rogers.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Nov 2024 08:30:24 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 9/9] drm/amd/display: 3.2.312
Date: Thu, 28 Nov 2024 09:26:31 -0500
Message-ID: <20241128142958.28370-10-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128142958.28370-1-Jerry.Zuo@amd.com>
References: <20241128142958.28370-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1895e5-6af0-4282-ae0c-08dd0fb933b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sJGi3mrko5k5I0gSjrAo3cAFS9McNnOBulwncJe2T7BTJDzT5RbWpCE7NSye?=
 =?us-ascii?Q?+BeZ+i1ze4KfzqL7PfxCHjbq0ccCL/V5Tz3nzmkeZeIsFcfA0c9+AsjPGlCk?=
 =?us-ascii?Q?uwiJc8iWPFql8/V98I0CRbiqIYyjnDEIg2e100e58z4H0do9rGoctUGFP/ca?=
 =?us-ascii?Q?lwrfqGKMNGTDqcD9Q1csnMDZSXO4GcIgOnHNyL2FUZb8ONdDmyKcEBXadF4Z?=
 =?us-ascii?Q?9d84PlQNAXi4w+VOpfi+lQh9lB9A9pH/oJ3mRRzKg2R6vbIj3ayxUvGGrdes?=
 =?us-ascii?Q?Yq0ZKDJyOGCOXa5Xmr9/THxZeNuJ3qB/5Ossq96zQkvJrzq8hWl4Oe2jClac?=
 =?us-ascii?Q?E0ck9qf3IyXjtCvBcochX7Bwjp3SOsgmAZlZAaM+BJcf28oQwNXam+25biHE?=
 =?us-ascii?Q?vKcmtah+Ean0Zq99j3VuV6kjpaRQ4rCGpTcl/uNamxTj/YQet79FrC768ArD?=
 =?us-ascii?Q?5U3hmOJ5uzlyxL/2l6h4mfgsr6ip1Ilgs8run4T2DyUa2LARxPLL088g4Z5/?=
 =?us-ascii?Q?6H9V0FTDeQNa0ykjahnnwLdngLp3XsiaNoL0IZg9ed82j8w7JSb6rt82Su5B?=
 =?us-ascii?Q?ocdcOKxY2+RmgFOX6b/0teWoXYPxvAi7KD/do3mjPI8qjtjWaSXKapwSUevB?=
 =?us-ascii?Q?bq/J7EutEJDBmlM1tzI4Qzt207VcG8QIIF+4fUxcrUe5dRfT7llW1zdwiAC8?=
 =?us-ascii?Q?RUqogu7sLvWiUvmD7Rb/aB1XUfmoMJZNetQeZrUplwN+/321D9i8CYyplcBT?=
 =?us-ascii?Q?j2mrDirAL2Prwp+8T4U7iZuPWaWu/2Tz+3mCeZTihYbii/qM5ZzFcPe64YiP?=
 =?us-ascii?Q?lVedSKqgAC2S6rWQLkEDFq3RCB86PjAZB3JlBIq3EFfFMyRNsHft6IXU1cnM?=
 =?us-ascii?Q?eGG9Mh4oK2qEatggmRpiWCBK21iR8zGKVAq5dNUbnK49CF7OaIUtPY+7rC6F?=
 =?us-ascii?Q?GdHwY6eJru/2Q3DGqwrcg2koTg6JKmIYWCni+owgVwzWUAch1K6jqMvWT9Pu?=
 =?us-ascii?Q?OgEB0bd58hAaZt1dQzfR0c3xgEbxpTgSFKADW+5sX1TCqDF7nKNF6k4h3ra7?=
 =?us-ascii?Q?oiz4F+FIeKzZqWqt6XfKa9OYO2SV6D+ivGuqlPgzdK62hi/5pQbOft4LsBea?=
 =?us-ascii?Q?e12aBD2Y7vzcBNYTJiOkUgGCLj6kXaJ/ui5AlDVBxtpnjfImZnP4oqafzIIp?=
 =?us-ascii?Q?5shRbe+VQ4XkvX1dmyihzrA4tG+biAk9ERS5RXCojHsE0zgelxJMxSKJMn0d?=
 =?us-ascii?Q?wbvReLpkQgquf19Cf3mKO62O58gA5EpluD1iFLOxg0QgADxjMz/kxO9p5Efb?=
 =?us-ascii?Q?P2Nt7lfjfZGOyp1jSgxejK+Uc9pN1RKphbOj2+DMgLcJWtHzxx9y1G02Zz35?=
 =?us-ascii?Q?syyPtuZYO8wPw2SqwxB5wxPkuEyYqWxBqMV4o8Eg3PtNqINhyrTXIDQrwId2?=
 =?us-ascii?Q?/5D1wRxR15J0wpJcWN7ty6omsgM8TvrK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:30:26.5499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1895e5-6af0-4282-ae0c-08dd0fb933b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
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

From: Aric Cyr <aric.cyr@amd.com>

DC 3.2.312 contains some improvements as summarized below:
* Fix dcn351 clk table
* Bug fix on IP2, reply, DP tunneling

Reviewed-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 39ed52b0d006..1f9b6147c826 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.311"
+#define DC_VER "3.2.312"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.43.0


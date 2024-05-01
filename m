Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCCFC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB64B1130CF;
	Wed,  1 May 2024 07:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0bmyzg/Q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7907E1130CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc5wvYOpTVKnDCTpxtwl+2tWXdMf9jyWp7XOIN6ZHKtjKRAtzyJP3o7Q4eAj2Df+cC6FsJQh13uLRWK/u72ObD++zF+ORupuRyzepRyRgzWx1AIAP23Xz5TNcArTX4v/v6VLycQ5ZL69TWhPFRUI4qcNHguA9fhoofg5RwecwgfWZDGABLJONrPzL1ZQDv1aBhFgc7QA0gQ/6eZeXJXRjln/Pcrts7mtZqzGNLetQcOLOcdcANv3+5a4cT467X39tQQtUe4EvvVaYkWlHZiCcDbzXxYQfjP8biWTykd/cKaIPYzp4poZgNVOJqQ2LVNV4Nd2kpD1j3MirRQ2RrgDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1hyIUUy9oZvONb2S01g+HUqvvelXqjjzK2Cqk3KnrA=;
 b=b3huD644jF/QqoTPTBppOoFnYye10qn8YQQlqiHcWg8NBVsjpd6f3SbDd5UWjEXU+I/8NfdlcmEBtRUhNVrfg/O15vtKeCH/84pMQZLaO8YB+iorzsJrgIiAdJV1r/XMNeNjAbe131zmxRvfR+rjpvU10pqH63WsKso8NlD4+xF/fD1ZVfe3AKTm9PMfKs4gH6NExacNf/09XAYwfBamKczLZPgMsRkPGcxK6eF6LYLA/ZMQ7PAE2/ZGRrtYS4f+bELf9EeY+7asUcGewmbGibFixpwOLMyebY27AV0ElMTUiV7vKIseaN8R70aYWs+KIfroeV4JF7mn+4l+6B8Siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1hyIUUy9oZvONb2S01g+HUqvvelXqjjzK2Cqk3KnrA=;
 b=0bmyzg/Qxt79hDmehHSiQ9YOxD4jUMK/jhFLlqq6to1dD3AwlNxXDewxU02SteeI5F/+ZikN8Ja/kBCFnZYPf0zWeocntK/99X2MIAH/vsIGdAgFZr/l1chkyNt0tetpxC/h9UCCP0uSI0EP7wXw8GGPupU3U6XqEH/bMDSdDVU=
Received: from SN6PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:805:106::13) by PH0PR12MB5648.namprd12.prod.outlook.com
 (2603:10b6:510:14b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:20:26 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::86) by SN6PR2101CA0003.outlook.office365.com
 (2603:10b6:805:106::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 07:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:20:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:24 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:20:17 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 34/45] drm/amd/display: Fix Coverity INTEGER_OVERFLOW within
 dal_gpio_service_create
Date: Wed, 1 May 2024 15:16:40 +0800
Message-ID: <20240501071651.3541919-35-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e1bb37-4030-4011-c51e-08dc69af2c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ICALgnoG9ZjhyqmuCNDhA2neCogs5pbqp3YOJu2lRwYrdKHT1c9mpLxt+ZfD?=
 =?us-ascii?Q?SP8FJ8IpMy7FrtCzgPZIZDk7rsrUNtyqEfoZw9+/aWaV4aO27cB1LzZ1W80u?=
 =?us-ascii?Q?GTevFy9eRkcQT6AF/1KNLieFcTibuPnfq9JksRCY8S+qfPL17ekNYeJQzyJW?=
 =?us-ascii?Q?oN92yoq46dH2uA9CsXfvc0OTFStJSnAI56NX7CMgCnXNuoRmoapg/nHcFk/M?=
 =?us-ascii?Q?vCcwcBjLZH0C/SXqKCcoqvPW+4I2VQBeH0cBZGxlDFxhuNgpAkklqvhU+23N?=
 =?us-ascii?Q?b01g8FJGEbq/1ujmDT1F9b8U9DwjwdjuzM0F3bqF4BaVQMledfmmnmX4Yof4?=
 =?us-ascii?Q?FVf9D4tTAM1cw0OiqG3jXFViJCjc+svDPI5udfQkAOjbMi1AAFRP3c/pmPpx?=
 =?us-ascii?Q?buCj2iYpRZ+Si25YSrhoY+YeM17z/mWolrzFaLKwvftTq1bKcK7p/bCB1MHE?=
 =?us-ascii?Q?FvJPoVsx6JQOrtO4mLlzwcJ3Qr8lXW9RbXHNKkcjl9kZqQtPOCQ0P1zdVyrr?=
 =?us-ascii?Q?+YOViPe6xrQ8U+LWkytnQR/A+s4EL6DhP+wl+jFIfFMDFT4rhw6Fy3pqm72M?=
 =?us-ascii?Q?jwQWBc2W5uK8aXgWczgTQL0wFSI/5NpVCwlWRvDuS57XRMhDtKwuihH+foGq?=
 =?us-ascii?Q?d0Dq4GERXgJ+w65yOaQHAYpuYIiFScOlSnm03/95ylmIQ/Ik/z8Ao3FxhhKB?=
 =?us-ascii?Q?5aMmTQSSXG4g/tA+s4QuBqV2+CSB/UVFjSj+mFs+YheZZpFIMXbNrNiHFiMd?=
 =?us-ascii?Q?Qw80qbHsrusk+4hUi/xxFfjAd9cVPlbNz/2w3PjIF8ax/Sgtxmnaomjxiso6?=
 =?us-ascii?Q?qRxyQ01Xn8lDdfSfr5BEeHcOjMVMP75GpS4tfLG4+z3otGZ+SLS2YJW3U5bQ?=
 =?us-ascii?Q?Qq9cu7y/UpyIm8lSduOOmWWupZF6YjZHKI4PVK3kzhjvGDjHkmxcgpYBL+zK?=
 =?us-ascii?Q?vbkB6K71E8tjb429RAZAxSTkEkR1Wf+Bpbp0teNhXi4qLH5x6kaXXX2uOBIL?=
 =?us-ascii?Q?RYX8Yrl7b6dzoo0vfX5sfSrXuRAc2shPHGt/G7gALHfLSHnezmqXtmAzcCYv?=
 =?us-ascii?Q?bRNDBL+YOfu650z/8ElXpuVAIbuOCkaL8LedywyrjDgj2R+5sFdUx5wWQiWm?=
 =?us-ascii?Q?TSnCDQK8QGbXmjDDjteah2tW5LUI91BI6Uvt2hFfibVjzqB7YomQMIvnp5IO?=
 =?us-ascii?Q?LbuV8WXCE9bDS/KpX16Ur6I5pJL/r44oLMYVqU5HBKM+UTwnJ5dBwPNwGarO?=
 =?us-ascii?Q?uflwGIG3p3ujPaPKA93Nsp0zpIpm1GGuzHW9DtEbB8QfzHCkk+qkKMhn+2Id?=
 =?us-ascii?Q?1wrRx6cEtdjSQL8PXEoWLuzWXTIJEM76+Usg3mcxc6h86bJozUEQchMzYlIh?=
 =?us-ascii?Q?Izg5E519/tYBN2u6BvsYq6M4k8bA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:20:26.0392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e1bb37-4030-4011-c51e-08dc69af2c32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
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
For subtraction, coverity reports integer overflow
warning message when variable type is uint32_t.

[How]
Change variable type to int32_t.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index d19d5c177022..f344478e9bd4 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -56,7 +56,7 @@ struct gpio_service *dal_gpio_service_create(
 	struct dc_context *ctx)
 {
 	struct gpio_service *service;
-	uint32_t index_of_id;
+	int32_t index_of_id;
 
 	service = kzalloc(sizeof(struct gpio_service), GFP_KERNEL);
 
@@ -112,7 +112,7 @@ struct gpio_service *dal_gpio_service_create(
 	return service;
 
 failure_2:
-	while (index_of_id) {
+	while (index_of_id > 0) {
 		--index_of_id;
 		kfree(service->busyness[index_of_id]);
 	}
-- 
2.34.1


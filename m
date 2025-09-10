Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E062BCA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8221210E85B;
	Wed, 10 Sep 2025 05:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iQZHnsOb";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26AC10E85A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXJGibB16m0UdEGlwjlcrg41apPkjuDLh4tCsPr5pKMUfdhHRjSyC1HKqC5MNhTJHxxmxtEmj+ybxlnsTle4IYlXsQWfXplI7ZftGhPpRqEuTH6Yd20g0LQqEfjLyWzM5TJQXM5VsPoTbrlxvRi9z26thNqXlDTs4JgGXmKxiTL+lmelvknsYNDU2vXDorCn+y3RO4hgnk8YcPaASuZZU6xWH7ZzuyCGsHiDV9qfD0hG4QuymTD/eoXmdvhPheX3ZvwrmQYx4F5Fua485+z0kavkwiSRviGQwNo0qIugMGk8pYar7mEHMMmSD0O2hu6vrQfQvj4oeY+MlnETqZPxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TPwCWtm5V7grYD0pF/viCmXn4x6TWw3ec4nLPjGPI0=;
 b=nJ+5iGCi2aqkjZdKZF78UqCKuxY17fpvITn33iP7bqHq97rVQy25M7r01/wlDYRqfZx9YiB7YywUc6XGvm3FaDoxqo1+Ag/wyBd49ioVs3wP9/fZFjWu8yziaWp6MZLoIZo+dbcCLphjYM/+TsbBBmR8njuNXHUCyLMS2bs088p0onGsFMYOezawLRQaN8UlgfHSQg5NoyPvAv4/qzTw3fqVu0IyfrbRVmXcsmud0ewIs2FG+XEiVPD1qpfYhNn0Ch8PCtnjuNL3QwC2/Kk4mhTvS1CX81LvKlX9Lt+kdSnMj48IOrjCkz2xgnhinWZzCj0OLxCyTSJk6BhqgqOkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TPwCWtm5V7grYD0pF/viCmXn4x6TWw3ec4nLPjGPI0=;
 b=iQZHnsObTKSo/3ntPwJ1sXNQ5ayXvxduR3evW0URFmU9wQAGgsvpuT27T5rKTon38YJzY6Rl2eroSAcjfnd1VzLQy26UptgJTrDBhTIRQb5j0VwemDjlUV21h5jASEHlB9d3+eZcwugkD+UZ3HkTVbCefBHZnxBm1LFFOzULKfI=
Received: from BN9PR03CA0944.namprd03.prod.outlook.com (2603:10b6:408:108::19)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:27 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::e0) by BN9PR03CA0944.outlook.office365.com
 (2603:10b6:408:108::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.21 via Frontend Transport; Wed,
 10 Sep 2025 05:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:21 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:33:20 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:18 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dillon
 Varone" <Dillon.Varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 10/15] drm/amd/display: re-enable
 disable_stutter_for_wm_program w/a
Date: Wed, 10 Sep 2025 13:30:33 +0800
Message-ID: <20250910053222.2884632-11-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 12dafb46-b412-46b6-3bac-08ddf02b9180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?inTaOgD7iMmZdxAESM68aXWiSp2UMzk7iLNlYXTp46lcfTsBjdkYqsIcXhro?=
 =?us-ascii?Q?dr6k34vd4/CgsBNzN2C+V6t8eIjms+tBkXxnQ6yidhqzxbxgKhT+8Rh1LmZw?=
 =?us-ascii?Q?npv6lYVBcGhPHMnVPsfMXVSfrXaNNtP1gapLv51E1mDQi1lzgPUZle8FXfmr?=
 =?us-ascii?Q?HYpR2IYhgaWH3ryGsb1YisY0tojFcw0dOuBHrCzhquT43mqt5M+AMaggSRbh?=
 =?us-ascii?Q?X2uIBRAot45rXRI3VLTlxD/C056/1jJ73IcTO3gkYXyf7P90hzUlRRkqVt6Q?=
 =?us-ascii?Q?eSLqXbrBrgLhzc0Q3lk8xvIo4tQM01JT5WYyhpuQD8yULeSC96nT9/oJEhzD?=
 =?us-ascii?Q?XuXAJa6kDEIo7A4HhJQWeCOBTHUSvgnQwn0MGgYTsJEwiVynYJcGF/z43RwG?=
 =?us-ascii?Q?6yWA8gHf8GR7QksTSCKYl7pIR7+ZvXh0VlCOHaQaGdkY2y1iHZDDNUdNdOia?=
 =?us-ascii?Q?MCbyX448IY6lunst87MmdN3F6qtBHnLRlR9SA8jB9KSwIv13qXRMmUc4+DyL?=
 =?us-ascii?Q?o0SQVOdp1frAeT2c/mQgm9/dxSNl/dxfjpjWw8MBn83wZLTdlm4w/SLOUndv?=
 =?us-ascii?Q?LSXAAWD7KzhL3yy9Gs77m7WdgT8n+ffZlxLASVSZVrkaqf61fqxalQSiqDzf?=
 =?us-ascii?Q?mdWI/kPE5Bx0TASOd4J82EZXD5YhKyh6BrOPsgw7QIqcG5Ijh1wmoaPNIFcn?=
 =?us-ascii?Q?zA6alQQTj2GmLgv6D2ALIwLsiX5vRoDJGBSE67RuKrjx7PxHRdGJeOBgfu5Y?=
 =?us-ascii?Q?nHga+VwFs42RbSw6j7zM6HqIG29cv0Vj0V57oC8DVLEMU5/gk3yzu5fBbLeY?=
 =?us-ascii?Q?nAHMp8suWPnCQSYl0Ndx0XiXPPUGENqYJRfgxe0b8kg///ntVzldjaq+qvwk?=
 =?us-ascii?Q?5uBkuUDy3oEYZhahFs0SWRxvkOYwABocQaoUfoysNlOgkfOWrp/wz7WHmhDN?=
 =?us-ascii?Q?aoDLlOzov5QPEwM5yB+YqfBIMhrsmW8myCsdtNGUl/PntQpBsk36EkcRBId5?=
 =?us-ascii?Q?9Upgl20RQ8QXR95su3X5k5uDP9NvGq1X8pep2S6If9tluigM/zGeNg4YTm5a?=
 =?us-ascii?Q?Hcnqu2xvLCiOP5vVeIlg7RGtnyiYBIWzxLcQiJqvwbYpv2ruuZ58RMtnvCFx?=
 =?us-ascii?Q?VXwQx9Vab7Rhb4CDVv8qVS6rUgCMLIxbOLDDNFxtdSBqnXftCVdMYo24r1fH?=
 =?us-ascii?Q?tptdJLy+9R2YCjuJ8wb0f4ed+EKyIyqT+QenM8U/Jae2V1iK2/1vSzYmDhEJ?=
 =?us-ascii?Q?EqeJ1n/ufkUmDRURvdUknZUqiiV2xnr8nA8FFclf+PeVr0SkICV3oaIn84ZI?=
 =?us-ascii?Q?0JGjvu/EfkO4Hs9U+9qIiloN/Q3ePHvH3PQnNzUzKy+3RkXTLGZNVaCRI2+0?=
 =?us-ascii?Q?WPqUpLp6Q287y158/jbERD2p7IcBi4RCNPzbBX6/wkQAfciatAbB4M8Fk8GE?=
 =?us-ascii?Q?WqJYB3+KKSFgn763a4AI9vDWkhJsf+pCg3ZUqWeBn60Eg+GwQBWzz1mD4nB+?=
 =?us-ascii?Q?QILegaATpsSb6BF5zGitA0gLxT2ekyUWzfuY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:27.1408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dafb46-b412-46b6-3bac-08ddf02b9180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
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
Re-enable the w/a to disable stutter when reprogramming watermarks.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 8aad920544bc..ed639437ae6b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -739,7 +739,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
 	.enable_legacy_fast_update = false,
-	.disable_stutter_for_wm_program = false
+	.disable_stutter_for_wm_program = true
 };
 
 static struct dce_aux *dcn32_aux_engine_create(
-- 
2.43.0


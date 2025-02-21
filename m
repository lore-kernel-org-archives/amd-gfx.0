Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B72BC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A9D10EAF2;
	Fri, 21 Feb 2025 16:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nPqqrUHu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F85010EAF2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2i638aYVWCph5RKTHBW6BDskZ2xLrktjZTm1DVGlwiyqZM1fzGYf0WDUJk3KmfgaeeqBv8MNUogC47bysXQA9KqAVz9fzyljZ+H4xTU1SbXuyxvGS48qlgN/P18L4A9x2ln4Wf7/U9CmP6cKZWIjBTQxPPYfzFtWfI6uNS+Z6nAN7uCQdOkAGr/Zef7i7QX/ggfuSkpdtDsdoU1WgzJCsjqqirmTljaaVAycCutW2koUpHHBdlO6lY4iC/godUoBcfXKCnRzO/4oD1AWMgAFnA6q7hdM4vH9dMU52jddTsXV5ggvs/wG2QocHBgG3fJ1nOV81efKAwN8KJfl6gXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJU4Wj+PbnCcc4nNQMDVV84D/B7KdwDu2rWt/Tuv04s=;
 b=voArfg1UiuSiizgwmlUDHDXfoQXfvwjB0Z6A1gHqhQPZXbgH6zSX9Ot69daL75sjg8mD4grSI68cBzhzL1wBwWvfJEbQ8gMpbONEzj7A4dehvgFsdpsUy30IjjmVu40O+P7WgjYRvuEOe28cttJB/Tiue89KhIPxUHRB1DyxUtd27VxLyEeGgaGemlUqD/zYA5xAg+4Vi3jKVbPlfEegllJP0vA8QOzqVWfjEgovIXu+dgS2oOIP3PDNARmISlWS9SsNV+SDJuGrRRShybVUpxgMt2cFj1YysVk5fStwmVP9PSY1UW18PVkMzXZ3/q8vPbkXUslqruoxr4a0izMYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJU4Wj+PbnCcc4nNQMDVV84D/B7KdwDu2rWt/Tuv04s=;
 b=nPqqrUHuFCC71PlRXZrsccIcasGQidri9mY9/6cVlZsEbJ+r9Rl8WM9ODQNvzw7mGVeGh9U8vpS++BzKIYQWYFqPDR3LpFvvShUfbDFaOTS9FCm4OgiiKqpPX1teJ3Wp4fukF/S524yZrMjdNsRh6ivyjqzz6i9qKQKYis6ekAI=
Received: from PH7PR17CA0067.namprd17.prod.outlook.com (2603:10b6:510:325::13)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:03:10 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::f1) by PH7PR17CA0067.outlook.office365.com
 (2603:10b6:510:325::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:09 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:04 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 04/24] drm/amd/display: Apply DCN35 DML2 state policy for
 DCN36 too
Date: Fri, 21 Feb 2025 11:01:25 -0500
Message-ID: <20250221160145.1730752-5-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce297c7-1502-489e-c669-08dd529118d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K1odec72tt/53mgR9TCOqFAWkfuCxxD7r65mJJD4mCCvFQAFOlxcGHh0GoLd?=
 =?us-ascii?Q?qQ2KKGzab+zjhwLUAqMgdNaFiTUo5k9uPUzPK+ZrOcnu2SF2205VgEauS0cD?=
 =?us-ascii?Q?k5wYEIZyRi/Ru1338+bHItdV6oCtS1ZV6pjuZCEKJuvm1jJNjIegx5YWa4Fg?=
 =?us-ascii?Q?KPdc49Iw/023CgVzhHttUCk4P6CFrvv7yEBWBrOegiqcZszFbENlAYs9TcbM?=
 =?us-ascii?Q?Tn/S4DRh7UMptooJZImvidgOiqfLdxqGRU0OuJsV9RBelpN+i6dZW/nV9Q0y?=
 =?us-ascii?Q?Fnr8l7W9dtGPYYXv2XXIDNo/SKukTNnXxTCLU6JE3rKL4Fj9M+WacexfbGkQ?=
 =?us-ascii?Q?YA5i9Nx+4VwzNJN0mxg3dHYV11ct2dupIz+kQW6rS6W7ZCV1x2iHGhpOkLZR?=
 =?us-ascii?Q?iKKch6l1jxohEfuqN7ngwpOS016/N5ZxYWShqQRL7xupBFKNXpOjCTJq5EXv?=
 =?us-ascii?Q?qCeAdFU57KlPnOT4/TZ6T3Ccz6GNPrCBk6cn80yHW/NBZZX56Raw4P/T9lWN?=
 =?us-ascii?Q?2ynB3UwKi2z+u64M7U3bOsVWLX7d2KL4KFg4HABeDJWmVk/qiGr+x+DHS27Y?=
 =?us-ascii?Q?ybQv4Bl2dgugjJj1ln0auAKMc6TPGpn8+ckqZYQTgpJvWdcSB9v6+98HBJnW?=
 =?us-ascii?Q?oDcLpjG/JmpAAkVHvlcRxdjiHQ4kD+Euny60PqDr3mBvGFMR3GzI/5ypFkBR?=
 =?us-ascii?Q?p4GAn2jqb8lRF0XdLY+/wGfKehZ6gLwgw/V7X47DWX+1NU15CFLUNyjXrFkc?=
 =?us-ascii?Q?J34/AvYIgQuPxPAusNu9zqz6J+p4mL1yxOjcOzf814WEdFSNL1QEGzDtlD3e?=
 =?us-ascii?Q?qh1RF0gtdlEILpzjeyq//Nhum7tXMae7Wtcen6XLoRxZp0nHopeUxrUvI8dD?=
 =?us-ascii?Q?0x1Ixz4RPTF8PSybGIzMjjDzga4eIern7gthGxePekwQ9ut4dy7fcIbmnOym?=
 =?us-ascii?Q?yRNiQmaN8lAmPbhk1loY9OpajNf1wZnJJQi+sgKdlM66zlNtSSvft73Jt8v1?=
 =?us-ascii?Q?lv3hon9M8FNt6qM7wh6xtRrScehmUd0Am3MjgYCUFkxAzpAktDVFgqd/yPD1?=
 =?us-ascii?Q?N5xPzlqvuuLc/k1UpDqpWvPvF0zVa7rVLVKK7jTukP0oAjVkg5qQqtK2XLCu?=
 =?us-ascii?Q?HbtfzBqH54VQbxFFDrUUGzKa6M1NQoQY5bOY4qY+6mA/tpseygKyu/9zNHON?=
 =?us-ascii?Q?p3/adz3FUPpviOJwwf4zImVdr1/XeUt5iPmI8GlAkjJZvd31p3RRLMt61rxO?=
 =?us-ascii?Q?oZg5P3QRP/oFGG6NnVoDhMe8ZfUr8L/dbTkUM/Hd78Rz/oPqkTqhGJi8/hID?=
 =?us-ascii?Q?FeLp4Fs0LNZaERBfvtCNMPEcjqjOHUBtWMib4/WzbQ/jw9T67p9PSWNlp2fq?=
 =?us-ascii?Q?2ApWu7SjzL9ENWx2H9ildegAzOLNPrt0UT+bzeUBk0MUE9cg8F0yCicRHqY+?=
 =?us-ascii?Q?AfauO/AUDXeOaB28O30kH1GNBqksYMwUlHdqtpLQDSDeEorfYRuKEIziAlNj?=
 =?us-ascii?Q?lvDeh5yl/RrgC7U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:09.5380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce297c7-1502-489e-c669-08dd529118d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DCN36 should inherit the same policy as DCN35 for DML2.

[How]
Add it to the list of checks in translation helper.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index f829d5ac7c8e..2061d43b92e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -557,6 +557,7 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	}
 
 	if (dml2->v20.dml_core_ctx.project == dml_project_dcn35 ||
+	    dml2->v20.dml_core_ctx.project == dml_project_dcn36 ||
 	    dml2->v20.dml_core_ctx.project == dml_project_dcn351) {
 		int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0,
 			max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0, max_socclk_mhz = 0;
-- 
2.34.1


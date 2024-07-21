Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA505C3DA61
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jul 2024 06:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6718910E17A;
	Sun, 21 Jul 2024 06:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gr8S+Bs5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D79A10E17A
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jul 2024 06:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqhJLcl/iG1mVcuDfJpEax/aWufay2ulAu3GxQ0aPnGwZkcPFkZWIQ56mtMosAMdBzANgh/oKi6k2YzTJm9G7aAUhIKJdjS1XQNfnZxL1TdIdRVZKUM10xsUVeUw+Hw4cSXfh4Hvfbcg0CSVKdJlsmWxZ3FiXqGIA/rVf1CeNdBw7H/0jLwOng1UqJaJamhGhJT8n3XDmqQSpRH1ju7rVP4360Ah4n5YVs/J6EoTVDsTMCa5/Q448So2fRG4FXSG8l6SScb3gI0wvFA9bdKiOXP9Tt9nSqTpZV/iY6L6gJ11ODY492TYTbv18O8Ur4lyjgA3R/B59cVHjXnnYe3e1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJSTMfW2/sNqtJREc4OZHScXGKaMWcSxnhYMQaL/OS8=;
 b=w/xAwkuuLplAx7GuqDXJWifphMqEwsJrsoDGLZhG36MwtIEVNrKONSivGqNRaH5yGL3Fx3XLFsYHB7HkI7crq0i06snS2ZoSORq2MijvNtOUx122S2Gr9to8IidRmlCoG1eoPrZwybrt2Q+6Bl+sqQaVcGT2zRM+YTqMBs6pusUw9FttXR82Prz7lsbqPSPGeP3bgvP6LRucQG8lIgu/oCedqpoSfBYZQA3F9pPuoBcFxzPUEIvgLt2hhR4cyzXXL7i6q6VvzKb+dNaWdbFHE1h55aDPFNaZxHHDyzx5MaifpDOR5UvkU8thjIEGWlcVTCVTDdNQjWjIJcgrhaGY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJSTMfW2/sNqtJREc4OZHScXGKaMWcSxnhYMQaL/OS8=;
 b=gr8S+Bs5UNvPeI8t68LLY4WRG16XRlnivgkCtQWZ0bjfW/Z3Tk+yyLCUtC5CiVqbP4c9J6jRYkpKyH/7noXJAYxMxrRa6DlwGKQxSc+AZTwPLsRhJfr5rYga0ZEZ+vGUdk7wovLL8JDmrtPdG7Eaj0Y4fwKzurYmEO7k0smuCv4=
Received: from CH2PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:4e::24)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.35; Sun, 21 Jul
 2024 06:22:35 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::ed) by CH2PR02CA0014.outlook.office365.com
 (2603:10b6:610:4e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Sun, 21 Jul 2024 06:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Sun, 21 Jul 2024 06:22:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 01:22:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add NULL check for clk_mgr in dcn30_init_hw
Date: Sun, 21 Jul 2024 11:52:10 +0530
Message-ID: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5c3d12-7380-4086-7c90-08dca94d8301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XF5TQo5n8Cj2mlU8ogkNut5q+BdugBA1wIoXXaae+z/Ed6d+tq8BKLl9BKa8?=
 =?us-ascii?Q?dX4mL1uapg3EuE8K1JJQPYxQRj/HaLxQOJftvzjdyOUEfcB7Md4DmF7Fbp0L?=
 =?us-ascii?Q?GktY5fTY+8c0NEpNLQ8icxQCyZ7cMqrdnghAxnfABlrokShcfJadHUA/MTUG?=
 =?us-ascii?Q?fm9xCXk4R15X3B8uv6d2GZ1S7m6/bJFzFvZOBcMIUantWhak99tlRrhI6Y7Q?=
 =?us-ascii?Q?BiQiHdV5HFOBa7pgiEvXfcj0pc3X/UbRcHKIeM7urPEmO+juhrHQl0jTWMSQ?=
 =?us-ascii?Q?AVPvPTOi1zQ4cutwtVym683f/j/bB8GbVko7lmHNpUWm8KuXhpeNUfUllAOW?=
 =?us-ascii?Q?FQv01MPfQ4dHEwDH69tBkgTcEbPQlKe3X2AxncJ5C5k42D8tiQuPvvB5m33+?=
 =?us-ascii?Q?xvetd5TXxyIqf2aSE8CUToTXksAg60Eaii9EpJGL+G6cMWZ16E+Mjxf/aAZT?=
 =?us-ascii?Q?mGG1/3EsUhJhTXTV8JuC3q2hqpUKwPsOLAIMiXxLxVXJkn1gZQDCGFajjVKN?=
 =?us-ascii?Q?67d6WMkW6vzagt8w04YE+Blwt5ONTd62bA55OlOYPqcsOmm26y9Jpcrkiu9S?=
 =?us-ascii?Q?U5KlbFsZBl0WKTq8uqFivHStG8hY18Nfn+oDlzcTFvA9ka4XCwd2R9JzALKg?=
 =?us-ascii?Q?xfRiVlo3YlBemaTGuKVuNdF/htkopMZ7kKmm5WHFzTwYH/OKiwLCNm8FJVlH?=
 =?us-ascii?Q?XmbzD605uCFW44TUpehaTqAWvz2d7+6JN2ZuoXEiRPcyM+Ky5fgIXfPMELRc?=
 =?us-ascii?Q?u/n7U8MYsZq0zMIBM5EBuFzklmxxNxbXUGzOzeMheJkTnXujhqr2KKkw/z2D?=
 =?us-ascii?Q?cprww5pEeeLuFFGS+POBp6ri8OjY6rLBk3aDSgAWW1jhdh3riBU5Z5jSKQOx?=
 =?us-ascii?Q?YT3jIdxupBARQo/N/g8bU+ORDAxkxzHQ5MnLRHXgpoG8dEe86dX0xFj4OI/d?=
 =?us-ascii?Q?roGq+iD0k2mh40BWVmYRs0Hvgak0f5yr8O58FXF/gtOHaIza089VxqVt0HCQ?=
 =?us-ascii?Q?0uzM/aD/ntkIREG+yK/sNlVUNj9zLgO3y6XpDeNxG+T3gVYAkK1Ish/heyjq?=
 =?us-ascii?Q?QWfNpxsYOQzIhEX8VYuch1nW2jh/OCVNeTFMrj6gAbhLtCAMgCKWyIS6ewbY?=
 =?us-ascii?Q?aZJMlbcra/Rx5lRUetpMHNh8VxADa4v/O0EenoWfA7Vm9ljIGegdj3kd8bsQ?=
 =?us-ascii?Q?rqPE9a6CO7Fj+zux4o9q19vTWhyxnA22CcDbD6xIFj+kpjZnUNFDPwOidgZp?=
 =?us-ascii?Q?SGYVjIKWz0xneK0UJyJ9/Haj+BdPLUlBt2zpU4dBFvPVMVZAKVybrz/Gj330?=
 =?us-ascii?Q?bebWx5FdUA0Wo/Zdb2MS0at8BiwR/b3gU4DKGQrPHNJNc5ZQwfRAKprH5fK3?=
 =?us-ascii?Q?0NjJJnpCwE75MCuN2UFdqvqgniDI9p1NeGT5QUwChyXtLEiEn8umlfYRFbpz?=
 =?us-ascii?Q?MRHQiIKi7ZDsLuY/pQg+dFtvE5sbVEg5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2024 06:22:35.4318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5c3d12-7380-4086-7c90-08dca94d8301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688
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

This commit addresses a potential null pointer dereference issue in the
`dcn30_init_hw` function. The issue could occur when `dc->clk_mgr` is
null.

The fix adds a check to ensure `dc->clk_mgr` is not null before
accessing its functions. This prevents a potential null pointer
dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:789 dcn30_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 628)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index eaeeade31ed7..f3eb6fe6f59b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -786,11 +786,12 @@ void dcn30_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
 	//if softmax is enabled then hardmax will be set by a different call
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.34.1


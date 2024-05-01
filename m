Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C252C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB44C1130D4;
	Wed,  1 May 2024 07:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ge6bPw4H";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8533A1130D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8PqTroRVv0EXGxZnKtFGwXG8/YmixE8n5bgPL2UkcoyL12qwB82Lswnv12P96N9vzv/Pe+Qj8gvkt4dIWkos1+kNeudhLs4K4i3YcNSzZ2qNAT/fdWvkUwfx1TXD+jp0d/n4pxU1hN93E+MaOJ1487XJ5nM0kGmnw1epqrpLQ0813OCzABWkmAFvY/WiUpB4QNltD3qh8UxMNn7ZLJpnsGSymm1UiQzrEMKDEakutVPf687oe/6Y2LnpAx8kClRkgjPyWkabgriLfPf7XL+pNRx/EQyRoRjHLnEjZmhWDkEEcclLjwvrqphZCqdJD1e23JOcm21mbRnbFNHXtFgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XEjNl0/6kG8K9ZQju7WGX278VclK7xv6ePiCIRA+mI=;
 b=APpEz9bTylT4aO3HhyADoQjZk9up7oEliMdcEyb9B9BmOmbCQlNoqnGX14EyMILthqxPV6TdUOvYtgUIH7xQrITEYJMDRImP3zmORED50oSfblrPopaRN1/y76lcPsyZC601j7VCLemiaNJ1TjFI6RGu4BdS2CwDO/uv0eYPEoTArf8UZnLdPvmA5Pqe9Ohgdh3Qx2jipL/sz87jUi4Tsgn9/0qqgX8d8eKfLLDhIfnyXYPuIrDruv/2eCBYVJ3LSkBykIcH6FQV1SYbcRCJs6Jj7sGp73Xgpd0Yugu5Wne3lqiIADxEegRw8cHlWx/kQFDa3ghZnCH2GrHeh3fhBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XEjNl0/6kG8K9ZQju7WGX278VclK7xv6ePiCIRA+mI=;
 b=Ge6bPw4HkoacZPamTuNuXOr2vCAm1lCXDKVt0hEG+LWbyGihxmQ1MMxQPgZiJj/lnHd4TnOH8Hps2bRawVOCDjS2xqGCawPkLxRAbO6LXRw0OF52TBeMxWyrYSaDZv+47HGw8inBnJdoJaFx3MAYPytRdDZxQ+5TYIASpH77Wmw=
Received: from SN6PR01CA0021.prod.exchangelabs.com (2603:10b6:805:b6::34) by
 SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.28; Wed, 1 May 2024 07:20:54 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::ca) by SN6PR01CA0021.outlook.office365.com
 (2603:10b6:805:b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.39 via Frontend
 Transport; Wed, 1 May 2024 07:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:20:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:53 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:20:45 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 38/45] drm/amd/display: Limit clock assignments by size of clk
 tables
Date: Wed, 1 May 2024 15:16:44 +0800
Message-ID: <20240501071651.3541919-39-chiahsuan.chung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: f1dc0175-ea19-47ca-6a5f-08dc69af3d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aFvIQg96L9VNEoNnwD5n0HnCjrkdmQiNH6yXZF1UcF2/bN77nNqHnBv7jpmy?=
 =?us-ascii?Q?zEgtIwGCfQP8xrgkqxlk/4MSnC0Snp8vuckZugXKWNXPnQqNvmuIWk9R/24D?=
 =?us-ascii?Q?jfYLv2tzy+uSyoZeo78nV/2U/yDuoaD/gyDgS7Cptfczuu5FSc7XFXjgZFpv?=
 =?us-ascii?Q?ELPYZwFowNjwNAwJf6JJaH7o5LzjrjaZhawOmV9xPu4hklLZbVuxEG3suP2+?=
 =?us-ascii?Q?BkkRET9NNQN0F7Y75xhahCUFSYVi9xY187tbXXQhpkRdWGcQuJO+GvlTVZdQ?=
 =?us-ascii?Q?/1kTDJpEQIqYOCCHgqtyzYtzBFJPV6LF1Q1T3CJTuSUxauw/QSOcxJC5WGmv?=
 =?us-ascii?Q?ut5ERGdzB15/rnBdlTP2FsLuYqqqmq4knfkBFcMKyYLFyVmMwQ+c21CEYyPS?=
 =?us-ascii?Q?5+E1lUjIg7nEbo1ptW5eXmV9vStgeQLvDK9odvpCtboV+nnZKKsAjcsich/O?=
 =?us-ascii?Q?3VKfqYQxbpdN+l30aQxiluWMt4iLB0BdSzKTwohbQzGud9IXPDxHeGznUDEP?=
 =?us-ascii?Q?zo7a+hYBPcADWPnbpRfQjfmoJoJxMRkwcrtvNff0Ckx4Kftf8Eac9/OFkgIe?=
 =?us-ascii?Q?ktuRF6s97xGsSTvQG03CExqZvzex2kYd+sP9JJJq+v4y3BTovC95dInX8byD?=
 =?us-ascii?Q?rq594idHO9hdG1dFOgOkVtVvGI11Y0r1TcR59dGbTTnUFlZa1Ti655NAkYjI?=
 =?us-ascii?Q?oseqz7bbnstOBhsJIISuTgiK3itflwMLYWSEjyLBl7DYM8momg3ddA/1lSSw?=
 =?us-ascii?Q?NFHcHKQPuYeUQ5OUOIoqT3hvyWdQL/esrcz4LKs5glO2uzya2Vy2L+6JUMGD?=
 =?us-ascii?Q?vbO8N4YidbBgb38flcfvkDWwT+0ihhqhKirsJzfQt79TdsC8hhOopGjzrwFb?=
 =?us-ascii?Q?njMM+PNUba6sEflPN2AIz4uAld8yIE9/WUHyjT6CTUos4sDVEk9S9CJre1Lw?=
 =?us-ascii?Q?YtjlqIPXreJmuij2M9DPhX+N1iQGcUPPR66WHOcMjcFoFnKVRZ/oZPho+Bts?=
 =?us-ascii?Q?LVRQ8SwmVJYrRY1EzGTVIvIU8PCd5S/Qhsv8E5MFU/Maxl37Osi3tAi9MsGm?=
 =?us-ascii?Q?nKB7FJXix0e5cwJkGmKDnoGP4m5eEZulKbo9GYPQiZNTrZ2MW/CJIJb3NABM?=
 =?us-ascii?Q?nSxSy2Azg6rSwLJF9hqSdpLZ+tAFwydgnvuzkvE/h5zrOEujYdHyFuxy39pD?=
 =?us-ascii?Q?zGaQ4CsGc1wHLP6WiYLw/KLlYN6CZy7w0fUYgTJi3Cr+ge8qnrdDMrSedxnO?=
 =?us-ascii?Q?ly80PJbbwkwqW6Jt5XhNXKThzyy4ffQhZGgtiF+SSZa0X6eExeMQqQb+geBf?=
 =?us-ascii?Q?GyGw6PLIWVEyN7A1x4xRRe/qFcfKEz0bi2xxuTOZizH9SRnHbqiKxrxJDCUZ?=
 =?us-ascii?Q?wxrrODdCoSin5HzhDEhBxAqK+63Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:20:54.4411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dc0175-ea19-47ca-6a5f-08dc69af3d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
Check clk table's array size to avoid out-of-bound memory accesses.

This fixes two OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index d146c35f6d60..a3bb46725b4f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -131,7 +131,7 @@ static void dcn401_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e c
 		*num_levels = ret & 0xFF;
 
 	/* if the initial message failed, num_levels will be 0 */
-	for (i = 0; i < *num_levels; i++) {
+	for (i = 0; i < *num_levels && i < ARRAY_SIZE(clk_mgr->base.bw_params->clk_table.entries); i++) {
 		*((unsigned int *)entry_i) = (dcn30_smu_get_dpm_freq_by_index(clk_mgr, clk, i) & 0xFFFF);
 		entry_i += sizeof(clk_mgr->base.bw_params->clk_table.entries[0]);
 	}
-- 
2.34.1


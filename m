Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC85C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E3610E4C9;
	Tue, 30 Jul 2024 07:22:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3/Vk3Cwr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915B610E4C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYqLnkpwiKDCx9Jr4uftZv8NYpohXd/9yA7GMShfDSafyUPhTOBqk7/imry4OcyEYKbgkkXHFT2gmNpLRqnivBNfIKrlyjKLuekHJjTMT9+gSsFKryO9qXMs2yOHJqW53ti5McTGY1Bu8mJY8DCjc2KwQXxbVX7gyv/43kV7O2PTofhtUm33hNLrMPGGfKrFhOeXseEbmBPaDNWdCYXCCfvX1127CbDX1hLv4RJi9RCpthkm1ODKCRmF4F3/O+nol3pHAF2/kDeE9pg6r7P20+UVj7ZI9jt5Zj4FFhJFxGAc108qIcXwARMiXbYaiHTesc3sJHj29tnMn9Oc1PBX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqCpyCH1i5iyfHCPkPO+ZUgmZNCKqVK/4QCTD2y7q9s=;
 b=e/yJ/P0iJIuVH2wIVfd5UIHapLr0ZML8+33DcLoSaYP7t7HO6u+H7uwZc6FltY28VI3oMLR47KhQd28b3klVlwwExp1puxX5g7u4+Ufto8i0pWC5KpMXSWmWZchT+LYPwtAkY1gNX95UmcL2Nd6ChP1W9s8yIpG9qGjcWFRCOYtSZSaC22f9FIkpDE2mULAgnbLKck2uN448KWf3DzWSIMlBWE6r4mcFZgbmpQZOlgNCaxofmLv60Q9r3v0YGFJy2MIUE+V0un+6ID1zNwKXicBpM3X/JIBc2oa3Ie5qjfOFH6t6njtdjR57/vQNFZD+HHW89m2VgQeONZuSRillGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqCpyCH1i5iyfHCPkPO+ZUgmZNCKqVK/4QCTD2y7q9s=;
 b=3/Vk3Cwr1N9VPxG3/dXZCS6TfxeOavpnSfQLtRwYfKy7ldyN3coySj5YVwjGYjk24XPrsYba8dfb2FlVQ2gzKxZlxknsE2UN9JAG++OrBuDjhNTXkv7WzroIpvcSWHPD7ufar5/cwzQvlWEO3EdQ3ZZ2OG6ypOjXxrvhbK7RXK0=
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 30 Jul
 2024 07:22:05 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::af) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 07:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:22:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:22:04 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:21:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Chris Park
 <chris.park@amd.com>, Leo Ma <hanghong.ma@amd.com>
Subject: [PATCH 18/22] drm/amd/display: Address coverity change
Date: Tue, 30 Jul 2024 15:18:39 +0800
Message-ID: <20240730071843.880430-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 6569dcc8-e681-4143-551b-08dcb0685054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vQ1LOhcHK6xxiWbp2BDGpw5Mm1h3FbCKt9BCQBOZwz9xb63P1KLXSzXeIrWV?=
 =?us-ascii?Q?ik4FqznvkuleG8tgBB/Sl4q9b3iH0hrFB50xHw2NMNWjj9dfUzTmFfeEpCj2?=
 =?us-ascii?Q?NO8aHfbco3rMidGQI2oV3Lo/jkMUB/PAHwUnXqRzZU8QCCgsPP3on1Pzcl9r?=
 =?us-ascii?Q?dubp+0oNElh9PyCOYwAwnpsaMF56hjT/EeV74lb3jVawu8FUrNXctoztqIQe?=
 =?us-ascii?Q?eyoNpFJ3Ki9ke3GGOAlZcK+R5m97SgK3hiknMuz0gEkAyOnVg8Xr0G2CZ8gG?=
 =?us-ascii?Q?YSHFZrC6kHUuf0/5ozrgngWuFknqzdSuAJbEkjtnZ9+AyhkU8uUIrED5WezS?=
 =?us-ascii?Q?b79ctg1iMoEahnzZK3nZ8Q2IWIpxPS4f4mHldshEPYKHdpaEeY4Dt8553n5p?=
 =?us-ascii?Q?N29SgHoPo1zoG9+rEu1KyvR0X2+pH9U01IRpzAWUwvDxz6W8sO9QYk5LgKVn?=
 =?us-ascii?Q?VclbO86VLtPnokCilYyHp7+Jw8DdovG8moUslNwAyr3zvMgdblnXUEfn0ioV?=
 =?us-ascii?Q?AD0xZELkTg4Gvz+stp2/4GjrLvqjkV1PPCgTU15Q9MycPnmNUquGmsiZbzYm?=
 =?us-ascii?Q?k4ikBmuta0v6IOh2FbQInJnsuXswcwSk05AZ5YVUPmxg63svUxOL9SD20Dfv?=
 =?us-ascii?Q?gP986FJpSfbRpSEX6+RcGuC9qdqPX/Wq5hgUtQTa2O2dC4LQBu0Wm4maQe+8?=
 =?us-ascii?Q?YfI9NHQW3YgVYXtE7LvpOv5vUiYZP9VT7q/4EkYnvZbxd/ClGgWnFo5gw/Og?=
 =?us-ascii?Q?V+Kt/8JezW51C8XbAS7705vb5zouhf58ttkFtaZYs/sc/Z6IPtu5WouERxsp?=
 =?us-ascii?Q?jgxAU9OJeNrF4N7JS6ymIN+gmgPY5fgdcrCOh/f6f8qgbyyl/4Q0vKSJL7ef?=
 =?us-ascii?Q?qtLmPzk5ECtzG+zDgOiqjsKVK1pJKiF2vnlg39TAlr5834JkE9Po1NMrR88L?=
 =?us-ascii?Q?BpGlOsXuHxOCMkUGzPNa29stW+MIkZOeBbQzo4CwAueiFsEmOvixtv03c2ik?=
 =?us-ascii?Q?zuMB2UcWTZoR4SpZLb7cYd3qkEVShJeyNPdSmVvYeheM9oRN1qKuCuZ5ZEwj?=
 =?us-ascii?Q?FNejLmA9j92WQKy+1Lv7BQ5OpSNPauqU9HkWvBJ9iHbf42O9AYZYJakKvSpH?=
 =?us-ascii?Q?BF/LJJ1mn1JmVCjgtYK7sn4f9ghI7yWChPRBRH+8muM+OHqES+7+4Csr09Ur?=
 =?us-ascii?Q?OzvLkCc25LaL6WOWTl528lP7EbVneSoMQSJP7ts9qJaQYwmOe/LZXRIii8AI?=
 =?us-ascii?Q?vZOHEPMFb7gfS0nuOMuezXNhCIhhKqGUPx2AG+iizAGD9Tj2ZvKiNvvBF9jl?=
 =?us-ascii?Q?yIoZHwP6BxeuHVFQs0jrqvFzBY4wS85vZ/M65wZk9hjITvaagxvFh918kkkH?=
 =?us-ascii?Q?qC0ggvdsL/CU0M6eFhj+AW2XPUy1fiSrGX6K6QStLKIk4oSOBb8xy2Z6Vc+c?=
 =?us-ascii?Q?P4OGDZj3rEY+3kEUDzu5sLsp9WvXWpF1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:22:04.9778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6569dcc8-e681-4143-551b-08dcb0685054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997
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

From: Chris Park <chris.park@amd.com>

[Why]
Coverity picks up a defect with regards to array underflow.

[How]
Address coverity issue as recommended.

Reviewed-by: Leo Ma <hanghong.ma@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c  | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index cce425dd62d2..01ea3a31e54d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -517,10 +517,12 @@ static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr
 		if (!use_hpo_encoder)
 			continue;
 
-		otg_master->clock_source->funcs->program_pix_clk(
+		if (otg_master->stream_res.pix_clk_params.controller_id > CONTROLLER_ID_UNDEFINED)
+			otg_master->clock_source->funcs->program_pix_clk(
 				otg_master->clock_source,
 				&otg_master->stream_res.pix_clk_params,
-				dccg->ctx->dc->link_srv->dp_get_encoding_format(&otg_master->link_config.dp_link_settings),
+				dccg->ctx->dc->link_srv->dp_get_encoding_format(
+					&otg_master->link_config.dp_link_settings),
 				&otg_master->pll_settings);
 	}
 }
-- 
2.37.3


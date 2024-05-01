Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F065FC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF3E1130CB;
	Wed,  1 May 2024 07:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HLO80Qa1";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149791130CB
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctjqsWD+PRM0gm8/uYDF1dDqlkPZOlm6vRNwh2XdNjjySmxqo6Uq2uP7cJuY61xlP/dzrpJxgvRNLhYMfwnVT7dB3/Lccg4BD2iA8ICF+3o0X9IjwB2fPruDoXfwwPXSAKO50eQLeASmd9nHO4r6LUB2vknN35vU2OW0x6Jf17q/+ox3djnlOaUBtVjxMwaT3YUhGjTOVrhSByQPhl8E4/FFcQp2ycQXKnFFFHPrTbPEmzm1FSpScAmeka0GsoG2s7yAExyI8Kfuiy8c/clnvqn/QhPY6sANbgXKk1+6ZPuCvVpcGiAzoktdMPyXHB1cRArf00DBH3D9iE2/D8sgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McwNiXH0gLftBA1IGrruK5Zv5wmZZQNI7Sf/HQWV41k=;
 b=L5TMBp7cdonIMhWIciYQSF3x4jfduCNYdaOemInaxlydzkZxyiYddEXYU8EsHNiHLUzInPBVUidH7NxqP/uB0XQCg0+SWmCY8C5gIMWb36xtq28aQiCf7J8GoUYUviPaTMz8hudCfS9uBYwV8YTeOTBcoN/f6oT/61tXTe7Coei9+ZWKsnBTbp4CSgXmsY2ofD456du2dAZbyjMdVf141ZHx3PYqj0ogYxgmusA3pDR2hOQzoWwwqeLNEusKaznJhqCAVHcA7XC15nJWbq0ZNFJO5fmXOmj6TQCexDNNIjLiTOU/ji1QcRN4GCxpFTuaaR+A4H0QysM49qgAbmcHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McwNiXH0gLftBA1IGrruK5Zv5wmZZQNI7Sf/HQWV41k=;
 b=HLO80Qa1e0SCWy6PZR73Xojlo+Gto2Lx8Pkalswf0Vi7YoOzRlMIIk6u8MwoQv9gJjhKLV4Is7kSfi8roNQE+ikE6bV0jvfXFEfJ+Ss7RGa/1t/xqMGPx+ccEEHC2shNAGCb8v6owxSKKZgfMtKfnaGoZwHGqzVCiMpuXEmwTos=
Received: from PH0PR07CA0034.namprd07.prod.outlook.com (2603:10b6:510:e::9) by
 SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 07:20:02 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::d3) by PH0PR07CA0034.outlook.office365.com
 (2603:10b6:510:e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Wed, 1 May 2024 07:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:20:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:01 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:19:53 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 30/45] drm/amd/display: Add otg_master NULL check within
 resource_log_pipe_topology_update
Date: Wed, 1 May 2024 15:16:36 +0800
Message-ID: <20240501071651.3541919-31-chiahsuan.chung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce1ad48-2351-4255-66ae-08dc69af1dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kctMzEBn35NJIq4Q3c52AqukunoUnX7so5iqD9EB7dz92l7NdH0PShJ/mZbu?=
 =?us-ascii?Q?+SMP1Mp2ZL3NGpXc6IIgiccPu0gOCjvqE/dx7I2KRAJrxWdqZfXyWpiTV3sQ?=
 =?us-ascii?Q?vV9xoLXJd3kYm12RRA/sCqGawS7XLuCLsQ3A+PwjedrfuJhnPwsQR4Rm6UAc?=
 =?us-ascii?Q?XUj7/BeLXRCclPKMcz4Niu+VIktVxtZd2BRvxQKqiDvxqfU3IRYPSQV9m+qU?=
 =?us-ascii?Q?h0kAPitBHnqjFLymGggzbMH9uIISj+x+JNSx5nnO/liaQcTyS2dT231IMbTd?=
 =?us-ascii?Q?yeYUalUYiBArStgvyfcXRB6/RULiYYbCBKwJPy4L9EoE4hCkX4vLCQ/BfwjL?=
 =?us-ascii?Q?64ppB9Ow9gf9XqxmN+yWPgkJZw/nI+QKLp9OlkcFG8woDaxPVdd2Rf9727IC?=
 =?us-ascii?Q?TLOHwMwIiMOz13sRZNZ4QW+S0shvlnFZdirkf7A+Q+ghcxFMZ+aZ9uF9z429?=
 =?us-ascii?Q?bjZl/0GAmI1cC2zPQJh/i7oEjJGZb1+NobAPs/gReakkN84HdhoFciDS7obq?=
 =?us-ascii?Q?3Z56U2aYFRktVR/ba97dOJW43orj50nxKckDn2tiIvqrN9KsGfdr+l9/SO8D?=
 =?us-ascii?Q?vio2UBeFBKac5sG8tHA8I4xphvSoEVm40jfzP5Ot7le20oak6sXlL2HRC7jB?=
 =?us-ascii?Q?GatqGreJcnPJSxbQ7URWFCmZlT4PNZgIEVfsOFmdF7Lse9fDTfayBDbB1No/?=
 =?us-ascii?Q?diG9A8xKNQu07SpmS3hF6MeiABCI5ogt+oPQc+uZB05QHII2f7NGhtVVVKWZ?=
 =?us-ascii?Q?Kgf2hP1Fv32rLdKFNyyr6Npf/TklSO96lR02TEXhKddXIYPNnbIEvVopwOiH?=
 =?us-ascii?Q?MH2XIYMyfPOi4yPvGRwPdzhyjgetk2CY+t5PNvaMyJhNTvZ4a0go2Zl6ePl3?=
 =?us-ascii?Q?SJfBUho2EKNEmNaEmCTeNt+ztOLDcmI+oFhfqRZY12JlkwSqVOackhbyCAV+?=
 =?us-ascii?Q?TVxL+2m7SWUe/QjBvL4N47Be3G2AP3X49bXiRnwTDrzhDCR2EPLMJ6tqMxWt?=
 =?us-ascii?Q?4jpKbHYcN5ftrAxOvKRcSoXoHdjIZF/3cA/DTBj9zlaBNH1x0K7uOlvjJv2J?=
 =?us-ascii?Q?Ekzsuaw7+/s8HAySAkmRAUEggozT2Mfmnl/S6Gv/20/ifyQZcggmctPwaAvC?=
 =?us-ascii?Q?DDjMoi8WLASnqopsh5P/UoA4lEZZYklk/Q+UtTnCdP6pQzRAhRnQS/0CjXF3?=
 =?us-ascii?Q?hTVPQ9TjqIwF6EboZ+PAGwSj4VivMo8/ohyMr8vcJRvPIDiXjDP36NK+4WtV?=
 =?us-ascii?Q?MYduXCCccuzzahtv6RNSypnLkOLzVao/frmqwNCLKt9CryfKt8s0pOn0V17d?=
 =?us-ascii?Q?snGt3R3Mjtkwk7RRN3QYqX0pR1O/Pny8UT8q3SXMGToKY3twXBNc2tXpQrXV?=
 =?us-ascii?Q?qF927Aw6YbJboPoIxIFw0fvgr4WR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:20:01.8640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce1ad48-2351-4255-66ae-08dc69af1dc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084
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
Coverity reports NULL_RETURN warning.

[How]
Add otg_master NULL check.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2d5983b2b541..532882ee7b2b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2338,6 +2338,9 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 					state->stream_status[stream_idx].mall_stream_config.paired_stream);
 			otg_master = resource_get_otg_master_for_stream(
 					&state->res_ctx, state->streams[phantom_stream_idx]);
+			if (!otg_master)
+				continue;
+
 			resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
 		}
 	}
-- 
2.34.1


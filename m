Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDF6CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7402310E7B6;
	Wed, 24 Sep 2025 18:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kx6fvdWj";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FA110E7B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEgQYWXzVCrAWqPjiQaLZIlvHd9ekP7owXTZ/a55Qh5ffG9r50VUWb8B2u/bcJcGUg5R85tDoH6vco3x4pz2ZqXOisoFjE51zZEWNBRe6XmRDw33IB0EhiXXHAKbnmW38gkv00Ezqdwg6JfpuqNJHdpCIAWB6YIxEeVuJEju+bdBUYknFckgipjeu6wYpm6k3OWDCnC7yirrgPNtfsDHtnwwxYLl5ye6SV8KtNg+z0G1qUHrXI5A0gc1auI4HqAaa+llAK9d0ih1ImzmbDC/+GIOPjshe1aUuSY3BJZcnM4l9gPcagslNo8krTLZqowhQeeBmtLdxTYwqC53PoQN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6yyMiZpQjU9Dm0GYPVRUihhpsRrZv4T5Vz9dgDuy4g=;
 b=IaBm7Hxm1Zva0RZ4DfCKkkeNOYeZqt3r6pENmk5w/8z7/fqYCK5LJTMZTBoB+2FaVbTUFb/yGm1MoCF1yvTAL+OsVAkZ99wM5oGW5RTXFw8egDaJnfAsvdBzcue1d9U/v5cS2UVag6v1553fMxcgIG9B4VfqHo8UGHgFxNCP3/KMnB9zU8wG/LBZR/ap1RiJE6L1FEezq3I+KHf37xeLOfmp0Q/amAj1TeP0Uf3Wg5rXcbKjsmbfX7170WdPXgLUXJYkwAHCGMdeyADX3JL/eX52P3nVez9qHTNzLpAz9YBsM5CbnNolc71ORIOEC3LBEiJIUD0vqP/vs41izKzUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6yyMiZpQjU9Dm0GYPVRUihhpsRrZv4T5Vz9dgDuy4g=;
 b=kx6fvdWj7HVy0Y7Q+JvKHKJqlOmCvYnhqQJS4f+ixsal0YmumCJ6ALn5O38mQe8izPDgyQtE4EdhiSPrtZ21AEDSKUyltYr2PVt1R6xh66mKqSQL7BYy59Bgbg21Sq4yrIooqpxg828i5YUTwuysIAlJIR4fKsKlSmtwSlXDRrA=
Received: from CH0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:610:b1::31)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 18:22:35 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::d8) by CH0PR13CA0026.outlook.office365.com
 (2603:10b6:610:b1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Wed,
 24 Sep 2025 18:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 18:22:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Sep
 2025 11:22:22 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Sep
 2025 13:22:21 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 11:22:21 -0700
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 03/10] drm/amd/display: Consolidate two DML2 FP guards
Date: Wed, 24 Sep 2025 14:21:54 -0400
Message-ID: <20250924182201.1049389-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924182201.1049389-1-Roman.Li@amd.com>
References: <20250924182201.1049389-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b82a80-42e0-4e4e-214e-08ddfb97559c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?owO5HFLP4Z1cEcur8VLwym7jXz4TCo665mgnxftjQ1yiOv2lddFE/lDEBkfb?=
 =?us-ascii?Q?zE5FTACOESTtIOKqxbwylQVqsT5oc8QcxQCjt+eWam6X8NZl4T01x3mvC1iO?=
 =?us-ascii?Q?jahtz2Xp9igdoJ0DiWHSxAzO16BAhIQ0Qw2+qd3HV0+5fdB5sFrJ55e5yGkK?=
 =?us-ascii?Q?GAGI8a1mjtesdP7thIbGdE1Wq/jvCr5aw8PMn1ykf5aCZE/LLCG65HnQ4Ryq?=
 =?us-ascii?Q?sQVQmYug6iSZ9disXStpL3hxLGamN52t4pTHn9ZTLmbcdWTTrcpxU59jECOQ?=
 =?us-ascii?Q?4/mV5/CP2KFPZxGO4XYvjyFZpPZtW3hTqe1/35uV0AqwnEEWvS33QhB+slj/?=
 =?us-ascii?Q?gToT4a793Qc4H5+rDV875mGInKchJqFn+4r8G6k8o7kQUxbfst2tptQQyHVg?=
 =?us-ascii?Q?J4Ozpw4rCfqefUrnoHQfpRuYCGvxJetP43wntPUP83zmbmgh4C9R4yZMyuXd?=
 =?us-ascii?Q?Rq+qH5zTRzva5tY2SrQrZ7qejckn1VsSgZkQUSbQ+P0wRV8pqEtZCoQf+mGJ?=
 =?us-ascii?Q?hDP0G4Z/8lQ8poaQa4tdhQWRzCQgjbuRlbTCc6LwTV1n0fDDVS/TOP6KPXJU?=
 =?us-ascii?Q?J+/BTPNmdYB+jeGMzcTmALv5eKXNE6hhumufFqZbNL6EZ5NTP2X9NWnYKMU9?=
 =?us-ascii?Q?rOo8mMHX74rqjv+rZriH+dMnzyryUTFDM6OFjETdipFoZDceSWd0h1VdgW0G?=
 =?us-ascii?Q?hD0Ijl0qB23brddf8mZCFiprDjgaVHBVFzbdOJX5ATXWZ3u/WH8xA2mrY/Kg?=
 =?us-ascii?Q?2vcbC0+YLCk5hAHKdzfWY/NO2a5qI0rnQWvIaMRE2ErwwrR7twtHixxa1Nj7?=
 =?us-ascii?Q?rzJX3Fb7OHhZckQn26pPxP9EvQbdKJcRx4PBXsY3oikydVEjB0S+GzVl2IdJ?=
 =?us-ascii?Q?jHwNeRgiL2pCeeIhO7NxgBTAsMjEs/XeyotvcGNaJfun9eUB/MzB07Mb4yo4?=
 =?us-ascii?Q?Za1mk6tv13UuTfVnYdc8IDh6VjqGLiGw9mXj+ihmlaR/KaJ6NXEuGzzRAxmL?=
 =?us-ascii?Q?Ls44X3pKQurZ3h7kGjFdt1y1wC50utQMNxdC21a2n8K6W8lpZ+fm9E8DUu2X?=
 =?us-ascii?Q?IIMXbAmsmhZ074FHKaOnzEanPbemDw/ruGYW+LloeDo8vz5uJmGnxvbKsaEN?=
 =?us-ascii?Q?hsEzQKeT4H8+EwQLywWss1AasoZ4pULp/KWNyrsGsNfDFaNi6IxGQUVh6RvF?=
 =?us-ascii?Q?YpUeTlY8wa96h2joSsokaMD/wLTJ2jH01wvULMSMxfQ8c/vlLMa2BS4uGTXn?=
 =?us-ascii?Q?iq3UNkVOiu70NosMAH9fAKboWxomMGaJduQCpBsp1MpVUGl9U/ETD2QKKIoD?=
 =?us-ascii?Q?uLj2Z9GweGKyys8E5yxrIdLDGTErqiBb/YVU5BnRs/ZaNMt8ZDac6PRr179R?=
 =?us-ascii?Q?KbyIh+FUcEr2iTDpRfkYWAeCVd6GJlkuvuOW7X26yexq1Vmw1Z+gsvmiPtfd?=
 =?us-ascii?Q?H5Z8CHs5KtihcvkExNEiLgShmLGLajx0MDolWGv5V5gDqJFYUSJOhrgP9Dow?=
 =?us-ascii?Q?iDETBLYW2kJUBzShmkk4dKD5G+9mIUVdNdHo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:22:35.0863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b82a80-42e0-4e4e-214e-08ddfb97559c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Consolidate two FP guards into one in dml2 since they are separated by
one line of code, independent from the guard.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 08f7f03b1023..43d333d6608e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -283,9 +283,7 @@ static bool dml21_check_mode_support(const struct dc *in_dc, struct dc_state *co
 	mode_support->dml2_instance = dml_init->dml2_instance;
 	DC_FP_START();
 	dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
-	DC_FP_END();
 	dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_programming_locals.mode_programming_params.programming = dml_ctx->v21.mode_programming.programming;
-	DC_FP_START();
 	is_supported = dml2_check_mode_supported(mode_support);
 	DC_FP_END();
 	if (!is_supported)
-- 
2.34.1


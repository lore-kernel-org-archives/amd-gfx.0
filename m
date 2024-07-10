Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3B2C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E9710E8A8;
	Wed, 10 Jul 2024 19:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxg2vmbe";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C42810E8AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKumGKwSx4X8FqKsE+Z9+62iZJprAXTwnB0Mkidfjxc72IVLVHT3uQGIdfH9j5XDerA3m6pkjsg6cptYXhwSxG8BrZFF6dgvMCpoebeYnQ2PsOe36DiLwn30gjZSw1Mdobl2EibHfg766Ja05DjOJ/HCwxYx4xYeunEeKaamrAL+BE9du1GcKUYJMvIJuMRhnE+qunk5bSJ5SjNav5KNmORbhDKbxatKcs1aW8a+i0cvhQVsRQ/3osAlch0BApMs+tUBr3gb3IaQjtvOHHSJGgVGDPzBEMpOSeL/RwKlCi/L0xqZGUK/W2AUC8/24SR9hOjfwj3xPPcpYidxwUWxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKYx2FOSNIBNaV1mPDCeHsv0qz2Xy1i/rnB5bzZfUDM=;
 b=Th97xwgQ6NBe29qkxOiSsLm5rauhwZtCUjYWZr0E2htBc8iAso07metR7THuoV5YglYXNM1io4WYleFfjPemgh3cHpKze8eSlwnApnXL1SmtpRfF03p8gVcsQaU973yO49QqqSOoVXpoY5yh3kEA659BbOzdXO7jU1DEsXToFpkBz4rKmAv7yaV9iK0Wgypv9cu7hUjywlhBMjtwF7JJkN9UiPflyn/niEPyeC10bkB6loJmWCelShEkrqY0QSkew7VlQq28uY4i6oiFCxket+rQhh2Bk9oAOxuqTLI3+yNradXi8xG9BgXXadF3WC0M+o7faLZ3XhqXBjoCX9welA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKYx2FOSNIBNaV1mPDCeHsv0qz2Xy1i/rnB5bzZfUDM=;
 b=zxg2vmbeGV7lDo8pi1VOnN6JyN43LxYFzjSgpYA9eVOj+MwZHe2Rq08aDgKS2hy3ACyL2ftYLU57JeldoLcH/jlfbZLzU1RJqhW7nSb2y2WDNy+j+13ukXE82qt6pJ1wZWFf/Y89ErG34wDjucUiBbw4jx0j1AAfBCh5QMcQmN4=
Received: from BY5PR16CA0032.namprd16.prod.outlook.com (2603:10b6:a03:1a0::45)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:38:15 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::9b) by BY5PR16CA0032.outlook.office365.com
 (2603:10b6:a03:1a0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:13 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:13 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 15/50] drm/amd/display: Fix DP-DVI dongle hotplug
Date: Wed, 10 Jul 2024 15:36:32 -0400
Message-ID: <20240710193707.43754-16-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: b73e6c67-3721-4b7c-4590-08dca117d7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T63eR4z19QAC5hB3XfU8T+BmRdW3JWPQM5FxkiwBn04qlsFMF2tLgZt1Nt76?=
 =?us-ascii?Q?ZOHyC36PXCho7jIpFwSOsDuWiMPMHcN0BtPAAFo5xuonXsgRPAoNpJ2G10jb?=
 =?us-ascii?Q?OEtjc08+/Dt52RdJ8i46y/Okby6ZAbvEE4ebphtT35tMQcxCbyVeRP5TW/b7?=
 =?us-ascii?Q?FJYoPKBXlIGRNzzK0sNh3FilGLqH10n8ljMfy7icEa2bSeihIZAXLNHf3Pck?=
 =?us-ascii?Q?3jErgQtbfk/WJbTl/F00oPe3wc4is6EMtWDmMk6Zyhf7bX706avk+Mxx/lFb?=
 =?us-ascii?Q?LLDtDF5BVqBfspXjVyY+YNzNxau6TLsCfA2I1e6WjDpmFxHUd5Y1lqTHXnlO?=
 =?us-ascii?Q?pIuguCMfQRT3ilhmn2GEqFZpX+GFXw+UT3bK7ME1jJp+RqvQ/j8YH2zu3Dup?=
 =?us-ascii?Q?5F7A4+UYeam9dJBRl+S4Ouo5ao02BHSm+lbaelRiNT20QWrsejeqMEJFNQgo?=
 =?us-ascii?Q?JRBhhvuOz92A5z/CLINtrYrnAdZUoiNgHKHGnD78YHyhuHI6fONqq34ovOt4?=
 =?us-ascii?Q?a6p5RwygHkIFcR9OKHQJv3T+UseXwajPuwqVcu37P7u3OUAHwUjA5KGsVOzB?=
 =?us-ascii?Q?A//5jfr0xGV2R/an7cJ2iRDBEO/MmmCi2I9tUUQ9STwAT2Uw8fmfkndf+4bZ?=
 =?us-ascii?Q?/mPB42ovIDDbw8T9oS75QDdLabxTb8DlxuYnnKs0KtZmRqpJ8/R3QHNGcflZ?=
 =?us-ascii?Q?DXMY9gY5Gsstsz/xanBTCknjLjc7PpI9a3U8Y1wgF5YvbxRyMWf3b4uM6XOw?=
 =?us-ascii?Q?rhw6yBzl3XB4LyQ5GEZ9DjPy7UKUOf269M+SSxUhglcH4lbfLtPrThqPNxEJ?=
 =?us-ascii?Q?xIb9RZ+zdRqcFWOlZWZ0zP2EMhEVeMa+CD2UD4bNNRrsl2+NZQMeVS9OtRLt?=
 =?us-ascii?Q?sKRVDpj3Ew8s19qOL3y7MffYbRRzDzG4dRK7zl3BXyxeqLjyoqCkUxg5Doi5?=
 =?us-ascii?Q?xy1ACNuLfC5V+xmty65fN6j57UqxF6EewcLPALCYgZ6mAdh+ZmFYRu/8DsD8?=
 =?us-ascii?Q?hsuBJxkkUbLHRiYR00X2US1+2bBd1m9VlHx/Hwy6lF8n5bume2BS1KBdsxGg?=
 =?us-ascii?Q?NHlAYqkqf+OIN0vNfvDqGvXqBeFHjfC0ZKK7EtSl794fFLXWxmGoM0c1zHFj?=
 =?us-ascii?Q?lH1siNEOPfNk63RD+9N1GCo2tDMxNlyml5drzFt4vOlGtqtdd0eFFDZXwPdR?=
 =?us-ascii?Q?bbp5EKiRRVIdRUmtIy55YUpEfUo+RN3vrKmntojsdZ1exV30sfIol+0TEEuo?=
 =?us-ascii?Q?Df7M71N94uTy+6Zy2JiXKy9gfOhY5D0EElENerEorDOSLbdiW0+qrS5lY5F1?=
 =?us-ascii?Q?+FfnuoswpOY+Ha/sekejhPQLMeMJx0LcckLK2NOzVcEaQnh0iNcIEuu+Spnb?=
 =?us-ascii?Q?e+6pSmdfSGazZFr/Ky7TG2euvgcWld8RfpR3m0x5eL3jb1TN96rsROCNFX5V?=
 =?us-ascii?Q?q9rABQiDYh/n+JFkbu1krDoq28lzw+aC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:15.2286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73e6c67-3721-4b7c-4590-08dca117d7bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028
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

From: Gabe Teeger <gabe.teeger@amd.com>

[why]
Hotplugging with a DVI-DP dongle on pre-rdna embedded platform
working about half the time. The regression was found to be the
setting of link->type here.
[what]
Reverts feb0593 besides the logging added.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index bba644024780..391dbe81534d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -863,7 +863,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 	struct dc_sink *prev_sink = NULL;
 	struct dpcd_caps prev_dpcd_caps;
 	enum dc_connection_type new_connection_type = dc_connection_none;
-	enum dc_connection_type pre_connection_type = link->type;
 	const uint32_t post_oui_delay = 30; // 30ms
 
 	DC_LOGGER_INIT(link->ctx->logger);
@@ -965,7 +964,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			}
 
 			if (!detect_dp(link, &sink_caps, reason)) {
-				link->type = pre_connection_type;
 
 				if (prev_sink)
 					dc_sink_release(prev_sink);
@@ -1299,8 +1297,7 @@ bool link_detect(struct dc_link *link, enum dc_detect_reason reason)
 			link->dpcd_caps.is_mst_capable)
 		is_delegated_to_mst_top_mgr = discover_dp_mst_topology(link, reason);
 
-	if (is_local_sink_detect_success &&
-			pre_link_type == dc_connection_mst_branch &&
+	if (pre_link_type == dc_connection_mst_branch &&
 			link->type != dc_connection_mst_branch)
 		is_delegated_to_mst_top_mgr = link_reset_cur_dp_mst_topology(link);
 
-- 
2.34.1


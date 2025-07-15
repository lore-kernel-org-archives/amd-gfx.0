Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24397C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD75D10E522;
	Tue, 15 Jul 2025 06:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZ59tvhJ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D4710E522
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:53:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ks+6u2ojO6K5sSyJEDzF81DHOWkb9aNlNKx2VTS39HhFGAONSzskW2E/v1B36hUQ8SF5khSiR4bldvt6yFmaO7gtsDAbQjVGx/m0gi/qMxislYj7rSyq6LLLGWeGY6pk+jsJcfgtoYSQCqeU8iOMyHD628xiIsD+0pgX8799lm0BLSjIo6Ss5K/If/BVfaWYk+x5sX5jDjeXz3+5nOW0zbNMS6n+5Gjw75yQ8/fwuYbEntduK62EOpZIAmB2x/HETUy/L6e5FQjcjN9OBzCNlEzgU6faG1x7HwYBhFWHBl4/h3ax1pgqPGooBN+bjTqPOATXJBeAXtFVzIPs6YIplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xx3ARr/aVaDNQCTrbD5WyUxD6cxQLUAvB50qw0He2o=;
 b=vH9/s9dfBKykVaG+K1jDwCaMjiuutRZWEMFSel1fJnIu2se7KSCGf/M1CPL4LlAJcGvaAZ4D7Mr+dvDcsp6Jwj2nrlUInOIP/SF4/aXBkfP9kT5Q9/x1Z5po9YEiOPvr0gZC9KEFv74RBdxeRlfs1wyA13naaOOaqv0skXET1cqoI1PagMzVoGOMbCs4Yq6pKkI0ictDH82nIvWzEIPEpiVG0zBfrWbPJMNG5YdTt0UuQ3weVlZvtlnqvMRVQTystVcRC5ZHPW/FaYxiq2VocOR1BKdVWHg0d21EfyU3kDZGnHN5uQ31KuDV30UCW4jXqtTdgv+dkMynosOwhYmWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xx3ARr/aVaDNQCTrbD5WyUxD6cxQLUAvB50qw0He2o=;
 b=YZ59tvhJH0m5es+a3OlKYtVobBvLwVw0gQcqCiS9cH44BreXzZ/DRFi2HRLb3jrGyIL2QV5unmCbH8p940bcUqNZMKTyC0RLFg1qU7+rteijkdinMNzVCA8ry905gLy/ATK5mWYzr/Hq0dKAEYlnlm9w1znQutRyMLC8ZT9Lx9c=
Received: from CH2PR14CA0054.namprd14.prod.outlook.com (2603:10b6:610:56::34)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 06:53:23 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::72) by CH2PR14CA0054.outlook.office365.com
 (2603:10b6:610:56::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 06:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:53:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:22 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:53:17 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Clay King
 <clayking@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 06/10] drm/amd/display: ensure committing streams is seamless
Date: Tue, 15 Jul 2025 14:49:30 +0800
Message-ID: <20250715065233.160043-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: a82e80bd-a933-4fce-3196-08ddc36c4a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P+1S1/kAi6tikvxCT6bPsXFBva9iOCNtxloTbJGSzbBk4Y33NEASatofVhZt?=
 =?us-ascii?Q?Bf4HkrVC725BG/PdgUJnRXjezvHlU81ILwH8JPxiGcs0tUPP9peK1VHFltiK?=
 =?us-ascii?Q?TfyBf79MvHatUfuY4QGpgF1CXIZzCHAbk1ehyqzaT9QOd4qV3DnL56Aulw1+?=
 =?us-ascii?Q?qvpSBNxzIq/pPgggY5fb7yr2X2MtjfpeGKx1NC0w5T+zhvQfopSw/Vje68f9?=
 =?us-ascii?Q?p2xwkkIUwyE/vGv2LGX1TLG+HGGPkA5HKe8lByFXQ9KHfp4TpkntFZEGyUvK?=
 =?us-ascii?Q?rGdU3fXQsyI/xv5P7vHEexCwcjUJwJYvFFTaQWJj5CXpKqSe3e9w9o8bJ9qe?=
 =?us-ascii?Q?WkolOKknzzd03PntSgF3bwtBYHgy5mbljVCIqME5xpFStf5SM1jtt8HupBXz?=
 =?us-ascii?Q?Y0RqRKoN8r6ep7JCat3q2T4JkHsvBSk9bv7cNRDPRny7Ijhqk1sI5ldHchxd?=
 =?us-ascii?Q?H5tTuk/y3/7vEH/4rf7Agk8e5zrdKUWL4clIX2iEIOsTznKBzkT89h8fSrcV?=
 =?us-ascii?Q?42Um8YNbsQWTfxKCusQBBpSqSe+rc3dibqQPien2wA+T6RcA/AsQxNtSLImk?=
 =?us-ascii?Q?PdpgrFtwOdxqFipdDhYq3QnhoPZedgokuaZ8GwymFAh5cOQ0c4u+jEoLtw27?=
 =?us-ascii?Q?fBF/z3PXbnhgt2rondziT0JM7EGeuJA13pl99pSgJuAVH85XzBixcJEJg/4q?=
 =?us-ascii?Q?rnlxBDbyMHjU5NgUQ0/U33Qs3PooOUtbS49Lpk65SUtFqGBbMulKTKrd+687?=
 =?us-ascii?Q?rmniV2Keobonc7z+d4X3pCz1Li2F89ogPDJJhfwI4Fg8DgSJuuz+bYGBKm2q?=
 =?us-ascii?Q?bAGHfpR42/4j6ESLhmtqBL+4+YC7YCh+R4yrNJqooI6XXc6zsuZNSb/VkKpX?=
 =?us-ascii?Q?R4N88XOH4azlQ5OHtrIwC66dAgYrPxW5zq7EciivHl/oFCILkNSlxD7NeCQt?=
 =?us-ascii?Q?KlINcMf7caEyj0qBCNqzxqiE1YwGjt1FTA8H4DCQ8sXpWA26/5n24phR3tjJ?=
 =?us-ascii?Q?sztKwmz/EDiJZ82Spwfbo0M1hWQuFFs9EANCwScPhso6En83A7ziGdTYWgnU?=
 =?us-ascii?Q?EjGo+KS+QWmV2r0iaSfdnPURdUeEBBVDaGxMvD0bE7lz52PLbKuj4yHGw7Xq?=
 =?us-ascii?Q?DvvSIDlKIjNdXyppAIBt9G8Z6r1nUp95VfcHPGXys2amfCS1zqQFP1MPOCgw?=
 =?us-ascii?Q?x8tVr8X0IHysv6bBmJFJhLY7WJ1yq0MecFYt8d8ztBrwPSbWIixM6dhk/bAI?=
 =?us-ascii?Q?YRmlyXaT1OdIrS8EBwfC1OzSBe8Y9rC+A+XWXgQy6Vm+ncVBz7VFeQZ2tNXM?=
 =?us-ascii?Q?9AeAxFGeDCou7ZOp5rJsxvLdIczZov17OBsBg2Z/rZIA8RX4geo3RyNgTmwc?=
 =?us-ascii?Q?1nxDWRXaPAVPOqnMxmNRBuufs2W9Ob6591BEBKjn0WKXYIdm5m0jzgXQTC0n?=
 =?us-ascii?Q?MSB/H62fDngT7yy47z3TDFkc88uc7WJWmhLAsJvciALTzt/Rij57ZKmEXYrP?=
 =?us-ascii?Q?PgpPzTRze5Im7sy7jA2RvfL+xfyYaxRVW/SylG9CPI8Zw1Yejf1yPP7Mig?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:53:22.7154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a82e80bd-a933-4fce-3196-08ddc36c4a5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
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

From: Clay King <clayking@amd.com>

[Why]
When transitioning between topologies such as multi-display to single
display ODM 2:1, pipes might not be freed before use.

[How]
In dc_commit_streams, commit an additional, minimal transition if
original transition is not seamless to ensure pipes are freed.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 61d0940cd41f..c17e5843e8b7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2399,6 +2399,18 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 		goto fail;
 	}
 
+	/*
+	 * If not already seamless, make transition seamless by inserting intermediate minimal transition
+	 */
+	if (dc->hwss.is_pipe_topology_transition_seamless &&
+			!dc->hwss.is_pipe_topology_transition_seamless(dc, dc->current_state, context)) {
+		res = commit_minimal_transition_state(dc, context);
+		if (res != DC_OK) {
+			BREAK_TO_DEBUGGER();
+			goto fail;
+		}
+	}
+
 	res = dc_commit_state_no_check(dc, context);
 
 	for (i = 0; i < params->stream_count; i++) {
-- 
2.43.0


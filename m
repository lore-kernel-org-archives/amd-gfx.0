Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D911CFD2F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 10:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052B110E60F;
	Tue,  2 Dec 2025 10:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tfJSPGBC";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3484B10E60D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 10:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI/NSx0quUHSksOV96vOpTNkH351uKrPaThFgG9A/TUeUyutNd4ghZC1A7gcmbvHEQIJNonre/NhCb6VPadQpC4Ah3kdo1y2Iu+ngMoBMpz+/voa9C5gCrdR5JFXM6pkLE/4hhHU+SDsHxFVHW6HE0pkZqUkD/uiKUGGNbBzUOp9rBNTZsKbqfy6TjUXM9lVAhgBF4Bx76pGF3wJtlikw1Uf3mh+sUunpo+rdpcfTMDPe6bJPCh41mydFYUDTh5pz3cuCePxLybt3DmVRjwcgm85vhN5PRDujqSmsMp89kg9n9COqYrmQcBaXSN+iczAGHoGOX9V54sKqW0fsjSjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZxECdNnYSvs0bO9Thi9NTyoRpnzxR8/FShM1RkOlAg=;
 b=kxlSZBP8Q+MXzncS+8ihSywwt/GUwq4LmR6WUFeTKGHZAzr0BWU/oNu9tWkS2c6WcK6d8wlmuuEqpCXMO7X7Bwqbs7bTZ8aZ2v3hUUIeLxSpKXhVedk87t197ZZBcrBsM0D5Z4aXd/uQAS0e2o0/XemcN4AuavYpxx49dQaIGBO/OKImPW9e+fnP+GSADnG0RkRiaKJMjo7nuxxnv6UPnET56sMlOJZNT2UdjLy05eO+c/mX6W7AZK4YM4hiKSIxq+DMvE0MquqmBBJc1XGuixV5w8Wnw30oYx4lNv3arM9p9DWI9u4NuUIWBxQdMJ5TMVK88QKr9SwWQFPcKmbgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZxECdNnYSvs0bO9Thi9NTyoRpnzxR8/FShM1RkOlAg=;
 b=tfJSPGBCgYbGzUr+9+UxXPk7+9cMZW5x/ODKr3Q+Xl5TmoLB2avgmyFR6gKBreQ4jmeTXc/gTL/n+sZLnk1/3dpGq7v9bN3GRbWFNKezBpBWa35E+XzGs3RR1eb2DaCPefbVd46jnOmzmwwQxGyFY5CzWkpYtMk1nuxEP749+Uw=
Received: from BY5PR16CA0024.namprd16.prod.outlook.com (2603:10b6:a03:1a0::37)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 10:29:03 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::a9) by BY5PR16CA0024.outlook.office365.com
 (2603:10b6:a03:1a0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 10:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 10:29:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 04:28:58 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 02:28:55 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 5/6] drm/amd/display: Additional info from DML for DMU
Date: Tue, 2 Dec 2025 18:21:07 +0800
Message-ID: <20251202102437.3126523-6-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202102437.3126523-1-chen-yu.chen@amd.com>
References: <20251202102437.3126523-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6e8b4a-f256-4ae8-bbca-08de318d9d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WMY27glu4gxrU1YB5Nh5kpOJ+qss9p5Sj/0R/lKQadgE6pp6t+g0YH965Qw6?=
 =?us-ascii?Q?GXm1+mKtpl7HvsrPJEGDYbdS0Z5Z8rHNdgXrJB3G4W9VwKrep7XrnbD/oHiJ?=
 =?us-ascii?Q?sb3vtzpA3QPN/r1b0/ldieM5bsZdru4t0AG46bRJ3NeZYNtXagrntAPm7CXG?=
 =?us-ascii?Q?SE97JZGfa3wJtC+Z43ISEjDFwHXFOdsXFmoHniTUom6LCs3Q0NpQkKN4iUQD?=
 =?us-ascii?Q?mtRKaGBeY2t4kVL8eb4YvkvOrjYE6GcqMCrkRxVrAdVR51yKgHjv1c0qUPwI?=
 =?us-ascii?Q?sSzZWhFDnulSh1Oq4XJRiGN0n3A4EwYJkJEbYqJWxNjWBQqxORYQFRxPiyWS?=
 =?us-ascii?Q?9P5/n80jEATpTxCc5Frnvb918MIPpAp5rZPmkaQ7DeUEhQ9i5iR83CKXcPxb?=
 =?us-ascii?Q?7rA+swG8x/rFSPJS6UjrHLig/15eV9o6J08q5tOMFiK8WlRl1KdwEZMdnfkd?=
 =?us-ascii?Q?0zQTJnpk8C9LUq7Z8RIEqMRr8OEIsf2S80ADfQ7juKPLf8UkA+PimWp575NR?=
 =?us-ascii?Q?wAhfnibmtJozKhC4Pk0olyirX9ga0MA4oUDJvdUfPTy3CXTvtuMM2M5VMS4j?=
 =?us-ascii?Q?TgDy6VpDJ7dL/XmUf85GT0P8QfLQMcF3UkBL2YIKFSXDwWHZHDcbSIknlqzq?=
 =?us-ascii?Q?9mSJI3/5pZ4DXmXCKRldlwghfNbQvmphO3KqLgnK8EvjWUrJUuX+c+Jc4jMc?=
 =?us-ascii?Q?PmWHLzsDYRTUXFiVseAW6wjbQi4M7F2ktY9PYmDjOpz7tJbVHYz1KTAjOUEO?=
 =?us-ascii?Q?waQEFkExp//EWC+74YmMx6ac/zvFmPu7MfhEqQFl4acUgWuXuswH6CNjPhva?=
 =?us-ascii?Q?Xp6ne8RXwAK89AQnXtk6xn0fUuvXnzPtv2vmxHBrC6z5FLVebzNFlhSPVO/V?=
 =?us-ascii?Q?SnBgcqWKA00ANCPcgnVN98/xy6P9L3XbIp9BB1ToH6KolmIK+5L3Oievva4Q?=
 =?us-ascii?Q?mumlYIxVa49PKReeF6DegLmhHvr0pvKKQQG4h2NDMIGKy79TU+atAg4qQRQr?=
 =?us-ascii?Q?XUR8/Bc5d02K2c17u6wp4rLpqNzRFFiO2v50nKCGDb2IDvFphE3zeFtXNKsj?=
 =?us-ascii?Q?nG+QsvI1fVECfcSOBA/prpFiuQBKuu4FMKO4Sk0pUZWAW+6znDZe0M1c1YSm?=
 =?us-ascii?Q?6FqhdWacRBt8hHj0qxXo9VOhSi6ah/aa8XP9fJDsI+JJOiUajMPfdF5p33xz?=
 =?us-ascii?Q?sJJq32rpqGZwRDZ5VgkdiBR9BJrgM8LFLcmU5uu0vnEX01TUMeV8EmwVtNv8?=
 =?us-ascii?Q?me1qYg/KOnTyfnrNM9MEr6Ok22kN9tYAt72AlBzD4D9QOc9ohQdIjV5aCSTN?=
 =?us-ascii?Q?+n1MOMA4d4TYIKhgjLiKRs3+NcwRIYqAEpjrBvYwMMveWXhckapigVzIRvA5?=
 =?us-ascii?Q?i3h6z+jT9sv8VxJ7G/+uzQJddqh5xGjjFPcVT6ZAK7YEIjoG7Aot7OS2ljqj?=
 =?us-ascii?Q?wQCjKUOy5NcuoaEeUxWQfEf7Cv4vmnUlhhGRpkOz0vTsjGjPc6PpSctICzeK?=
 =?us-ascii?Q?HFaOcHhute9e3tI1p2la/TIbaJK99gitgbNHw9tUFVM4gHZITXEZ5TPOFujj?=
 =?us-ascii?Q?aRUbr1NHYsIVC+KK/yU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:29:03.4658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6e8b4a-f256-4ae8-bbca-08de318d9d83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
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

From: Nevenko Stupar <Nevenko.Stupar@amd.com>

[WHAT]
Add additional info from DML for DMU when applicable
on future platforms.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c      | 3 ++-
 .../gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index ee721606b883..f667026cb43e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -387,7 +387,8 @@ void dml21_build_fams2_programming(const struct dc *dc,
 	memset(&context->bw_ctx.bw.dcn.fams2_stream_sub_params_v2, 0, sizeof(union dmub_fams2_stream_static_sub_state_v2) * DML2_MAX_PLANES);
 	memset(&context->bw_ctx.bw.dcn.fams2_global_config, 0, sizeof(struct dmub_cmd_fams2_global_config));
 
-	if (dml_ctx->v21.mode_programming.programming->fams2_required) {
+	if ((dml_ctx->v21.mode_programming.programming->fams2_required) ||
+		(dml_ctx->v21.mode_programming.programming->legacy_pstate_info_for_dmu)) {
 		for (i = 0; i < context->stream_count; i++) {
 			int dml_stream_idx;
 			struct dc_stream_state *phantom_stream;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index 452e4a2e72c0..943fd3f040c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -418,6 +418,7 @@ struct dml2_display_cfg_programming {
 
 	/* indicates this configuration requires FW to support */
 	bool fams2_required;
+	bool legacy_pstate_info_for_dmu;
 	struct dmub_cmd_fams2_global_config fams2_global_config;
 
 	struct {
-- 
2.43.0


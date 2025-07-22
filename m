Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FCAC83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AD310E738;
	Tue, 22 Jul 2025 22:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2rmER7s6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99F710E737
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCLypSBXEZClBq1InFeglS1trAclsaKFP3X8OaIBsHjMDeH5uvjACGXRIIDYKVaKsw3XUTCscX2ZHFXgIO+VUrq0Pk4mO7kAQZtD2mze7cPsjBOqET2ilOu+GqJBw2Kw2ePGvGtTxf5eVUH8Z9QOIyQm7MYXsyhsztrirY3ez4BYAoLu87iRiiDxEmZ5F+3yi7wPvGxrvKp2boYoevF+eYzoVpOVA3uIVX1DM96QwtGvGPOw9q3JsziDD8yqEBRs6Ra0++3Y3kkSHh/q6fmEDB31JF5Sx9AJT8LO5fg4MBUEWkcBoA65/8t86eCqyHbS+KFNEmFas3C9oXgxg3q1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIiWY5Uk0EsXnrZV0lWH8Gbf2rdW/EzMIpy0SknyQz0=;
 b=FdVCNOBSadF1K5H166cxRXE4toeNFuNA7YlwIFCdpG2AwA/Zs9HR3UFuAv2MiD9BWF8Yq0HGJI3LHxyMmfuZkn6dauHacjidyFDnKL8unIununMJFjoWtC3wqpqo3TlnuHRaVEGBUhjFYOuJUE/4PZOEj/eICJtA2vetwdJ8Le5psaQlgRugHyPq8r/KPpyRHRC5mJUhdx3C1fvoLlIEEnRxkYdi8G4g7e9hUnP8tZ69CL4Kc6SH2o35ChZCS4C0pQvXgeL7lKFshWvvELNAqisrmI0u88yM5lnRxDNdypqTIs/aGPlXT+siZrUJBF9dP3Em3FfvE7En059XEA8bLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIiWY5Uk0EsXnrZV0lWH8Gbf2rdW/EzMIpy0SknyQz0=;
 b=2rmER7s6nquYtLcot9Xd/Maw3ZNgBwAqDwk7EzJfxOtPKmSKDo4JvaHc4gdk7Fg8wxKqQbiaiGiq/w7NVB0RQdISHKmmie2coaOHhLHepHeG+f4VbffvHqwaYO/6JZUSWsHAidoIqSU7qPK8+EvK+Kn4KFUCXMpo1GBEWD8iWGY=
Received: from MW4PR03CA0085.namprd03.prod.outlook.com (2603:10b6:303:b6::30)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:46:15 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::ad) by MW4PR03CA0085.outlook.office365.com
 (2603:10b6:303:b6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Tue,
 22 Jul 2025 22:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:46:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:46:14 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:46:13 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 24/25] drm/amd/display: Cache streams targeting link when
 performing LT automation
Date: Tue, 22 Jul 2025 18:44:33 -0400
Message-ID: <20250722224514.2655899-24-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
References: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: b37b757e-f602-4eb1-b3cf-08ddc9719084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b/TfxxaaDJr++C5GPOkOipKLzB3/1aSECRTuVLe0bQRgegcdqI9UMX4/COcD?=
 =?us-ascii?Q?wkDm6GWbv05cvIyjVUuyhIGozOOuPgXdTDMzuxhECNvKIddZwRYgHmC0qB+5?=
 =?us-ascii?Q?ObYbKvon5ldlaGbKfM+AMcUxFMxWRpEQUmcHxxRusN3Ywgq9Pr7FyK/VWddy?=
 =?us-ascii?Q?ZNdxH2BbbIk55NIkncjpLMWwQleLcZGcsXtwHcwJcMRnJfy60FxA6MJZKxmB?=
 =?us-ascii?Q?f9o7zz+30bebM4ecy0CjNa5Ix6804f9I7S/Pb3U89Lojz7esot1JCISsP1b0?=
 =?us-ascii?Q?C4/OLGQf5+jg8I1gQCNz+ML1u6s8yWG2Px/wHKW1wx1mLFfRuBv/8Rr+3Kp9?=
 =?us-ascii?Q?1LtRmmqR1MnFhKlku/gAPgj2KOzuW8/M2qRUzIQSdahGj1JzZCLS62FuFWGW?=
 =?us-ascii?Q?QbE/rtwpZRdLJAJq0D8pEi1dL/gmp2nzooudzkb1FsnhTbPm619D6A0ortYF?=
 =?us-ascii?Q?v3uTfmruIpvbIcac3MmoUY7eYv6P8Zw8I4mTSqwTbIf8sXyzlpNHbE1BWw/e?=
 =?us-ascii?Q?Z6S5brwYwDxVum+DLGfUpEeu0Z09Q9KQovGP/YHhJZmNaY4hUArW1i+yCS7W?=
 =?us-ascii?Q?cAGO3y5lIyEXRZ2i3FBJNv5XcMulCDkz7SpyfxgK769/4h1QGZkQ5iLcfHAZ?=
 =?us-ascii?Q?FJG7OIu7GohJo4CpjXS90Suwe/M10ZG+7oSevyp9P4ubkK3p0OXqlz4xMAi1?=
 =?us-ascii?Q?9tfvUezjFCqgpVck686jglecraT9fuHb3+VB6ljP49lKvRidBCT6EbnDwLLH?=
 =?us-ascii?Q?HqPleamu3xhayOawEWCeXi7kuDGffksPA0MyTmIVEZdeuMLsPA4ouktK84Q9?=
 =?us-ascii?Q?ZeP2HxHeiC+BmmQNVMWFNFh3eiyssDr/mFkBHG6xb1DeZjBtzUd9yIq4Z76Y?=
 =?us-ascii?Q?YTEnQeAuaKmUB8FZd6dUwdxMb/Yb2mBD8e1RAcVECfGQKamPX+e/SXiTNk4n?=
 =?us-ascii?Q?4Vb1gxesriA87q07r6hKzf50sAMx6lqekWArgzzYY1gbgVMaOdk4mImHRnBT?=
 =?us-ascii?Q?CU8WPlRwgrsaZJarhk0snLJbby2pX2PdNQ1pw8WpdaBY4DfXhbEUyzaoCsfp?=
 =?us-ascii?Q?nrZAt5E9GqzCH7crMzjxQNCAIRdWs+cBcot5T+fQsmZ+tHb86P4Fr4LwkE09?=
 =?us-ascii?Q?LOJX1I5gFSVH4PHeQsYNA2WRYdBrLZCW6Gz7wDa8ofvsFWycy3Yurej1W1eW?=
 =?us-ascii?Q?rNtNqqh5j4pxJBbN+mzw9yJ1rSIAudSxOVGe7t86BPIIe1Y5gKFgxAWzbSEJ?=
 =?us-ascii?Q?JQEU9ZoW16ZY9sKrohybgLrpTPrxZFv4UBgda3mR4IbOmsSNCbgGJthonsVg?=
 =?us-ascii?Q?MauhX0o5TFrVx0I3REmExim3s8o+zzvaUGmQaZajX17xBMWHkbX9Zzwb13+F?=
 =?us-ascii?Q?qq8f/ancrw+PQQrYkpQlRwye7ZGF0v3ltSN7XdMs6Z3F6AtJvgvIlwc7nWjw?=
 =?us-ascii?Q?O3Cc3aYoSy9NSOkoH1ZWmUgdUKxUKtbrsBecfKZcMWSURBNHLwGb4zzwXrnu?=
 =?us-ascii?Q?NnMQuLu/LQqkCE+kHqkskF4Roh3XmUiSD6K5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:46:14.8240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37b757e-f602-4eb1-b3cf-08ddc9719084
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Last LT automation update can cause crash by referencing current_state and
calling into dc_update_planes_and_stream which may clobber current_state.

[HOW]
Cache relevant stream pointers and iterate through them instead of relying
on the current_state.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/dc/link/accessories/link_dp_cts.c   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 2956c2b3ad1a..9e33bf937a69 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -76,6 +76,8 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	uint8_t count;
 	int i;
 	struct audio_output audio_output[MAX_PIPES];
+	struct dc_stream_state *streams_on_link[MAX_PIPES];
+	int num_streams_on_link = 0;
 
 	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
 	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
@@ -138,12 +140,19 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 		pipes[i]->stream_res.tg->funcs->enable_crtc(pipes[i]->stream_res.tg);
 
 	// Set DPMS on with stream update
-	for (i = 0; i < state->stream_count; i++)
-		if (state->streams[i] && state->streams[i]->link && state->streams[i]->link == link) {
-			stream_update.stream = state->streams[i];
+	// Cache all streams on current link since dc_update_planes_and_stream might kill current_state
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (state->streams[i] && state->streams[i]->link && state->streams[i]->link == link)
+			streams_on_link[num_streams_on_link++] = state->streams[i];
+	}
+
+	for (i = 0; i < num_streams_on_link; i++) {
+		if (streams_on_link[i] && streams_on_link[i]->link && streams_on_link[i]->link == link) {
+			stream_update.stream = streams_on_link[i];
 			stream_update.dpms_off = &dpms_off;
-			dc_update_planes_and_stream(state->clk_mgr->ctx->dc, NULL, 0, state->streams[i], &stream_update);
+			dc_update_planes_and_stream(state->clk_mgr->ctx->dc, NULL, 0, streams_on_link[i], &stream_update);
 		}
+	}
 }
 
 static void dp_test_send_link_training(struct dc_link *link)
-- 
2.43.0


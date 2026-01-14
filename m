Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24C1D39011
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FB010E243;
	Wed, 14 Jan 2026 20:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oV3RmWB8";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2652C10E681
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BA3VwIrip94g/H0LDTuGloT+lBLHQqPVkn+e3gq5H//MhECS2xZn+JgiVb2cR3D5A36d2EOvJWGpWrC6dVemvrtEJz7sbNeuU5uI12uiDlyewm9SL+YW5wBFw1yoQDrGoAOrzgi7zy/cyExJcce3YCb7Ww0q0en3IFQX812QoR1atnekmoKf+iCg44HdAWoZHUKb76gB8IEvB9VdBIwvHmsdJ/0lXsNwhedyStdiUEPnvmkb1ibrIMWyvu6D3OQlhOBivSshG9bzO3SYcBOMKwgejqmiwtJsDSLZbzvR1uwIwgISdoTCdfioWIYgbwjtFpVAIoKwai6vvPNrm4W4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/Dxz+5e1I8eciIkCXc2Z2N3vHp09rXybPvYMsx/sPk=;
 b=UkQCpbTHqOZblAGTRRLnEAz2DG7ZSiSumFeU7z1CU1G/K4R08Dbd/dGL98c/Hr1zY36/VZvUGTNPB/3hbDBZI1uArLtx8oKN0nxQgW5SYwr/yVx7ylvkL+NttPr7Ji631KsEWUnmQXaiRoUEu9WiTwyhJx1IxsMnN5Qvci0dzoQkg3aw+zshrdh3FhqQYxgcg1WUTKh9Fs1ZR7UXLNJgWuyb2YjVAcfhiBaMfu30E/EefP1aphs50v1JWmNiP+DpNETj0w7rEtkGcC4OtpCdgGoZnJAgWviovPt1VU49jPFXEhy9iUAZJDJ+NfLb7qmC8qsInjv5XKhoaj4uUGnMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/Dxz+5e1I8eciIkCXc2Z2N3vHp09rXybPvYMsx/sPk=;
 b=oV3RmWB8ARVKR6L95OchmQdQsFIKFU2pTMWsL56USCbtejYW2rAcq7hezjlgsGXoaJLddDduy2GJ4g4kziOKe2sKPkMU1dW9lFg5bB51V0lzjUJ8dHFJP0zsZf0Ezc82l7lIMvPAf6f9LIDZ4Vc7r5Ew8lUetScvsjWB5QyXNX0=
Received: from CH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::11)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 20:24:13 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::ce) by CH5P220CA0009.outlook.office365.com
 (2603:10b6:610:1ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 20:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:12 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:12 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 "Ovidiu (Ovi) Bunea" <ovidiu.bunea@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 10/14] drm/amd/display: Ensure link output is disabled in
 backend reset for PLL_ON
Date: Wed, 14 Jan 2026 15:21:51 -0500
Message-ID: <20260114202421.3654137-11-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6afbbf-02c8-470a-eac6-08de53aae1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZgseegXGz2B5pWcinRS1MoH+mV1X71TX5jAkzKkqoBDAq3Vp3Gyg4tEJmjfW?=
 =?us-ascii?Q?RIS2DDduRdm+8kC24lhedAmdlnwWyZJ18sEgibLyLNLHY3elwS62jO3P5i/B?=
 =?us-ascii?Q?Dwq/FueGewzFnyiokYAOH9bAh4rmXsPxi3iWMKsgcmGrbF0BGCHnuSoIf2zA?=
 =?us-ascii?Q?wBUByKxmAxQNLsKSxImMjeT9vO9JC+70M33aucwxANXb0ZyCh04YNcvxNPrV?=
 =?us-ascii?Q?CiAmko9Bf14GSMOzbUQBAtDESqWhN414p7taLprtGvH+KFITCtq73SHmNrY2?=
 =?us-ascii?Q?j+ONRk0rzPMinUsKf9penVC/mQQ4v8SyltUmn3opv7MbtPEQSyGtgdSUUZrs?=
 =?us-ascii?Q?yIl5XupH9s8g8UVdzfoNltzqIKsoAZUPncVdDiwOk6CLq1FdrHnG8ZNyZ4ag?=
 =?us-ascii?Q?F7omfMH/S8q3F92wjyWCpp7mK7t7EAl1JW8xDEfbw7UjJTsgPPRaTiF/C3YV?=
 =?us-ascii?Q?b1EW+qWy80aMNgW3iT15ZWDgd1x3oLEjP94UQArRPa9/S4UBYZWZgrjXaeAT?=
 =?us-ascii?Q?7XaQfwnhUpoz5TwoSgUGq5cpc9pwz1eyQgeGJw1m/DGhiMw3DUGtYFvD0Z9C?=
 =?us-ascii?Q?K9ov+xjYSXpfX605cAnOcoRuXzF02LHzuZLXNZTUjrGY88phGLpIO+DiAkXS?=
 =?us-ascii?Q?eZO185sfAha9/yle3LA3hjvQgs7PHLJ0MsGKKvUjzXZdw9cxppYCe9TU6hU2?=
 =?us-ascii?Q?bPhXVK2VC8PnvNYTXxdg0+zCnTdFLpW5gMNoXW4C6N6JAmDfCLLVoy4PQUSk?=
 =?us-ascii?Q?wfTfSvM6rYEkJjkRzLZ7mVlZSdRzGzDQ6ImfuUa79IN8z+D66O2Q9uWzGVjD?=
 =?us-ascii?Q?p0VRn9nq0tsI6dTJeLfnoLLi43I3eR+rObwoBeZH7k2vnOa6UBrFqMn6Rx1B?=
 =?us-ascii?Q?CAxG5y6ehSTxgpr9LEhuxiiK1V0pjm2H+nokygyyHPjC2iiPBhtGcT7w5Y2j?=
 =?us-ascii?Q?HxtmY2WeFiZPeMZvGqLk7mfOTygD+wS4AXWisnM4MXNvYM/6qAQ8xpUQqbs1?=
 =?us-ascii?Q?ZGoiLYmzQm2qy1n294YGdJ45fZYsAksCbiGnc/4f4yPKeSAEzMrSjkCgFUJx?=
 =?us-ascii?Q?3UvkfT3GahTxRSvor305yWxV9gU77boxpkuL4ZoFlvWKdufWHsal4NEjK+gi?=
 =?us-ascii?Q?owj3cfLgWPFW1TJ00RmWlLvyjqZetsrDQKdo1kTZlHu2sb+Y2yNrykoiqEHe?=
 =?us-ascii?Q?NT/eRJvBkOe2kSmnWxNm6yGFC1RkoyZIA4qrcWaPyXCSDnDYfpRasVYAB4za?=
 =?us-ascii?Q?3xv3CAzgPtCsLrvzeuN4i74/U5H0QlwEt1woVHQHNtHJjgtKUB7F68swnyWl?=
 =?us-ascii?Q?XuiNCe7KCAe3cIDx+gSalzr7iSnCa9Kpjrd7xmyFGLjoOeVXiN49/0mAU0lm?=
 =?us-ascii?Q?j6HQ1aGpFUN8IrzjwHACSCtMqRGyLtV+FqDoYSefp7cXmqTWZGpnqpJW5zyZ?=
 =?us-ascii?Q?CkVHYuufYBIpteBDf//clJ+/V6IB8oHsX6sIjdcwVlAOztH0hC1iXjDc4/PR?=
 =?us-ascii?Q?mZ9mDp6YdZApe5O3/1CN1tY4fYgX394Q+q6eRA5c90ADXZUELGiV8Gopyew+?=
 =?us-ascii?Q?M09CnbGyljMhWcpJxy2KndHyvusYkPw8bKkv0s3SK6yI0bvlmL26eXn2bHMc?=
 =?us-ascii?Q?rXr2t39ezE82dRmjPbPWgsbRUZaWlMO4zQUCnlTgfWu0xHnNoxtdGhGTKwYa?=
 =?us-ascii?Q?0jqdyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:12.9908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6afbbf-02c8-470a-eac6-08de53aae1c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713
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
We're missing the code to actually disable the link output when we have
to leave the SYMCLK_ON but the TX remains OFF.

[How]
Port the code from DCN401 that detects SYMCLK_ON_TX_OFF and disable
the link output when the backend is reset.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c  | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index d1ecdb92b072..20f700b59847 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -546,8 +546,22 @@ static void dcn31_reset_back_end_for_pipe(
 	if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
+	/*
+	 * TODO - convert symclk_ref_cnts for otg to a bit map to solve
+	 * the case where the same symclk is shared across multiple otg
+	 * instances
+	 */
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
-		pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
+		link->phy_state.symclk_ref_cnts.otg = 0;
+
+	if (pipe_ctx->top_pipe == NULL) {
+		if (link->phy_state.symclk_state == SYMCLK_ON_TX_OFF) {
+			const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+
+			link_hwss->disable_link_output(link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
+			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		}
+	}
 
 	set_drr_and_clear_adjust_pending(pipe_ctx, pipe_ctx->stream, NULL);
 
-- 
2.52.0


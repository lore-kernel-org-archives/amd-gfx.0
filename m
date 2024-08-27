Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1426DC54734
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BB510E393;
	Tue, 27 Aug 2024 16:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0OgBu2ba";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC1410E390
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcM+oMSpcN7ckBt11Wj9gL599qA+Os632HBinYWJ/6SpBID/LME192qj+zHAtkecNlsFGk6+8A//Wl1tIk6Cao0U8slP/iS0NK7caua+jPtah+dBKs5fNlgtxsKs9pIJRTKAJt8o7ja48u7AOUxVV9xLHRB2onT4RFPeNme9emN8HeapXkvXBoZ4EByuBXcwEIxcQvAieIJWEbB0lNnFOFa60jGLtJPksgW1zSF4L1NANfAMnOECZn6sA5QLLLmwdVcEAwlUi3rf6a3V4waQ8Y6MwbLAXXrj/pSMxu22zDwR0y9h11GL8hYJ+h66S+cTuD8+gogheefMj6cQ5mv/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BqNPtyAEy+aELPpLWPUjNX8A8GnDO736qFSzAvdHBA=;
 b=cGqAxamtuB6FhwiQ5yd7GetRPYc/Lzjv+b40OeMAWPACPNXxapP0yKbOIe9kfRrvXO7IvpofOKA3Yn4jIC9P6kXy0lpoppespL7C0oe0YmB6J9eMRUMIH8CLUhawQih6epBdRdtjaICYNliF6udop5SM9J5w2YeHM/desfrry/u35eYIv2NPesM68MaPKmVVzi6vDi3w2cqu+jKSjKpElz+gJA8CY4zUL6qbKRfNC3n/qRp6AaXaEhSBSBUvtYjwZLE/RGPg+FN8uBAklQFwXevRtuy2izRlp3dyXCGtWKe2rmN1CQJXOEyb1BSYs0rwkbZh9YjzkZYxOP4Er45FTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BqNPtyAEy+aELPpLWPUjNX8A8GnDO736qFSzAvdHBA=;
 b=0OgBu2baLPJbbcbjnnuPqFZxzujwY8JMb5/3/96v0Z6UE+Xgux+eUYVrk0+uvopLG+UbST9T9ra5fZ5L9bsH2yosrDkvlFtNdUkEcRmXHXrfX7EsI1QvE54SGKvqrXtEeKjKw4PGuqMYk3zJA2poOJB+7ifWMNHVsmeQYE1HoTE=
Received: from BN9PR03CA0435.namprd03.prod.outlook.com (2603:10b6:408:113::20)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 16:41:10 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::2) by BN9PR03CA0435.outlook.office365.com
 (2603:10b6:408:113::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:10 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:08 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 06/14] drm/amd/display: disable sharpness if HDR Multiplier is
 too large
Date: Tue, 27 Aug 2024 12:37:26 -0400
Message-ID: <20240827164045.167557-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 9107bb20-8606-410e-5ff0-08dcc6b70e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IufYJpMA7/qenFZdSHtBZy4E9YR7M0S9nxXf9b/qKs+80Jo0DgXc48i3Siu8?=
 =?us-ascii?Q?uBsupSYb0oI3yEE8uaO6t0bT9tRkb98zPvYXnRooboDRZ/upGwtbmeqciAhs?=
 =?us-ascii?Q?jUSNOw33kZamiW80e7UUbcvGN9m8c6X6xG8GvRze2W2XSqnN/KT9yOSOWdr9?=
 =?us-ascii?Q?LPdi0A4Bygv2tVZDn9Bd04zRpAr4rC/bpbP07WBnTNyxPpBi4mXhRFyB9pNM?=
 =?us-ascii?Q?qDN42eRDM6anX+tO5xotAOGoQJJtFdBv+97MmGvlO5zGHh8VdEVUATtevAXn?=
 =?us-ascii?Q?R4Ve+jj9FlNAlwVWL+G7yicTlWvbRmy5UhXHlVkKa2ldBo+0PdTSJ+9IFIZF?=
 =?us-ascii?Q?70E/wCLKYn1E4EcIiguz8mrFPHX2u2zG+sdWFHVGFeor1SdQSF/bkRF7r9J2?=
 =?us-ascii?Q?LW5iGaADD78z2pm2ao6INvXW2Y6PvPzkLlMngrxUtO312YPn8Vm9X8K5Agof?=
 =?us-ascii?Q?xoBL5V6wl6qX74rSRLBsu4k00wAoDOXK/T2FyiXXUJT0vTh+1EBjJmjG5UDa?=
 =?us-ascii?Q?ByiIE6x2HsNJmz3a8/lzKSKs4bI4odS5hU4GgnamWPWYHDiDVw1vijT/i+yt?=
 =?us-ascii?Q?wKUBUcZe24+PP2IeBrgvU9PySJhKHPaH/aivzqlniOpkCKXgWHRKxBfYVWzk?=
 =?us-ascii?Q?O61ZWXJnajBxXigF0NuMuIimd73slWketf/OFvoSXhTrbbUPdefjHhsasjYt?=
 =?us-ascii?Q?Ce+zyFh9iGPR1VoxhM5F4aVxzDduKzJjmnx3sWYXYgMQYBfaPHKd2rtV3htx?=
 =?us-ascii?Q?qGxhC0VmyUEua5uMew63exTOWJLaDA7x4Z+OVxyTxDKEP0iu2UUSOrkcaTew?=
 =?us-ascii?Q?+BH3PuFOkyhYUztosE2iX6tey54OL0G9pJZE56LtLw9BVZ77zePuOOWd11II?=
 =?us-ascii?Q?K7nSt1TIcyIaX1EDcEJLOkqa1fG/VJsABAINpUZF+WnswQ6nLXNC9baL9jPN?=
 =?us-ascii?Q?VqqJEtfXSEdeAve1DuPext2log9PvK3q1UzBTyYo27VDAhF2HquOO6VWrDm3?=
 =?us-ascii?Q?LipyrLcOtCDgcj5W++/4yRrKq2HB10wOGTw3P49qUD1CTwF70H1aK/KAYse/?=
 =?us-ascii?Q?V+WNkwMirkW2hruM5z52YFMVRGyAQBrFB9CmvXw5AeXgm8G7Y4Gzmq2+o1eM?=
 =?us-ascii?Q?Bfa/AubJGDCWv5crX7ng4PZPiqp0CwUt7RmSDg3/BN826k4XzczkInS9yX+b?=
 =?us-ascii?Q?MbBFGURHW5RAci8Tmr7WQnqpc5hc29qzaPRxFYLaWK0eL2HeSdJuaUvCBf/j?=
 =?us-ascii?Q?ENMTMQvD/BUEWlFAs16HdP8I6P0bUHlF04vmg+X/vnd0V2GtMuz9VKMf2dIM?=
 =?us-ascii?Q?vRy/Ui5/DWuQxPmK5kw6xKb8VFXkKtBW4pJh+Ey+Zzcm5jxQxO8/H25cXbB1?=
 =?us-ascii?Q?ofoSUkw1Ce4Sx/aX4wL0kvWQklg+ft3YDvR+o1bnrvlQBlLMsYvImDRs1m4M?=
 =?us-ascii?Q?dBgdj7gGVKtAyPzITsQx1XAg9C/g37SM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:10.0409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9107bb20-8606-410e-5ff0-08dcc6b70e4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Certain profiles have higher HDR multiplier than SDR boost max which
is not currently supported

[How]
Disable sharpness for these profiles

Fixes: 63697e1d69c7 ("drm/amd/display: add improvements for text display and HDR DWM and MPO")
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 75d00c6a38f4..328499a77884 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -180,9 +180,13 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	spl_in->is_fullscreen = dm_helpers_is_fullscreen(pipe_ctx->stream->ctx, pipe_ctx->stream);
 	spl_in->is_hdr_on = dm_helpers_is_hdr_on(pipe_ctx->stream->ctx, pipe_ctx->stream);
 	spl_in->hdr_multx100 = 0;
-	if (spl_in->is_hdr_on)
+	if (spl_in->is_hdr_on) {
 		spl_in->hdr_multx100 = (uint32_t)dc_fixpt_floor(dc_fixpt_mul(plane_state->hdr_mult,
 			dc_fixpt_from_int(100)));
+		/* Disable sharpness for HDR Mult > 6.0 */
+		if (spl_in->hdr_multx100 > 600)
+			spl_in->adaptive_sharpness.enable = false;
+	}
 }
 
 /// @brief Translate SPL output parameters to pipe context
-- 
2.46.0


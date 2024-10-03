Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94678CF34D8
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1995B10E270;
	Thu,  3 Oct 2024 23:35:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AuFCYfgH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9C910E26F
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttzMUKaHlySIxJi8mStzeHCuSf3PDd2GP4/rnLbWVR+TWfxP2oXLhhT3UtmyaocoqcNlVK9OVviOnjp4IXgH8N3Y3BnEcZnNQVS0Iq1YoEoPhJKusXEMzqWrqw+DeZEtDJWTAKQv+Q/NY4s049FzPR9/5AlacerwXobT/kPf3W/Q372AakLQ6GXH+2g91UynbPKFqr9cQAefQrBMvHCxF4DK2fSrH9tI+M49h74nz9AdR4n+avxieUnRybe/9tLGVTYZI9IZeLbL3yRUaneM/5ebSMN4SeH/6QGZmuuoHl8oxOfkQzh+ik/a0BDT0oPuxqXI8Ko+F5shLgg+RA2rgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8TFqq+mvi1soax/9hGi6o13fvnqpu5tdHjJmruEcCU=;
 b=nMdqiekbjSn93dbG+P2KdhFLbZ9e4P/SCg5eS+o/KNOTeVwdFJMorgxOmuBROmeWOkcgPkZQ/fXjqK94mxnLLWM8HUXoyZsmvSJgDE1auHMRjxisZYlXzrcdXUne0QvoRZltfgjLDAqH7LU5OXmWaVHqUQVToi648GtCSEpjOJB9oiRvXddunKD0WTWREWVosQ6DVFfB2IXjF+Lp0JPFvsHpSlCqKBbmEZOTyjh4ezjfla+JNcj01qvE5IQmHdEEsV331U+UGbBGsz4H+lZtVgGnSqxYO1PGKuxX7nwpPs64BurxGgVir0mKNxaZahvmYwnylAVd1zN7GtB1VMieLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8TFqq+mvi1soax/9hGi6o13fvnqpu5tdHjJmruEcCU=;
 b=AuFCYfgHv9+BSvtdtRIaFd1HOa2kqwa/iYhttG+Ml+tuxnAy/sGx/rL8Uk/YAGBpo4W5iosZYObtFXb2fTIcLXq/NXy38tlQAHgSYtoC2ILTlDBrseqeHNNx/whLYa9FnYu79JZSgV4cSwxRf2yRQlaMcYEVYUn6PVxrTmf3P/4=
Received: from BYAPR06CA0021.namprd06.prod.outlook.com (2603:10b6:a03:d4::34)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:35:41 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::ec) by BYAPR06CA0021.outlook.office365.com
 (2603:10b6:a03:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:40 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:38 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Fudongwang <Fudong.Wang@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 02/26] drm/amd/display: skip disable CRTC in seemless bootup
 case
Date: Thu, 3 Oct 2024 17:33:20 -0600
Message-ID: <20241003233509.210919-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 1302976e-ab7b-4a1f-8820-08dce40417be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eHn8yiMBdzDsyRXKqmmY+DRnR4zH1bgpGTaHAp0p7M9KRWcmFOsYl/3YApEZ?=
 =?us-ascii?Q?hfYkQg8kHJu7XcYFiEHi7qy/aJEsWAoEEOy/zvOTObTmV1hOZ5Kh2N8dQXmL?=
 =?us-ascii?Q?3buvAglDh0ukX3i+4vGkQJnAN+Rai1fnTtiVuref/FWQIifOBUCAH9BIFuIp?=
 =?us-ascii?Q?J56SIyzMqE+4AukEPF49vQFXDpqnJVfWoiaTFh+Fq7G8rGJRaTEY2lymAC7o?=
 =?us-ascii?Q?StPEN1moJqSaGIVGkpyhfEyHXDQHLV0qVdHjMMT0Mldl6dZDGzcrh1PxwwvP?=
 =?us-ascii?Q?/ehcj2l15HCxtLg5DcFTEFZeprqaUGBRg/ueA97Xz/lFYVKpZYQlhbBD7XQa?=
 =?us-ascii?Q?WPL1QQhqXRzk2+po6mEKtQptGr6d5i3tMDBDHodtPU1OQveN6k2J/8CHilcJ?=
 =?us-ascii?Q?bVZnM9UBQedC1Eq02EntIOkzdMru08ay2uQhZNGPZJAAdzIx0aNgKrL/+/UX?=
 =?us-ascii?Q?y1Re7MGT+T0qsDAnBG1rtO6abBOJJU9wF8NGqcBUBcGdifZ14QfGbXmW033p?=
 =?us-ascii?Q?DIrFQ1qRZv68jNoLMYA3QxbZhwUu9OKwLowoH3tCpzwOgJlxh1HUn3jpAKh3?=
 =?us-ascii?Q?5fVhXtRc5V16C4ZZRpYY7blJAWKda4gON7oX9AE5v+lwPZravp4q8lFs/JR1?=
 =?us-ascii?Q?XhzWpk2Wlx94g0IDL8ifWRVGWi/aiqodHck1P9NBgA+ypT4U8v1xBavSWKmM?=
 =?us-ascii?Q?UTITikp1gacKPpktnvQW8stcSAnhPqSvZvVQVGJ5tSpDAAk+gwiHeymAFWGj?=
 =?us-ascii?Q?iovCBC2TOzLcdfPiwMTQN8ZiG3wUVmD8+0+EPz1MWuBI6djhNFChevkjSJCN?=
 =?us-ascii?Q?0Fa65ad2upSLwIYwtQ5mU/vhz8jyQ6tWHlPXVWEiYfA54T1ROqF63YKK4ROW?=
 =?us-ascii?Q?TbTsZbxGcHmmW4QfwcBVM75F4CPzFdcR+gYTidcqhQOZZC+JFHVUjkkao2je?=
 =?us-ascii?Q?uSt4+cvgeLF7U7CyHS5iK4EUFR8gEBBo7Er9dQYIkXG34K33RqdOCVnw1r/G?=
 =?us-ascii?Q?SYWpTZvoFJZjsqM4UufrBTN+N33LhJmIdSCp7u6HW3oq/4/F6oJTSkgxQVYp?=
 =?us-ascii?Q?YndV1r9u3CDIbkH2t4JoHt+nQ3SQNz4TerxqOVE3qZm6nbGi0Zvh/BSk8aTj?=
 =?us-ascii?Q?l6lYkngp9Te/9bAKK+ju/ereqkjm9XX7w9tZsxmdyjkwETuvuB8IH+TZCOGe?=
 =?us-ascii?Q?QHRpL+esLf5q6PLxXU9lKoRVAl4QmbpLF0izROiHhuI0QjisHT5MiBxldCZR?=
 =?us-ascii?Q?brPxaipgDHW4ROah0ZLhBpa8Y1/lEgkSn43ENGL4gSXNzBoB4A/mOlsBfsDz?=
 =?us-ascii?Q?EIGMbGJoFR67yhRzpkMPfveKiBVaz3FSQQ/Sl9QM1EeBqWKaEq/X6yrC3F0d?=
 =?us-ascii?Q?Y3sUdatN81r7cT92Mu/AN+unEuC4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:40.7413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1302976e-ab7b-4a1f-8820-08dce40417be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

From: Fudongwang <Fudong.Wang@amd.com>

Resync FIFO is a workaround to write the same value to
DENTIST_DISPCLK_CNTL register after programming OTG_PIXEL_RATE_DIV
register, in case seemless boot, there is no OTG_PIXEL_RATE_DIV register
update, so skip CRTC disable when resync FIFO to avoid random FIFO error
and garbage.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Fudongwang <Fudong.Wang@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 5b6cf2a8e38d..e0054e654db6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -371,7 +371,9 @@ void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 
-		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal)) &&
+			!pipe->stream->apply_seamless_boot_optimization &&
+			!pipe->stream->apply_edp_fast_boot_optimization) {
 			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
 			reset_sync_context_for_pipe(dc, context, i);
 			otg_disabled[i] = true;
-- 
2.45.2


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCFFCA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE3910E7E9;
	Wed, 20 Aug 2025 20:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1w7+/+6o";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3865610E7E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLQ2djzKQykp/clVuMQqB99JCuJZLGRdE+xT5TuiK7BbX0O5ALB+nAPS5qYzye4I6jNRhbEgX2/+mILeivT87m3EvZWWo781XQVp6a6rwnnJ1wjmwUHsH0fopDb5sX/zYFHFsv3fsjFCdjKUI0CN8Ldh0WZ7zaDkdgkssIM7EVKubAJsTGc0xKgXCvkX8BZmxHvBdrIN3oS9l1BlWFRW95JC0tDgscT568iJsCgvYY0/T6vFOpq+KyRTKkXxo6gTvdzyI6S7bfw2KLGYHF8C9Z/DqGStQ6bFlw8AUDphCfbpoHxBz9Cs/gG1H+/pbyuK89PoxX9VpfPHDZK8XsmgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEbl8CXR3CmOHaX+yhsb845tiz88uAoVBWlNOFSklwM=;
 b=j8HKFssR9/R/UTQdEqpHcKBBjd8l2KUvqhy9Duq+Vd17mx0aoY3DTt38ATA9P/Ul2btVzQKDqb9Ea+/z3DcElSWaLuvRPkYnzM+wpB3vXyo0CAtQ6atJpJqc9f68lCaWtktk4tIH5ehbmAhMklx2mCQvJeRdgzVunFV7O1W9dtKBvxUMCdSsB/1iZNYVGxIExTmbQbvHg6d4nFf/M5gTiUCMvYOU1w6obk6h5i56z/idEoNeP7KFBJT8xxBRUFO/52PogoFDOtRmvvuBHZmm4EdzvSQJHDiawaq0wwtVMDwqLIz2UVQqJvR8XOHJi4D7Qs41T649EPLpzVrFSY/I7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEbl8CXR3CmOHaX+yhsb845tiz88uAoVBWlNOFSklwM=;
 b=1w7+/+6omuj6991eaOAOlPzYpVq2d+f9dHszUgf8fTiv0Lw+9Kl8KlzOIig9YXAcTLAiTF0V66B9PP0J+08HD5lq3bUB6y0NcS3UgT4+JNLv1OjLwVi76YN/yCAO0Pep/JCH0rfYGxrf+l/FcaQCOklrEJItaqY/m6CpGOWlCxo=
Received: from DM6PR06CA0040.namprd06.prod.outlook.com (2603:10b6:5:54::17) by
 IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 20 Aug
 2025 20:21:10 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::36) by DM6PR06CA0040.outlook.office365.com
 (2603:10b6:5:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 20:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 13:21:06 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Reza Amini <reza.amini@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 04/12] drm/amd/display: Decrease stack size in logging path
Date: Wed, 20 Aug 2025 16:19:54 -0400
Message-ID: <20250820202103.1122706-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a4f921-f6e3-4a9a-d4c4-08dde02719e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kx0RH1qLJchhz/JBGPJITWwVUzg4QwuNCyCY+XvKYrQOrAzQRuHfXTNYIUYv?=
 =?us-ascii?Q?wIjiNjp3RtD5P5VWQprr25GsSZKrYSJTB5B8xRerdOMnWTrFW4FIS9qSOa2l?=
 =?us-ascii?Q?98YDaK7UGzknKg+Zo5kHmtZrEYXPDwSheKn2GM1gEKoF9iyUXPzsfDJhIDyt?=
 =?us-ascii?Q?LygUvu3Xlu97k85O4X6W91XTPbBzpoVOhjuERudShzU3lcRl5dG69I7kkEO5?=
 =?us-ascii?Q?13zPFw2T3pp6VWvOjTPIFz6NIMM/UiWxKeu30SD61NTRNoLlSxjzH9m6pnqK?=
 =?us-ascii?Q?1J8BBvYMKqXLwJB2iD2bDjwiWEEiHAViBkLQe85zkC2No5G2U9JFVMgdeuE8?=
 =?us-ascii?Q?PvdISajBmuYeSGPIoqvFogIXmgpqPk5XBbX1K4CMkiailFX6i6g0IDftxIng?=
 =?us-ascii?Q?DVAV+JL91LmVHotptSwe/2opewiodcDEt1ZyNSKtPo/Zl6RVePXSMuQcGzXy?=
 =?us-ascii?Q?m3IuuVmWmEZe/PlfwvxSqMSjg9/ESeq9aISbIXeGc/vPIsi3k5BO+A9Dp10a?=
 =?us-ascii?Q?2DWUC1WYxJjF2q6AwAgrYA5uP54f0cEuUAYsytHS9JbZ+gybRZfP/N2G+9AR?=
 =?us-ascii?Q?S7TQGr+QPBtV/F1vmX/enVE40JiUuG149LNB44U4rjRbhsyDnmyymGQlrkDy?=
 =?us-ascii?Q?I3+FUdwMhcWjc+wK4nZBpV0rc6Nd/h8BvaTuDYeCSpEjQ3OMwBJWVthqEsIe?=
 =?us-ascii?Q?c3F7cJU6g+a4jgP5tqelM5w7hxAKaLGuZhOdWqMwHHasg+L3ve0pcjMbUVhP?=
 =?us-ascii?Q?WZn3wSUngdrzUAZEdJ4q8oIG00lMClQD40rBkppbZVFOTK0C9mwcaUaeOYzN?=
 =?us-ascii?Q?jukmEi+L9vlPZ7MrEntTbUYefPFRpTpfcCcLHuVT0A0Og224FMzwrb1C8Vst?=
 =?us-ascii?Q?Aq9M7QMK2orF78/8KS1CYPZz4+lEN9V3IXkjhtgZ7vBkZuUPLaQWiWqFy3JP?=
 =?us-ascii?Q?MoAY/OayVQPOs1Qg9A6jPsyzMivbUbtyY1+h2l/WqQogfjFltgnnIwttFogy?=
 =?us-ascii?Q?ck/xj3gxMdxvKndDWHMT0xV7XiWAu+8eoxCi529TB30shh6GAEllTcfMY+zU?=
 =?us-ascii?Q?QtLb6+q8iO7XR/amv6ngA66MD4K6ItTt/fvXIOvyEXupAfHezQBFIzq29KOX?=
 =?us-ascii?Q?jeaAUsF3ziJCoBFTXKnJ1XJA5ql7KDitlqp4U2ptf/kuQdGQBUs99sZdho5s?=
 =?us-ascii?Q?79kzBAIJDreDj8lnwxbG1PLe1nqaP3IvhANfzVVp4DC33YrcMPt9EsYiC4AZ?=
 =?us-ascii?Q?go5zsY3VczNKp3E76YHJSb30bn/CLkxJARGfHHeBVmT+U78uuLADz787L1Np?=
 =?us-ascii?Q?obZxGFSvToIBgmfH3+m/0AW62PV0b2/SjA2zpNflaeza6IK+ZO78V+t481Dz?=
 =?us-ascii?Q?3kIInPdi9LdGa9ReA/UVOurQFlaIX23Taqs+njB2dG7TcJ5SqacwruFeWD5H?=
 =?us-ascii?Q?V7NAiXduDF2cHsD+tQx6KChuLR7LLTB4E3W/CMt/S6Q2gVeVCLvGcjfMI15B?=
 =?us-ascii?Q?tZ2N5QS5W+QLcY6AlShRmZhv/qtFRAKF1JqX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:09.8177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a4f921-f6e3-4a9a-d4c4-08dde02719e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
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

From: Reza Amini <reza.amini@amd.com>

[why]
Reducing stack size can avoid stack over flow

[how]
Make local variables const and static so they are not
on the stack.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Reza Amini <reza.amini@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 79c9bea78c47..d633033c98f2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -328,7 +328,7 @@ static void dcn10_log_hubp_states(struct dc *dc, void *log_ctx)
 	}
 
 	DTN_INFO("\n=======HUBP FL======\n");
-	char pLabels[18][50] = {
+	static const char * const pLabels[] = {
 		"inst", "Enabled ", "Done ", "adr_mode ", "width ", "mpc_width ",
 		"tmz", "xbar_sel_R", "xbar_sel_G", "xbar_sel_B", "adr_hi ",
 		"adr_low", "REFCYC", "Bias", "Scale", "Mode",
@@ -552,7 +552,7 @@ static void dcn10_log_color_state(struct dc *dc,
 		 dc->caps.color.mpc.ogam_ram,
 		 dc->caps.color.mpc.ocsc);
 	DTN_INFO("===== MPC RMCM 3DLUT =====\n");
-	char pLabels[19][50] = {
+	static const char * const pLabels[] = {
 		"MPCC", "SIZE", "MODE", "MODE_CUR", "RD_SEL",
 		"30BIT_EN", "WR_EN_MASK", "RAM_SEL", "OUT_NORM_FACTOR", "FL_SEL",
 		"OUT_OFFSET", "OUT_SCALE", "FL_DONE", "SOFT_UNDERFLOW", "HARD_UNDERFLOW",
-- 
2.50.1


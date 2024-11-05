Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3499D36137
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4947710E435;
	Tue,  5 Nov 2024 20:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dSn2HCOn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF11310E435
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcNn1NEVK33JgmvAZDthbuW8PaUx+/SSa0T5Jk+yrMPaBtC6wB9/OB+Ygt/YbSbsl/vK98lrDTaYGLHoqD/iMgK2qd37ucxHZImUXUEq/+sTUbQwi55vgc1Vj25mzQALIuYdkeetxSbZ1MBL5iXBo4R6Ogq+RoaPDQGO3YmsrTK4v2KEpenHl8ZpDI5B7RSxU3/fx7gh+B31t7ESr4f+MAE9qm+V0Solq+1PXuN26lcCbsKnqIm5MGPftGVzRAE39/JhWh0YuSvRKU2lgm7hkUV1QObG9dtljrrQWkFyII+E1acQUgXcFPMvcZr1XPJMNIaZD8i7hbEl1UNpGLNwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeMP7JgFY3zQr5N4T/B6FawzbqA51Qp5C3JHyVddzAs=;
 b=wNZfmAfjtnzRN+BEt90Sj/Y96Cbc5nam5jxG7nLFn3kxQmRX2js6bdPZ+6oInIvvmKCfS99uvvHdpi0bB8CYv/IitOquN2oHH1uEcoCdiK70sNYYttnsniEFsPgD2yt7RKoc6RCwFHkzPPPBh9CfCXYjuxXxaXvdqp1MK+9Y40FuB3BELUcJHGFp4YfhS83lIEwg/4SjrxJth6LaXp5QCmqdgvHQL5wsLLMEEpta6BT1dpQgpOO1hbXIH2QygnM/sQm+8Ie7uVz22eMvSJZ35Mz1KTqSHDjDzxRJZlGO8NbrtuEmXj+kJTaXz+N8FZNGwx8zflTiDxPdpk8CovUN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeMP7JgFY3zQr5N4T/B6FawzbqA51Qp5C3JHyVddzAs=;
 b=dSn2HCOndslNRBRE5L8f4dO5ZdtbWAdQtrdMK91T6GQg9pagqroppUL8ASBKZkNZqe/OP2vlmTyuavV/KtJMR0dfb3bGyPw1Xr9QDZovb3hqo8Rr/tAGnTQxrM592gpGTK1mcYiPxX56OGvzN51wJCbV9m9VfG3T8wmV3sacKWQ=
Received: from BN9PR03CA0244.namprd03.prod.outlook.com (2603:10b6:408:ff::9)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:24:09 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::b0) by BN9PR03CA0244.outlook.office365.com
 (2603:10b6:408:ff::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:08 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:05 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Leon Huang <Leon.Huang1@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Refactor HPD IRQ error checking flow
Date: Tue, 5 Nov 2024 15:22:02 -0500
Message-ID: <20241105202341.154036-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|LV3PR12MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: af3dcf3d-2630-4483-968d-08dcfdd7cd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E1LLic/j8ZB7/3LC2lZIDg1DY+u8qDyuEgb/GSHjDwrP82yBLdztdmVJXD+F?=
 =?us-ascii?Q?zQUtd8b+tkDbhWWGsZuHE5HQoi3/y8N6y4pNHRcdjAuoKPEf7Knch6tj0h6c?=
 =?us-ascii?Q?9MFLkvt+N1UcBiVeAnwscR3DNyoSW38wCuyvVJpDTlhwO4LYLTBRqtYCyi1a?=
 =?us-ascii?Q?Lkr+FOgOwl8uvvThIupWoAa3gYmu21oM3BbWTS2vrbgWMqKyqG0ccP0s/XFp?=
 =?us-ascii?Q?BBwUz3b3Y+YxMMjHTeXJShfEz/i9F2Pi7rH8G2LZx+CinZE3CY+4l7dclySa?=
 =?us-ascii?Q?leVKbNN8TRhSBCQxNTc4Gni9jlVi/I/0TowpEpz2ySFHYQ2l3NEOEGftga8F?=
 =?us-ascii?Q?gkiptKMYJE+oc9r3jUGddEMJNYPjN3lgbNM5t63f8xLCiuZs9Lp1TwFNUrf6?=
 =?us-ascii?Q?nY74fMHyOy6JMWoubt6p8kl0/6ot7YDGEr+7EaJj6lEIdrgIBBmBJeKVHWSX?=
 =?us-ascii?Q?CKhWpbX3Ku7AACSnwitrU1kB2yMEybIM0MtbANg+5LDGfIh5FiVk74ZEKMJG?=
 =?us-ascii?Q?5+7kdWHhXqo1l+3hmjBFOzovOoXZW0PPI4Z05+uaQCA3BTpxG6mJhOSX8M85?=
 =?us-ascii?Q?Y8WnQmO9BBP1cAf8H06Ppg/2lDxGqkJZxP+0F9FsZSdx8T1wEnZBl+JVarqx?=
 =?us-ascii?Q?bw9Gtnfnj4dH2HDSYWN2HWxpfwOyRidBIWlOz0ce8imVt3NlN653nBdIYqy6?=
 =?us-ascii?Q?bvWE8gFLzeGn6Sr0yRHE8tr36hZf4mHz5lw6pFtXRiU+WNmwQB3QpGlOaBvX?=
 =?us-ascii?Q?HKzlctZvr/GmLMYEDCJ6Esenpd732zChL7TKBVz2tupFROGGka7sFr8E9WiC?=
 =?us-ascii?Q?R9JjSljqH+iUUxSRIVqiHEQMn1+d3YOanW78r1Wc3/sLLiXr1dCZ/JJYKIDE?=
 =?us-ascii?Q?5HAYr2FOTDFZkIZFo/Nns4xvswVLRu3zNKGkzqWQO3hMbV6FhIaGJGs/VZbg?=
 =?us-ascii?Q?dKgNmdax65yC6JkP6jyDthJKuPFLvP/lOw+ltxYT5X9thYMmPDxHCB8141Iv?=
 =?us-ascii?Q?/adJqm08DDNYAe422RXrlRx2XUsmGEXZGQA//dBWNz6IBaaceRBROk6gZtSW?=
 =?us-ascii?Q?7xbvf/c7WbjY1CRZnusycySrNlk3BUlkf1WcVgx2XB9NPCaOZwEFm4MBdyUT?=
 =?us-ascii?Q?cI11VU1x0tNyfASCdxeTeMytgV1NLNOEMGzekpq4Ht54rsIgRSxDdQliQlUF?=
 =?us-ascii?Q?dfmoo8RbUz13PiANGPhNjKFFCi2IATBRb2x1XF1/YmGHYIMVT9bDKotIL1D2?=
 =?us-ascii?Q?8CaFj63bBauas3cafkSwg9rAgIOJ72VZeJRKm0ZHizI4ydEuINRNUYqhS5jO?=
 =?us-ascii?Q?p09JYXGpxdqOgEZxNvTv6/Cw5HPLsdKhMuezFk3QsXNxg/1KvypIY+WNOJ63?=
 =?us-ascii?Q?PfkcKD1lBhBlAQ2AryrRhnZ8TfsrQAKGpaap12xUkPYorwk9IQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:08.7380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3dcf3d-2630-4483-968d-08dcfdd7cd94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401
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

From: Leon Huang <Leon.Huang1@amd.com>

[Why]
HPD error status does not cover Replay desync error status
while executing autotests and CTS tests.

[How]
Refactor the checking flow, reporting the HPD error based on
different eDP feature.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../dc/link/protocols/link_dp_irq_handler.c      | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 96bf135b6f05..48abeaa88678 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -221,21 +221,11 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 		&replay_error_status.raw,
 		sizeof(replay_error_status.raw));
 
-	link->replay_settings.config.replay_error_status.bits.LINK_CRC_ERROR =
-		replay_error_status.bits.LINK_CRC_ERROR;
-	link->replay_settings.config.replay_error_status.bits.DESYNC_ERROR =
-		replay_configuration.bits.DESYNC_ERROR_STATUS;
-	link->replay_settings.config.replay_error_status.bits.STATE_TRANSITION_ERROR =
-		replay_configuration.bits.STATE_TRANSITION_ERROR_STATUS;
-
-	if (link->replay_settings.config.replay_error_status.bits.LINK_CRC_ERROR ||
-		link->replay_settings.config.replay_error_status.bits.DESYNC_ERROR ||
-		link->replay_settings.config.replay_error_status.bits.STATE_TRANSITION_ERROR) {
+	if (replay_error_status.bits.LINK_CRC_ERROR ||
+		replay_configuration.bits.DESYNC_ERROR_STATUS ||
+		replay_configuration.bits.STATE_TRANSITION_ERROR_STATUS) {
 		bool allow_active;
 
-		if (link->replay_settings.config.replay_error_status.bits.DESYNC_ERROR)
-			link->replay_settings.config.received_desync_error_hpd = 1;
-
 		if (link->replay_settings.config.force_disable_desync_error_check)
 			return;
 
-- 
2.46.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149F9D2E014
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC69210E725;
	Wed, 23 Oct 2024 04:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="imrsozGF";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259F910E725
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+5qECuZfQAQUxfblMmXViXHyilVMbiZWxLTb0T6Ameojx1eT5PYWFu7syH/DIn4lXnbvI620fibX2Wn9GIuXF2npBB7jbPO2mk+QeAUcVNPWbcC7EbX3UkEOZo7cUBwRnBM1Qdcw9+PTlBzvHJ/lCbjsen6wZuu8IJmQPy3EiRgU2pZ9emiHqKxaNbqDIfPHFpzzoFy+0sJOA9PAsYeStGvI4sDfDeUFgoeww2QoRQAEYrho0L2vPqrugKWEE+kzPwTJhrpGeGI2PZENuAzpEgVQ3K0jPrqBGZnoZYrBNKE+ajMbdU28pWESHtRRFsMaf6Hr0EADLT8bdgK9+Ebag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vltOw/Ki76DZtFVybNfT6ZyCATActkYjiHCjzhT8g/I=;
 b=l9VZ1f84FSg4TTBQWvdJIMDW0xrAjoO32wHeAHzZ+z7cUPMaifDhnqy69R3/vkm1HNSh64Wy9eW1eUjMR1sZaUrVkWrEIDP3Nh/mwmTgXlcexV/sdUbwshVGs10z5GAWA0HeoId8U2eISfgh5K9JRTuqg6b29CK0BfzwXcaQhyAsyc3QElHLsrZOHkf25XFgLKqaBngSx57fHfE9onI10bMcymiwyXIMgmKgv2WWSMLlR1NDQm6K9fVc137cK/MyJDpzV89zqOmai2I27t7CGHZjL7p5UwCdPF0h+I5GQf6Uz0gsy+TAflaaJhdE5f5CV6+aczDbAXhQysSvseTt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vltOw/Ki76DZtFVybNfT6ZyCATActkYjiHCjzhT8g/I=;
 b=imrsozGFEeTfUJDQy3QvcEQX9Xir6MBFmW/xShf5D4VML4Avx/piXgJzaxgER2svVCKHymf71mdP/spbkn5QEz6zaOmnzGlY3XWsC23n1asc6zf7bujL/A+Z7+J6b1VUf2syHiBefmCmBPiB5rSTSxKkiMxmu+hrneW716TgYCk=
Received: from DS2PEPF0000455D.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::515) by IA1PR12MB6041.namprd12.prod.outlook.com
 (2603:10b6:208:3d7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 04:54:37 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:92f::1003:0:7) by DS2PEPF0000455D.outlook.office365.com
 (2603:10b6:f:fc00::515) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.3 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:54:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:36 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:54:32 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, "Alvin
 Lee" <alvin.lee2@amd.com>
Subject: [PATCH 11/16] drm/amd/display: Change MPC Tree visual confirm colours
Date: Wed, 23 Oct 2024 12:53:31 +0800
Message-ID: <20241023045336.1557443-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: f48791f8-2069-4ca4-a990-08dcf31ecb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cMJeG+9Nrzyi32ooDaiplXPw1TvTjT+W/dh3OYiBqH6oJwIFHo4by/Hjm+5v?=
 =?us-ascii?Q?qN0OQeW+yo5qw7bqRnEVAHvpIfo7TGqI11HgRTK7lVIa6H6hYYvERUqtaYuA?=
 =?us-ascii?Q?Js2fyM6pvoVao5PYNQJYLPswk92Ofw3/Zt3C03leoIrR7IWLcSEjC0A1rRS2?=
 =?us-ascii?Q?lxTRc0aWeh5VnFR5j9m+0yjvRSFj8hNJyrtPEQ2GX8Lynwm18KX3DSbvXXOK?=
 =?us-ascii?Q?p4crqcsxaPM1P2ji6OYgMxC+1mePGytWlqHqxmK0xPgL6g/IJNP/G1YgDVvo?=
 =?us-ascii?Q?BEfEDKay6XJxZZWlD56qUdQWVNyrRWon0HWIFsF5swP/zG+1NOkYwqw85C0H?=
 =?us-ascii?Q?TbDLtA1wVeRi1rxLsqeZle52kkL6WaxHCJhQVF8i//VYUt6q8xD40MX1ClZ5?=
 =?us-ascii?Q?cytpIvosDCmjZ3NtSzXtPKR5azz3hxUmB+x3ggA93TpHdi41MN3hQRR5znm5?=
 =?us-ascii?Q?Mx+UA4VxA65QDvHEP3mQSwshhDRz8TvQhPjPOhQQ9IZC3VX8zCYgazC8Ks2K?=
 =?us-ascii?Q?WL49nW7afxRy6lR5X0e1hH5ZaRAxPNTqNXwSVLkwzQLL+dWH3BEJ9dUnMugN?=
 =?us-ascii?Q?Kw2o2O/vwOrCpr0YhNYkadALfWGh1F3LG+GWZiWobHKB9ASGX8PkAcnG5SU1?=
 =?us-ascii?Q?Hs1xGkmb1A34f14RRzWW6zGg8AZSoyXlvPMZBlI0S0PDKz33SHWxJrzfu8wq?=
 =?us-ascii?Q?/6buD4WVja6uVRHeR0gMre6fT3yyZKl7pTDr+SG6NHbIcaPCh16uNqRzSN1W?=
 =?us-ascii?Q?g4XVgTRUhsitASHV8Rl0S4PZFQezM2Lq7SvIcVxXfc/MB/l3QpEjG/PG3gEU?=
 =?us-ascii?Q?13VO6DyqeVBO5C467oWJe4EIYP7CIbQ5PtpAsHSauFyceylarR97+LAR6M/z?=
 =?us-ascii?Q?HnX9UReQJru5drWDoCG7ArC7QB43vass5zteoK+A6tZJDLeTqL6FHwBeCIzQ?=
 =?us-ascii?Q?ukt+//PZ1CwXUIHYwZAdGV0DPtKHCLiLybENiAkurZgWOYcsSP8OHxZfT6AY?=
 =?us-ascii?Q?GqGLR3KTI5niFLkk0wqdzQs2cjUOj5ipMKjbiJa3yfQcJd2um2SayFLYiZdS?=
 =?us-ascii?Q?5IOzkIM+GH5yTKWVKYeV0zoLo8BAwlP3maBfCnFpSaTechXj6y373+rZcuX9?=
 =?us-ascii?Q?5HqcjRLVdwcd/uAPOwhLHmryWpwEvrq2i3A92m1lTHV/UxbVuvQMeO0QHqWN?=
 =?us-ascii?Q?EL7EnVOCMBm+BOkt6AX0Z6tvb4hiEZ7Q+MxWOOcONLge/7ONtEcJwZ6JMd2J?=
 =?us-ascii?Q?7rV5Y7TX7V6u6wL0c2ZMKesGb6veZk7frttGYtPB9UqFN53mn0egMHfry+u4?=
 =?us-ascii?Q?3532P1bpI2qXZxCKeh3BvmaaSnG0u0uSyrbFrThsNUea3nEW3SL979bgpQX7?=
 =?us-ascii?Q?PTltmpGukqZ2Cre0jvb+C+9dXRugpvjihuX5AuIJS/S1NmROLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:54:36.8881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f48791f8-2069-4ca4-a990-08dcf31ecb9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
MPC background colours that use fractional components look different if
MPC OGAM is in use vs in bypass mode. The current red and orange colours
look very similar when OGAM is in bypass, so the colours need to change
to be consistently very easy to tell apart.

[How]
Use colours that only have 0 or MAX values in each component

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 2fdcf8d59b9f..0419ee7f22a5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -312,11 +312,11 @@ void get_mpctree_visual_confirm_color(
 {
 	const struct tg_color pipe_colors[6] = {
 			{MAX_TG_COLOR_VALUE, 0, 0}, /* red */
-			{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE / 4, 0}, /* orange */
 			{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE, 0}, /* yellow */
 			{0, MAX_TG_COLOR_VALUE, 0}, /* green */
+			{0, MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE}, /* cyan */
 			{0, 0, MAX_TG_COLOR_VALUE}, /* blue */
-			{MAX_TG_COLOR_VALUE / 2, 0, MAX_TG_COLOR_VALUE / 2}, /* purple */
+			{MAX_TG_COLOR_VALUE, 0, MAX_TG_COLOR_VALUE}, /* magenta */
 	};
 
 	struct pipe_ctx *top_pipe = pipe_ctx;
-- 
2.34.1


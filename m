Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A8FC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A2A10E8AC;
	Wed, 10 Jul 2024 19:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iRE+wq+r";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D919E10E8AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=karUNeJSZwROAdYWXJaNL95Z/XTpe5e7UuB4Nz71KJXYGjM8hFGN6rcqZ4SxQ5LwrrXAFlTNoCqOBEf8hgX016w4T/Oq0XeakOqSwCX+zRQa7VNiBGE/mGxdgS0+liYAxSzz699NF4ltykzWXx7TGc102/2qygZZesmvL0TwDMGkfTNqLOO/OwvP1J/zfnQNs7hbuCRuG732PlepIc+dPwBurrc+XI11zLsXfDquGIZwvBCUfmQobXxcRh7CmrAVdOuVQqZauOSR7kyXucUcCDc6Gb0h8T6GQeYHCwBrKi5/WynFk5lWCMRafvNRocaTJBFFB/TgEa3UrtW9aqKRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rlgCobSrTSlnJP0rX2h2FfHGXGIZ6jAQbsWt2s6tEE=;
 b=A1iTz9Y/tZ7xzUI/en6Pm/7rC5vpXxzl8BwU1qhaEwEv8RJrVgFAhClZKQMvLCH2fsIv0RI1GYrXLfhKEeHlVp84s1/NIvIzQVVAq141bcYcrChG6Bb3Nvf0blDGAtWGZboRZZjH4Q34381iZY2PXMUnp9JWLTkjicadwNPXp14Kc/9UEzI6XHLW3HLVFxUqFbDLCxG28exFfND17M+4cc7X+uMbKnf6gYS0j+k68yyRe5py95fFOHFbqaZzsXwnYWTjvC/x4buBBX+nRpXCnEHo3psc09YTyGYuti5LB4B3l8ucHkftrlQV3op1ycDmcWmDl0McnpfHjh/q3PxlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rlgCobSrTSlnJP0rX2h2FfHGXGIZ6jAQbsWt2s6tEE=;
 b=iRE+wq+rHuNSjwHT6paSeeq86/7iO5pRZiiJ95fOhBFzwo2f6Q8hoyvq1rytkixGFhEf7dkfWIcJAm6Xy/rqI+alCEYPhpZEC8sKcV0/X9o2Re5Obw+mRdQ8V6DXutn9qiEljMumETcARv0hFV3if30qGiOTcmbonXepYL028S4=
Received: from MN2PR22CA0005.namprd22.prod.outlook.com (2603:10b6:208:238::10)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Wed, 10 Jul 2024 19:38:28 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::6a) by MN2PR22CA0005.outlook.office365.com
 (2603:10b6:208:238::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:27 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:21 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 17/50] drm/amd/display: Initialize denominators' default to 1
Date: Wed, 10 Jul 2024 15:36:34 -0400
Message-ID: <20240710193707.43754-18-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: fe35a313-98c5-4f9f-856b-08dca117def7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hzV0VHOydOL/50CsuKeQGOlt7gS4IH3evItIj3javqOkalKVhDfz2MDT+vr3?=
 =?us-ascii?Q?BYVqH0GwMfY3MI/2UhOsM/nmMmPFXluKmBJFQW+AGAt1KmDybYOG4YzsPtcR?=
 =?us-ascii?Q?mRA02z73l9a5HMHE9TtuY0sBIlSWRO7EyqtFe4k2rDZskaRo3dKnY+TdXCxD?=
 =?us-ascii?Q?dWcJ750e6S+fnPO6cm1L6FvLI140ILLxpsqswNuMiFgsvg/hqMJWXiQLm0kz?=
 =?us-ascii?Q?ePAA8PMcSSKpDqZ1NzKS30dK/Qs1AK7eSFixu4s3vejpLHo1MsbN8OorfZVc?=
 =?us-ascii?Q?aDvP8x2eVgxkAnfnj+AEG312pifWGm4LKKdJ9rnNfd6wKJQs3S0aiCd/jjgg?=
 =?us-ascii?Q?weRQARl52sRuP592C6iwocpN4jCI0OjyFc/hbow7G1FcdGJmVFi6BlcfGrd4?=
 =?us-ascii?Q?6WsM9ke8IZ+/LfK7QHzqzY4m2uqeswKkn7k0BNqboPTr1kbQ1XyLZcGfLGY5?=
 =?us-ascii?Q?3oCyjO5XBZWeWmEJ3cW/QkMtEYvD6Tj0thQm7RGpBA4Sg7r3xDF4rBhs5yhI?=
 =?us-ascii?Q?xdTcr7Qee5GArIrgJ3S1OpJxRAv0MGKpX3n+5fZwBj9Bm+4GreslqxJfSBvd?=
 =?us-ascii?Q?yExrHLRr67YLyZDcjWBA0IoztAeslaAR6m5V4HEUuNezbY1lrBAnAuGmXoHM?=
 =?us-ascii?Q?Q5TKjYua1zQpo8LqVNiIGhIePGaHE1zXdJ5Tza1goZOmXofrYy9tcrSOHt9i?=
 =?us-ascii?Q?n+YMh3TaN93MT6dJvwwrJ3uUiDg9ISJDnzcoywTF5SbBGhjxmvOD9Hsb5G05?=
 =?us-ascii?Q?3DQaoP2dtpmx73YHxVeX+f7Cma3va2amAZq3W3XaNdN96/M6ip6bucm99AUn?=
 =?us-ascii?Q?hN8ca2pGdBDAVzuDxAx0dVXjRP6qV+Gr2b6qZmZK3NH2mexZKIXhPRWAe1Ry?=
 =?us-ascii?Q?gLevJfKeCnKwmDVes7dS1Lycnrjhiv1NSZ/f24hAA9qaXIHxY3/XVJcPx7QR?=
 =?us-ascii?Q?9mHezoV+OfjFRnLaivA/Uwz78RXNIffqKEI3S0g/N35SZJBEv+ajwQpBhnZ7?=
 =?us-ascii?Q?Bo/Trp4FQyM+U7nSyy/DhMaO5iuJxUU0X0owT7/+jOYpJDApLUqz1qDR82SO?=
 =?us-ascii?Q?OeQZU1eZfDWBbPIxWg0tAjHPKkiW9DNIwMNXITWGGIxT8x+URBKLsqb3IuWH?=
 =?us-ascii?Q?cRM6Ui/nU1P6/vayGpf1QASvtOc00I4JjPOrj6pBFYxWSnGj+SEgRulOv5nO?=
 =?us-ascii?Q?T++dqXzWTOw9RMF3GAH5B1kc2PiWkaoHlfF9l4XJJfaSlvvpmjLV0vYo4VK5?=
 =?us-ascii?Q?4jWnZcaLsdNRxPGkZh6HFuVFRZ+egf6MDFEBwiyzz/sSXjDJpUlhYdmIXcay?=
 =?us-ascii?Q?R3XdLy1mzPrFLcbnPQcYw8NHRm7KCHiJ7XbOD8dojiGPalq82VwzpX7oygZN?=
 =?us-ascii?Q?PbWATfp24PqyTEbzzd5Oe78qLu1s18A4mFdc8YpSkjULKRz0Plz1ip3P2tqK?=
 =?us-ascii?Q?NYOKtf1QSB6Mk88tKrmVWAMNQUMMBHIE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:27.4976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe35a313-98c5-4f9f-856b-08dca117def7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
Variables used as denominators and maybe not assigned to other values,
should not be 0. Change their default to 1 so they are never 0.

This fixes 10 DIVIDE_BY_ZERO issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c | 2 +-
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 7c56ad0f8812..e7019c95ba79 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -78,7 +78,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index dae13f202220..d8bfc85e5dcd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -39,7 +39,7 @@
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
index 81f0a6f19f87..679b20031903 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
@@ -9386,8 +9386,8 @@ static void CalculateVMGroupAndRequestTimes(
 	double TimePerVMRequestVBlank[],
 	double TimePerVMRequestFlip[])
 {
-	unsigned int num_group_per_lower_vm_stage = 0;
-	unsigned int num_req_per_lower_vm_stage = 0;
+	unsigned int num_group_per_lower_vm_stage = 1;
+	unsigned int num_req_per_lower_vm_stage = 1;
 
 #ifdef __DML_VBA_DEBUG__
 	dml2_printf("DML::%s: NumberOfActiveSurfaces = %u\n", __func__, NumberOfActiveSurfaces);
-- 
2.34.1


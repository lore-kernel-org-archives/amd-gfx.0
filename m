Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CCEC52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 21:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA95910E6F9;
	Wed, 21 Aug 2024 21:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GhY7Id+R";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ABD10E6F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 21:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACjfBsFPfDmokDSlaWGsR8AxQE43NfBO6xk4wXYyUiCy81i3dvGC5A9QpeV949sEE4J2+pKjzRP9sRmHh4c/XzsJjBaeORHtj2oW1F0bsTLb6t6bnadHgTsCZ9zbixF7A2KE+pZOJNi4Qh2CoPSzsCDuziX4Mw/Aq7XE897rwJ1vJiTNCs6LA+w3zpIR48CxTJrL3X1oRIL+cTakeWm7/DAxPSWj32ygr3wS6f12s+2Pjt6Iff8BSpbCndyF8C9iqrs0yr5pg/2TCHiRYSxZDvS+0RF6sjFT3VS6xI9l5f+cKR+AzznZMPEPoVLgOcpeFzFcmak7Hab3L+9z2iMtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8NeI5/dBzTNdLTyM8chwgiXFpK1s++JjrdPUa0VDlY=;
 b=m9sLMtZJ7B4kEmU3U7Sup8humj1DIBhQEfjqZeDyYjh4q6Ce1AbOZquKGzJ39PssqeWVUOtccluceuRwM1vTOHYSN9gKIguQNzKJvkcOUrleGyoA01Tku+ic4TsPeYL1IDi5eIEIwaFshRM8v4Vfwdqt2adq/jxqJdoafeorQUlYBnHrNXfRZZMgmi15QjvRW5z00ZR/yYEE+Uzc/DRAF2JBU62K5mQsMpdZiVy2LmNJes2j/RmE7igJBvIkeosa8iPG/th7QnRGv1DJ4klKbfzaTp7r5fjOEmyPcQG2PBjpsVRsOkbIlEQssO4hOlk+Sm6REF+Upc5FvC2sTep6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8NeI5/dBzTNdLTyM8chwgiXFpK1s++JjrdPUa0VDlY=;
 b=GhY7Id+Rb0cQAYsM+oj6AGPOXnVsfWWTfZ6/6ALx+wskpBepYV1mIVSjrKBWj69p8FGaVrIMrDbmflb2sNxSCgctyK7dcpK4TLV6he9tBYjBHV2b0TrE1/1ycRUBncaKObVLxQUvWuKQ3LXYcja1f5v9DTY4RRu4NUGFdTrKXc0=
Received: from CH2PR12CA0019.namprd12.prod.outlook.com (2603:10b6:610:57::29)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 21:52:55 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:57:cafe::9) by CH2PR12CA0019.outlook.office365.com
 (2603:10b6:610:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 21:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 21:52:55 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 16:52:54 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, 
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Don't skip clock updates in
 overclocking
Date: Wed, 21 Aug 2024 17:51:58 -0400
Message-ID: <20240821215213.1496781-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821215213.1496781-1-zaeem.mohamed@amd.com>
References: <20240821215213.1496781-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f47d9de-3103-4c12-21f0-08dcc22b9d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eIZsZRFzXoM5CuueItxpMELhayobMB/RK4wdGxLtMu6419s7JVXlfbpO9880?=
 =?us-ascii?Q?sSBnYDbC5d/drB1U7f2Wtu0ec3uGF7PD4rFTuCekHmTHY5Jhci9D1LnMwzzB?=
 =?us-ascii?Q?0ZHG/ZRI1KHyh4x+P93hexk/w8n0jr60/rcvy+6IFf2+gODKAuB/bCvgXTzV?=
 =?us-ascii?Q?eK7E+4qPdikWwknVxI2NyxOW+x/X+pXoMo7MN32ot/9lzMg5EgzqZtlNGdBl?=
 =?us-ascii?Q?Nsm2kGyE2K3wLwKwzDPAFbnzzVBIJbzL4P2Bn8kmORp08cl9tYR83piJgBKC?=
 =?us-ascii?Q?qo0MQ+f5LzJVTzN8/WgCgIZ7HScJPeAb23YERJa8hiq5FTecGjDU6ugqkD23?=
 =?us-ascii?Q?sEsp29wV2CpEWXigRlyALAHVGzsEyyrDNCxO2lU2b1LvL5qNBT//08+3ez+U?=
 =?us-ascii?Q?1m0eElKu7mq0FbwA1BpY4P1oe0ahRKQWynTXMq8cT3124ixWDJ9BB7d2O/Te?=
 =?us-ascii?Q?i69H9xhd5vwjO6HyyDZZmaQWnwz931wt90zDnUe63Bhyc/pDQ7amB+gNgV54?=
 =?us-ascii?Q?IoHrHph4hM7uICbwSdoy4vNlqDpwOvVn3krVscu9G9mwETvrepW8hdXjnklN?=
 =?us-ascii?Q?zuGu6kKZot/2LjOrWD4cxjI5X4t1vkIhjl787PH32WsqjKAuBcILsonl+Wa/?=
 =?us-ascii?Q?ZB+o6sTH0euNEc1pWI76naqvYLFeTNWmc5V5RcOnDyIm3IeCQsNmsi2W0kHJ?=
 =?us-ascii?Q?dW//U0iWvfIjeJFvJ/DYfBxZNWBC/X8IKd7BpNiT4TMTr++EpMSwzYc7EoOB?=
 =?us-ascii?Q?QnqSHKWL609QOfAS5jKTjE9BvzY02tQVEwSghicmykNZnxJRCnlXUhvnkt0I?=
 =?us-ascii?Q?vjPvFJRa+mMtoWgP4IJMhu/4TEQFZ6eVOqWeCNJHZBADHa1KPC5yVROgZGvN?=
 =?us-ascii?Q?K0Eh7kX9vf3lW7SqJjoN7UdXkFkJ9zSAeo5jQCzXCmXFm4xHhlQjHw5daQ0K?=
 =?us-ascii?Q?gjZDeYrfJ43TlVdkbGxZR2l/DKpC5i2lFDQCFsGu2g2BzRCqsNZ9D+JlI8/M?=
 =?us-ascii?Q?B9/ev4hakfwj1tMxQ+cCdjT6m2zHhPr0fHO3syme/R4TgjucpyE2+qGYGnM+?=
 =?us-ascii?Q?Sjls4IsxB1HcQWM64poOOsJZk9LK5d3Iujohxw1lF/7CWJjNzCvz1QIuirBG?=
 =?us-ascii?Q?WqdzEsWOM62RkDw50kFd11S27O+btFdhR7EPKMI2BFTW9ShkcrzgJQqsanqG?=
 =?us-ascii?Q?//GC9Ihp3GE33thpSowzqsp0ATW22j2mbFLk3Jkx1tlZ/APsX4iai1n0hr8M?=
 =?us-ascii?Q?668kEHsSoXo2jIAxq3znG2w1zrRrMBUKV610gu7oE6hzPm6S08kyICK4J/Dd?=
 =?us-ascii?Q?STPN5hOk4djJ/RBzf2ShvxvpX2gcDvuiyfL3YufnDl7uIARyQtR1y8RB+Ayt?=
 =?us-ascii?Q?8mNx/6sGEPbAahT8cbQKMLqMvYT6Hcq4G7uituVBmEsAQ9jW1YxD+5RjrPZG?=
 =?us-ascii?Q?F7FRFIOvCiOouxi1/omjpVcnPiIQjiLG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:52:55.6504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f47d9de-3103-4c12-21f0-08dcc22b9d41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Skipping clock updates is not a hard requirement for overclocking
and only an optimization. Remove the skip as this can cause issues
for FAMS transitions during the overclock sequence. If FAMS
is enabled we must disable UCLK switch on any full update (which
requires update clocks to be called).

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 01ea3a31e54d..8cfc5f435937 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1366,9 +1366,6 @@ static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	unsigned int num_steps = 0;
 
-	if (dc->work_arounds.skip_clock_update)
-		return;
-
 	if (dc->debug.enable_legacy_clock_update) {
 		dcn401_update_clocks_legacy(clk_mgr_base, context, safe_to_lower);
 		return;
-- 
2.34.1


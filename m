Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187B7CD343F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EF310E796;
	Wed, 12 Nov 2025 18:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q7C6Uh8B";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E4810E796
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHB1OKRhxuOHbj/TycwOqtMevttJhFWxra/j0/oM5DLHqe9iZjVuSWaw1/f9JtiI2x/ksAA0fim2yXmWwH0hJRWx4lmlWVDRq3N5WPQIsJw/q0rJBqW6j8G8/mdfOZYr7nruXkdfgef5ricxOko4/fSlFfIuTqTTkZ8HypZMMVnrYMFWgrPRQQ0QHtC0C2j5z97cJccXDOKZyHyVgCViEzgVXmHcrjZFAL6IC/zv9mPzlGW/+KdyQ8MLGOg1e/6Ky756geBkulr2lqar/EElExnRMuWbK00TBDBINW/oG44yu6oVJjo5Vsnk8jRfNkxT1iyI7niQeQOMhtce25purg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQ/NprwyLUSYx63//X2a4j/XsxHqhnn2ts0a7Bas8QE=;
 b=GtdVQ4Y5O9L/TNR089KcLxTB52EPW+heu2eMog5HXSFEw6CB7lGJJe+icNM6SMWvQAGyKsLCxnh7MhWJFTAvbTYEB/7IQk0LazE8eg3Qu89v+TOF0Zvg7SL0vzrCG3mu5chsxomUPLJbXceZaUnhlall+Y9rHwc3K84ZIMH5CZNgUsWfYbHxA3dT8S8VC8wlxtQ7hl8a0V9wN4gs7p+CMJ7tdgSg8jPEeRrAwXsfZD4ZIQmmFzoiVQeDbb8E5tcK7FEj2fQvfFcWhgoqQRuVTYuq2uD/XQFdkiDxdWneX2kFfFZe0svZF3FD0zCuEb/VWXMm8ULPE/42XYC0/q/Pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ/NprwyLUSYx63//X2a4j/XsxHqhnn2ts0a7Bas8QE=;
 b=Q7C6Uh8B/It6+1D7kSsgUipDs5BW7MN6wj5RurNfR6/dkuu+hSXrXLB09/iuT6a9yD/GeDJHGeR2OLtUEQJBZBDZxoC9y6vFiLfwr73XTq0sYQdaopYNF1YNLNIOoJdu4vQoaf4BZNyi/HwDEwUPv90Rgp6CRKAym+b7afDx+6U=
Received: from CY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:930:1e::22)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:23:21 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::53) by CY5PR04CA0019.outlook.office365.com
 (2603:10b6:930:1e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:23:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:39 -0800
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:38 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Paul Hsieh <Paul.Hsieh@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 06/16] drm/amd/display: Re-check seamless boot can be enabled
 or not
Date: Wed, 12 Nov 2025 13:20:24 -0500
Message-ID: <20251112182212.559007-7-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 470fb18c-99f1-4bc6-278c-08de22188f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E9UFOTziMtna3icc7PgM/thFE2TltWLIPi0ycDDEhW2O2mc4OrNL5mLL4B75?=
 =?us-ascii?Q?JkljhSH0aPBnOX1oNDMYEbdDJ2Z22bq+SKY7Z3QXLn6nZJ7ORTEUWXo5ltlb?=
 =?us-ascii?Q?B7C8MY4Sz8mGgcl/4OyVMVWeMi+LEjynJ+aba5lmt++5Qygj5pRvFbQhSOHq?=
 =?us-ascii?Q?+RCYcQDpIv4VM6I44c6nHZuTJMaF5YVd5dWgsfaLUmqN2Coq/VwBXaxirEZp?=
 =?us-ascii?Q?ZUe3WevXYmpbuLSDJd9NWqMJ+V6jdAlChh2fm3LSq9oXYtnTYbX1DXICTgHz?=
 =?us-ascii?Q?GX0IYURpt4Ph2yqaPbscAuL2RxMZLgUl1Qvh8Ce5lU+O9KbM7vpvc9L/ibCz?=
 =?us-ascii?Q?XLjED2mI181XHQA8bvnXBvWJ1zRr8sml42agTQtLhRRZJ1VvuAAQzfcJ6eEb?=
 =?us-ascii?Q?MiGGgQ6mTQY8Oh1B/F/E7ZMSgZ5ESTl6ym8C7TrwMPSCZsIYZcspdR+PsV99?=
 =?us-ascii?Q?1hdJHNHXcF6M+LdA/QqUI2KvrCitCOBSY8fH/5o3D2NX9GawP4dtJvIa4wjy?=
 =?us-ascii?Q?mbNzAze6knH5Iw5W8l+KgNJStHp2LXBiCxwfIiqRkr2WGkIz36LMWnSrj8Ac?=
 =?us-ascii?Q?nHShvPw/SNghSyyVMYaykbQVbbgwrXNXTLEYUTS6XvF3W1dRnmEsBuWs9LcO?=
 =?us-ascii?Q?E8ZdwAncMy5RZjOBHmqsg7rmPgpusYr+t+lEMvKNND/9AghE91wS89wXURgS?=
 =?us-ascii?Q?tE/hs8MVOWvpVEJYX73FXZFmRR0Zeee0TM3qe7nAxRlDfjW63JR18WLb0yoj?=
 =?us-ascii?Q?XT+NBqn0x4HEv7CcCHdw6lz5kbwpveZ7ZaTnjYvy9NCwMtaG7qUnT8kB1UEW?=
 =?us-ascii?Q?KsaS8N5XhrSasgKEGPhQ0V1Dc2iZkuSVJNcSMGsDSbgSW9ipwDbY8ep4P/mY?=
 =?us-ascii?Q?QygXHS249a7crxHVIbYYWmrrXoBlBniqXhxk5rgUl2hE0YIntPHAZMb0pp9H?=
 =?us-ascii?Q?PiZp56sG7OK9wC73GJs/WCoFUtk9rtr6ThmEv4xhxT0H4z3Yo2iSajOxOWma?=
 =?us-ascii?Q?E9vVhbsdIJLazmE5IZysQr1G1wnUx/xK+Qh8DXoJcAYdbL2EE9Icyqyq7EMU?=
 =?us-ascii?Q?JGNWRGhopweNR5ykxSFU32ah2TjjAMW+nELO1eYh/PZv17syQmHDHxnC4PFL?=
 =?us-ascii?Q?QaxLJPTvxc7p9kbMIg1HQnVyQ1mujjVusA8uddcsheqy0xUdVryxGRfQk3Be?=
 =?us-ascii?Q?+q7oO82C8f/SRhqeUw/xTZEwJYnAG0ir9wRvGDGchJlz5/YqLpw5tB0NNLoz?=
 =?us-ascii?Q?FvyQety1aB8v6aOvM9Vi5c2b5BfXmeVxK39l9bWI5GWSXRzaAweLv1AVfhhS?=
 =?us-ascii?Q?yCvyHGLSZMHccQKnGbnwTwphp+NwQB6/MAACrDBMgDkw0lrwns+7TFT8Ooe8?=
 =?us-ascii?Q?uLxNDGn0hZiDyvhf++ax0oeoXGlVs6USkEijDRoYzWkKJudn42NHgodH6rxA?=
 =?us-ascii?Q?XL6jR4d2A03VGm25BW88zNfsbvPz05mBxubB6TEncWcfPYE56S/ZmosbAE04?=
 =?us-ascii?Q?xhtegelpKp2Vjgh1A3AnJLb/v9/MjwA2E43dIzXu+1jujxnPSEsyUPijISH9?=
 =?us-ascii?Q?MsZrtKrbxDTFh9R2tqw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:23:20.9103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470fb18c-99f1-4bc6-278c-08de22188f2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
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

From: Paul Hsieh <Paul.Hsieh@amd.com>

[Why]
If the seamless boot feature has already been enabled, and
dc_commit_streams is called again before receiving a flip, the
driver will adjust the engine clock without turning off the screen,
which will cause garbage to occur. However, in reality, the Pixel
Clock from the first dc_commit_streams and the second dc_commit_streams
are different.

[How]
If the apply seamless boot flag in the previous stream has not been
cleared, and dc_commit_streams is received again, we need to recheck
whether seamless boot should be disabled

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Paul Hsieh <Paul.Hsieh@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0da36b5f5556..5b8b55c1dc68 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2147,6 +2147,14 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	if (!dcb->funcs->is_accelerated_mode(dcb)) {
 		disable_vbios_mode_if_required(dc, context);
 		dc->hwss.enable_accelerated_mode(dc, context);
+	} else if (get_seamless_boot_stream_count(dc->current_state) > 0) {
+		/* If the previous Stream still retains the apply seamless boot flag,
+		 * it means the OS has not actually performed a flip yet.
+		 * At this point, if we receive dc_commit_streams again, we should
+		 * once more check whether the actual HW timing matches what the OS
+		 * has provided
+		 */
+		disable_vbios_mode_if_required(dc, context);
 	}
 
 	if (dc->hwseq->funcs.wait_for_pipe_update_if_needed) {
-- 
2.43.0


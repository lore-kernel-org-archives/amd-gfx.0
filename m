Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663F4CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064CB10E6E8;
	Wed, 29 Oct 2025 03:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eOgFwUp+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC7110E6E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLc0KvWHImURQMmThGAqMTlQlF+S6d3Uv94MlopiZieUHtU4HlZMvxcdzpaCQrVJXNynWipEMQhK+0UZKPUhoOfopHZqzFVfAb2aMIR2mtMz+uBdRIga+i8de1gSJ5wSXYN4zjGlPB5JJEA+M47GbIMZERQZRDz3RPUCNb9Bo2Xkqr9Gb9GniphdHkyWdqNs/R/+iYYS+HFd+jZ84RwpTVshEec8z2+jt6y36WPLAoaYl72j8Z4iGqzLpVOheoyWynKh1pEd9s08NijWoRqkcKeamNJ33A0MzLuzGhXhjVCmMhTAi0I/S4RyvuPZQBp0FSXdtadbDGJWGhpLe+8f2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtPBahkXcMYULEOAVRE2MlDeQ57S9CgHhMAA4567ykU=;
 b=SxK7fnFek+7VdXqLLcyJJs4b112aQzn2mJEC+Hk1LN4tiCU80bNBkJ5zvthkvdCkriikrDy/8ByRhKUAwAXA5dfwfj8/gwuhHLvcaiX4ELNMF1zx7zK/3QQuDP/hU297QBL4mI/WGqj1BYg4q57mwPM36m19AUx6bSVEfwK5vu8Z0wxXZ8COpexbMwghH1BXuqPRqUjOdv+DDHQQpoGng2AS0IoVtQB5nf4/HOvJb+hscCxHcOpJi5d3Y4+b+1q4XFnvQkbrkJaLhT0xplCRAfimCgXzdkoXJF/+kQnCk0payao6ymUlZmyyfGWyBnUpvpWmdXF2ytDCRfg5fK7nEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtPBahkXcMYULEOAVRE2MlDeQ57S9CgHhMAA4567ykU=;
 b=eOgFwUp+o9FYIXiWiOlhLWk60Gwb9tgceOBYwvrOYaAMk9hETj5CPPx4+jrTnpj2U3OsJh9YHmrb2P8tlld4CWDWqc31I9+peA/2xB+aWoaDbp2S+M1brPIIfz2SwqACHpFGU2DaKumWa5YmIKy0eBG5XOjOi+Su9aNHUJC8PQw=
Received: from DM6PR02CA0161.namprd02.prod.outlook.com (2603:10b6:5:332::28)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 03:11:33 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::34) by DM6PR02CA0161.outlook.office365.com
 (2603:10b6:5:332::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 03:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:11:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:11:13 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:11:04 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 07/13] drm/amd/display: Add Pstate viewport reduction
Date: Wed, 29 Oct 2025 11:02:55 +0800
Message-ID: <20251029030935.2785560-8-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: bb331b2a-385e-4091-6650-08de1698dce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JFGH9/tu7Zl4UHTpFIg5Y6eBY3HHNNeo27nFTWHj3XQlXMhAmrUehOaW8RpH?=
 =?us-ascii?Q?7iE5c3Wtddh6XSgmnreePgHomM/r7bLzDDpDOSiySSAtsaOwqV1OiQIfVd0F?=
 =?us-ascii?Q?FQKcjKdzyQp9MndxFjVwRNrU0XcqiaBmm8b5IFqrpc41hIfVtKV5zWbrtg7p?=
 =?us-ascii?Q?pux17NVo+PBeunOlSXIxUXmAUljBWSTdxtmJ7OeUBpxTTWpIWgp9kD38/xrs?=
 =?us-ascii?Q?VjeZoj2ufBZ+aaHcpMNj8R/4TpKkzLhf27vTHqb2fiD99ejPE2HiW0LYyA7T?=
 =?us-ascii?Q?lliYlwetWwL73EY/y+UL+WYvMrZIYSC3NN1VefO11y7U0it7qjB2NMme0mvi?=
 =?us-ascii?Q?9cg/H1lfFJD1EUc4i9yahHViRKbTn7pKnqv+9LY/lCja8yPPAfvB4BXUBk5l?=
 =?us-ascii?Q?m+ChDmPJqHkGd8f4Hn6cWBHDJzsOvwpA+0/CErIImwcW5gjKH8yf9epAvo4U?=
 =?us-ascii?Q?1mnv2NSM4hypvSa36x5mSgpfWdcMYeb09/vq2pB/9lKPwNLrZdGijbZ/ezWX?=
 =?us-ascii?Q?TnzApaGItBPHKIxZ4pm/ts+hV9gl6bAdLdFnB8qiIJtqee5tbbM0gujwpT1n?=
 =?us-ascii?Q?yNyU9hM82pArf9ICFodw4Ym/vt3q342l2n1YKjWEYLizmG0/INugbjf283+6?=
 =?us-ascii?Q?zRBFejnRrqf8fN99uT62Qsq/EXX9xmMZ1Ykk05gDX5fm22x2/l78KiwPkCtL?=
 =?us-ascii?Q?XVX0pe+Rus+jMA6ukKfTMbkdAkFBnlibWWc8eHfFmrR3D1DTklh3CAyePJC0?=
 =?us-ascii?Q?NtjcGGrCLXfPs3fUR/lsx6qqmjaAKcGJKQNcTSpeLBa+MqN2w0ZnWGTmwuGY?=
 =?us-ascii?Q?INt3ArX0SZxbgpXJarGn34TuXIrkFQM5xV7oICreaRWc0RAjWBz630SjWPOI?=
 =?us-ascii?Q?6aMQN2mfCMLRiGPkLLUDNmkdRSmHaU2aJ7xcJ+eliSRuKt+SOPmqjB9wfLJK?=
 =?us-ascii?Q?wKITfPCo5sIYENDZK9sMxEa+y5CgmmqREyZepl1df3WkA+Lpi/N1G0gb/lxM?=
 =?us-ascii?Q?XubyicveToWo0d34JxA8S+f1ljPEqs8IOcdWg7wtdYkCxp4C3+aHUf4XnLfm?=
 =?us-ascii?Q?H2VmvsDf1LCMU8v+7MlD4pRVvaC/9un6om7A2irW3NHTDZFjyVDxoXMsCZhv?=
 =?us-ascii?Q?9rKg+nm+MuL2h6BJluK9F78e6vjBQtZsFmKu2qpNgFmLvYQ1cmrw2EAqWLBP?=
 =?us-ascii?Q?unYHusDdLt6BjmCmuOJOhzYAQ79/Ht7uFWSeJUavWO2zLSP4qPXWU0HXAzro?=
 =?us-ascii?Q?WJ83fcbJXdRrjQ5LEQ43UsBSkB5yOFX6WMl3jEDpsvZ/xfYjXvNbKadpcp1p?=
 =?us-ascii?Q?3cInLvOKwEOiANhctvLFKjFPrKxfj/ozDKSPcCPW9Wugj6LF0SQaEcvdRffV?=
 =?us-ascii?Q?lmq6LF2Jfx0evUIZZaXmjK2+4D7qcDosj7MpqUoNOiS9joph81VYxyDZM7Zw?=
 =?us-ascii?Q?aVRWZWNPsfHlBEa/FuhjFuMKua1lM0OTDJ/oVXcWc1cpjLNXUQ0mfwC6Ob9Z?=
 =?us-ascii?Q?vtjEMlkLCMIsc8M6yHNmBHZhMWQveKyRjyc+TiP3bnw1lPDPf8p7EFPoRjng?=
 =?us-ascii?Q?5ZRb/KwrHmUUAycVHW8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:11:32.9458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb331b2a-385e-4091-6650-08de1698dce8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Add struct to hold calculated reduced viewport pstate
recout reduction lines per plane

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index d2584b00a19c..452e4a2e72c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -676,6 +676,8 @@ struct dml2_display_cfg_programming {
 			unsigned int PrefetchMode[DML2_MAX_PLANES]; // LEGACY_ONLY
 			bool ROBUrgencyAvoidance;
 			double LowestPrefetchMargin;
+
+			unsigned int pstate_recout_reduction_lines[DML2_MAX_PLANES];
 		} misc;
 
 		struct dml2_mode_support_info mode_support_info;
-- 
2.43.0


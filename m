Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3B9C5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78BD110E21A;
	Wed,  4 Jun 2025 19:37:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wogOq3C3";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E18610E21A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0QSSZbgwT0rjsEzxxY7cUqAuX2Qz+Vt/3xTdFNmYtUL7+l0LB9tyyfsrY3FieqaocymSzRU+c9t89XtDaZg3KsYKxcc1aCXMUoPzoECru1YDHxOWuuKiJRR0Naa4uj/W8jlf6AKyP153QIdbFjOyYDujdh4tebqUDAm7tHABEDguf+PZcoq9V7BOhfwqxhqDGnvvGSBkszUs0RdqruHtx3wX6ACVxbHdSolJMFCpahROLM1/SW/bEpHVSB7n3KDwZcpgl86L27G541Nve9YR70wr5Wj7uXDbu4APz9g7PwPkSTrPUKwHanavjhJrFyPCMvMa7fhY7tInSFzzAZr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4aJY0H49ZZ4Mm/BF/GbggWgzp9wPWswnn2HwYZuyUA=;
 b=b2nu8MEC8N+nqtVg4crC/D86Ve3Quri/lVM/ZtteID2s5e8A6haT2gqGd8Yxpp+rTcCTf9//gdGQuFVeBsdiRjH8NW8eaUV9OZI+5w8FfjMpgfUrgJx4R1oAdYnaQuR1AUDkv6f8UdUX+IAswIrVf1efRWsd1kVNnTIFHx5Al/ajI1o2sa9ulk+cgVkTXR4F/qHQY8Dy2TpLtbHE0zkhqO+M9O7dYeTkIUG2sEXL1lWdIhgyBcXlQ8p0qyKGkGZFaCcJFbqSjNrp0573o1OPce5YA5dexGtr8P5zEueeCUEf4L03AgQsB8jGWNCSGEr3J4CQN3SJVAWT1vIAwFah7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4aJY0H49ZZ4Mm/BF/GbggWgzp9wPWswnn2HwYZuyUA=;
 b=wogOq3C3NHCNWzlW/adNX5N1C2R822GjGRFqDVeh1wTkQ85/Yd/5o0ce8/Y5PAex/+vzo0a2ZeSELSR+rUDIdMJWav/Nkguo2Mx3UkKdLGtZ7zMVyEmBZ4belofeQyLjTARIFNde1j7Byy+4Xj+iQg6A5QekZN06mnw+xeKc7s8=
Received: from DS7PR05CA0014.namprd05.prod.outlook.com (2603:10b6:5:3b9::19)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Wed, 4 Jun
 2025 19:37:39 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8) by DS7PR05CA0014.outlook.office365.com
 (2603:10b6:5:3b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 19:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:37:38 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:37:36 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Peichen Huang
 <PeiChen.Huang@amd.com>, Cruise Hung <cruise.hung@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 01/23] drm/amd/display: Remove dpia debug bits
Date: Wed, 4 Jun 2025 12:43:12 -0600
Message-ID: <20250604193659.2462225-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: cfffa6fe-0315-4596-dcd7-08dda39f43a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5+oL//E9tKHNK21AWjFZyHpLKad5LWrxjwn8ddnHJwJ1dDguY3VW4crgMKlT?=
 =?us-ascii?Q?fPeIZOb4raO3a4dvtTjFayRKWQ7lV5FD6VxzVJfqrSvIBI4bKgRRQJFkzEko?=
 =?us-ascii?Q?VfuIUOlS0pUj6U6NlMdoZu7PerAjrA2YpMlRsUdhgbFhxgWc440oeUpP4Qpk?=
 =?us-ascii?Q?nwsZhg8ArmjUnbUwXSWs0160GBxuOzdk4TzDbgsUYiJA96n6K6oGFCXNJOKa?=
 =?us-ascii?Q?kEG0mG81gLgS94MEorvcxRg7YMAc0r6ApYBdbO3Ykw53gXI9A/2sGW+ntAAG?=
 =?us-ascii?Q?kPoX3PpnirAKbvpDy9ZFW0bKwGdGHd04d6P/qOmWbPD0HOJiOpnA4/WYQWgk?=
 =?us-ascii?Q?8tXOrPgg2jcWFHrPhZAnj4GyORzlPENErtuOwJUVYOpwPpLOHT9U3rJTNpZC?=
 =?us-ascii?Q?/xBuj49Osqa2XS9HRb9uNN7ohjOAP2lgzscsh7aZIHQeOLeSgJaMl42Zlfwn?=
 =?us-ascii?Q?91Q2eY16RMzDzAtqeS6BP/WC4Uzxnz4LbSZ/Y9DOdCKO1fIJvLxEJ50yfl4A?=
 =?us-ascii?Q?eJrbgl2UQxed26uVK71vbgIotaaCcHcVNM4emU1FZhpohinKZIMIe1B24Maf?=
 =?us-ascii?Q?jaMo7rLPRHP2a2EGuVT54OsmAj62JMs0F7fA+SgI3uFUvEBDla6VN10Nw/ip?=
 =?us-ascii?Q?Na9XFKIJzpYU01rYeKMIlHFBVxgEwI4jQ5mAeyuUFi1koDBMXo8fsBsePqzD?=
 =?us-ascii?Q?nuLEXw3YZ954tuoVwo0qToJth03XV44pI0UXcD7oMMmiaPLCbIHVrlriELXa?=
 =?us-ascii?Q?GgNvq1apmUgBE/lkRaRREPQZrnhCJbE67fK4O0/5jhghjWkrlWRdgf/TMgGw?=
 =?us-ascii?Q?Vz3aIduouyo0Wk6naUJp8toahq1gpStBcF6lB6dEYz3Y/oQxywvZAahrWnIT?=
 =?us-ascii?Q?8ADuUvjUZIool7wIeYu0h6C+KQQj6LtctpZa5efB8PU280l+wCBNA8Nu5BQO?=
 =?us-ascii?Q?Bwv77DRp54na2Md9y86bD/dwjyGzi9T5X1EY4Hmrvlj+pbT8SuQGAq3YEIBh?=
 =?us-ascii?Q?XSeqTa5FPnvLHmXYHBStgDDgbH3BQGytP+uXHXOseTFDNvlUfpwxGqXUmMAO?=
 =?us-ascii?Q?L69WUudH5rNb6qkTfFAPMZqt6TDejY8Xnj6wF9Mv2pNsjI1XkfHOgEQto+VH?=
 =?us-ascii?Q?Sa8qvZtLvgKA1OztT9AK4WLflzTCFYMKMCojif0wY+mXgmKd+lNWxnxh2jti?=
 =?us-ascii?Q?gLDdBdvx2rf/1bl9ubaBwBt/rzPg8MeEu9LclvAwRULNqBUHOmA5DpGLNnQh?=
 =?us-ascii?Q?v/FlZv5N/y2pt9Ozqlbrrxt96gHrdU6dabLwuFqe4PQ/l7NmjuR9nTtfUby8?=
 =?us-ascii?Q?TTMdtoI9LRy3MgsuA3jM1CIqBvOWOjt1nvzyqOfGUwvS8NtZC+FDT3xF1Pdd?=
 =?us-ascii?Q?mbNkWFI4Opf9PBo7On5Z0o7symdAViswAUuRkLx9TJubucAIrIMej3GuiBDZ?=
 =?us-ascii?Q?Dmt4YqsNtyBWjMJbrgaP+Z10Y4Fznk2lED1DUrNOZ+fu1q5/7pnQFZPl2pDr?=
 =?us-ascii?Q?as6eKUpOnV8Qq8dfc2NWK+YmSgwI8r1nL4kT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:37:38.5536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfffa6fe-0315-4596-dcd7-08dda39f43a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
Remove some unused dpia debug bits.

[HOW]
Remove them from dpia_debug_options.

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4984700b5f1b..d0839a679901 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -821,10 +821,7 @@ union dpia_debug_options {
 		uint32_t disable_mst_dsc_work_around:1; /* bit 3 */
 		uint32_t enable_force_tbt3_work_around:1; /* bit 4 */
 		uint32_t disable_usb4_pm_support:1; /* bit 5 */
-		uint32_t enable_consolidated_dpia_dp_lt:1; /* bit 6 */
-		uint32_t enable_dpia_pre_training:1; /* bit 7 */
-		uint32_t unify_link_enc_assignment:1; /* bit 8 */
-		uint32_t reserved:24;
+		uint32_t reserved:26;
 	} bits;
 	uint32_t raw;
 };
-- 
2.43.0


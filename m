Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ABDCAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 21:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6A010E139;
	Wed,  1 Oct 2025 21:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="msZk3t4Y";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB70210E139
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 21:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWkiQmsB6RZegpOTBjaxqm+dSF5iC/e2cSKaXZg1gJ6Ngvistb0JG99igT/0tFOZLRAxNgs8TEacRsxFAV4VZfBVRsE4JDvHztmF3OvQVoP3MWy7HxG7tBSXsYQLRPKPttCUaiV+rXLppmI4nQ5y+lFP20Pjt9A4PI8Wlz7r6KgbWxg6rR3egZ/+h7qy4NAs8vWErNi6J2SFy2cIGLSIXUElqRQ6N672AyFW4axEP78mTYCV4rnJ7LysS0ysp3978ZBLBJSCK2UfbJKgfT5QsWLMovh29jEggzGQK1u2hzRQjuy+PqFgsuuBgaOHHMeaH+cMU+Q7PbkHE/mDGVezrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqRY1wpO9sA0xasjGmxcJya5k1vCySdx+wbhflrlckc=;
 b=fZydrQ54ZkTBAiswGBtiuGrHnTC2124lPGBnTSLgKuYCkJtuCMmUP7dS6zke9tbAEzQmSTObKEOt86EDGYd23H1k1gm1PvTY4guLqwFRHTElV/K94Iqhq0l5AzMvx6pdudGd75hyMV0fV1Gpw5yQv5ZDoZXbjjLQnKXwGnmp0dqPu6PSy2LiK1S6cDz7yKrCWU7hvXOM9WRAVR2Qn3RZa5M8Fn1NijB/x2ZfeJBmm8jqnpa/de3nN8V1wCdaF9sNxoqaRgXx7vZhJ1Rms8T0rbO3yS21bQNf2R1x6NMrhnaetgYfpsfzx6x2+qtCGD4CNWVTvlmj4C5RSfJQ9dKUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqRY1wpO9sA0xasjGmxcJya5k1vCySdx+wbhflrlckc=;
 b=msZk3t4YUEoFbwaEWj71RdokFPUKcweA+GHds5rn/YJasqncBNight8/1/7A9QOJmUsWJXiO8TrqaDHRK9Zgxk28FdIb1PY4UBpfNrlNn98MLQzx3aAeX5mLTPLk3eTgCFTY1IAaiR171cZtSjOBEfzfaEkjHa9NvLotgelpSKY=
Received: from SA9PR13CA0008.namprd13.prod.outlook.com (2603:10b6:806:21::13)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 21:27:37 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::62) by SA9PR13CA0008.outlook.office365.com
 (2603:10b6:806:21::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.13 via Frontend Transport; Wed,
 1 Oct 2025 21:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 21:27:36 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 14:27:34 -0700
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>
Subject: [PATCH 1/7] drm/amd/display: Remove inaccessible URL
Date: Wed, 1 Oct 2025 15:24:06 -0600
Message-ID: <20251001212700.1458245-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212700.1458245-1-alex.hung@amd.com>
References: <20251001212700.1458245-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: db7f1ef1-5d71-4e24-a98c-08de013157bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YBk0XGXxarJISt3kOCaog6F0jX6Myw/zBFIL54w3o+nNN37UuIO3gMgJVT4z?=
 =?us-ascii?Q?gYkuFRPhjXLjMwdBtij6bnB78zochB7gKwN5AALHS3KwPkRLC+OsJwf9ZapC?=
 =?us-ascii?Q?ot3TykKGmRrmTnltBfG5yXgJZMPJ4aWKa39mjczbp1kDikOXarhgsX8LArLB?=
 =?us-ascii?Q?N6x2oq1JeyhlGf62U+C3qhZdrz1LqWa9yl2FhGV5mlzfTj8l0l70kdV4dRuU?=
 =?us-ascii?Q?/pv7peXXmIZBGF4DzUoUgbzcJsnGOlmeENQxqaKh4Tw22Z3jCzqUgH3pEi0x?=
 =?us-ascii?Q?5ZA/I7FXqRseb3FcV1yAktVO7RlNoDuUC3JMhAdCT6TNi6DklvXHDppXMmcp?=
 =?us-ascii?Q?INMm56fQb3M015wNz9MFQDUsBiDuUjKQ+NlT7U+fvytdZv5LQOOJJI4Bn/97?=
 =?us-ascii?Q?ZHcrrjCLmDp1B9gz6HgRqwYD89scNVp496nwh1bvULDp/fDoBYn8j0C+LsK8?=
 =?us-ascii?Q?7j9uxSS0GzuANPnxixwK45/6dnS0x/Ef8eE4cbQb7kV4ojfeMHATr5/iwkP3?=
 =?us-ascii?Q?74XHkr9rfjCOSp94l/LI0pJjJzx4lXXJeifFSR0Ae8Un5ka0kmYv0yhI2XB4?=
 =?us-ascii?Q?FJD9PQ8pzflWw74bwqY/3s1ETapGf6KQ6OCn0GuO35gPK7CgGNVQqJUewtiZ?=
 =?us-ascii?Q?NsE89UchRWJF/GQVfB0bfF7lhOdhvtXDdp+w4og0K6gkfEzubuQRBwV0vzMl?=
 =?us-ascii?Q?7UI6dz/SYK59ttpTp1lgYATteu8zI4afKIksfa3keZRTxFz6T58Npgy8CyJU?=
 =?us-ascii?Q?OKBvImxeYQ/hgub4bDgbusUhGSM9yz78wOLa348F2kPqNpTsTNPNsf6W7Cdr?=
 =?us-ascii?Q?XFo+RV1+xfbnb2D+LugGDgyMfxVtxJlWSKxNcxtSjcNDdr6ygC/4Aa+TT1xC?=
 =?us-ascii?Q?2j5R/Oebrcj5pdGcey6lcOB7T71NtENvd+CZiYWtl3XNdWF2DJQuO4DRLWR/?=
 =?us-ascii?Q?WtSGQFo/SbtRnmmWsj3gjS4fuKSkvohyzTpJwC6Xxv5wq1c/fuoqv06Zygbi?=
 =?us-ascii?Q?U1KdsbTpE4vYrmnInA1iIR51pcOGSXeoaAayJS5Dulz1XCbYKwahwqvMUrsh?=
 =?us-ascii?Q?/RMbAVWlUIK8RRF7nFCbFvQ3tJ7VeMm3gJQjCxzwajinWE4EsS0m6YNkc77Q?=
 =?us-ascii?Q?juXtMlygAD1MTMtkwW+5L3lvhz+KNuXQYPzBbn+eVRqeUP6m4VM6kU0/luhe?=
 =?us-ascii?Q?IGyfBgL/2IIe5upfp83H2w13t9JGLgSOk0cU2tHUnunIwK7nT7Up3+PKGPkc?=
 =?us-ascii?Q?L/OOE61/LELNJ1v7BtKQFcB7JsQ81fIaVEAh5vHX2Tt6Qo5kz9vRCqhSK4Mi?=
 =?us-ascii?Q?nxI2cszqRQgtirbs214SyCkb9UqkOav7AT3JK34sUXpXnHktQV9Oem/Gv0en?=
 =?us-ascii?Q?71uXXoY5TGub41J4Jp/yIfENbIN/IXXGcY4A+wnNd+GfGCClXzkaL4S0aE8U?=
 =?us-ascii?Q?eQ9YqSWh0deK100Rf8jAQPVC6m3XuFvDayHi5KlIiVMmUrLSrERh6AG06pp8?=
 =?us-ascii?Q?WlpAf6XlOHaUObwGoVKZs8nauCd/NZVATe+j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 21:27:36.9733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7f1ef1-5d71-4e24-a98c-08de013157bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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

From: Clay King <clayking@amd.com>

[WHAT]
Remove inaccessible link.

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
index e2740482e1cf..08ea0a1b9e7f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
@@ -73,8 +73,6 @@
  * On any mode switch, if the new reg values are smaller than the current values,
  * then update the regs with the new values.
  *
- * Link to the ticket: http://ontrack-internal.amd.com/browse/DEDCN21-142
- *
  */
 void apply_DEDCN21_142_wa_for_hostvm_deadline(
 		struct hubp *hubp,
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EA8C021A6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53EDA10ECC3;
	Fri, 14 Feb 2025 15:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nKqtCp9S";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFCA10ECBB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbExaQHW5Q9KINExlIB9jpgYs0bUkPGhCZIVxdwChDcizI4sI0VDLVSJphr1sP3bpPZxiujG2oKjQ60mC9K6kahJkqmtfI3/974KYx9ubXF03z6j0IJyFcMOE3Ubu64tJNwmknz7YwO5NkS2+y8ckriXk1d/4RdRFAZZJQTnBAUVOUOHS5cfZ7+aCRUyYeQRZyipub4OA//Yc5+2IbXv1xYOQcqQOgqsxxjOhia0cNv7QANlGpxJE0X+m9KLd8krcxkg9Tfewb4QV6tIEhli8AsRBIg3GvxTeNfXK/5MHdnadTTKqm+5hI2XAF7S29SIiJoIgCf2PcH+KNsXnaGBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9vPbQ/nuA/jvAMS5f5gF8EEstkpii9MKF6RG4+tyvA=;
 b=JfEM9YrFgd8wEOWEK0JqOSIP13T+zxyHfqlKDieqfqjhD3CMcIkxYUlUIY82Fz7c8AWtVAJvAgldAWN3mRzBFuXNAqQd7tGB1aEaVIvtb8bRARytjAiRdd9X2Hsol/o1I1m+4PYx1a7NWHmmRSNP/7fWvsz+XzOn6K2/9GYY5WrzKnu7WRAR+m4nxhCUBNXxGbBjJC7O3ajiDZF2UrsVf/MmxrM75N2YoiPlN1LrKSn+MbycQ97vb08X04L8QPass0R/r4ZF8JFjeQZKbzmJJwzYrfRVp0KpFMzk+NrA2FPboQK7YiULJ4wKGi/BJlm3TT8PslAQmKau74myLXnOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9vPbQ/nuA/jvAMS5f5gF8EEstkpii9MKF6RG4+tyvA=;
 b=nKqtCp9SBeXG4waLYxc3rIEjok3hCh5MikNN0s4FTKy+zoRoumUKXw8mbGW8g5rJ9gCXME+9Fmdm4VT50XNMazK42tFvs4nWa/8GQmKVsYV/lMdPekA4Aze6IkoBL23cI2l4MMrvyz+Lpy707I7jTl1pHd3J59zF/HUjjx0HQbQ=
Received: from CH2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:610:53::32)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Fri, 14 Feb
 2025 15:01:40 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::d2) by CH2PR17CA0022.outlook.office365.com
 (2603:10b6:610:53::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:38 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:38 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:38 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 11/16] drm/amd/display: Add log for MALL entry on DCN32x
Date: Fri, 14 Feb 2025 10:00:28 -0500
Message-ID: <20250214150033.767978-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 07dd1daf-98b5-4245-6b91-08dd4d087cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eguilkQjgq+wEkZSFTSvqK7SkUb1oGCcm5AhmnEIkBg1luKRI+7A04+cDCs6?=
 =?us-ascii?Q?/RhDAjT7DEzYI52mQ2rHMGsY42TbbuG2AD/rtQCxV6jbk/RHewrbVWg0WWu3?=
 =?us-ascii?Q?J368/94JfXkPdB7r9geYIeiRTTeHyywiyJY0vvtvTxNHrrBN0FkF31PQtqDv?=
 =?us-ascii?Q?E19P3PrRd5baIgaB+xDIPbi09e9pjRreu6GLigArLPx4If5I7nkaA6vihZOR?=
 =?us-ascii?Q?BMTLB1CE96NmTuuChMWvpT/72c4GhX6r0p7JzdqjrKkgN3+Am7fHfSvaJ4aV?=
 =?us-ascii?Q?KMMF0NS8VTh4q5VUrlK9bkx5gZc633qW+YjsFS6IkMQQ3Ilz370a3gOqJ2oa?=
 =?us-ascii?Q?NgZj3iVxEgn2bej9I7OuN13mEvj11gFOphZR+9al8BT0bhZCiFzlJZQwSySl?=
 =?us-ascii?Q?PqI/O209ZKqOUIl4iPiueXnWyHsfhSP2UJ3sG+uJhpfsri1G1UQBSAOswM4S?=
 =?us-ascii?Q?4HhEF1vHfSTT1pYWSG8i2LK0GACuwiXZA7qpgz0VOgalO5QZvQgFdhTYXCN1?=
 =?us-ascii?Q?X9ca4S4OwPlF4HImF0YxDPhXg/z0tufQvyPQxCzORY9yF8LeliSr2Q+Re0Q7?=
 =?us-ascii?Q?/WZ+6HcrCd++XwikP8yKigIq5WrJq+q7jxngZM4xi4HdpkIrY1En3VZYtqWN?=
 =?us-ascii?Q?+xGABNHpZB7x/nzyHz8X037vehlqYNEotSO7dQz0AJAAKlHrO1aeo22rGwib?=
 =?us-ascii?Q?LdYKizqdz6gL3B6gU160LCXT6KxTk8y+jVdT9YGRjZRnExtZyahMbvGoO5Ab?=
 =?us-ascii?Q?XZT5+Qx8IBHnSN2452CSjKQDiypppr11eiLGNi6VFGoEwbln7pkHpl0R1GTY?=
 =?us-ascii?Q?rTYKQL5IM3oZreH80eY4zf+YMUKruz5y+29m1JUZh0pXpay6pJ4YeXmeq37u?=
 =?us-ascii?Q?QOjPWRpHYGs6XUA3PlCKc2OSGYsf2jhmKz1Btz8ecytRecqHN6nqi6pcmN3p?=
 =?us-ascii?Q?EzFfKmLPxRmjJW4K8snZuN50cmotE5BufnzdmdT+nBosDnnSfnta/XbvGtcV?=
 =?us-ascii?Q?GWjzC/y8PhSKqmxQJ0OR+8BYeKwMLjbFADARn6YA07Vuoxa8U2U2rKOAe/gg?=
 =?us-ascii?Q?tsDN1GR7ehCRpoP48qIx/xFZ8+HCYGEcy2vjqmSCzl42WXCnzYRdHm6ZmvhP?=
 =?us-ascii?Q?VxF08OFVO8m1wKcwCXXvHF95jYdW93KmN+WIPQcVXAFS+evwF3d8dpJ8mMOc?=
 =?us-ascii?Q?CQG6zpwt7itUaIA/APRUwed4DP7GrYfPfMDohe8ZV1TzD7Fs71uk/Sz3W6R8?=
 =?us-ascii?Q?tAhMDH5mWCgGGR7OCQzcsuVuuSS9qDR/D7n0Y7TsmrlF/7NTXTWJEV62/zO3?=
 =?us-ascii?Q?EU5WL1wegYn72YBo47QWChpiPnG7aXgQVRhreO0vVtMflcXN7G4ZBS63D3sp?=
 =?us-ascii?Q?7RcfpumskJiDvXE7uYT0tm1te/N+B7BUKKaAJ/8el6SNLIn9gOYQxkOGjhoM?=
 =?us-ascii?Q?NCOxoEaUFxUApL2Q7IPz9mzZD4CCV2RxPVwPF6dSl0re5+THBCsk9C/5IA37?=
 =?us-ascii?Q?N8DrIdYlAm3Dn7I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:40.1541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dd1daf-98b5-4245-6b91-08dd4d087cb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Add a dyndbg log entry to check whether the driver requested scanout
from MALL cache to PMFW via DMCUB

Reviewed-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index dd46db67d033..cd0adf72b223 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -316,10 +316,12 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			cmd.cab.cab_alloc_ways = (uint8_t)ways;
 
 			dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
+			DC_LOG_MALL("enable scanout from MALL");
 
 			return true;
 		}
 
+		DC_LOG_MALL("surface cannot fit in CAB, disabling scanout from MALL\n");
 		return false;
 	}
 
-- 
2.34.1


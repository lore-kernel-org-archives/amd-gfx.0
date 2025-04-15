Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F470C369BE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0328010E7BE;
	Tue, 15 Apr 2025 14:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VqYSZaEh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9317510E118
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDeiCqvTorC+B51WXACEePUtlEgtEQmettjj9fLQ1SfKNDf255BhIrEt5cs5v76eVGVY3PZX1BDsZslJzd5V1cll/oay7gd3FMlBk6wp8XuPqERNEcja/QWkLzZo+UsiJpI2HJRuYtfyChwMMNrReVRIn75CptwXuxX4YyM33xfImikH9N2+l8zkd4jTZfTlGPFi22EJHtRrc4zaFN+zXZ9jay6wsIImlQfP0/FMEuttXmBc9SMJnBIHRKxT+UZWQP3V1RcRnf86LkIfnbyhrXvSyIKCIMcg8mux/RHbhXQw5cR0H25ncOPH5N8BjpuoBYowGFQkMpthR6sul7JmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOOHZ7YCqPjPFdVx6pg2fQ0ndMjxqhZnf9+iq0gWx8U=;
 b=LbBTPxDpVilObgzL7y1u+dGeh+joZFpzxss8e8fUJM18yzLJhgPdqV3oGxBV92Zl7Mm+b/LpvxmnEBuDSO1cXpb1ubyjPL5Z/GrSRpbemSfzFJuClOZM43Th6vei7JZM1+zk9LFijcB+4R6zlwWZ9BR5uRIgPVRkdIIsWHO15/tHYTedKtKDDnyDcDP+ZMrcCisMbbPt0PYngAYx8ZuFM9zoIsWPmrdsKdvlAWwu8uZ5pqPXGrpchCsDOg3VCHKXEsUM7uC053B7/EIrBh/aBEP5YVIzei2IRe6MKB+X16dF2pHnTh44XyGqKsLebHIrBoY7dX1IRH/QIW0WEHPRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOOHZ7YCqPjPFdVx6pg2fQ0ndMjxqhZnf9+iq0gWx8U=;
 b=VqYSZaEhid58H7AXsf7NtDRTbovsuDn3KlhH8OvvBBEDh7Ptm3noLOX1Y4E05d9AXLnHA0zJlOPmT1j9v3BLsNuEQUOMPwB5XCOyKAY7AIXH+mipsq9umQKJjcuyAD7i6Cw0X57w4grGCn83y0m4JyHZVpQugBgyK/JNNpVqPRA=
Received: from DS7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:3b8::21)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 14:59:37 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a2) by DS7PR03CA0016.outlook.office365.com
 (2603:10b6:5:3b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 14:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:36 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:34 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Jack Chang
 <jack.chang@amd.com>, Robin Chen <robin.chen@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 04/22] drm/amd/display: Move desync error counter operation up.
Date: Tue, 15 Apr 2025 10:58:50 -0400
Message-ID: <20250415145908.3790253-5-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: aa721715-84bc-4501-1f75-08dd7c2e23e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TrZ3fLhPwaxEOjHHX0Pc1T25Osiz0TdjdoXdEztiR8ZrNGOREXmwsIcVxTd5?=
 =?us-ascii?Q?cZsa78PYO41xC8XbVI08Ge0GBcERWqu5ReSZGlO/hSghl82ck3Xt/Z7BkEU5?=
 =?us-ascii?Q?ZTY638AUqcj6s0r0GKgJ8uCrDfFWhF3iVLyyH8/8lEpqM1ef/CoP40E+3dz5?=
 =?us-ascii?Q?VJyVwcV0ri2IuWPGKpWSyVa6tuMfctGnI4LVaMhUDRrjHacb4POujW927Zqx?=
 =?us-ascii?Q?PNNdMY68KMJNJ6QkOaUHuxQLg1HDl0EvEniixuf+0MBPWGTTBwyLPv7BZrdO?=
 =?us-ascii?Q?mC4b3cEOHUsN8M3KUQ/GyLXNNhBnE6qsL6UQXGrzDtaKC6jAecfl24FgHUfY?=
 =?us-ascii?Q?IKknizhhzncWYU8QXqJoB4JXmvlB3e37i4J0ZWKJ6EobLmdDdRfIzIu6AFhm?=
 =?us-ascii?Q?IQ3UC29UYz4S5OkBbPnWtnHzG3ozIVwizLMNiLJSudaWX1naY/4BGLl3QRcr?=
 =?us-ascii?Q?vDBVOHyL8c5J7ur3eo36srqoU9tFqOVuX4dygg4RfpFnvEdCGU4cj7+FCjDD?=
 =?us-ascii?Q?dsyLkQ9vQ9ht0WwSO5EkE8RC8RLwW3qbTAdbQFE6GZl8q4570tXMqZG4hd2M?=
 =?us-ascii?Q?xCrxVSYELpkC1Cbfh3qTQV/ohqRV4/HzHNvpf9FTJhPG2ba4ZJY1qyqotBDx?=
 =?us-ascii?Q?deo8bHoKGNOjDkXEusfHoLLnxjBq0kOH/uwB9ri/+h4dQ0SwADqfgj6ngsSA?=
 =?us-ascii?Q?x9aGJxe1aOvhztZi+Hen8/HNEZk7NrvqMfYFjJ4QOd6zqkIuhW0OP0UoKO8q?=
 =?us-ascii?Q?QYXSl1wOVlwj0etKqMgzpM7o0AvqvnQEziVhZDWWz6CBDrOWYd14ZIg4Ik7w?=
 =?us-ascii?Q?T/s1IYtfrpW1IsQcHepw+gUQrr//5Kwf43xC1rRL+9YAx3wAgiWXuZaaNY5+?=
 =?us-ascii?Q?5K3fda3bsfscLp8gNMVnEwujs9X7GXgYeIsjpTlbjaL6pqdOORNIg6P9ZCqU?=
 =?us-ascii?Q?gHKnQZbx3fLlvhJg+obACyrrNCi9/9dGjv8PmPGDCuDSXRhWPMA+21dx0O+F?=
 =?us-ascii?Q?Yo8ohWmPWyrdiTplxteUFhp/WxtJYACfEVdE6aHwMsTBogjNn8nj9vEhdqeU?=
 =?us-ascii?Q?zeIyfc6mVFs0zJvsI9kcjthwk8xUq6wu7XS+DhdD9P9h3zIVz5g4qO486Ske?=
 =?us-ascii?Q?J80AsEb2RKzQvrw39OpIm74o1Bua8gGgeAVZib9QMDk2zHcr8efMlyExme74?=
 =?us-ascii?Q?Z5kD2KN5UHt1YAZD3oc1L+cEKIsxi0WfbLqhB+KEDNwKqfPGoPHiuCD/6gAi?=
 =?us-ascii?Q?/cdd1shwEH6u4liTqXuW9LokVkqm7u1qeaelhm98usBmCJ5nJTEikyNfJ0w9?=
 =?us-ascii?Q?o1rAormotGMxDC1goEfwgSN8aiHMH4CFi9TMPtv9WcEY1ek6UKleNpllMr7b?=
 =?us-ascii?Q?t6Lln0M9QP+AiimZnTDy6yIsvXMuxHcMW/yR3Y6WqONQ2GJQpI7DyeLIy3CD?=
 =?us-ascii?Q?4bjdRlA/9E6XubDuqFG/smhTI1+GKQ56mbM9Plonzm4T6rjNESd2wSeijiLS?=
 =?us-ascii?Q?5atEOA0GXOxxuZHbsa+cB6N+vBmgYS4Di+xK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:36.8124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa721715-84bc-4501-1f75-08dd7c2e23e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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

From: Jack Chang <jack.chang@amd.com>

[Why & How]
Move desync error counter operation up to prevent
it from being skipped by force disable desync
error.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_irq_handler.c    | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 5be00e4ce10b..991b8ad4984b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -229,6 +229,10 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 
 		link->replay_settings.config.replay_error_status.raw |= replay_error_status.raw;
 
+		/* Increment desync error counter if a desync error is detected */
+		if (replay_configuration.bits.DESYNC_ERROR_STATUS)
+			link->replay_settings.replay_desync_error_fail_count++;
+
 		if (link->replay_settings.config.force_disable_desync_error_check)
 			return;
 
@@ -240,9 +244,6 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 			&replay_configuration.raw,
 			sizeof(replay_configuration.raw));
 
-		/* Update desync error counter */
-		link->replay_settings.replay_desync_error_fail_count++;
-
 		/* Acknowledge and clear error bits */
 		dm_helpers_dp_write_dpcd(
 			link->ctx,
-- 
2.34.1


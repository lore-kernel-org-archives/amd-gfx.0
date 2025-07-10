Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB210C83F22
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5754010E96F;
	Thu, 10 Jul 2025 21:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oVsC6vQL";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D6BA10E96E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkkK9TZ+2mEU+/twzMRU5BPytlfBztvlfUhYMYl/twLUwXc2XtZxksZ2FAJuAkw+UHICNK2dwqxdne3Uh0jVYKkjLiW4hTKQa0RECTvRGbWchyIIubR4ZIcLiYSw+O+2NOBu2MdPdeX9u8YbCVy5Z+r0AQTv0uU7Lw1VZ6tFT2SjBlfTarTNqmZxwcAPThlMSi+QynPtSRC0zqhgBJ/R3L0ggdmnT4SHWJSt4xFt9yfTETevXAF19Sm6gbqnYiy4/1B5TeN859UsUanV5vc1tCn480ET6wIdUfWNxThPEuedp1NHxYQvRGyVbx4Z/K03OWRjSCJfmVhP0BrHaHYn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6PMDXLULyittx9wjR4CTI+zXrS8pVehZ8KEugimCbA=;
 b=XK1QDxBy+pG92DU6H08NpQ1PAXNP9nh0qTt4w1f86Zfa5JQRnYBb4dSIHUOYQcnq3CTC/oC0z8ZkE+2bDrhXDRRzISg08zZCFo7Q3oV3wfoHalfYOf8+3npp1Jrn2awfa2dv/y7SYhfp8Pzs+gTsm6mibCaYc4jHqt39SAe05O85D0qKbJ6WoQTHO/s+Dpvxfk/ljiWKc2b58GkW2I6YA0mEoNoCqw78TLhCven6IR3lQOayUJbfo/MbtGUxnCpgl47RWydvHniVlURWi+aaimjgRC0n4NDKExbNX4FeJ6XzRNcoOGXPal614D81YKrI2NvBI0Hxs9+HdVG+DH+GIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6PMDXLULyittx9wjR4CTI+zXrS8pVehZ8KEugimCbA=;
 b=oVsC6vQLh0nP4BGcp6gyyGdA53Ai0XVYdQjHkbiuyI3x9+p1A4duDcV0Jev6icvvxH8wigmJ/rwUVUouzgZ1E76isjsBRadNV34wu1iZYW8QIyaDTHYtH+oT+EhoGG1O8XZwROOQi2l+iI9dKLrNU9rGhyEOHQ2/LUUUfHv+Hl0=
Received: from CH2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:59::23)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 21:31:19 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::f0) by CH2PR03CA0013.outlook.office365.com
 (2603:10b6:610:59::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 21:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:31:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:07 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:31:07 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ovidiu Bunea
 <Ovidiu.Bunea@amd.com>, Charlene Liu <charlene.liu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 13/18] drm/amd/display: Add support for Panel Replay on DP1
 eDP (panel_inst=1)
Date: Thu, 10 Jul 2025 17:25:46 -0400
Message-ID: <20250710212941.630259-14-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9ef7a6-81e7-48a2-7115-08ddbff91bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jIfXBDlv9uJQZ3w6LOJqIKjHnWeeNfJx/tPHAlswH1oioEnT4Au5+TZ3Qeys?=
 =?us-ascii?Q?VZXxmxtYI0I1t0q63neFGEO2y3/Q2qRClx4wQQLdDdBLMRQu213xgsI4QOiR?=
 =?us-ascii?Q?QayC2UUP1xJYULMy07VXnr+wYQVbA8iSGU+yDGYLiUlLDcVBMR3xudcM0EPM?=
 =?us-ascii?Q?IhncY1TrzzEZy3lSJB+aBablCbY9QXpH8zwSc0x43FvQkLy3JvJnCxsy1A/3?=
 =?us-ascii?Q?FRmWk84LxkilvoBiD4xoj/KrLUdsV/JIm3648kSKw41k5Tj/I6cUMigqapNh?=
 =?us-ascii?Q?oJMTS5MQPey8yVFP6fwgUDbv000X1tMK5vkahn8OJrCBJSvmq8x7K1iwGbzR?=
 =?us-ascii?Q?KQ9YrwOm73HSD/Y1uT8hPLkPftMK4uKVThSC1amhKiCPn5J5OwIB+94u9KIm?=
 =?us-ascii?Q?I1PeYK7x3QnN42zGi9vLe/kqKvkJQavO1KCgvnSU2XbEy2dIcFBWI7ovoT5s?=
 =?us-ascii?Q?HxqMuDk+l+l+09KC6FMX9je0V1T8arrhwICa5PciroJez3u654c/OPse6i+n?=
 =?us-ascii?Q?eurSU36aX9o0n+88FhN9vdLEYkIhEmX+K+O0A4Br0iQC8OWYidNOAiqC3Gvb?=
 =?us-ascii?Q?VLznjlRZUAwSk2bBXRyHRAuV8S0Avh98T/kdZeNDoJurLwqlCay2uCADG4Ra?=
 =?us-ascii?Q?CA3jMiUuG18J9UoeA+krZrnWwLcc8zDJxGbEHdzJhvBBc6QWOHNyVL8ySm+6?=
 =?us-ascii?Q?DduWAek+Sb5Im2SEUE3AV3sBN+uMQQBTvkd0ZAuKL1oAu58GYmCEwTmckiYK?=
 =?us-ascii?Q?ElcCkUQEgcidcBAEc8pZ4B/u3KpHG7EoB1ylGpuf0P40qIMY58DEhnhQsg7v?=
 =?us-ascii?Q?DNc+jxn5shxs4A335JIiu9hdWnbGweeOj4V17vO+p3gNAlmMRZ9rHfnXYbcP?=
 =?us-ascii?Q?ZTwSfksP0NLxA7Xm0LaUPVD2ZFiLfRVMbU54Rd+9wKQpRuozYtZKiyrzW2Xy?=
 =?us-ascii?Q?R1S/wkGx2IzFxS9LlN7FR2Y6uNMPjk8qMM9ekh4vJ10BOsG8NBhnuogM9eJU?=
 =?us-ascii?Q?ygWCDdMyQdFW/a2lKI2tidf7d+RBt/NyXGDUMWe5pZZZPzlqRbXfZGPUbE6C?=
 =?us-ascii?Q?02YlvZ3TKtT71RVVe/0NJrTcOyXVcz9dCZjD/vOHWNhbHq7iKX6BSWdRdBLp?=
 =?us-ascii?Q?W6zN9OcUxt6+ptyw5gUXUj4NT3if/JZWWWQdvGxjQX3cpnN6IRaZ+zEn6ZL1?=
 =?us-ascii?Q?1mwHl3T9PC+gR3sSZ/LiD9oJ7RGBx4neekimwQAmg6GpjGkKy6QedT3NGigG?=
 =?us-ascii?Q?q1cDs+lRrq399obpxfoWZWrLIJDChYGZo0XKXiENU400d8bBS9qtx3SjqKMh?=
 =?us-ascii?Q?bwAtvJVDDHvE+PqT8PAO3oTUMC1f/4nAn0vVBmMrhBhugFP7+aopkxr6tmwY?=
 =?us-ascii?Q?Zd1hdzBbc/u/XwEBFmPx2w+voaywxQQyzxF+9JUcK8e5gQLwshRhh7omOEZ/?=
 =?us-ascii?Q?ET2J2102ZoHHIqnn+vEo0P7rgSSG+KjlO2acRoEckiKxTD/mRBxcwDNeWU0d?=
 =?us-ascii?Q?pPSynydrG5w4kpcGqlIVHiBn8zIGOLjHZ4I/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:31:19.2765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9ef7a6-81e7-48a2-7115-08ddbff91bf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

[why & how]
DP1 eDP is still considered a single-eDP case and should support Panel Replay.
Modify secondary eDP policy to reflect this and update Replay state accordingly.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index fcd3d86ad517..5d77d0912ee9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -211,6 +211,7 @@ static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
 	pCmd->header.type = DMUB_CMD__REPLAY;
 	pCmd->header.sub_type = DMUB_CMD__REPLAY_SET_COASTING_VTOTAL;
 	pCmd->header.payload_bytes = sizeof(struct dmub_cmd_replay_set_coasting_vtotal_data);
+	pCmd->replay_set_coasting_vtotal_data.panel_inst = panel_inst;
 	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal = (coasting_vtotal & 0xFFFF);
 	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal_high = (coasting_vtotal & 0xFFFF0000) >> 16;
 
-- 
2.43.0

